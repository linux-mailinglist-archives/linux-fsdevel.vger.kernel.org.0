Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEEC1FD54
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 03:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfEPBq1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 21:46:27 -0400
Received: from fieldses.org ([173.255.197.46]:33116 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727010AbfEPBWY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 21:22:24 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id 8179F20AE; Wed, 15 May 2019 21:20:23 -0400 (EDT)
From:   "J. Bruce Fields" <bfields@redhat.com>
To:     linux-nfs@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org,
        "J. Bruce Fields" <bfields@redhat.com>
Subject: [PATCH 08/12] nfsd: add more information to client info file
Date:   Wed, 15 May 2019 21:20:15 -0400
Message-Id: <1557969619-17157-11-git-send-email-bfields@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1557969619-17157-1-git-send-email-bfields@redhat.com>
References: <1557969619-17157-1-git-send-email-bfields@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "J. Bruce Fields" <bfields@redhat.com>

Add ip address, full client-provided identifier, and minor version.
There's much more that could possibly be useful but this is a start.

As with open owners, client identifiers are opaque binary data, but some
clients happen to include useful information in ascii.

Signed-off-by: J. Bruce Fields <bfields@redhat.com>
---
 fs/nfsd/nfs4state.c      | 18 ++++++++++++++++++
 fs/seq_file.c            | 17 +++++++++++++++++
 include/linux/seq_file.h |  2 ++
 3 files changed, 37 insertions(+)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index c665ce9af773..876c035d2a91 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -42,6 +42,7 @@
 #include <linux/sunrpc/svcauth_gss.h>
 #include <linux/sunrpc/addr.h>
 #include <linux/jhash.h>
+#include <linux/string_helpers.h>
 #include "xdr4.h"
 #include "xdr4cb.h"
 #include "vfs.h"
@@ -2193,6 +2194,19 @@ find_stateid_by_type(struct nfs4_client *cl, stateid_t *t, char typemask)
 	return s;
 }
 
+static void seq_escape_quotable_mem(struct seq_file *m, char *data, int len)
+{
+	/* List taken from kstrdup_quotable: */
+	seq_escape_mem(m, data, len, ESCAPE_HEX, "\f\n\r\t\v\a\e\\\"");
+}
+
+static void seq_quote_mem(struct seq_file *m, char *data, int len)
+{
+	seq_printf(m, "\"");
+	seq_escape_quotable_mem(m, data, len);
+	seq_printf(m, "\"");
+}
+
 static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
@@ -2206,6 +2220,10 @@ static int client_info_show(struct seq_file *m, void *v)
 	clp = container_of(nc, struct nfs4_client, cl_nfsdfs);
 	memcpy(&clid, &clp->cl_clientid, sizeof(clid));
 	seq_printf(m, "clientid: %llx\n", clid);
+	seq_printf(m, "address: %pISpc\n", (struct sockaddr *)&clp->cl_addr);
+	seq_printf(m, "name: ");
+	seq_quote_mem(m, clp->cl_name.data, clp->cl_name.len);
+	seq_printf(m, "\nminor version: %d\n", clp->cl_minorversion);
 	drop_client(clp);
 
 	return 0;
diff --git a/fs/seq_file.c b/fs/seq_file.c
index 1dea7a8a5255..bb646e0c5b9c 100644
--- a/fs/seq_file.c
+++ b/fs/seq_file.c
@@ -383,6 +383,23 @@ void seq_escape(struct seq_file *m, const char *s, const char *esc)
 }
 EXPORT_SYMBOL(seq_escape);
 
+/**
+ * seq_escape_mem - copy data to buffer, escaping some characters
+ *
+ * See string_escape_mem for explanations of the arguments.
+ */
+void seq_escape_mem(struct seq_file *m, const char *src, size_t isz,
+		    unsigned int flags, const char *only)
+{
+	char *buf;
+	size_t size = seq_get_buf(m, &buf);
+	int ret;
+
+	ret = string_escape_mem(src, isz, buf, size, flags, only);
+	seq_commit(m, ret < size ? ret : -1);
+}
+EXPORT_SYMBOL(seq_escape_mem);
+
 void seq_vprintf(struct seq_file *m, const char *f, va_list args)
 {
 	int len;
diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
index a121982af0f5..de6ace9e5e6b 100644
--- a/include/linux/seq_file.h
+++ b/include/linux/seq_file.h
@@ -127,6 +127,8 @@ void seq_put_hex_ll(struct seq_file *m, const char *delimiter,
 		    unsigned long long v, unsigned int width);
 
 void seq_escape(struct seq_file *m, const char *s, const char *esc);
+void seq_escape_mem(struct seq_file *m, const char *src, size_t isz,
+		    unsigned int flags, const char *only);
 
 void seq_hex_dump(struct seq_file *m, const char *prefix_str, int prefix_type,
 		  int rowsize, int groupsize, const void *buf, size_t len,
-- 
2.21.0


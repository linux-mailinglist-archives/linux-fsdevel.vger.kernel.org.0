Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8071D2CA0E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 May 2019 17:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727955AbfE1POH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 May 2019 11:14:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35143 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727921AbfE1POG (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 May 2019 11:14:06 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7F468301988B;
        Tue, 28 May 2019 15:14:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-125-65.rdu2.redhat.com [10.10.125.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29E44C087F;
        Tue, 28 May 2019 15:14:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
 Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
 Kingdom.
 Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/25] fsinfo: pstore - add sb operation fsinfo() [ver #13]
From:   David Howells <dhowells@redhat.com>
To:     viro@zeniv.linux.org.uk
Cc:     dhowells@redhat.com, raven@themaw.net, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        mszeredi@redhat.com
Date:   Tue, 28 May 2019 16:14:04 +0100
Message-ID: <155905644440.1662.3745883327641806605.stgit@warthog.procyon.org.uk>
In-Reply-To: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
References: <155905626142.1662.18430571708534506785.stgit@warthog.procyon.org.uk>
User-Agent: StGit/unknown-version
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Tue, 28 May 2019 15:14:06 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ian Kent <raven@themaw.net>

The new fsinfo() system call adds a new super block operation
->fsinfo() which is used by file systems to provide file
system specific information for fsinfo() requests.

The fsinfo() request FSINFO_ATTR_PARAMETERS provides the same
function as sb operation ->show_options() so it needs to be
implemented by any file system that provides ->show_options()
as a minimum.

Signed-off-by: Ian Kent <raven@themaw.net>
Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/pstore/inode.c |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/fs/pstore/inode.c b/fs/pstore/inode.c
index 4640debf8755..44f4ffc4436e 100644
--- a/fs/pstore/inode.c
+++ b/fs/pstore/inode.c
@@ -36,6 +36,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/uaccess.h>
+#include <linux/fsinfo.h>
 
 #include "internal.h"
 
@@ -281,6 +282,33 @@ static int pstore_show_options(struct seq_file *m, struct dentry *root)
 	return 0;
 }
 
+#ifdef CONFIG_FSINFO
+/*
+ * Get filesystem information.
+ */
+static int pstore_fsinfo(struct path *path, struct fsinfo_kparams *params)
+{
+	struct fsinfo_capabilities *caps;
+
+	switch (params->request) {
+	case FSINFO_ATTR_CAPABILITIES:
+		caps = params->buffer;
+		fsinfo_set_cap(caps, FSINFO_CAP_IS_FLASH_FS);
+		fsinfo_set_cap(caps, FSINFO_CAP_HAS_CTIME);
+		fsinfo_set_cap(caps, FSINFO_CAP_HAS_MTIME);
+		return sizeof(*caps);
+
+	case FSINFO_ATTR_PARAMETERS:
+		if (kmsg_bytes != PSTORE_DEFAULT_KMSG_BYTES)
+			fsinfo_note_paramf(params, "kmsg_bytes", "%lu", kmsg_bytes);
+		return params->usage;
+
+	default:
+		return generic_fsinfo(path, params);
+	}
+}
+#endif /* CONFIG_FSINFO */
+
 static int pstore_reconfigure(struct fs_context *fc)
 {
 	sync_filesystem(fc->root->d_sb);
@@ -293,6 +321,9 @@ static const struct super_operations pstore_ops = {
 	.drop_inode	= generic_delete_inode,
 	.evict_inode	= pstore_evict_inode,
 	.show_options	= pstore_show_options,
+#ifdef CONFIG_FSINFO
+	.fsinfo		= pstore_fsinfo,
+#endif
 };
 
 static struct super_block *pstore_sb;


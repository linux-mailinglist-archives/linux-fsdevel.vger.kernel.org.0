Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A4FF206758
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 00:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387960AbgFWWoO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 18:44:14 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:54771 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387666AbgFWWoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:44:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952251; x=1624488251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=NLVN9Q2A0b00snDAE9ThJnTCcOLANkKYH+fT6qiOcKU=;
  b=p8xjcrzy8LkPN+nQ8P/ahevjbNUKWE43EOInXOspx+gl8WVfUNciGNQj
   g6gAJJMCx+E2OzK/JA6MvfvcfLcLqfBSm6gOIhu7g/sdh0E1IC3WN/FOo
   mIz59W/eSiUUX4gxD7kjMnuVKhFzn7CpqAXev6X0k8fJD44vC49QD+uLy
   M=;
IronPort-SDR: REZWfGI3okiv3ZfNXBVjstILgGPtDTxHBi/xMy9BcJ8sRDsI/zrbyEwL5cJwDjL9lNjNvF47r1
 k6c70RRnJd5Q==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="37982007"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-119b4f96.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 23 Jun 2020 22:39:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-119b4f96.us-west-2.amazon.com (Postfix) with ESMTPS id 403441A0D62;
        Tue, 23 Jun 2020 22:39:37 +0000 (UTC)
Received: from EX13D13UWB002.ant.amazon.com (10.43.161.21) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D13UWB002.ant.amazon.com (10.43.161.21) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 096C1CD35B; Tue, 23 Jun 2020 22:39:28 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 02/10] xattr: add a function to check if a namespace is supported
Date:   Tue, 23 Jun 2020 22:39:19 +0000
Message-ID: <20200623223927.31795-3-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function that checks is an extended attribute namespace is
supported for an inode, meaning that a handler must be present
for either the whole namespace, or at least one synthetic
xattr in the namespace.

To be used by the nfs server code when being queried for extended
attributes support.

Cc: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/xattr.c            | 27 +++++++++++++++++++++++++++
 include/linux/xattr.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 95f38f57347f..386b45676d7e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -134,6 +134,33 @@ xattr_permission(struct inode *inode, const char *name, int mask)
 	return inode_permission(inode, mask);
 }
 
+/*
+ * Look for any handler that deals with the specified namespace.
+ */
+int
+xattr_supported_namespace(struct inode *inode, const char *prefix)
+{
+	const struct xattr_handler **handlers = inode->i_sb->s_xattr;
+	const struct xattr_handler *handler;
+	size_t preflen;
+
+	if (!(inode->i_opflags & IOP_XATTR)) {
+		if (unlikely(is_bad_inode(inode)))
+			return -EIO;
+		return -EOPNOTSUPP;
+	}
+
+	preflen = strlen(prefix);
+
+	for_each_xattr_handler(handlers, handler) {
+		if (!strncmp(xattr_prefix(handler), prefix, preflen))
+			return 0;
+	}
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL(xattr_supported_namespace);
+
 int
 __vfs_setxattr(struct dentry *dentry, struct inode *inode, const char *name,
 	       const void *value, size_t size, int flags)
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index a2f3cd02653c..fac75810d9d3 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -61,6 +61,8 @@ ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_siz
 ssize_t vfs_getxattr_alloc(struct dentry *dentry, const char *name,
 			   char **xattr_value, size_t size, gfp_t flags);
 
+int xattr_supported_namespace(struct inode *inode, const char *prefix);
+
 static inline const char *xattr_prefix(const struct xattr_handler *handler)
 {
 	return handler->prefix ?: handler->name;
-- 
2.17.2


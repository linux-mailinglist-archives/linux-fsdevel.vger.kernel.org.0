Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD208B13BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387673AbfILR3O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:14 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:6371 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387594AbfILR3K (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:29:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309349; x=1599845349;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=go2WMuEC8d4jW8Xxl60nZEHowSglDH+4J7lxYAStWuA=;
  b=oWl7kHa3DqgCrBXmEJ9V9IjAPPGfWuK+TRtymKrt02kOeaMGHZZVsvSS
   NPNtGznnof3AQdBIoeF2hQV4iVaQvrDjqC9ShQeIx4UVyFNO1xL28+yyS
   nDZ2BeJN0WQAH4wyobiFxOXCxxOLwcyl4BgxgBDef0bJzrt+jUepuuguA
   A=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="702191776"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-1e-57e1d233.us-east-1.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 12 Sep 2019 17:28:57 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-57e1d233.us-east-1.amazon.com (Postfix) with ESMTPS id 3B620141C61;
        Thu, 12 Sep 2019 17:28:51 +0000 (UTC)
Received: from EX13D15UEA002.ant.amazon.com (10.43.61.85) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.243) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13D15UEA002.ant.amazon.com (10.43.61.85) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:51 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.61.243) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:51 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E1C15C0566; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <64c6cfb84541b4231ea1b29100f6641d8a7e169a.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Mon, 2 Sep 2019 20:34:23 +0000
Subject: [RFC PATCH 32/35] xattr: add a function to check if a namespace is
 supported
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add a function that checks is an extended attribute namespace is
supported for an inode.

To be used by the nfs server code when being queried for extended
attributes support.

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/xattr.c            | 27 +++++++++++++++++++++++++++
 include/linux/xattr.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index 58013bcbc333..7d0ebab1df30 100644
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
index 3a71ad716da5..32e377602068 100644
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


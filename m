Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC1D1961DC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 00:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgC0X1c (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Mar 2020 19:27:32 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:44449 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726912AbgC0X1c (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Mar 2020 19:27:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1585351652; x=1616887652;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=7CJ0/DxBMA03qm16lsX16qMguWhLUK5dHu3YmBnNsO0=;
  b=Y+MBRDsslp+ZzKzSJhc3KM1OoO/pEj8Xvg3ELYskJglpO4OmevbXKYy+
   HikNFUlarGyCr8sDyaI/MJr+bXBvJATcWIXPSMxXz4ebTbAVCfwGhFfW4
   xrc8q/zuqTQv3xZvxQ32zAWYCQBWuDBN1Acaei1u2zvCJg6BKPpKT1SiQ
   Q=;
IronPort-SDR: lBhqbUyixFEgMLXUrhZ/pBNk25AFqcF6/HnxigOBbxHkjDPy8wDbSary+VO4VaysC8QUQEuBTY
 tc3Qd6RUheug==
X-IronPort-AV: E=Sophos;i="5.72,314,1580774400"; 
   d="scan'208";a="24526352"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2a-22cc717f.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 27 Mar 2020 23:27:19 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-22cc717f.us-west-2.amazon.com (Postfix) with ESMTPS id CD199A2087;
        Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 27 Mar 2020 23:27:17 +0000
Received: from EX13MTAUWC001.ant.amazon.com (10.43.162.135) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Mar 2020 23:27:16 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.162.232) with Microsoft SMTP
 Server id 15.0.1367.3 via Frontend Transport; Fri, 27 Mar 2020 23:27:17 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 34BCDDEFAF; Fri, 27 Mar 2020 23:27:17 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v2 02/11] xattr: add a function to check if a namespace is supported
Date:   Fri, 27 Mar 2020 23:27:08 +0000
Message-ID: <20200327232717.15331-3-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200327232717.15331-1-fllinden@amazon.com>
References: <20200327232717.15331-1-fllinden@amazon.com>
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

Cc: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/xattr.c            | 27 +++++++++++++++++++++++++++
 include/linux/xattr.h |  2 ++
 2 files changed, 29 insertions(+)

diff --git a/fs/xattr.c b/fs/xattr.c
index f2854570d411..1b079550a96d 100644
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


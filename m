Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D528206765
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 00:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388149AbgFWWoW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Jun 2020 18:44:22 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:14750 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387881AbgFWWoN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Jun 2020 18:44:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1592952251; x=1624488251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=GqJcfO2z0/QXdUwZZb7NPjQfThC/WYVsGSN3S3j17OE=;
  b=EOOHPa8l8WjPkD5DXPdwnYq7nExmE7ObCjJdZ7DK35TK1q62qnVPLAuW
   Gy7nqrxRgFLFyNpuXmV6NU19FkWYWqaQr/vBbEVsgdCQUsTLcz6Q57CIv
   VYkuXuOu1YgXXOVHSHZF0G83W6k/RXGcEOLGvU3u1TIqZOjrf3xvPbBaU
   4=;
IronPort-SDR: HSzIjK6ZzglwCBxoRwKrFlEdIZxl09u9xK9URWY1E5zGuPI0pR8ps1TqLy5MI1P0vCsjfzJ3pa
 1zjKco03b93A==
X-IronPort-AV: E=Sophos;i="5.75,272,1589241600"; 
   d="scan'208";a="53337281"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 23 Jun 2020 22:39:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2c-4e7c8266.us-west-2.amazon.com (Postfix) with ESMTPS id 5044CA1C75;
        Tue, 23 Jun 2020 22:39:37 +0000 (UTC)
Received: from EX13D13UWB004.ant.amazon.com (10.43.161.218) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from EX13MTAUEB002.ant.amazon.com (10.43.60.12) by
 EX13D13UWB004.ant.amazon.com (10.43.161.218) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 23 Jun 2020 22:39:29 +0000
Received: from dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com
 (172.23.141.97) by mail-relay.amazon.com (10.43.60.234) with Microsoft SMTP
 Server id 15.0.1497.2 via Frontend Transport; Tue, 23 Jun 2020 22:39:28 +0000
Received: by dev-dsk-fllinden-2c-c1893d73.us-west-2.amazon.com (Postfix, from userid 6262777)
        id 039A3CD35A; Tue, 23 Jun 2020 22:39:27 +0000 (UTC)
From:   Frank van der Linden <fllinden@amazon.com>
To:     <bfields@fieldses.org>, <chuck.lever@oracle.com>,
        <linux-nfs@vger.kernel.org>
CC:     Frank van der Linden <fllinden@amazon.com>,
        <linux-fsdevel@vger.kernel.org>, Al Viro <viro@zeniv.linux.org.uk>
Subject: [PATCH v3 01/10] xattr: break delegations in {set,remove}xattr
Date:   Tue, 23 Jun 2020 22:39:18 +0000
Message-ID: <20200623223927.31795-2-fllinden@amazon.com>
X-Mailer: git-send-email 2.16.6
In-Reply-To: <20200623223927.31795-1-fllinden@amazon.com>
References: <20200623223927.31795-1-fllinden@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

set/removexattr on an exported filesystem should break NFS delegations.
This is true in general, but also for the upcoming support for
RFC 8726 (NFSv4 extended attribute support). Make sure that they do.

Additonally, they need to grow a _locked variant, since callers might
call this with i_rwsem held (like the NFS server code).

Cc: stable@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/xattr.c            | 84 +++++++++++++++++++++++++++++++++++++++----
 include/linux/xattr.h |  2 ++
 2 files changed, 79 insertions(+), 7 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 91608d9bfc6a..95f38f57347f 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -204,10 +204,22 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	return error;
 }
 
-
+/**
+ * __vfs_setxattr_locked: set an extended attribute while holding the inode
+ * lock
+ *
+ *  @dentry - object to perform setxattr on
+ *  @name - xattr name to set
+ *  @value - value to set @name to
+ *  @size - size of @value
+ *  @flags - flags to pass into filesystem operations
+ *  @delegated_inode - on return, will contain an inode pointer that
+ *  a delegation was broken on, NULL if none.
+ */
 int
-vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		size_t size, int flags)
+__vfs_setxattr_locked(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags,
+		struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -216,15 +228,40 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
 	if (error)
 		return error;
 
-	inode_lock(inode);
 	error = security_inode_setxattr(dentry, name, value, size, flags);
 	if (error)
 		goto out;
 
+	error = try_break_deleg(inode, delegated_inode);
+	if (error)
+		goto out;
+
 	error = __vfs_setxattr_noperm(dentry, name, value, size, flags);
 
 out:
+	return error;
+}
+EXPORT_SYMBOL_GPL(__vfs_setxattr_locked);
+
+int
+vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
+		size_t size, int flags)
+{
+	struct inode *inode = dentry->d_inode;
+	struct inode *delegated_inode = NULL;
+	int error;
+
+retry_deleg:
+	inode_lock(inode);
+	error = __vfs_setxattr_locked(dentry, name, value, size, flags,
+	    &delegated_inode);
 	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_setxattr);
@@ -378,8 +415,18 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
 }
 EXPORT_SYMBOL(__vfs_removexattr);
 
+/**
+ * __vfs_removexattr_locked: set an extended attribute while holding the inode
+ * lock
+ *
+ *  @dentry - object to perform setxattr on
+ *  @name - name of xattr to remove
+ *  @delegated_inode - on return, will contain an inode pointer that
+ *  a delegation was broken on, NULL if none.
+ */
 int
-vfs_removexattr(struct dentry *dentry, const char *name)
+__vfs_removexattr_locked(struct dentry *dentry, const char *name,
+		struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -388,11 +435,14 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 	if (error)
 		return error;
 
-	inode_lock(inode);
 	error = security_inode_removexattr(dentry, name);
 	if (error)
 		goto out;
 
+	error = try_break_deleg(inode, delegated_inode);
+	if (error)
+		goto out;
+
 	error = __vfs_removexattr(dentry, name);
 
 	if (!error) {
@@ -401,12 +451,32 @@ vfs_removexattr(struct dentry *dentry, const char *name)
 	}
 
 out:
+	return error;
+}
+EXPORT_SYMBOL_GPL(__vfs_removexattr_locked);
+
+int
+vfs_removexattr(struct dentry *dentry, const char *name)
+{
+	struct inode *inode = dentry->d_inode;
+	struct inode *delegated_inode = NULL;
+	int error;
+
+retry_deleg:
+	inode_lock(inode);
+	error = __vfs_removexattr_locked(dentry, name, &delegated_inode);
 	inode_unlock(inode);
+
+	if (delegated_inode) {
+		error = break_deleg_wait(&delegated_inode);
+		if (!error)
+			goto retry_deleg;
+	}
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_removexattr);
 
-
 /*
  * Extended attribute SET operations
  */
diff --git a/include/linux/xattr.h b/include/linux/xattr.h
index 47eaa34f8761..a2f3cd02653c 100644
--- a/include/linux/xattr.h
+++ b/include/linux/xattr.h
@@ -51,8 +51,10 @@ ssize_t vfs_getxattr(struct dentry *, const char *, void *, size_t);
 ssize_t vfs_listxattr(struct dentry *d, char *list, size_t size);
 int __vfs_setxattr(struct dentry *, struct inode *, const char *, const void *, size_t, int);
 int __vfs_setxattr_noperm(struct dentry *, const char *, const void *, size_t, int);
+int __vfs_setxattr_locked(struct dentry *, const char *, const void *, size_t, int, struct inode **);
 int vfs_setxattr(struct dentry *, const char *, const void *, size_t, int);
 int __vfs_removexattr(struct dentry *, const char *);
+int __vfs_removexattr_locked(struct dentry *, const char *, struct inode **);
 int vfs_removexattr(struct dentry *, const char *);
 
 ssize_t generic_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size);
-- 
2.17.2


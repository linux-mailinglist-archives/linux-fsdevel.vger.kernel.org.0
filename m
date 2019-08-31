Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83FB13A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Sep 2019 19:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387640AbfILR3B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Sep 2019 13:29:01 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:44607 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387597AbfILR26 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Sep 2019 13:28:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568309338; x=1599845338;
  h=message-id:in-reply-to:references:from:date:subject:to:
   mime-version;
  bh=+8uLLJBHkKd2f2TwaLb19UdDfsUlykAE/ru2EoaUj/s=;
  b=L8KtES7U0WPhY0TPOJZ1xS6oRVxktalZsh4vuSIwk3YzliIMMguHJVnq
   ED0Yq0YDgmYbDoVNzy2zUF4Hz/UVs3uAWzDQ86n/0quYNCZeqa0J5DOwY
   aL3EDiP028z9i1RNXQHXtKbBnq+tKwfOE1a5y+DrjN43wVMdMlIedCVSL
   k=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="750440670"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 12 Sep 2019 17:28:53 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id 1BEE8A2CAD;
        Thu, 12 Sep 2019 17:28:52 +0000 (UTC)
Received: from EX13D04UWB001.ant.amazon.com (10.43.161.46) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from EX13MTAUWB001.ant.amazon.com (10.43.161.207) by
 EX13D04UWB001.ant.amazon.com (10.43.161.46) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 17:28:52 +0000
Received: from kaos-source-ops-60003.pdx1.corp.amazon.com (10.36.133.164) by
 mail-relay.amazon.com (10.43.161.249) with Microsoft SMTP Server id
 15.0.1367.3 via Frontend Transport; Thu, 12 Sep 2019 17:28:52 +0000
Received: by kaos-source-ops-60003.pdx1.corp.amazon.com (Postfix, from userid 6262777)
        id E6C6DC04C6; Thu, 12 Sep 2019 17:28:49 +0000 (UTC)
Message-ID: <2afeb5330f488b70f7ae5495b2b0d56e75ee9392.1568309119.git.fllinden@amazon.com>
In-Reply-To: <cover.1568309119.git.fllinden@amazon.com>
References: <cover.1568309119.git.fllinden@amazon.com>
From:   Frank van der Linden <fllinden@amazon.com>
Date:   Sat, 31 Aug 2019 02:12:53 +0000
Subject: [RFC PATCH 21/35] xattr: modify vfs_{set,remove}xattr for NFS server
 use
To:     <linux-nfs@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

To be called from the upcoming NFS server xattr code, the vfs_removexattr
and vfs_setxattr need some modifications.

First, they need to grow a _locked variant, since the NFS server code
will call this with i_rwsem held. It needs to do that in fh_lock to be
able to atomically provide the before and after change attributes.

Second, RFC 8276 (NFSv4 extended attribute support) specifies that
delegations should be recalled (8.4.2.4, 8.4.4.4) when a SETXATTR
or REMOVEXATTR operation is performed. So, like with other fs
operations, try to break the delegation. The _locked version of
these operations will not wait for the delegation to be successfully
broken, instead returning an error if it wasn't, so that the NFS
server code can return NFS4ERR_DELAY to the client (similar to
what e.g. vfs_link does).

Signed-off-by: Frank van der Linden <fllinden@amazon.com>
---
 fs/xattr.c            | 63 ++++++++++++++++++++++++++++++++++++++-----
 include/linux/xattr.h |  2 ++
 2 files changed, 58 insertions(+), 7 deletions(-)

diff --git a/fs/xattr.c b/fs/xattr.c
index 90dd78f0eb27..58013bcbc333 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -204,10 +204,10 @@ int __vfs_setxattr_noperm(struct dentry *dentry, const char *name,
 	return error;
 }
 
-
 int
-vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
-		size_t size, int flags)
+__vfs_setxattr_locked(struct dentry *dentry, const char *name,
+		const void *value, size_t size, int flags,
+		struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -216,15 +216,40 @@ vfs_setxattr(struct dentry *dentry, const char *name, const void *value,
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
@@ -379,7 +404,8 @@ __vfs_removexattr(struct dentry *dentry, const char *name)
 EXPORT_SYMBOL(__vfs_removexattr);
 
 int
-vfs_removexattr(struct dentry *dentry, const char *name)
+__vfs_removexattr_locked(struct dentry *dentry, const char *name,
+		struct inode **delegated_inode)
 {
 	struct inode *inode = dentry->d_inode;
 	int error;
@@ -388,11 +414,14 @@ vfs_removexattr(struct dentry *dentry, const char *name)
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
@@ -401,12 +430,32 @@ vfs_removexattr(struct dentry *dentry, const char *name)
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
index 6dad031be3c2..3a71ad716da5 100644
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


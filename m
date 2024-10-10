Return-Path: <linux-fsdevel+bounces-31600-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 44304998D0A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 18:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E887B2BD43
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 15:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B481CCB25;
	Thu, 10 Oct 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b="x5Kg8XAg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-8fad.mail.infomaniak.ch (smtp-8fad.mail.infomaniak.ch [83.166.143.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E41CC8A8
	for <linux-fsdevel@vger.kernel.org>; Thu, 10 Oct 2024 15:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.166.143.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728574029; cv=none; b=tZq1fH2tTu0EqGBMLizb+0gdktiSdeo12mX0oWhZIWoRiiCK5AeAc14gA62eLuV6uO86zDF76Q/ATw6QCbgikjaAR4IWvRGTH0lIvpTLix/frOEqGjgle1ntfxqTWDG7Y8qeLUMHw0J5VghEdw5pz43xguSLsVPZMxwNhECa3EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728574029; c=relaxed/simple;
	bh=pWtLcjsmW4Qrm1YUcmTcA7tapQRt91fGtH3cEhWZ1EY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=i5vsf5snPj+VdOB0Tx+er62cyAjzUv7Df66g49+rX7h3vk1TvJpE7WZNyp2wBcF/t8RNAdYzmV1CSyR+nM9ofRZBISLMXJhsXWq35mS9o7IBkLKTj3JCnrW7qXzH0BFAncKEi6E2G11eA5monkpDSK9HpZ6Q4bwEMLgiMCaUIrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net; spf=pass smtp.mailfrom=digikod.net; dkim=pass (1024-bit key) header.d=digikod.net header.i=@digikod.net header.b=x5Kg8XAg; arc=none smtp.client-ip=83.166.143.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikod.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikod.net
Received: from smtp-4-0001.mail.infomaniak.ch (smtp-4-0001.mail.infomaniak.ch [10.7.10.108])
	by smtp-4-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4XPYX03MtCz63h;
	Thu, 10 Oct 2024 17:26:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digikod.net;
	s=20191114; t=1728574016;
	bh=oCSwOw598EhYP254uOWzIyCUOB7f8SxQQTeZxoKvSLU=;
	h=From:To:Cc:Subject:Date:From;
	b=x5Kg8XAgBFXfFqaybiH6SHrYOau3tOPmMTIzkIEP/oFRB4WdWdWgzZ4LNSB6l+rSK
	 l1NE5fgNuGMKWC036+wChsgGxCX8H5R0sG0z3TrH4Ik52EwcHt/Tb4wgCMzb+jdctv
	 kWakYI2PbopwRZiy5bTbYX/iDfpUfJpPgauzuq8Q=
Received: from unknown by smtp-4-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4XPYWz5bv6zQj1;
	Thu, 10 Oct 2024 17:26:55 +0200 (CEST)
From: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>
To: Christian Brauner <brauner@kernel.org>,
	Paul Moore <paul@paul-moore.com>
Cc: =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org,
	Trond Myklebust <trondmy@kernel.org>,
	Anna Schumaker <anna@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>
Subject: [RFC PATCH v1 1/7] fs: Add inode_get_ino() and implement get_ino() for NFS
Date: Thu, 10 Oct 2024 17:26:41 +0200
Message-ID: <20241010152649.849254-1-mic@digikod.net>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Infomaniak-Routing: alpha

When a filesystem manages its own inode numbers, like NFS's fileid shown
to user space with getattr(), other part of the kernel may still expose
the private inode->ino through kernel logs and audit.

Another issue is on 32-bit architectures, on which ino_t is 32 bits,
whereas the user space's view of an inode number can still be 64 bits.

Add a new inode_get_ino() helper calling the new struct
inode_operations' get_ino() when set, to get the user space's view of an
inode number.  inode_get_ino() is called by generic_fillattr().

Implement get_ino() for NFS.

Cc: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>
Signed-off-by: Mickaël Salaün <mic@digikod.net>
---

I'm not sure about nfs_namespace_getattr(), please review carefully.

I guess there are other filesystems exposing inode numbers different
than inode->i_ino, and they should be patched too.
---
 fs/nfs/inode.c     | 6 ++++--
 fs/nfs/internal.h  | 1 +
 fs/nfs/namespace.c | 2 ++
 fs/stat.c          | 2 +-
 include/linux/fs.h | 9 +++++++++
 5 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/fs/nfs/inode.c b/fs/nfs/inode.c
index 542c7d97b235..5dfc176b6d92 100644
--- a/fs/nfs/inode.c
+++ b/fs/nfs/inode.c
@@ -83,18 +83,19 @@ EXPORT_SYMBOL_GPL(nfs_wait_bit_killable);
 
 /**
  * nfs_compat_user_ino64 - returns the user-visible inode number
- * @fileid: 64-bit fileid
+ * @inode: inode pointer
  *
  * This function returns a 32-bit inode number if the boot parameter
  * nfs.enable_ino64 is zero.
  */
-u64 nfs_compat_user_ino64(u64 fileid)
+u64 nfs_compat_user_ino64(const struct *inode)
 {
 #ifdef CONFIG_COMPAT
 	compat_ulong_t ino;
 #else	
 	unsigned long ino;
 #endif
+	u64 fileid = NFS_FILEID(inode);
 
 	if (enable_ino64)
 		return fileid;
@@ -103,6 +104,7 @@ u64 nfs_compat_user_ino64(u64 fileid)
 		ino ^= fileid >> (sizeof(fileid)-sizeof(ino)) * 8;
 	return ino;
 }
+EXPORT_SYMBOL_GPL(nfs_compat_user_ino64);
 
 int nfs_drop_inode(struct inode *inode)
 {
diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index 430733e3eff2..f5555a71a733 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -451,6 +451,7 @@ extern void nfs_zap_acl_cache(struct inode *inode);
 extern void nfs_set_cache_invalid(struct inode *inode, unsigned long flags);
 extern bool nfs_check_cache_invalid(struct inode *, unsigned long);
 extern int nfs_wait_bit_killable(struct wait_bit_key *key, int mode);
+extern u64 nfs_compat_user_ino64(const struct *inode);
 
 #if IS_ENABLED(CONFIG_NFS_LOCALIO)
 /* localio.c */
diff --git a/fs/nfs/namespace.c b/fs/nfs/namespace.c
index e7494cdd957e..d9b1e0606833 100644
--- a/fs/nfs/namespace.c
+++ b/fs/nfs/namespace.c
@@ -232,11 +232,13 @@ nfs_namespace_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 const struct inode_operations nfs_mountpoint_inode_operations = {
 	.getattr	= nfs_getattr,
 	.setattr	= nfs_setattr,
+	.get_ino	= nfs_compat_user_ino64,
 };
 
 const struct inode_operations nfs_referral_inode_operations = {
 	.getattr	= nfs_namespace_getattr,
 	.setattr	= nfs_namespace_setattr,
+	.get_ino	= nfs_compat_user_ino64,
 };
 
 static void nfs_expire_automounts(struct work_struct *work)
diff --git a/fs/stat.c b/fs/stat.c
index 41e598376d7e..05636919f94b 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -50,7 +50,7 @@ void generic_fillattr(struct mnt_idmap *idmap, u32 request_mask,
 	vfsgid_t vfsgid = i_gid_into_vfsgid(idmap, inode);
 
 	stat->dev = inode->i_sb->s_dev;
-	stat->ino = inode->i_ino;
+	stat->ino = inode_get_ino(inode);
 	stat->mode = inode->i_mode;
 	stat->nlink = inode->i_nlink;
 	stat->uid = vfsuid_into_kuid(vfsuid);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e3c603d01337..0eba09a21cf7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2165,6 +2165,7 @@ struct inode_operations {
 			    struct dentry *dentry, struct fileattr *fa);
 	int (*fileattr_get)(struct dentry *dentry, struct fileattr *fa);
 	struct offset_ctx *(*get_offset_ctx)(struct inode *inode);
+	u64 (*get_ino)(const struct inode *inode);
 } ____cacheline_aligned;
 
 static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
@@ -2172,6 +2173,14 @@ static inline int call_mmap(struct file *file, struct vm_area_struct *vma)
 	return file->f_op->mmap(file, vma);
 }
 
+static inline u64 inode_get_ino(struct inode *inode)
+{
+	if (unlikely(inode->i_op->get_ino))
+		return inode->i_op->get_ino(inode);
+
+	return inode->i_ino;
+}
+
 extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
-- 
2.46.1



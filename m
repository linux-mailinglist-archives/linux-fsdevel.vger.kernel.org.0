Return-Path: <linux-fsdevel+bounces-55214-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB3DB087F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 10:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3C601AA5F11
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 08:32:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A17C255F57;
	Thu, 17 Jul 2025 08:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="plJ7kFkt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071EC23B0
	for <linux-fsdevel@vger.kernel.org>; Thu, 17 Jul 2025 08:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752741133; cv=none; b=sj52ilaGex7aGS42/WdveqJmF0I9OPJofUgU37gUOQKxJAiW0OdD45nEy2A+zG4Yc1ssm+DmUTlERIGZwJHsoK1/2EPwS8d1gDnFditojL/EJdRZaYmoUR9AjNsCrF+S6wsFzBivQaF5VolYO+ZIg5MPjFPTGSIauG23spxvbMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752741133; c=relaxed/simple;
	bh=bRlPOsgBltCo4asJ0r3LUt7Vv2+p9oJj+OIelRKuiJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e54IdTQRTtXDze4MCpsRvrYqwJRm6LHaDtCyQH6dnlGP33OjOLJ0OANu8avnikGG7SOIC483aHWGZzJ35VlaH0vO/JOYNfO4r2b4Sp4bWPlEtd7sgDuOkBTE7q7ZCqXu62Bf2XiOgWAZbfTCH7dKrJ8kt7/yIjx9JVteRoaaSKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=plJ7kFkt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BB38C4CEE3;
	Thu, 17 Jul 2025 08:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752741132;
	bh=bRlPOsgBltCo4asJ0r3LUt7Vv2+p9oJj+OIelRKuiJU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=plJ7kFktvFxEMKEQJrzcCgxpN7c0RNhm6GLYe4hecgvSPzyj/KTskAVFYcJi9qs2P
	 8mHfCq99gXcmFgl9UpVM6ektVvTrDh/09st85KIxOHyzWU0VIsm0JanyHozepB4QmU
	 /ng8QUoe4MBNAdNiHHWFiGaqMWlwUQikrd87zFwkQ8aNxWnXBWmdl4AYLtyS0RGe69
	 veFl4pqMgaSAFHNMUwNZOWkta8bLo224Mwwzwki5UC1QsbYS5VAXgN5UP7rkrwsheA
	 ZJZUjBk7j6pZspvo2x5wj9kHjjihvO6oq3Jxj7CGvQ67IVAKbfyNaKP7gor1p+OxaF
	 HKNlhTwTZOvHw==
Date: Thu, 17 Jul 2025 10:32:07 +0200
From: Christian Brauner <brauner@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Matthew Wilcox <willy@infradead.org>, Jeff Layton <jlayton@kernel.org>, 
	Jan Kara <jack@suse.com>, Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>, 
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC DRAFT DOESNOTBUILD] inode: free up more space
Message-ID: <20250717-drehbaren-rabiat-850d4c5212fb@brauner>
References: <20250715-work-inode-fscrypt-v1-1-aa3ef6f44b6b@kernel.org>
 <20250716112149.GA29673@lst.de>
 <20250716-unwahr-dumpf-835be7215e4c@brauner>
 <a24e87f111509bed526dd0a1650399edda9b75c0.camel@kernel.org>
 <aHeydTPax7kh5p28@casper.infradead.org>
 <20250716141030.GA11490@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250716141030.GA11490@lst.de>

On Wed, Jul 16, 2025 at 04:10:30PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 16, 2025 at 03:08:53PM +0100, Matthew Wilcox wrote:
> > struct filemap_inode {
> > 	struct inode		inode;
> > 	struct address_space	i_mapping;
> > 	struct fscrypt_struct	i_fscrypt;
> > 	struct fsverity_struct	i_fsverity;
> > 	struct quota_struct	i_quota;
> > };
> > 
> > struct ext4_inode {
> > 	struct filemap_inode inode;
> > 	...
> > };
> > 
> > saves any messing with i_ops and offsets.
> 
> I still wastest a lot of space for XFS which only needs inode
> and i_mapping of those.  As would most ext4 file systems..

We can do a hybrid approach:

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 2bc6a3ac2b8e..dda45b3f2122 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1198,9 +1198,7 @@ struct ext4_inode_info {

        kprojid_t i_projid;

-#ifdef CONFIG_FS_ENCRYPTION
-       struct fscrypt_inode_info       *i_fscrypt_info;
-#endif
+       struct vfs_inode_adjunct i_adjunct; /* Adjunct data for inode */
 };

 /*
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 676d33a7d842..f257ac048f3b 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -981,17 +981,19 @@ const struct file_operations ext4_file_operations = {
 };

 const struct inode_operations ext4_file_inode_operations = {
-       .setattr        = ext4_setattr,
-       .getattr        = ext4_file_getattr,
-       .listxattr      = ext4_listxattr,
-       .get_inode_acl  = ext4_get_acl,
-       .set_acl        = ext4_set_acl,
-       .fiemap         = ext4_fiemap,
-       .fileattr_get   = ext4_fileattr_get,
-       .fileattr_set   = ext4_fileattr_set,
+       .i_adjunct_offset       = offsetof(struct ext4_inode_info, vfs_inode) -
+                                 offsetof(struct ext4_inode_info, i_adjunct),
+       .setattr                = ext4_setattr,
+       .getattr                = ext4_file_getattr,
+       .listxattr              = ext4_listxattr,
+       .get_inode_acl          = ext4_get_acl,
+       .set_acl                = ext4_set_acl,
+       .fiemap                 = ext4_fiemap,
+       .fileattr_get           = ext4_fileattr_get,
+       .fileattr_set           = ext4_fileattr_set,
 #ifdef CONFIG_FS_ENCRYPTION
-       .get_fscrypt    = ext4_get_fscrypt,
-       .set_fscrypt    = ext4_set_fscrypt,
+       .get_fscrypt            = ext4_get_fscrypt,
+       .set_fscrypt            = ext4_set_fscrypt,
 #endif
 };

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d8f242a2f431..c4752c80710e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -789,6 +789,12 @@ struct inode {
        void                    *i_private; /* fs or device private pointer */
 } __randomize_layout;

+struct vfs_inode_adjunct {
+#ifdef CONFIG_FS_ENCRYPTION
+       struct fscrypt_inode_info *i_fscrypt_info;
+#endif
+};
+
 static inline void inode_set_cached_link(struct inode *inode, char *link, int linklen)
 {
        VFS_WARN_ON_INODE(strlen(link) != linklen, inode);
@@ -2217,6 +2223,7 @@ int wrap_directory_iterator(struct file *, struct dir_context *,
        { return wrap_directory_iterator(file, ctx, x); }

 struct inode_operations {
+       ptrdiff_t i_adjunct_offset;
        struct dentry * (*lookup) (struct inode *,struct dentry *, unsigned int);
        const char * (*get_link) (struct dentry *, struct inode *, struct delayed_call *);
        int (*permission) (struct mnt_idmap *, struct inode *, int);
diff --git a/include/linux/fscrypt.h b/include/linux/fscrypt.h
index 1aa474232fa7..fa0080869dc1 100644
--- a/include/linux/fscrypt.h
+++ b/include/linux/fscrypt.h
@@ -195,6 +195,12 @@ struct fscrypt_operations {
 int fscrypt_d_revalidate(struct inode *dir, const struct qstr *name,
                         struct dentry *dentry, unsigned int flags);

+static inline struct fscrypt_inode_info *CRYPT_I(struct inode *inode)
+{
+       struct vfs_inode_adjunct *p = ((void *)inode) - inode->i_op->i_adjunct_offset;
+       return p->i_fscrypt_info;
+}
+
 static inline int vfs_fscrypt_inode_set(struct fscrypt_inode_info *crypt_info,
                                        struct fscrypt_inode_info **p)
 {


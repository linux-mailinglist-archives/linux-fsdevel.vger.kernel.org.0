Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08E2511511
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Apr 2022 12:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiD0KqX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 06:46:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229964AbiD0KqC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 06:46:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62EA1C1DD1;
        Wed, 27 Apr 2022 03:29:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C426B82576;
        Wed, 27 Apr 2022 09:22:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD70C385A7;
        Wed, 27 Apr 2022 09:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651051327;
        bh=onXoX5u0npwqKTIon13EJNfGXjQv81cfFzRb4TQR/dc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jLhIgScPS7R2CqTfhmHVMf/TU4Y+czL3f7z6OwMCOVsPbjYDrGs7UbYcZdBG7p/Jb
         kRMrL/tHcqJToDf6+fC47MmTyhAd27t/bmeYz+AulJNl4roW/576hr4JMWkf8CHTTQ
         8pQSTBAGlNdgjLlUr2Ca+/EkpB5VHGt7CYaiXzSuekQaR/tZTOS7YNmkS7VPdkOXSh
         xHy3Q+lobGZVKLktdYFCe/x5OHqq07wCXUCZHszgpBtA00Xd6/JxEunW4dEBkFyBjz
         7tKxnp7ffDI1MYrKMUEcHDAqMvoNYhfDsldJswaQrEN9ocaPPC2Kt4sgltWQ7KR6h3
         rYmr5nVeGexRQ==
Date:   Wed, 27 Apr 2022 11:22:01 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v8 3/4] fs: move S_ISGID stripping into the vfs
Message-ID: <20220427092201.wvsdjbnc7b4dttaw@wittgenstein>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650971490-4532-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220426103846.tzz66f2qxcxykws3@wittgenstein>
 <CAOQ4uxhRMp4tM9nP+0yPHJyzPs6B2vtX6z51tBHWxE6V+UZREw@mail.gmail.com>
 <CAJfpegu5uJiHgHmLcuSJ6+cQfOPB2aOBovHr4W5j_LU+reJsCw@mail.gmail.com>
 <20220426145349.zxmahoq2app2lhip@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220426145349.zxmahoq2app2lhip@wittgenstein>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 26, 2022 at 04:53:49PM +0200, Christian Brauner wrote:
> On Tue, Apr 26, 2022 at 01:52:11PM +0200, Miklos Szeredi wrote:
> > On Tue, 26 Apr 2022 at 13:21, Amir Goldstein <amir73il@gmail.com> wrote:
> > >
> > > On Tue, Apr 26, 2022 at 1:38 PM Christian Brauner <brauner@kernel.org> wrote:
> > 
> > > > One thing that I just remembered and which I think I haven't mentioned
> > > > so far is that moving S_ISGID stripping from filesystem callpaths into
> > > > the vfs callpaths means that we're hoisting this logic out of vfs_*()
> > > > helpers implicitly.
> > > >
> > > > So filesystems that call vfs_*() helpers directly can't rely on S_ISGID
> > > > stripping being done in vfs_*() helpers anymore unless they pass the
> > > > mode on from a prior run through the vfs.
> > > >
> > > > This mostly affects overlayfs which calls vfs_*() functions directly. So
> > > > a typical overlayfs callstack would be (roughly - I'm omw to lunch):
> > > >
> > > > sys_mknod()
> > > > -> do_mknodat(mode) // calls vfs_prepare_mode()
> > > >    -> .mknod = ovl_mknod(mode)
> > > >       -> ovl_create(mode)
> > > >          -> vfs_mknod(mode)
> > > >
> > > > I think we are safe as overlayfs passes on the mode on from its own run
> > > > through the vfs and then via vfs_*() to the underlying filesystem but it
> > > > is worth point that out.
> > > >
> > > > Ccing Amir just for confirmation.
> > >
> > > Looks fine to me, but CC Miklos ...
> > 
> > Looks fine to me as well.  Overlayfs should share the mode (including
> > the suid and sgid bits), owner, group and ACL's with the underlying
> > filesystem, so clearing sgid based on overlay parent directory should
> > result in the same mode as if it was done based on the parent
> > directory on the underlying layer.
> 
> Ah yes, good point.
> 
> > 
> > AFAIU this logic is not affected by userns or mnt_userns, but
> > Christian would be best to confirm that.
> 
> It does depend on it as S_ISGID stripping requires knowledge about
> whether the caller has CAP_FSETID and is capable over the parent
> directory or if they are in the group the file is owned by.
> 
> I think ultimately it might just come down to moving vfs_prepare_mode()
> into vfs_*() helpers and not into the do_*at() helpers.
> 
> That would be cleaner anyway as right now we have this weird disconnect
> between vfs_tmpfile() and vfs_{create,mknod,mkdir}(). IOW, vfs_tmpfile()
> doesn't even have an associated do_*() wrapper where we could call
> vfs_prepare_mode() from.
> 
> So ultimately it might be nicer if we do it in vfs_*() helpers anyway.
> 
> The less pretty thing about it will be that the security_path_*() hooks
> also want a mode.
> 
> Right now these hooks receive the mode as it's passed in from userspace
> minus umask but before S_ISGID stripping happens.
> 
> Whereas I think they should really see what the filesystem sees and
> currently it's a bug that they see something else.
> 
> I need to think about this a bit.

So on top of that series (though it should just be folded in), does that
look reasonable?

From e993f81caae60fee4f77b40d46ad3863ea383493 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 27 Apr 2022 10:53:35 +0200
Subject: [PATCH] UNTESTED UNTESTED UNTESTED

As I realized yesterday we need to move mode preparation into the vfs_*()
instead of do_*() helpers as filesystems like overlayfs have the following
callstacks:

sys_mknod(ovl_path, mode)
-> do_mknodat(ovl_path, mode)
   -> .mknod = ovl_mknod(ovl_path, mode)
      -> vfs_mknod(xfs_path, mode)
	 -> .mknod = xfs_vn_mknod(xfs_path, mode)

and the requirement that this will yield the same mode as:

sys_mknod(xfs_path, mode)
-> do_mknodat(xfs_path, mode)
   -> .mknod = xfs_vn_mknod(xfs_path, mode)

By moving setgid stripping into vfs_*() helpers we achieve:

- Moving setgid stripping out of the individual filesystem's responsibility.
- Ensure that callers of vfs_*() helpers continue to get correct setgid
  stripping.

Another thing I realized while looking at this yesterday was the entanglement
with security hooks. Security hooks currently see a different mode than the
actual filesystem sees when it calls into inode_init_owner(). This patch
doesn't change that!

I originally thought that we might be able to make the security hooks see the
same mode that the filesystem will see. However, I have doubts. First, I don't
think that is achievable without more restructuring. Second, I don't think it's
required as the hooks have clearly been placed before any vfs_*() calls and
thereby have committed themselves to see the mode as passed in from userspace
(minus the umask). We will simply continue doing just exactly that
side-stepping the issue for now.

Sketched-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/namei.c         | 103 +++++++++++++++++++++++++++++++++++++++------
 include/linux/fs.h |  11 -----
 2 files changed, 90 insertions(+), 24 deletions(-)

diff --git a/fs/namei.c b/fs/namei.c
index 5dbf00704ae8..8b83db15ae5f 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -2998,6 +2998,71 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
 }
 EXPORT_SYMBOL(unlock_rename);
 
+/**
+ * mode_strip_umask - handle vfs umask stripping
+ * @dir:	parent directory of the new inode
+ * @mode:	mode of the new inode to be created in @dir
+ *
+ * Umask stripping depends on whether or not the filesystem supports POSIX
+ * ACLs. If the filesystem doesn't support it umask stripping is done directly
+ * in here. If the filesystem does support POSIX ACLs umask stripping is
+ * deferred until the filesystem calls posix_acl_create().
+ *
+ * Returns: mode
+ */
+static inline umode_t mode_strip_umask(const struct inode *dir, umode_t mode)
+{
+	if (!IS_POSIXACL(dir))
+		mode &= ~current_umask();
+	return mode;
+}
+
+/**
+ * vfs_prepare_mode - prepare the mode to be used for a new inode
+ * @mnt_userns:	user namespace of the mount the inode was found from
+ * @dir:	parent directory of the new inode
+ * @mode:	mode of the new inode
+ * @mask_perms:	allowed permission by the vfs
+ * @type:	type of file to be created
+ *
+ * This helper consolidates and enforces vfs restrictions on the @mode of a new
+ * object to be created.
+ *
+ * Umask stripping depends on whether the filesystem supports POSIX ACLs (see
+ * the kernel documentation for mode_strip_umask()). Moving umask stripping
+ * after setgid stripping allows the same ordering for both non-POSIX ACL and
+ * POSIX ACL supporting filesystems.
+ *
+ * Note that it's currently valid for @type to be 0 if a directory is created.
+ * Filesystems raise that flag individually and we need to check whether each
+ * filesystem can deal with receiving S_IFDIR from the vfs before we enforce a
+ * non-zero type.
+ *
+ * Returns: mode to be passed to the filesystem
+ */
+static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
+				       const struct inode *dir, umode_t mode,
+				       umode_t mask_perms, umode_t type)
+{
+	/*
+	 * S_ISGID stripping depends on the mode of the new file so make sure
+	 * that the caller gives us this information and splat if we miss it.
+	 */
+	WARN_ON_ONCE((mode & S_IFMT) == 0);
+
+	mode = mode_strip_sgid(mnt_userns, dir, mode);
+	mode = mode_strip_umask(dir, mode);
+
+	/*
+	 * Apply the vfs mandated allowed permission mask and set the type of
+	 * file to be created before we call into the filesystem.
+	 */
+	mode &= (mask_perms & ~S_IFMT);
+	mode |= (type & S_IFMT);
+
+	return mode;
+}
+
 /**
  * vfs_create - create new file
  * @mnt_userns:	user namespace of the mount the inode was found from
@@ -3023,8 +3088,9 @@ int vfs_create(struct user_namespace *mnt_userns, struct inode *dir,
 
 	if (!dir->i_op->create)
 		return -EACCES;	/* shouldn't it be ENOSYS? */
-	mode &= S_IALLUGO;
-	mode |= S_IFREG;
+
+	mode = vfs_prepare_mode(mnt_userns, d_inode(path.dentry), mode,
+				S_IALLUGO, S_IFREG);
 	error = security_inode_create(dir, dentry, mode);
 	if (error)
 		return error;
@@ -3287,7 +3353,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
 	if (open_flag & O_CREAT) {
 		if (open_flag & O_EXCL)
 			open_flag &= ~O_TRUNC;
-		mode = vfs_prepare_mode(mnt_userns, dir->d_inode, mode);
+		mode = vfs_prepare_mode(mnt_userns, dir->d_inode, mode, mode, mode);
 		if (likely(got_write))
 			create_error = may_o_create(mnt_userns, &nd->path,
 						    dentry, mode);
@@ -3520,7 +3586,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
 	child = d_alloc(dentry, &slash_name);
 	if (unlikely(!child))
 		goto out_err;
-	mode = vfs_prepare_mode(mnt_userns, dir, mode);
+	mode = vfs_prepare_mode(mnt_userns, dir, mode, mode, mode);
 	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
 	if (error)
 		goto out_err;
@@ -3798,6 +3864,8 @@ int vfs_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	if (!dir->i_op->mknod)
 		return -EPERM;
 
+	mode = vfs_prepare_mode(mnt_userns, d_inode(path.dentry),
+				mode, mode, mode);
 	error = devcgroup_inode_mknod(mode, dev);
 	if (error)
 		return error;
@@ -3848,12 +3916,13 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
 	if (IS_ERR(dentry))
 		goto out1;
 
-	mnt_userns = mnt_user_ns(path.mnt);
-	mode = vfs_prepare_mode(mnt_userns, path.dentry->d_inode, mode);
-	error = security_path_mknod(&path, dentry, mode, dev);
+	error = security_path_mknod(&path, dentry,
+				    mode_strip_umask(d_inode(path.dentry), mode),
+				    dev);
 	if (error)
 		goto out2;
 
+	mnt_userns = mnt_user_ns(path.mnt);
 	switch (mode & S_IFMT) {
 		case 0: case S_IFREG:
 			error = vfs_create(mnt_userns, path.dentry->d_inode,
@@ -3919,7 +3988,13 @@ int vfs_mkdir(struct user_namespace *mnt_userns, struct inode *dir,
 	if (!dir->i_op->mkdir)
 		return -EPERM;
 
-	mode &= (S_IRWXUGO|S_ISVTX);
+	/*
+	 * Filesystems currently raise S_IFDIR individually. We should try and
+	 * fix that going forward passing it in from the vfs as we do for all
+	 * other files going forward.
+	 */
+	mode = vfs_prepare_mode(mnt_userns, d_inode(path.dentry),
+				mode, S_IRWXUGO | S_ISVTX, 0);
 	error = security_inode_mkdir(dir, dentry, mode);
 	if (error)
 		return error;
@@ -3940,7 +4015,6 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	struct path path;
 	int error;
 	unsigned int lookup_flags = LOOKUP_DIRECTORY;
-	struct user_namespace *mnt_userns;
 
 retry:
 	dentry = filename_create(dfd, name, &path, lookup_flags);
@@ -3948,12 +4022,15 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
 	if (IS_ERR(dentry))
 		goto out_putname;
 
-	mnt_userns = mnt_user_ns(path.mnt);
-	mode = vfs_prepare_mode(mnt_userns, path.dentry->d_inode, mode);
-	error = security_path_mkdir(&path, dentry, mode);
-	if (!error)
+	error = security_path_mkdir(&path, dentry,
+				    mode_strip_umask(d_inode(path.dentry), mode));
+	if (!error) {
+		struct user_namespace *mnt_userns;
+
+		mnt_userns = mnt_user_ns(path.mnt);
 		error = vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
 				  mode);
+	}
 
 	done_path_create(&path, dentry);
 	if (retry_estale(error, lookup_flags)) {
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 914c8f28bb02..98b44a2732f5 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3459,17 +3459,6 @@ static inline bool dir_relax_shared(struct inode *inode)
 	return !IS_DEADDIR(inode);
 }
 
-static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
-				   const struct inode *dir, umode_t mode)
-{
-	mode = mode_strip_sgid(mnt_userns, dir, mode);
-
-	if (!IS_POSIXACL(dir))
-		mode &= ~current_umask();
-
-	return mode;
-}
-
 extern bool path_noexec(const struct path *path);
 extern void inode_nohighmem(struct inode *inode);
 
-- 
2.32.0


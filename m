Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498BE5F46F6
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Oct 2022 17:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbiJDPw3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Oct 2022 11:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiJDPw1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Oct 2022 11:52:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 222BB4F66F;
        Tue,  4 Oct 2022 08:52:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4A5D614CC;
        Tue,  4 Oct 2022 15:52:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32AFBC433C1;
        Tue,  4 Oct 2022 15:52:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664898745;
        bh=C0o+u2iAWngWLKUKgDuplg4cdjFuGCGnabpJgxNqmvk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kHQk/TcPCP7C5LjqtM2oLnHkClmR2mdGqheMIuV+MFsa8ez0vXbhVud8bKLnSRnm/
         axmQ0zVyzPU0SJNCSbe2UO6YSwmAfGJ+Cg6EmPenZ1YUr0lDpZXI6WyHsuHOlpNryP
         HDp0N9SvixMjf6s5fuKpQIN9EBQfrT0DFqUmMFlDmavofkO4MS9QXcYB22mT7xBSRo
         qiAgxb7NgK3u7KYpknkD1Ag/YtYe/UNS1lpMEUNo8WYW/Vwy+++Sz4GeZm2GPqLr9N
         eCjfCQowlPLBaitn/XLM7wnZdZwM+szu1nKQ5UJPTAv3kNGT2oAykGMFMN8X6AnEmt
         f3DsyECXYtl9Q==
Date:   Tue, 4 Oct 2022 17:52:16 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] ovl: remove privs in ovl_fallocate()
Message-ID: <20221004155216.f3bzwbcwncl6jyq2@wittgenstein>
References: <20221003123040.900827-1-amir73il@gmail.com>
 <20221003123040.900827-3-amir73il@gmail.com>
 <20221004105932.bpvqstjrfpud5rcs@wittgenstein>
 <CAOQ4uxgXYTdUoE5MpG-UzdZUtVYQ1FpjTHEc8FjEQAmgqj0hyQ@mail.gmail.com>
 <20221004141259.72gdvmzm3jwxpsva@wittgenstein>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221004141259.72gdvmzm3jwxpsva@wittgenstein>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 04, 2022 at 04:13:05PM +0200, Christian Brauner wrote:
> On Tue, Oct 04, 2022 at 05:01:06PM +0300, Amir Goldstein wrote:
> > On Tue, Oct 4, 2022 at 1:59 PM Christian Brauner <brauner@kernel.org> wrote:
> > >
> > > On Mon, Oct 03, 2022 at 03:30:40PM +0300, Amir Goldstein wrote:
> > > > Underlying fs doesn't remove privs because fallocate is called with
> > > > privileged mounter credentials.
> > > >
> > > > This fixes some failure in fstests generic/683..687.
> > > >
> > > > Fixes: aab8848cee5e ("ovl: add ovl_fallocate()")
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > > ---
> > > >  fs/overlayfs/file.c | 12 +++++++++++-
> > > >  1 file changed, 11 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
> > > > index c8308da8909a..e90ac5376456 100644
> > > > --- a/fs/overlayfs/file.c
> > > > +++ b/fs/overlayfs/file.c
> > > > @@ -517,9 +517,16 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
> > > >       const struct cred *old_cred;
> > > >       int ret;
> > > >
> > > > +     inode_lock(inode);
> > > > +     /* Update mode */
> > > > +     ovl_copyattr(inode);
> > > > +     ret = file_remove_privs(file);
> > >
> > > First, thank you for picking this up!
> > >
> > > Let me analyze generic/683 failure of Test1 to see why you still see
> > > failures in this test:
> > >
> > > echo "Test 1 - qa_user, non-exec file $verb"
> > > setup_testfile
> > > chmod a+rws $junk_file
> > > commit_and_check "$qa_user" "$verb" 64k 64k
> > >
> > > So this creates a file with 6666 permissions. While the file has the
> > > S_ISUID and S_ISGID bits set it does not have the S_IXGRP set. This is
> > > important in a little bit.
> > >
> > > On a regular filesystem like xfs what will happen is:
> > >
> > > sys_fallocate()
> > > -> vfs_fallocate()
> > >    -> xfs_file_fallocate()
> > >       -> file_modified()
> > >          -> __file_remove_privs()
> > >             -> dentry_needs_remove_privs()
> > >                -> should_remove_suid()
> > >             -> __remove_privs()
> > >                newattrs.ia_valid = ATTR_FORCE | kill;
> > >                -> notify_change()
> > >
> > > In should_remove_suid() we can see that ATTR_KILL_SUID is raised
> > > unconditionally because the file in the test has S_ISUID set.
> > >
> > > But we also see that ATTR_KILL_SGID won't be set because while the file
> > > is S_ISGID it is not S_IXGRP (see above) which is a condition for
> > > ATTR_KILL_SGID being raised.
> > >
> > > So by the time we call notify_change() we have attr->ia_valid set to
> > > ATTR_KILL_SUID | ATTR_FORCE. Now notify_change() sees that
> > > ATTR_KILL_SUID is set and does:
> > >
> > > ia_valid = attr->ia_valid |= ATTR_MODE
> > > attr->ia_mode = (inode->i_mode & ~S_ISUID);
> > >
> > > which means that when we call setattr_copy() later we will definitely
> > > update inode->i_mode. Note that attr->ia_mode still contain S_ISGID.
> > >
> > > Now we call into the filesystem's ->setattr() inode operation which will end up
> > > calling setattr_copy(). Since ATTR_MODE is set we will hit:
> > >
> > > if (ia_valid & ATTR_MODE) {
> > >         umode_t mode = attr->ia_mode;
> > >         vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
> > >         if (!vfsgid_in_group_p(vfsgid) &&
> > >             !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> > >                 mode &= ~S_ISGID;
> > >         inode->i_mode = mode;
> > > }
> > >
> > 
> > Can you think of a reason why the above should not be done
> > in notify_change() before even calling to ->setattr()?
> > 
> > Although, it wouldn't help because ovl_setattr() does:
> > 
> >     if (attr->ia_valid & (ATTR_KILL_SUID|ATTR_KILL_SGID))
> >         attr->ia_valid &= ~ATTR_MODE;
> > 
> > > and since the caller in the test is neither capable nor in the group of the
> > > inode the S_ISGID bit is stripped.
> > >
> > > But now contrast this with overlayfs even after your changes. When
> > > ovl_setattr() is hit from ovl_fallocate()'s call to file_remove_privs()
> > > and calls ovl_do_notify_change() then we are doing this under the
> > > mounter's creds and so the S_ISGID bit is retained:
> > >
> > > sys_fallocate()
> > > -> vfs_fallocate()
> > >    -> ovl_fallocate()
> > >       -> file_remove_privs()
> > >          -> dentry_needs_remove_privs()
> > >             -> should_remove_suid()
> > >          -> __remove_privs()
> > >             newattrs.ia_valid = attr_force | kill;
> > >             -> notify_change()
> > >                -> ovl_setattr()
> > >                   // TAKE ON MOUNTER'S CREDS
> > >                   -> ovl_do_notify_change()
> > >                   // GIVE UP MOUNTER'S CREDS
> > >      // TAKE ON MOUNTER'S CREDS
> > >      -> vfs_fallocate()
> > >         -> xfs_file_fallocate()
> > >            -> file_modified()
> > >               -> __file_remove_privs()
> > >                  -> dentry_needs_remove_privs()
> > >                     -> should_remove_suid()
> > >                  -> __remove_privs()
> > >                     newattrs.ia_valid = attr_force | kill;
> > >                     -> notify_change()
> > 
> > The model in overlayfs is that security is checked twice
> > once on overlay inode with caller creds and once again
> > on xfs inode with mounter creds. Either of these checks
> > could result in clearing SUID/SGID bits.
> 
> Yep.
> 
> > 
> > In the call stack above, the outer should_remove_suid()
> > with caller creds sets ATTR_KILL_SUID and then the outer
> > notify_change() clears SUID and sets ATTR_MODE,
> 
> Yes.
> 
> > but ovl_setattr() clears ATTR_MODE and then the inner
> > notify_change() re-clears SUID and sets ATTR_MODE again.
> 
> Yes.
> 
> > 
> > If the outer notify_change() would have checked the in_group_p()
> > condition, clear SGID and set a flag ATTR_KILL_SGID_FORCE
> > then the inner notify_change() would see this flag and re-clear
> > SGID bit, just the same as it does with SUID bit in the stack stace
> > above.
> > 
> > Is this making any sense?
> 
> What I kept thinking was sm along the lines of:
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index ba1de23c13c1..e62a564201b7 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -1968,8 +1968,12 @@ int should_remove_suid(struct dentry *dentry)
>          * sgid without any exec bits is just a mandatory locking mark; leave
>          * it alone.  If some exec bits are set, it's a real sgid; kill it.
>          */
> -       if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
> -               kill |= ATTR_KILL_SGID;
> +       if (unlikely(mode & S_ISGID)) {
> +               if ((mode & S_IXGRP) ||
> +                   (!vfsgid_in_group_p(vfsgid) &&
> +                    !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID)))
> +                       kill |= ATTR_KILL_SGID;
> +       }
> 
>         if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
>                 return kill;
> 
> mandatory locks have been removed as well so that remark seems pointless
> as well?

My feeling here is that both should_remove_suid() and notify_change()
need to apply the same permission checks as setattr_prepare() and
setattr_copy() instead of all this special casing them. I don't see a
good reason to not require the same checks. So sm like (__completely
untested__):

From 922f9f123ab6531c29bf05585ef88c17fe65dba3 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 4 Oct 2022 16:13:34 +0200
Subject: [UNTESTED PATCH] attr: use consistent sgid stripping checks

Require the same permissions as setattr_prepare() and setattr_copy() have
instead of all these special cases. We can probably consolidate this even
more...

Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
---
 fs/attr.c          |  2 +-
 fs/fuse/file.c     |  2 +-
 fs/inode.c         | 41 ++++++++++++++++++++++++-----------------
 fs/internal.h      |  4 +++-
 fs/ocfs2/file.c    |  4 ++--
 fs/open.c          |  2 +-
 include/linux/fs.h |  2 +-
 7 files changed, 33 insertions(+), 24 deletions(-)

diff --git a/fs/attr.c b/fs/attr.c
index 1552a5f23d6b..9262c6b31c26 100644
--- a/fs/attr.c
+++ b/fs/attr.c
@@ -375,7 +375,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
 		}
 	}
 	if (ia_valid & ATTR_KILL_SGID) {
-		if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
+		if (should_remove_sgid(mnt_userns, dentry)) {
 			if (!(ia_valid & ATTR_MODE)) {
 				ia_valid = attr->ia_valid |= ATTR_MODE;
 				attr->ia_mode = inode->i_mode;
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 1a3afd469e3a..fccc2c7e88fd 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -1313,7 +1313,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
 			return err;
 
 		if (fc->handle_killpriv_v2 &&
-		    should_remove_suid(file_dentry(file))) {
+		    should_remove_suid(&init_user_ns, file_dentry(file))) {
 			goto writethrough;
 		}
 
diff --git a/fs/inode.c b/fs/inode.c
index ba1de23c13c1..c639aefe01c3 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1949,27 +1949,33 @@ void touch_atime(const struct path *path)
 }
 EXPORT_SYMBOL(touch_atime);
 
-/*
- * The logic we want is
- *
- *	if suid or (sgid and xgrp)
- *		remove privs
- */
-int should_remove_suid(struct dentry *dentry)
+bool should_remove_sgid(struct user_namespace *mnt_userns, struct dentry *dentry)
+{
+	struct inode *inode = d_inode(dentry);
+	umode_t mode = inode->i_mode;
+
+	if (unlikely(mode & S_ISGID)) {
+		if ((mode & S_IXGRP) ||
+		    (!vfsgid_in_group_p(i_gid_into_vfsgid(mnt_userns, inode)) &&
+		     !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID)))
+			return true;
+	}
+
+	return false;
+}
+
+int should_remove_suid(struct user_namespace *mnt_userns, struct dentry *dentry)
 {
-	umode_t mode = d_inode(dentry)->i_mode;
+	struct inode *inode = d_inode(dentry);
+	umode_t mode = inode->i_mode;
 	int kill = 0;
 
 	/* suid always must be killed */
 	if (unlikely(mode & S_ISUID))
 		kill = ATTR_KILL_SUID;
 
-	/*
-	 * sgid without any exec bits is just a mandatory locking mark; leave
-	 * it alone.  If some exec bits are set, it's a real sgid; kill it.
-	 */
-	if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
-		kill |= ATTR_KILL_SGID;
+	if (should_remove_sgid(mnt_userns, dentry))
+		kill = ATTR_KILL_SGID;
 
 	if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
 		return kill;
@@ -1983,7 +1989,8 @@ EXPORT_SYMBOL(should_remove_suid);
  * response to write or truncate. Return 0 if nothing has to be changed.
  * Negative value on error (change should be denied).
  */
-int dentry_needs_remove_privs(struct dentry *dentry)
+int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
+			      struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
 	int mask = 0;
@@ -1992,7 +1999,7 @@ int dentry_needs_remove_privs(struct dentry *dentry)
 	if (IS_NOSEC(inode))
 		return 0;
 
-	mask = should_remove_suid(dentry);
+	mask = should_remove_suid(mnt_userns, dentry);
 	ret = security_inode_need_killpriv(dentry);
 	if (ret < 0)
 		return ret;
@@ -2024,7 +2031,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
 	if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
 		return 0;
 
-	kill = dentry_needs_remove_privs(dentry);
+	kill = dentry_needs_remove_privs(file_mnt_user_ns(file), dentry);
 	if (kill < 0)
 		return kill;
 
diff --git a/fs/internal.h b/fs/internal.h
index 1e67b4b9a4d1..ae152ded227c 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -139,7 +139,8 @@ extern int vfs_open(const struct path *, struct file *);
  * inode.c
  */
 extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
-extern int dentry_needs_remove_privs(struct dentry *dentry);
+extern int dentry_needs_remove_privs(struct user_namespace *,
+				     struct dentry *dentry);
 
 /*
  * fs-writeback.c
@@ -226,3 +227,4 @@ int do_set_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 	       const char *acl_name, const void *kvalue, size_t size);
 ssize_t do_get_acl(struct user_namespace *mnt_userns, struct dentry *dentry,
 		   const char *acl_name, void *kvalue, size_t size);
+int should_remove_sgid(struct user_namespace *mnt_userns, struct dentry *dentry);
diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
index af900aaa9275..0a33096a3852 100644
--- a/fs/ocfs2/file.c
+++ b/fs/ocfs2/file.c
@@ -1991,7 +1991,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
 		}
 	}
 
-	if (file && should_remove_suid(file->f_path.dentry)) {
+	if (file && should_remove_suid(&init_user_ns, file->f_path.dentry)) {
 		ret = __ocfs2_write_remove_suid(inode, di_bh);
 		if (ret) {
 			mlog_errno(ret);
@@ -2279,7 +2279,7 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
 		 * inode. There's also the dinode i_size state which
 		 * can be lost via setattr during extending writes (we
 		 * set inode->i_size at the end of a write. */
-		if (should_remove_suid(dentry)) {
+		if (should_remove_suid(&init_user_ns, dentry)) {
 			if (meta_level == 0) {
 				ocfs2_inode_unlock_for_extent_tree(inode,
 								   &di_bh,
diff --git a/fs/open.c b/fs/open.c
index 8a813fa5ca56..ecb7b8a58275 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -54,7 +54,7 @@ int do_truncate(struct user_namespace *mnt_userns, struct dentry *dentry,
 	}
 
 	/* Remove suid, sgid, and file capabilities on truncate too */
-	ret = dentry_needs_remove_privs(dentry);
+	ret = dentry_needs_remove_privs(mnt_userns, dentry);
 	if (ret < 0)
 		return ret;
 	if (ret)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index badff81b9dde..58347514421e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -3092,7 +3092,7 @@ extern void __destroy_inode(struct inode *);
 extern struct inode *new_inode_pseudo(struct super_block *sb);
 extern struct inode *new_inode(struct super_block *sb);
 extern void free_inode_nonrcu(struct inode *inode);
-extern int should_remove_suid(struct dentry *);
+extern int should_remove_suid(struct user_namespace *, struct dentry *);
 extern int file_remove_privs(struct file *);
 
 /*
-- 
2.34.1


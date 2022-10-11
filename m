Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E525FAEC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Oct 2022 10:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbiJKI4u (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Oct 2022 04:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJKI4t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Oct 2022 04:56:49 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE5CC6D9DB;
        Tue, 11 Oct 2022 01:56:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4E172B811BF;
        Tue, 11 Oct 2022 08:56:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 091F7C433D6;
        Tue, 11 Oct 2022 08:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665478605;
        bh=OR+masIfDLTk+fUPpbZdxszMhWiazfkXl6SkRFoZyYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u7iL+atVu+TSp8fCtrpgPxb4nXo/h40gWAZmusPwfVd95rCjo7m3aZos4OzLkoMlF
         Rb74hsimlQzDqIgDoDWWI1dGIejFUcrAZp/HlzQUO9Ci4iisi7x4mXE1lILQMBJf3R
         GpRxNWNB7aptVzdIBr6kU3ggRdtZ9sNDd8s/qJYKmm0AG3IdOBKeTuKx5qDbgr0mCy
         AtP/EEYnqVxz5zoQADIpajHO58IZHg2+uD09tin+KqhYNJiv4ylUtR1yqgJRmcDGPW
         ZUPnSECAuLNao2ZoteqpZZqkvO+M4Pc4l55X7Ax6ji4GcXv40RU6TN95KKQc3i26qT
         MpSTImUGJp2Og==
Date:   Tue, 11 Oct 2022 10:56:34 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 3/5] attr: use consistent sgid stripping checks
Message-ID: <20221011085634.2qp2ragzcdzub6oq@wittgenstein>
References: <20221007140543.1039983-1-brauner@kernel.org>
 <20221007140543.1039983-4-brauner@kernel.org>
 <CAOQ4uxggKnsyi2DvVOCUQQ8hEZJjioing_H-M4y_Hq-wvRk0nA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAOQ4uxggKnsyi2DvVOCUQQ8hEZJjioing_H-M4y_Hq-wvRk0nA@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 11, 2022 at 11:43:22AM +0300, Amir Goldstein wrote:
> On Fri, Oct 7, 2022 at 5:06 PM Christian Brauner <brauner@kernel.org> wrote:
> >
> > Currently setgid stripping in file_remove_privs()'s should_remove_suid()
> > helper is inconsistent with other parts of the vfs. Specifically, it only
> > raises ATTR_KILL_SGID if the inode is S_ISGID and S_IXGRP but not if the
> > inode isn't in the caller's groups and the caller isn't privileged over the
> > inode although we require this already in setattr_prepare() and
> > setattr_copy() and so all filesystem implement this requirement implicitly
> > because they have to use setattr_{prepare,copy}() anyway.
> >
> > But the inconsistency shows up in setgid stripping bugs for overlayfs in
> > xfstests (e.g., generic/673, generic/683, generic/685, generic/686,
> > generic/687). For example, we test whether suid and setgid stripping works
> > correctly when performing various write-like operations as an unprivileged
> > user (fallocate, reflink, write, etc.):
> >
> > echo "Test 1 - qa_user, non-exec file $verb"
> > setup_testfile
> > chmod a+rws $junk_file
> > commit_and_check "$qa_user" "$verb" 64k 64k
> >
> > The test basically creates a file with 6666 permissions. While the file has
> > the S_ISUID and S_ISGID bits set it does not have the S_IXGRP set. On a
> > regular filesystem like xfs what will happen is:
> >
> > sys_fallocate()
> > -> vfs_fallocate()
> >    -> xfs_file_fallocate()
> >       -> file_modified()
> >          -> __file_remove_privs()
> >             -> dentry_needs_remove_privs()
> >                -> should_remove_suid()
> >             -> __remove_privs()
> >                newattrs.ia_valid = ATTR_FORCE | kill;
> >                -> notify_change()
> >                   -> setattr_copy()
> >
> > In should_remove_suid() we can see that ATTR_KILL_SUID is raised
> > unconditionally because the file in the test has S_ISUID set.
> >
> > But we also see that ATTR_KILL_SGID won't be set because while the file
> > is S_ISGID it is not S_IXGRP (see above) which is a condition for
> > ATTR_KILL_SGID being raised.
> >
> > So by the time we call notify_change() we have attr->ia_valid set to
> > ATTR_KILL_SUID | ATTR_FORCE. Now notify_change() sees that
> > ATTR_KILL_SUID is set and does:
> >
> > ia_valid = attr->ia_valid |= ATTR_MODE
> > attr->ia_mode = (inode->i_mode & ~S_ISUID);
> >
> > which means that when we call setattr_copy() later we will definitely
> > update inode->i_mode. Note that attr->ia_mode still contains S_ISGID.
> >
> > Now we call into the filesystem's ->setattr() inode operation which will
> > end up calling setattr_copy(). Since ATTR_MODE is set we will hit:
> >
> > if (ia_valid & ATTR_MODE) {
> >         umode_t mode = attr->ia_mode;
> >         vfsgid_t vfsgid = i_gid_into_vfsgid(mnt_userns, inode);
> >         if (!vfsgid_in_group_p(vfsgid) &&
> >             !capable_wrt_inode_uidgid(mnt_userns, inode, CAP_FSETID))
> >                 mode &= ~S_ISGID;
> >         inode->i_mode = mode;
> > }
> >
> > and since the caller in the test is neither capable nor in the group of the
> > inode the S_ISGID bit is stripped.
> >
> > But assume the file isn't suid then ATTR_KILL_SUID won't be raised which
> > has the consequence that neither the setgid nor the suid bits are stripped
> > even though it should be stripped because the inode isn't in the caller's
> > groups and the caller isn't privileged over the inode.
> >
> > If overlayfs is in the mix things become a bit more complicated and the bug
> > shows up more clearly. When e.g., ovl_setattr() is hit from
> > ovl_fallocate()'s call to file_remove_privs() then ATTR_KILL_SUID and
> > ATTR_KILL_SGID might be raised but because the check in notify_change() is
> > questioning the ATTR_KILL_SGID flag again by requiring S_IXGRP for it to be
> > stripped the S_ISGID bit isn't removed even though it should be stripped:
> >
> > sys_fallocate()
> > -> vfs_fallocate()
> >    -> ovl_fallocate()
> >       -> file_remove_privs()
> >          -> dentry_needs_remove_privs()
> >             -> should_remove_suid()
> >          -> __remove_privs()
> >             newattrs.ia_valid = ATTR_FORCE | kill;
> >             -> notify_change()
> >                -> ovl_setattr()
> >                   // TAKE ON MOUNTER'S CREDS
> >                   -> ovl_do_notify_change()
> >                      -> notify_change()
> >                   // GIVE UP MOUNTER'S CREDS
> >      // TAKE ON MOUNTER'S CREDS
> >      -> vfs_fallocate()
> >         -> xfs_file_fallocate()
> >            -> file_modified()
> >               -> __file_remove_privs()
> >                  -> dentry_needs_remove_privs()
> >                     -> should_remove_suid()
> >                  -> __remove_privs()
> >                     newattrs.ia_valid = attr_force | kill;
> >                     -> notify_change()
> >
> > The fix for all of this is to make file_remove_privs()'s
> > should_remove_suid() helper to perform the same checks as we already
> > require in setattr_prepare() and setattr_copy() and have notify_change()
> > not pointlessly requiring S_IXGRP again. It doesn't make any sense in the
> > first place because the caller must calculate the flags via
> > should_remove_suid() anyway which would raise ATTR_KILL_SGID.
> >
> > Running xfstests with this doesn't report any regressions. We should really
> > try and use consistent checks.
> >
> > Co-Developed-by: Amir Goldstein <amir73il@gmail.com>
> > Signed-off-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> > ---
> >
> > Notes:
> >     /* v2 */
> >     Amir Goldstein <amir73il@gmail.com>:
> >     - mention xfstests that failed prior to that
> >
> >     Christian Brauner <brauner@kernel.org>:
> >     - Use should_remove_sgid() in chown_common() just like we do in do_truncate().
> >
> >  fs/attr.c          |  2 +-
> >  fs/fuse/file.c     |  2 +-
> >  fs/inode.c         | 24 ++++++++----------------
> >  fs/internal.h      |  3 ++-
> >  fs/ocfs2/file.c    |  4 ++--
> >  fs/open.c          |  8 ++++----
> >  include/linux/fs.h |  2 +-
> >  7 files changed, 19 insertions(+), 26 deletions(-)
> >
> > diff --git a/fs/attr.c b/fs/attr.c
> > index d0bb1dae425e..888b34e8c268 100644
> > --- a/fs/attr.c
> > +++ b/fs/attr.c
> > @@ -421,7 +421,7 @@ int notify_change(struct user_namespace *mnt_userns, struct dentry *dentry,
> >                 }
> >         }
> >         if (ia_valid & ATTR_KILL_SGID) {
> > -               if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP)) {
> > +               if (mode & S_ISGID) {
> >                         if (!(ia_valid & ATTR_MODE)) {
> >                                 ia_valid = attr->ia_valid |= ATTR_MODE;
> >                                 attr->ia_mode = inode->i_mode;
> > diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> > index 1a3afd469e3a..fccc2c7e88fd 100644
> > --- a/fs/fuse/file.c
> > +++ b/fs/fuse/file.c
> > @@ -1313,7 +1313,7 @@ static ssize_t fuse_cache_write_iter(struct kiocb *iocb, struct iov_iter *from)
> >                         return err;
> >
> >                 if (fc->handle_killpriv_v2 &&
> > -                   should_remove_suid(file_dentry(file))) {
> > +                   should_remove_suid(&init_user_ns, file_dentry(file))) {
> >                         goto writethrough;
> >                 }
> >
> > diff --git a/fs/inode.c b/fs/inode.c
> > index ba1de23c13c1..092a66324c65 100644
> > --- a/fs/inode.c
> > +++ b/fs/inode.c
> > @@ -1949,26 +1949,17 @@ void touch_atime(const struct path *path)
> >  }
> >  EXPORT_SYMBOL(touch_atime);
> >
> > -/*
> > - * The logic we want is
> > - *
> > - *     if suid or (sgid and xgrp)
> > - *             remove privs
> > - */
> > -int should_remove_suid(struct dentry *dentry)
> > +int should_remove_suid(struct user_namespace *mnt_userns, struct dentry *dentry)
> >  {
> > -       umode_t mode = d_inode(dentry)->i_mode;
> > +       struct inode *inode = d_inode(dentry);
> > +       umode_t mode = inode->i_mode;
> >         int kill = 0;
> >
> >         /* suid always must be killed */
> >         if (unlikely(mode & S_ISUID))
> >                 kill = ATTR_KILL_SUID;
> >
> > -       /*
> > -        * sgid without any exec bits is just a mandatory locking mark; leave
> > -        * it alone.  If some exec bits are set, it's a real sgid; kill it.
> > -        */
> > -       if (unlikely((mode & S_ISGID) && (mode & S_IXGRP)))
> > +       if (unlikely(should_remove_sgid(mnt_userns, inode)))
> >                 kill |= ATTR_KILL_SGID;
> 
>    kill |= should_remove_sgid(mnt_userns, inode);
> 
> >
> >         if (unlikely(kill && !capable(CAP_FSETID) && S_ISREG(mode)))
> > @@ -1983,7 +1974,8 @@ EXPORT_SYMBOL(should_remove_suid);
> >   * response to write or truncate. Return 0 if nothing has to be changed.
> >   * Negative value on error (change should be denied).
> >   */
> > -int dentry_needs_remove_privs(struct dentry *dentry)
> > +int dentry_needs_remove_privs(struct user_namespace *mnt_userns,
> > +                             struct dentry *dentry)
> >  {
> >         struct inode *inode = d_inode(dentry);
> >         int mask = 0;
> > @@ -1992,7 +1984,7 @@ int dentry_needs_remove_privs(struct dentry *dentry)
> >         if (IS_NOSEC(inode))
> >                 return 0;
> >
> > -       mask = should_remove_suid(dentry);
> > +       mask = should_remove_suid(mnt_userns, dentry);
> >         ret = security_inode_need_killpriv(dentry);
> >         if (ret < 0)
> >                 return ret;
> > @@ -2024,7 +2016,7 @@ static int __file_remove_privs(struct file *file, unsigned int flags)
> >         if (IS_NOSEC(inode) || !S_ISREG(inode->i_mode))
> >                 return 0;
> >
> > -       kill = dentry_needs_remove_privs(dentry);
> > +       kill = dentry_needs_remove_privs(file_mnt_user_ns(file), dentry);
> >         if (kill < 0)
> >                 return kill;
> >
> > diff --git a/fs/internal.h b/fs/internal.h
> > index 9d165ab65a2a..b46881b7f8a0 100644
> > --- a/fs/internal.h
> > +++ b/fs/internal.h
> > @@ -139,7 +139,8 @@ extern int vfs_open(const struct path *, struct file *);
> >   * inode.c
> >   */
> >  extern long prune_icache_sb(struct super_block *sb, struct shrink_control *sc);
> > -extern int dentry_needs_remove_privs(struct dentry *dentry);
> > +extern int dentry_needs_remove_privs(struct user_namespace *,
> > +                                    struct dentry *dentry);
> >
> >  /*
> >   * fs-writeback.c
> > diff --git a/fs/ocfs2/file.c b/fs/ocfs2/file.c
> > index 9c67edd215d5..e421491783c3 100644
> > --- a/fs/ocfs2/file.c
> > +++ b/fs/ocfs2/file.c
> > @@ -1991,7 +1991,7 @@ static int __ocfs2_change_file_space(struct file *file, struct inode *inode,
> >                 }
> >         }
> >
> > -       if (file && should_remove_suid(file->f_path.dentry)) {
> > +       if (file && should_remove_suid(&init_user_ns, file->f_path.dentry)) {
> >                 ret = __ocfs2_write_remove_suid(inode, di_bh);
> >                 if (ret) {
> >                         mlog_errno(ret);
> > @@ -2279,7 +2279,7 @@ static int ocfs2_prepare_inode_for_write(struct file *file,
> >                  * inode. There's also the dinode i_size state which
> >                  * can be lost via setattr during extending writes (we
> >                  * set inode->i_size at the end of a write. */
> > -               if (should_remove_suid(dentry)) {
> > +               if (should_remove_suid(&init_user_ns, dentry)) {
> >                         if (meta_level == 0) {
> >                                 ocfs2_inode_unlock_for_extent_tree(inode,
> >                                                                    &di_bh,
> > diff --git a/fs/open.c b/fs/open.c
> > index 8a813fa5ca56..d955ecef758f 100644
> > --- a/fs/open.c
> > +++ b/fs/open.c
> > @@ -54,7 +54,7 @@ int do_truncate(struct user_namespace *mnt_userns, struct dentry *dentry,
> >         }
> >
> >         /* Remove suid, sgid, and file capabilities on truncate too */
> > -       ret = dentry_needs_remove_privs(dentry);
> > +       ret = dentry_needs_remove_privs(mnt_userns, dentry);
> >         if (ret < 0)
> >                 return ret;
> >         if (ret)
> > @@ -721,10 +721,10 @@ int chown_common(const struct path *path, uid_t user, gid_t group)
> >                 return -EINVAL;
> >         if ((group != (gid_t)-1) && !setattr_vfsgid(&newattrs, gid))
> >                 return -EINVAL;
> > -       if (!S_ISDIR(inode->i_mode))
> > -               newattrs.ia_valid |=
> > -                       ATTR_KILL_SUID | ATTR_KILL_SGID | ATTR_KILL_PRIV;
> >         inode_lock(inode);
> > +       if (!S_ISDIR(inode->i_mode))
> > +               newattrs.ia_valid |= ATTR_KILL_SUID | ATTR_KILL_PRIV |
> > +                                    should_remove_sgid(mnt_userns, inode);
> 
> This is making me stop and wonder:
> 1. This has !S_ISDIR, should_remove_suid() has S_ISREG and
>     setattr_drop_sgid() has neither - is this consistent?

I thought about that. It'very likely redundant since we deal with that
in other parts but I need to verify all callers before we can remove
that.

> 2. SUID and PRIV are removed unconditionally and SGID is
>     removed conditionally - this is not a change of behavior
>     (at least for non-overlayfs), but is it desired???

It looks that way but it isn't. The setgid bit was only killed
unconditionally for S_IXGRP. We continue to do that. But it was always
removed conditionally for ~S_IXGRP. The difference between this patchset
and earlier is that it was done in settattr_prepare() or setattr_copy()
before this change.

IOW, we raised ATTR_KILL_SGID unconditionally but then only
conditionally obeyed it in setattr_{prepare,copy}() whereas now we
conditionally raise ATTR_KILL_SGID. That's surely a slight change but it
just means that we don't cause bugs for filesystems that roll their own
prepare or copy helpers and is just nicer overall.

> 
> Those questions could be dealt with in future patches if at all.

Yes, I think we're not past cleaning this up but moving slowly here
can't hurt tbh.

> 
> The change itself looks legit and solves a real problem, so you may add:
> 
> Reviewed-by: Amir Goldstein <amir73il@gmail.com>
> 
> Instead of Co-Developed-by ;-)

Well, you did suggest the notify_change() bit.
But I'll take the RVB. ;)
Thank you!

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8587150B45B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Apr 2022 11:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377723AbiDVJum (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Apr 2022 05:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiDVJuk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Apr 2022 05:50:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 876BBDFBB;
        Fri, 22 Apr 2022 02:47:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 130F461DFE;
        Fri, 22 Apr 2022 09:47:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E016C385A0;
        Fri, 22 Apr 2022 09:47:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650620866;
        bh=pTN/NAn+ojNn54Nj82sYtilI8xRWO5S36Nq+KRy25ME=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m6sjJYMHKlsBlz1LePkzClkriKDJ9OeaQiPCgp+JLMTBagmxMV2Ry7sSFT/2LPBIV
         Mc7rsO+Y2HGreDJ6R90xCI2SX3SwAXqITwiE5uYi+AonVhCLQtUab+wgtngHmj/Uh8
         B+em9HhWOG6XHp3oQHIVgrRiwZYoI6Vi1NpMmkl/WC1ovZ7onHdEGclANGYLbl8wXC
         QiurHtZkVRU1sRvKm5neQJLb1t/GsWh55+s+S5k8bLfUGZITsqm7yvNQxn1UdfbxYM
         MfJjsyg36dTam9LEbWAZvuwWOakuJH8ZFcm852KGXlbEhB6NbT3zkg0MWZQ+/XqzuN
         kWZH2+H7NuquA==
Date:   Fri, 22 Apr 2022 11:47:40 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Cc:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v5 3/4] fs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Message-ID: <20220422094740.4d4wcx5fv4zkwcc2@wittgenstein>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650527658-2218-3-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220421083507.siunu6ohyba6peyq@wittgenstein>
 <6262537C.9020908@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6262537C.9020908@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 22, 2022 at 06:03:09AM +0000, xuyang2018.jy@fujitsu.com wrote:
> on 2022/4/21 16:35, Christian Brauner wrote:
> > On Thu, Apr 21, 2022 at 03:54:17PM +0800, Yang Xu wrote:
> >> Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
> >> to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> >> firstly, then posxi acl setup, but xfs uses the contrary order. It will
> >> affect S_ISGID clear especially we filter S_IXGRP by umask or acl.
> >>
> >> Regardless of which filesystem is in use, failure to strip the SGID correctly
> >> is considered a security failure that needs to be fixed. The current VFS
> >> infrastructure requires the filesystem to do everything right and not step on
> >> any landmines to strip the SGID bit, when in fact it can easily be done at the
> >> VFS and the filesystems then don't even need to be aware that the SGID needs
> >> to be (or has been stripped) by the operation the user asked to be done.
> >>
> >> Vfs has all the info it needs - it doesn't need the filesystems to do everything
> >> correctly with the mode and ensuring that they order things like posix acl setup
> >> functions correctly with inode_init_owner() to strip the SGID bit.
> >>
> >> Just strip the SGID bit at the VFS, and then the filesystem can't get it wrong.
> >>
> >> Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
> >> this api may change mode.
> >>
> >> Only the following places use inode_init_owner
> >> "
> >> arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
> >> arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
> >> fs/9p/vfs_inode.c:      inode_init_owner(&init_user_ns, inode, NULL, mode);
> >> fs/bfs/dir.c:   inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
> >> fs/btrfs/tests/btrfs-tests.c:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
> >> fs/ext2/ialloc.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/ext4/ialloc.c:               inode_init_owner(mnt_userns, inode, dir, mode);
> >> fs/f2fs/namei.c:        inode_init_owner(mnt_userns, inode, dir, mode);
> >> fs/hfsplus/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/hugetlbfs/inode.c:           inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/jfs/jfs_inode.c:     inode_init_owner(&init_user_ns, inode, parent, mode);
> >> fs/minix/bitmap.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/nilfs2/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/ntfs3/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
> >> fs/ocfs2/dlmfs/dlmfs.c:         inode_init_owner(&init_user_ns, inode, NULL, mode);
> >> fs/ocfs2/dlmfs/dlmfs.c: inode_init_owner(&init_user_ns, inode, parent, mode);
> >> fs/ocfs2/namei.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/omfs/inode.c:        inode_init_owner(&init_user_ns, inode, NULL, mode);
> >> fs/overlayfs/dir.c:     inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
> >> fs/ramfs/inode.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/reiserfs/namei.c:    inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/sysv/ialloc.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/ubifs/dir.c: inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/udf/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/ufs/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
> >> fs/xfs/xfs_inode.c:             inode_init_owner(mnt_userns, inode, dir, mode);
> >> fs/zonefs/super.c:      inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
> >> kernel/bpf/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
> >> mm/shmem.c:             inode_init_owner(&init_user_ns, inode, dir, mode);
> >> "
> >>
> >> They are used in filesystem to init new inode function and these init inode
> >> functions are used by following operations:
> >> mkdir
> >> symlink
> >> mknod
> >> create
> >> tmpfile
> >> rename
> >>
> >> We don't care about mkdir because we don't strip SGID bit for directory except
> >> fs.xfs.irix_sgid_inherit. But we even call prepare_mode() in do_mkdirat() since
> >> inode_sgid_strip() will skip directories anyway. This will enforce the same
> >> ordering for all relevant operations and it will make the code more uniform and
> >> easier to understand by using new helper prepare_mode().
> >>
> >> symlink and rename only use valid mode that doesn't have SGID bit.
> >>
> >> We have added inode_sgid_strip api for the remaining operations.
> >>
> >> In addition to the above six operations, four filesystems has a little difference
> >> 1) btrfs has btrfs_create_subvol_root to create new inode but used non SGID bit
> >>     mode and can ignore
> >> 2) ocfs2 reflink function should add inode_sgid_strip api manually because we
> >>     don't add it in vfs
> >> 3) spufs which doesn't really go hrough the regular VFS callpath because it has
> >>     separate system call spu_create, but it t only allows the creation of
> >>     directories and only allows bits in 0777 and can ignore
> >> 4) bpf use vfs_mkobj in bpf_obj_do_pin with
> >>     "S_IFREG | ((S_IRUSR | S_IWUSR)&  ~current_umask()) mode and
> >>     use bpf_mkobj_ops in bpf_iter_link_pin_kernel with S_IFREG | S_IRUSR mode,
> >>     so bpf is also not affected
> >>
> >> This patch also changed grpid behaviour for ext4/xfs because the mode passed to
> >> them may been changed by inode_sgid_strip.
> >>
> >> Also as Christian Brauner said"
> >> The patch itself is useful as it would move a security sensitive operation that is
> >> currently burried in individual filesystems into the vfs layer. But it has a decent
> >> regression  potential since it might strip filesystems that have so far relied on
> >> getting the S_ISGID bit with a mode argument. So this needs a lot of testing and
> >> long exposure in -next for at least one full kernel cycle."
> >>
> >> Suggested-by: Dave Chinner<david@fromorbit.com>
> >> Signed-off-by: Yang Xu<xuyang2018.jy@fujitsu.com>
> >> ---
> >> v4->v5:
> >> put inode_sgid_strip before the inode_init_owner in ocfs2 filesystem
> >> because the inode->i_mode's assignment is in inode_init_owner
> >>   fs/inode.c         |  2 --
> >>   fs/namei.c         | 22 +++++++++-------------
> >>   fs/ocfs2/namei.c   |  1 +
> >>   include/linux/fs.h | 11 +++++++++++
> >>   4 files changed, 21 insertions(+), 15 deletions(-)
> >>
> >> diff --git a/fs/inode.c b/fs/inode.c
> >> index 57130e4ef8b4..95667e634bd4 100644
> >> --- a/fs/inode.c
> >> +++ b/fs/inode.c
> >> @@ -2246,8 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
> >>   		/* Directories are special, and always inherit S_ISGID */
> >>   		if (S_ISDIR(mode))
> >>   			mode |= S_ISGID;
> >> -		else
> >> -			mode = inode_sgid_strip(mnt_userns, dir, mode);
> >>   	} else
> >>   		inode_fsgid_set(inode, mnt_userns);
> >>   	inode->i_mode = mode;
> >> diff --git a/fs/namei.c b/fs/namei.c
> >> index 73646e28fae0..5b8e6288d503 100644
> >> --- a/fs/namei.c
> >> +++ b/fs/namei.c
> >> @@ -3287,8 +3287,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
> >>   	if (open_flag&  O_CREAT) {
> >>   		if (open_flag&  O_EXCL)
> >>   			open_flag&= ~O_TRUNC;
> >> -		if (!IS_POSIXACL(dir->d_inode))
> >> -			mode&= ~current_umask();
> >> +		mode = prepare_mode(mnt_userns, dir->d_inode, mode);
> >>   		if (likely(got_write))
> >>   			create_error = may_o_create(mnt_userns,&nd->path,
> >>   						    dentry, mode);
> >> @@ -3521,8 +3520,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
> >>   	child = d_alloc(dentry,&slash_name);
> >>   	if (unlikely(!child))
> >>   		goto out_err;
> >> -	if (!IS_POSIXACL(dir))
> >> -		mode&= ~current_umask();
> >> +	mode = prepare_mode(mnt_userns, dir, mode);
> >>   	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
> >>   	if (error)
> >>   		goto out_err;
> >> @@ -3850,13 +3848,12 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
> >>   	if (IS_ERR(dentry))
> >>   		goto out1;
> >>
> >> -	if (!IS_POSIXACL(path.dentry->d_inode))
> >> -		mode&= ~current_umask();
> >> +	mnt_userns = mnt_user_ns(path.mnt);
> >> +	mode = prepare_mode(mnt_userns, path.dentry->d_inode, mode);
> >>   	error = security_path_mknod(&path, dentry, mode, dev);
> >>   	if (error)
> >>   		goto out2;
> >>
> >> -	mnt_userns = mnt_user_ns(path.mnt);
> >>   	switch (mode&  S_IFMT) {
> >>   		case 0: case S_IFREG:
> >>   			error = vfs_create(mnt_userns, path.dentry->d_inode,
> >> @@ -3943,6 +3940,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
> >>   	struct path path;
> >>   	int error;
> >>   	unsigned int lookup_flags = LOOKUP_DIRECTORY;
> >> +	struct user_namespace *mnt_userns;
> >>
> >>   retry:
> >>   	dentry = filename_create(dfd, name,&path, lookup_flags);
> >> @@ -3950,15 +3948,13 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
> >>   	if (IS_ERR(dentry))
> >>   		goto out_putname;
> >>
> >> -	if (!IS_POSIXACL(path.dentry->d_inode))
> >> -		mode&= ~current_umask();
> >> +	mnt_userns = mnt_user_ns(path.mnt);
> >> +	mode = prepare_mode(mnt_userns, path.dentry->d_inode, mode);
> >>   	error = security_path_mkdir(&path, dentry, mode);
> >> -	if (!error) {
> >> -		struct user_namespace *mnt_userns;
> >> -		mnt_userns = mnt_user_ns(path.mnt);
> >> +	if (!error)
> >>   		error = vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
> >>   				  mode);
> >> -	}
> >> +
> >>   	done_path_create(&path, dentry);
> >>   	if (retry_estale(error, lookup_flags)) {
> >>   		lookup_flags |= LOOKUP_REVAL;
> >> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> >> index c75fd54b9185..21f3da2e66c9 100644
> >> --- a/fs/ocfs2/namei.c
> >> +++ b/fs/ocfs2/namei.c
> >> @@ -197,6 +197,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
> >>   	 * callers. */
> >>   	if (S_ISDIR(mode))
> >>   		set_nlink(inode, 2);
> >> +	mode = inode_sgid_strip(&init_user_ns, dir, mode);
> >>   	inode_init_owner(&init_user_ns, inode, dir, mode);
> >
> > For the record, I'm not too fond of this separate invocation of
> > inode_sgid_strip() but since it's only one location this might be fine.
> > If there's more than one location a separate helper should exist for
> > this that abstracts this away for the filesystem.
> Agree. This case only be found when using OCFS2_IOC_REFLINK ioctl. And 

(I have one very minor non-technical ask: can you please make sure to
leave an empty line between the text you're citing and your reply? It
would make reading your replies a lot easier. :))

> other support reflink filesystem(xfs, btrfs) they use  FICLONE or 
> FICLONERANGE ioctl.
> 
> Since ocfs2 has supported reflink by using it remap_file_range, should 
> we still need this ioctl?
> 
> commit bd50873dc725a9fa72592ecc986c58805e823051
> Author: Tao Ma <tao.ma@oracle.com>
> Date:   Mon Sep 21 11:25:14 2009 +0800
> 
>      ocfs2: Add ioctl for reflink.
> 
>      The ioctl will take 3 parameters: old_path, new_path and
>      preserve and call vfs_reflink. It is useful when we backport
>      reflink features to old kernels.
> 
>      Signed-off-by: Tao Ma <tao.ma@oracle.com>
> 
> Of course, this is a problem doesn't belong to this series.
> 
> >
> > Two questions:
> > - Sould this call prepare_mode(), i.e. should we honor umasks here too?
> IMO, it desn't need to honor umask. Because reflink only will update 
> inode_imode by setattr to strip S_ISGID and S_ISUID instead of creating 
> a file.

I had a misconception here because I got confused by ocfs2.
While the OCFS2_IOC_REFLINK ioctl creates the target file itself and the
reflink the FICLONE and FICLONERANGE _only_ create the reflink.

So the target file itself must've been created prior to
FICLONE/FICLONERANGE which means basic setgid stripping should've been
done when the file was created.

Since ocfs2 reflink callpaths work very differently we can't switch it
to FICLONE/FICLONERANGE as this would regress ocfs2 users.

> > - How is the sgid bit handled when creating reflinks on other reflink
> >    supporting filesystems such as xfs and btrfs?
> xfstests has a test case generic/673 for this, so btrfs and xfs should 
> have the same behavior.
> I look into xfs code.
> 
> Firstly
> 
> If we don't have CAP_FSETID and it is a regulre file,also have sgid bit, 
> then should_remove_suid will give attr a ATTR_KILL_SGID mask.

What you're referring to below is privilege stripping when _modifying
the content_ of set{g,u}id binaries.

That happens e.g. during write() or indeed a reflink creation via
FICLONE/FICLONERANGE. For the latter privilege stripping happens when
only some extents are reflinked and not the whole file. So that's:

* ioctl_file_clone()
  * vfs_clone_file_range()
    * do_clone_file_range()
      * generic_file_rw_checks()
      * remap_verify_area()
        * security_file_permission()
      * ->remap_file_range() [1]

[1]:
btrfs:
* btrfs_remap_file_range()
  * generic_remap_file_range_prep()
    * file_modified() // privilege stripping

ocfs2:
* ocfs2_remap_file_range()
  * generic_remap_file_range_prep()
    * file_modified() // privilege stripping

xfs:
* xfs_remap_file_range()
  * generic_remap_file_range_prep()
    * file_modified() // privilege stripping

// This is stacked, i.e. ovl filesystems will rely on the filesystem
// used for the upper mount and it's .remap_file_range() implementation.
overlayfs:
* ovl_remap_file_range()
  * vfs_clone_file_range()

The other two implementers are:

cifs:
* cifs_remap_file_range()

nfs:
* nfs42_remap_file_range()

both of which don't call into generic_remap_file_range_prep() and so
file_modified() isn't called. But they are netfses and there's a server
involved. In general, this isn't really a concern for this patchset.
(But something to potentially to look into in the future.)

And it wasn't what I was worried about.

The crucial information that we needed was whether reflink callpaths
other than ocfs2 create files themselves and therefore might rely
implicitly on setgid stripping in inode_init_owner().

Now that we looked at all callers we can be confident that this isn't
the case. _Apart from ocfs2_ but which you handle in the patchset.

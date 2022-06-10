Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A42455466E9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jun 2022 14:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345924AbiFJMyD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jun 2022 08:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbiFJMyC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jun 2022 08:54:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3BDC50AC;
        Fri, 10 Jun 2022 05:54:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEB2560F54;
        Fri, 10 Jun 2022 12:54:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33DFFC34114;
        Fri, 10 Jun 2022 12:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654865640;
        bh=Vk1Xzsk9tawsunC9ERMki7Pf7wP6hGAUYO03mruKpoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tGTr0KRzXrECTM58cbpx/4cgTs3JUqmNtW3b5a1mBMtuaOfo9/bsoPuLMlEtAp8Sa
         qIK2K4vT5VnKhcucsQhIHNDxkZ1ZzKLVG53MHrrkerhuCi7GmZuazIQUumqWJ9aT2G
         q3zUtqK4Cfb/FIfCpDW/VtlRmoVTiFYliOFvWy67nu+x2PATu145zo2mggYtBAOsBy
         bd2ozsor8ee3sITWz8A0ZlfqQbjy8ggz5C06+X8UhMZwupLn4IW9cKRcvnmMunKAuS
         PGa8LtIKQ2Rg3CUNhdnvdJdJAImo1gn6N054mxTdCjWwKiJxiWUoWKBKRV3eq6s9i7
         e4a6jQmKb4oAg==
Date:   Fri, 10 Jun 2022 14:53:55 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        willy@infradead.org, jlayton@kernel.org
Subject: Re: [PATCH v9 3/4] fs: move S_ISGID stripping into the vfs
Message-ID: <20220610125355.r27nwi3jtipyo4ao@wittgenstein>
References: <1653063037-2461-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1653063037-2461-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1653063037-2461-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 21, 2022 at 12:10:36AM +0800, Yang Xu wrote:
> Creating files that have both the S_IXGRP and S_ISGID bit raised in
> directories that themselves have the S_ISGID bit set requires additional
> privileges to avoid security issues.
> 
> When a filesystem creates a new inode it needs to take care that the
> caller is either in the group of the newly created inode or they have
> CAP_FSETID in their current user namespace and are privileged over the
> parent directory of the new inode. If any of these two conditions is
> true then the S_ISGID bit can be raised for an S_IXGRP file and if not
> it needs to be stripped.
> 
> However, there are several key issues with the current state of things:
> 
> * The S_ISGID stripping logic is entangled with umask stripping.
> 
>   If a filesystem doesn't support or enable POSIX ACLs then umask
>   stripping is done directly in the vfs before calling into the
>   filesystem.
>   If the filesystem does support POSIX ACLs then unmask stripping may be
>   done in the filesystem itself when calling posix_acl_create().
> 
> * Filesystems that don't rely on inode_init_owner() don't get S_ISGID
>   stripping logic.
> 
>   While that may be intentional (e.g. network filesystems might just
>   defer setgid stripping to a server) it is often just a security issue.
> 
> * The first two points taken together mean that there's a
>   non-standardized ordering between setgid stripping in
>   inode_init_owner() and posix_acl_create() both on the vfs level and
>   the filesystem level. The latter part is especially problematic since
>   each filesystem is technically free to order inode_init_owner() and
>   posix_acl_create() however it sees fit meaning that S_ISGID
>   inheritance might or might not be applied.
> 
> * We do still have bugs in this areas years after the initial round of
>   setgid bugfixes.
> 
> So the current state is quite messy and while we won't be able to make
> it completely clean as posix_acl_create() is still a filesystem specific
> call we can improve the S_SIGD stripping situation quite a bit by
> hoisting it out of inode_init_owner() and into the vfs creation
> operations. This means we alleviate the burden for filesystems to handle
> S_ISGID stripping correctly and can standardize the ordering between
> S_ISGID and umask stripping in the vfs.
> 
> The S_ISGID bit is stripped before any umask is applied. This has the
> advantage that the ordering is unaffected by whether umask stripping is
> done by the vfs itself (if no POSIX ACLs are supported or enabled) or in
> the filesystem in posix_acl_create() (if POSIX ACLs are supported).
> 
> To this end a new helper vfs_prepare_mode() is added which calls the
> previously added mode_strip_setgid() helper and strips the umask
> afterwards.
> 
> All inode operations that create new filesystem objects have been
> updated to call vfs_prepare_mode() before passing the mode into the
> relevant inode operation of the filesystems. Care has been taken to
> ensure that the mode passed to the security hooks is the mode that is
> seen by the filesystem.
> 
> Moving S_ISGID stripping from filesystem callpaths into the vfs callpaths
> means thatfilesystems that call vfs_*() helpers directly can't rely on
> S_ISGID stripping being done in vfs_*() helpers anymore unless they pass the
> mode on from a prior run through the vfs.
> 
> This mostly affects overlayfs which calls vfs_*() functions directly. So
> a typical overlayfs callstack would be
> sys_mknod()
> -> do_mknodat(mode) // calls vfs_prepare_mode()
>    -> .mknod = ovl_mknod(mode)
>       -> ovl_create(mode)
>          -> vfs_mknod(mode)
> 
> But it is safe as overlayfs passes on the mode on from its own run
> through the vfs and then via vfs_*() to the underlying filesystem.
> 
> Following is an overview of the filesystem specific and inode operations
> specific implications:
> 
> arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
> arch/powerpc/platforms/cell/spufs/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode | S_IFDIR);
> fs/9p/vfs_inode.c:      inode_init_owner(&init_user_ns, inode, NULL, mode);
> fs/bfs/dir.c:   inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/btrfs/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
> fs/btrfs/tests/btrfs-tests.c:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
> fs/ext2/ialloc.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/ext4/ialloc.c:               inode_init_owner(mnt_userns, inode, dir, mode);
> fs/f2fs/namei.c:        inode_init_owner(mnt_userns, inode, dir, mode);
> fs/hfsplus/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/hugetlbfs/inode.c:           inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/jfs/jfs_inode.c:     inode_init_owner(&init_user_ns, inode, parent, mode);
> fs/minix/bitmap.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/nilfs2/inode.c:      inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/ntfs3/inode.c:       inode_init_owner(mnt_userns, inode, dir, mode);
> fs/ocfs2/dlmfs/dlmfs.c:         inode_init_owner(&init_user_ns, inode, NULL, mode);
> fs/ocfs2/dlmfs/dlmfs.c: inode_init_owner(&init_user_ns, inode, parent, mode);
> fs/ocfs2/namei.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/omfs/inode.c:        inode_init_owner(&init_user_ns, inode, NULL, mode);
> fs/overlayfs/dir.c:     inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
> fs/ramfs/inode.c:               inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/reiserfs/namei.c:    inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/sysv/ialloc.c:       inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/ubifs/dir.c: inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/udf/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/ufs/ialloc.c:        inode_init_owner(&init_user_ns, inode, dir, mode);
> fs/xfs/xfs_inode.c:             inode_init_owner(mnt_userns, inode, dir, mode);
> fs/zonefs/super.c:      inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
> kernel/bpf/inode.c:     inode_init_owner(&init_user_ns, inode, dir, mode);
> mm/shmem.c:             inode_init_owner(&init_user_ns, inode, dir, mode);
> 
> All of the above filesystems end up calling inode_init_owner() when new
> filesystem objects are created through the following ->mkdir(),
> ->symlink(), ->mknod(), ->create(), ->tmpfile(), ->rename() inode
> operations.
> 
> Since directories always inherit the S_ISGID bit with the exception of
> xfs when irix_sgid_inherit mode is turned on S_ISGID stripping doesn't
> apply. The ->symlink() inode operation trivially inherit the mode from
> the target and the ->rename() inode operation inherits the mode from the
> source inode.
> 
> All other inode operations will have the S_ISGID bit stripped once in
> vfs_prepare_mode() before.
> 
> In addition to this there are filesystems which allow the creation of
> filesystem objects through ioctl()s or - in the case of spufs -
> circumventing the vfs in other ways. If filesystem objects are created
> through ioctl()s the vfs doesn't know about it and can't apply regular
> permission checking including S_ISGID logic. Therfore, a filesystem
> relying on S_ISGID stripping in inode_init_owner() in their ioctl()
> callpath will be affected by moving this logic into the vfs.
> 
> So we did our best to audit all filesystems in this regard:
> 
> * btrfs allows the creation of filesystem objects through various
>   ioctls(). Snapshot creation literally takes a snapshot and so the mode
>   is fully preserved and S_ISGID stripping doesn't apply.
> 
>   Creating a new subvolum relies on inode_init_owner() in
>   btrfs_new_inode() but only creates directories and doesn't raise
>   S_ISGID.
> 
> * ocfs2 has a peculiar implementation of reflinks. In contrast to e.g.
>   xfs and btrfs FICLONE/FICLONERANGE ioctl() that is only concerned with
>   the actual extents ocfs2 uses a separate ioctl() that also creates the
>   target file.
> 
>   Iow, ocfs2 circumvents the vfs entirely here and did indeed rely on
>   inode_init_owner() to strip the S_ISGID bit. This is the only place
>   where a filesystem needs to call mode_strip_sgid() directly but this
>   is self-inflicted pain tbh.
> 
> * spufs doesn't go through the vfs at all and doesn't use ioctl()s
>   either. Instead it has a dedicated system call spufs_create() which
>   allows the creation of filesystem objects. But spufs only creates
>   directories and doesn't allo S_SIGID bits, i.e. it specifically only
>   allows 0777 bits.
> 
> * bpf uses vfs_mkobj() but also doesn't allow S_ISGID bits to be created.
> 
> This patch also changed grpid behaviour for ext4/xfs because the mode
> passed to them may have been changed by vfs_prepare_mode.
> 
> While we did our best to audit everything there's a risk of regressions
> in here. However, for the sake of maintenance and given that we've seen
> a range of bugs years after S_ISGID inheritance issues were fixed (see
> [1]-[3]) the risk seems worth taking. In the worst case we will have to
> revert.
> 
> Associated with this change is a new set of fstests to enforce the
> semantics for all new filesystems.
> 
> Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes") [1]
> Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [2]
> Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [3]
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> v8->v9:
> 1.move vfs_prepare_mode info fs/namei.c
> 2. add grpid behaviour change in commit message
> 3. also mention the overflay in commit meessage because it will use call vfs_mknod directly
>  fs/inode.c       |  2 --
>  fs/namei.c       | 33 ++++++++++++++++++++-------------
>  fs/ocfs2/namei.c |  1 +
>  3 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 37bd85981d38..42ecaf79aaaf 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2246,8 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  		/* Directories are special, and always inherit S_ISGID */
>  		if (S_ISDIR(mode))
>  			mode |= S_ISGID;
> -		else
> -			mode = mode_strip_sgid(mnt_userns, dir, mode);
>  	} else
>  		inode_fsgid_set(inode, mnt_userns);
>  	inode->i_mode = mode;
> diff --git a/fs/namei.c b/fs/namei.c
> index 73646e28fae0..8b60914861f5 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -2998,6 +2998,17 @@ void unlock_rename(struct dentry *p1, struct dentry *p2)
>  }
>  EXPORT_SYMBOL(unlock_rename);
>  
> +static inline umode_t vfs_prepare_mode(struct user_namespace *mnt_userns,
> +				       const struct inode *dir, umode_t mode)
> +{
> +	mode = mode_strip_sgid(mnt_userns, dir, mode);
> +
> +	if (!IS_POSIXACL(dir))
> +		mode &= ~current_umask();
> +
> +	return mode;
> +}
> +
>  /**
>   * vfs_create - create new file
>   * @mnt_userns:	user namespace of the mount the inode was found from
> @@ -3287,8 +3298,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &= ~O_TRUNC;
> -		if (!IS_POSIXACL(dir->d_inode))
> -			mode &= ~current_umask();
> +		mode = vfs_prepare_mode(mnt_userns, dir->d_inode, mode);
>  		if (likely(got_write))
>  			create_error = may_o_create(mnt_userns, &nd->path,
>  						    dentry, mode);
> @@ -3521,8 +3531,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
>  	child = d_alloc(dentry, &slash_name);
>  	if (unlikely(!child))
>  		goto out_err;
> -	if (!IS_POSIXACL(dir))
> -		mode &= ~current_umask();
> +	mode = vfs_prepare_mode(mnt_userns, dir, mode);
>  	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
>  	if (error)
>  		goto out_err;
> @@ -3850,13 +3859,12 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	if (IS_ERR(dentry))
>  		goto out1;
>  
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> -		mode &= ~current_umask();
> +	mnt_userns = mnt_user_ns(path.mnt);
> +	mode = vfs_prepare_mode(mnt_userns, path.dentry->d_inode, mode);

This needs to move into vfs_mknod() itself to allow overlayfs to
continue to rely on setgid stripping.
See the relevant part in the _draft_ patch in [1].

>  	error = security_path_mknod(&path, dentry, mode, dev);
>  	if (error)
>  		goto out2;
>  
> -	mnt_userns = mnt_user_ns(path.mnt);
>  	switch (mode & S_IFMT) {
>  		case 0: case S_IFREG:
>  			error = vfs_create(mnt_userns, path.dentry->d_inode,
> @@ -3943,6 +3951,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = LOOKUP_DIRECTORY;
> +	struct user_namespace *mnt_userns;
>  
>  retry:
>  	dentry = filename_create(dfd, name, &path, lookup_flags);
> @@ -3950,15 +3959,13 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  	if (IS_ERR(dentry))
>  		goto out_putname;
>  
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> -		mode &= ~current_umask();
> +	mnt_userns = mnt_user_ns(path.mnt);
> +	mode = vfs_prepare_mode(mnt_userns, path.dentry->d_inode, mode);

This needs to move into vfs_mkdir() itself to allow overlayfs to
continue to rely on setgid stripping.
See the relevant part in the _draft_ patch in [1].

[1]: https://lore.kernel.org/ceph-devel/20220427092201.wvsdjbnc7b4dttaw@wittgenstein

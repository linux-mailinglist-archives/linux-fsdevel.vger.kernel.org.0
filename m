Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68DC509ACA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386736AbiDUIiH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386738AbiDUIiF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:38:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F38DBB0;
        Thu, 21 Apr 2022 01:35:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41A64B8238D;
        Thu, 21 Apr 2022 08:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3E8BC385A5;
        Thu, 21 Apr 2022 08:35:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650530112;
        bh=CsZbPQ3fpzr9G4TOzLryId0FdHQkqXiittsIevIwLm8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AbC5xXXtVkxZz1Q/JPkl0wOwixvxTQuVY6KN26NcJQmlmFeFx9GX3WNZYMiK3SqqD
         x2HArd91JlM9QbXuYjHa6RlJORxlurWf3JBdeTsiqWuo7QABrpEXaTGCld1CKsYSk+
         vSmj0Xz1hSN+LiASDOu3efEnDWZLWtejA32NoA4v6ySr49X/dNu4/B5xpExA8vuChG
         Ke8POkkt6qOxK44EQ0K4cGd1czN2XqeyIr06lr6iy7LHXaDAmT3zRtmU25u3ORuz6d
         P5iwKkIH8ybxw2+odEnVe9a06nyWomHy68N/RwOwU2S9m2UMJXj0Qa0kEsyrjUhS8q
         zKu1lHMvxRlAQ==
Date:   Thu, 21 Apr 2022 10:35:07 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        willy@infradead.org, jlayton@kernel.org
Subject: Re: [PATCH v5 3/4] fs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Message-ID: <20220421083507.siunu6ohyba6peyq@wittgenstein>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650527658-2218-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650527658-2218-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:54:17PM +0800, Yang Xu wrote:
> Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
> to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> firstly, then posxi acl setup, but xfs uses the contrary order. It will
> affect S_ISGID clear especially we filter S_IXGRP by umask or acl.
> 
> Regardless of which filesystem is in use, failure to strip the SGID correctly
> is considered a security failure that needs to be fixed. The current VFS
> infrastructure requires the filesystem to do everything right and not step on
> any landmines to strip the SGID bit, when in fact it can easily be done at the
> VFS and the filesystems then don't even need to be aware that the SGID needs
> to be (or has been stripped) by the operation the user asked to be done.
> 
> Vfs has all the info it needs - it doesn't need the filesystems to do everything
> correctly with the mode and ensuring that they order things like posix acl setup
> functions correctly with inode_init_owner() to strip the SGID bit.
> 
> Just strip the SGID bit at the VFS, and then the filesystem can't get it wrong.
> 
> Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
> this api may change mode.
> 
> Only the following places use inode_init_owner
> "
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
> "
> 
> They are used in filesystem to init new inode function and these init inode
> functions are used by following operations:
> mkdir
> symlink
> mknod
> create
> tmpfile
> rename
> 
> We don't care about mkdir because we don't strip SGID bit for directory except
> fs.xfs.irix_sgid_inherit. But we even call prepare_mode() in do_mkdirat() since
> inode_sgid_strip() will skip directories anyway. This will enforce the same
> ordering for all relevant operations and it will make the code more uniform and
> easier to understand by using new helper prepare_mode().
> 
> symlink and rename only use valid mode that doesn't have SGID bit.
> 
> We have added inode_sgid_strip api for the remaining operations.
> 
> In addition to the above six operations, four filesystems has a little difference
> 1) btrfs has btrfs_create_subvol_root to create new inode but used non SGID bit
>    mode and can ignore
> 2) ocfs2 reflink function should add inode_sgid_strip api manually because we
>    don't add it in vfs
> 3) spufs which doesn't really go hrough the regular VFS callpath because it has
>    separate system call spu_create, but it t only allows the creation of
>    directories and only allows bits in 0777 and can ignore
> 4) bpf use vfs_mkobj in bpf_obj_do_pin with
>    "S_IFREG | ((S_IRUSR | S_IWUSR) & ~current_umask()) mode and
>    use bpf_mkobj_ops in bpf_iter_link_pin_kernel with S_IFREG | S_IRUSR mode,
>    so bpf is also not affected
> 
> This patch also changed grpid behaviour for ext4/xfs because the mode passed to
> them may been changed by inode_sgid_strip.
> 
> Also as Christian Brauner said"
> The patch itself is useful as it would move a security sensitive operation that is
> currently burried in individual filesystems into the vfs layer. But it has a decent
> regression  potential since it might strip filesystems that have so far relied on
> getting the S_ISGID bit with a mode argument. So this needs a lot of testing and
> long exposure in -next for at least one full kernel cycle."
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> v4->v5:
> put inode_sgid_strip before the inode_init_owner in ocfs2 filesystem
> because the inode->i_mode's assignment is in inode_init_owner
>  fs/inode.c         |  2 --
>  fs/namei.c         | 22 +++++++++-------------
>  fs/ocfs2/namei.c   |  1 +
>  include/linux/fs.h | 11 +++++++++++
>  4 files changed, 21 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 57130e4ef8b4..95667e634bd4 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2246,8 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  		/* Directories are special, and always inherit S_ISGID */
>  		if (S_ISDIR(mode))
>  			mode |= S_ISGID;
> -		else
> -			mode = inode_sgid_strip(mnt_userns, dir, mode);
>  	} else
>  		inode_fsgid_set(inode, mnt_userns);
>  	inode->i_mode = mode;
> diff --git a/fs/namei.c b/fs/namei.c
> index 73646e28fae0..5b8e6288d503 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3287,8 +3287,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &= ~O_TRUNC;
> -		if (!IS_POSIXACL(dir->d_inode))
> -			mode &= ~current_umask();
> +		mode = prepare_mode(mnt_userns, dir->d_inode, mode);
>  		if (likely(got_write))
>  			create_error = may_o_create(mnt_userns, &nd->path,
>  						    dentry, mode);
> @@ -3521,8 +3520,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
>  	child = d_alloc(dentry, &slash_name);
>  	if (unlikely(!child))
>  		goto out_err;
> -	if (!IS_POSIXACL(dir))
> -		mode &= ~current_umask();
> +	mode = prepare_mode(mnt_userns, dir, mode);
>  	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
>  	if (error)
>  		goto out_err;
> @@ -3850,13 +3848,12 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	if (IS_ERR(dentry))
>  		goto out1;
>  
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> -		mode &= ~current_umask();
> +	mnt_userns = mnt_user_ns(path.mnt);
> +	mode = prepare_mode(mnt_userns, path.dentry->d_inode, mode);
>  	error = security_path_mknod(&path, dentry, mode, dev);
>  	if (error)
>  		goto out2;
>  
> -	mnt_userns = mnt_user_ns(path.mnt);
>  	switch (mode & S_IFMT) {
>  		case 0: case S_IFREG:
>  			error = vfs_create(mnt_userns, path.dentry->d_inode,
> @@ -3943,6 +3940,7 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  	struct path path;
>  	int error;
>  	unsigned int lookup_flags = LOOKUP_DIRECTORY;
> +	struct user_namespace *mnt_userns;
>  
>  retry:
>  	dentry = filename_create(dfd, name, &path, lookup_flags);
> @@ -3950,15 +3948,13 @@ int do_mkdirat(int dfd, struct filename *name, umode_t mode)
>  	if (IS_ERR(dentry))
>  		goto out_putname;
>  
> -	if (!IS_POSIXACL(path.dentry->d_inode))
> -		mode &= ~current_umask();
> +	mnt_userns = mnt_user_ns(path.mnt);
> +	mode = prepare_mode(mnt_userns, path.dentry->d_inode, mode);
>  	error = security_path_mkdir(&path, dentry, mode);
> -	if (!error) {
> -		struct user_namespace *mnt_userns;
> -		mnt_userns = mnt_user_ns(path.mnt);
> +	if (!error)
>  		error = vfs_mkdir(mnt_userns, path.dentry->d_inode, dentry,
>  				  mode);
> -	}
> +
>  	done_path_create(&path, dentry);
>  	if (retry_estale(error, lookup_flags)) {
>  		lookup_flags |= LOOKUP_REVAL;
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index c75fd54b9185..21f3da2e66c9 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -197,6 +197,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
>  	 * callers. */
>  	if (S_ISDIR(mode))
>  		set_nlink(inode, 2);
> +	mode = inode_sgid_strip(&init_user_ns, dir, mode);
>  	inode_init_owner(&init_user_ns, inode, dir, mode);

For the record, I'm not too fond of this separate invocation of
inode_sgid_strip() but since it's only one location this might be fine.
If there's more than one location a separate helper should exist for
this that abstracts this away for the filesystem.

Two questions:
- Sould this call prepare_mode(), i.e. should we honor umasks here too?
- How is the sgid bit handled when creating reflinks on other reflink
  supporting filesystems such as xfs and btrfs?

>  	status = dquot_initialize(inode);
>  	if (status)
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index 532de76c9b91..0bf81ab71619 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -3459,6 +3459,17 @@ static inline bool dir_relax_shared(struct inode *inode)
>  	return !IS_DEADDIR(inode);
>  }
>  
> +static inline umode_t prepare_mode(struct user_namespace *mnt_userns,
> +				   const struct inode *dir, umode_t mode)
> +{
> +	mode = inode_sgid_strip(mnt_userns, dir, mode);
> +
> +	if (!IS_POSIXACL(dir))
> +		mode &= current_umask();

You're missing a "~". I assume you meant:

mode &= ~current_umask();

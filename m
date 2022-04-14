Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8854500DF8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 14:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240550AbiDNMs1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 08:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232496AbiDNMsZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:48:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01A8A90CDB;
        Thu, 14 Apr 2022 05:45:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8864BB828FB;
        Thu, 14 Apr 2022 12:45:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72E40C385A5;
        Thu, 14 Apr 2022 12:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649940357;
        bh=MdzD+Hc4tAnAwRmjDuMoWeaoAJddm5AR/TAYkKzsyAc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hl2+DHHLTtFJG/+ifuKAxfe+23urLJZFYDJ71p2fqkhP2uAhq0z1UKks3Erg5qMZ6
         sfq5z1uPzbivMCBAT/twwAWXy/0NZ/4gL8PrAxk86Tm6GxzYbHGy17GrCGrORm1lk0
         qI3+ZDvR/yUbDJwSzJ9+Lsq/W20rahigYFenJQh9p6euOo9UXdK4vozBWKlwjYBVQd
         5swbabqIjdcbn2iXUh6cdMXOubf4ZkEmCH5+xOeMdjByFjnmehJea7hskJDHIRWNkm
         Wx5PyzDWRtqRS6aCks1XUmhXnCmgV/qQP7NP2XEmQrHbq04syHVxq2IhUAY60N40dY
         ysOMH+ZlJ4EtQ==
Date:   Thu, 14 Apr 2022 14:45:52 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, viro@zeniv.linux.org.uk,
        david@fromorbit.com, djwong@kernel.org, jlayton@kernel.org
Subject: Re: [PATCH v2 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on underlying filesystem
Message-ID: <20220414124552.4uf3hpopqa4xlwrd@wittgenstein>
References: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649923039-2273-2-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1649923039-2273-2-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 14, 2022 at 03:57:18PM +0800, Yang Xu wrote:
> Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
> to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> firstly, then posxi acl setup, but xfs uses the contrary order. It will affect
> S_ISGID clear especially we filter S_IXGRP by umask or acl.
> 
> Regardless of which filesystem is in use, failure to strip the SGID correctly is
> considered a security failure that needs to be fixed. The current VFS infrastructure
> requires the filesystem to do everything right and not step on any landmines to
> strip the SGID bit, when in fact it can easily be done at the VFS and the filesystems
> then don't even need to be aware that the SGID needs to be (or has been stripped) by
> the operation the user asked to be done.
> 
> Vfs has all the info it needs - it doesn't need the filesystems to do everything
> correctly with the mode and ensuring that they order things like posix acl setup
> functions correctly with inode_init_owner() to strip the SGID bit.
> 
> Just strip the SGID bit at the VFS, and then the filesystems can't get it wrong.
> 
> Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
> this api may change mode.
> 
> Only the following places use inode_init_owner
> "hugetlbfs/inode.c:846:          inode_init_owner(&init_user_ns, inode, dir, mode);
>  nilfs2/inode.c:354:     inode_init_owner(&init_user_ns, inode, dir, mode);
>  zonefs/super.c:1289:    inode_init_owner(&init_user_ns, inode, parent, S_IFDIR | 0555);
>  reiserfs/namei.c:619:   inode_init_owner(&init_user_ns, inode, dir, mode);
>  jfs/jfs_inode.c:67:     inode_init_owner(&init_user_ns, inode, parent, mode);
>  f2fs/namei.c:50:        inode_init_owner(mnt_userns, inode, dir, mode);
>  ext2/ialloc.c:549:              inode_init_owner(&init_user_ns, inode, dir, mode);
>  overlayfs/dir.c:643:    inode_init_owner(&init_user_ns, inode, dentry->d_parent->d_inode, mode);
>  ufs/ialloc.c:292:       inode_init_owner(&init_user_ns, inode, dir, mode);
>  ntfs3/inode.c:1283:     inode_init_owner(mnt_userns, inode, dir, mode);
>  ramfs/inode.c:64:               inode_init_owner(&init_user_ns, inode, dir, mode);
>  9p/vfs_inode.c:263:     inode_init_owner(&init_user_ns, inode, NULL, mode);
>  btrfs/tests/btrfs-tests.c:65:   inode_init_owner(&init_user_ns, inode, NULL, S_IFREG);
>  btrfs/inode.c:6215:     inode_init_owner(mnt_userns, inode, dir, mode);
>  sysv/ialloc.c:166:      inode_init_owner(&init_user_ns, inode, dir, mode);
>  omfs/inode.c:51:        inode_init_owner(&init_user_ns, inode, NULL, mode);
>  ubifs/dir.c:97: inode_init_owner(&init_user_ns, inode, dir, mode);
>  udf/ialloc.c:108:       inode_init_owner(&init_user_ns, inode, dir, mode);
>  ext4/ialloc.c:979:              inode_init_owner(mnt_userns, inode, dir, mode);
>  hfsplus/inode.c:393:    inode_init_owner(&init_user_ns, inode, dir, mode);
>  xfs/xfs_inode.c:840:            inode_init_owner(mnt_userns, inode, dir, mode);
>  ocfs2/dlmfs/dlmfs.c:331:                inode_init_owner(&init_user_ns, inode, NULL, mode);
>  ocfs2/dlmfs/dlmfs.c:354:        inode_init_owner(&init_user_ns, inode, parent, mode);
>  ocfs2/namei.c:200:      inode_init_owner(&init_user_ns, inode, dir, mode);
>  minix/bitmap.c:255:     inode_init_owner(&init_user_ns, inode, dir, mode);
>  bfs/dir.c:99:   inode_init_owner(&init_user_ns, inode, dir, mode);
> "

For completeness sake, there's also spufs which doesn't really go
through the regular VFS callpath because it has separate system calls
like:

SYSCALL_DEFINE4(spu_create, const char __user *, name, unsigned int, flags,
	umode_t, mode, int, neighbor_fd)

but looking through the code it only allows the creation of directories and only
allows bits in 0777.

> 
> They are used in filesystem init new inode function and these init inode functions are used
> by following operations:
> mkdir
> symlink
> mknod
> create
> tmpfile
> rename
> 
> We don't care about mkdir because we don't strip SGID bit for directory except fs.xfs.irix_sgid_inherit.
> symlink and rename only use valid mode that doesn't have SGID bit.
> 
> We have added inode_sgid_strip api for the remaining operations.
> 
> In addition to the above six operations, two filesystems has a little difference
> 1) btrfs has btrfs_create_subvol_root to create new inode but used non SGID bit mode and can ignore
> 2) ocfs2 reflink function should add inode_sgid_strip api manually because we don't add it in vfs
> 
> Last but not least, this patch also changed grpid behaviour for ext4/xfs because the mode passed to
> them may been changed by inode_sgid_strip.

I think the patch itself is useful as it would move a security sensitive
operation that is currently burried in individual filesystems into the
vfs layer. But it has a decent regression potential since it might trip
filesystems that have so far relied on getting the S_ISGID bit with a
mode argument. The example being network filesystems that Jeff brought
up earlier. So this needs a lot of testing and long exposure in -next
for at least one full kernel cycle imho.

> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  fs/inode.c       | 4 ----
>  fs/namei.c       | 5 ++++-
>  fs/ocfs2/namei.c | 1 +
>  3 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index d63264998855..b08bdd73e116 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2246,10 +2246,6 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  		/* Directories are special, and always inherit S_ISGID */
>  		if (S_ISDIR(mode))
>  			mode |= S_ISGID;
> -		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
> -			 !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
> -			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> -			mode &= ~S_ISGID;
>  	} else
>  		inode_fsgid_set(inode, mnt_userns);
>  	inode->i_mode = mode;
> diff --git a/fs/namei.c b/fs/namei.c
> index 3f1829b3ab5b..e03f7defdd30 100644
> --- a/fs/namei.c
> +++ b/fs/namei.c
> @@ -3287,6 +3287,7 @@ static struct dentry *lookup_open(struct nameidata *nd, struct file *file,
>  	if (open_flag & O_CREAT) {
>  		if (open_flag & O_EXCL)
>  			open_flag &= ~O_TRUNC;
> +		inode_sgid_strip(mnt_userns, dir->d_inode, &mode);
>  		if (!IS_POSIXACL(dir->d_inode))
>  			mode &= ~current_umask();
>  		if (likely(got_write))
> @@ -3521,6 +3522,7 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
>  	child = d_alloc(dentry, &slash_name);
>  	if (unlikely(!child))
>  		goto out_err;
> +	inode_sgid_strip(mnt_userns, dir, &mode);

Hm, an additional question: how is umask stripping currently handled in
vfs_tmpfile()? I don't see it anywhere. That seems like a bug?

>  	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
>  	if (error)
>  		goto out_err;
> @@ -3850,13 +3852,14 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	if (IS_ERR(dentry))
>  		goto out1;
>  
> +	mnt_userns = mnt_user_ns(path.mnt);
> +	inode_sgid_strip(mnt_userns, path.dentry->d_inode, &mode);
>  	if (!IS_POSIXACL(path.dentry->d_inode))
>  		mode &= ~current_umask();

It would be worth to add another helper prepare_mode() that calls
inode_sgid_strip() and does the umask stripping as well and then call it
in all these places. You should even call it in do_mkdirat() since
inode_sgid_strip() will skip directories anyway. This will enforce the
same ordering for all relevant operations and it will make the code more
uniform and easier to understand.

>  	error = security_path_mknod(&path, dentry, mode, dev);
>  	if (error)
>  		goto out2;
>  
> -	mnt_userns = mnt_user_ns(path.mnt);
>  	switch (mode & S_IFMT) {
>  		case 0: case S_IFREG:
>  			error = vfs_create(mnt_userns, path.dentry->d_inode,
> diff --git a/fs/ocfs2/namei.c b/fs/ocfs2/namei.c
> index c75fd54b9185..f1d626697302 100644
> --- a/fs/ocfs2/namei.c
> +++ b/fs/ocfs2/namei.c
> @@ -197,6 +197,7 @@ static struct inode *ocfs2_get_init_inode(struct inode *dir, umode_t mode)
>  	 * callers. */
>  	if (S_ISDIR(mode))
>  		set_nlink(inode, 2);
> +	inode_sgid_strip(&init_user_ns, dir, &mode);
>  	inode_init_owner(&init_user_ns, inode, dir, mode);
>  	status = dquot_initialize(inode);
>  	if (status)
> -- 
> 2.27.0
> 
> 

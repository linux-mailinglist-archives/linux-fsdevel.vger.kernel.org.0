Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FBA4EABFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Mar 2022 13:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235581AbiC2LOA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Mar 2022 07:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232456AbiC2LN7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:13:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41FEA35DF0;
        Tue, 29 Mar 2022 04:12:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8288B81658;
        Tue, 29 Mar 2022 11:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1502CC2BBE4;
        Tue, 29 Mar 2022 11:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648552333;
        bh=zeKiA1acOnL8r0cEWKUDM1xFymj7F96GLmoiirJTzv4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=GYPMbrti1bRusihUHfcqU6JwUCeSE2qN23adSBsIAgGrWbr6fornPpqtyihaoVCoF
         2zHD8h0KrKI74fnr/kObB/90OBH+q0reoScfJwnvb6AZYVe3Sw/UzlS+SiTLptZVK9
         uSzA+EYpq/P7/N2gdY8uai+DCSULrjLZhn08NAH6d8mi1M50H+wyQ0uJBUsPaOnWDI
         BN0jYVvELDPhvFUgpYwp6IA55Yu11m7IEVuj+fwQFqy/4BllxufzJpnPzOJAy+34Xs
         PdNFr6irJjUKkYoUWONk0I7sPB3EalO6GFKbYs+rUc85aRhBZVrpejijU2e+QXoySe
         s9Fvyj4JVrKyA==
Message-ID: <4250135d7321841ee6bdf0487c576f311aa583aa.camel@kernel.org>
Subject: Re: [PATCH v1 2/3] vfs: strip file's S_ISGID mode on vfs instead of
 on filesystem
From:   Jeff Layton <jlayton@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, david@fromorbit.com
Date:   Tue, 29 Mar 2022 07:12:11 -0400
In-Reply-To: <1648461389-2225-2-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
         <1648461389-2225-2-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-03-28 at 17:56 +0800, Yang Xu wrote:
> Currently, vfs only passes mode argument to filesystem, then use inode_init_owner()
> to strip S_ISGID. Some filesystem(ie ext4/btrfs) will call inode_init_owner
> firstly, then posxi acl setup, but xfs uses the contrary order. It will affect
> S_ISGID clear especially umask with S_IXGRP.
> 
> Vfs has all the info it needs - it doesn't need the filesystems to do everything
> correctly with the mode and ensuring that they order things like posix acl setup
> functions correctly with inode_init_owner() to strip the SGID bit.
> 
> Just strip the SGID bit at the VFS, and then the filesystems can't get it wrong.
> 
> Also, the inode_sgid_strip() api should be used before IS_POSIXACL() because
> this api may change mode by using umask but S_ISGID clear isn't related to
> SB_POSIXACL flag.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  fs/inode.c | 4 ----
>  fs/namei.c | 7 +++++--
>  2 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 1f964e7f9698..a2dd71c2437e 100644
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
> index 3f1829b3ab5b..e68a99e0ac96 100644
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
> @@ -3521,6 +3522,8 @@ struct dentry *vfs_tmpfile(struct user_namespace *mnt_userns,
>  	child = d_alloc(dentry, &slash_name);
>  	if (unlikely(!child))
>  		goto out_err;
> +	inode_sgid_strip(mnt_userns, dir, &mode);
> +
>  	error = dir->i_op->tmpfile(mnt_userns, dir, child, mode);
>  	if (error)
>  		goto out_err;
> @@ -3849,14 +3852,14 @@ static int do_mknodat(int dfd, struct filename *name, umode_t mode,
>  	error = PTR_ERR(dentry);
>  	if (IS_ERR(dentry))
>  		goto out1;
> -
> +	mnt_userns = mnt_user_ns(path.mnt);
> +	inode_sgid_strip(mnt_userns, path.dentry->d_inode, &mode);
>  	if (!IS_POSIXACL(path.dentry->d_inode))
>  		mode &= ~current_umask();
>  	error = security_path_mknod(&path, dentry, mode, dev);
>  	if (error)
>  		goto out2;
>  
> -	mnt_userns = mnt_user_ns(path.mnt);
>  	switch (mode & S_IFMT) {
>  		case 0: case S_IFREG:
>  			error = vfs_create(mnt_userns, path.dentry->d_inode,

I haven't gone over this in detail, but have you tested this with NFS at
all?

IIRC, NFS has to leave setuid/gid stripping to the server, so I wonder
if this may end up running afoul of that by forcing the client to try
and strip these bits.

-- 
Jeff Layton <jlayton@kernel.org>

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D55C5100FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Apr 2022 16:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348610AbiDZO4H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Apr 2022 10:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244221AbiDZO4G (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Apr 2022 10:56:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A66B644E8;
        Tue, 26 Apr 2022 07:52:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA6A4618A9;
        Tue, 26 Apr 2022 14:52:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79194C385A0;
        Tue, 26 Apr 2022 14:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650984778;
        bh=sI30y5H5YftG4MXI2Gw38i3P0XYbhin3oM2Omc/XTx0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=EN7sUpFgLNc8pFxLz/za6PrkS/DlI15BsZOo5yd6V9i4M9Z9EHuYgDWSlBUOHE703
         xwexj7i7d9zbTS8x5cCKJ2H1YlckV6KiJ+29VzENa2zQaIIuGIK7SIkBtONYHHbx1W
         iXtQt+dw3Q0RurNzoetgqGIpmM5QWg6f8D8E4RBT6k4dfHWZcs8bqYrxgO55wb38my
         yyNsTOnYGrFGXeO6WtOJqOsQmdSSSU92bUTQkZj/zJZLAvgJcNofMJsyI4D4MH6MyY
         02RkLFLPwpLV2Hp2kPXnWqlwRY4YRMYoE86/18D959nrxFhYeYUVm9/+Pkj6uPKEMT
         dDqfgXhWyIe/w==
Message-ID: <a6919986dcd93c695761b022b9fddb93937d3deb.camel@kernel.org>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
From:   Jeff Layton <jlayton@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>, linux-fsdevel@vger.kernel.org,
        ceph-devel@vger.kernel.org
Cc:     viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        brauner@kernel.org, willy@infradead.org
Date:   Tue, 26 Apr 2022 10:52:56 -0400
In-Reply-To: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2022-04-26 at 19:11 +0800, Yang Xu wrote:
> Add a dedicated helper to handle the setgid bit when creating a new file
> in a setgid directory. This is a preparatory patch for moving setgid
> stripping into the vfs. The patch contains no functional changes.
> 
> Currently the setgid stripping logic is open-coded directly in
> inode_init_owner() and the individual filesystems are responsible for
> handling setgid inheritance. Since this has proven to be brittle as
> evidenced by old issues we uncovered over the last months (see [1] to
> [3] below) we will try to move this logic into the vfs.
> 
> Link: e014f37db1a2 ("xfs: use setattr_copy to set vfs inode attributes") [1]
> Link: 01ea173e103e ("xfs: fix up non-directory creation in SGID directories") [2]
> Link: fd84bfdddd16 ("ceph: fix up non-directory creation in SGID directories") [3]
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  fs/inode.c         | 37 +++++++++++++++++++++++++++++++++----
>  include/linux/fs.h |  2 ++
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d9b422504d1..e9a5f2ec2f89 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2246,10 +2246,8 @@ void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  		/* Directories are special, and always inherit S_ISGID */
>  		if (S_ISDIR(mode))
>  			mode |= S_ISGID;
> -		else if ((mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
> -			 !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
> -			 !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> -			mode &= ~S_ISGID;
> +		else
> +			mode = mode_strip_sgid(mnt_userns, dir, mode);
>  	} else
>  		inode_fsgid_set(inode, mnt_userns);
>  	inode->i_mode = mode;
> @@ -2405,3 +2403,34 @@ struct timespec64 current_time(struct inode *inode)
>  	return timestamp_truncate(now, inode);
>  }
>  EXPORT_SYMBOL(current_time);
> +
> +/**
> + * mode_strip_sgid - handle the sgid bit for non-directories
> + * @mnt_userns: User namespace of the mount the inode was created from
> + * @dir: parent directory inode
> + * @mode: mode of the file to be created in @dir
> + *
> + * If the @mode of the new file has both the S_ISGID and S_IXGRP bit
> + * raised and @dir has the S_ISGID bit raised ensure that the caller is
> + * either in the group of the parent directory or they have CAP_FSETID
> + * in their user namespace and are privileged over the parent directory.
> + * In all other cases, strip the S_ISGID bit from @mode.
> + *
> + * Return: the new mode to use for the file
> + */
> +umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
> +			 const struct inode *dir, umode_t mode)
> +{
> +	if (S_ISDIR(mode) || !dir || !(dir->i_mode & S_ISGID))
> +		return mode;
> +	if ((mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
> +		return mode;
> +	if (in_group_p(i_gid_into_mnt(mnt_userns, dir)))
> +		return mode;
> +	if (capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> +		return mode;
> +
> +	mode &= ~S_ISGID;
> +	return mode;
> +}
> +EXPORT_SYMBOL(mode_strip_sgid);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bbde95387a23..98b44a2732f5 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1897,6 +1897,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
>  void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  		      const struct inode *dir, umode_t mode);
>  extern bool may_open_dev(const struct path *path);
> +umode_t mode_strip_sgid(struct user_namespace *mnt_userns,
> +			 const struct inode *dir, umode_t mode);
>  
>  /*
>   * This is the "filldir" function type, used by readdir() to let

This series looks like a nice cleanup. I went ahead and added this pile
to another kernel I was testing with xfstests and it seemed to do fine.

You can add this (or some variant of it) to all 4 patches.

Reviewed-and-Tested-by: Jeff Layton <jlayton@kernel.org>

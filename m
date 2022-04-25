Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD1E250E643
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Apr 2022 18:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243635AbiDYQ4R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Apr 2022 12:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbiDYQ4O (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:56:14 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6880E2E0B1;
        Mon, 25 Apr 2022 09:53:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F96AB81907;
        Mon, 25 Apr 2022 16:53:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1FFCC385A4;
        Mon, 25 Apr 2022 16:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650905584;
        bh=EKe57K8GmRA9xBv+6SKXlcFNHKDCr7PmKqT69U00AEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qvNt3Hjn8UJm9vmfk0DWmWeR8D3LGkXH30rdT/I228KAxw4JuGBmfLa1hh976mjQo
         bYgemn2ezNX03mRW/76168+LH6dHXSp8w0fWe3SOZYPk5WAgCoh6zvnh6p/iyImZS3
         m7GcBkSN0T5gG8KUnAyNAyCefLoIbioWH5bT+7S6GPEB8uhznKJP3ZC9tcSofVFQ7J
         /mRXePY95q4vq+7omgbI2v9PFVWh6t/1TtQELkRcktFH9HWn/TY7mfZElC5+/++C3g
         RB/w2q2VX7RY9GcGVWD/T31wFBN7JOg6bFiTb/qv5KP24NLlWdFXWmpsBRw4cZP+MA
         5aLHxYRBdhfxQ==
Date:   Mon, 25 Apr 2022 09:53:04 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, brauner@kernel.org,
        willy@infradead.org, jlayton@kernel.org
Subject: Re: [PATCH v6 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Message-ID: <20220425165304.GD16996@magnolia>
References: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650856181-21350-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Apr 25, 2022 at 11:09:38AM +0800, Yang Xu wrote:
> This has no functional change. Just create and export inode_sgid_strip
> api for the subsequent patch. This function is used to strip inode's
> S_ISGID mode when init a new inode.
> 
> Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>

I've a slight preference for inode_strip_sgid() as well, but otherwise
this looks like a reasonable refactoring.

Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> ---
>  fs/inode.c         | 37 +++++++++++++++++++++++++++++++++----
>  include/linux/fs.h |  2 ++
>  2 files changed, 35 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d9b422504d1..78e7ef567e04 100644
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
> +			mode = inode_sgid_strip(mnt_userns, dir, mode);
>  	} else
>  		inode_fsgid_set(inode, mnt_userns);
>  	inode->i_mode = mode;
> @@ -2405,3 +2403,34 @@ struct timespec64 current_time(struct inode *inode)
>  	return timestamp_truncate(now, inode);
>  }
>  EXPORT_SYMBOL(current_time);
> +
> +/**
> + * inode_sgid_strip - handle the sgid bit for non-directories
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
> +umode_t inode_sgid_strip(struct user_namespace *mnt_userns,
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
> +EXPORT_SYMBOL(inode_sgid_strip);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index bbde95387a23..532de76c9b91 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1897,6 +1897,8 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
>  void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  		      const struct inode *dir, umode_t mode);
>  extern bool may_open_dev(const struct path *path);
> +umode_t inode_sgid_strip(struct user_namespace *mnt_userns,
> +			 const struct inode *dir, umode_t mode);
>  
>  /*
>   * This is the "filldir" function type, used by readdir() to let
> -- 
> 2.27.0
> 

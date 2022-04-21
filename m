Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724C9509A0C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386351AbiDUIET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386345AbiDUIES (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:04:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F1CC26F5;
        Thu, 21 Apr 2022 01:01:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B9F6461B9C;
        Thu, 21 Apr 2022 08:01:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DA8EC385AB;
        Thu, 21 Apr 2022 08:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650528088;
        bh=EEGk7gNQhGDo0zygYXjYjz6HtOK/f5qwPBTNV9pUMF8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oN7RYC6JTVhu+mu+Nel/ki2yrIRrMtjJlNneSKm2ulR9aNvmhBzNsUANw51DrEPbf
         z1qh9wqZ6kh28C+nEvChQpxL5CUiMtXijPjzNVjoamKUYMGTOFKKrAKS2nMEKbzMaa
         uExl5PsJ7NuScZcQ4IaZCcRw6M6yZtLJkgt5fh6y+XvMo6JTvAHsKjUHYa0hsblIg9
         kAuulehnSqHaJbwXSjfeC0h7WqpYMmtDd4z8Yo/B0d0Cdv/1yyC8hs8bnKv4Tlc+FP
         v2yTZs3dmevCrqyJnFy0pink8gmk1yUp67W20ClTxiMUH85I7PHrtVJUZuNZ5i1xuS
         +2ay/u/Sx3isQ==
Date:   Thu, 21 Apr 2022 10:01:22 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, djwong@kernel.org,
        willy@infradead.org, jlayton@kernel.org
Subject: Re: [PATCH v5 1/4] fs: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Message-ID: <20220421080122.nhcs6hksr5vdilgy@wittgenstein>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Apr 21, 2022 at 03:54:15PM +0800, Yang Xu wrote:
> This has no functional change. Just create and export inode_sgid_strip
> api for the subsequent patch. This function is used to strip inode's
> S_ISGID mode when init a new inode.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---

Could you please add the kernel doc I sketched below to the new helper?

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>

> v4-v5:
> use umode_t return value instead of mode pointer
>  fs/inode.c         | 23 +++++++++++++++++++----
>  include/linux/fs.h |  2 ++
>  2 files changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d9b422504d1..57130e4ef8b4 100644
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
> @@ -2405,3 +2403,20 @@ struct timespec64 current_time(struct inode *inode)
>  	return timestamp_truncate(now, inode);
>  }
>  EXPORT_SYMBOL(current_time);
> +

/**
 * inode_sgid_strip - handle the sgid bit for non-directories
 * @mnt_userns:	idmapping of the mount
 * @dir: parent directory
 * @mode: mode of the file to be created in @dir
 *
 * If the @mode of the new file has both the S_ISGID and S_IXGRP bit
 * raised and @dir has the S_ISGID bit raised ensure that the caller is
 * either in the group of the parent directory or they have CAP_FSETID
 * in their user namespace and are privileged over the parent directory.
 * In all other cases, strip the S_ISGID bit from @mode.
 *
 * Return: the new mode to use for the file
 */
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

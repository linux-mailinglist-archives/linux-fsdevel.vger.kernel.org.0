Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC4554EC9BC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Mar 2022 18:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348849AbiC3Qgf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 12:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348868AbiC3Qgb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 12:36:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A439193169;
        Wed, 30 Mar 2022 09:34:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CDBDB617D6;
        Wed, 30 Mar 2022 16:34:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3965DC340EC;
        Wed, 30 Mar 2022 16:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648658080;
        bh=L6fLpv9vJKZxpHVfLRlfJrHdzfnv56qI3d9VTw2fGH4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLQLf/aL4NjxFspy+POQNsARFbNsjnYVkMk/1rSKTKcyNs3X9/kWc/CMKg+nGLZNw
         l+wevW39YsaG8AYIfFACh8/Jot9IkDW25cfeQIl77CctJ4py1if4tfV7RYxHd9atwX
         C3gNHATf/ijJ8lw/gWNEuWoU1YoMiKk/vuQpTyiBPZoUqAWZTn4o10//nvoya9dBTo
         E1EBhbv1G5liO0Y+bMLx0OL9+Tonb6TUeZq5IppnYD0ymoMBvwy8Y/cRU6/HVYNHVT
         Q03IwuJPt6T3CUMfm32dArSO49lbKbL1sf8W6W2Sa3twQ5rnavJtIrlf6wU5bEUWSU
         y0PHQNPCbJVkQ==
Date:   Wed, 30 Mar 2022 09:34:39 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        viro@zeniv.linux.org.uk, david@fromorbit.com, jlayton@kernel.org
Subject: Re: [PATCH v1 1/3] vfs: Add inode_sgid_strip() api
Message-ID: <20220330163439.GB27649@magnolia>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 28, 2022 at 05:56:27PM +0800, Yang Xu wrote:
> inode_sgid_strip() function is used to strip S_ISGID mode
> when creat/open/mknod file.
> 
> Suggested-by: Dave Chinner <david@fromorbit.com>
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
>  fs/inode.c         | 12 ++++++++++++
>  include/linux/fs.h |  3 +++
>  2 files changed, 15 insertions(+)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 63324df6fa27..1f964e7f9698 100644
> --- a/fs/inode.c
> +++ b/fs/inode.c
> @@ -2405,3 +2405,15 @@ struct timespec64 current_time(struct inode *inode)
>  	return timestamp_truncate(now, inode);
>  }
>  EXPORT_SYMBOL(current_time);
> +
> +void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
> +		      umode_t *mode)
> +{
> +	if ((dir && dir->i_mode & S_ISGID) &&
> +		(*mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
> +		!S_ISDIR(*mode) &&
> +		!in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
> +		!capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
> +		*mode &= ~S_ISGID;

A couple of style nits here:

The secondary if test clauses have the same indentation level as the
code that actually gets executed, which makes this harder to scan
visually.

	if ((dir && dir->i_mode & S_ISGID) &&
	    (*mode & (S_ISGID | S_IXGRP)) == (S_ISGID | S_IXGRP) &&
	    !S_ISDIR(*mode) &&
	    !in_group_p(i_gid_into_mnt(mnt_userns, dir)) &&
	    !capable_wrt_inode_uidgid(mnt_userns, dir, CAP_FSETID))
		*mode &= ~S_ISGID;

Alternately, you could use inverse logic to bail out early:

void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
		      umode_t *mode)
{
	if (!dir || !(dir->i_mode & S_ISGID))
		return;
	if (S_ISDIR(*mode))
		return;
	if (in_group_p(...))
		return;
	if (capable_wrt_inode_uidgid(...))
		return;

	*mode &= ~S_ISGID;
}

Though I suppose that /is/ much longer.

The bigger thing here is that I'd like to see this patch hoist the ISGID
stripping code out of init_inode_owner so that it's easier to verify
that the new helper does exactly the same thing as the old code.  The
second patch would then add callsites around the VFS as necessary to
prevent this problem from happening again.

--D

> +}
> +EXPORT_SYMBOL(inode_sgid_strip);
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index e2d892b201b0..639c830ad797 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1921,6 +1921,9 @@ extern long compat_ptr_ioctl(struct file *file, unsigned int cmd,
>  void inode_init_owner(struct user_namespace *mnt_userns, struct inode *inode,
>  		      const struct inode *dir, umode_t mode);
>  extern bool may_open_dev(const struct path *path);
> +void inode_sgid_strip(struct user_namespace *mnt_userns, struct inode *dir,
> +		      umode_t *mode);
> +
>  
>  /*
>   * This is the "filldir" function type, used by readdir() to let
> -- 
> 2.27.0
> 

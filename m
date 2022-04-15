Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2B6502B84
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 16:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354286AbiDOOMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Apr 2022 10:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233185AbiDOOMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Apr 2022 10:12:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5956468;
        Fri, 15 Apr 2022 07:09:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E548E6209F;
        Fri, 15 Apr 2022 14:09:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41D62C385A5;
        Fri, 15 Apr 2022 14:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650031774;
        bh=8SN8pSQF26UhUrZ5RWRuwnWsg6JzFY4XPlBZTxxZw6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fPB68BrWZXRJZ2F7znRpyMQqUa+q5QVsVbv6bwxbm/vGGKcd5anVAFW2mHgvwlKMJ
         cYkoqMAXQBZ5DwRe3gt5saZYeREPfLG7eUfR11mqmmqenTCmGbzqk7NBt9TwH6QSOB
         JjJYWwO0r13SYJcnTp/Snq2RZYF9/NwEOtSXTlYOYva32t9kAe/lyRjbYvP2fl3R4r
         w21nk+B3OrLEpTOInu4ubE9tZD9hWEe8jy0Z0ePkBfJTnGI+RVyvWfHxIA3XyW7SE4
         qqlCBFF5wAzooiD2RbKY8O1oTsc/0NIbLvPOZ1T1l44asU6AL3DC7/A1ddP5cHZn7W
         Tx89MwNkyN80A==
Date:   Fri, 15 Apr 2022 16:09:24 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yang Xu <xuyang2018.jy@fujitsu.com>
Cc:     david@fromorbit.com, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-xfs@vger.kernel.org,
        viro@zeniv.linux.org.uk, jlayton@kernel.org
Subject: Re: [PATCH v3 1/7] fs/inode: move sgid strip operation from
 inode_init_owner into inode_sgid_strip
Message-ID: <20220415140924.oirar6dklelujnxs@wittgenstein>
References: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1650020543-24908-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Apr 15, 2022 at 07:02:17PM +0800, Yang Xu wrote:
> This has no functional change. Just create and export inode_sgid_strip api for
> the subsequent patch. This function is used to strip S_ISGID mode when init
> a new inode.
> 
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> v2->v3:
> 1.Use const struct inode * instead of struct inode *
> 2.replace sgid strip with inode_sgid_strip in a single patch
>  fs/inode.c         | 24 ++++++++++++++++++++----
>  include/linux/fs.h |  3 ++-
>  2 files changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/inode.c b/fs/inode.c
> index 9d9b422504d1..1b569ad882ce 100644
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
> +			inode_sgid_strip(mnt_userns, dir, &mode);
>  	} else
>  		inode_fsgid_set(inode, mnt_userns);
>  	inode->i_mode = mode;
> @@ -2405,3 +2403,21 @@ struct timespec64 current_time(struct inode *inode)
>  	return timestamp_truncate(now, inode);
>  }
>  EXPORT_SYMBOL(current_time);
> +
> +void inode_sgid_strip(struct user_namespace *mnt_userns,
> +		      const struct inode *dir, umode_t *mode)
> +{
> +	if (!dir || !(dir->i_mode & S_ISGID))
> +		return;
> +	if ((*mode & (S_ISGID | S_IXGRP)) != (S_ISGID | S_IXGRP))
> +		return;
> +	if (S_ISDIR(*mode))
> +		return;

I'd place that check first as this whole function is really only
relevant for non-directories.

Otherwise I can live with *mode being a pointer although I still find
this unpleasant API wise but the bikeshed does it's job without having
my color. :)

I'd like to do some good testing on this.

Acked-by: Christian Brauner (Microsoft) <brauner@kernel.org>

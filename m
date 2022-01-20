Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E82F4953D6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jan 2022 19:03:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233510AbiATSDs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Jan 2022 13:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiATSDr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Jan 2022 13:03:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF45BC061574;
        Thu, 20 Jan 2022 10:03:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98C7BB81D74;
        Thu, 20 Jan 2022 18:03:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DA23C340E0;
        Thu, 20 Jan 2022 18:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642701824;
        bh=hnCvMNzGWqbC4sL/0zVTHFsSyDTS0wssN9HVuAtSlEE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b5HKZ1DiR5MGJUva6SjqfLdFN29GNFkr5XOv88VzjZDFQXBrdd1QySbriErYp4A3y
         +qbt2fzqWG8LegRWAii4Yu8MGRyqhey3z9gjKULit5ycvchECXktUrUWZrEYIIxmWl
         4k1vk0uJFHNuX249R2yqJNFIz1fNUqgOAthaezSJxIZbvcduZB0pu03JbAKfSUsW5K
         a8zotVTBVrwGTwBWBXgc1OkdPxmT1244v7vrufWG6WVIf+01wTpdFW+3dJc08DX2m+
         hCqkEDcH6uJKt32C4rglP4k4WNbkJpYHME5RUHRJEVy0ARAl+MCDlZxKp6Tltp6kLq
         rpxrOALfkFFZw==
Date:   Thu, 20 Jan 2022 10:03:44 -0800
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Anthony Iliopoulos <ailiop@suse.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND] mount: warn only once about timestamp range
 expiration
Message-ID: <20220120180344.GA13499@magnolia>
References: <20220119202934.26495-1-ailiop@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220119202934.26495-1-ailiop@suse.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:29:34PM +0100, Anthony Iliopoulos wrote:
> Commit f8b92ba67c5d ("mount: Add mount warning for impending timestamp
> expiry") introduced a mount warning regarding filesystem timestamp
> limits, that is printed upon each writable mount or remount.
> 
> This can result in a lot of unnecessary messages in the kernel log in
> setups where filesystems are being frequently remounted (or mounted
> multiple times).
> 
> Avoid this by setting a superblock flag which indicates that the warning
> has been emitted at least once for any particular mount, as suggested in
> [1].
> 
> Signed-off-by: Anthony Iliopoulos <ailiop@suse.com>

I'm glad someone finally turned down the volume on this.
Reviewed-by: Darrick J. Wong <djwong@kernel.org>

--D

> 
> [1] https://lore.kernel.org/CAHk-=wim6VGnxQmjfK_tDg6fbHYKL4EFkmnTjVr9QnRqjDBAeA@mail.gmail.com/
> ---
>  fs/namespace.c     | 2 ++
>  include/linux/fs.h | 1 +
>  2 files changed, 3 insertions(+)
> 
> diff --git a/fs/namespace.c b/fs/namespace.c
> index c6feb92209a6..fec0f79aa2eb 100644
> --- a/fs/namespace.c
> +++ b/fs/namespace.c
> @@ -2583,6 +2583,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
>  	struct super_block *sb = mnt->mnt_sb;
>  
>  	if (!__mnt_is_readonly(mnt) &&
> +	   (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
>  	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
>  		char *buf = (char *)__get_free_page(GFP_KERNEL);
>  		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
> @@ -2597,6 +2598,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
>  			tm.tm_year+1900, (unsigned long long)sb->s_time_max);
>  
>  		free_page((unsigned long)buf);
> +		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
>  	}
>  }
>  
> diff --git a/include/linux/fs.h b/include/linux/fs.h
> index f3daaea16554..5c537cd9b006 100644
> --- a/include/linux/fs.h
> +++ b/include/linux/fs.h
> @@ -1435,6 +1435,7 @@ extern int send_sigurg(struct fown_struct *fown);
>  
>  #define SB_I_SKIP_SYNC	0x00000100	/* Skip superblock at global sync */
>  #define SB_I_PERSB_BDI	0x00000200	/* has a per-sb bdi */
> +#define SB_I_TS_EXPIRY_WARNED 0x00000400 /* warned about timestamp range expiry */
>  
>  /* Possible states of 'frozen' field */
>  enum {
> -- 
> 2.34.1
> 

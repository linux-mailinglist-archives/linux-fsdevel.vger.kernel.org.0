Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F679F27B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 21:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbjIMT5i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 15:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjIMT5i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 15:57:38 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EE9D9E;
        Wed, 13 Sep 2023 12:57:34 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B0AC433CC;
        Wed, 13 Sep 2023 19:57:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694635053;
        bh=8s2Z1d1m3xuRoijuegAF7XDzYLIWy1+XSu3/xCTkOGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=bKNQUkL1wCDZ/gm59APeTdRTYc1TQhIDHGTt+vC8/7wftu+kCz5uohuq79uNm62eS
         uEeqVtIu5SN8F8Jqs8GfRUbQVgSdWaJanEGOw4VkV426meePVQmAvqG1P83G6n2u4g
         GlqylAHiVR/yZxYYVQJAAFCWyiAhXhzstAY9+OCq23xLvlrqDaxRbRVtUa7XAaXwDm
         8KakiD8ydMsHMy4mP/KC8SeBWBkXsryAsC2to77GPy/wm8dSIGWcvzld5Ljm+8Nc9j
         kqrZeCZvK163CtW4GRTIb7S+QSKYmDyQn7i4HLTkpaz6mh/pFndc22UxzhORnsznAl
         aBCfHLzvi8LBA==
Date:   Wed, 13 Sep 2023 12:57:31 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] overlayfs: set ctime when setting mtime and atime
Message-ID: <20230913195731.GA2922283@dev-arch.thelio-3990X>
References: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230913-ctime-v1-1-c6bc509cbc27@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 13, 2023 at 09:33:12AM -0400, Jeff Layton wrote:
> Nathan reported that he was seeing the new warning in
> setattr_copy_mgtime pop when starting podman containers. Overlayfs is
> trying to set the atime and mtime via notify_change without also
> setting the ctime.
> 
> POSIX states that when the atime and mtime are updated via utimes() that
> we must also update the ctime to the current time. The situation with
> overlayfs copy-up is analogies, so add ATTR_CTIME to the bitmask.
> notify_change will fill in the value.
> 
> Reported-by: Nathan Chancellor <nathan@kernel.org>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

I applied this patch on top of next-20230913 and I do not see the
warning I reported on any of my machines. Thanks for the quick fix!

Tested-by: Nathan Chancellor <nathan@kernel.org>

> ---
> The new WARN_ON_ONCE in setattr_copy_mgtime caught a bug! Fix up
> overlayfs to ensure that the ctime on the upper inode is also updated
> when copying up the atime and mtime.
> ---
>  fs/overlayfs/copy_up.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
> index d1761ec5866a..ada3fcc9c6d5 100644
> --- a/fs/overlayfs/copy_up.c
> +++ b/fs/overlayfs/copy_up.c
> @@ -337,7 +337,7 @@ static int ovl_set_timestamps(struct ovl_fs *ofs, struct dentry *upperdentry,
>  {
>  	struct iattr attr = {
>  		.ia_valid =
> -		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET,
> +		     ATTR_ATIME | ATTR_MTIME | ATTR_ATIME_SET | ATTR_MTIME_SET | ATTR_CTIME,
>  		.ia_atime = stat->atime,
>  		.ia_mtime = stat->mtime,
>  	};
> 
> ---
> base-commit: 9cb8e7c86ac793862e7bea7904b3426942bbd7ef
> change-id: 20230913-ctime-299173760dd9
> 
> Best regards,
> -- 
> Jeff Layton <jlayton@kernel.org>
> 

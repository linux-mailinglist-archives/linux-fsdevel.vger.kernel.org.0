Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19DAF3CBA7B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Jul 2021 18:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbhGPQXQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Jul 2021 12:23:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:40920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229498AbhGPQXP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:23:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8C7B61374;
        Fri, 16 Jul 2021 16:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626452418;
        bh=Zwqt1cSzJoWIBhvTU1eTmw8u+q+e0QVoxw05sJjMweM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZvwNnisSJVvVeA3Wqh1gfKo4TFcHs3CG0DHzaUz2EmCzvRL75fYdQXJFKNGPv+nzb
         7NTJinuaoMSFIN+41ui0WXxnyxdRo7rtpwONqVpdgd2SRc06TjVxJ8sMWK7Vw3+Hlu
         ujJqOhuvh6Clih3IDBqMftAQXQvarsesgSwSleYLgGCZOBug+jb+qacsjSuKJxJ1v8
         UcQyBwh2vzDNEdpVaXHyibfobUV3y5NegfrRJbM0CxTA67/pZS66EPCRlO3bLs6c5z
         CKc/MxEW5RYHKTeiAsUn3Cao3g4eSF3BgCiEtUk9k+QNPNQq1GKDBDW/1OTbxJTgah
         /uNqs+i9Muo3g==
Date:   Fri, 16 Jul 2021 09:20:17 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] vfs: only allow SETFLAGS to set DAX flag on files and
 dirs
Message-ID: <20210716162017.GA22346@magnolia>
References: <20210716061951.81529-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210716061951.81529-1-jefflexu@linux.alibaba.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 16, 2021 at 02:19:51PM +0800, Jeffle Xu wrote:
> This is similar to commit dbc77f31e58b ("vfs: only allow FSSETXATTR to
> set DAX flag on files and dirs").
> 
> Though the underlying filesystems may have filtered invalid flags, e.g.,
> ext4_mask_flags() called in ext4_fileattr_set(), also check it in VFS
> layer.
> 
> Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
> ---
>  fs/ioctl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1e2204fa9963..1fe73e148e2d 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -835,7 +835,7 @@ static int fileattr_set_prepare(struct inode *inode,
>  	 * It is only valid to set the DAX flag on regular files and
>  	 * directories on filesystems.
>  	 */
> -	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
> +	if ((fa->fsx_xflags & FS_XFLAG_DAX || fa->flags & FS_DAX_FL) &&

I thought we always had to surround flag tests with separate
parentheses...?

--D

>  	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
>  		return -EINVAL;
>  
> -- 
> 2.27.0
> 

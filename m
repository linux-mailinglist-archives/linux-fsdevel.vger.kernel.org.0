Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65A6E411290
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Sep 2021 12:06:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbhITKIE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Sep 2021 06:08:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:46718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhITKIC (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Sep 2021 06:08:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF671600D4;
        Mon, 20 Sep 2021 10:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1632132396;
        bh=Y9K2peoP+053qe709BSIBNv+PSkuEnDu9beMJCEm1kc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dkZ2epxCWQxx9jGPfmKG17yir0Al78Bj8bxw0HJyH1jiDCtaQSMGtqhObnPzzvMpK
         4V+BJYy+XemFXhVNC06d9O/SNjIZ99+fHu16NpYET3vJuvOZi3DtwYPiXrrP7JT8pA
         ZevrqQ1u94LO2H51eSLSYqKePMLKurQCKfR3vxKI=
Date:   Mon, 20 Sep 2021 12:06:33 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Gaelan Steele <gbs@canishe.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-man@vger.kernel.org,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: move struct linux_dirent into headers
Message-ID: <YUhdKQV2ZC8T8MhB@kroah.com>
References: <20210920095649.28600-1-gbs@canishe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920095649.28600-1-gbs@canishe.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Sep 20, 2021 at 10:56:48AM +0100, Gaelan Steele wrote:
> Move the definition of linux_dirent to include/linux/dirent.h,
> where the newer linux_dirent64 already lives. This is done in
> preparation for moving both of these struct definitions into uapi/
> so userspace code doesn't need to duplicate them.
> 
> Signed-off-by: Gaelan Steele <gbs@canishe.com>
> ---
>  fs/readdir.c           | 8 +-------
>  include/linux/dirent.h | 7 +++++++
>  2 files changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 09e8ed7d4161..51890aeafc53 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -202,14 +202,8 @@ SYSCALL_DEFINE3(old_readdir, unsigned int, fd,
>  
>  /*
>   * New, all-improved, singing, dancing, iBCS2-compliant getdents()
> - * interface. 
> + * interface.
>   */
> -struct linux_dirent {
> -	unsigned long	d_ino;
> -	unsigned long	d_off;
> -	unsigned short	d_reclen;
> -	char		d_name[1];
> -};
>  
>  struct getdents_callback {
>  	struct dir_context ctx;
> diff --git a/include/linux/dirent.h b/include/linux/dirent.h
> index 99002220cd45..48e119dd3694 100644
> --- a/include/linux/dirent.h
> +++ b/include/linux/dirent.h
> @@ -2,6 +2,13 @@
>  #ifndef _LINUX_DIRENT_H
>  #define _LINUX_DIRENT_H
>  
> +struct linux_dirent {
> +	unsigned long	d_ino;
> +	unsigned long	d_off;
> +	unsigned short	d_reclen;
> +	char		d_name[1];

These are not valid user/kernel api types.  If you want them in
userspace, please use the correct ones (__u64, __u16, __u8, etc.)

thanks,

greg k-h

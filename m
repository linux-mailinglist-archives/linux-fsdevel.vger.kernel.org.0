Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63A9F1B5F7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 17:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729268AbgDWPiK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 11:38:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:49886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729231AbgDWPiJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 11:38:09 -0400
Received: from gmail.com (unknown [104.132.1.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2C872075A;
        Thu, 23 Apr 2020 15:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587656289;
        bh=gNuSCC47zvyIpLuTBzO63qOyw2+XLh1hnmdTAhceGTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QrUHkOjYuCDNFRZ/3MvnBxO4LKJWu+ajgOB6x5hkqksFy0HvGuqrS9hQ7dFIwIPsa
         EXCy+00IuxCWb82mhyt+L9lFP0PewiJL5mK7XkX11k1NWqJMzW1UHBq6MjAXJ0g9Dt
         ycxPmB92BIz1hXqOE10XcvM37SLAnpip0oJvAPYc=
Date:   Thu, 23 Apr 2020 08:38:07 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     =Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH] fuse: Mark fscrypt ioctls as unrestricted
Message-ID: <20200423153807.GA205729@gmail.com>
References: <20200423074706.107016-1-chirantan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200423074706.107016-1-chirantan@chromium.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[+Cc linux-fscrypt@vger.kernel.org]

On Thu, Apr 23, 2020 at 04:47:06PM +0900, Chirantan Ekbote wrote:
> The definitions for these 2 ioctls have been reversed: "get" is marked
> as a write ioctl and "set" is marked as a read ioctl.  Moreover, since
> these are now part of the public kernel interface they can never be
> fixed because fixing them might break userspace applications compiled
> with the older headers.
> 
> Since the fuse module strictly enforces the ioctl encodings, it will
> reject any attempt by the fuse server to correctly implement these
> ioctls.  Instead, check if the process is trying to make one of these
> ioctls and mark it unrestricted.  This will allow the server to fix the
> encoding by reading/writing the correct data.
> 
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>
> ---
>  fs/fuse/file.c | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index 9d67b830fb7a2..9b6d993323d53 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -18,6 +18,7 @@
>  #include <linux/swap.h>
>  #include <linux/falloc.h>
>  #include <linux/uio.h>
> +#include <linux/fscrypt.h>
>  
>  static struct page **fuse_pages_alloc(unsigned int npages, gfp_t flags,
>  				      struct fuse_page_desc **desc)
> @@ -2751,6 +2752,16 @@ long fuse_do_ioctl(struct file *file, unsigned int cmd, unsigned long arg,
>  
>  	fuse_page_descs_length_init(ap.descs, 0, fc->max_pages);
>  
> +	/*
> +	 * These commands are encoded backwards so it is literally impossible
> +	 * for a fuse server to implement them. Instead, mark them unrestricted
> +	 * so that the server can deal with the broken encoding itself.
> +	 */
> +	if (cmd == FS_IOC_GET_ENCRYPTION_POLICY ||
> +	    cmd == FS_IOC_SET_ENCRYPTION_POLICY) {
> +		flags |= FUSE_IOCTL_UNRESTRICTED;
> +	}

Are there any security concerns with marking these ioctls unrestricted, as
opposed to dealing with the payload in the kernel?

Also, can you elaborate on why you need only these two specific ioctls?
FS_IOC_GET_ENCRYPTION_POLICY_EX and FS_IOC_ADD_ENCRYPTION_KEY take a
variable-length payload and thus are similarly incompatible with FUSE, right?
I thought we had discussed that for your use case the ioctl you actually need
isn't the above two, but rather FS_IOC_GET_ENCRYPTION_POLICY_EX.  So I'm a bit
confused by this patch.

- Eric

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E19629D7E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Oct 2020 23:28:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387402AbgJ1W1m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Oct 2020 18:27:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733309AbgJ1W1l (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:27:41 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 505CFC0613D1;
        Wed, 28 Oct 2020 15:27:41 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id z6so542538qkz.4;
        Wed, 28 Oct 2020 15:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ibdSaZ8Nv78jXZZ8NldkQ0j4dNhMGpHKfKsC4EOIlHk=;
        b=Jpx3AsgPEDUVr3nYkmh3LRmaILtNOy/8cK50gs9C9VNtGcS14U5mdSwCVBM1aDyiIx
         ySoka72Bl/jN3Na/hYtyEfOecFNcU/A8w0cv2aYuTL/yIDsO9zIYR4z9H3bsNrLKDVBD
         Bi7eQKijY92FC8QvYp0O6KUkAduonHfwbFqp3zydrRawZ6txH4M1cRQp8IiOl7LDbhDD
         WzDI69D1YZi32489gahKZvRfSkqZ7dO5Cd74dPM7nKAN93CGyFrws1uDxOoFVBJc9OFc
         FrB16Fiq2ZcV8/7HYxooNgEJWi99hwV9PJdBDxUyXGPLcYC9FuDE0/RV6SSwL+1RfT0N
         7A+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ibdSaZ8Nv78jXZZ8NldkQ0j4dNhMGpHKfKsC4EOIlHk=;
        b=aiIPmIwKPOJPXUk/2vik6pUAa7Z51uZw/wM0WePayE1ZIiJHblHjUYFnbEMEgF8Ufm
         WdI50broYlUudzHwuqHuDPj6q/bJYYaTaudiM3bkwHeVHvrlCF+36NdIJ/2Y2dDptm1+
         556yOBgmHAPDwwdepLPZvjifEdKhauvGrs6BZ6sRbISd/sgecNIp1KD+93M+5jlubCll
         899z72WFnZa1DlJgxyT7vCBsgdOcpSQNC/MKDoabNwmQRPRSvgBdZ8A+v71nuDtS/YbM
         IVq65ruApqx1wIu1yQQ7jNN4CU2lDQpp1X9fwDUyJg8ft02DO4eYca7y+nbKaMylv4RA
         KcqA==
X-Gm-Message-State: AOAM5339E4b1amY4LpAKWz03eqg88cZVwt8nIp5KtFX0lYBRI6XfOwDj
        MMpoFC0G8sqNmKQ0JPqTYA/VPUYh6Q8=
X-Google-Smtp-Source: ABdhPJxb+uOEaM8rhYUbnlc/TPyswUOTNBXyjnqJz4eRbWkTODtbJzHqG6pxXcfErquCYg6GPcmbZA==
X-Received: by 2002:ae9:c211:: with SMTP id j17mr6165393qkg.458.1603867895755;
        Tue, 27 Oct 2020 23:51:35 -0700 (PDT)
Received: from ubuntu-m3-large-x86 ([2604:1380:45d1:2600::3])
        by smtp.gmail.com with ESMTPSA id b23sm2396284qkh.68.2020.10.27.23.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 23:51:34 -0700 (PDT)
Date:   Tue, 27 Oct 2020 23:51:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH v3] seq_file: fix clang warning for NULL pointer
 arithmetic
Message-ID: <20201028065132.GA4099162@ubuntu-m3-large-x86>
References: <20201027221916.463235-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201027221916.463235-1-arnd@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 27, 2020 at 11:18:24PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> Clang points out that adding something to NULL is notallowed
                                                    not allowed
> in standard C:
> 
> fs/kernfs/file.c:127:15: warning: performing pointer arithmetic on a
> null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>                 return NULL + !*ppos;
>                        ~~~~ ^
> fs/seq_file.c:529:14: warning: performing pointer arithmetic on a
> null pointer has undefined behavior [-Wnull-pointer-arithmetic]
>         return NULL + (*pos == 0);
> 
> Rephrase the code to be extra explicit about the valid, giving

                                                   valid what?

> them named SEQ_OPEN_EOF and SEQ_OPEN_SINGLE definitions.
> The instance in kernfs was copied from single_start, so fix both
> at once.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Fixes: c2b19daf6760 ("sysfs, kernfs: prepare read path for kernfs")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Aside from the minor nits in the commit message, this should keep the
same behavior while eliminating the warning and making it a little
easier to understand.

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> ---
> v2: add the named macros after Christoph Hellwig pointed out
> that my original logic was too ugly.
> Suggestions for better names welcome
> 
> v3: don't overload the NULL return, avoid ?: operator
> ---
>  fs/kernfs/file.c         | 9 ++++++---
>  fs/seq_file.c            | 5 ++++-
>  include/linux/seq_file.h | 2 ++
>  3 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/kernfs/file.c b/fs/kernfs/file.c
> index f277d023ebcd..5a5adb03c6df 100644
> --- a/fs/kernfs/file.c
> +++ b/fs/kernfs/file.c
> @@ -121,10 +121,13 @@ static void *kernfs_seq_start(struct seq_file *sf, loff_t *ppos)
>  		return next;
>  	} else {
>  		/*
> -		 * The same behavior and code as single_open().  Returns
> -		 * !NULL if pos is at the beginning; otherwise, NULL.
> +		 * The same behavior and code as single_open().  Continues
> +		 * if pos is at the beginning; otherwise, NULL.
>  		 */
> -		return NULL + !*ppos;
> +		if (*ppos)
> +			return NULL;
> +
> +		return SEQ_OPEN_SINGLE;
>  	}
>  }
>  
> diff --git a/fs/seq_file.c b/fs/seq_file.c
> index 31219c1db17d..6b467d769501 100644
> --- a/fs/seq_file.c
> +++ b/fs/seq_file.c
> @@ -526,7 +526,10 @@ EXPORT_SYMBOL(seq_dentry);
>  
>  static void *single_start(struct seq_file *p, loff_t *pos)
>  {
> -	return NULL + (*pos == 0);
> +	if (*pos)
> +	       return NULL;
> +
> +	return SEQ_OPEN_SINGLE;
>  }
>  
>  static void *single_next(struct seq_file *p, void *v, loff_t *pos)
> diff --git a/include/linux/seq_file.h b/include/linux/seq_file.h
> index 813614d4b71f..eb344448d4da 100644
> --- a/include/linux/seq_file.h
> +++ b/include/linux/seq_file.h
> @@ -37,6 +37,8 @@ struct seq_operations {
>  
>  #define SEQ_SKIP 1
>  
> +#define SEQ_OPEN_SINGLE	(void *)1
> +
>  /**
>   * seq_has_overflowed - check if the buffer has overflowed
>   * @m: the seq_file handle
> -- 
> 2.27.0
> 

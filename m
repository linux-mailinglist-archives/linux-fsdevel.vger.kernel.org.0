Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C23473543
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jul 2019 19:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfGXRQw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jul 2019 13:16:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33055 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbfGXRQv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jul 2019 13:16:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so21278490pfq.0;
        Wed, 24 Jul 2019 10:16:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=156P/sv9kl3W4lzShHBiZ6Cb3GP3B3vD0ubCKwHKThU=;
        b=ogZkITl+R1w0hlSIWbPt04yOFXv9P1LNco/jXgKGy6aCdE5vvKx725w0Yn5VLJQsGT
         flYPS3UmtM44igz+SqHnUdE1uRJXIg7BOnlu+/LOWDPyT/j7pZ3dN7G7kWpS3ioASkTs
         5Z5unLj5Uq2mFnJ8qvBvnVqCCzFn/gMLRjLq8TEDqaAiXAgUyYu/Psg5B2pTjRndZg7U
         QebIeliYQQczUaMNqVVoBwyp6vVOBfv1uDVsuRTr4h0DLnkrk6F3rlPdyAH3mmzBGxxC
         dB6WRBN691blgNgtINJ/cWxZPKv0VBvcCP0u8sEbgfXQGGSH+99KBbTD2tXP3P8jlcBz
         MSDg==
X-Gm-Message-State: APjAAAXJbteQYt2/BlkRDh3PDcca0tn7Lv0JStjcMeM8Pyrp/2vdQHXP
        xVP/ku5ZyOBQMH4pIhJ1v4Q=
X-Google-Smtp-Source: APXvYqwTVGKd3fvTa9LEjWhqIcTFIJiIjYs9TLAcnxEPWXeforQowmcaSvI2CRLGqprBSYmGXcozlQ==
X-Received: by 2002:a17:90a:8a91:: with SMTP id x17mr89006769pjn.95.1563988610289;
        Wed, 24 Jul 2019 10:16:50 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id n140sm49450927pfd.132.2019.07.24.10.16.49
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 10:16:49 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id ADB7B402A1; Wed, 24 Jul 2019 17:16:48 +0000 (UTC)
Date:   Wed, 24 Jul 2019 17:16:48 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Palmer Dabbelt <palmer@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH REBASE v4 12/14] mips: Replace arch specific way to
 determine 32bit task with generic version
Message-ID: <20190724171648.GW19023@42.do-not-panic.com>
References: <20190724055850.6232-1-alex@ghiti.fr>
 <20190724055850.6232-13-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190724055850.6232-13-alex@ghiti.fr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 24, 2019 at 01:58:48AM -0400, Alexandre Ghiti wrote:
> Mips uses TASK_IS_32BIT_ADDR to determine if a task is 32bit, but
> this define is mips specific and other arches do not have it: instead,
> use !IS_ENABLED(CONFIG_64BIT) || is_compat_task() condition.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  arch/mips/mm/mmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index faa5aa615389..d4eafbb82789 100644
> --- a/arch/mips/mm/mmap.c
> +++ b/arch/mips/mm/mmap.c
> @@ -17,6 +17,7 @@
>  #include <linux/sched/signal.h>
>  #include <linux/sched/mm.h>
>  #include <linux/sizes.h>
> +#include <linux/compat.h>
>  
>  unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
>  EXPORT_SYMBOL(shm_align_mask);
> @@ -191,7 +192,7 @@ static inline unsigned long brk_rnd(void)
>  
>  	rnd = rnd << PAGE_SHIFT;
>  	/* 32MB for 32bit, 1GB for 64bit */
> -	if (TASK_IS_32BIT_ADDR)
> +	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
>  		rnd = rnd & SZ_32M;
>  	else
>  		rnd = rnd & SZ_1G;
> -- 

Since there are at least two users why not just create an inline for
this which describes what we are looking for and remove the comments?

  Luis

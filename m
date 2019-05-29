Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6CF92E5E0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2019 22:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726718AbfE2UM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 May 2019 16:12:27 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36103 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfE2UM1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 May 2019 16:12:27 -0400
Received: by mail-pf1-f193.google.com with SMTP id u22so2349376pfm.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 29 May 2019 13:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0aft1pCaWtRYtnkCVrHz1gsURga5CiN4SjNK2Yoiqfs=;
        b=XrzLaKA5MBHx0xlQKOcw3TIc85QvkhgJkO2JlDacDh+XCgUjABQyymyiZ/G560P5jJ
         HkAij558NkgyQQddecvDdQLSq5ZIicJMj+V7FdjS/5Qp/CTG9jIYFMaRFN3A7NFwUjgi
         FNTYdjrs48vkuDxAgacSirUU/cz2L2J9fobnY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0aft1pCaWtRYtnkCVrHz1gsURga5CiN4SjNK2Yoiqfs=;
        b=dz8VJUe7i8yIPvUgW95ovwWcgwW1ks0kbF9utbD8FDVJL/7B7l0xiVCKsM460xhy39
         AKEFxOk8Sr0E96sj29a7jZVhd0RgryJhNl43xz9DwCe3nKpZaDVnmtYPIHgcDlgzDf48
         6fQMOJI+N5w09KFEgHCQ2hiKKUkIghbbYUoYf0mFV9xSmta8IOsy6WrMGgeqNUdV82zI
         cBA0WUQmev1yB8aXD2M3BNShhogT9oIclRs0p18JFFO98wycIGJH9uFsnCdLoa86bkoM
         LW5H7+bsGNa2DJZxJFk9IHQef4mOzXOIEbhCZ/pu4NOw14uI1bVoyEBp4uPv8j91/4XL
         XMZw==
X-Gm-Message-State: APjAAAUPksW4bDhAM20ttx5Di+VnnbPnW7kHf8vYoYJ7Oc5ehIbaMcmg
        sfpC/bBldVo3bpFzhn8a1eLZbA==
X-Google-Smtp-Source: APXvYqwc7/sGYBIou0XJOLY+/Ol3XK8SIbVohsGySQ6NBMh2dCNE0NA9cvRsEXWPqWrlHnSoWF5LlQ==
X-Received: by 2002:aa7:8d81:: with SMTP id i1mr126561827pfr.244.1559160746780;
        Wed, 29 May 2019 13:12:26 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id d9sm220941pgj.34.2019.05.29.13.12.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 29 May 2019 13:12:25 -0700 (PDT)
Date:   Wed, 29 May 2019 13:12:25 -0700
From:   Kees Cook <keescook@chromium.org>
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
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 12/14] mips: Replace arch specific way to determine
 32bit task with generic version
Message-ID: <201905291312.7B8EBE955@keescook>
References: <20190526134746.9315-1-alex@ghiti.fr>
 <20190526134746.9315-13-alex@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190526134746.9315-13-alex@ghiti.fr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, May 26, 2019 at 09:47:44AM -0400, Alexandre Ghiti wrote:
> Mips uses TASK_IS_32BIT_ADDR to determine if a task is 32bit, but
> this define is mips specific and other arches do not have it: instead,
> use !IS_ENABLED(CONFIG_64BIT) || is_compat_task() condition.
> 
> Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> ---
>  arch/mips/mm/mmap.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> index c052565b76fb..900670ea8531 100644
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
> 2.20.1
> 

-- 
Kees Cook

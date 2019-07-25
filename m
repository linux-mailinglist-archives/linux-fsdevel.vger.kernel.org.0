Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 519FB75883
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 Jul 2019 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfGYUAg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 16:00:36 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33670 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbfGYUAf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 16:00:35 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so14322877pgj.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 25 Jul 2019 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=czhvpuMA3newxUE1Ok0eyKdEKMeSe/BMrFd/BkJbH88=;
        b=VFAYa7L009E7Uphizuk8EUTkPs3Kp07Ow0349Bvlb5HNDgpvBrzunrXj9n7hha+kMS
         bUM5MSI0W1TI2wdDk/dt+iOAY/2LqMW2igW+v6EdmydphptD2J677zHoPzFb2KTmBouE
         B/nckqeeuspAcsyRQBtXmWSYaDMekv/0MycuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=czhvpuMA3newxUE1Ok0eyKdEKMeSe/BMrFd/BkJbH88=;
        b=j3b5EiLAI4KQ1m/6z6DfUsHXuDqUBhKStBxsI5L106kcquKlbJ9ZWhUDegN6Y2JZ2i
         xk83JVCut32VDW1lvOwIW2n57ol/tvBzNXZgMHQTe9lky466M/Y7ZtYBA0hg6l2YoVNi
         0bewQcdzIbtgTJauKwV4ccPF9DeoDIBenQ7atZpevxw+XSaNRe7+TiEuD3R4RBB/wyFf
         bN9qvmXVxD4rEO0/qU2e2kT4WoggEiXKEtTN7+u75zK+Xosx+BK5keXaJTLlJR0lnS27
         rvqFQVkoO9pgdT2R9f5BSifXvhvP7MI0mCiuhtcYmJYeiLKhSCsizSPiqkDGlwFnHokw
         YDtg==
X-Gm-Message-State: APjAAAW4+/Uexmh9LVm1pPgrHRvRDpO50lldOgCgAs077JtsT6wPbHyk
        J74PJkoYwxgmcfIAHYnyOcUFTQ==
X-Google-Smtp-Source: APXvYqxpPEGm+2UHeZbjVl2jSdGpMi/b2Xe2soYfLXU2pENpqL6KqScEe4kJzeeCzenWEThRkjVa+g==
X-Received: by 2002:aa7:9713:: with SMTP id a19mr465671pfg.64.1564084835161;
        Thu, 25 Jul 2019 13:00:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j1sm75405528pgl.12.2019.07.25.13.00.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 25 Jul 2019 13:00:34 -0700 (PDT)
Date:   Thu, 25 Jul 2019 13:00:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Alexandre Ghiti <alex@ghiti.fr>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Paul Burton <paul.burton@mips.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        James Hogan <jhogan@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-mips@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        linux-arm-kernel@lists.infradead.org,
        Luis Chamberlain <mcgrof@kernel.org>
Subject: Re: [PATCH REBASE v4 11/14] mips: Adjust brk randomization offset to
 fit generic version
Message-ID: <201907251259.09E0101@keescook>
References: <20190724055850.6232-1-alex@ghiti.fr>
 <20190724055850.6232-12-alex@ghiti.fr>
 <1ba4061a-c026-3b9e-cd91-3ed3a26fce1b@ghiti.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ba4061a-c026-3b9e-cd91-3ed3a26fce1b@ghiti.fr>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 25, 2019 at 08:22:06AM +0200, Alexandre Ghiti wrote:
> On 7/24/19 7:58 AM, Alexandre Ghiti wrote:
> > This commit simply bumps up to 32MB and 1GB the random offset
> > of brk, compared to 8MB and 256MB, for 32bit and 64bit respectively.
> > 
> > Suggested-by: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Alexandre Ghiti <alex@ghiti.fr>
> > Reviewed-by: Kees Cook <keescook@chromium.org>
> > ---
> >   arch/mips/mm/mmap.c | 7 ++++---
> >   1 file changed, 4 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/mips/mm/mmap.c b/arch/mips/mm/mmap.c
> > index a7e84b2e71d7..faa5aa615389 100644
> > --- a/arch/mips/mm/mmap.c
> > +++ b/arch/mips/mm/mmap.c
> > @@ -16,6 +16,7 @@
> >   #include <linux/random.h>
> >   #include <linux/sched/signal.h>
> >   #include <linux/sched/mm.h>
> > +#include <linux/sizes.h>
> >   unsigned long shm_align_mask = PAGE_SIZE - 1;	/* Sane caches */
> >   EXPORT_SYMBOL(shm_align_mask);
> > @@ -189,11 +190,11 @@ static inline unsigned long brk_rnd(void)
> >   	unsigned long rnd = get_random_long();
> >   	rnd = rnd << PAGE_SHIFT;
> > -	/* 8MB for 32bit, 256MB for 64bit */
> > +	/* 32MB for 32bit, 1GB for 64bit */
> >   	if (TASK_IS_32BIT_ADDR)
> > -		rnd = rnd & 0x7ffffful;
> > +		rnd = rnd & SZ_32M;
> >   	else
> > -		rnd = rnd & 0xffffffful;
> > +		rnd = rnd & SZ_1G;
> >   	return rnd;
> >   }
> 
> Hi Andrew,
> 
> I have just noticed that this patch is wrong, do you want me to send
> another version of the entire series or is the following diff enough ?
> This mistake gets fixed anyway in patch 13/14 when it gets merged with the
> generic version.

While I can't speak for Andrew, I'd say, since you've got Paul and
Luis's Acks to add now, I'd say go ahead and respin with the fix and the
Acks added.

I'm really looking forward to this cleanup! Thanks again for working on
it. :)

-- 
Kees Cook

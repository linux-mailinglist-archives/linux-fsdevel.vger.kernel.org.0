Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4F06183DAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 01:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCMAAc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Mar 2020 20:00:32 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37416 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgCMAAc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Mar 2020 20:00:32 -0400
Received: by mail-pj1-f67.google.com with SMTP id ca13so3341676pjb.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Mar 2020 17:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=68Cq5h+6GaqQ99oSPAy6IaN4rpXx7c2iWTnSQGSX7Aw=;
        b=dEoqxqf1i30Hqx1/xFGfas8I7FnPfE7HxFpLMkCILtUDLqZhex57zJ/JEu7kOHQRdZ
         EKav1f8IYK2fxkrBBXA3uAc+nNPcN+1Guio6L0do+O3oV+j8OelQ1sonxdnzc+XJFIZ8
         kxkLdSbC+Z3uNOjUyoUZovQpWcGR5gjC3hXh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=68Cq5h+6GaqQ99oSPAy6IaN4rpXx7c2iWTnSQGSX7Aw=;
        b=GnEyzDwyjXYRdk9gNIETHpG4aXoKN4e6hir2G3Ps8Z5f9hpMbL1GeOYnjmrxOsWwMs
         NM4zYCjd4zf5TgBWPtMVhGrwTTMSmc+jenFXpRPwt8dDrUwcmKCQaDUPIeF79OtlfWKD
         5+JPuiytr5zahmcK5a/pZVGJHX3lvaNPJMbMwdfsDDdfHWoswZS5ic8PhZRRIdF99Kna
         jsu8cwvf4NNrs0eAqRczXQTLDGpGajYNS/rAAWfAmmpWy6JRnFSWcKSP+I/ToDzXgf9a
         DipJ6ebZqujJXHbeaQgjGJXnxCozEYjw9/AKvI5LtuJQaETlxnYpN2/GQLZssKnZhi1X
         n15w==
X-Gm-Message-State: ANhLgQ2J/7LgDVePPzceQ1Qc5NYjpv2ueSqoIQVOeA33Iy/EIF0mn8Zw
        hIHziQ0rkbEeKsKNDAT3BojA8Q==
X-Google-Smtp-Source: ADFU+vvUroD1W1qqX0EjqEWCImiHJfbhkJXYYbkKwy3WRva09w1jh4DoGHfxFTEJwE4ce0YverNKyg==
X-Received: by 2002:a17:902:868d:: with SMTP id g13mr10761455plo.36.1584057631106;
        Thu, 12 Mar 2020 17:00:31 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 72sm44462738pgd.86.2020.03.12.17.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 17:00:30 -0700 (PDT)
Date:   Thu, 12 Mar 2020 17:00:29 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu " <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        Richard Henderson <richard.henderson@linaro.org>,
        Kristina =?utf-8?Q?Mart=C5=A1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Daniel Kiss <daniel.kiss@arm.com>
Subject: Re: [PATCH v9 12/13] mm: smaps: Report arm64 guarded pages in smaps
Message-ID: <202003121700.C10E9E5@keescook>
References: <20200311192608.40095-1-broonie@kernel.org>
 <20200311192608.40095-13-broonie@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200311192608.40095-13-broonie@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 11, 2020 at 07:26:07PM +0000, Mark Brown wrote:
> From: Daniel Kiss <daniel.kiss@arm.com>
> 
> The arm64 Branch Target Identification support is activated by marking
> executable pages as guarded pages.  Report pages mapped this way in
> smaps to aid diagnostics.
> 
> Signed-off-by: Daniel Kiss <daniel.kiss@arm.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-Kees

> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>  Documentation/filesystems/proc.txt | 1 +
>  fs/proc/task_mmu.c                 | 3 +++
>  2 files changed, 4 insertions(+)
> 
> diff --git a/Documentation/filesystems/proc.txt b/Documentation/filesystems/proc.txt
> index 99ca040e3f90..ed5465d0f435 100644
> --- a/Documentation/filesystems/proc.txt
> +++ b/Documentation/filesystems/proc.txt
> @@ -519,6 +519,7 @@ manner. The codes are the following:
>      hg  - huge page advise flag
>      nh  - no-huge page advise flag
>      mg  - mergable advise flag
> +    bt  - arm64 BTI guarded page
>  
>  Note that there is no guarantee that every flag and associated mnemonic will
>  be present in all further kernel releases. Things get changed, the flags may
> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
> index 3ba9ae83bff5..1e3409c484d1 100644
> --- a/fs/proc/task_mmu.c
> +++ b/fs/proc/task_mmu.c
> @@ -668,6 +668,9 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>  		[ilog2(VM_ARCH_1)]	= "ar",
>  		[ilog2(VM_WIPEONFORK)]	= "wf",
>  		[ilog2(VM_DONTDUMP)]	= "dd",
> +#ifdef CONFIG_ARM64_BTI
> +		[ilog2(VM_ARM64_BTI)]	= "bt",
> +#endif
>  #ifdef CONFIG_MEM_SOFT_DIRTY
>  		[ilog2(VM_SOFTDIRTY)]	= "sd",
>  #endif
> -- 
> 2.20.1
> 

-- 
Kees Cook

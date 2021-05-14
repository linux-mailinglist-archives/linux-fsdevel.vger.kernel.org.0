Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7B938062B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 May 2021 11:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhENJ1B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 May 2021 05:27:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42975 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhENJ1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 May 2021 05:27:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620984349;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Fx334L5vVgVDfx7L2kVeRZ1gFR/dFDyujA5YMe7z6io=;
        b=S5lFNU5TQKD03U47KGRUq0qxXj401VvzZwf8ycDk75sZ8elD6zmYfr8ormTPVmnMFlB//f
        k7DIspm8Yj8j769M+pu58fgnypnwOYb1A7IAdw2hBPD/n1GZwGdpwstsH11YZVHvVvpX7A
        tkxkRTd+2YudBVAMGoeBZyeF6WdzMDE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-436-3vBFMSz7OE6mXwrER_Rbvg-1; Fri, 14 May 2021 05:25:47 -0400
X-MC-Unique: 3vBFMSz7OE6mXwrER_Rbvg-1
Received: by mail-ed1-f71.google.com with SMTP id h18-20020a05640250d2b029038cc3938914so4393681edb.17
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 May 2021 02:25:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:organization:subject
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Fx334L5vVgVDfx7L2kVeRZ1gFR/dFDyujA5YMe7z6io=;
        b=XK8D09Ure3CzRUuOWdrC7egw3p+lt8IfRwD3/p+GHBpnexGMdtbTBhs8Dp1M5zuubl
         DZxTwRjyu2zR8ER4k1l/HbmYMqdayswXwCVgyBT6SDJWZ2/nkEQbXfDUS2/HmMVrRfle
         2SWC/6dOTqhuH/j/IHA8kJFjlSl9EhDCrp7irZPB0rDkdsQEl4MOMoLQE1QHG/EPl1Zj
         KhKisyDsj87PWKw/Q1f8j8TY9mtynbub9CEKc7xuzeWurp6vP0hw4M11cnNLM6CrLEOI
         ZXi0IgsfI2JqSxlty8mGLNr0Fa9+7cSrPZe8ta6XwWsQpcuaNzm5Csm9yq9pSZKj5ySz
         U+Bw==
X-Gm-Message-State: AOAM531hKQEQTz2J3I4QmAOvM2w8MfVbfBr/JvYQVdXannA2yhaHwuoB
        mxABDgvDNDHxV/ThyFO/fj4oayApx+C7KPGk7gQto+z8f9scsO7h8AEYq2ycc+sZOXTKCkT6O0k
        TzxtO2+7/eqxdkHEQjIk1Bc1qNQ==
X-Received: by 2002:a50:cd57:: with SMTP id d23mr54117135edj.5.1620984346385;
        Fri, 14 May 2021 02:25:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwffpojWIdDjWYW/MMXX/wRjb+C923CYpz5CDGlKRq9NSx2v+gQE16nA0IMA6MthtTXx38cuQ==
X-Received: by 2002:a50:cd57:: with SMTP id d23mr54117114edj.5.1620984346105;
        Fri, 14 May 2021 02:25:46 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c6501.dip0.t-ipconnect.de. [91.12.101.1])
        by smtp.gmail.com with ESMTPSA id gt12sm3267244ejb.60.2021.05.14.02.25.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 May 2021 02:25:45 -0700 (PDT)
To:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Hagen Paul Pfeifer <hagen@jauu.net>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Kees Cook <keescook@chromium.org>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
Date:   Fri, 14 May 2021 11:25:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210513184734.29317-6-rppt@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>   #ifdef CONFIG_IA64
>   # include <linux/efi.h>
> @@ -64,6 +65,9 @@ static inline int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
>   #ifdef CONFIG_STRICT_DEVMEM
>   static inline int page_is_allowed(unsigned long pfn)
>   {
> +	if (pfn_valid(pfn) && page_is_secretmem(pfn_to_page(pfn)))
> +		return 0;
> +

1. The memmap might be garbage. You should use pfn_to_online_page() instead.

page = pfn_to_online_page(pfn);
if (page && page_is_secretmem(page))
	return 0;

2. What about !CONFIG_STRICT_DEVMEM?

3. Someone could map physical memory before a secretmem page gets 
allocated and read the content after it got allocated and gets used. If 
someone would gain root privileges and would wait for the target 
application to (re)start, that could be problematic.


I do wonder if enforcing CONFIG_STRICT_DEVMEM would be cleaner. 
devmem_is_allowed() should disallow access to any system ram, and 
thereby, any possible secretmem pages, avoiding this check completely.


[...]

>   
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> new file mode 100644
> index 000000000000..1ae50089adf1
> --- /dev/null
> +++ b/mm/secretmem.c
> @@ -0,0 +1,239 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright IBM Corporation, 2021
> + *
> + * Author: Mike Rapoport <rppt@linux.ibm.com>
> + */
> +
> +#include <linux/mm.h>
> +#include <linux/fs.h>
> +#include <linux/swap.h>
> +#include <linux/mount.h>
> +#include <linux/memfd.h>
> +#include <linux/bitops.h>
> +#include <linux/printk.h>
> +#include <linux/pagemap.h>
> +#include <linux/syscalls.h>
> +#include <linux/pseudo_fs.h>
> +#include <linux/secretmem.h>
> +#include <linux/set_memory.h>
> +#include <linux/sched/signal.h>
> +
> +#include <uapi/linux/magic.h>
> +
> +#include <asm/tlbflush.h>
> +
> +#include "internal.h"
> +
> +#undef pr_fmt
> +#define pr_fmt(fmt) "secretmem: " fmt
> +
> +/*
> + * Define mode and flag masks to allow validation of the system call
> + * parameters.
> + */
> +#define SECRETMEM_MODE_MASK	(0x0)
> +#define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
> +
> +static bool secretmem_enable __ro_after_init;
> +module_param_named(enable, secretmem_enable, bool, 0400);
> +MODULE_PARM_DESC(secretmem_enable,
> +		 "Enable secretmem and memfd_secret(2) system call");
> +
> +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> +{
> +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> +	struct inode *inode = file_inode(vmf->vma->vm_file);
> +	pgoff_t offset = vmf->pgoff;
> +	gfp_t gfp = vmf->gfp_mask;
> +	unsigned long addr;
> +	struct page *page;
> +	int err;
> +
> +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> +		return vmf_error(-EINVAL);
> +
> +retry:
> +	page = find_lock_page(mapping, offset);
> +	if (!page) {
> +		page = alloc_page(gfp | __GFP_ZERO);

We'll end up here with gfp == GFP_HIGHUSER (via the mapping below), correct?

> +		if (!page)
> +			return VM_FAULT_OOM;
> +
> +		err = set_direct_map_invalid_noflush(page, 1);
> +		if (err) {
> +			put_page(page);
> +			return vmf_error(err);

Would we want to translate that to a proper VM_FAULT_..., which would 
most probably be VM_FAULT_OOM when we fail to allocate a pagetable?

> +		}
> +
> +		__SetPageUptodate(page);
> +		err = add_to_page_cache_lru(page, mapping, offset, gfp);
> +		if (unlikely(err)) {
> +			put_page(page);
> +			/*
> +			 * If a split of large page was required, it
> +			 * already happened when we marked the page invalid
> +			 * which guarantees that this call won't fail
> +			 */
> +			set_direct_map_default_noflush(page, 1);
> +			if (err == -EEXIST)
> +				goto retry;
> +
> +			return vmf_error(err);
> +		}
> +
> +		addr = (unsigned long)page_address(page);
> +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);

Hmm, to me it feels like something like that belongs into the 
set_direct_map_invalid_*() calls? Otherwise it's just very easy to mess 
up ...


I'm certainly not a filesystem guy. Nothing else jumped at me.


To me, the overall approach makes sense and I consider it an improved 
mlock() mechanism for storing secrets, although I'd love to have some 
more information in the log regarding access via root, namely that there 
are still fancy ways to read secretmem memory once root via

1. warm reboot attacks especially in VMs (e.g., modifying the cmdline)
2. kexec-style reboot attacks (e.g., modifying the cmdline)
3. kdump attacks
4. kdb most probably
5. "letting the process read the memory for us" via Kees if that still
    applies
6. ... most probably something else

Just to make people aware that there are still some things to be sorted 
out when we fully want to protect against privilege escalations.

(maybe this information is buried in the cover letter already, where it 
usually gets lost)

-- 
Thanks,

David / dhildenb


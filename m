Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3FBD2C19F1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 01:28:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729278AbgKXA02 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Nov 2020 19:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729107AbgKXA01 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Nov 2020 19:26:27 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1278C0613CF;
        Mon, 23 Nov 2020 16:26:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id k5so3291911plt.6;
        Mon, 23 Nov 2020 16:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:subject:to:cc:newsgroups:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Nt3WL/sMZDFdQ0jAbOhXhrOfUwobfRhA4oYHScZyEuA=;
        b=Oc54z6HIkJQlFjkPTcr65cfgUp+grLzgjNRN4/CJ1+XKQWLG5D12r7elXf4hS19Uap
         7S6Kbe4/Xau6BCwvExNeAoQ4jm1ZA49Ex76lhFBxxcLfCGTAyxqnZb6LJKtir5hanryj
         W/novpTZ0kcl/7Lt3HhjbZQvL8hLnEMnJOKsGrNGGY5YxLoedCtMLiZFiKAIknj1sIGa
         KrPYNf3D2q1jAzZACjf2b36x7EpsJwo6CLbMoQdRfFu0GzXwP7nwF6a8+bLz0HHwzQMu
         tmwVtWgApsX8Jo00b+rsMZLa52Kfxozy1t4hV/QAvfnJtcI0Bn+XqCeK4LODz51vbCko
         EE6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:subject:to:cc:newsgroups:references
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Nt3WL/sMZDFdQ0jAbOhXhrOfUwobfRhA4oYHScZyEuA=;
        b=QDnvEsDlhXDEISFft2AQ00JMVPWTDzAjYUv1/Y8LQKAg3cROlNUOPGtTPqzENe9QyY
         gkHWJU9AVHBEbwan27uHgzPxi3zI3tduhh/3+21dYwcv1qdhcAdQFgtklFqtS4VNr5Ul
         VDFNbdOfnfkIaJ3MHcFL7e9Quzf3TLR/ByHRaQVIusjRGcsQjGIC3WtvT/0smxc44LRf
         zXEaO+qdDBMmslqGMVhVzV+0RCNq5W7A0KC3FZYqfIZ00wFCs9N0It32YQA8NBtJH/IG
         fw9+cNfH565xpsZmSp18fOddVrkN6PffY9ZdCZPdik1LUObUThq3SaKkExrg9s/YbLTO
         FVPw==
X-Gm-Message-State: AOAM5334Figrq+D1EU+e3TO+sLnHRHxUr018MGNLBJA/T1Sd40QGulDU
        b/W/5rHKW/I0t2nGhec7UWg=
X-Google-Smtp-Source: ABdhPJxCEhCjGIy2PVAc5Q4JGQ5FebvcnHmsaAsAUqP8ddjKTbGi1i1Ua+KLRC8mYp1dd9Lt347RqA==
X-Received: by 2002:a17:902:778e:b029:d8:d024:a9a with SMTP id o14-20020a170902778eb02900d8d0240a9amr1721810pll.12.1606177584778;
        Mon, 23 Nov 2020 16:26:24 -0800 (PST)
Received: from [192.168.50.50] (c-24-4-73-83.hsd1.ca.comcast.net. [24.4.73.83])
        by smtp.gmail.com with ESMTPSA id ha21sm529493pjb.2.2020.11.23.16.26.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Nov 2020 16:26:24 -0800 (PST)
Sender: Vineet Gupta <vineetg76@gmail.com>
From:   Vineet Gupta <vgupta@synopsys.com>
Subject: Re: [PATCH v2 10/13] arc: use FLATMEM with freeing of unused memory
 map instead of DISCONTIGMEM
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>, Meelis Roos <mroos@linux.ee>,
        Michael Schmitz <schmitzmic@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        Tony Luck <tony.luck@intel.com>, Will Deacon <will@kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        arcml <linux-snps-arc@lists.infradead.org>
Newsgroups: gmane.linux.ports.ia64,gmane.linux.ports.alpha,gmane.linux.ports.arm.kernel,gmane.linux.documentation,gmane.linux.file-systems,gmane.linux.kernel,gmane.linux.kernel.mm
References: <20201101170454.9567-1-rppt@kernel.org>
 <20201101170454.9567-11-rppt@kernel.org>
 <3a1ef201-611b-3eb0-1a8a-4fcb05634b85@synopsys.com>
 <20201117065708.GD370813@kernel.org>
X-Mozilla-News-Host: news://news.gmane.io
Message-ID: <dfbbfa6c-15ea-bc64-d163-5c96c1df43a3@synopsys.com>
Date:   Mon, 23 Nov 2020 16:26:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201117065708.GD370813@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 11/16/20 10:57 PM, Mike Rapoport wrote:
> On Tue, Nov 17, 2020 at 06:40:16AM +0000, Vineet Gupta wrote:
>> Hi Mike,
>>
>> On 11/1/20 9:04 AM, Mike Rapoport wrote:
>>> From: Mike Rapoport <rppt@linux.ibm.com>
>>>
>>> Currently ARC uses DISCONTIGMEM to cope with sparse physical memory address
>>> space on systems with 2 memory banks. While DISCONTIGMEM avoids wasting
>>> memory on unpopulated memory map, it adds both memory and CPU overhead
>>> relatively to FLATMEM. Moreover, DISCONTINGMEM is generally considered
>>> deprecated.
>>>
>>> The obvious replacement for DISCONTIGMEM would be SPARSEMEM, but it is also
>>> less efficient than FLATMEM in pfn_to_page() and page_to_pfn() conversions.
>>> Besides it requires tuning of SECTION_SIZE which is not trivial for
>>> possible ARC memory configuration.
>>>
>>> Since the memory map for both banks is always allocated from the "lowmem"
>>> bank, it is possible to use FLATMEM for two-bank configuration and simply
>>> free the unused hole in the memory map. All is required for that is to
>>> provide ARC-specific pfn_valid() that will take into account actual
>>> physical memory configuration and define HAVE_ARCH_PFN_VALID.
>>>
>>> The resulting kernel image configured with defconfig + HIGHMEM=y is
>>> smaller:
>>>
>>> $ size a/vmlinux b/vmlinux
>>>      text    data     bss     dec     hex filename
>>> 4673503 1245456  279756 6198715  5e95bb a/vmlinux
>>> 4658706 1246864  279756 6185326  5e616e b/vmlinux
>>>
>>> $ ./scripts/bloat-o-meter a/vmlinux b/vmlinux
>>> add/remove: 28/30 grow/shrink: 42/399 up/down: 10986/-29025 (-18039)
>>> ...
>>> Total: Before=4709315, After=4691276, chg -0.38%
>>>
>>> Booting nSIM with haps_ns.dts results in the following memory usage
>>> reports:
>>>
>>> a:
>>> Memory: 1559104K/1572864K available (3531K kernel code, 595K rwdata, 752K rodata, 136K init, 275K bss, 13760K reserved, 0K cma-reserved, 1048576K highmem)
>>>
>>> b:
>>> Memory: 1559112K/1572864K available (3519K kernel code, 594K rwdata, 752K rodata, 136K init, 280K bss, 13752K reserved, 0K cma-reserved, 1048576K highmem)
>>>
>>> Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>

To avoid any surprises later, I tested that highmem was actually working 
on real hardware (HSDK-4xD dev platform) with modified hsdk.dts to 
enable 2 GB of memory.

        reg = <0x0 0x80000000 0x0 0x40000000    /* 1 GB low mem */
-         0x1 0x00000000 0x0 0x40000000>;  /* 1 GB highmem PAE */
+         0x0 0x00000000 0x0 0x40000000>;  /* 1 GB highmem low phy mem*/
         };

A simple malloc+memset program can allocate upto 1.98 GB of memory.

# cat /proc/meminfo | grep Mem
MemTotal:        2077984 kB
MemFree:         2047512 kB
MemAvailable:    2005712 kB

# /oom 1000 &
# malloc 1000 MB
# Done memset, sleeping for 20 secs

# cat /proc/meminfo | grep Mem
MemTotal:        2077984 kB
MemFree:         1163888 kB
MemAvailable:    1122088 kB

# /oom 980 &
# malloc 980 MB
# Done memset, sleeping for 20 secs

# cat /proc/meminfo | grep Mem
MemTotal:        2077984 kB
MemFree:          239096 kB
MemAvailable:     197296 kB

# Done free.
Done free.

So this is all hunky-dory. Thanks for working on this Mike and improving 
things.

Acked-by: Vineet Gupta <vgupta@synopsys.com>

-Vineet

>>
>> Sorry this fell through the cracks. Do you have a branch I can checkout
>> and do a quick test.
> 
> It's in mmotm and in my tree:
> https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git memory-models/rm-discontig/v0
> 
>> Thx,
>> -Vineet
>>
>>> ---
>>>    arch/arc/Kconfig            |  3 ++-
>>>    arch/arc/include/asm/page.h | 20 +++++++++++++++++---
>>>    arch/arc/mm/init.c          | 29 ++++++++++++++++++++++-------
>>>    3 files changed, 41 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/arch/arc/Kconfig b/arch/arc/Kconfig
>>> index 0a89cc9def65..c874f8ab0341 100644
>>> --- a/arch/arc/Kconfig
>>> +++ b/arch/arc/Kconfig
>>> @@ -67,6 +67,7 @@ config GENERIC_CSUM
>>>    
>>>    config ARCH_DISCONTIGMEM_ENABLE
>>>    	def_bool n
>>> +	depends on BROKEN
>>>    
>>>    config ARCH_FLATMEM_ENABLE
>>>    	def_bool y
>>> @@ -506,7 +507,7 @@ config LINUX_RAM_BASE
>>>    
>>>    config HIGHMEM
>>>    	bool "High Memory Support"
>>> -	select ARCH_DISCONTIGMEM_ENABLE
>>> +	select HAVE_ARCH_PFN_VALID
>>>    	help
>>>    	  With ARC 2G:2G address split, only upper 2G is directly addressable by
>>>    	  kernel. Enable this to potentially allow access to rest of 2G and PAE
>>> diff --git a/arch/arc/include/asm/page.h b/arch/arc/include/asm/page.h
>>> index b0dfed0f12be..23e41e890eda 100644
>>> --- a/arch/arc/include/asm/page.h
>>> +++ b/arch/arc/include/asm/page.h
>>> @@ -82,11 +82,25 @@ typedef pte_t * pgtable_t;
>>>     */
>>>    #define virt_to_pfn(kaddr)	(__pa(kaddr) >> PAGE_SHIFT)
>>>    
>>> -#define ARCH_PFN_OFFSET		virt_to_pfn(CONFIG_LINUX_RAM_BASE)
>>> +/*
>>> + * When HIGHMEM is enabled we have holes in the memory map so we need
>>> + * pfn_valid() that takes into account the actual extents of the physical
>>> + * memory
>>> + */
>>> +#ifdef CONFIG_HIGHMEM
>>> +
>>> +extern unsigned long arch_pfn_offset;
>>> +#define ARCH_PFN_OFFSET		arch_pfn_offset
>>> +
>>> +extern int pfn_valid(unsigned long pfn);
>>> +#define pfn_valid		pfn_valid
>>>    
>>> -#ifdef CONFIG_FLATMEM
>>> +#else /* CONFIG_HIGHMEM */
>>> +
>>> +#define ARCH_PFN_OFFSET		virt_to_pfn(CONFIG_LINUX_RAM_BASE)
>>>    #define pfn_valid(pfn)		(((pfn) - ARCH_PFN_OFFSET) < max_mapnr)
>>> -#endif
>>> +
>>> +#endif /* CONFIG_HIGHMEM */
>>>    
>>>    /*
>>>     * __pa, __va, virt_to_page (ALERT: deprecated, don't use them)
>>> diff --git a/arch/arc/mm/init.c b/arch/arc/mm/init.c
>>> index 3a35b82a718e..ce07e697916c 100644
>>> --- a/arch/arc/mm/init.c
>>> +++ b/arch/arc/mm/init.c
>>> @@ -28,6 +28,8 @@ static unsigned long low_mem_sz;
>>>    static unsigned long min_high_pfn, max_high_pfn;
>>>    static phys_addr_t high_mem_start;
>>>    static phys_addr_t high_mem_sz;
>>> +unsigned long arch_pfn_offset;
>>> +EXPORT_SYMBOL(arch_pfn_offset);
>>>    #endif
>>>    
>>>    #ifdef CONFIG_DISCONTIGMEM
>>> @@ -98,16 +100,11 @@ void __init setup_arch_memory(void)
>>>    	init_mm.brk = (unsigned long)_end;
>>>    
>>>    	/* first page of system - kernel .vector starts here */
>>> -	min_low_pfn = ARCH_PFN_OFFSET;
>>> +	min_low_pfn = virt_to_pfn(CONFIG_LINUX_RAM_BASE);
>>>    
>>>    	/* Last usable page of low mem */
>>>    	max_low_pfn = max_pfn = PFN_DOWN(low_mem_start + low_mem_sz);
>>>    
>>> -#ifdef CONFIG_FLATMEM
>>> -	/* pfn_valid() uses this */
>>> -	max_mapnr = max_low_pfn - min_low_pfn;
>>> -#endif
>>> -
>>>    	/*------------- bootmem allocator setup -----------------------*/
>>>    
>>>    	/*
>>> @@ -153,7 +150,9 @@ void __init setup_arch_memory(void)
>>>    	 * DISCONTIGMEM in turns requires multiple nodes. node 0 above is
>>>    	 * populated with normal memory zone while node 1 only has highmem
>>>    	 */
>>> +#ifdef CONFIG_DISCONTIGMEM
>>>    	node_set_online(1);
>>> +#endif
>>>    
>>>    	min_high_pfn = PFN_DOWN(high_mem_start);
>>>    	max_high_pfn = PFN_DOWN(high_mem_start + high_mem_sz);
>>> @@ -161,8 +160,15 @@ void __init setup_arch_memory(void)
>>>    	max_zone_pfn[ZONE_HIGHMEM] = min_low_pfn;
>>>    
>>>    	high_memory = (void *)(min_high_pfn << PAGE_SHIFT);
>>> +
>>> +	arch_pfn_offset = min(min_low_pfn, min_high_pfn);
>>>    	kmap_init();
>>> -#endif
>>> +
>>> +#else /* CONFIG_HIGHMEM */
>>> +	/* pfn_valid() uses this when FLATMEM=y and HIGHMEM=n */
>>> +	max_mapnr = max_low_pfn - min_low_pfn;
>>> +
>>> +#endif /* CONFIG_HIGHMEM */
>>>    
>>>    	free_area_init(max_zone_pfn);
>>>    }
>>> @@ -190,3 +196,12 @@ void __init mem_init(void)
>>>    	highmem_init();
>>>    	mem_init_print_info(NULL);
>>>    }
>>> +
>>> +#ifdef CONFIG_HIGHMEM
>>> +int pfn_valid(unsigned long pfn)
>>> +{
>>> +	return (pfn >= min_high_pfn && pfn <= max_high_pfn) ||
>>> +		(pfn >= min_low_pfn && pfn <= max_low_pfn);
>>> +}
>>> +EXPORT_SYMBOL(pfn_valid);
>>> +#endif
>>
> 


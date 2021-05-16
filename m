Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B061381D3A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 May 2021 09:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233627AbhEPHa6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 May 2021 03:30:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:35618 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229807AbhEPHa6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 May 2021 03:30:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1E02561186;
        Sun, 16 May 2021 07:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621150183;
        bh=+OVDWA7/0Ml7ugiOtMv/uSOFjjO2dGH0xRQLpIVrDKo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eBhIrhYCTFIxc+VLsj8yA1Hoe59pJz4TDDp6gfkIUHKRIu0++Cr5KOBRH7zrVG52p
         jLfgetdQBPFyGyYlCbhHgrA81HExKP2ocYEBnwzrEhSEVffjHtkoz36MNZWcelhnjr
         noHKLnAroU/P6toelBVnxQ/nCrteyUNSBeOVQywuuFyCuwJ6KjRHTSSw3C+ibOdCJ3
         nZMC/S7X0atBwkdwhNBuFLlwXmQxpjArOHlAb4RGnRXLMyIjWStS2eO92iGNxGhb4j
         AFUJ5pyWh3JLWvb+t/p5OaBJRuDbt8Hej/cPyKYdFGX/8WcxIDRg2v902Yv7qfiYZ0
         ydk4b7ykNjpwQ==
Date:   Sun, 16 May 2021 10:29:24 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
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
Subject: Re: [PATCH v19 5/8] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <YKDJ1L7XpJRQgSch@kernel.org>
References: <20210513184734.29317-1-rppt@kernel.org>
 <20210513184734.29317-6-rppt@kernel.org>
 <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b625c5d7-bfcc-9e95-1f79-fc8b61498049@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 14, 2021 at 11:25:43AM +0200, David Hildenbrand wrote:
> >   #ifdef CONFIG_IA64
> >   # include <linux/efi.h>
> > @@ -64,6 +65,9 @@ static inline int valid_mmap_phys_addr_range(unsigned long pfn, size_t size)
> >   #ifdef CONFIG_STRICT_DEVMEM
> >   static inline int page_is_allowed(unsigned long pfn)
> >   {
> > +	if (pfn_valid(pfn) && page_is_secretmem(pfn_to_page(pfn)))
> > +		return 0;
> > +
> 
> 1. The memmap might be garbage. You should use pfn_to_online_page() instead.
> 
> page = pfn_to_online_page(pfn);
> if (page && page_is_secretmem(page))
> 	return 0;
> 
> 2. What about !CONFIG_STRICT_DEVMEM?
> 
> 3. Someone could map physical memory before a secretmem page gets allocated
> and read the content after it got allocated and gets used. If someone would
> gain root privileges and would wait for the target application to (re)start,
> that could be problematic.
> 
> 
> I do wonder if enforcing CONFIG_STRICT_DEVMEM would be cleaner.
> devmem_is_allowed() should disallow access to any system ram, and thereby,
> any possible secretmem pages, avoiding this check completely.

I've been thinking a bit more about the /dev/mem case, it seems I was to
fast on the trigger with adding that test for page_is_secretmem().

When CONFIG_STRICT_DEVMEM=y the access to RAM is anyway forbidden and if
the user built a kernel with CONFIG_STRICT_DEVMEM=n all the physical memory
is accessible by root anyway.

We might want to default STRICT_DEVMEM to "y" for all architectures and not
only arm64, ppc and x86, but this is not strictly related to this series.
 
> [...]
> 
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > new file mode 100644
> > index 000000000000..1ae50089adf1
> > --- /dev/null
> > +++ b/mm/secretmem.c
> > @@ -0,0 +1,239 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +/*
> > + * Copyright IBM Corporation, 2021
> > + *
> > + * Author: Mike Rapoport <rppt@linux.ibm.com>
> > + */
> > +
> > +#include <linux/mm.h>
> > +#include <linux/fs.h>
> > +#include <linux/swap.h>
> > +#include <linux/mount.h>
> > +#include <linux/memfd.h>
> > +#include <linux/bitops.h>
> > +#include <linux/printk.h>
> > +#include <linux/pagemap.h>
> > +#include <linux/syscalls.h>
> > +#include <linux/pseudo_fs.h>
> > +#include <linux/secretmem.h>
> > +#include <linux/set_memory.h>
> > +#include <linux/sched/signal.h>
> > +
> > +#include <uapi/linux/magic.h>
> > +
> > +#include <asm/tlbflush.h>
> > +
> > +#include "internal.h"
> > +
> > +#undef pr_fmt
> > +#define pr_fmt(fmt) "secretmem: " fmt
> > +
> > +/*
> > + * Define mode and flag masks to allow validation of the system call
> > + * parameters.
> > + */
> > +#define SECRETMEM_MODE_MASK	(0x0)
> > +#define SECRETMEM_FLAGS_MASK	SECRETMEM_MODE_MASK
> > +
> > +static bool secretmem_enable __ro_after_init;
> > +module_param_named(enable, secretmem_enable, bool, 0400);
> > +MODULE_PARM_DESC(secretmem_enable,
> > +		 "Enable secretmem and memfd_secret(2) system call");
> > +
> > +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > +{
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > +	struct inode *inode = file_inode(vmf->vma->vm_file);
> > +	pgoff_t offset = vmf->pgoff;
> > +	gfp_t gfp = vmf->gfp_mask;
> > +	unsigned long addr;
> > +	struct page *page;
> > +	int err;
> > +
> > +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > +		return vmf_error(-EINVAL);
> > +
> > +retry:
> > +	page = find_lock_page(mapping, offset);
> > +	if (!page) {
> > +		page = alloc_page(gfp | __GFP_ZERO);
> 
> We'll end up here with gfp == GFP_HIGHUSER (via the mapping below), correct?

Yes
 
> > +		if (!page)
> > +			return VM_FAULT_OOM;
> > +
> > +		err = set_direct_map_invalid_noflush(page, 1);
> > +		if (err) {
> > +			put_page(page);
> > +			return vmf_error(err);
> 
> Would we want to translate that to a proper VM_FAULT_..., which would most
> probably be VM_FAULT_OOM when we fail to allocate a pagetable?

That's what vmf_error does, it translates -ESOMETHING to VM_FAULT_XYZ.

> > +		}
> > +
> > +		__SetPageUptodate(page);
> > +		err = add_to_page_cache_lru(page, mapping, offset, gfp);
> > +		if (unlikely(err)) {
> > +			put_page(page);
> > +			/*
> > +			 * If a split of large page was required, it
> > +			 * already happened when we marked the page invalid
> > +			 * which guarantees that this call won't fail
> > +			 */
> > +			set_direct_map_default_noflush(page, 1);
> > +			if (err == -EEXIST)
> > +				goto retry;
> > +
> > +			return vmf_error(err);
> > +		}
> > +
> > +		addr = (unsigned long)page_address(page);
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> 
> Hmm, to me it feels like something like that belongs into the
> set_direct_map_invalid_*() calls? Otherwise it's just very easy to mess up
> ...

AFAIU set_direct_map() deliberately do not flush TLB and leave it to the
caller to allow gathering multiple updates of the direct map and doing a
single TLB flush afterwards.

> I'm certainly not a filesystem guy. Nothing else jumped at me.
> 
> 
> To me, the overall approach makes sense and I consider it an improved
> mlock() mechanism for storing secrets, although I'd love to have some more
> information in the log regarding access via root, namely that there are
> still fancy ways to read secretmem memory once root via
> 
> 1. warm reboot attacks especially in VMs (e.g., modifying the cmdline)
> 2. kexec-style reboot attacks (e.g., modifying the cmdline)
> 3. kdump attacks
> 4. kdb most probably
> 5. "letting the process read the memory for us" via Kees if that still
>    applies
> 6. ... most probably something else
> 
> Just to make people aware that there are still some things to be sorted out
> when we fully want to protect against privilege escalations.
> 
> (maybe this information is buried in the cover letter already, where it
> usually gets lost)

I believe that it belongs more to the man page than to changelog so that
the *users* are aware of secretmem limitations.
 
-- 
Sincerely yours,
Mike.

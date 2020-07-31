Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E10D234773
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731750AbgGaOKk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 10:10:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:58696 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728206AbgGaOKk (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 10:10:40 -0400
Received: from gaia (unknown [95.146.230.158])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52369206DA;
        Fri, 31 Jul 2020 14:10:34 +0000 (UTC)
Date:   Fri, 31 Jul 2020 15:10:31 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v2 3/7] mm: introduce memfd_secret system call to create
 "secret" memory areas
Message-ID: <20200731141031.GD29569@gaia>
References: <20200727162935.31714-1-rppt@kernel.org>
 <20200727162935.31714-4-rppt@kernel.org>
 <20200730162209.GB3128@gaia>
 <20200730204409.GB534153@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730204409.GB534153@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 11:44:09PM +0300, Mike Rapoport wrote:
> On Thu, Jul 30, 2020 at 05:22:10PM +0100, Catalin Marinas wrote:
> > On Mon, Jul 27, 2020 at 07:29:31PM +0300, Mike Rapoport wrote:
> > > For instance, the following example will create an uncached mapping (error
> > > handling is omitted):
> > > 
> > > 	fd = memfd_secret(SECRETMEM_UNCACHED);
> > > 	ftruncate(fd, MAP_SIZE);
> > > 	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
[...]
> > > +static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
> > > +{
> > > +	struct secretmem_ctx *ctx = file->private_data;
> > > +	unsigned long mode = ctx->mode;
> > > +	unsigned long len = vma->vm_end - vma->vm_start;
> > > +
> > > +	if (!mode)
> > > +		return -EINVAL;
> > > +
> > > +	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> > > +		return -EINVAL;
> > > +
> > > +	if (mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
> > > +		return -EAGAIN;
> > > +
> > > +	switch (mode) {
> > > +	case SECRETMEM_UNCACHED:
> > > +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > > +		fallthrough;
> > > +	case SECRETMEM_EXCLUSIVE:
> > > +		vma->vm_ops = &secretmem_vm_ops;
> > > +		break;
> > > +	default:
> > > +		return -EINVAL;
> > > +	}
> > > +
> > > +	vma->vm_flags |= VM_LOCKED;
> > > +
> > > +	return 0;
> > > +}
> > 
> > I think the uncached mapping is not the right thing for arm/arm64. First
> > of all, pgprot_noncached() gives us Strongly Ordered (Device memory)
> > semantics together with not allowing unaligned accesses. I suspect the
> > semantics are different on x86.
>  
> Hmm, on x86 it's also Strongly Ordered, but I didn't find any alignment
> restrictions. Is there a mode for arm64 that can provide similar
> semantics?
> 
> Would it make sence to use something like
> 
> #define pgprot_uncached(prot) \
> 	__pgprot_modify(prot, PTE_ATTRINDX_MASK, \
> 			PTE_ATTRINDX(MT_NORMAL_NC) | PTE_PXN)
> 
> or is it too weak?

Reading Elena's email, that's about preventing speculative loads. While
the arm64 Normal NC is non-cacheable (equivalent to write-combine), a
CPU is allowed to speculatively read from it. A carefully crafted gadget
could leave an imprint on a different part of the cache via speculative
execution based on a value in the secret memory. So IIUC, we want memory
that cannot be speculatively loaded from and that would be Device memory
on arm64 (with the alignment restrictions).

Now, I think we could relax this to Device_GRE. So maybe add a
pgprot_nospec() and allow architectures to define whatever they find
suitable. The exact semantics will be different between architectures.

> > The second, more serious problem, is that I can't find any place where
> > the caches are flushed for the page mapped on fault. When a page is
> > allocated, assuming GFP_ZERO, only the caches are guaranteed to be
> > zeroed. Exposing this subsequently to user space as uncached would allow
> > the user to read stale data prior to zeroing. The arm64
> > set_direct_map_default_noflush() doesn't do any cache maintenance.
> 
> Well, the idea of uncached mappings came from Elena [1] to prevent
> possibility of side channels that leak user space memory. So I think
> even without cache flushing after the allocation, user space is
> protected as all its memory accesses bypass cache so even after the page
> is freed there won't be stale data in the cache.
> 
> I think that it makes sense to limit SECRETMEM_UNCACHED only for
> architectures that define an appropriate protection, e.g.
> pgprot_uncahced(). For x86 it can be aliased to pgprot_noncached() and
> other architecures can define their versions.

Indeed, though as I said above, maybe use a name that suggests no
speculation since non-cacheable doesn't always guarantee that. Something
like pgprot_nospec() and SECRETMEM_NOSPEC.

However, your implementation still has the problem that such memory must
have the caches flushed before being mapped in user-space, otherwise we
leak other secrets via such pages to the caller. The only generic API we
have in the kernel for such things is the DMA one. If hch doesn't mind,
you could abuse it and call arch_dma_prep_coherent() prior to
set_direct_map_invalid_noflush() (if the mapping is non-cacheable).

-- 
Catalin

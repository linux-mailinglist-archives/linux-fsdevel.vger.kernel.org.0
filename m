Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEF0E2339E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jul 2020 22:44:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728722AbgG3Uo1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Jul 2020 16:44:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:39082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728586AbgG3Uo1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Jul 2020 16:44:27 -0400
Received: from kernel.org (unknown [87.70.91.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 715E220838;
        Thu, 30 Jul 2020 20:44:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596141866;
        bh=sZKYPMSX12eBmbaRqySKTHS1smjkmdh3zWo010nIk8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BmsOo3YUFCDw4gkyz7ZfQOn2kMn5QK/7KTwPtnQBqKiwbYcNBoz+qwKW/hGKQwn6F
         B9NMUdyu3EPJylOAMbuE0DD99sT3k6OWuEoKFMV4rR/rqwql2n/fAPL1B+he1E2TFF
         0UoU05MxTEQpp1qzhn8HCcZC6Zx2ZqD62fqBrpYw=
Date:   Thu, 30 Jul 2020 23:44:09 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
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
Message-ID: <20200730204409.GB534153@kernel.org>
References: <20200727162935.31714-1-rppt@kernel.org>
 <20200727162935.31714-4-rppt@kernel.org>
 <20200730162209.GB3128@gaia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730162209.GB3128@gaia>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 30, 2020 at 05:22:10PM +0100, Catalin Marinas wrote:
> Hi Mike,
> 
> On Mon, Jul 27, 2020 at 07:29:31PM +0300, Mike Rapoport wrote:
> > For instance, the following example will create an uncached mapping (error
> > handling is omitted):
> > 
> > 	fd = memfd_secret(SECRETMEM_UNCACHED);
> > 	ftruncate(fd, MAP_SIZE);
> > 	ptr = mmap(NULL, MAP_SIZE, PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> [...]
> > +static struct page *secretmem_alloc_page(gfp_t gfp)
> > +{
> > +	/*
> > +	 * FIXME: use a cache of large pages to reduce the direct map
> > +	 * fragmentation
> > +	 */
> > +	return alloc_page(gfp);
> > +}
> > +
> > +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > +{
> > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > +	struct inode *inode = file_inode(vmf->vma->vm_file);
> > +	pgoff_t offset = vmf->pgoff;
> > +	unsigned long addr;
> > +	struct page *page;
> > +	int ret = 0;
> > +
> > +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > +		return vmf_error(-EINVAL);
> > +
> > +	page = find_get_entry(mapping, offset);
> > +	if (!page) {
> > +		page = secretmem_alloc_page(vmf->gfp_mask);
> > +		if (!page)
> > +			return vmf_error(-ENOMEM);
> > +
> > +		ret = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
> > +		if (unlikely(ret))
> > +			goto err_put_page;
> > +
> > +		ret = set_direct_map_invalid_noflush(page);
> > +		if (ret)
> > +			goto err_del_page_cache;
> > +
> > +		addr = (unsigned long)page_address(page);
> > +		flush_tlb_kernel_range(addr, addr + PAGE_SIZE);
> > +
> > +		__SetPageUptodate(page);
> > +
> > +		ret = VM_FAULT_LOCKED;
> > +	}
> > +
> > +	vmf->page = page;
> > +	return ret;
> > +
> > +err_del_page_cache:
> > +	delete_from_page_cache(page);
> > +err_put_page:
> > +	put_page(page);
> > +	return vmf_error(ret);
> > +}
> > +
> > +static const struct vm_operations_struct secretmem_vm_ops = {
> > +	.fault = secretmem_fault,
> > +};
> > +
> > +static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
> > +{
> > +	struct secretmem_ctx *ctx = file->private_data;
> > +	unsigned long mode = ctx->mode;
> > +	unsigned long len = vma->vm_end - vma->vm_start;
> > +
> > +	if (!mode)
> > +		return -EINVAL;
> > +
> > +	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> > +		return -EINVAL;
> > +
> > +	if (mlock_future_check(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
> > +		return -EAGAIN;
> > +
> > +	switch (mode) {
> > +	case SECRETMEM_UNCACHED:
> > +		vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> > +		fallthrough;
> > +	case SECRETMEM_EXCLUSIVE:
> > +		vma->vm_ops = &secretmem_vm_ops;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	vma->vm_flags |= VM_LOCKED;
> > +
> > +	return 0;
> > +}
> 
> I think the uncached mapping is not the right thing for arm/arm64. First
> of all, pgprot_noncached() gives us Strongly Ordered (Device memory)
> semantics together with not allowing unaligned accesses. I suspect the
> semantics are different on x86.
 
Hmm, on x86 it's also Strongly Ordered, but I didn't find any alignment
restrictions. Is there a mode for arm64 that can provide similar
semantics?

Would it make sence to use something like

#define pgprot_uncached(prot) \
	__pgprot_modify(prot, PTE_ATTRINDX_MASK, \
			PTE_ATTRINDX(MT_NORMAL_NC) | PTE_PXN)

or is it too weak?

> The second, more serious problem, is that I can't find any place where
> the caches are flushed for the page mapped on fault. When a page is
> allocated, assuming GFP_ZERO, only the caches are guaranteed to be
> zeroed. Exposing this subsequently to user space as uncached would allow
> the user to read stale data prior to zeroing. The arm64
> set_direct_map_default_noflush() doesn't do any cache maintenance.

Well, the idea of uncached mappings came from Elena [1] to prevent
possibility of side channels that leak user space memory. So I think
even without cache flushing after the allocation, user space is
protected as all its memory accesses bypass cache so even after the page
is freed there won't be stale data in the cache.

I think that it makes sense to limit SECRETMEM_UNCACHED only for
architectures that define an appropriate protection, e.g.
pgprot_uncahced(). For x86 it can be aliased to pgprot_noncached() and
other architecures can define their versions.

[1] https://lore.kernel.org/lkml/2236FBA76BA1254E88B949DDB74E612BA4EEC0CE@IRSMSX102.ger.corp.intel.com/

-- 
Sincerely yours,
Mike.

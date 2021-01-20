Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FB02FD4E8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jan 2021 17:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730476AbhATQFX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Jan 2021 11:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391205AbhATQFL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Jan 2021 11:05:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12124C061793;
        Wed, 20 Jan 2021 08:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=saaFHJth3qz3xI0Dro7UHa0PgnHwAKKwZMU5+56dtJE=; b=ZACVPHDnW8nMnHToaApes5g3Rw
        YvejBi+ndU51oeSrxqqcYYLAwliMBGBXghPXPYc7XG0lsgIcf+/IvR9eJvgtCr1Y5bxBLOsNZcLBQ
        vxSb7WDqPTplOeChJJO0bdqf2couRLArJqCqj+JJHVlMqYUasnii5Ahu8a9pr17qMCP5jWMHxkGSS
        q6aEdJuVPlms8bTXRO0qZ2BUkaKlzq/5TxYAwU0Ad6+fh/jU8PXLs9HsRV6qDt9A/EPq+R0dOuJcM
        Lpx6Y1tpfz20HDKCh6YfbGEj7XSx+aNMkVsZzAS1FtW9RnCqIaJmYKn7ticVopJumXn3gPadcnzNH
        uNwqFTFw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2Fvu-00Fsqd-9M; Wed, 20 Jan 2021 16:02:37 +0000
Date:   Wed, 20 Jan 2021 16:02:10 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org, Hagen Paul Pfeifer <hagen@jauu.net>
Subject: Re: [PATCH v14 05/10] mm: introduce memfd_secret system call to
 create "secret" memory areas
Message-ID: <20210120160210.GK2260413@casper.infradead.org>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-6-rppt@kernel.org>
 <20210119202213.GI2260413@casper.infradead.org>
 <20210120150510.GO1106298@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120150510.GO1106298@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:05:10PM +0200, Mike Rapoport wrote:
> On Tue, Jan 19, 2021 at 08:22:13PM +0000, Matthew Wilcox wrote:
> > On Thu, Dec 03, 2020 at 08:29:44AM +0200, Mike Rapoport wrote:
> > > +static vm_fault_t secretmem_fault(struct vm_fault *vmf)
> > > +{
> > > +	struct address_space *mapping = vmf->vma->vm_file->f_mapping;
> > > +	struct inode *inode = file_inode(vmf->vma->vm_file);
> > > +	pgoff_t offset = vmf->pgoff;
> > > +	vm_fault_t ret = 0;
> > > +	unsigned long addr;
> > > +	struct page *page;
> > > +	int err;
> > > +
> > > +	if (((loff_t)vmf->pgoff << PAGE_SHIFT) >= i_size_read(inode))
> > > +		return vmf_error(-EINVAL);
> > > +
> > > +	page = find_get_page(mapping, offset);
> > > +	if (!page) {
> > > +
> > > +		page = secretmem_alloc_page(vmf->gfp_mask);
> > > +		if (!page)
> > > +			return vmf_error(-ENOMEM);
> > 
> > Just use VM_FAULT_OOM directly.
>  
> Ok.
> 
> > > +		err = add_to_page_cache(page, mapping, offset, vmf->gfp_mask);
> > > +		if (unlikely(err))
> > > +			goto err_put_page;
> > 
> > What if the error is EEXIST because somebody else raced with you to add
> > a new page to the page cache?
> 
> Right, for -EEXIST I need a retry here, thanks.
> 
> > > +		err = set_direct_map_invalid_noflush(page, 1);
> > > +		if (err)
> > > +			goto err_del_page_cache;
> > 
> > Does this work correctly if somebody else has a reference to the page
> > in the meantime?
> 
> Yes, it does. If somebody else won the race that page was dropped from the
> direct map and this call would be essentially a nop. And anyway, the very
> next patch changes the way pages are removed from the direct map ;-)

What I'm thinking is:

thread A page faults
doesn't find page
allocates page
adds page to page cache
				thread B page faults
				does find page in page cache
set direct map invalid fails
deletes from page cache
				... ?


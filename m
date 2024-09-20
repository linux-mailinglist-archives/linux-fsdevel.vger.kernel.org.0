Return-Path: <linux-fsdevel+bounces-29741-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2AB97D3DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 11:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1E681C215FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Sep 2024 09:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB7E013C683;
	Fri, 20 Sep 2024 09:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FCaBAyrk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1FAB13AA3F;
	Fri, 20 Sep 2024 09:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726825717; cv=none; b=pdpWwkkvpYCZuXrEAi8RdlCCvFAYIMmP5rHxc9uV3JCwg/M2JO9KSs52j2ttNm59iWQLuZ71jpA71FZxtYuPvk6lhGF25LxnE9q/HxrQ5X32WMI0a9nc9SnYnL68CzPnIBmzPlun3nfEB8Ff81feZDjOmr/6JIjucJQQSn1VHio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726825717; c=relaxed/simple;
	bh=FyxXb8akrb6773SzHwSGzE+XY53OJaKmSY0ZkfUJSqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HIDoFf2iJTYBpxOWvIvSIZlqOCQPS8fZMl94Zfajf1Karl0ArqW8B5OF8XCTNyXmKnmv/Rda5LpMk2f0AcUyh7tAIXrB+/vJzixLPRbJmVOy+t/h+yptoh6p1GR9zrc76Cpz5lABdo7KGJjAHR8lwBx1QH082KAN2rxFJM94fyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FCaBAyrk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lqLyI3VFGw/HAwz/TUdgSpSC7qmKkHxnZTuEYK+TROA=; b=FCaBAyrkr2GhMgqDOcDSm15x44
	nBBZNKK4o9GTMPjz2ia1eI3kls0oviUY0lhgsfF078MVJ95hghGLUWqxjj7IQJmhvgpLIPV/yzCoi
	UwCVkT0y2oAqMAnQ7V4iCoNNGeAaXGZoVmnKe+e4D8PVlQrF+WlpvAQT5N3EzL52CV2AbsyillS/E
	G7kqNOAMyp5VI22eqWfpdik8O6y0z3/ezk72CoHzgDI7/QfbfayfpKTVZe42RhbO6Kyg63huHbJyD
	lrcsuFtw8ntkZDjFpG/+BpKsPH4eBNbbt48coqkUgq60sBcdvKdIMvsGIaTRuXyBxkKozH6oFjq34
	HASJesyQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:33476)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sraF3-0001NG-1b;
	Fri, 20 Sep 2024 10:47:57 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sraEr-0002Qp-2B;
	Fri, 20 Sep 2024 10:47:45 +0100
Date: Fri, 20 Sep 2024 10:47:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
	llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	"Mike Rapoport (IBM)" <rppt@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Muchun Song <muchun.song@linux.dev>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Miaohe Lin <linmiaohe@huawei.com>, Dennis Zhou <dennis@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Christoph Lameter <cl@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
Message-ID: <Zu1EwTItDrnkTVTB@shell.armlinux.org.uk>
References: <20240917073117.1531207-8-anshuman.khandual@arm.com>
 <202409190310.ViHBRe12-lkp@intel.com>
 <8f43251a-5418-4c54-a9b0-29a6e9edd879@arm.com>
 <ZuvqpvJ6ht4LCuB+@shell.armlinux.org.uk>
 <82fa108e-5b15-435a-8b61-6253766c7d88@arm.com>
 <ZuxZ/QeSdqTHtfmw@shell.armlinux.org.uk>
 <5bd51798-cb47-4a7b-be40-554b5a821fe7@arm.com>
 <ZuyIwdnbYcm3ZkkB@shell.armlinux.org.uk>
 <9e68ffad-8a7e-40d7-a6f3-fa989a834068@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e68ffad-8a7e-40d7-a6f3-fa989a834068@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Sep 20, 2024 at 08:57:23AM +0200, Ryan Roberts wrote:
> On 19/09/2024 21:25, Russell King (Oracle) wrote:
> > On Thu, Sep 19, 2024 at 07:49:09PM +0200, Ryan Roberts wrote:
> >> On 19/09/2024 18:06, Russell King (Oracle) wrote:
> >>> On Thu, Sep 19, 2024 at 05:48:58PM +0200, Ryan Roberts wrote:
> >>>>> 32-bit arm uses, in some circumstances, an array because each level 1
> >>>>> page table entry is actually two descriptors. It needs to be this way
> >>>>> because each level 2 table pointed to by each level 1 entry has 256
> >>>>> entries, meaning it only occupies 1024 bytes in a 4096 byte page.
> >>>>>
> >>>>> In order to cut down on the wastage, treat the level 1 page table as
> >>>>> groups of two entries, which point to two consecutive 1024 byte tables
> >>>>> in the level 2 page.
> >>>>>
> >>>>> The level 2 entry isn't suitable for the kernel's use cases (there are
> >>>>> no bits to represent accessed/dirty and other important stuff that the
> >>>>> Linux MM wants) so we maintain the hardware page tables and a separate
> >>>>> set that Linux uses in the same page. Again, the software tables are
> >>>>> consecutive, so from Linux's perspective, the level 2 page tables
> >>>>> have 512 entries in them and occupy one full page.
> >>>>>
> >>>>> This is documented in arch/arm/include/asm/pgtable-2level.h
> >>>>>
> >>>>> However, what this means is that from the software perspective, the
> >>>>> level 1 page table descriptors are an array of two entries, both of
> >>>>> which need to be setup when creating a level 2 page table, but only
> >>>>> the first one should ever be dereferenced when walking the tables,
> >>>>> otherwise the code that walks the second level of page table entries
> >>>>> will walk off the end of the software table into the actual hardware
> >>>>> descriptors.
> >>>>>
> >>>>> I've no idea what the idea is behind introducing pgd_get() and what
> >>>>> it's semantics are, so I can't comment further.
> >>>>
> >>>> The helper is intended to read the value of the entry pointed to by the passed
> >>>> in pointer. And it shoiuld be read in a "single copy atomic" manner, meaning no
> >>>> tearing. Further, the PTL is expected to be held when calling the getter. If the
> >>>> HW can write to the entry such that its racing with the lock holder (i.e. HW
> >>>> update of access/dirty) then READ_ONCE() should be suitable for most
> >>>> architectures. If there is no possibility of racing (because HW doesn't write to
> >>>> the entry), then a simple dereference would be sufficient, I think (which is
> >>>> what the core code was already doing in most cases).
> >>>
> >>> The core code should be making no access to the PGD entries on 32-bit
> >>> ARM since the PGD level does not exist. Writes are done at PMD level
> >>> in arch code. Reads are done by core code at PMD level.
> >>>
> >>> It feels to me like pgd_get() just doesn't fit the model to which 32-bit
> >>> ARM was designed to use decades ago, so I want full details about what
> >>> pgd_get() is going to be used for and how it is going to be used,
> >>> because I feel completely in the dark over this new development. I fear
> >>> that someone hasn't understood the Linux page table model if they're
> >>> wanting to access stuff at levels that effectively "aren't implemented"
> >>> in the architecture specific kernel model of the page tables.
> >>
> >> This change isn't as big and scary as I think you fear.
> > 
> > The situation is as I state above. Core code must _not_ dereference pgd
> > pointers on 32-bit ARM.
> 
> Let's just rewind a bit. This thread exists because the kernel test robot failed
> to compile pgd_none_or_clear_bad() (a core-mm function) for the arm architecture
> after Anshuman changed the direct pgd dereference to pgdp_get(). The reason
> compilation failed is because arm defines its own pgdp_get() override, but it is
> broken (there is a typo).

Let's not rewind, because had you fully read and digested my reply, you
would have seen why this isn't a problem... but let me spell it out.

> 
> Code before Anshuman's change:
> 
> static inline int pgd_none_or_clear_bad(pgd_t *pgd)
> {
> 	if (pgd_none(*pgd))
> 		return 1;
> 	if (unlikely(pgd_bad(*pgd))) {
> 		pgd_clear_bad(pgd);
> 		return 1;
> 	}
> 	return 0;
> }

This isn't a problem as the code stands. While there is a dereference
in C, that dereference is a simple struct copy, something that we use
everywhere in the kernel. However, that is as far as it goes, because
neither pgd_none() and pgd_bad() make use of their argument, and thus
the compiler will optimise it away, resulting in no actual access to
the page tables - _as_ _intended_.

If these are going to be converted to pgd_get(), then we need pgd_get()
to _also_ be optimised away, and if e.g. this is the only place that
pgd_get() is going to be used, the suggestion I made in my previous
email is entirely reasonable, since we know that the result of pgd_get()
will not actually be used.

> As an aside, the kernel also dereferences p4d, pud, pmd and pte pointers in
> various circumstances.

I already covered these in my previous reply.

> And other changes in this series are also replacing those
> direct dereferences with calls to similar helpers. The fact that these are all
> folded (by a custom arm implementation if I've understood the below correctly)
> just means that each dereference is returning what you would call the pmd from
> the HW perspective, I think?

It'll "return" the first of each pair of level-1 page table entries,
which is pgd[0] or *p4d, *pud, *pmd - but all of these except *pmd
need to be optimised away, so throwing lots of READ_ONCE() around
this code without considering this is certainly the wrong approach.

> >> The core-mm today
> >> dereferences pgd pointers (and p4d, pud, pmd pointers) directly in its code. See
> >> follow_pfnmap_start(),
> > 
> > Doesn't seem to exist at least not in 6.11.
> 
> Appologies, I'm on mm-unstable and that isn't upstream yet. See follow_pte() in
> v6.11 or __apply_to_page_range(), or pgd_none_or_clear_bad() as per above.

Looking at follow_pte(), it's not a problem.

I think we wouldn't be having this conversation before:

commit a32618d28dbe6e9bf8ec508ccbc3561a7d7d32f0
Author: Russell King <rmk+kernel@arm.linux.org.uk>
Date:   Tue Nov 22 17:30:28 2011 +0000

    ARM: pgtable: switch to use pgtable-nopud.h

where:
-#define pgd_none(pgd)          (0)
-#define pgd_bad(pgd)           (0)

existed before this commit - and thus the dereference in things like:

	pgd_none(*pgd)

wouldn't even be visible to beyond the preprocessor step.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


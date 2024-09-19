Return-Path: <linux-fsdevel+bounces-29722-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 595C797CCDE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 19:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE81A1F22DF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 17:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51D171A2542;
	Thu, 19 Sep 2024 17:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="an6X8ydO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FAE31A071F;
	Thu, 19 Sep 2024 17:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726765615; cv=none; b=k6sHNnnMBczez37Smryqr8fLvcwb/ZOVdhBu4/KLKMFbd84jDv9J3Y4gK3seZOxpdxGpghRnKZrk5fKoYwxHIHivOiaD8UE/jXRhY3fVnKkmu+KNM/8TH+JNhxV8g1gYJYNgQFKzHsJgyxoTfJG4KLdwNq7pldeCZ/KEzzEsf2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726765615; c=relaxed/simple;
	bh=7HJt2DixLXCURCjuSi2NMOTOCwUujocSNiFrKecg27w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rYFItCdkGKo4aAkkBI7xkNSv1T1xarQduWSCuwDv3VJR0tart27o0YwxqCmmCv3PpP4+h5QeHQruG0VQm2nf8ZYRA3p51G0xKSJ0GkQtf855zAPunOw6mMrM65BZ21m4ebXbxhDif5/tVHYzIG36HJ3dzAruiFceSkMP69626sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=an6X8ydO; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=6mai/1zkLhhmEUxeaWpVi/QzAXrwkM3agGKBk9/iEkI=; b=an6X8ydO0MniShvTb/kpEMvXPv
	jWLqY50FB2LvcWzWy8CtBFmRJwZfNMPEQcghAdDVBIoqGCOjNjnZdDrif3ndrOsa2ngT/EZbvi5MF
	+Wkpw7PEe7rSe1w56jAKK+KK0WJziDrsSj3FS0RaP0CxvtHB1lL1yMgZ8+U1LOqRGtUXQCiJ9kZfL
	YFRDBt5yNl0lgh5jSYrNZULtzwo05DU9D2w5/h7RlIY888f5fJ8OJAh9c5a4vepDklpkZzaLsXPm2
	LdYt2BmHE3DVdLcbvY0KpuXlN1jlcqFVXbL1vNbNJxdRRtWfrUzI01+wCM2Gh2BBLa6q1eaTh3xr3
	S6z0dMkQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:53624)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1srKbe-0000gQ-2J;
	Thu, 19 Sep 2024 18:06:14 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1srKbV-0001gs-1e;
	Thu, 19 Sep 2024 18:06:05 +0100
Date: Thu, 19 Sep 2024 18:06:05 +0100
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
Message-ID: <ZuxZ/QeSdqTHtfmw@shell.armlinux.org.uk>
References: <20240917073117.1531207-8-anshuman.khandual@arm.com>
 <202409190310.ViHBRe12-lkp@intel.com>
 <8f43251a-5418-4c54-a9b0-29a6e9edd879@arm.com>
 <ZuvqpvJ6ht4LCuB+@shell.armlinux.org.uk>
 <82fa108e-5b15-435a-8b61-6253766c7d88@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <82fa108e-5b15-435a-8b61-6253766c7d88@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 19, 2024 at 05:48:58PM +0200, Ryan Roberts wrote:
> > 32-bit arm uses, in some circumstances, an array because each level 1
> > page table entry is actually two descriptors. It needs to be this way
> > because each level 2 table pointed to by each level 1 entry has 256
> > entries, meaning it only occupies 1024 bytes in a 4096 byte page.
> > 
> > In order to cut down on the wastage, treat the level 1 page table as
> > groups of two entries, which point to two consecutive 1024 byte tables
> > in the level 2 page.
> > 
> > The level 2 entry isn't suitable for the kernel's use cases (there are
> > no bits to represent accessed/dirty and other important stuff that the
> > Linux MM wants) so we maintain the hardware page tables and a separate
> > set that Linux uses in the same page. Again, the software tables are
> > consecutive, so from Linux's perspective, the level 2 page tables
> > have 512 entries in them and occupy one full page.
> > 
> > This is documented in arch/arm/include/asm/pgtable-2level.h
> > 
> > However, what this means is that from the software perspective, the
> > level 1 page table descriptors are an array of two entries, both of
> > which need to be setup when creating a level 2 page table, but only
> > the first one should ever be dereferenced when walking the tables,
> > otherwise the code that walks the second level of page table entries
> > will walk off the end of the software table into the actual hardware
> > descriptors.
> > 
> > I've no idea what the idea is behind introducing pgd_get() and what
> > it's semantics are, so I can't comment further.
> 
> The helper is intended to read the value of the entry pointed to by the passed
> in pointer. And it shoiuld be read in a "single copy atomic" manner, meaning no
> tearing. Further, the PTL is expected to be held when calling the getter. If the
> HW can write to the entry such that its racing with the lock holder (i.e. HW
> update of access/dirty) then READ_ONCE() should be suitable for most
> architectures. If there is no possibility of racing (because HW doesn't write to
> the entry), then a simple dereference would be sufficient, I think (which is
> what the core code was already doing in most cases).

The core code should be making no access to the PGD entries on 32-bit
ARM since the PGD level does not exist. Writes are done at PMD level
in arch code. Reads are done by core code at PMD level.

It feels to me like pgd_get() just doesn't fit the model to which 32-bit
ARM was designed to use decades ago, so I want full details about what
pgd_get() is going to be used for and how it is going to be used,
because I feel completely in the dark over this new development. I fear
that someone hasn't understood the Linux page table model if they're
wanting to access stuff at levels that effectively "aren't implemented"
in the architecture specific kernel model of the page tables.

Essentially, on 32-bit 2-level ARM, the PGD is merely indexed by the
virtual address. As far as the kernel is concerned, each entry is
64-bit, and the generic kernel code has no business accessing that
through the pgd pointer.

The pgd pointer is passed through the PUD and PMD levels, where it is
typecast down through the kernel layers to a pmd_t pointer, where it
becomes a 32-bit quantity. This results in only the _first_ level 1
pointer being dereferenced by kernel code to a 32-bit pmd_t quantity.
pmd_page_vaddr() converts this pmd_t quantity to a pte pointer (which
points at the software level 2 page tables, not the hardware page
tables.)

So, as I'm now being told that the kernel wants to dereference the
pgd level despite the model I describe above, alarm bells are ringing.
I want full information please.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!


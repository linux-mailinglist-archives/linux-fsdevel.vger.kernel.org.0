Return-Path: <linux-fsdevel+bounces-5907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A73781159A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 16:03:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE087B20E36
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Dec 2023 15:03:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55A930D16;
	Wed, 13 Dec 2023 15:03:10 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6579CE8;
	Wed, 13 Dec 2023 07:03:07 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 211E2C15;
	Wed, 13 Dec 2023 07:03:53 -0800 (PST)
Received: from e124191.cambridge.arm.com (e124191.cambridge.arm.com [10.1.197.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 06D6E3F738;
	Wed, 13 Dec 2023 07:03:04 -0800 (PST)
Date: Wed, 13 Dec 2023 15:02:59 +0000
From: Joey Gouly <joey.gouly@arm.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
	aneesh.kumar@linux.ibm.com, broonie@kernel.org,
	dave.hansen@linux.intel.com, maz@kernel.org, oliver.upton@linux.dev,
	shuah@kernel.org, will@kernel.org, kvmarm@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	linux-kselftest@vger.kernel.org, James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v3 12/25] arm64: handle PKEY/POE faults
Message-ID: <20231213150259.GA1129554@e124191.cambridge.arm.com>
References: <20231124163510.1835740-1-joey.gouly@arm.com>
 <20231124163510.1835740-13-joey.gouly@arm.com>
 <ZXdSaRIJGWrtXin-@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXdSaRIJGWrtXin-@arm.com>

Hi,

On Mon, Dec 11, 2023 at 06:18:17PM +0000, Catalin Marinas wrote:
> On Fri, Nov 24, 2023 at 04:34:57PM +0000, Joey Gouly wrote:
> > @@ -497,6 +498,23 @@ static void do_bad_area(unsigned long far, unsigned long esr,
> >  #define VM_FAULT_BADMAP		((__force vm_fault_t)0x010000)
> >  #define VM_FAULT_BADACCESS	((__force vm_fault_t)0x020000)
> >  
> > +static bool fault_from_pkey(unsigned long esr, struct vm_area_struct *vma,
> > +			unsigned int mm_flags)
> > +{
> > +	unsigned long iss2 = ESR_ELx_ISS2(esr);
> > +
> > +	if (!arch_pkeys_enabled())
> > +		return false;
> > +
> > +	if (iss2 & ESR_ELx_Overlay)
> > +		return true;
> > +
> > +	return !arch_vma_access_permitted(vma,
> > +			mm_flags & FAULT_FLAG_WRITE,
> > +			mm_flags & FAULT_FLAG_INSTRUCTION,
> > +			mm_flags & FAULT_FLAG_REMOTE);
> > +}
> 
> Do we actually need this additional arch_vma_access_permitted() check?
> The ESR should tell us if it was a POE fault. Permission overlay faults
> have priority over the base permission faults, so we'd not need to fall
> back to this additional checks. Well, see below, we could do something
> slightly smarter here.

We want this here as it follows other arch's which will fail with a pkey fault
even if the page isn't actually mapped. If the paged isn't mapped we'd get a
translation fault, but since we know the type of access and have the pkey in
the VMA we check it here.

> 
> I can see x86 and powerpc have similar checks (though at a different
> point under the mmap lock) but I'm not familiar with their exception
> model, exception priorities.
> 
> > +
> >  static vm_fault_t __do_page_fault(struct mm_struct *mm,
> >  				  struct vm_area_struct *vma, unsigned long addr,
> >  				  unsigned int mm_flags, unsigned long vm_flags,
> > @@ -688,9 +706,29 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
> >  		 * Something tried to access memory that isn't in our memory
> >  		 * map.
> >  		 */
> > -		arm64_force_sig_fault(SIGSEGV,
> > -				      fault == VM_FAULT_BADACCESS ? SEGV_ACCERR : SEGV_MAPERR,
> > -				      far, inf->name);
> > +		int fault_kind;
> > +		/*
> > +		 * The pkey value that we return to userspace can be different
> > +		 * from the pkey that caused the fault.
> > +		 *
> > +		 * 1. T1   : mprotect_key(foo, PAGE_SIZE, pkey=4);
> > +		 * 2. T1   : set AMR to deny access to pkey=4, touches, page
> > +		 * 3. T1   : faults...
> > +		 * 4.    T2: mprotect_key(foo, PAGE_SIZE, pkey=5);
> > +		 * 5. T1   : enters fault handler, takes mmap_lock, etc...
> > +		 * 6. T1   : reaches here, sees vma_pkey(vma)=5, when we really
> > +		 *	     faulted on a pte with its pkey=4.
> > +		 */
> > +		int pkey = vma_pkey(vma);
> 
> Other than the vma_pkey() race, I'm more worried about the vma
> completely disappearing, e.g. munmap() in another thread. We end up
> dereferencing a free pointer here. We need to do this under the mmap
> lock.
> 
> Since we need to do this check under the mmap lock, we could add an
> additional check to see if the pkey fault we got was a racy and just
> restart the instruction if it no longer faults according to
> por_el0_allows_pkey(). However, the code below is too late in the fault
> handling to be able to do much other than SIGSEGV.

After discussing in person, I agree with the assesment that this is the wrong
place to do the check, and after looking at the x86 arch code, I see how
they're doing it earlier.

Thanks,
Joey


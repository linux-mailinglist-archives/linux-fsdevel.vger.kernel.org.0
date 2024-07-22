Return-Path: <linux-fsdevel+bounces-24072-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C99F939004
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 15:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3741C212F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jul 2024 13:40:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 295E716D4E5;
	Mon, 22 Jul 2024 13:40:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74F901D696
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Jul 2024 13:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721655605; cv=none; b=cc1JwNSp7fAqYkCrIkUA+MNq/T+I5ZHXtnTWtAtChqVadsh7qzwGFz3I3rwTst7M9eUmp531m13t2h3F27ULxJ8r1C16hFdf6X04g0/SIcwPekCZJPNNFlMB0HbDZHQB+Ag8JnamUbHLY94PFiKYAZ1eb/eR2s1HzFx8f27Xjeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721655605; c=relaxed/simple;
	bh=qNZ6+wPpE4b0eb6JiOYhozAXjOaNH5Iw9Fy9vPIlntE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LMVW/9JZW533v30yD6EzXdwCCljDnY23lAcTAaCAXQkMN1i9aMXU5L7hRK67Dxtt9N5b0Up13gIc6trNFuYaH8oIuqEphrn09WPy2ykZbaefLV3di9thyGZUCN2NM+7j+A3U5SPEAaK47PS2i7Oec59QZKS6+qhlrAAffsodS/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E204CFEC;
	Mon, 22 Jul 2024 06:40:27 -0700 (PDT)
Received: from [10.44.160.75] (e126510-lin.lund.arm.com [10.44.160.75])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E99F23F766;
	Mon, 22 Jul 2024 06:39:56 -0700 (PDT)
Message-ID: <b4f8b351-4c83-43b4-bfbe-8f67f3f56fb9@arm.com>
Date: Mon, 22 Jul 2024 15:39:54 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 17/29] arm64: implement PKEYS support
To: Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>
Cc: linux-arm-kernel@lists.infradead.org, akpm@linux-foundation.org,
 aneesh.kumar@kernel.org, aneesh.kumar@linux.ibm.com, bp@alien8.de,
 broonie@kernel.org, christophe.leroy@csgroup.eu,
 dave.hansen@linux.intel.com, hpa@zytor.com, linux-fsdevel@vger.kernel.org,
 linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, maz@kernel.org,
 mingo@redhat.com, mpe@ellerman.id.au, naveen.n.rao@linux.ibm.com,
 npiggin@gmail.com, oliver.upton@linux.dev, shuah@kernel.org,
 szabolcs.nagy@arm.com, tglx@linutronix.de, will@kernel.org, x86@kernel.org,
 kvmarm@lists.linux.dev
References: <20240503130147.1154804-1-joey.gouly@arm.com>
 <20240503130147.1154804-18-joey.gouly@arm.com> <Zogmi1AogxHWlWWR@arm.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <Zogmi1AogxHWlWWR@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/07/2024 18:59, Catalin Marinas wrote:
> On Fri, May 03, 2024 at 02:01:35PM +0100, Joey Gouly wrote:
>> @@ -163,7 +182,8 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>  #define pte_access_permitted_no_overlay(pte, write) \
>>  	(((pte_val(pte) & (PTE_VALID | PTE_USER)) == (PTE_VALID | PTE_USER)) && (!(write) || pte_write(pte)))
>>  #define pte_access_permitted(pte, write) \
>> -	pte_access_permitted_no_overlay(pte, write)
>> +	(pte_access_permitted_no_overlay(pte, write) && \
>> +	por_el0_allows_pkey(FIELD_GET(PTE_PO_IDX_MASK, pte_val(pte)), write, false))
> I'm still not entirely convinced on checking the keys during fast GUP
> but that's what x86 and powerpc do already, so I guess we'll follow the
> same ABI.

I've thought about this some more. In summary I don't think adding this
check to pte_access_permitted() is controversial, but we should decide
how POR_EL0 is set for kernel threads.

This change essentially means that fast GUP behaves like uaccess for
pages that are already present: in both cases POR_EL0 will be looked up
based on the POIndex of the page being accessed (by the hardware in the
uaccess case, and explicitly in the fast GUP case). Fast GUP always
operates on current->mm, so to me checking POR_EL0 in
pte_access_permitted() should be no more restrictive than a uaccess
check from a user perspective. In other words, POR_EL0 is checked when
the kernel accesses user memory on the user's behalf, whether through
uaccess or GUP.

It's also worth noting that the "slow" GUP path (which
get_user_pages_fast() falls back to if a page is missing) also checks
POR_EL0 by virtue of calling handle_mm_fault(), which in turn calls
arch_vma_access_permitted(). It would be pretty inconsistent for the
slow GUP path to do a pkey check but not the fast path. (That said, the
slow GUP path does not call arch_vma_access_permitted() if a page is
already present, so callers of get_user_pages() and similar will get
inconsistent checking. Not great, that may be worth fixing - but that's
clearly beyond the scope of this series.)

Now an interesting question is what happens with kernel threads that
access user memory, as is the case for the optional io_uring kernel
thread (IORING_SETUP_SQPOLL). The discussion above holds regardless of
the type of thread, so the sqpoll thread will have its POR_EL0 checked
when processing commands that involve uaccess or GUP. AFAICT, this
series does not have special handling for kernel threads w.r.t. POR_EL0,
which means that it is left unchanged when a new kernel thread is cloned
(create_io_thread() in the IORING_SETUP_SQPOLL case). The sqpoll thread
will therefore inherit POR_EL0 from the (user) thread that calls
io_uring_setup(). In other words, the sqpoll thread ends up with the
same view of user memory as that user thread - for instance if its
POR_EL0 prevents access to POIndex 1, then any I/O that the sqpoll
thread attempts on mappings with POIndex/pkey 1 will fail.

This behaviour seems potentially useful to me, as the io_uring SQ could
easily become a way to bypass POE without some restriction. However, it
feels like this should be documented, as one should keep it in mind when
using pkeys, and there may well be other cases where kernel threads are
impacted by POR_EL0. I am also unsure how x86/ppc handle this.

Kevin


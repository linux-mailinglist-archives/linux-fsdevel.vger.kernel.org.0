Return-Path: <linux-fsdevel+bounces-29715-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5243D97CBB5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84A5C1C2209C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FAC19FA99;
	Thu, 19 Sep 2024 15:49:12 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98251EA84;
	Thu, 19 Sep 2024 15:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760952; cv=none; b=LrTFmlC3RU2BqCJlzJ/XAPPYk+ICztvtHZ+acOvdlnkbn5EWg7TDHsEj2iYIEfdCJbOtxyoAeY2NOSlPKQ2fL2TO+aEW9p81YQI1o8wS95nhbZQntIEEtw1Zwtlt3TjunTuUVOUqOc4DWnefd0Pu0NfQEgHUtNFVux0xbjRw3+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760952; c=relaxed/simple;
	bh=0Ks9ypmdxJsVxoZ7cxi1O2kerYF/Q+rGlQda6T7lCRU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Soj1Y3Wr1gdTbBegfKJqwNFwRe/y+FAi0io48qrECeYieJWr4WxCEYoNr0iHdlwJ801N+ptCpukd+ILy3jW8xLKqBwiV+8PtXbY6bbBVQM1TjJ7GZ0PplD4AhzH/yPcCzSlBoqP3QKtmrG1hAv+k+HdoeYzEE0qc8x1NrOWMrHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 41B6AFEC;
	Thu, 19 Sep 2024 08:49:37 -0700 (PDT)
Received: from [10.57.82.79] (unknown [10.57.82.79])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E30043F71A;
	Thu, 19 Sep 2024 08:49:00 -0700 (PDT)
Message-ID: <82fa108e-5b15-435a-8b61-6253766c7d88@arm.com>
Date: Thu, 19 Sep 2024 17:48:58 +0200
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
Content-Language: en-GB
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Anshuman Khandual <anshuman.khandual@arm.com>
Cc: kernel test robot <lkp@intel.com>, linux-mm@kvack.org,
 llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-fsdevel@vger.kernel.org,
 kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
 linux-perf-users@vger.kernel.org, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Muchun Song <muchun.song@linux.dev>, Andrey Ryabinin
 <ryabinin.a.a@gmail.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
 Christoph Lameter <cl@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Christoph Hellwig <hch@infradead.org>
References: <20240917073117.1531207-8-anshuman.khandual@arm.com>
 <202409190310.ViHBRe12-lkp@intel.com>
 <8f43251a-5418-4c54-a9b0-29a6e9edd879@arm.com>
 <ZuvqpvJ6ht4LCuB+@shell.armlinux.org.uk>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ZuvqpvJ6ht4LCuB+@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/09/2024 10:11, Russell King (Oracle) wrote:
> On Thu, Sep 19, 2024 at 01:25:08PM +0530, Anshuman Khandual wrote:
>> arm (32) platform currently overrides pgdp_get() helper in the platform but
>> defines that like the exact same version as the generic one, albeit with a
>> typo which can be fixed with something like this.
> 
> pgdp_get() was added to arm in eba2591d99d1 ("mm: Introduce
> pudp/p4dp/pgdp_get() functions") with the typo you've spotted. It seems
> it was added with no users, otherwise the error would have been spotted
> earlier. I'm not a fan of adding dead code to the kernel for this
> reason.
> 
>> Regardless there is another problem here. On arm platform there are multiple
>> pgd_t definitions available depending on various configs but some are arrays
>> instead of a single data element, although platform pgdp_get() helper remains
>> the same for all.
>>
>> arch/arm/include/asm/page-nommu.h:typedef unsigned long pgd_t[2];
>> arch/arm/include/asm/pgtable-2level-types.h:typedef struct { pmdval_t pgd[2]; } pgd_t;
>> arch/arm/include/asm/pgtable-2level-types.h:typedef pmdval_t pgd_t[2];
>> arch/arm/include/asm/pgtable-3level-types.h:typedef struct { pgdval_t pgd; } pgd_t;
>> arch/arm/include/asm/pgtable-3level-types.h:typedef pgdval_t pgd_t;
>>
>> I guess it might need different pgdp_get() variants depending applicable pgd_t
>> definition. Will continue looking into this further but meanwhile copied Russel
>> King in case he might be able to give some direction.
> 
> That's Russel*L*, thanks.
> 
> 32-bit arm uses, in some circumstances, an array because each level 1
> page table entry is actually two descriptors. It needs to be this way
> because each level 2 table pointed to by each level 1 entry has 256
> entries, meaning it only occupies 1024 bytes in a 4096 byte page.
> 
> In order to cut down on the wastage, treat the level 1 page table as
> groups of two entries, which point to two consecutive 1024 byte tables
> in the level 2 page.
> 
> The level 2 entry isn't suitable for the kernel's use cases (there are
> no bits to represent accessed/dirty and other important stuff that the
> Linux MM wants) so we maintain the hardware page tables and a separate
> set that Linux uses in the same page. Again, the software tables are
> consecutive, so from Linux's perspective, the level 2 page tables
> have 512 entries in them and occupy one full page.
> 
> This is documented in arch/arm/include/asm/pgtable-2level.h
> 
> However, what this means is that from the software perspective, the
> level 1 page table descriptors are an array of two entries, both of
> which need to be setup when creating a level 2 page table, but only
> the first one should ever be dereferenced when walking the tables,
> otherwise the code that walks the second level of page table entries
> will walk off the end of the software table into the actual hardware
> descriptors.
> 
> I've no idea what the idea is behind introducing pgd_get() and what
> it's semantics are, so I can't comment further.

The helper is intended to read the value of the entry pointed to by the passed
in pointer. And it shoiuld be read in a "single copy atomic" manner, meaning no
tearing. Further, the PTL is expected to be held when calling the getter. If the
HW can write to the entry such that its racing with the lock holder (i.e. HW
update of access/dirty) then READ_ONCE() should be suitable for most
architectures. If there is no possibility of racing (because HW doesn't write to
the entry), then a simple dereference would be sufficient, I think (which is
what the core code was already doing in most cases).

There is additional benefit that the architecture can hook this function if it
has exotic use cases (see contpte feature on arm64 as an example, which hooks
ptep_get()).

It sounds to me like the arm (32) implementation of pgdp_get() could just
continue to do a direct dereference and this should be safe? I don't think it
supports HW update of access/dirty?

Thanks,
Ryan




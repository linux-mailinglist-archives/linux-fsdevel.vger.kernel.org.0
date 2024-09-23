Return-Path: <linux-fsdevel+bounces-29859-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F00F897EE05
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 17:21:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CBB41C2149C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097CC19E827;
	Mon, 23 Sep 2024 15:21:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0482119CC0F;
	Mon, 23 Sep 2024 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727104887; cv=none; b=XzXfIrvEHnO1aonMK2tAuhSAodDnDNikobDHU7HWNfoMaPxU5jv0LDvmd0G3IrV0T1QOS0x4MM4BPn+4ecIG4FLhf3g52Tnib/l4L3uBd3Z5Lq60MrmFbVcM+/cFnRKB2Hf0SPud9JpXSTixHJ8DOR9TjmbcSFMjMcrHO7cS75o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727104887; c=relaxed/simple;
	bh=bMSKhr+4rYP/5MGeIk1qblZn7/5eBVdbQ9Yv1NT8p2s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mbo8K/7lCpAuQsAkuMXmnCQMnP9xtR3kIIpMVtEFtMW4BqZ2VDi4D0H8pJtQFlKAY5RPZ4oF0Z9uS2OavOgn4ZFjJLMhTTzpT+nO2igjlJdb16BJ0H3OTRju/0oVF4cdzrZT18ICxTm+Q0wgA/MhDi4tVy595z/xGwRTTQOo0KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 80143FEC;
	Mon, 23 Sep 2024 08:21:53 -0700 (PDT)
Received: from [10.57.84.103] (unknown [10.57.84.103])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B4B793F64C;
	Mon, 23 Sep 2024 08:21:20 -0700 (PDT)
Message-ID: <ebf8d9c6-867d-4e50-9e98-5d7f854278d8@arm.com>
Date: Mon, 23 Sep 2024 16:21:18 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 7/7] mm: Use pgdp_get() for accessing PGD entries
Content-Language: en-GB
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
 kernel test robot <lkp@intel.com>, linux-mm@kvack.org, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
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
 <82fa108e-5b15-435a-8b61-6253766c7d88@arm.com>
 <ZuxZ/QeSdqTHtfmw@shell.armlinux.org.uk>
 <5bd51798-cb47-4a7b-be40-554b5a821fe7@arm.com>
 <ZuyIwdnbYcm3ZkkB@shell.armlinux.org.uk>
 <9e68ffad-8a7e-40d7-a6f3-fa989a834068@arm.com>
 <Zu1EwTItDrnkTVTB@shell.armlinux.org.uk>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <Zu1EwTItDrnkTVTB@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

>> Let's just rewind a bit. This thread exists because the kernel test robot failed
>> to compile pgd_none_or_clear_bad() (a core-mm function) for the arm architecture
>> after Anshuman changed the direct pgd dereference to pgdp_get(). The reason
>> compilation failed is because arm defines its own pgdp_get() override, but it is
>> broken (there is a typo).
> 
> Let's not rewind, because had you fully read and digested my reply, you
> would have seen why this isn't a problem... but let me spell it out.
> 
>>
>> Code before Anshuman's change:
>>
>> static inline int pgd_none_or_clear_bad(pgd_t *pgd)
>> {
>> 	if (pgd_none(*pgd))
>> 		return 1;
>> 	if (unlikely(pgd_bad(*pgd))) {
>> 		pgd_clear_bad(pgd);
>> 		return 1;
>> 	}
>> 	return 0;
>> }
> 
> This isn't a problem as the code stands. While there is a dereference
> in C, that dereference is a simple struct copy, something that we use
> everywhere in the kernel. However, that is as far as it goes, because
> neither pgd_none() and pgd_bad() make use of their argument, and thus
> the compiler will optimise it away, resulting in no actual access to
> the page tables - _as_ _intended_.

Right. Are you saying you depend upon those loads being optimized away for
correctness or performance reasons?

> 
> If these are going to be converted to pgd_get(), then we need pgd_get()
> to _also_ be optimised away, 

OK, agreed.

So perhaps the best approach is to modify the existing default pxdp_get()
implementations to just do a C dereference. That will ensure that there are no
intended consequences, unlike moving to READ_ONCE() by default. Then riscv
(which I think is the only arch to actually use pxdp_get() currently?) will need
its own pxdp_get() overrides, which use READ_ONCE(). arm64 would also define its
own overrides in terms of READ_ONCE() to ensure single copy atomicity in the
presence of HW updates.

How does that sound to you?

> and if e.g. this is the only place that
> pgd_get() is going to be used, the suggestion I made in my previous
> email is entirely reasonable, since we know that the result of pgd_get()
> will not actually be used.

I guess you could do that as an arm-specific override, but I don't think it adds
anything over using my proposed reworked default? Your call.

> 
>> As an aside, the kernel also dereferences p4d, pud, pmd and pte pointers in
>> various circumstances.
> 
> I already covered these in my previous reply.
> 
>> And other changes in this series are also replacing those
>> direct dereferences with calls to similar helpers. The fact that these are all
>> folded (by a custom arm implementation if I've understood the below correctly)
>> just means that each dereference is returning what you would call the pmd from
>> the HW perspective, I think?
> 
> It'll "return" the first of each pair of level-1 page table entries,
> which is pgd[0] or *p4d, *pud, *pmd - but all of these except *pmd
> need to be optimised away, so throwing lots of READ_ONCE() around
> this code without considering this is certainly the wrong approach.

Yep, got it.

> 
>>>> The core-mm today
>>>> dereferences pgd pointers (and p4d, pud, pmd pointers) directly in its code. See
>>>> follow_pfnmap_start(),
>>>
>>> Doesn't seem to exist at least not in 6.11.
>>
>> Appologies, I'm on mm-unstable and that isn't upstream yet. See follow_pte() in
>> v6.11 or __apply_to_page_range(), or pgd_none_or_clear_bad() as per above.
> 
> Looking at follow_pte(), it's not a problem.
> 
> I think we wouldn't be having this conversation before:
> 
> commit a32618d28dbe6e9bf8ec508ccbc3561a7d7d32f0
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Tue Nov 22 17:30:28 2011 +0000
> 
>     ARM: pgtable: switch to use pgtable-nopud.h
> 
> where:
> -#define pgd_none(pgd)          (0)
> -#define pgd_bad(pgd)           (0)
> 
> existed before this commit - and thus the dereference in things like:
> 
> 	pgd_none(*pgd)
> 
> wouldn't even be visible to beyond the preprocessor step.
> 



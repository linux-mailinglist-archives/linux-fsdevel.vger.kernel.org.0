Return-Path: <linux-fsdevel+bounces-11071-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B48AD850CCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 03:01:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 706DC287B6C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Feb 2024 02:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 533761FA4;
	Mon, 12 Feb 2024 02:00:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0892217C2;
	Mon, 12 Feb 2024 02:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707703251; cv=none; b=I4Nv1FBCepaOfAyXDEmdMB3TzRCliLYcDqYMKIPFAEEKD7kPIA4gdTUk5hnBcrYJPDCRdWtoqS3chN90xr/FbqD2nN78rc7LCQuNMDqfzbY4jjqNqY1EezKBDpt2L2/DTFP7r7Hms9t95t+oel3AdegGVehZ2/A0Zp74DPe4Yz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707703251; c=relaxed/simple;
	bh=6Lf06nnCwCLxaCHtDslobILzwXHZSIpo66gcQObBuEo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=IifZjXZeo27JALVm9EgPwJDFq+05dZykjqc7G3aZWLUnBxJ+CbVJCtO3kJkFTl005oF+aohZBODMOPeo74h1MnbRIwM1n9ADhmZbcXrCItZH5tdXfgLCrxCfr3YmVMTX8UUylE5ySuWafuuhwknZqKGqOwtq9IdVjrsFQFgtEqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 22A1BDA7;
	Sun, 11 Feb 2024 18:01:27 -0800 (PST)
Received: from [10.162.40.23] (unknown [10.162.40.23])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0AA2A3F762;
	Sun, 11 Feb 2024 18:00:43 -0800 (PST)
Message-ID: <e0521fe5-f7d5-404a-b646-6630ddd8a244@arm.com>
Date: Mon, 12 Feb 2024 07:30:40 +0530
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] fs/proc/task_mmu: Add display flag for VM_MAYOVERLAY
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20240208084805.1252337-1-anshuman.khandual@arm.com>
 <fb157154-5661-4925-b2c5-7952188b28f5@redhat.com>
 <20240208124035.1c96c256d6e8c65f70b18675@linux-foundation.org>
 <2e7496af-0988-49fb-9582-bf6a94f08198@redhat.com>
Content-Language: en-US
In-Reply-To: <2e7496af-0988-49fb-9582-bf6a94f08198@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


On 2/10/24 04:01, David Hildenbrand wrote:
> On 08.02.24 21:40, Andrew Morton wrote:
>> On Thu, 8 Feb 2024 17:48:26 +0100 David Hildenbrand <david@redhat.com> wrote:
>>
>>> On 08.02.24 09:48, Anshuman Khandual wrote:
>>>> VM_UFFD_MISSING flag is mutually exclussive with VM_MAYOVERLAY flag as they
>>>> both use the same bit position i.e 0x00000200 in the vm_flags. Let's update
>>>> show_smap_vma_flags() to display the correct flags depending on CONFIG_MMU.
>>>>
>>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>>> Cc: David Hildenbrand <david@redhat.com>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Cc: linux-fsdevel@vger.kernel.org
>>>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>>>> ---
>>>> This applies on v6.8-rc3
>>>>
>>>>    fs/proc/task_mmu.c | 4 ++++
>>>>    1 file changed, 4 insertions(+)
>>>>
>>>> diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
>>>> index 3f78ebbb795f..1c4eb25cfc17 100644
>>>> --- a/fs/proc/task_mmu.c
>>>> +++ b/fs/proc/task_mmu.c
>>>> @@ -681,7 +681,11 @@ static void show_smap_vma_flags(struct seq_file *m, struct vm_area_struct *vma)
>>>>            [ilog2(VM_HUGEPAGE)]    = "hg",
>>>>            [ilog2(VM_NOHUGEPAGE)]    = "nh",
>>>>            [ilog2(VM_MERGEABLE)]    = "mg",
>>>> +#ifdef CONFIG_MMU
>>>>            [ilog2(VM_UFFD_MISSING)]= "um",
>>>> +#else
>>>> +        [ilog2(VM_MAYOVERLAY)]    = "ov",
>>>> +#endif /* CONFIG_MMU */
>>>>            [ilog2(VM_UFFD_WP)]    = "uw",
>>>>    #ifdef CONFIG_ARM64_MTE
>>>>            [ilog2(VM_MTE)]        = "mt",
>>>
>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>
>> I'm thinking
>>
>> Fixes: b6b7a8faf05c ("mm/nommu: don't use VM_MAYSHARE for MAP_PRIVATE mappings")
>> Cc: <stable@vger.kernel.org>
> 
> I'm having a hard time believing that anybody that runs a !MMU kernel would actually care about this bit being exposed as "ov" instead of "uw".
> 
> So in my thinking, one could even update Documentation/filesystems/proc.rst to just mention that "uw" on !MMU is only used for internal purposes.
> 
> But now, I actually read what that structure says:
> 
> "Don't forget to update Documentation/ on changes."
> 
> So, let's look there: Documentation/filesystems/proc.rst
> 
> "Note that there is no guarantee that every flag and associated mnemonic will be present in all further kernel releases. Things get changed, the flags may be vanished or the reverse -- new added. Interpretation of their meaning might change in future as well. So each consumer of these flags has to follow each specific kernel version for the exact semantic.
> 
> This file is only present if the CONFIG_MMU kernel configuration option is enabled."
> 
> And in fact
> 
> $ git grep MMU fs/proc/Makefile
> fs/proc/Makefile:proc-$(CONFIG_MMU)     := task_mmu.o

Ahh! you are right, completely missed that.

> 
> 
> So I rewoke my RB, this patch should be dropped and was never even tested unless I am missing something important.

Fair enough, let's drop this patch. I found this via code inspection while
looking into VM_UFFD_MISSING definition, booted with default configs which
has CONFIG_MMU enabled. But this was an oversight, my bad.


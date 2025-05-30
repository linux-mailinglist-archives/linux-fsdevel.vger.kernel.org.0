Return-Path: <linux-fsdevel+bounces-50126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BB56AC8647
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 04:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79F337A6BDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 May 2025 02:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CEBD15A864;
	Fri, 30 May 2025 02:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="R5cKHIYX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5164A1D;
	Fri, 30 May 2025 02:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748572357; cv=none; b=CQoxf7xezzDI8BuRjm4T+iJ6ZshQJrJoHZPojjh4FK5BqQw7Eohnb4Q5ekSDFQEoPY2gWMeEJgG+inhxX5wsiEO0XrAcRCCEouY1rtYA0JLBBslz+nULnhYXt5MhaMUdxJHaS4m/OJRpeHDx8ZA1TDAZCKM39W9PK4A4Q4QJocw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748572357; c=relaxed/simple;
	bh=XNk7U7Io0evThCV3ya40+xcB4zMlUriEjwU5JF2v+y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rXgnELJDDChehmVwpyGryG4Q1RfNbHTCBNJXPvcSod/VfmGPeplEIWLjSGxjc4LnEVYFN+2MtsMYz2tY29a2anltvPRnRNiaWWodCA50su3HBXeivihFEOLJZ/asOE/X2esFZBURXF9TgrXSzdaek9BLV+ooM5XbDLVw83WaBO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=R5cKHIYX; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1748572345; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=FnpZqDey5u3mslj2S0Hfd7m5wbIzCQtrpGZcOidM//Q=;
	b=R5cKHIYX3wVyi1K1ybr5RTubE/BJEGgDJjDjvIfUGLpkgR2EV2vbMDMfRCJAkC+MM9ox7BvvTXoHUGX5pVusdb/9CWBuTnTh7IZ2wcSBsV8SHhs3U8fGU4dKUmNkGyPBirnyoVnL5jsbvM1PJruTecqslBne2SkSrVLzqfQT7XQ=
Received: from 30.74.144.115(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0WcJeWDE_1748572344 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 30 May 2025 10:32:25 +0800
Message-ID: <6132583a-1754-4eb1-9b84-19b55cac176c@linux.alibaba.com>
Date: Fri, 30 May 2025 10:32:24 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mm: shmem: disallow hugepages if the system-wide
 shmem THP sysfs settings are disabled
To: Zi Yan <ziy@nvidia.com>
Cc: akpm@linux-foundation.org, hughd@google.com, david@redhat.com,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, linux-mm@kvack.org,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <cover.1748506520.git.baolin.wang@linux.alibaba.com>
 <c1a6fe55f668cfe87ad113faa49120f049ba9cb5.1748506520.git.baolin.wang@linux.alibaba.com>
 <BB3BDA79-3185-4346-9260-BA5E1B9C9949@nvidia.com>
 <bd89651e-0ee0-4819-87da-d3a5db04c5b3@linux.alibaba.com>
 <D61B9FA2-4EAC-4F0E-AF56-236D37A766BE@nvidia.com>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <D61B9FA2-4EAC-4F0E-AF56-236D37A766BE@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/5/30 10:17, Zi Yan wrote:
> On 29 May 2025, at 21:58, Baolin Wang wrote:
> 
>> On 2025/5/29 23:21, Zi Yan wrote:
>>> On 29 May 2025, at 4:23, Baolin Wang wrote:
>>>
>>>> The MADV_COLLAPSE will ignore the system-wide shmem THP sysfs settings, which
>>>> means that even though we have disabled the shmem THP configuration, MADV_COLLAPSE
>>>> will still attempt to collapse into a shmem THP. This violates the rule we have
>>>> agreed upon: never means never.
>>>>
>>>> Then the current strategy is:
>>>> For shmem, if none of always, madvise, within_size, and inherit have enabled
>>>> PMD-sized mTHP, then MADV_COLLAPSE will be prohibited from collapsing PMD-sized mTHP.
>>>>
>>>> For tmpfs, if the mount option is set with the 'huge=never' parameter, then
>>>> MADV_COLLAPSE will be prohibited from collapsing PMD-sized mTHP.
>>>>
>>>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>> ---
>>>>    mm/huge_memory.c |  2 +-
>>>>    mm/shmem.c       | 12 ++++++------
>>>>    2 files changed, 7 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>>> index d3e66136e41a..a8cfa37cae72 100644
>>>> --- a/mm/huge_memory.c
>>>> +++ b/mm/huge_memory.c
>>>> @@ -166,7 +166,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>>>>    	 * own flags.
>>>>    	 */
>>>>    	if (!in_pf && shmem_file(vma->vm_file))
>>>> -		return shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>> +		return orders & shmem_allowable_huge_orders(file_inode(vma->vm_file),
>>>>    						   vma, vma->vm_pgoff, 0,
>>>>    						   !enforce_sysfs);
>>>
>>> OK, here orders is checked against allowed orders.
>>>
>>>>
>>>> diff --git a/mm/shmem.c b/mm/shmem.c
>>>> index 4b42419ce6b2..4dbb28d85cd9 100644
>>>> --- a/mm/shmem.c
>>>> +++ b/mm/shmem.c
>>>> @@ -613,7 +613,7 @@ static unsigned int shmem_get_orders_within_size(struct inode *inode,
>>>>    }
>>>>
>>>>    static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>>>> -					      loff_t write_end, bool shmem_huge_force,
>>>> +					      loff_t write_end,
>>>>    					      struct vm_area_struct *vma,
>>>>    					      unsigned long vm_flags)
>>>>    {
>>>> @@ -625,7 +625,7 @@ static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index
>>>>    		return 0;
>>>>    	if (shmem_huge == SHMEM_HUGE_DENY)
>>>>    		return 0;
>>>> -	if (shmem_huge_force || shmem_huge == SHMEM_HUGE_FORCE)
>>>> +	if (shmem_huge == SHMEM_HUGE_FORCE)
>>>>    		return maybe_pmd_order;
>>>
>>> shmem_huge is set by sysfs?
>>
>> Yes, through the '/sys/kernel/mm/transparent_hugepage/shmem_enabled' interface.
>>
>>>>    	/*
>>>> @@ -860,7 +860,7 @@ static unsigned long shmem_unused_huge_shrink(struct shmem_sb_info *sbinfo,
>>>>    }
>>>>
>>>>    static unsigned int shmem_huge_global_enabled(struct inode *inode, pgoff_t index,
>>>> -					      loff_t write_end, bool shmem_huge_force,
>>>> +					      loff_t write_end,
>>>>    					      struct vm_area_struct *vma,
>>>>    					      unsigned long vm_flags)
>>>>    {
>>>> @@ -1261,7 +1261,7 @@ static int shmem_getattr(struct mnt_idmap *idmap,
>>>>    			STATX_ATTR_NODUMP);
>>>>    	generic_fillattr(idmap, request_mask, inode, stat);
>>>>
>>>> -	if (shmem_huge_global_enabled(inode, 0, 0, false, NULL, 0))
>>>> +	if (shmem_huge_global_enabled(inode, 0, 0, NULL, 0))
>>>>    		stat->blksize = HPAGE_PMD_SIZE;
>>>>
>>>>    	if (request_mask & STATX_BTIME) {
>>>> @@ -1768,7 +1768,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>    		return 0;
>>>>
>>>>    	global_orders = shmem_huge_global_enabled(inode, index, write_end,
>>>> -						  shmem_huge_force, vma, vm_flags);
>>>> +						  vma, vm_flags);
>>>>    	/* Tmpfs huge pages allocation */
>>>>    	if (!vma || !vma_is_anon_shmem(vma))
>>>>    		return global_orders;
>>>> @@ -1790,7 +1790,7 @@ unsigned long shmem_allowable_huge_orders(struct inode *inode,
>>>>    	/* Allow mTHP that will be fully within i_size. */
>>>>    	mask |= shmem_get_orders_within_size(inode, within_size_orders, index, 0);
>>>>
>>>> -	if (vm_flags & VM_HUGEPAGE)
>>>> +	if (shmem_huge_force || (vm_flags & VM_HUGEPAGE))
>>>>    		mask |= READ_ONCE(huge_shmem_orders_madvise);
>>>>
>>>>    	if (global_orders > 0)
>>>> -- 
>>>> 2.43.5
>>>
>>> shmem_huge_force comes from !enforce_sysfs in __thp_vma_allowable_orders().
>>> Do you know when sysfs is not enforced and why?
>>
>> IIUC, shmem_huge_force will only be set during MADV_COLLAPSE. Originally, MADV_COLLAPSE was intended to ignore the system-wide THP sysfs settings. However, if all system-wide shmem THP settings are disabled, we should not allow MADV_COLLAPSE to collapse a THP. This is the issue this patchset aims to fix. Thanks for the review.
> 
> Got it. If we want to enforce sysfs, why not just get rid of TVA_ENFORCE_SYSFS
> and make everyone follow sysfs?

Now MADV_COLLAPSE will ignore the VM_HUGEPAGE, while the others will 
check the VM_HUGEPAGE flag before using 'huge_shmem_orders_madvise' with 
the TVA_ENFORCE_SYSFS flag set.

That is to follow the rule: “allowing for collapsing in a VM without 
VM_HUGEPAGE in the "madvise" mode would be fine".

So I think we should still keep the TVA_ENFORCE_SYSFS flag.


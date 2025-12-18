Return-Path: <linux-fsdevel+bounces-71663-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D3767CCBD5D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 13:49:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2430D3031E8F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 12:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17513333740;
	Thu, 18 Dec 2025 12:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ob9xJa4c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725A22BB17
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 12:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766062189; cv=none; b=UTith9iAl4J9sJ1RfMwVUFWj7xJHWnaUGkSA4cxz8T1Hd3zOQoL0P18u/cqdIqUEhmYq8P6dzza4lJAxEaJ9C5b99RHT7zTpWcHFNn/aZahHIm7+V5vxAePjMO4Vc1ojGSw/g0rlUcWebDkCSepELtG9ZXWr6EQqKnyGdmB4EwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766062189; c=relaxed/simple;
	bh=HlSDHO4a+WU2i+f2Bhk05iN0w7JfevP2vf0ALQnLCGo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nu/u+5NOtdO+xX4klkY8jLTRCgZ9B3M9v4qjpPNy+WdwjWr8W7PDUH7lNB0CDvTVablpQadolecc6L6q7N0N+FXeT4qT7Gev883SgL/43SnbG19LwWwCq6tauaZKuByxIkheP00tYZozL5E56GgGUiyTqpIifCY/x7Ues+gmc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ob9xJa4c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69B37C116C6;
	Thu, 18 Dec 2025 12:49:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766062189;
	bh=HlSDHO4a+WU2i+f2Bhk05iN0w7JfevP2vf0ALQnLCGo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ob9xJa4cl7ez4892sUMyEG1ICEn2apZEEPkkbV5ZtnAXtrEXexNJO2CFjkXovdwW+
	 b0hz+SE5H3DPKeY6dEYuI2/lU/D7mAbEclRoIb+hCqDok8K6Z3AZynyMRvI7j6NwBf
	 A/7RVTIDtI+JreIIM9bbRYt59UP1KLSdpcWe9JwdtpaGpiWDo6phf37yoHLjyec/RI
	 VL3Y44LKNA8SMWTJNWE2znCh022a1J+8GKN9K3ZiMaJGYI36aOURV1kD2v+0P+aN38
	 sjs0AZudKD2cEZJ2YPysEnkznlj4niphm5VrCgerqq2PbaYfL6d9HBYqmKY35ZGeZB
	 nR+BZPPaTc0XQ==
Message-ID: <05bbe26e-e71a-4a49-95d2-47373b828145@kernel.org>
Date: Thu, 18 Dec 2025 13:49:43 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] memory leak of xa_node in collapse_file() when
 rollbacks
To: Jinjiang Tu <tujinjiang@huawei.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>, ziy@nvidia.com,
 lorenzo.stoakes@oracle.com, baolin.wang@linux.alibaba.com,
 Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
 dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>,
 Shardul Bankar <shardul.b@mpiricsoftware.com>
References: <86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com>
 <32e4658f-d23b-4bae-9053-acdd5277bb17@kernel.org>
 <4b129453-97d1-4da4-9472-21c1634032d0@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <4b129453-97d1-4da4-9472-21c1634032d0@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/18/25 13:18, Jinjiang Tu wrote:
> 
> 在 2025/12/18 19:51, David Hildenbrand (Red Hat) 写道:
>> On 12/18/25 12:45, Jinjiang Tu wrote:
>>> I encountered a memory leak issue caused by xas_create_range().
>>>
>>> collapse_file() calls xas_create_range() to pre-create all slots needed.
>>> If collapse_file() finally fails, these pre-created slots are empty 
>>> nodes
>>> and aren't destroyed.
>>>
>>> I can reproduce it with following steps.
>>> 1) create file /tmp/test_madvise_collapse and ftruncate to 4MB size, 
>>> and then mmap the file
>>> 2) memset for the first 2MB
>>> 3) madvise(MADV_COLLAPSE) for the second 2MB
>>> 4) unlink the file
>>>
>>> in 3), collapse_file() calls xas_create_range() to expand xarray 
>>> depth, and fails to collapse
>>> due to the whole 2M region is empty, the code is as following:
>>>
>>> collapse_file()
>>>     for (index = start; index < end;) {
>>>         xas_set(&xas, index);
>>>         folio = xas_load(&xas);
>>>
>>>         VM_BUG_ON(index != xas.xa_index);
>>>         if (is_shmem) {
>>>             if (!folio) {
>>>                 /*
>>>                  * Stop if extent has been truncated or
>>>                  * hole-punched, and is now completely
>>>                  * empty.
>>>                  */
>>>                 if (index == start) {
>>>                     if (!xas_next_entry(&xas, end - 1)) {
>>>                         result = SCAN_TRUNCATED;
>>>                         goto xa_locked;
>>>                     }
>>>                 }
>>>                 ...
>>>             }
>>>
>>>
>>> collapse_file() rollback path doesn't destroy the pre-created empty 
>>> nodes.
>>>
>>> When the file is deleted, shmem_evict_inode()->shmem_truncate_range() 
>>> traverses
>>> all entries and calls xas_store(xas, NULL) to delete, if the leaf 
>>> xa_node that
>>> stores deleted entry becomes emtry, xas_store() will automatically 
>>> delete the empty
>>> node and delete it's  parent is empty too, until parent node isn't 
>>> empty. shmem_evict_inode()
>>> won't traverse the empty nodes created by xas_create_range() due to 
>>> these nodes doesn't store
>>> any entries. As a result, these empty nodes are leaked.
>>>
>>> At first, I tried to destory the empty nodes when collapse_file() 
>>> goes to rollback path. However,
>>> collapse_file() only holds xarray lock and may release the lock, so 
>>> we couldn't prevent concurrent
>>> call of collapse_file(), so the deleted empty nodes may be needed by 
>>> other collapse_file() calls.
>>>
>>> IIUC, xas_create_range() is used to guarantee the xas_store(&xas, 
>>> new_folio); succeeds. Could we
>>> remove xas_create_range() call and just rollback when we fail to 
>>> xas_store?
>>
>> Hi,
>>
>> thanks for the report.
>>
>> Is that what [1] is fixing?
>>
>> [1] https://lore.kernel.org/linux-mm/20251204142625.1763372-1- 
>> shardul.b@mpiricsoftware.com/
>>
> No, this patch fixes memory leak caused by xas->xa_alloc allocated by xas_nomem() and the xa_node
> isn't installed into xarray.
> 
> In my case, the leaked xa_nodes have been installed into xarray by xas_create_range().

Thanks for checking. I thought that was also discussed as part of the 
other fix.

See [2] where we have

"Note: This fixes the leak of pre-allocated nodes. A separate fix will
be needed to clean up empty nodes that were inserted into the tree by
xas_create_range() but never populated."

Is that the issue you are describing? (sounds like it, but I only 
skimmed over the details).

CCing Shardul.


[2] 
https://lore.kernel.org/linux-mm/20251123132727.3262731-1-shardul.b@mpiricsoftware.com/

-- 
Cheers

David


Return-Path: <linux-fsdevel+bounces-71660-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62208CCBAF4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 12:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C591301F8E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Dec 2025 11:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B64A9328254;
	Thu, 18 Dec 2025 11:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bF7EOa85"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F54C13D2B2
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Dec 2025 11:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766058704; cv=none; b=UpNbHoKK8elPe8N0Q0kvv0pEP+CxyBCTr19Dt9ufuOcWSuenloDA++5S1pr7exmzoUiA1ZNDfAVTbUx5KII6lOB+qKFt2Xxbx0hvAT8d0TOdAMNcE4SlCjN1Gzh++alOJNNBprwgyp7cCFO9iRbIZQoH8P4H+9LbzrGYQhnqAPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766058704; c=relaxed/simple;
	bh=9hGn2FeJPN4hnz5ZpNDfyZdQc2Q/0q3NgIHMdRCBgpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JQoqKMoPaYx+YdiRn8aPTHSL7JuILOCHDtDHurZNDzwaBh41az4rCz4JPUWFMzpK562WK0RCyMFg2eDY8yhiFwtInSF2A6TJB9SRZe1MaUwIAIvsoqJc1tGc80p/Y58StH/Di85VJ/Nn9jdrpkT0SwkGWC/9AP/WvZvG/yHG88U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bF7EOa85; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6819C4CEFB;
	Thu, 18 Dec 2025 11:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766058703;
	bh=9hGn2FeJPN4hnz5ZpNDfyZdQc2Q/0q3NgIHMdRCBgpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=bF7EOa85IixPjgRaZ2KOj1lp6hbMTILcry6l6a/ENPkhpNsWTIwQPPLCNr9q7cWWE
	 mWo3UU3mrvuytkMEHVa+Y7aFx4HenCeQR/V6ze+QnrydfuZJlsTfEzWLydbsbQ9y4l
	 9mX/ib/EdLG5YdXKlgQXZIaweitfFvrg/CnV7IHUd8EnLADIM5FIXoO8TerDTaTd9Q
	 uAl83Pru6+Csuea9rmZRBLxqInKMyCfyPngAnojRT8LYO26s05aZVlADUrFmniVocG
	 jQoEClg+pJz+PlZ12G5/e1tFXcrJ0/8+Op5T6XTTnyVVCyQ75NLlhQSI4i5DfcYrIf
	 nuhtzr1CLQkTQ==
Message-ID: <32e4658f-d23b-4bae-9053-acdd5277bb17@kernel.org>
Date: Thu, 18 Dec 2025 12:51:38 +0100
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
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
References: <86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <86834731-02ba-43ea-9def-8b8ca156ec4a@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/18/25 12:45, Jinjiang Tu wrote:
> I encountered a memory leak issue caused by xas_create_range().
> 
> collapse_file() calls xas_create_range() to pre-create all slots needed.
> If collapse_file() finally fails, these pre-created slots are empty nodes
> and aren't destroyed.
> 
> I can reproduce it with following steps.
> 1) create file /tmp/test_madvise_collapse and ftruncate to 4MB size, and then mmap the file
> 2) memset for the first 2MB
> 3) madvise(MADV_COLLAPSE) for the second 2MB
> 4) unlink the file
> 
> in 3), collapse_file() calls xas_create_range() to expand xarray depth, and fails to collapse
> due to the whole 2M region is empty, the code is as following:
> 
> collapse_file()
> 	for (index = start; index < end;) {
> 		xas_set(&xas, index);
> 		folio = xas_load(&xas);
> 
> 		VM_BUG_ON(index != xas.xa_index);
> 		if (is_shmem) {
> 			if (!folio) {
> 				/*
> 				 * Stop if extent has been truncated or
> 				 * hole-punched, and is now completely
> 				 * empty.
> 				 */
> 				if (index == start) {
> 					if (!xas_next_entry(&xas, end - 1)) {
> 						result = SCAN_TRUNCATED;
> 						goto xa_locked;
> 					}
> 				}
> 				...
> 			}
> 
> 
> collapse_file() rollback path doesn't destroy the pre-created empty nodes.
> 
> When the file is deleted, shmem_evict_inode()->shmem_truncate_range() traverses
> all entries and calls xas_store(xas, NULL) to delete, if the leaf xa_node that
> stores deleted entry becomes emtry, xas_store() will automatically delete the empty
> node and delete it's  parent is empty too, until parent node isn't empty. shmem_evict_inode()
> won't traverse the empty nodes created by xas_create_range() due to these nodes doesn't store
> any entries. As a result, these empty nodes are leaked.
> 
> At first, I tried to destory the empty nodes when collapse_file() goes to rollback path. However,
> collapse_file() only holds xarray lock and may release the lock, so we couldn't prevent concurrent
> call of collapse_file(), so the deleted empty nodes may be needed by other collapse_file() calls.
> 
> IIUC, xas_create_range() is used to guarantee the xas_store(&xas, new_folio); succeeds. Could we
> remove xas_create_range() call and just rollback when we fail to xas_store?

Hi,

thanks for the report.

Is that what [1] is fixing?

[1] 
https://lore.kernel.org/linux-mm/20251204142625.1763372-1-shardul.b@mpiricsoftware.com/

-- 
Cheers

David


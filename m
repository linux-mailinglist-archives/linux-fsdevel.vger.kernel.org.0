Return-Path: <linux-fsdevel+bounces-62857-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EF89BA2AF3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 09:19:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AD033845A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Sep 2025 07:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD9C2848A4;
	Fri, 26 Sep 2025 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LdiHvY8P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D37181A9F92
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Sep 2025 07:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758871183; cv=none; b=P4gPhcsEAewFMJz86t06jvCQ4Hg9Sfc8dGaSKYV3fChr8W2tSYP+VP3p5s7wa/Wxwla5Gsb1Nc1b0rYrrcX8MCi/vzenXBMyZJy4OYU0l/LCdr7iiJhKkSsEgc1lhVkk0hZWkq2w1OQZm7YyhZwg4qYFg2IfA7ZDUeZYqzU/WRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758871183; c=relaxed/simple;
	bh=JRdElAaYrsMk/hbGLO3LzmgAJ7Fs0pbrMFXUsevzipA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LeZ1agLAJ8qTgyFtfpC1gT9xWkJP1wLLo7Eq0OaWQYVQWMZpLX9ZcLEPyhufs2T+xLsJivjVGNs9rFf0Tn6hmZww6iEBK4y+0ChHz0DNcxzS8UpHRu9/11tqtURSEWUOw/eb8bF0ng+23TsDyNkeNGSEj+iQsnP7qhzEUoFez3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LdiHvY8P; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1758871171; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=7+Lid7tVANbv9C0w36HA1kzx8jVyBUlqgWSlAu0EAzI=;
	b=LdiHvY8PaDTFLgZfkj4+mYgBTUFqFYw/L4e8X8IJJL41HIFcLoTb1KWsE2JLMKWjOVVojl4OG22ScAqQLbmJWYQxdq1XtByeB4KmB3qoEa3N4I/BhznajryZBT28RdDcJ/wwqMtCjkzbwWTGa5ccro2UQmIBReg0cwtocBtwQYo=
Received: from 30.221.128.184(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0WorFx8U_1758871170 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 26 Sep 2025 15:19:30 +0800
Message-ID: <9e9d5912-db2f-4945-918a-9c133b6aff81@linux.alibaba.com>
Date: Fri, 26 Sep 2025 15:19:30 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix readahead reclaim deadlock
From: Gao Xiang <hsiangkao@linux.alibaba.com>
To: Joanne Koong <joannelkoong@gmail.com>, miklos@szeredi.hu
Cc: linux-fsdevel@vger.kernel.org, osandov@fb.com, kernel-team@meta.com
References: <20250925224404.2058035-1-joannelkoong@gmail.com>
 <dc3fbd15-1234-485e-a11d-4e468db635cd@linux.alibaba.com>
In-Reply-To: <dc3fbd15-1234-485e-a11d-4e468db635cd@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/26 14:51, Gao Xiang wrote:
> 
> 
> On 2025/9/26 06:44, Joanne Koong wrote:
>> A deadlock can occur if the server triggers reclaim while servicing a
>> readahead request, and reclaim attempts to evict the inode of the file
>> being read ahead:
>>
>>>>> stack_trace(1504735)
>>   folio_wait_bit_common (mm/filemap.c:1308:4)
>>   folio_lock (./include/linux/pagemap.h:1052:3)
>>   truncate_inode_pages_range (mm/truncate.c:336:10)
>>   fuse_evict_inode (fs/fuse/inode.c:161:2)
>>   evict (fs/inode.c:704:3)
>>   dentry_unlink_inode (fs/dcache.c:412:3)
>>   __dentry_kill (fs/dcache.c:615:3)
>>   shrink_kill (fs/dcache.c:1060:12)
>>   shrink_dentry_list (fs/dcache.c:1087:3)
>>   prune_dcache_sb (fs/dcache.c:1168:2)
>>   super_cache_scan (fs/super.c:221:10)
>>   do_shrink_slab (mm/shrinker.c:435:9)
>>   shrink_slab (mm/shrinker.c:626:10)
>>   shrink_node (mm/vmscan.c:5951:2)
>>   shrink_zones (mm/vmscan.c:6195:3)
>>   do_try_to_free_pages (mm/vmscan.c:6257:3)
>>   do_swap_page (mm/memory.c:4136:11)
>>   handle_pte_fault (mm/memory.c:5562:10)
>>   handle_mm_fault (mm/memory.c:5870:9)
>>   do_user_addr_fault (arch/x86/mm/fault.c:1338:10)
>>   handle_page_fault (arch/x86/mm/fault.c:1481:3)
>>   exc_page_fault (arch/x86/mm/fault.c:1539:2)
>>   asm_exc_page_fault+0x22/0x27
>>
>> During readahead, the folio is locked. When fuse_evict_inode() is
>> called, it attempts to remove all folios associated with the inode from
>> the page cache (truncate_inode_pages_range()), which requires acquiring
>> the folio lock. If the server triggers reclaim while servicing a
>> readahead request, reclaim will block indefinitely waiting for the folio
>> lock, while readahead cannot relinquish the lock because it is itself
>> blocked in reclaim, resulting in a deadlock.
>>
>> The inode is only evicted if it has no remaining references after its
>> dentry is unlinked. Since readahead is asynchronous, it is not
>> guaranteed that the inode will have any references at this point.
>>
>> This fixes the deadlock by holding a reference on the inode while
>> readahead is in progress, which prevents the inode from being evicted
>> until readahead completes. Additionally, this also prevents a malicious
>> or buggy server from indefinitely blocking kswapd if it never fulfills a
>> readahead request.
>>
>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>> Reported-by: Omar Sandoval <osandov@fb.com>
>> ---
>>   fs/fuse/file.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>> index f1ef77a0be05..8e759061b843 100644
>> --- a/fs/fuse/file.c
>> +++ b/fs/fuse/file.c
>> @@ -893,6 +893,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>>       if (ia->ff)
>>           fuse_file_put(ia->ff, false);
>> +    iput(inode);
> 
> It's somewhat odd to use `igrab` and `iput` in the read(ahead)
> context.
> 
> I wonder for FUSE, if it's possible to just wait ongoing
> locked folios when i_count == 0 (e.g. in .drop_inode) before
> adding into lru so that the final inode eviction won't wait
> its readahead requests itself so that deadlock like this can
> be avoided.

Oh, it was in the dentry LRU list instead, I don't think it can
work.

Or normally the kernel filesystem uses GFP_NOFS to avoid such
deadlock (see `if (!(sc->gfp_mask & __GFP_FS))` in
super_cache_scan()), I wonder if the daemon should simply use
prctl(PR_SET_IO_FLUSHER) so that the user daemon won't be called
into the fs reclaim context again.

Thanks,
Gao Xiang

> 
> Thanks,
> Gao Xiang
> 
> 
>>       fuse_io_free(ia);
>>   }
>> @@ -973,6 +974,12 @@ static void fuse_readahead(struct readahead_control *rac)
>>           ia = fuse_io_alloc(NULL, cur_pages);
>>           if (!ia)
>>               break;
>> +        /*
>> +         *  Acquire the inode ref here to prevent reclaim from
>> +         *  deadlocking. The ref gets dropped in fuse_readpages_end().
>> +         */
>> +        igrab(inode);
>> +
>>           ap = &ia->ap;
>>           while (pages < cur_pages) {
> 



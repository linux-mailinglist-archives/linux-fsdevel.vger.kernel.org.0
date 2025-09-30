Return-Path: <linux-fsdevel+bounces-63065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4A8CBAAFC1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 04:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BAD53C591A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Sep 2025 02:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC15219A8D;
	Tue, 30 Sep 2025 02:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BTTHUdTw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F781EC018
	for <linux-fsdevel@vger.kernel.org>; Tue, 30 Sep 2025 02:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759198913; cv=none; b=n2gxoYkI4tq9nXB8gj84kgaJL0dzSsvIh2qMyKeplD5UsgWVmQoPF5xpHf4UITVbuco9Y1qgA1wl/br4apFcGNkkAAMcxyqEevXvAPjPRSgcL96oXtn2GTo402RRytoAGioUGm9ROFqESGcCHY+exf0Fm5bECCmUXptGggc1v7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759198913; c=relaxed/simple;
	bh=MAayKVnZRaE70tLxoXmnd243+ggD/ch+9dRGfJZ0YW0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lG08BdvxowTbbZaDh34nMrhWtJMPeqWeDSh5GKaLVCLXjsDRD64n8DX9eIweJLZoJOl77hrGByivVWr3/ONY5j9qUFenuUcpkqzWbPnxjoxBK1wACQSDXAX7Ne7LJRxjl9V6+lL+wVk5K1LCNcCWhkoK61aXLVJCCcfOPLET5PE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BTTHUdTw; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759198907; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=bVIqxn7OwzBynN9iiDhW241kr888HFY6E3jT2k/ZLrk=;
	b=BTTHUdTw5/XKY+4fXb3v3AasGyUjJQDlFWj01AQPby9My/TwluHni1wjwjzvyErYTnYJUsu4JlmYrg8C7jM8iEU0RLfzu9a0cExtAIbD8R3inbavnZeVyoEk1bDR7wLxuvk8My2MT2DSRcalxG7sq75pKb4k9hb81+8a1RkRAXc=
Received: from 30.221.129.112(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0Wp9iBmp_1759198906 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 10:21:46 +0800
Message-ID: <a517168d-840f-483b-b9a1-4b9c417df217@linux.alibaba.com>
Date: Tue, 30 Sep 2025 10:21:46 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: fix readahead reclaim deadlock
To: Joanne Koong <joannelkoong@gmail.com>
Cc: miklos@szeredi.hu, linux-fsdevel@vger.kernel.org, osandov@fb.com,
 kernel-team@meta.com
References: <20250925224404.2058035-1-joannelkoong@gmail.com>
 <dc3fbd15-1234-485e-a11d-4e468db635cd@linux.alibaba.com>
 <9e9d5912-db2f-4945-918a-9c133b6aff81@linux.alibaba.com>
 <CAJnrk1b=0ug8RMZEggVQpcQzG=Q=msZimjeoEPwwp260dbZ1eg@mail.gmail.com>
From: Gao Xiang <hsiangkao@linux.alibaba.com>
In-Reply-To: <CAJnrk1b=0ug8RMZEggVQpcQzG=Q=msZimjeoEPwwp260dbZ1eg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/30 01:25, Joanne Koong wrote:
> On Fri, Sep 26, 2025 at 12:19 AM Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
>>
>> On 2025/9/26 14:51, Gao Xiang wrote:
>>>
>>> On 2025/9/26 06:44, Joanne Koong wrote:
>>>> A deadlock can occur if the server triggers reclaim while servicing a
>>>> readahead request, and reclaim attempts to evict the inode of the file
>>>> being read ahead:
>>>>
>>>>>>> stack_trace(1504735)
>>>>    folio_wait_bit_common (mm/filemap.c:1308:4)
>>>>    folio_lock (./include/linux/pagemap.h:1052:3)
>>>>    truncate_inode_pages_range (mm/truncate.c:336:10)
>>>>    fuse_evict_inode (fs/fuse/inode.c:161:2)
>>>>    evict (fs/inode.c:704:3)
>>>>    dentry_unlink_inode (fs/dcache.c:412:3)
>>>>    __dentry_kill (fs/dcache.c:615:3)
>>>>    shrink_kill (fs/dcache.c:1060:12)
>>>>    shrink_dentry_list (fs/dcache.c:1087:3)
>>>>    prune_dcache_sb (fs/dcache.c:1168:2)
>>>>    super_cache_scan (fs/super.c:221:10)
>>>>    do_shrink_slab (mm/shrinker.c:435:9)
>>>>    shrink_slab (mm/shrinker.c:626:10)
>>>>    shrink_node (mm/vmscan.c:5951:2)
>>>>    shrink_zones (mm/vmscan.c:6195:3)
>>>>    do_try_to_free_pages (mm/vmscan.c:6257:3)
>>>>    do_swap_page (mm/memory.c:4136:11)
>>>>    handle_pte_fault (mm/memory.c:5562:10)
>>>>    handle_mm_fault (mm/memory.c:5870:9)
>>>>    do_user_addr_fault (arch/x86/mm/fault.c:1338:10)
>>>>    handle_page_fault (arch/x86/mm/fault.c:1481:3)
>>>>    exc_page_fault (arch/x86/mm/fault.c:1539:2)
>>>>    asm_exc_page_fault+0x22/0x27
>>>>
>>>> During readahead, the folio is locked. When fuse_evict_inode() is
>>>> called, it attempts to remove all folios associated with the inode from
>>>> the page cache (truncate_inode_pages_range()), which requires acquiring
>>>> the folio lock. If the server triggers reclaim while servicing a
>>>> readahead request, reclaim will block indefinitely waiting for the folio
>>>> lock, while readahead cannot relinquish the lock because it is itself
>>>> blocked in reclaim, resulting in a deadlock.
>>>>
>>>> The inode is only evicted if it has no remaining references after its
>>>> dentry is unlinked. Since readahead is asynchronous, it is not
>>>> guaranteed that the inode will have any references at this point.
>>>>
>>>> This fixes the deadlock by holding a reference on the inode while
>>>> readahead is in progress, which prevents the inode from being evicted
>>>> until readahead completes. Additionally, this also prevents a malicious
>>>> or buggy server from indefinitely blocking kswapd if it never fulfills a
>>>> readahead request.
>>>>
>>>> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
>>>> Reported-by: Omar Sandoval <osandov@fb.com>
>>>> ---
>>>>    fs/fuse/file.c | 7 +++++++
>>>>    1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
>>>> index f1ef77a0be05..8e759061b843 100644
>>>> --- a/fs/fuse/file.c
>>>> +++ b/fs/fuse/file.c
>>>> @@ -893,6 +893,7 @@ static void fuse_readpages_end(struct fuse_mount *fm, struct fuse_args *args,
>>>>        if (ia->ff)
>>>>            fuse_file_put(ia->ff, false);
>>>> +    iput(inode);
>>>
>>> It's somewhat odd to use `igrab` and `iput` in the read(ahead)
>>> context.
>>>
>>> I wonder for FUSE, if it's possible to just wait ongoing
>>> locked folios when i_count == 0 (e.g. in .drop_inode) before
>>> adding into lru so that the final inode eviction won't wait
>>> its readahead requests itself so that deadlock like this can
>>> be avoided.
>>
>> Oh, it was in the dentry LRU list instead, I don't think it can
>> work.
>>
>> Or normally the kernel filesystem uses GFP_NOFS to avoid such
>> deadlock (see `if (!(sc->gfp_mask & __GFP_FS))` in
>> super_cache_scan()), I wonder if the daemon should simply use
>> prctl(PR_SET_IO_FLUSHER) so that the user daemon won't be called
>> into the fs reclaim context again.
> 
> Hi Gao,
> 
> We cannot rely on the daemon to set this unfortunately. This can tie
> up reclaim and kswapd for the entire system so I think this
> enforcement needs to be guaranteed and at the kernel level. For
> example, there is the possibility of malicious servers, which we
> cannot rely on to set FR_SET_IO_FLUSHER.

Hi Joanne,

Yes, currently I don't have a saner way in my mind but iput()
in such nested context sounds a new entry (e.g. I thought
kernel page fault path should have nothing tangled with
evict() directly but I may be wrong.)

In principle, typical the kernel filesystem holds a valid `file`
during the entire buffered read (file)/mmap (vma->vm_file)
submission path (and of course they won't upcall to userspace
and then do random behavior in the userspace for I/O processing).

So for the kernel filesystems I think the GFP_NOFS allocation
isn't needed since `file.f_path` always takes a valid dentry
ref during the submission so that such dentry/inode reclaim
above is impossible IMO.)

Thanks,
Gao Xiang

> 
> Thanks,
> Joanne
> 


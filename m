Return-Path: <linux-fsdevel+bounces-38747-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5180FA07BE4
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 16:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B9137A3A9F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 15:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96DB521CA01;
	Thu,  9 Jan 2025 15:24:39 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C944321C9FB
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Jan 2025 15:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736436279; cv=none; b=tX/pcVOfTirgxvwqfjEK/Cf0wPeR/b0LFXqiMtfuJKobGsL4/A7V6IttRjUMrAR0TB9cjAtQ7GpL4C72gP6jbWd++ujeuS2D9yjLfwFPy77AG82ofH4iejKchvjQ38kJ/eiYnctn1MUPnCnCO9LhmEUURtgDS0eVmTnHEMKF0Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736436279; c=relaxed/simple;
	bh=Any0J+MC1u07ysr1CDLiCxboTH2i5szEUpw6M13fECY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Rs1fpj2FPaUz6Mc0mQG0YSeZFfIhChSyjJqRcc+u05dulX3dlsPj78gJNBupRSKJbbN4GqzN7eMnwR07Sa4YosVfTmusnHFHsSlIwdpZihQLV/1tvKFd46AtaWp3dyc6v7TxQBIQaRS6iRTmcaj92cyFiLTMY/QXa1IAd0yiTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3538A13D5;
	Thu,  9 Jan 2025 07:25:04 -0800 (PST)
Received: from [10.1.37.181] (XHFQ2J9959.cambridge.arm.com [10.1.37.181])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0E11A3F59E;
	Thu,  9 Jan 2025 07:24:34 -0800 (PST)
Message-ID: <c842632d-3924-4228-b92d-9255aae9939b@arm.com>
Date: Thu, 9 Jan 2025 15:24:33 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
Content-Language: en-GB
From: Ryan Roberts <ryan.roberts@arm.com>
To: Phillip Lougher <phillip@squashfs.org.uk>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>
References: <20241220224634.723899-1-willy@infradead.org>
 <20241220224634.723899-5-willy@infradead.org>
 <c37bc614-2656-44c4-9aed-c30fe6438677@squashfs.org.uk>
 <5cf5a52c-e5f4-4486-8421-c7fe913c43c4@arm.com>
In-Reply-To: <5cf5a52c-e5f4-4486-8421-c7fe913c43c4@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 09/01/2025 15:22, Ryan Roberts wrote:
> Hi Matthew,
> 
> On 30/12/2024 00:45, Phillip Lougher wrote:
>>
>>
>> On 12/20/24 22:46, Matthew Wilcox (Oracle) wrote:
>>> squashfs_fill_page is only used in this file, so make it static.
>>> Use kmap_local instead of kmap_atomic, and return a bool so that
>>> the caller can use folio_end_read() which saves an atomic operation
>>> over calling folio_mark_uptodate() followed by folio_unlock().
>>>
>>> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>>> ---
>>>   fs/squashfs/file.c     | 21 ++++++++++++---------
>>>   fs/squashfs/squashfs.h |  1 -
>>>   2 files changed, 12 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
>>> index 1f27e8161319..da25d6fa45ce 100644
>>> --- a/fs/squashfs/file.c
>>> +++ b/fs/squashfs/file.c
>>> @@ -362,19 +362,21 @@ static int read_blocklist(struct inode *inode, int
>>> index, u64 *block)
>>>       return squashfs_block_size(size);
>>>   }
>>>   -void squashfs_fill_page(struct page *page, struct squashfs_cache_entry
>>> *buffer, int offset, int avail)
>>> +static bool squashfs_fill_page(struct folio *folio,
>>> +        struct squashfs_cache_entry *buffer, size_t offset,
>>> +        size_t avail)
>>>   {
>>> -    int copied;
>>> +    size_t copied;
>>>       void *pageaddr;
>>>   -    pageaddr = kmap_atomic(page);
>>> +    pageaddr = kmap_local_folio(folio, 0);
>>>       copied = squashfs_copy_data(pageaddr, buffer, offset, avail);
>>>       memset(pageaddr + copied, 0, PAGE_SIZE - copied);
>>> -    kunmap_atomic(pageaddr);
>>> +    kunmap_local(pageaddr);
>>>   -    flush_dcache_page(page);
>>> -    if (copied == avail)
>>> -        SetPageUptodate(page);
>>> +    flush_dcache_folio(folio);
>>> +
>>> +    return copied == avail;
>>>   }
>>>     /* Copy data into page cache  */
>>> @@ -398,6 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
>>>               bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
>>>           struct folio *push_folio;
>>>           size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
>>> +        bool uptodate = true;
>>>             TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
>>>   @@ -412,9 +415,9 @@ void squashfs_copy_cache(struct folio *folio,
>>>           if (folio_test_uptodate(push_folio))
>>>               goto skip_folio;
>>>   -        squashfs_fill_page(&push_folio->page, buffer, offset, avail);
>>> +        uptodate = squashfs_fill_page(push_folio, buffer, offset, avail);
>>>   skip_folio:
>>> -        folio_unlock(push_folio);
>>> +        folio_end_read(push_folio, uptodate);
>>
>> Hi Matthew,
>>
>> I'm still getting an oops with this (V2) patch.  The same as before, which is an
>> assert in folio_end_read() triggers.
>>
>> Looking at the code in folio_end_read(), the assert appears to happen irrespective
>> of the value of success.
> 
> I've just hit the same oops. Just prodding since the original report is now 
> getting on for 2 weeks old.

Sorry forgot to mention I'm hitting it against today's -next (next-20250109).

> 
> I believe the issue is due to calling folio_end_read() with an uptodate folio, 
> and triggering VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio). Prior to this 
> change, folio_unlock() was called which doesn't have this assert. It's possible 
> to call this for an uptodate folio via the "skip_folio" goto.
> 
> I guess either you want to remove the assert (if it's valid to call 
> folio_end_read() for already-uptodate folios) or continue to call folio_unlock() 
> for the already-uptodate case?
> 
> Including my oops (from arm64 for completeness):
> 
> 
> [    5.333160] kernel BUG at mm/filemap.c:1526!
> [    5.333729] Internal error: Oops - BUG: 00000000f2000800 [#1] PREEMPT SMP
> [    5.334590] Modules linked in:
> [    5.335020] CPU: 4 UID: 0 PID: 534 Comm: snap Tainted: G        W          6.13.0-rc4-00152-g0187b83d8f07 #30
> [    5.336387] Tainted: [W]=WARN
> [    5.336774] Hardware name: linux,dummy-virt (DT)
> [    5.337416] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    5.338391] pc : folio_end_read+0xe0/0xf0
> [    5.338973] lr : folio_end_read+0xe0/0xf0
> [    5.339522] sp : ffff80008c903a00
> [    5.339961] x29: ffff80008c903a00 x28: fffffdffc66cfbc0 x27: 0000000000001000
> [    5.340932] x26: ffff000190224728 x25: ffff0001914a7c60 x24: 0000000000000cbf
> [    5.341934] x23: 0000000000001000 x22: 0000000000000ca0 x21: fffffdffc66cd340
> [    5.342936] x20: 0000000000000001 x19: fffffdffc66cfbc0 x18: 0000000000000010
> [    5.343947] x17: 3130303066666666 x16: 2031303030303030 x15: 3034303030303030
> [    5.345034] x14: 0000000000000000 x13: 29296f696c6f6628 x12: 657461646f747075
> [    5.345983] x11: 5f747365745f6f69 x10: ffff8000832df210 x9 : ffff80008013bc6c
> [    5.346970] x8 : 00000000ffffefff x7 : ffff8000832df210 x6 : 0000000000000000
> [    5.347933] x5 : ffff0002fe5693c8 x4 : 0000000000000fff x3 : 0000000000000000
> [    5.348899] x2 : 0000000000000000 x1 : ffff000196701180 x0 : 0000000000000040
> [    5.349865] Call trace:
> [    5.350195]  folio_end_read+0xe0/0xf0 (P)
> [    5.350756]  squashfs_copy_cache+0xd8/0x210
> [    5.351348]  squashfs_readpage_block+0x98/0xa8
> [    5.351944]  squashfs_read_folio+0x164/0x2a8
> [    5.352536]  filemap_read_folio+0x44/0x110
> [    5.353110]  filemap_fault+0x85c/0xa10
> [    5.353650]  __do_fault+0x44/0x320
> [    5.354132]  do_fault+0x304/0x6d0
> [    5.354605]  __handle_mm_fault+0x660/0xb38
> [    5.355200]  handle_mm_fault+0xbc/0x2b0
> [    5.355738]  do_page_fault+0x130/0x5c0
> [    5.356269]  do_translation_fault+0xc4/0xe8
> [    5.356852]  do_mem_abort+0x4c/0xa8
> [    5.357350]  el0_da+0x2c/0xa0
> [    5.357776]  el0t_64_sync_handler+0x134/0x168
> [    5.358378]  el0t_64_sync+0x198/0x1a0
> [    5.358892] Code: aa1303e0 9000efc1 910e6021 940138b5 (d4210000) 
> [    5.359921] ---[ end trace 0000000000000000 ]---
> [    5.360569] note: snap[534] exited with irqs disabled
> [    5.361296] note: snap[534] exited with preempt_count 1
> [    5.362004] ------------[ cut here ]------------
> [    5.362593] WARNING: CPU: 4 PID: 0 at kernel/context_tracking.c:128 ct_kernel_exit.constprop.0+0xfc/0x118
> [    5.363859] Modules linked in:
> [    5.364250] CPU: 4 UID: 0 PID: 0 Comm: swapper/4 Tainted: G      D W          6.13.0-rc4-00152-g0187b83d8f07 #30
> [    5.365562] Tainted: [D]=DIE, [W]=WARN
> [    5.366057] Hardware name: linux,dummy-virt (DT)
> [    5.366679] pstate: 204003c5 (nzCv DAIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> [    5.367587] pc : ct_kernel_exit.constprop.0+0xfc/0x118
> [    5.368265] lr : ct_idle_enter+0x10/0x20
> [    5.368783] sp : ffff800083b63dc0
> [    5.369222] x29: ffff800083b63dc0 x28: 0000000000000000 x27: 0000000000000000
> [    5.370288] x26: 0000000000000000 x25: ffff000181c58000 x24: 0000000000000000
> [    5.371285] x23: 0000000000000000 x22: ffff800083259e20 x21: ffff8000826973f0
> [    5.372236] x20: ffff800083259d00 x19: ffff0002fe578548 x18: ffffffffffffffff
> [    5.373199] x17: 3430303030303030 x16: 3030303030303020 x15: 0774076e0775076f
> [    5.374160] x14: 0000000000000016 x13: ffff80008327fa18 x12: 0000000000000000
> [    5.375129] x11: 00000069af8f73f8 x10: 0000000000000ae0 x9 : ffff80008019e15c
> [    5.376034] x8 : ffff000181c58b40 x7 : ffff00018b79cb00 x6 : ffff0002fe57d641
> [    5.376967] x5 : 4000000000000002 x4 : ffff80027bee4000 x3 : ffff800083b63dc0
> [    5.377904] x2 : ffff800082694548 x1 : ffff800082694548 x0 : 4000000000000000
> [    5.378832] Call trace:
> [    5.379168]  ct_kernel_exit.constprop.0+0xfc/0x118 (P)
> [    5.379862]  ct_idle_enter+0x10/0x20
> [    5.380371]  default_idle_call+0x24/0x158
> [    5.380913]  do_idle+0x20c/0x270
> [    5.381365]  cpu_startup_entry+0x3c/0x50
> [    5.381880]  secondary_start_kernel+0x138/0x160
> [    5.382518]  __secondary_switched+0xc0/0xc8
> [    5.383091] ---[ end trace 0000000000000000 ]---
> 
> 
> Thanks,
> Ryan
> 
> 
>>
>> void folio_end_read(struct folio *folio, bool success)
>> {
>>     unsigned long mask = 1 << PG_locked;
>>
>>     /* Must be in bottom byte for x86 to work */
>>     BUILD_BUG_ON(PG_uptodate > 7);
>>     VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
>>     VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
>>
>>     if (likely(success))
>>         mask |= 1 << PG_uptodate;
>>     if (folio_xor_flags_has_waiters(folio, mask))
>>         folio_wake_bit(folio, PG_locked);
>> }
>> EXPORT_SYMBOL(folio_end_read);
>>
>> Thanks
>>
>> Phillip
>>
>> The oops is
>>
>> [  977.270664][ T7696] page: refcount:2 mapcount:0 mapping:ffff8880114c1c98
>> index:0x100 pfn:0x2022c
>> [  977.271277][ T7696] memcg:ffff8880162c4000
>> [  977.271501][ T7696] aops:squashfs_aops ino:1f dentry name(?):".tmp_vmlinux2"
>> [  977.271941][ T7696] flags: 0x200000000000012d(locked|referenced|uptodate|lru|
>> active|zone=1)
>> [  977.272375][ T7696] raw: 200000000000012d ffffea0000aeaf08 ffffea00009ae388
>> ffff8880114c1c98
>> [  977.272796][ T7696] raw: 0000000000000100 0000000000000000 00000002ffffffff
>> ffff8880162c4000
>> [  977.273215][ T7696] page dumped because:
>> VM_BUG_ON_FOLIO(folio_test_uptodate(folio))
>> [  977.273600][ T7696] page_owner tracks the page as allocated
>> [  977.273916][ T7696] page last allocated via order 0, migratetype Movable,
>> gfp_mask 0x152c4a(GFP_NOFS|__GFP_HIGH0
>> [  977.274987][ T7696]  post_alloc_hook+0x2d0/0x350
>> [  977.275233][ T7696]  get_page_from_freelist+0xb39/0x22a0
>> [  977.275512][ T7696]  __alloc_pages_slowpath.constprop.0+0x2ff/0x2650
>> [  977.275872][ T7696]  __alloc_pages_noprof+0x3e6/0x480
>> [  977.276139][ T7696]  __folio_alloc_noprof+0x11/0x90
>> [  977.276392][ T7696]  page_cache_ra_unbounded+0x2e3/0x750
>> [  977.276779][ T7696]  page_cache_ra_order+0x8ef/0xc30
>> [  977.277057][ T7696]  page_cache_async_ra+0x5cb/0x820
>> [  977.277530][ T7696]  filemap_get_pages+0x105b/0x1bd0
>> [  977.277827][ T7696]  filemap_read+0x3b6/0xd50
>> [  977.278058][ T7696]  generic_file_read_iter+0x344/0x450
>> [  977.278323][ T7696]  __kernel_read+0x3b5/0xb10
>> [  977.278581][ T7696]  integrity_kernel_read+0x7f/0xb0
>> [  977.278844][ T7696]  ima_calc_file_hash_tfm+0x2bc/0x3d0
>> [  977.279131][ T7696]  ima_calc_file_hash+0x1ba/0x490
>> [  977.279415][ T7696]  ima_collect_measurement+0x848/0x9d0
>> [  977.279721][ T7696] page last free pid 7695 tgid 7695 stack trace:
>> [  977.280101][ T7696]  free_unref_page+0x619/0x10e0
>> [  977.280363][ T7696]  __folio_put+0x31d/0x440
>> [  977.280603][ T7696]  put_page+0x21d/0x280
>> [  977.280875][ T7696]  anon_pipe_buf_release+0x11a/0x240
>> [  977.281171][ T7696]  pipe_read+0x635/0x13b0
>> [  977.281447][ T7696]  vfs_read+0xa0c/0xba0
>> [  977.281761][ T7696]  ksys_read+0x1fe/0x240
>> [  977.282045][ T7696]  do_syscall_64+0x74/0x1c0
>> [  977.282314][ T7696]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  977.282679][ T7696] ------------[ cut here ]------------
>> [  977.283000][ T7696] kernel BUG at mm/filemap.c:1535!
>> [  977.283313][ T7696] Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>> [  977.283939][ T7696] CPU: 4 UID: 0 PID: 7696 Comm: cat Not tainted 6.13.0-
>> rc2-00367-gbfe147475f84 #24
>> [  977.284605][ T7696] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>> 1.16.2-debian-1.16.2-1 04/01/2014
>> [  977.285195][ T7696] RIP: 0010:folio_end_read+0x17b/0x1a0
>> [  977.285517][ T7696] Code: e8 1a 62 ca ff 48 c7 c6 60 17 d8 8a 48 89 ef e8 2b
>> d2 0e 00 0f 0b e8 04 62 ca ff 48 c8
>> [  977.287017][ T7696] RSP: 0018:ffffc90007aa7710 EFLAGS: 00010293
>> [  977.287424][ T7696] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
>> ffffc90007aa75b8
>> [  977.287897][ T7696] RDX: ffff888026320000 RSI: ffffffff81cd65bb RDI:
>> ffff888026320444
>> [  977.288356][ T7696] RBP: ffffea0000808b00 R08: 0000000000000000 R09:
>> fffffbfff1efaf3a
>> [  977.288781][ T7696] R10: ffffffff8f7d79d7 R11: 0000000000000001 R12:
>> 0000000000000001
>> [  977.289166][ T7696] R13: 0000000000000001 R14: 0000000000000001 R15:
>> ffffea0000ac3440
>> [  977.289550][ T7696] FS:  00007f7d03bb7700(0000) GS:ffff88802da00000(0000)
>> knlGS:0000000000000000
>> [  977.289982][ T7696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  977.290304][ T7696] CR2: 00007f833c9a6c68 CR3: 0000000011584000 CR4:
>> 00000000003506f0
>> [  977.290688][ T7696] Call Trace:
>> [  977.290852][ T7696]  <TASK>
>> [  977.290999][ T7696]  ? die+0x31/0x80
>> [  977.291190][ T7696]  ? do_trap+0x232/0x430
>> [  977.291400][ T7696]  ? folio_end_read+0x17b/0x1a0
>> [  977.291644][ T7696]  ? folio_end_read+0x17b/0x1a0
>> [  977.291912][ T7696]  ? do_error_trap+0xf4/0x230
>> [  977.292172][ T7696]  ? folio_end_read+0x17b/0x1a0
>> [  977.292415][ T7696]  ? handle_invalid_op+0x34/0x40
>> [  977.292660][ T7696]  ? folio_end_read+0x17b/0x1a0
>> [  977.292904][ T7696]  ? exc_invalid_op+0x2d/0x40
>> [  977.293140][ T7696]  ? asm_exc_invalid_op+0x1a/0x20
>> [  977.293392][ T7696]  ? folio_end_read+0x17b/0x1a0
>> [  977.293635][ T7696]  ? folio_end_read+0x17b/0x1a0
>> [  977.293882][ T7696]  squashfs_copy_cache+0x1d7/0x550
>> [  977.294174][ T7696]  squashfs_read_folio+0xa13/0xc00
>> [  977.294483][ T7696]  ? __pfx_squashfs_read_folio+0x10/0x10
>> [  977.294811][ T7696]  ? __pfx_squashfs_read_folio+0x10/0x10
>> [  977.295154][ T7696]  filemap_read_folio+0xc0/0x2a0
>> [  977.295457][ T7696]  ? __pfx_filemap_read_folio+0x10/0x10
>> [  977.295819][ T7696]  ? page_cache_sync_ra+0x4b4/0x9c0
>> [  977.296171][ T7696]  filemap_get_pages+0x155c/0x1bd0
>> [  977.296473][ T7696]  ? current_time+0x79/0x380
>> [  977.296744][ T7696]  ? __pfx_filemap_get_pages+0x10/0x10
>> [  977.297055][ T7696]  filemap_read+0x3b6/0xd50
>> [  977.297315][ T7696]  ? __pfx_filemap_read+0x10/0x10
>> [  977.297605][ T7696]  ? pipe_write+0xf9f/0x1ae0
>> [  977.297854][ T7696]  ? __pfx_pipe_write+0x10/0x10
>> [  977.298127][ T7696]  ? lock_acquire+0x1b1/0x550
>> [  977.298391][ T7696]  ? __pfx_autoremove_wake_function+0x10/0x10
>> [  977.298714][ T7696]  generic_file_read_iter+0x344/0x450
>> [  977.299008][ T7696]  ? rw_verify_area+0xd0/0x700
>> [  977.299283][ T7696]  vfs_read+0x83e/0xba0
>> [  977.299526][ T7696]  ? __pfx_vfs_read+0x10/0x10
>> [  977.299809][ T7696]  ? __pfx_generic_fadvise+0x10/0x10
>> [  977.300132][ T7696]  ksys_read+0x122/0x240
>> [  977.300361][ T7696]  ? __pfx_ksys_read+0x10/0x10
>> [  977.300630][ T7696]  do_syscall_64+0x74/0x1c0
>> [  977.300859][ T7696]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>> [  977.301152][ T7696] RIP: 0033:0x7f7d034dbba0
>> [  977.301372][ T7696] Code: 0b 31 c0 48 83 c4 08 e9 be fe ff ff 48 8d 3d 3f f0
>> 08 00 e8 e2 ce 01 00 66 90 83 3d 34
>> [  977.302300][ T7696] RSP: 002b:00007fffbb0b34a8 EFLAGS: 00000246 ORIG_RAX:
>> 0000000000000000
>> [  977.302705][ T7696] RAX: ffffffffffffffda RBX: 0000000000008000 RCX:
>> 00007f7d034dbba0
>> [  977.303088][ T7696] RDX: 0000000000008000 RSI: 0000000031e9c000 RDI:
>> 0000000000000003
>> [  977.303473][ T7696] RBP: 0000000000008000 R08: 0000000000000003 R09:
>> 00007f7d0344b99a
>> [  977.303874][ T7696] R10: 0000000000000002 R11: 0000000000000246 R12:
>> 0000000031e9c000
>> [  977.304283][ T7696] R13: 0000000000000003 R14: 0000000000000000 R15:
>> 0000000000008000
>> [  977.304675][ T7696]  </TASK>
>> [  977.304827][ T7696] Modules linked in:
>> [  977.305052][ T7696] ---[ end trace 0000000000000000 ]---
>> [  977.305346][ T7696] RIP: 0010:folio_end_read+0x17b/0x1a0
>> [  977.305640][ T7696] Code: e8 1a 62 ca ff 48 c7 c6 60 17 d8 8a 48 89 ef e8 2b
>> d2 0e 00 0f 0b e8 04 62 ca ff 48 c8
>> [  977.306747][ T7696] RSP: 0018:ffffc90007aa7710 EFLAGS: 00010293
>> [  977.307125][ T7696] RAX: 0000000000000000 RBX: 0000000000000001 RCX:
>> ffffc90007aa75b8
>> [  977.307610][ T7696] RDX: ffff888026320000 RSI: ffffffff81cd65bb RDI:
>> ffff888026320444
>> [  977.308117][ T7696] RBP: ffffea0000808b00 R08: 0000000000000000 R09:
>> fffffbfff1efaf3a
>> [  977.308541][ T7696] R10: ffffffff8f7d79d7 R11: 0000000000000001 R12:
>> 0000000000000001
>> [  977.308964][ T7696] R13: 0000000000000001 R14: 0000000000000001 R15:
>> ffffea0000ac3440
>> [  977.309385][ T7696] FS:  00007f7d03bb7700(0000) GS:ffff88802da00000(0000)
>> knlGS:0000000000000000
>> [  977.309842][ T7696] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [  977.310165][ T7696] CR2: 00007f833c9a6c68 CR3: 0000000011584000 CR4:
>> 00000000003506f0
>> [  977.310551][ T7696] Kernel panic - not syncing: Fatal exception
>> [  977.311300][ T7696] Kernel Offset: disabled
>> [  977.311520][ T7696] Rebooting in 86400 seconds..
>>  
>>
> 



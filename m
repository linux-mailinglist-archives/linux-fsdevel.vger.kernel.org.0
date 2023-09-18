Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96F3B7A46D1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 12:21:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjIRKUg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbjIRKUW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:20:22 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C87A6;
        Mon, 18 Sep 2023 03:20:15 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 909EF60173;
        Mon, 18 Sep 2023 12:20:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695032413; bh=rX0YAONv3gMNho1TfQL2tH3WaTVXGD3xa0UwnM3eZM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=IYCerkXGn9VvuUfLqb+bqsNsTCs4730YL3URbacI+OOjnkIo3572+aKfymfYaiUFK
         zK0GssLYCQCVIUtTYbNx3lp1yHOQC1F7Ovmdhwg8kTVzZNBqndkgO4idMS2zpqUGpf
         zwTNHpO8o61sDSTDT9+ZhvOpBYKIsBscKYU2vCUdy8TujA19NDws82QCToa9l+O/D1
         RlKsq6JBmelqpV6tMm3jyBRDvNg23wd+F7SAeA2x2pPmFT/VzAeOysWDgzbcDlBfIW
         Ke5XHybFrNalj8Dl1yalMl1MhFqiNjE5psclJ2sgbGNxuqzBzR1PmR3wkHS5Y6tw/I
         PfxHVkxxm8dgA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id yb-GMnSu9hpB; Mon, 18 Sep 2023 12:20:10 +0200 (CEST)
Received: from [192.168.1.6] (78-1-184-14.adsl.net.t-com.hr [78.1.184.14])
        by domac.alu.hr (Postfix) with ESMTPSA id 152296015E;
        Mon, 18 Sep 2023 12:20:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695032410; bh=rX0YAONv3gMNho1TfQL2tH3WaTVXGD3xa0UwnM3eZM8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=rHIN9WS6JGlf5P+6CjZTjJN3rHP6j7NQXLLKdVGxPjeD8b5Mz9afk5M2GGjqxK7GL
         3E/FvCcAxs9IW66JWLEj1W6m1UcFE32jnv4aldUSF2mZ870AMQNTaq+KlXdXLI5pVO
         X0Jo+bpImmmqzdWmcg/jB2XaVqY8cfVz5w97IkgIgNft4QOP1Am+YPkwc+qRYB4KQm
         y5giv0ZN23PmUA51DCdRnjr2cgAVmGZa2jyVMrR7CgJCY0/bnOnwT52jkQwNCqQ2/1
         yePj5P38fj7jrerV2pyZEMB4zIyar6lQtUxPeygR62+HWwVnOxuO1DLCXskcfgB4VN
         Rd6wdVxPkyV+A==
Message-ID: <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
Date:   Mon, 18 Sep 2023 12:20:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, Yury Norov <yury.norov@gmail.com>
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <20230918094116.2mgquyxhnxcawxfu@quack3>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/18/23 11:41, Jan Kara wrote:
> On Mon 18-09-23 06:47:40, Mirsad Goran Todorovac wrote:
>> KCSAN has discovered the following data-race:
>>
>> [  206.510010] ==================================================================
>> [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
>>
>> [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
>> [  206.510081] xas_clear_mark (./arch/x86/include/asm/bitops.h:178 ./include/asm-generic/bitops/instrumented-non-atomic.h:115 lib/xarray.c:102 lib/xarray.c:914)
>> [  206.510097] __xa_clear_mark (lib/xarray.c:1923)
>> [  206.510114] __folio_end_writeback (mm/page-writeback.c:2981)
>> [  206.510128] folio_end_writeback (mm/filemap.c:1616)
>> [  206.510143] end_page_writeback (mm/folio-compat.c:28)
>> [  206.510155] btrfs_page_clear_writeback (fs/btrfs/subpage.c:646) btrfs
>> [  206.510994] end_bio_extent_writepage (./include/linux/bio.h:84 fs/btrfs/extent_io.c:542) btrfs
>> [  206.511817] __btrfs_bio_end_io (fs/btrfs/bio.c:117 fs/btrfs/bio.c:112) btrfs
>> [  206.512640] btrfs_orig_bbio_end_io (fs/btrfs/bio.c:164) btrfs
>> [  206.513497] btrfs_simple_end_io (fs/btrfs/bio.c:380) btrfs
>> [  206.514350] bio_endio (block/bio.c:1617)
>> [  206.514362] blk_mq_end_request_batch (block/blk-mq.c:837 block/blk-mq.c:1073)
>> [  206.514377] nvme_pci_complete_batch (drivers/nvme/host/pci.c:986) nvme
>> [  206.514437] nvme_irq (drivers/nvme/host/pci.c:1086) nvme
>> [  206.514500] __handle_irq_event_percpu (kernel/irq/handle.c:158)
>> [  206.514517] handle_irq_event (kernel/irq/handle.c:195 kernel/irq/handle.c:210)
>> [  206.514533] handle_edge_irq (kernel/irq/chip.c:836)
>> [  206.514549] __common_interrupt (./include/linux/irqdesc.h:161 arch/x86/kernel/irq.c:238 arch/x86/kernel/irq.c:257)
>> [  206.514563] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
>> [  206.514583] asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
>> [  206.514599] kcsan_setup_watchpoint (kernel/kcsan/core.c:705 (discriminator 1))
>> [  206.514612] __tsan_read8 (kernel/kcsan/core.c:1025)
>> [  206.514626] steal_from_bitmap.part.0 (./include/linux/find.h:186 fs/btrfs/free-space-cache.c:2557 fs/btrfs/free-space-cache.c:2613) btrfs
>> [  206.515491] __btrfs_add_free_space (fs/btrfs/free-space-cache.c:2689 fs/btrfs/free-space-cache.c:2667) btrfs
>> [  206.516361] btrfs_add_free_space_async_trimmed (fs/btrfs/free-space-cache.c:2798) btrfs
>> [  206.517231] add_new_free_space (fs/btrfs/block-group.c:550) btrfs
>> [  206.518095] load_free_space_tree (fs/btrfs/free-space-tree.c:1595 fs/btrfs/free-space-tree.c:1658) btrfs
>> [  206.518953] caching_thread (fs/btrfs/block-group.c:873) btrfs
>> [  206.519800] btrfs_work_helper (fs/btrfs/async-thread.c:314) btrfs
>> [  206.520643] process_one_work (kernel/workqueue.c:2600)
>> [  206.520658] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
>> [  206.520672] kthread (kernel/kthread.c:389)
>> [  206.520684] ret_from_fork (arch/x86/kernel/process.c:145)
>> [  206.520701] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
>>
>> [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
>> [  206.520735] xas_find_marked (./include/linux/xarray.h:1706 lib/xarray.c:1354)
>> [  206.520750] filemap_get_folios_tag (mm/filemap.c:1975 mm/filemap.c:2273)
>> [  206.520763] __filemap_fdatawait_range (mm/filemap.c:519)
>> [  206.520777] filemap_fdatawait_range (mm/filemap.c:556)
>> [  206.520790] btrfs_wait_ordered_range (fs/btrfs/ordered-data.c:839) btrfs
>> [  206.521641] btrfs_sync_file (fs/btrfs/file.c:1859) btrfs
>> [  206.522495] vfs_fsync_range (fs/sync.c:188)
>> [  206.522509] __x64_sys_fsync (./include/linux/file.h:45 fs/sync.c:213 fs/sync.c:220 fs/sync.c:218 fs/sync.c:218)
>> [  206.522522] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
>> [  206.522535] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
>>
>> [  206.522557] value changed: 0xfffffffffff80000 -> 0xfffffffffff00000
>>
>> [  206.522574] Reported by Kernel Concurrency Sanitizer on:
>> [  206.522585] CPU: 6 PID: 2793 Comm: tracker-extract Tainted: G             L     6.5.0-rc6+ #44
>> [  206.522600] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [  206.522608] ==================================================================
> 
> Thanks for working on this. I guess the full KCSAN warning isn't that
> useful in the changelog. Rather I'd spend more time explaining the real
> problem here ...
> 
>> As Jan Kara explained, the problem is in the function xas_find_chuck():
>>
>> /* Private */
>> static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
>> 		xa_mark_t mark)
>> {
>> 	unsigned long *addr = xas->xa_node->marks[(__force unsigned)mark];
>> 	unsigned int offset = xas->xa_offset;
>>
>> 	if (advance)
>> 		offset++;
>> 	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
>> 		if (offset < XA_CHUNK_SIZE) {
>> →			unsigned long data = *addr & (~0UL << offset);
>> 			if (data)
>> 				return __ffs(data);
> 
> ... which is that xas_find_chunk() is called only under RCU protection and
> thus the two uses of 'data' in the above code can yield different results.
> 
>> 		}
>> 		return XA_CHUNK_SIZE;
>> 	}
>>
>> 	return find_next_bit(addr, XA_CHUNK_SIZE, offset);
>> }
>>
>> In particular, the line
>>
>> 			unsigned long data = *addr & (~0UL << offset);
>>
>> contains a data race that is best avoided using READ_ONCE(), which eliminated the KCSAN
>> data-race warning completely.
> 
> Yes, this improves the situation for xarray use on 64-bit architectures but
> doesn't fix cases on 32-bit archs or if CONFIG_BASE_SMALL is set. As I
> mentioned in my previous reply, I'd rather:
> 
> 1) Fix find_next_bit(), find_first_bit() and related functions in
> lib/find_bit.c to use READ_ONCE() - such as _find_first_bit() etc. It is
> quite some churn but I don't see how else to make these functions safe when
> the underlying contents can change.

Thank you for your review.

I assume you have the big picture, but just a stupid question:

	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
		if (offset < XA_CHUNK_SIZE) {
			unsigned long data = READ_ONCE(*addr) & (~0UL << offset);
			if (data)
				return __ffs(data);
		}
		return XA_CHUNK_SIZE;
	}

I would hate to argue, but ...

Wouldn't BITS_PER_LONG simply change to 32 on 32-bit architectures?

Is there something I am missing?

 From include/asm-generic/bitsperlong.h:
----------------------------------------
#ifdef CONFIG_64BIT
#define BITS_PER_LONG 64
#else
#define BITS_PER_LONG 32
#endif /* CONFIG_64BIT */

About the CONFIG_BASE_SMALL I cannot tell:
----------------------------------------
#ifndef XA_CHUNK_SHIFT
#define XA_CHUNK_SHIFT		(CONFIG_BASE_SMALL ? 4 : 6)
#endif
#define XA_CHUNK_SIZE		(1UL << XA_CHUNK_SHIFT)
#define XA_CHUNK_MASK		(XA_CHUNK_SIZE - 1)
#define XA_MAX_MARKS		3
#define XA_MARK_LONGS		DIV_ROUND_UP(XA_CHUNK_SIZE, BITS_PER_LONG)
----------------------------------------

I see why you would want find_next_bit() and find_first_bit() fixed, but I am not that deep
into those bitops, so I guess I cannot make this in one step ... Probably it would require
a lot of homework.

_find_*_bit() functions and/or macros cause quite a number of KCSAN BUG warnings:

  95 _find_first_and_bit (lib/find_bit.c:114 (discriminator 10))
  31 _find_first_zero_bit (lib/find_bit.c:125 (discriminator 10))
173 _find_next_and_bit (lib/find_bit.c:171 (discriminator 2))
655 _find_next_bit (lib/find_bit.c:133 (discriminator 2))
   5 _find_next_zero_bit

... but I am simply not certain what is the right thing to do ATM about those and whether they
are false positives.

AFAICS, READ_ONCE() here solves the case of 64 and 32 architectures which is
an incremental step, and it works ... I am just not ready for an universal solution ATM.

> 2) Change xas_find_chunk() to unconditionally use find_next_bit() as the
> special case XA_CHUNK_SIZE == BITS_PER_LONG seems pointless these days
> because find_next_bit() is inline and does small_const_nbits(size) check.

I see your point. A generalised solution would of course be better. But from the report about
data-races in those functions it seems that they need a major rethink. It isn't that obvious
to me what should be READ_ONCE()-ed in a bit field ...

Those functions are extensively used throughout the kernel and I get the notion it is a job
for someone with more experience ...

Best regards,
Mirsad

> 								Honza
> 
>   
>> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> Suggested-by: Jan Kara <jack@suse.cz>
>> Fixes: b803b42823d0d ("xarray: Add XArray iterators")
>> Matthew Wilcox <willy@infradead.org>
>> Cc: Chris Mason <clm@fb.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Josef Bacik <josef@toxicpanda.com>
>> Cc: David Sterba <dsterba@suse.com>
>> Cc: linux-btrfs@vger.kernel.org
>> Cc: linux-fsdevel@vger.kernel.org
>> Cc: linux-mm@kvack.org
>> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
>> ---
>> v1: the proposed fix (RFC)
>>
>>   include/linux/xarray.h | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
>> index cb571dfcf4b1..1715fd322d62 100644
>> --- a/include/linux/xarray.h
>> +++ b/include/linux/xarray.h
>> @@ -1720,7 +1720,7 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
>>   		offset++;
>>   	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
>>   		if (offset < XA_CHUNK_SIZE) {
>> -			unsigned long data = *addr & (~0UL << offset);
>> +			unsigned long data = READ_ONCE(*addr) & (~0UL << offset);
>>   			if (data)
>>   				return __ffs(data);
>>   		}
>> -- 
>> 2.34.1
>>

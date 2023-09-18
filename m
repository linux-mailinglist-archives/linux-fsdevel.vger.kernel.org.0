Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7797E7A4FDE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 18:54:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbjIRQyv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 12:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbjIRQyn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:54:43 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CE797;
        Mon, 18 Sep 2023 09:54:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C3CBC1FEC7;
        Mon, 18 Sep 2023 13:18:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695043095; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTvuYmmI59O/pv6Q8FC1W4YOqjhNA6NKXAcSkjN/4Rk=;
        b=RhxG9zq9r+sfse9Piw1yYMQoer+CLjn6dLLJTFNVtgOIYbsefW6b/uhVGQnXsMzUkWePLK
        h/lDSdTqpE2PtVQJz3VLygJ3izNbmdPXbMdf4k1isQZB10mJYehPWZNPX6Vv5JF/YHoxp3
        GdXGHSTpnVULrLS+4mZF8FAfuKQgdes=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695043095;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vTvuYmmI59O/pv6Q8FC1W4YOqjhNA6NKXAcSkjN/4Rk=;
        b=Zho0XxMU0ZK8hTHqIO4fbnzCfUa/sgspdtJyiqmaGO3XeIAasGV2Mmfz8I079Yrroc/U1s
        BN7F7p4IWDuEcTAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AA4C91358A;
        Mon, 18 Sep 2023 13:18:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oaKDKRdOCGXfEgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 13:18:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 33B39A0759; Mon, 18 Sep 2023 15:18:15 +0200 (CEST)
Date:   Mon, 18 Sep 2023 15:18:15 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Jan Kara <jack@suse.cz>, Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Message-ID: <20230918131815.otjqgu3zhigsst64@quack3>
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
 <20230918094116.2mgquyxhnxcawxfu@quack3>
 <22ca3ad4-42ef-43bc-51d0-78aaf274977b@alu.unizg.hr>
 <20230918113840.h3mmnuyer44e5bc5@quack3>
 <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fb0f5ba9-7fe3-a951-0587-640e7672efec@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-09-23 14:46:02, Mirsad Todorovac wrote:
> On 9/18/23 13:38, Jan Kara wrote:
> > On Mon 18-09-23 12:20:09, Mirsad Todorovac wrote:
> > > On 9/18/23 11:41, Jan Kara wrote:
> > > > On Mon 18-09-23 06:47:40, Mirsad Goran Todorovac wrote:
> > > > > KCSAN has discovered the following data-race:
> > > > > 
> > > > > [  206.510010] ==================================================================
> > > > > [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
> > > > > 
> > > > > [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
> > > > > [  206.510081] xas_clear_mark (./arch/x86/include/asm/bitops.h:178 ./include/asm-generic/bitops/instrumented-non-atomic.h:115 lib/xarray.c:102 lib/xarray.c:914)
> > > > > [  206.510097] __xa_clear_mark (lib/xarray.c:1923)
> > > > > [  206.510114] __folio_end_writeback (mm/page-writeback.c:2981)
> > > > > [  206.510128] folio_end_writeback (mm/filemap.c:1616)
> > > > > [  206.510143] end_page_writeback (mm/folio-compat.c:28)
> > > > > [  206.510155] btrfs_page_clear_writeback (fs/btrfs/subpage.c:646) btrfs
> > > > > [  206.510994] end_bio_extent_writepage (./include/linux/bio.h:84 fs/btrfs/extent_io.c:542) btrfs
> > > > > [  206.511817] __btrfs_bio_end_io (fs/btrfs/bio.c:117 fs/btrfs/bio.c:112) btrfs
> > > > > [  206.512640] btrfs_orig_bbio_end_io (fs/btrfs/bio.c:164) btrfs
> > > > > [  206.513497] btrfs_simple_end_io (fs/btrfs/bio.c:380) btrfs
> > > > > [  206.514350] bio_endio (block/bio.c:1617)
> > > > > [  206.514362] blk_mq_end_request_batch (block/blk-mq.c:837 block/blk-mq.c:1073)
> > > > > [  206.514377] nvme_pci_complete_batch (drivers/nvme/host/pci.c:986) nvme
> > > > > [  206.514437] nvme_irq (drivers/nvme/host/pci.c:1086) nvme
> > > > > [  206.514500] __handle_irq_event_percpu (kernel/irq/handle.c:158)
> > > > > [  206.514517] handle_irq_event (kernel/irq/handle.c:195 kernel/irq/handle.c:210)
> > > > > [  206.514533] handle_edge_irq (kernel/irq/chip.c:836)
> > > > > [  206.514549] __common_interrupt (./include/linux/irqdesc.h:161 arch/x86/kernel/irq.c:238 arch/x86/kernel/irq.c:257)
> > > > > [  206.514563] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
> > > > > [  206.514583] asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
> > > > > [  206.514599] kcsan_setup_watchpoint (kernel/kcsan/core.c:705 (discriminator 1))
> > > > > [  206.514612] __tsan_read8 (kernel/kcsan/core.c:1025)
> > > > > [  206.514626] steal_from_bitmap.part.0 (./include/linux/find.h:186 fs/btrfs/free-space-cache.c:2557 fs/btrfs/free-space-cache.c:2613) btrfs
> > > > > [  206.515491] __btrfs_add_free_space (fs/btrfs/free-space-cache.c:2689 fs/btrfs/free-space-cache.c:2667) btrfs
> > > > > [  206.516361] btrfs_add_free_space_async_trimmed (fs/btrfs/free-space-cache.c:2798) btrfs
> > > > > [  206.517231] add_new_free_space (fs/btrfs/block-group.c:550) btrfs
> > > > > [  206.518095] load_free_space_tree (fs/btrfs/free-space-tree.c:1595 fs/btrfs/free-space-tree.c:1658) btrfs
> > > > > [  206.518953] caching_thread (fs/btrfs/block-group.c:873) btrfs
> > > > > [  206.519800] btrfs_work_helper (fs/btrfs/async-thread.c:314) btrfs
> > > > > [  206.520643] process_one_work (kernel/workqueue.c:2600)
> > > > > [  206.520658] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
> > > > > [  206.520672] kthread (kernel/kthread.c:389)
> > > > > [  206.520684] ret_from_fork (arch/x86/kernel/process.c:145)
> > > > > [  206.520701] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
> > > > > 
> > > > > [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
> > > > > [  206.520735] xas_find_marked (./include/linux/xarray.h:1706 lib/xarray.c:1354)
> > > > > [  206.520750] filemap_get_folios_tag (mm/filemap.c:1975 mm/filemap.c:2273)
> > > > > [  206.520763] __filemap_fdatawait_range (mm/filemap.c:519)
> > > > > [  206.520777] filemap_fdatawait_range (mm/filemap.c:556)
> > > > > [  206.520790] btrfs_wait_ordered_range (fs/btrfs/ordered-data.c:839) btrfs
> > > > > [  206.521641] btrfs_sync_file (fs/btrfs/file.c:1859) btrfs
> > > > > [  206.522495] vfs_fsync_range (fs/sync.c:188)
> > > > > [  206.522509] __x64_sys_fsync (./include/linux/file.h:45 fs/sync.c:213 fs/sync.c:220 fs/sync.c:218 fs/sync.c:218)
> > > > > [  206.522522] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> > > > > [  206.522535] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> > > > > 
> > > > > [  206.522557] value changed: 0xfffffffffff80000 -> 0xfffffffffff00000
> > > > > 
> > > > > [  206.522574] Reported by Kernel Concurrency Sanitizer on:
> > > > > [  206.522585] CPU: 6 PID: 2793 Comm: tracker-extract Tainted: G             L     6.5.0-rc6+ #44
> > > > > [  206.522600] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> > > > > [  206.522608] ==================================================================
> > > > 
> > > > Thanks for working on this. I guess the full KCSAN warning isn't that
> > > > useful in the changelog. Rather I'd spend more time explaining the real
> > > > problem here ...
> > > > 
> > > > > As Jan Kara explained, the problem is in the function xas_find_chuck():
> > > > > 
> > > > > /* Private */
> > > > > static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
> > > > > 		xa_mark_t mark)
> > > > > {
> > > > > 	unsigned long *addr = xas->xa_node->marks[(__force unsigned)mark];
> > > > > 	unsigned int offset = xas->xa_offset;
> > > > > 
> > > > > 	if (advance)
> > > > > 		offset++;
> > > > > 	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
> > > > > 		if (offset < XA_CHUNK_SIZE) {
> > > > > →			unsigned long data = *addr & (~0UL << offset);
> > > > > 			if (data)
> > > > > 				return __ffs(data);
> > > > 
> > > > ... which is that xas_find_chunk() is called only under RCU protection and
> > > > thus the two uses of 'data' in the above code can yield different results.
> > > > 
> > > > > 		}
> > > > > 		return XA_CHUNK_SIZE;
> > > > > 	}
> > > > > 
> > > > > 	return find_next_bit(addr, XA_CHUNK_SIZE, offset);
> > > > > }
> > > > > 
> > > > > In particular, the line
> > > > > 
> > > > > 			unsigned long data = *addr & (~0UL << offset);
> > > > > 
> > > > > contains a data race that is best avoided using READ_ONCE(), which eliminated the KCSAN
> > > > > data-race warning completely.
> > > > 
> > > > Yes, this improves the situation for xarray use on 64-bit architectures but
> > > > doesn't fix cases on 32-bit archs or if CONFIG_BASE_SMALL is set. As I
> > > > mentioned in my previous reply, I'd rather:
> > > > 
> > > > 1) Fix find_next_bit(), find_first_bit() and related functions in
> > > > lib/find_bit.c to use READ_ONCE() - such as _find_first_bit() etc. It is
> > > > quite some churn but I don't see how else to make these functions safe when
> > > > the underlying contents can change.
> > > 
> > > Thank you for your review.
> > > 
> > > I assume you have the big picture, but just a stupid question:
> > > 
> > > 	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
> > > 		if (offset < XA_CHUNK_SIZE) {
> > > 			unsigned long data = READ_ONCE(*addr) & (~0UL << offset);
> > > 			if (data)
> > > 				return __ffs(data);
> > > 		}
> > > 		return XA_CHUNK_SIZE;
> > > 	}
> > > 
> > > I would hate to argue, but ...
> > 
> > No problem, asking questions isn't argueing ;).
> > 
> > > Wouldn't BITS_PER_LONG simply change to 32 on 32-bit architectures?
> > 
> > Yes, they will. But XA_CHUNK_SIZE will still be 64 on 32-bit AFAICT so
> > XA_CHUNK_SIZE != BITS_PER_LONG there.
> 
> Ah, I see. This is definitely not good. But I managed to fix and test the find_next_bit()
> family, but this seems that simply
> 
> -------------------------------------------
>  include/linux/xarray.h | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index 1715fd322d62..89918b65b00d 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1718,14 +1718,6 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
>         if (advance)
>                 offset++;
> -       if (XA_CHUNK_SIZE == BITS_PER_LONG) {
> -               if (offset < XA_CHUNK_SIZE) {
> -                       unsigned long data = READ_ONCE(*addr) & (~0UL << offset);
> -                       if (data)
> -                               return __ffs(data);
> -               }
> -               return XA_CHUNK_SIZE;
> -       }
>         return find_next_bit(addr, XA_CHUNK_SIZE, offset);
>  }
> 
> seems too good to be true.
> 
> According to what you explained, the performance impact would be negligent or non-existing,
> and the CONFIG_BASE_SMALL problem would disappear?

If you fix find_next_bit(), then this will fix xas_find_chunk(), yes.

> I did not even try to run that, as I am not 100% confident in the logic.
> 
> Am I doing something very wrong?

No, this is exactly what I think needs to happen.

> > > Is there something I am missing?
> > > 
> > >  From include/asm-generic/bitsperlong.h:
> > > ----------------------------------------
> > > #ifdef CONFIG_64BIT
> > > #define BITS_PER_LONG 64
> > > #else
> > > #define BITS_PER_LONG 32
> > > #endif /* CONFIG_64BIT */
> > > 
> > > About the CONFIG_BASE_SMALL I cannot tell:
> > > ----------------------------------------
> > > #ifndef XA_CHUNK_SHIFT
> > > #define XA_CHUNK_SHIFT		(CONFIG_BASE_SMALL ? 4 : 6)
> > > #endif
> > > #define XA_CHUNK_SIZE		(1UL << XA_CHUNK_SHIFT)
> > > #define XA_CHUNK_MASK		(XA_CHUNK_SIZE - 1)
> > > #define XA_MAX_MARKS		3
> > > #define XA_MARK_LONGS		DIV_ROUND_UP(XA_CHUNK_SIZE, BITS_PER_LONG)
> > > ----------------------------------------
> > 
> > Again with CONFIG_BASE_SMALL we have XA_CHUNK_SIZE == 16 so it will not be
> > equal to BITS_PER_LONG.
> > > I see why you would want find_next_bit() and find_first_bit() fixed, but
> > > I am not that deep into those bitops, so I guess I cannot make this in
> > > one step ... Probably it would require a lot of homework.
> > > 
> > > _find_*_bit() functions and/or macros cause quite a number of KCSAN BUG warnings:
> > > 
> > >   95 _find_first_and_bit (lib/find_bit.c:114 (discriminator 10))
> > >   31 _find_first_zero_bit (lib/find_bit.c:125 (discriminator 10))
> > > 173 _find_next_and_bit (lib/find_bit.c:171 (discriminator 2))
> > > 655 _find_next_bit (lib/find_bit.c:133 (discriminator 2))
> > >    5 _find_next_zero_bit
> > > 
> > > ... but I am simply not certain what is the right thing to do ATM about
> > > those and whether they are false positives.
> > 
> > Well, it would require some auditing to be sure but there is at least one
> > user of these functions (xarray) where the problem is real so given the fix
> > has no real runtime cost the fix looks justified.
> > 
> > > AFAICS, READ_ONCE() here solves the case of 64 and 32 architectures which is
> > > an incremental step, and it works ... I am just not ready for an
> > > universal solution ATM.
> > > 
> > > > 2) Change xas_find_chunk() to unconditionally use find_next_bit() as the
> > > > special case XA_CHUNK_SIZE == BITS_PER_LONG seems pointless these days
> > > > because find_next_bit() is inline and does small_const_nbits(size) check.
> > > 
> > > I see your point. A generalised solution would of course be better. But
> > > from the report about data-races in those functions it seems that they
> > > need a major rethink. It isn't that obvious to me what should be
> > > READ_ONCE()-ed in a bit field ...
> > 
> > Well, it's actually not that difficult. They all need a treatment like:
> > 
> > unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, uns
> > {
> > -       return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
> > +       return FIND_NEXT_BIT(READ_ONCE(addr[idx]), /* nop */, nbits, start);
> > }
> > 
> > 
> > > Those functions are extensively used throughout the kernel and I get the
> > > notion it is a job for someone with more experience ...
> > 
> > Sure, if you don't feel like doing the general change, I can look into it
> > myself.
> > 
> > 								Honza
> 
> Hi,
> 
> I tried this patch and the
> 
> > >   95 _find_first_and_bit (lib/find_bit.c:114 (discriminator 10))
> > >   31 _find_first_zero_bit (lib/find_bit.c:125 (discriminator 10))
> > > 173 _find_next_and_bit (lib/find_bit.c:171 (discriminator 2))
> > > 655 _find_next_bit (lib/find_bit.c:133 (discriminator 2))
> > >    5 _find_next_zero_bit
> 
> data-races do not seem to appear any longer.

Yup. You've just missed one case in _find_last_bit() and then all the
functions in include/linux/find.h need a similar treatment...

								Honza

> 
> --------------------------------------------------------
>  lib/find_bit.c | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)
> 
> diff --git a/lib/find_bit.c b/lib/find_bit.c
> index 32f99e9a670e..56244e4f744e 100644
> --- a/lib/find_bit.c
> +++ b/lib/find_bit.c
> @@ -18,6 +18,7 @@
>  #include <linux/math.h>
>  #include <linux/minmax.h>
>  #include <linux/swab.h>
> +#include <asm/rwonce.h>
>  /*
>   * Common helper for find_bit() function family
> @@ -98,7 +99,7 @@ out:                                                                          \
>   */
>  unsigned long _find_first_bit(const unsigned long *addr, unsigned long size)
>  {
> -       return FIND_FIRST_BIT(addr[idx], /* nop */, size);
> +       return FIND_FIRST_BIT(READ_ONCE(addr[idx]), /* nop */, size);
>  }
>  EXPORT_SYMBOL(_find_first_bit);
>  #endif
> @@ -111,7 +112,7 @@ unsigned long _find_first_and_bit(const unsigned long *addr1,
>                                   const unsigned long *addr2,
>                                   unsigned long size)
>  {
> -       return FIND_FIRST_BIT(addr1[idx] & addr2[idx], /* nop */, size);
> +       return FIND_FIRST_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]), /* nop */, size);
>  }
>  EXPORT_SYMBOL(_find_first_and_bit);
>  #endif
> @@ -122,7 +123,7 @@ EXPORT_SYMBOL(_find_first_and_bit);
>   */
>  unsigned long _find_first_zero_bit(const unsigned long *addr, unsigned long size)
>  {
> -       return FIND_FIRST_BIT(~addr[idx], /* nop */, size);
> +       return FIND_FIRST_BIT(~READ_ONCE(addr[idx]), /* nop */, size);
>  }
>  EXPORT_SYMBOL(_find_first_zero_bit);
>  #endif
> @@ -130,28 +131,28 @@ EXPORT_SYMBOL(_find_first_zero_bit);
>  #ifndef find_next_bit
>  unsigned long _find_next_bit(const unsigned long *addr, unsigned long nbits, unsigned long start)
>  {
> -       return FIND_NEXT_BIT(addr[idx], /* nop */, nbits, start);
> +       return FIND_NEXT_BIT(READ_ONCE(addr[idx]), /* nop */, nbits, start);
>  }
>  EXPORT_SYMBOL(_find_next_bit);
>  #endif
>  unsigned long __find_nth_bit(const unsigned long *addr, unsigned long size, unsigned long n)
>  {
> -       return FIND_NTH_BIT(addr[idx], size, n);
> +       return FIND_NTH_BIT(READ_ONCE(addr[idx]), size, n);
>  }
>  EXPORT_SYMBOL(__find_nth_bit);
>  unsigned long __find_nth_and_bit(const unsigned long *addr1, const unsigned long *addr2,
>                                  unsigned long size, unsigned long n)
>  {
> -       return FIND_NTH_BIT(addr1[idx] & addr2[idx], size, n);
> +       return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]), size, n);
>  }
>  EXPORT_SYMBOL(__find_nth_and_bit);
>  unsigned long __find_nth_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>                                  unsigned long size, unsigned long n)
>  {
> -       return FIND_NTH_BIT(addr1[idx] & ~addr2[idx], size, n);
> +       return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & ~READ_ONCE(addr2[idx]), size, n);
>  }
>  EXPORT_SYMBOL(__find_nth_andnot_bit);
> @@ -160,7 +161,7 @@ unsigned long __find_nth_and_andnot_bit(const unsigned long *addr1,
>                                         const unsigned long *addr3,
>                                         unsigned long size, unsigned long n)
>  {
> -       return FIND_NTH_BIT(addr1[idx] & addr2[idx] & ~addr3[idx], size, n);
> +       return FIND_NTH_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]) & ~READ_ONCE(addr3[idx]), size, n);
>  }
>  EXPORT_SYMBOL(__find_nth_and_andnot_bit);
> @@ -168,7 +169,7 @@ EXPORT_SYMBOL(__find_nth_and_andnot_bit);
>  unsigned long _find_next_and_bit(const unsigned long *addr1, const unsigned long *addr2,
>                                         unsigned long nbits, unsigned long start)
>  {
> -       return FIND_NEXT_BIT(addr1[idx] & addr2[idx], /* nop */, nbits, start);
> +       return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) & READ_ONCE(addr2[idx]), /* nop */, nbits, start);
>  }
>  EXPORT_SYMBOL(_find_next_and_bit);
>  #endif
> @@ -177,7 +178,7 @@ EXPORT_SYMBOL(_find_next_and_bit);
>  unsigned long _find_next_andnot_bit(const unsigned long *addr1, const unsigned long *addr2,
>                                         unsigned long nbits, unsigned long start)
>  {
> -       return FIND_NEXT_BIT(addr1[idx] & ~addr2[idx], /* nop */, nbits, start);
> +       return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) & ~READ_ONCE(addr2[idx]), /* nop */, nbits, start);
>  }
>  EXPORT_SYMBOL(_find_next_andnot_bit);
>  #endif
> @@ -186,7 +187,7 @@ EXPORT_SYMBOL(_find_next_andnot_bit);
>  unsigned long _find_next_or_bit(const unsigned long *addr1, const unsigned long *addr2,
>                                         unsigned long nbits, unsigned long start)
>  {
> -       return FIND_NEXT_BIT(addr1[idx] | addr2[idx], /* nop */, nbits, start);
> +       return FIND_NEXT_BIT(READ_ONCE(addr1[idx]) | READ_ONCE(addr2[idx]), /* nop */, nbits, start);
>  }
>  EXPORT_SYMBOL(_find_next_or_bit);
>  #endif
> @@ -195,7 +196,7 @@ EXPORT_SYMBOL(_find_next_or_bit);
>  unsigned long _find_next_zero_bit(const unsigned long *addr, unsigned long nbits,
>                                          unsigned long start)
>  {
> -       return FIND_NEXT_BIT(~addr[idx], /* nop */, nbits, start);
> +       return FIND_NEXT_BIT(~READ_ONCE(addr[idx]), /* nop */, nbits, start);
>  }
>  EXPORT_SYMBOL(_find_next_zero_bit);
>  #endif
> @@ -208,7 +209,7 @@ unsigned long _find_last_bit(const unsigned long *addr, unsigned long size)
>                 unsigned long idx = (size-1) / BITS_PER_LONG;
>                 do {
> -                       val &= addr[idx];
> +                       val &= READ_ONCE(addr[idx]);
>                         if (val)
>                                 return idx * BITS_PER_LONG + __fls(val);
> @@ -242,7 +243,7 @@ EXPORT_SYMBOL(find_next_clump8);
>   */
>  unsigned long _find_first_zero_bit_le(const unsigned long *addr, unsigned long size)
>  {
> -       return FIND_FIRST_BIT(~addr[idx], swab, size);
> +       return FIND_FIRST_BIT(~READ_ONCE(addr[idx]), swab, size);
>  }
>  EXPORT_SYMBOL(_find_first_zero_bit_le);
> @@ -252,7 +253,7 @@ EXPORT_SYMBOL(_find_first_zero_bit_le);
>  unsigned long _find_next_zero_bit_le(const unsigned long *addr,
>                                         unsigned long size, unsigned long offset)
>  {
> -       return FIND_NEXT_BIT(~addr[idx], swab, size, offset);
> +       return FIND_NEXT_BIT(~READ_ONCE(addr[idx]), swab, size, offset);
>  }
>  EXPORT_SYMBOL(_find_next_zero_bit_le);
>  #endif
> @@ -261,7 +262,7 @@ EXPORT_SYMBOL(_find_next_zero_bit_le);
>  unsigned long _find_next_bit_le(const unsigned long *addr,
>                                 unsigned long size, unsigned long offset)
>  {
> -       return FIND_NEXT_BIT(addr[idx], swab, size, offset);
> +       return FIND_NEXT_BIT(READ_ONCE(addr[idx]), swab, size, offset);
>  }
>  EXPORT_SYMBOL(_find_next_bit_le);
> --
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

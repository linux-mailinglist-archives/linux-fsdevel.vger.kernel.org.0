Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20CD47A463A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 11:43:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240485AbjIRJnK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 05:43:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241124AbjIRJm4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 05:42:56 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C9A8CC7;
        Mon, 18 Sep 2023 02:41:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id AA89E1F37F;
        Mon, 18 Sep 2023 09:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1695030076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQP1wPJDUgx7ZLJLXNhEB9grdPp9c1uarNW8JL9bAWU=;
        b=vlkbnDMDju+XgrwdDYfedeuYfzjEk817K2JhOTs4N7fhhzPU59q+5+mBT5Z9PejJ0zSpOA
        uhL9g0wSPB2ETzIMhNpIJ13h03U1jd4hMlSFbDsHtooSPi5Hfgd1CAyMuoreAAJV5pWJdG
        gWpHqDNtb8u1jId+LACHTEt756NP3oY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1695030076;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dQP1wPJDUgx7ZLJLXNhEB9grdPp9c1uarNW8JL9bAWU=;
        b=cgeXizwHufg+26MLNkJsbe3TLqNfoh1bAOp/RgAN9jvLGTQfP54G8gPG/tQQAwAe5DTud7
        EXTHTGujAtLNx7AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9B45513480;
        Mon, 18 Sep 2023 09:41:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZCnlJTwbCGUFHwAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 18 Sep 2023 09:41:16 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 2EA86A0759; Mon, 18 Sep 2023 11:41:16 +0200 (CEST)
Date:   Mon, 18 Sep 2023 11:41:16 +0200
From:   Jan Kara <jack@suse.cz>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Philipp Stanner <pstanner@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Chris Mason <clm@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
        linux-mm@kvack.org, Yury Norov <yury.norov@gmail.com>
Subject: Re: [PATCH v1 1/1] xarray: fix the data-race in xas_find_chunk() by
 using READ_ONCE()
Message-ID: <20230918094116.2mgquyxhnxcawxfu@quack3>
References: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230918044739.29782-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon 18-09-23 06:47:40, Mirsad Goran Todorovac wrote:
> KCSAN has discovered the following data-race:
> 
> [  206.510010] ==================================================================
> [  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
> 
> [  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
> [  206.510081] xas_clear_mark (./arch/x86/include/asm/bitops.h:178 ./include/asm-generic/bitops/instrumented-non-atomic.h:115 lib/xarray.c:102 lib/xarray.c:914)
> [  206.510097] __xa_clear_mark (lib/xarray.c:1923)
> [  206.510114] __folio_end_writeback (mm/page-writeback.c:2981)
> [  206.510128] folio_end_writeback (mm/filemap.c:1616)
> [  206.510143] end_page_writeback (mm/folio-compat.c:28)
> [  206.510155] btrfs_page_clear_writeback (fs/btrfs/subpage.c:646) btrfs
> [  206.510994] end_bio_extent_writepage (./include/linux/bio.h:84 fs/btrfs/extent_io.c:542) btrfs
> [  206.511817] __btrfs_bio_end_io (fs/btrfs/bio.c:117 fs/btrfs/bio.c:112) btrfs
> [  206.512640] btrfs_orig_bbio_end_io (fs/btrfs/bio.c:164) btrfs
> [  206.513497] btrfs_simple_end_io (fs/btrfs/bio.c:380) btrfs
> [  206.514350] bio_endio (block/bio.c:1617)
> [  206.514362] blk_mq_end_request_batch (block/blk-mq.c:837 block/blk-mq.c:1073)
> [  206.514377] nvme_pci_complete_batch (drivers/nvme/host/pci.c:986) nvme
> [  206.514437] nvme_irq (drivers/nvme/host/pci.c:1086) nvme
> [  206.514500] __handle_irq_event_percpu (kernel/irq/handle.c:158)
> [  206.514517] handle_irq_event (kernel/irq/handle.c:195 kernel/irq/handle.c:210)
> [  206.514533] handle_edge_irq (kernel/irq/chip.c:836)
> [  206.514549] __common_interrupt (./include/linux/irqdesc.h:161 arch/x86/kernel/irq.c:238 arch/x86/kernel/irq.c:257)
> [  206.514563] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
> [  206.514583] asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
> [  206.514599] kcsan_setup_watchpoint (kernel/kcsan/core.c:705 (discriminator 1))
> [  206.514612] __tsan_read8 (kernel/kcsan/core.c:1025)
> [  206.514626] steal_from_bitmap.part.0 (./include/linux/find.h:186 fs/btrfs/free-space-cache.c:2557 fs/btrfs/free-space-cache.c:2613) btrfs
> [  206.515491] __btrfs_add_free_space (fs/btrfs/free-space-cache.c:2689 fs/btrfs/free-space-cache.c:2667) btrfs
> [  206.516361] btrfs_add_free_space_async_trimmed (fs/btrfs/free-space-cache.c:2798) btrfs
> [  206.517231] add_new_free_space (fs/btrfs/block-group.c:550) btrfs
> [  206.518095] load_free_space_tree (fs/btrfs/free-space-tree.c:1595 fs/btrfs/free-space-tree.c:1658) btrfs
> [  206.518953] caching_thread (fs/btrfs/block-group.c:873) btrfs
> [  206.519800] btrfs_work_helper (fs/btrfs/async-thread.c:314) btrfs
> [  206.520643] process_one_work (kernel/workqueue.c:2600)
> [  206.520658] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
> [  206.520672] kthread (kernel/kthread.c:389)
> [  206.520684] ret_from_fork (arch/x86/kernel/process.c:145)
> [  206.520701] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)
> 
> [  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
> [  206.520735] xas_find_marked (./include/linux/xarray.h:1706 lib/xarray.c:1354)
> [  206.520750] filemap_get_folios_tag (mm/filemap.c:1975 mm/filemap.c:2273)
> [  206.520763] __filemap_fdatawait_range (mm/filemap.c:519)
> [  206.520777] filemap_fdatawait_range (mm/filemap.c:556)
> [  206.520790] btrfs_wait_ordered_range (fs/btrfs/ordered-data.c:839) btrfs
> [  206.521641] btrfs_sync_file (fs/btrfs/file.c:1859) btrfs
> [  206.522495] vfs_fsync_range (fs/sync.c:188)
> [  206.522509] __x64_sys_fsync (./include/linux/file.h:45 fs/sync.c:213 fs/sync.c:220 fs/sync.c:218 fs/sync.c:218)
> [  206.522522] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
> [  206.522535] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
> 
> [  206.522557] value changed: 0xfffffffffff80000 -> 0xfffffffffff00000
> 
> [  206.522574] Reported by Kernel Concurrency Sanitizer on:
> [  206.522585] CPU: 6 PID: 2793 Comm: tracker-extract Tainted: G             L     6.5.0-rc6+ #44
> [  206.522600] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [  206.522608] ==================================================================

Thanks for working on this. I guess the full KCSAN warning isn't that
useful in the changelog. Rather I'd spend more time explaining the real
problem here ...

> As Jan Kara explained, the problem is in the function xas_find_chuck():
> 
> /* Private */
> static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
> 		xa_mark_t mark)
> {
> 	unsigned long *addr = xas->xa_node->marks[(__force unsigned)mark];
> 	unsigned int offset = xas->xa_offset;
> 
> 	if (advance)
> 		offset++;
> 	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
> 		if (offset < XA_CHUNK_SIZE) {
> →			unsigned long data = *addr & (~0UL << offset);
> 			if (data)
> 				return __ffs(data);

... which is that xas_find_chunk() is called only under RCU protection and
thus the two uses of 'data' in the above code can yield different results.

> 		}
> 		return XA_CHUNK_SIZE;
> 	}
> 
> 	return find_next_bit(addr, XA_CHUNK_SIZE, offset);
> }
> 
> In particular, the line
> 
> 			unsigned long data = *addr & (~0UL << offset);
> 
> contains a data race that is best avoided using READ_ONCE(), which eliminated the KCSAN
> data-race warning completely.

Yes, this improves the situation for xarray use on 64-bit architectures but
doesn't fix cases on 32-bit archs or if CONFIG_BASE_SMALL is set. As I
mentioned in my previous reply, I'd rather:

1) Fix find_next_bit(), find_first_bit() and related functions in
lib/find_bit.c to use READ_ONCE() - such as _find_first_bit() etc. It is
quite some churn but I don't see how else to make these functions safe when
the underlying contents can change.

2) Change xas_find_chunk() to unconditionally use find_next_bit() as the
special case XA_CHUNK_SIZE == BITS_PER_LONG seems pointless these days
because find_next_bit() is inline and does small_const_nbits(size) check.

								Honza

 
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Suggested-by: Jan Kara <jack@suse.cz>
> Fixes: b803b42823d0d ("xarray: Add XArray iterators")
> Matthew Wilcox <willy@infradead.org>
> Cc: Chris Mason <clm@fb.com>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Josef Bacik <josef@toxicpanda.com>
> Cc: David Sterba <dsterba@suse.com>
> Cc: linux-btrfs@vger.kernel.org
> Cc: linux-fsdevel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> v1: the proposed fix (RFC)
> 
>  include/linux/xarray.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/xarray.h b/include/linux/xarray.h
> index cb571dfcf4b1..1715fd322d62 100644
> --- a/include/linux/xarray.h
> +++ b/include/linux/xarray.h
> @@ -1720,7 +1720,7 @@ static inline unsigned int xas_find_chunk(struct xa_state *xas, bool advance,
>  		offset++;
>  	if (XA_CHUNK_SIZE == BITS_PER_LONG) {
>  		if (offset < XA_CHUNK_SIZE) {
> -			unsigned long data = *addr & (~0UL << offset);
> +			unsigned long data = READ_ONCE(*addr) & (~0UL << offset);
>  			if (data)
>  				return __ffs(data);
>  		}
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

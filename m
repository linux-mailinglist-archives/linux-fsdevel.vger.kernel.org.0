Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145FF7A62CF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 14:26:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231580AbjISM0D (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 08:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbjISM0C (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 08:26:02 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63165E3;
        Tue, 19 Sep 2023 05:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/KFevr7dW0f/5Ti4kgp6vV2k1mBpPBQoqzT0cbEJW+s=; b=jNvNv4azKNlSavqUAGCY+d34lK
        0wraupFeP5AwBJ9JuMYNU2UJb7SCM3M7TOZKlIZNu8haan0/lmUM+7teJW+pi5BkRz0YcgGYojnui
        abi/pVcGGv2Rj5toQNE/UD5m3dkK1aupLpT6MLycl1cagvY2dY0rOgQNwxHJJiPTrlf6wG6tyi6RD
        OJ4mBJDG/E2FNSu4bqaIE9XmRcLyrwKzZCEJnjR197WWvcJFFy2K/EnvrXVgcOGxFspolMomj5eeu
        3uRkPAnwWdk7sAXOHRLxsu/44d/IvuamtEZw/X8fzrGtmn+9sqCa/09qW7bVqMIO4GjoMY1JWddmJ
        aKE2LbSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qiZnd-00HBfS-L0; Tue, 19 Sep 2023 12:25:53 +0000
Date:   Tue, 19 Sep 2023 13:25:53 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
Message-ID: <ZQmTUWywzpIk5kMW@casper.infradead.org>
References: <4ca1f264-eebb-608e-617e-7aec743ccc90@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ca1f264-eebb-608e-617e-7aec743ccc90@alu.unizg.hr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 08:24:02AM +0200, Mirsad Todorovac wrote:
> Hi,
> 
> The usual setup: vanilla torvalds tree kernel 6.6-rc2, Ubuntu 22.04 LTS.
> 
> KCSAN had found a number of data-races in the btrfs implementation.

This isn't btrfs; it's the same as the race reported on August 18th.
https://lore.kernel.org/linux-mm/06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr/

> It is not clear whether this can lead to the corruption of data on the storage media.
> 
> Please find the complete KCSAN dmesg report attached.
> 
> Best regards,
> Mirsad Todorovac
> 
>  2149.512903] ==================================================================
> [ 2149.512933] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
> 
> [ 2149.512967] write to 0xffff8881ab9d2468 of 8 bytes by interrupt on cpu 27:
> [ 2149.512984] xas_clear_mark (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/bitops.h:178 /home/marvin/linux/kernel/torvalds2/./include/asm-generic/bitops/instrumented-non-atomic.h:115 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:102 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:914)
> [ 2149.513002] __xa_clear_mark (/home/marvin/linux/kernel/torvalds2/lib/xarray.c:1929)
> [ 2149.513019] __folio_end_writeback (/home/marvin/linux/kernel/torvalds2/mm/page-writeback.c:2960)
> [ 2149.513039] folio_end_writeback (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:1613)
> [ 2149.513053] end_page_writeback (/home/marvin/linux/kernel/torvalds2/mm/folio-compat.c:28)
> [ 2149.513073] btrfs_page_clear_writeback (/home/marvin/linux/kernel/torvalds2/fs/btrfs/subpage.c:646) btrfs
> [ 2149.513829] end_bio_extent_writepage (/home/marvin/linux/kernel/torvalds2/./include/linux/bio.h:84 /home/marvin/linux/kernel/torvalds2/fs/btrfs/extent_io.c:468) btrfs
> [ 2149.514481] __btrfs_bio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:117 /home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:112) btrfs
> [ 2149.515130] btrfs_orig_bbio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:164) btrfs
> [ 2149.515777] btrfs_simple_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:380) btrfs
> [ 2149.516425] bio_endio (/home/marvin/linux/kernel/torvalds2/block/bio.c:1603)
> [ 2149.516436] blk_mq_end_request_batch (/home/marvin/linux/kernel/torvalds2/block/blk-mq.c:851 /home/marvin/linux/kernel/torvalds2/block/blk-mq.c:1089)
> [ 2149.516449] nvme_pci_complete_batch (/home/marvin/linux/kernel/torvalds2/drivers/nvme/host/pci.c:986) nvme
> [ 2149.516494] nvme_irq (/home/marvin/linux/kernel/torvalds2/drivers/nvme/host/pci.c:1086) nvme
> [ 2149.516538] __handle_irq_event_percpu (/home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:158)
> [ 2149.516553] handle_irq_event (/home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:195 /home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:210)
> [ 2149.516566] handle_edge_irq (/home/marvin/linux/kernel/torvalds2/kernel/irq/chip.c:833)
> [ 2149.516578] __common_interrupt (/home/marvin/linux/kernel/torvalds2/./include/linux/irqdesc.h:161 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:238 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:257)
> [ 2149.516589] common_interrupt (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:247 (discriminator 14))
> [ 2149.516601] asm_common_interrupt (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/idtentry.h:636)
> [ 2149.516612] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:291)
> [ 2149.516623] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
> [ 2149.516633] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
> [ 2149.516646] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
> [ 2149.516655] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
> [ 2149.516664] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
> [ 2149.516677] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)
> 
> [ 2149.516697] read to 0xffff8881ab9d2468 of 8 bytes by task 4603 on cpu 25:
> [ 2149.516708] xas_find_marked (/home/marvin/linux/kernel/torvalds2/./include/linux/find.h:63 /home/marvin/linux/kernel/torvalds2/./include/linux/xarray.h:1722 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:1354)
> [ 2149.516719] filemap_get_folios_tag (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:1978 /home/marvin/linux/kernel/torvalds2/mm/filemap.c:2266)
> [ 2149.516729] __filemap_fdatawait_range (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:516)
> [ 2149.516739] filemap_fdatawait_range (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:553)
> [ 2149.516749] btrfs_wait_ordered_range (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ordered-data.c:841) btrfs
> [ 2149.517405] btrfs_sync_file (/home/marvin/linux/kernel/torvalds2/fs/btrfs/file.c:1844) btrfs
> [ 2149.518059] vfs_fsync_range (/home/marvin/linux/kernel/torvalds2/fs/sync.c:188)
> [ 2149.518071] __x64_sys_fsync (/home/marvin/linux/kernel/torvalds2/./include/linux/file.h:45 /home/marvin/linux/kernel/torvalds2/fs/sync.c:213 /home/marvin/linux/kernel/torvalds2/fs/sync.c:220 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218)
> [ 2149.518081] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
> [ 2149.518095] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)
> 
> [ 2149.518111] value changed: 0xffffff8000000000 -> 0x0000000000000000
> 
> [ 2149.518126] Reported by Kernel Concurrency Sanitizer on:
> [ 2149.518133] CPU: 25 PID: 4603 Comm: mozStorage #1 Tainted: G             L     6.6.0-rc2-kcsan-00003-g16819584c239-dirty #21
> [ 2149.518146] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
> [ 2149.518153] ==================================================================



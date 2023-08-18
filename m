Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F71E7806D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 18 Aug 2023 10:02:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358420AbjHRICQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 18 Aug 2023 04:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358426AbjHRIB7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:01:59 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4FAC3A88;
        Fri, 18 Aug 2023 01:01:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 367D960174;
        Fri, 18 Aug 2023 10:01:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692345714; bh=DWq7plNSMacckvuYD0EBljYEhY22+nbVDzFU4EVun7s=;
        h=Date:Cc:From:To:Subject:From;
        b=wdTh7dwi4lDeRAbtT33oQfk6XRfo7AOV0XmvkUQfQedOd+NujNL4fq0dJfSA8TDWw
         /CfXzeqTZy8XB9HRk+WROh6KnaWf5GGCLdkB6/Tx2broeYEUXmC6LK4MJ2HWUYmrbK
         Vgw6f8pGGQPHo5uMKJyNqWUe1Zb//EJoElPc7WmQ1nNIuEhbWz5wklx5E5+AfSenMa
         GhVT3v+u4LP+TDWAOoGJo11Ww5guXuQB9oW+ohyAwYkA3vnr8Lr5SVpXmo21MBhnbl
         qCjmU52/3yV297+/aZkV5h+nDxDhqz6La7SXyD9P1BHT9m9ia5YvckbCth31i3l5Gp
         J47PBQyJ6yLOA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wlmvasoMhgJm; Fri, 18 Aug 2023 10:01:50 +0200 (CEST)
Received: from [192.168.1.6] (unknown [94.250.191.183])
        by domac.alu.hr (Postfix) with ESMTPSA id 8D4146015E;
        Fri, 18 Aug 2023 10:01:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1692345710; bh=DWq7plNSMacckvuYD0EBljYEhY22+nbVDzFU4EVun7s=;
        h=Date:Cc:From:To:Subject:From;
        b=u6wmw2rBUyxwKVF6DNSG70LeBO1ws16S8+xnrn2oDuQBa2HBkb5a5gB7N730Hs3mK
         vpp1Yq/F888GS96AuvLptYMT8H8ZXIBe++HaYROky3s0wAy9GyOf38H1zhBbMV/Xax
         qpv33E8j6B/FDs1+EB2HigKdsMNpA7PQTpPLOiPaAjpyelkfwZ5uCCZJtbEQzNm9ty
         E7dzOrhUi2p9xmf1eyBgQVEIZPaDKJRf65wCKj8sJIb/zym/1FJ797gwk21d67nth0
         N3EvwaMf0HxXsGs1rcglIahdOFD8eZXHqjvoTnXRNnn+K4J+Iya00nhYYThdKKlEIb
         pfU+DiAC1l2Dw==
Message-ID: <06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr>
Date:   Fri, 18 Aug 2023 10:01:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Content-Language: en-US
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
To:     linux-kernel@vger.kernel.org
Subject: [BUG] KCSAN: data-race in xas_clear_mark / xas_find_marked
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

This is your friendly bug reporter.

I have found this KCSAN reported bug on a torvalds tree kernel 6.5-rc6, on an Ubuntu 22.04 LTS system and
a Ryzen 9 7950X assembled box.

So, the kernel is reported to be tainted, but I reckon it the taint comes from a previous KCSAN detection,
not from a loaded proprietary module.

Excert from dmesg log:

[  206.510010] ==================================================================
[  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked

[  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
[  206.510081]  xas_clear_mark+0xd5/0x180
[  206.510097]  __xa_clear_mark+0xd1/0x100
[  206.510114]  __folio_end_writeback+0x293/0x5a0
[  206.510128]  folio_end_writeback+0x60/0x170
[  206.510143]  end_page_writeback+0x2a/0xb0
[  206.510155]  btrfs_page_clear_writeback+0xbe/0xe0 [btrfs]
[  206.510994]  end_bio_extent_writepage+0x103/0x310 [btrfs]
[  206.511817]  __btrfs_bio_end_io+0x9b/0xc0 [btrfs]
[  206.512640]  btrfs_orig_bbio_end_io+0x70/0x170 [btrfs]
[  206.513497]  btrfs_simple_end_io+0x122/0x170 [btrfs]
[  206.514350]  bio_endio+0x2c4/0x2f0
[  206.514362]  blk_mq_end_request_batch+0x238/0x9b0
[  206.514377]  nvme_pci_complete_batch+0x38/0x1a0 [nvme]
[  206.514437]  nvme_irq+0xa0/0xb0 [nvme]
[  206.514500]  __handle_irq_event_percpu+0x7c/0x290
[  206.514517]  handle_irq_event+0x7c/0x100
[  206.514533]  handle_edge_irq+0x13d/0x450
[  206.514549]  __common_interrupt+0x4f/0x110
[  206.514563]  common_interrupt+0x9f/0xb0
[  206.514583]  asm_common_interrupt+0x27/0x40
[  206.514599]  kcsan_setup_watchpoint+0x274/0x3f0
[  206.514612]  __tsan_read8+0x11c/0x180
[  206.514626]  steal_from_bitmap.part.0+0x29f/0x410 [btrfs]
[  206.515491]  __btrfs_add_free_space+0x1b4/0x850 [btrfs]
[  206.516361]  btrfs_add_free_space_async_trimmed+0x62/0xa0 [btrfs]
[  206.517231]  add_new_free_space+0x127/0x160 [btrfs]
[  206.518095]  load_free_space_tree+0x552/0x680 [btrfs]
[  206.518953]  caching_thread+0x923/0xba0 [btrfs]
[  206.519800]  btrfs_work_helper+0xfa/0x620 [btrfs]
[  206.520643]  process_one_work+0x525/0x930
[  206.520658]  worker_thread+0x311/0x7e0
[  206.520672]  kthread+0x18b/0x1d0
[  206.520684]  ret_from_fork+0x43/0x70
[  206.520701]  ret_from_fork_asm+0x1b/0x30

[  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
[  206.520735]  xas_find_marked+0xe5/0x600
[  206.520750]  filemap_get_folios_tag+0xf9/0x3d0
[  206.520763]  __filemap_fdatawait_range+0xa1/0x180
[  206.520777]  filemap_fdatawait_range+0x13/0x30
[  206.520790]  btrfs_wait_ordered_range+0x86/0x180 [btrfs]
[  206.521641]  btrfs_sync_file+0x36e/0xa80 [btrfs]
[  206.522495]  vfs_fsync_range+0x70/0x120
[  206.522509]  __x64_sys_fsync+0x44/0x80
[  206.522522]  do_syscall_64+0x58/0x90
[  206.522535]  entry_SYSCALL_64_after_hwframe+0x73/0xdd

[  206.522557] value changed: 0xfffffffffff80000 -> 0xfffffffffff00000

[  206.522574] Reported by Kernel Concurrency Sanitizer on:
[  206.522585] CPU: 6 PID: 2793 Comm: tracker-extract Tainted: G             L     6.5.0-rc6+ #44
[  206.522600] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[  206.522608] ==================================================================

Unwound:

[  206.510010] ==================================================================
[  206.510035] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked

[  206.510067] write to 0xffff963df6a90fe0 of 8 bytes by interrupt on cpu 22:
[  206.510081] xas_clear_mark (./arch/x86/include/asm/bitops.h:178 ./include/asm-generic/bitops/instrumented-non-atomic.h:115 lib/xarray.c:102 lib/xarray.c:914)
[  206.510097] __xa_clear_mark (lib/xarray.c:1923)
[  206.510114] __folio_end_writeback (mm/page-writeback.c:2981)
[  206.510128] folio_end_writeback (mm/filemap.c:1616)
[  206.510143] end_page_writeback (mm/folio-compat.c:28)
[  206.510155] btrfs_page_clear_writeback (fs/btrfs/subpage.c:646) btrfs
[  206.510994] end_bio_extent_writepage (./include/linux/bio.h:84 fs/btrfs/extent_io.c:542) btrfs
[  206.511817] __btrfs_bio_end_io (fs/btrfs/bio.c:117 fs/btrfs/bio.c:112) btrfs
[  206.512640] btrfs_orig_bbio_end_io (fs/btrfs/bio.c:164) btrfs
[  206.513497] btrfs_simple_end_io (fs/btrfs/bio.c:380) btrfs
[  206.514350] bio_endio (block/bio.c:1617)
[  206.514362] blk_mq_end_request_batch (block/blk-mq.c:837 block/blk-mq.c:1073)
[  206.514377] nvme_pci_complete_batch (drivers/nvme/host/pci.c:986) nvme
[  206.514437] nvme_irq (drivers/nvme/host/pci.c:1086) nvme
[  206.514500] __handle_irq_event_percpu (kernel/irq/handle.c:158)
[  206.514517] handle_irq_event (kernel/irq/handle.c:195 kernel/irq/handle.c:210)
[  206.514533] handle_edge_irq (kernel/irq/chip.c:836)
[  206.514549] __common_interrupt (./include/linux/irqdesc.h:161 arch/x86/kernel/irq.c:238 arch/x86/kernel/irq.c:257)
[  206.514563] common_interrupt (arch/x86/kernel/irq.c:247 (discriminator 14))
[  206.514583] asm_common_interrupt (./arch/x86/include/asm/idtentry.h:636)
[  206.514599] kcsan_setup_watchpoint (kernel/kcsan/core.c:705 (discriminator 1))
[  206.514612] __tsan_read8 (kernel/kcsan/core.c:1025)
[  206.514626] steal_from_bitmap.part.0 (./include/linux/find.h:186 fs/btrfs/free-space-cache.c:2557 fs/btrfs/free-space-cache.c:2613) btrfs
[  206.515491] __btrfs_add_free_space (fs/btrfs/free-space-cache.c:2689 fs/btrfs/free-space-cache.c:2667) btrfs
[  206.516361] btrfs_add_free_space_async_trimmed (fs/btrfs/free-space-cache.c:2798) btrfs
[  206.517231] add_new_free_space (fs/btrfs/block-group.c:550) btrfs
[  206.518095] load_free_space_tree (fs/btrfs/free-space-tree.c:1595 fs/btrfs/free-space-tree.c:1658) btrfs
[  206.518953] caching_thread (fs/btrfs/block-group.c:873) btrfs
[  206.519800] btrfs_work_helper (fs/btrfs/async-thread.c:314) btrfs
[  206.520643] process_one_work (kernel/workqueue.c:2600)
[  206.520658] worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2752)
[  206.520672] kthread (kernel/kthread.c:389)
[  206.520684] ret_from_fork (arch/x86/kernel/process.c:145)
[  206.520701] ret_from_fork_asm (arch/x86/entry/entry_64.S:312)

[  206.520722] read to 0xffff963df6a90fe0 of 8 bytes by task 2793 on cpu 6:
[  206.520735] xas_find_marked (./include/linux/xarray.h:1706 lib/xarray.c:1354)
[  206.520750] filemap_get_folios_tag (mm/filemap.c:1975 mm/filemap.c:2273)
[  206.520763] __filemap_fdatawait_range (mm/filemap.c:519)
[  206.520777] filemap_fdatawait_range (mm/filemap.c:556)
[  206.520790] btrfs_wait_ordered_range (fs/btrfs/ordered-data.c:839) btrfs
[  206.521641] btrfs_sync_file (fs/btrfs/file.c:1859) btrfs
[  206.522495] vfs_fsync_range (fs/sync.c:188)
[  206.522509] __x64_sys_fsync (./include/linux/file.h:45 fs/sync.c:213 fs/sync.c:220 fs/sync.c:218 fs/sync.c:218)
[  206.522522] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
[  206.522535] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

[  206.522557] value changed: 0xfffffffffff80000 -> 0xfffffffffff00000

[  206.522574] Reported by Kernel Concurrency Sanitizer on:
[  206.522585] CPU: 6 PID: 2793 Comm: tracker-extract Tainted: G             L     6.5.0-rc6+ #44
[  206.522600] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[  206.522608] ==================================================================

Best regards,
Mirsad Todorovac

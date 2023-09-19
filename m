Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2951E7A59E6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 08:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbjISGYO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 02:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjISGYN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 02:24:13 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3611100;
        Mon, 18 Sep 2023 23:24:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7C44D60155;
        Tue, 19 Sep 2023 08:24:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695104645; bh=upOfDOQSgqs944vK9naJ0PYlsPlTDfNuMdXJNp22TdI=;
        h=Date:To:Cc:From:Subject:From;
        b=ctigf3mvgSNd2Cc/JjqsVHm/0RB5TkSrfiLPDS+0i1PiIeRIUhlS3ybjRRlDUuOk3
         F6Qk/GdzbAOFFM8AZGNlav4nOugKgStSspBdFd1vowC2zd/iJv3TuiUhAEzCneGIFQ
         b2+apG40XvIGuQF75HLS02yWrlBKjT3BCoJWNoByDKCoGaqj2LeCiHAz66yUQFSLza
         t9Ok/zo7mbNcVx31ta3c7XR76Q6kHsar53D0KvZHdyGdVxPxYNl8QOX1vr0Cg2SRi3
         LmebAslSANNykU+LV9rPVrCyMyBskWeN/nt/nJCZXXSStG3hD5Be3MPQHoIGgPo3sI
         XpblPXy0kDxAQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rt40xg3vzshH; Tue, 19 Sep 2023 08:24:02 +0200 (CEST)
Received: from [192.168.1.6] (78-0-136-157.adsl.net.t-com.hr [78.0.136.157])
        by domac.alu.hr (Postfix) with ESMTPSA id D4CB760152;
        Tue, 19 Sep 2023 08:24:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695104642; bh=upOfDOQSgqs944vK9naJ0PYlsPlTDfNuMdXJNp22TdI=;
        h=Date:To:Cc:From:Subject:From;
        b=Xca54BgzOtYZj6M9zA2yQ6ykQ7nbaxs1Rbf22JMVbhwR2tT4HYkPZWe4zcUVzTAVX
         FQr8OW5zI88TjJdvmEGmKh/6UdoKVfiri++etMEo09XVZpIB8XKlVyOARf6/Ubf3Aj
         zSEiumie2p5inPsrCg9QgJyyWbIO0F6+iFP3+HefWAiqXJbVzP37222Df+fdKR4TEE
         KOWx6Prz5FuKRo+9j6l7GbHoFrO0iDBXEaEDXVfwbqg09Ur67HJEm01KuY2Wb6p/yI
         bJkawpgGkHxem1CSW8NeIHvShoWStt4UJgcPxuTtZVkC0KdBJWUZWaCXPBwmWQplBH
         wPymydDCGX4MA==
Content-Type: multipart/mixed; boundary="------------SpSWYZgDL6QsR9DfvhptriRR"
Message-ID: <4ca1f264-eebb-608e-617e-7aec743ccc90@alu.unizg.hr>
Date:   Tue, 19 Sep 2023 08:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Subject: BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is a multi-part message in MIME format.
--------------SpSWYZgDL6QsR9DfvhptriRR
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

The usual setup: vanilla torvalds tree kernel 6.6-rc2, Ubuntu 22.04 LTS.

KCSAN had found a number of data-races in the btrfs implementation.

It is not clear whether this can lead to the corruption of data on the storage media.

Please find the complete KCSAN dmesg report attached.

Best regards,
Mirsad Todorovac

  2149.512903] ==================================================================
[ 2149.512933] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked

[ 2149.512967] write to 0xffff8881ab9d2468 of 8 bytes by interrupt on cpu 27:
[ 2149.512984] xas_clear_mark (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/bitops.h:178 /home/marvin/linux/kernel/torvalds2/./include/asm-generic/bitops/instrumented-non-atomic.h:115 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:102 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:914)
[ 2149.513002] __xa_clear_mark (/home/marvin/linux/kernel/torvalds2/lib/xarray.c:1929)
[ 2149.513019] __folio_end_writeback (/home/marvin/linux/kernel/torvalds2/mm/page-writeback.c:2960)
[ 2149.513039] folio_end_writeback (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:1613)
[ 2149.513053] end_page_writeback (/home/marvin/linux/kernel/torvalds2/mm/folio-compat.c:28)
[ 2149.513073] btrfs_page_clear_writeback (/home/marvin/linux/kernel/torvalds2/fs/btrfs/subpage.c:646) btrfs
[ 2149.513829] end_bio_extent_writepage (/home/marvin/linux/kernel/torvalds2/./include/linux/bio.h:84 /home/marvin/linux/kernel/torvalds2/fs/btrfs/extent_io.c:468) btrfs
[ 2149.514481] __btrfs_bio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:117 /home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:112) btrfs
[ 2149.515130] btrfs_orig_bbio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:164) btrfs
[ 2149.515777] btrfs_simple_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:380) btrfs
[ 2149.516425] bio_endio (/home/marvin/linux/kernel/torvalds2/block/bio.c:1603)
[ 2149.516436] blk_mq_end_request_batch (/home/marvin/linux/kernel/torvalds2/block/blk-mq.c:851 /home/marvin/linux/kernel/torvalds2/block/blk-mq.c:1089)
[ 2149.516449] nvme_pci_complete_batch (/home/marvin/linux/kernel/torvalds2/drivers/nvme/host/pci.c:986) nvme
[ 2149.516494] nvme_irq (/home/marvin/linux/kernel/torvalds2/drivers/nvme/host/pci.c:1086) nvme
[ 2149.516538] __handle_irq_event_percpu (/home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:158)
[ 2149.516553] handle_irq_event (/home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:195 /home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:210)
[ 2149.516566] handle_edge_irq (/home/marvin/linux/kernel/torvalds2/kernel/irq/chip.c:833)
[ 2149.516578] __common_interrupt (/home/marvin/linux/kernel/torvalds2/./include/linux/irqdesc.h:161 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:238 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:257)
[ 2149.516589] common_interrupt (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:247 (discriminator 14))
[ 2149.516601] asm_common_interrupt (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/idtentry.h:636)
[ 2149.516612] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:291)
[ 2149.516623] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
[ 2149.516633] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
[ 2149.516646] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
[ 2149.516655] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
[ 2149.516664] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
[ 2149.516677] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)

[ 2149.516697] read to 0xffff8881ab9d2468 of 8 bytes by task 4603 on cpu 25:
[ 2149.516708] xas_find_marked (/home/marvin/linux/kernel/torvalds2/./include/linux/find.h:63 /home/marvin/linux/kernel/torvalds2/./include/linux/xarray.h:1722 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:1354)
[ 2149.516719] filemap_get_folios_tag (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:1978 /home/marvin/linux/kernel/torvalds2/mm/filemap.c:2266)
[ 2149.516729] __filemap_fdatawait_range (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:516)
[ 2149.516739] filemap_fdatawait_range (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:553)
[ 2149.516749] btrfs_wait_ordered_range (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ordered-data.c:841) btrfs
[ 2149.517405] btrfs_sync_file (/home/marvin/linux/kernel/torvalds2/fs/btrfs/file.c:1844) btrfs
[ 2149.518059] vfs_fsync_range (/home/marvin/linux/kernel/torvalds2/fs/sync.c:188)
[ 2149.518071] __x64_sys_fsync (/home/marvin/linux/kernel/torvalds2/./include/linux/file.h:45 /home/marvin/linux/kernel/torvalds2/fs/sync.c:213 /home/marvin/linux/kernel/torvalds2/fs/sync.c:220 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218)
[ 2149.518081] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
[ 2149.518095] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)

[ 2149.518111] value changed: 0xffffff8000000000 -> 0x0000000000000000

[ 2149.518126] Reported by Kernel Concurrency Sanitizer on:
[ 2149.518133] CPU: 25 PID: 4603 Comm: mozStorage #1 Tainted: G             L     6.6.0-rc2-kcsan-00003-g16819584c239-dirty #21
[ 2149.518146] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
[ 2149.518153] ==================================================================
--------------SpSWYZgDL6QsR9DfvhptriRR
Content-Type: application/x-xz; name="xas_clear_mark.log.xz"
Content-Disposition: attachment; filename="xas_clear_mark.log.xz"
Content-Transfer-Encoding: base64

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

--------------SpSWYZgDL6QsR9DfvhptriRR--

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490707A654A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 15:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232384AbjISNgP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 09:36:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjISNgO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 09:36:14 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [161.53.235.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478D6F5;
        Tue, 19 Sep 2023 06:36:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 3587C60157;
        Tue, 19 Sep 2023 15:36:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1695130564; bh=8632NUMsCw1YBeVxUGKl9XmColmXPFnLeY4eFFa3i1w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E6J9j5sfSpMPySEJB9LfTDlsg3m3TC6mx8/eChC1Z6Z9vNf8V0SzQs9eOfGQt2xcc
         zWZCVXVY2NJfKc+BmRY4TIvky5DWpiYu880gABk2STIURTjaA2nzmd66n9HsudFybm
         2vxdfqajrko2gYT6QLy8SibxufhXyqoPPnEs124bhPkmSSCL7bwZfPi30v2DPu7H6L
         HYyHh1WMdSHACOOOoe770s4nAg+D9x7bXq9KAiyEavQfJZokGa5Q6KZcFvibj335ME
         zQDA09kQsJS7AqNGqsCoCZCm2Tjy0TdmhxeKll2vTkAFpotNEqKNnY+R7oK7Z0whHS
         e3Wmmcdb5F5EA==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id fsEjALMZnwWS; Tue, 19 Sep 2023 15:36:01 +0200 (CEST)
Received: from [IPV6:2001:b68:2:2600:847a:a5b8:fda0:5de5] (unknown [IPv6:2001:b68:2:2600:847a:a5b8:fda0:5de5])
        by domac.alu.hr (Postfix) with ESMTPSA id 513D860152;
        Tue, 19 Sep 2023 15:36:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1695130561; bh=8632NUMsCw1YBeVxUGKl9XmColmXPFnLeY4eFFa3i1w=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=U80bhw3dZsz9ZRsVPjPpgUOa/Hb4sxrL2puwXwzhEkL6X8dWA/WpxowFfDLF+DqVx
         qFKC+xzbxUl5b8giFCk3ZpTYjpgu8NbaoG6YxIJ760ojQbKnczNh9lUeSXDl8ORvIH
         aQoj1QJ+t//NIFBn2V/Uni7aMWMq6ZrgWABGxLTzafMG+vzy7ZfqH/bnkeoAdBOU5s
         /+sio/eX8wcXPug+PtOge5VHqWdya7R1RoR+4AB2eahqpDHC7EN+kgKWD3QPAZJrH6
         0lel8Vnb8Me+GorIfoIB5XzCnxcBrZmozCicqYD3zuvX46zh7X5+6OMIt82ff3CRsJ
         Li0FjO2OSNoiQ==
Message-ID: <ef71936d-8385-4fe6-bdfe-c1ad7a38ca9c@alu.unizg.hr>
Date:   Tue, 19 Sep 2023 15:36:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <4ca1f264-eebb-608e-617e-7aec743ccc90@alu.unizg.hr>
 <ZQmTUWywzpIk5kMW@casper.infradead.org>
From:   Mirsad Todorovac <mirsad.todorovac@alu.hr>
In-Reply-To: <ZQmTUWywzpIk5kMW@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org



On 9/19/2023 2:25 PM, Matthew Wilcox wrote:
> On Tue, Sep 19, 2023 at 08:24:02AM +0200, Mirsad Todorovac wrote:
>> Hi,
>>
>> The usual setup: vanilla torvalds tree kernel 6.6-rc2, Ubuntu 22.04 LTS.
>>
>> KCSAN had found a number of data-races in the btrfs implementation.
> 
> This isn't btrfs; it's the same as the race reported on August 18th.
> https://lore.kernel.org/linux-mm/06645d2b-a964-1c4c-15cf-42ccc6c6e19b@alu.unizg.hr/

Hi,

Thank you for your insight.

Yes, I see that it is the old report ... Mea culpa. But now I had more 
instances and perhaps they can give more insight?

I must admit that I am a bit perplexed with the KCSAN reports data races 
in hundreds.

Most of them were connected with the find_*_bit() family of functions 
and ACPI. Eliminating those races might fix like 80% of the KCSAN 
reported bugs.

Best regards,
Mirsad Todorovac

>> It is not clear whether this can lead to the corruption of data on the storage media.
>>
>> Please find the complete KCSAN dmesg report attached.
>>
>> Best regards,
>> Mirsad Todorovac
>>
>>   2149.512903] ==================================================================
>> [ 2149.512933] BUG: KCSAN: data-race in xas_clear_mark / xas_find_marked
>>
>> [ 2149.512967] write to 0xffff8881ab9d2468 of 8 bytes by interrupt on cpu 27:
>> [ 2149.512984] xas_clear_mark (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/bitops.h:178 /home/marvin/linux/kernel/torvalds2/./include/asm-generic/bitops/instrumented-non-atomic.h:115 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:102 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:914)
>> [ 2149.513002] __xa_clear_mark (/home/marvin/linux/kernel/torvalds2/lib/xarray.c:1929)
>> [ 2149.513019] __folio_end_writeback (/home/marvin/linux/kernel/torvalds2/mm/page-writeback.c:2960)
>> [ 2149.513039] folio_end_writeback (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:1613)
>> [ 2149.513053] end_page_writeback (/home/marvin/linux/kernel/torvalds2/mm/folio-compat.c:28)
>> [ 2149.513073] btrfs_page_clear_writeback (/home/marvin/linux/kernel/torvalds2/fs/btrfs/subpage.c:646) btrfs
>> [ 2149.513829] end_bio_extent_writepage (/home/marvin/linux/kernel/torvalds2/./include/linux/bio.h:84 /home/marvin/linux/kernel/torvalds2/fs/btrfs/extent_io.c:468) btrfs
>> [ 2149.514481] __btrfs_bio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:117 /home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:112) btrfs
>> [ 2149.515130] btrfs_orig_bbio_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:164) btrfs
>> [ 2149.515777] btrfs_simple_end_io (/home/marvin/linux/kernel/torvalds2/fs/btrfs/bio.c:380) btrfs
>> [ 2149.516425] bio_endio (/home/marvin/linux/kernel/torvalds2/block/bio.c:1603)
>> [ 2149.516436] blk_mq_end_request_batch (/home/marvin/linux/kernel/torvalds2/block/blk-mq.c:851 /home/marvin/linux/kernel/torvalds2/block/blk-mq.c:1089)
>> [ 2149.516449] nvme_pci_complete_batch (/home/marvin/linux/kernel/torvalds2/drivers/nvme/host/pci.c:986) nvme
>> [ 2149.516494] nvme_irq (/home/marvin/linux/kernel/torvalds2/drivers/nvme/host/pci.c:1086) nvme
>> [ 2149.516538] __handle_irq_event_percpu (/home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:158)
>> [ 2149.516553] handle_irq_event (/home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:195 /home/marvin/linux/kernel/torvalds2/kernel/irq/handle.c:210)
>> [ 2149.516566] handle_edge_irq (/home/marvin/linux/kernel/torvalds2/kernel/irq/chip.c:833)
>> [ 2149.516578] __common_interrupt (/home/marvin/linux/kernel/torvalds2/./include/linux/irqdesc.h:161 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:238 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:257)
>> [ 2149.516589] common_interrupt (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/irq.c:247 (discriminator 14))
>> [ 2149.516601] asm_common_interrupt (/home/marvin/linux/kernel/torvalds2/./arch/x86/include/asm/idtentry.h:636)
>> [ 2149.516612] cpuidle_enter_state (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:291)
>> [ 2149.516623] cpuidle_enter (/home/marvin/linux/kernel/torvalds2/drivers/cpuidle/cpuidle.c:390)
>> [ 2149.516633] call_cpuidle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:135)
>> [ 2149.516646] do_idle (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:219 /home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:282)
>> [ 2149.516655] cpu_startup_entry (/home/marvin/linux/kernel/torvalds2/kernel/sched/idle.c:378 (discriminator 1))
>> [ 2149.516664] start_secondary (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:210 /home/marvin/linux/kernel/torvalds2/arch/x86/kernel/smpboot.c:294)
>> [ 2149.516677] secondary_startup_64_no_verify (/home/marvin/linux/kernel/torvalds2/arch/x86/kernel/head_64.S:433)
>>
>> [ 2149.516697] read to 0xffff8881ab9d2468 of 8 bytes by task 4603 on cpu 25:
>> [ 2149.516708] xas_find_marked (/home/marvin/linux/kernel/torvalds2/./include/linux/find.h:63 /home/marvin/linux/kernel/torvalds2/./include/linux/xarray.h:1722 /home/marvin/linux/kernel/torvalds2/lib/xarray.c:1354)
>> [ 2149.516719] filemap_get_folios_tag (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:1978 /home/marvin/linux/kernel/torvalds2/mm/filemap.c:2266)
>> [ 2149.516729] __filemap_fdatawait_range (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:516)
>> [ 2149.516739] filemap_fdatawait_range (/home/marvin/linux/kernel/torvalds2/mm/filemap.c:553)
>> [ 2149.516749] btrfs_wait_ordered_range (/home/marvin/linux/kernel/torvalds2/fs/btrfs/ordered-data.c:841) btrfs
>> [ 2149.517405] btrfs_sync_file (/home/marvin/linux/kernel/torvalds2/fs/btrfs/file.c:1844) btrfs
>> [ 2149.518059] vfs_fsync_range (/home/marvin/linux/kernel/torvalds2/fs/sync.c:188)
>> [ 2149.518071] __x64_sys_fsync (/home/marvin/linux/kernel/torvalds2/./include/linux/file.h:45 /home/marvin/linux/kernel/torvalds2/fs/sync.c:213 /home/marvin/linux/kernel/torvalds2/fs/sync.c:220 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218 /home/marvin/linux/kernel/torvalds2/fs/sync.c:218)
>> [ 2149.518081] do_syscall_64 (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:50 /home/marvin/linux/kernel/torvalds2/arch/x86/entry/common.c:80)
>> [ 2149.518095] entry_SYSCALL_64_after_hwframe (/home/marvin/linux/kernel/torvalds2/arch/x86/entry/entry_64.S:120)
>>
>> [ 2149.518111] value changed: 0xffffff8000000000 -> 0x0000000000000000
>>
>> [ 2149.518126] Reported by Kernel Concurrency Sanitizer on:
>> [ 2149.518133] CPU: 25 PID: 4603 Comm: mozStorage #1 Tainted: G             L     6.6.0-rc2-kcsan-00003-g16819584c239-dirty #21
>> [ 2149.518146] Hardware name: ASRock X670E PG Lightning/X670E PG Lightning, BIOS 1.21 04/26/2023
>> [ 2149.518153] ==================================================================
> 

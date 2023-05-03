Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3D86F4FE3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 May 2023 08:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbjECGE6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 May 2023 02:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjECGE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 May 2023 02:04:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 273C82D69
        for <linux-fsdevel@vger.kernel.org>; Tue,  2 May 2023 23:04:55 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1aaec6f189cso26105785ad.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 02 May 2023 23:04:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20221208.gappssmtp.com; s=20221208; t=1683093894; x=1685685894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MDRQRdyZS/T+X4lsFUSgluI/WlYxzE7pQwx3ic8Xr44=;
        b=Jw8drwQZaAeoy/SUvR7g1veEr8dlHJF0AquJjUmxq0Si5IxwdiCtCxs43pzwsVMfnY
         mSSq2kSUWgflIpPWxkzKUSJVlc3GC01Gk4vtQUq9X/pkzhDbAaLSVGpir2PYgMvA0jS9
         6Al50raFsk5Dmxl6pGTiHkH7Uo3GbSfjEtp8472SXZfjMmgtQgAxltx4yHe2hiZX/8My
         k/tX9AFQ9dhGJoyP6R04swAT7R2OeU0KlRmKOqS4Ho9DmN5Pg5BKLMHn/f8en4q4db+q
         WoFL6EK10SdISmIfATHk2Vxf6sJiDiBTAW3WVteeRmHX8PA6X/IeoCKfj37QKDMQGNvO
         fQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683093894; x=1685685894;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MDRQRdyZS/T+X4lsFUSgluI/WlYxzE7pQwx3ic8Xr44=;
        b=D0o9xHx9n7qqRP3TrG5fd4m+QeKkjzHkBJIXCDwvAfb22Lc3lNMlXdksIDwoacyaE/
         5Tr9IMJ7qHQrgaVjUUH8HdNfsXhOIpnKlFvPq3pR2XuiG5HgDajKF4WOUvWh2jFtpYY/
         phvLDVk5d4/ND7FHUK/4/RCz1/ZO5iELbjYFxBxzfEnGbvlCUL18UkpyMP4yVDV3+YwN
         qPyimBy/TXHvum/KDcRfBrtzfFpRxnWoxj/2ZlNWtgOksUMl1TIzSVZWcj/LKezw295m
         T/nYHzjyqz8LHuHAnOTOs6n7vDY3q9rCKGrLlv/su7/tvwuhFLIh9Kb6GfZ/YUlV+FPu
         qmnw==
X-Gm-Message-State: AC+VfDy5KNH6dDgFV+pmlP+PDhF+dzodRU1DJdME53gAe2ahot16ThVk
        K8pcyTKL4mqyYt/vLixoBiPi0WB9Tk2gfIFKhKaegQ==
X-Google-Smtp-Source: ACHHUZ5/3UAdX7u+gtieAw2vbSrkfqv2xakKrS9XytzsyomFuwRTWECbxaFwcB6WJkO0oCTABgrwWg==
X-Received: by 2002:a17:903:18c:b0:1a6:87e3:db50 with SMTP id z12-20020a170903018c00b001a687e3db50mr1233951plg.1.1683093894576;
        Tue, 02 May 2023 23:04:54 -0700 (PDT)
Received: from dread.disaster.area (pa49-181-88-204.pa.nsw.optusnet.com.au. [49.181.88.204])
        by smtp.gmail.com with ESMTPSA id c9-20020a170902b68900b001ab016ea3f9sm3717752pls.21.2023.05.02.23.04.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 23:04:53 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1pu5be-00AkKn-Ob; Wed, 03 May 2023 16:04:50 +1000
Date:   Wed, 3 May 2023 16:04:50 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     linux-block@vger.kernel.org
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        axboe@kernel.dk
Subject: [6.4-current oops] null ptr deref in blk_mq_sched_bio_merge() from
 blkdev readahead
Message-ID: <20230503060450.GC3223426@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi folks,

fstests running shared/032 on XFS with a default mkfs and mount
config causes a panic in the block layer when userspace is operating
directly on the block device like this:

SECTION       -- xfs
FSTYP         -- xfs (debug)
PLATFORM      -- Linux/x86_64 test3 6.3.0-dgc+ #1792 SMP PREEMPT_DYNAMIC Wed May  3 15:20:20 AEST 2023
MKFS_OPTIONS  -- -f -m rmapbt=1 /dev/pmem1
MOUNT_OPTIONS -- -o dax=never -o context=system_u:object_r:root_t:s0 /dev/pmem1 /mnt/scratch

....

[   56.070695] run fstests shared/032 at 2023-05-03 15:21:55
[   56.768890] BTRFS: device fsid 355df15c-7bc5-49b0-9b5d-dc25ce855a9d devid 1 transid 6 /dev/pmem1 scanned by mkfs.btrfs (5836)
[   57.285879]  pmem1: p1
[   57.301845] BUG: kernel NULL pointer dereference, address: 00000000000000a8
[   57.304562] #PF: supervisor read access in kernel mode
[   57.306499] #PF: error_code(0x0000) - not-present page
[   57.308414] PGD 0 P4D 0 
[   57.309401] Oops: 0000 [#1] PREEMPT SMP
[   57.310876] CPU: 3 PID: 4478 Comm: (udev-worker) Not tainted 6.3.0-dgc+ #1792
[   57.313517] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[   57.317089] RIP: 0010:blk_mq_sched_bio_merge+0x7b/0x100
[   57.319059] Code: c0 49 8b 5c 24 38 48 03 1c c5 c0 69 71 82 b8 02 00 00 00 f7 c2 00 00 40 00 75 07 31 c0 84 d2 0f 94 c0 48 8b 94 c3 90 00 00 00 <f6> 82 a8 0d
[   57.325898] RSP: 0018:ffffc900042ab880 EFLAGS: 00010246
[   57.327835] RAX: 0000000000000001 RBX: ffff888237d80000 RCX: 0000000000000000
[   57.330492] RDX: 0000000000000000 RSI: ffff88810135e000 RDI: ffff8885c1928000
[   57.333118] RBP: ffffc900042ab8b0 R08: 0000000000001000 R09: 0000000000000001
[   57.335791] R10: ffff8885c1928000 R11: 0000000000000008 R12: ffff8885c1928000
[   57.338298] R13: ffff88810135e000 R14: 0000000000000001 R15: ffff88810135e000
[   57.340092] FS:  00007f4adf5438c0(0000) GS:ffff888237d80000(0000) knlGS:0000000000000000
[   57.342132] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   57.343536] CR2: 00000000000000a8 CR3: 0000000102e4a005 CR4: 0000000000060ee0
[   57.345150] Call Trace:
[   57.345732]  <TASK>
[   57.346265]  ? mempool_alloc_slab+0x15/0x20
[   57.347242]  blk_mq_attempt_bio_merge+0x4e/0x50
[   57.348288]  blk_mq_submit_bio+0x232/0x580
[   57.349230]  __submit_bio+0x1e/0x110
[   57.350066]  submit_bio_noacct_nocheck+0x24a/0x330
[   57.351161]  submit_bio_noacct+0x196/0x490
[   57.352104]  submit_bio+0x43/0x60
[   57.352879]  mpage_readahead+0xf4/0x130
[   57.353762]  ? blkdev_write_begin+0x30/0x30
[   57.354741]  blkdev_readahead+0x15/0x20
[   57.355719]  read_pages+0x5c/0x230
[   57.356625]  page_cache_ra_unbounded+0x148/0x190
[   57.357764]  force_page_cache_ra+0x9a/0xc0
[   57.358845]  page_cache_sync_ra+0x2e/0x50
[   57.359839]  filemap_get_pages+0x10f/0x670
[   57.360870]  ? walk_component+0xc7/0x170
[   57.361859]  filemap_read+0xed/0x380
[   57.362819]  ? __ia32_compat_sys_lookup_dcookie+0x410/0xe80
[   57.364086]  ? __might_fault+0x22/0x30
[   57.364953]  blkdev_read_iter+0xe3/0x1e0
[   57.365871]  vfs_read+0x213/0x2e0
[   57.366646]  ksys_read+0x71/0xf0
[   57.367396]  __x64_sys_read+0x19/0x20
[   57.368244]  do_syscall_64+0x34/0x80
[   57.369064]  entry_SYSCALL_64_after_hwframe+0x63/0xcd
[   57.370225] RIP: 0033:0x7f4adf7c503d
[   57.371054] Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d a6 55 0a 00 e8 39 fe 01 00 66 0f 1f 84 00 00 00 00 00 80 3d a1 25 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 fc
[   57.375229] RSP: 002b:00007ffd91350748 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
[   57.376933] RAX: ffffffffffffffda RBX: 000055c11070df70 RCX: 00007f4adf7c503d
[   57.378565] RDX: 0000000000000040 RSI: 000055c1105c48f8 RDI: 000000000000000f
[   57.380177] RBP: 00000001fffe0000 R08: 000055c1106f41c0 R09: 00007f4adf8a02e0
[   57.381790] R10: 0000000000000000 R11: 0000000000000246 R12: 000055c1105c48d0
[   57.383406] R13: 0000000000000040 R14: 000055c11070dfc8 R15: 000055c1105c48e8
[   57.385026]  </TASK>

shared/032 is entirely a mkfs test - it is checking that mkfs for
the filesystem under test recognises other filesystem signatures on
the block device and does not overwrite them by accident. This test
does not involve kernel filesystem code at all.

Somewhere in amongst the running of various mkfs operations during
the test, a udev-worker is triggered and is doing something with
the block device (probing it?) and that results in the above oops
occurring.

This is only happening on the machine I have configured with (fake)
PMEM devices - virtio, sd and nvme devices do not appear to
be triggering this. That kinda implies a timing issue - pmem
completes IO synchronously, all the the others use async
completion...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

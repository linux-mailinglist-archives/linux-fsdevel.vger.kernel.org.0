Return-Path: <linux-fsdevel+bounces-36468-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A69429E3CFF
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 15:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C2E8B2DB04
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 14:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5E020A5E7;
	Wed,  4 Dec 2024 14:39:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4DA20899C
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 14:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733323145; cv=none; b=lg13T2nzHmsyAJtfm+5RkWiUh6+mz69NT6lLqNsVB8oYyt50r/3hr5/7GYS8aYzVPEZ+A8KiqcXh1DwjxN2CbdPsvznI2fcVFzkDsqLOr7FoIILdve+DZNAeivTOFFZt1eV8iFiAuMRNcZ77PhCo5MUNIvavEUn4EcahciUm/Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733323145; c=relaxed/simple;
	bh=cgBrAu3rCotz8BO7lyA7PKhbxTxHdDX0EkhOU/HDJoM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=csEwFs2KyD0EqCrc/LHBFsQb1wwzhKgPkF6JfWWC+7VIkSGFRweRQsNTN/qYeZkRBBbnx5os2x8kDwbSGz9R0XdmpksiFu1MUdho3h/BCObZD3bo3hQYK8tTFneCliISbi8vwrYc2mu/KUQ98jhG5s/lbp6XLFbOuT3zotTC/Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a7e1e6d83fso101017055ab.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 04 Dec 2024 06:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733323143; x=1733927943;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i8eUeYyXPY5DE2a4Z351/KxDabP2x7UZlSYonRpg5JM=;
        b=vtF+2cv15x8yzbWjCaSrXun4FA0oTMmqqPHd+TVwfk6XucmpfYBiz1ur2SVpBRBvml
         HH+EiQrWSCBwARFO5TRZyd/Iq3vtsll5ThK8GO3KIPWnngg9tcKRNhunlrltckR3T7rf
         iECQkLNQ2QDiXB5w1auQEC9R51exH+mbZpu1dgLumRPGOHi8umyAbu8qX/3P32udjK93
         RQtaaOmnlrGD2IbyNsZY9Yu1hmFQ/CGFPORzpOy0T5LA6z2w8Zn3FcY+Sn+OR5bg/NCn
         rDRY5uIQKH3IEpbusdy8aZcsOgEg4Z7y1g52/XGzmIIJnjMSF8zHuYANFeko9kFTBlrd
         9Dfg==
X-Forwarded-Encrypted: i=1; AJvYcCX6Qjawx7jIRLrCTd/qqp2BfPDT5Pax8Kmej8YNB0ezYxMtlvaK55Kx1Y6PONG5ijpoOxuN6PSBqnfEIcvd@vger.kernel.org
X-Gm-Message-State: AOJu0YwAmqTXjFooZEX67Suz7i+ZpHSvEtQrWss7C35x8MJr5gbujOdo
	uLJqAgoSIgtJx0YMOjy4LQSDaONuJBUojToEbAVyZzZLvGq0Ext1i+T0uRf9bEoDcOz1YdFNAf1
	ebgfuqWOIHjkf9LIBw4ibW9mNOsfR4hLYlx83aZcBjxWgO4CxzvbyNzE=
X-Google-Smtp-Source: AGHT+IEI8Fm+ngcAScAw3GZ+NipnXHnpue0z2vk2s83Py6BMfT1btpH7zPlB8xEQn7qHc0VWjeGLNUVysHgH6ZPN7Sw0Fi41YoLy
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c56a:0:b0:3a7:dfe4:bd33 with SMTP id
 e9e14a558f8ab-3a7fecc82b3mr58583675ab.6.1733323143026; Wed, 04 Dec 2024
 06:39:03 -0800 (PST)
Date: Wed, 04 Dec 2024 06:39:03 -0800
In-Reply-To: <1129891.1733321485@warthog.procyon.org.uk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67506987.050a0220.17bd51.006f.GAE@google.com>
Subject: Re: [syzbot] [netfs?] kernel BUG in iov_iter_revert (2)
From: syzbot <syzbot+404b4b745080b6210c6c@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in __submit_bio

======================================================
WARNING: possible circular locking dependency detected
6.13.0-rc1-syzkaller-dirty #0 Not tainted
------------------------------------------------------
kswapd0/75 is trying to acquire lock:
ffff888034c41438 (&q->q_usage_counter(io)#37){++++}-{0:0}, at: __submit_bio+0x2c6/0x560 block/blk-core.c:629

but task is already holding lock:
ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6864 [inline]
ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 mm/vmscan.c:7246

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (fs_reclaim){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __fs_reclaim_acquire mm/page_alloc.c:3851 [inline]
       fs_reclaim_acquire+0x88/0x130 mm/page_alloc.c:3865
       might_alloc include/linux/sched/mm.h:318 [inline]
       slab_pre_alloc_hook mm/slub.c:4055 [inline]
       slab_alloc_node mm/slub.c:4133 [inline]
       __do_kmalloc_node mm/slub.c:4282 [inline]
       __kmalloc_node_noprof+0xb2/0x4d0 mm/slub.c:4289
       __kvmalloc_node_noprof+0x72/0x190 mm/util.c:650
       sbitmap_init_node+0x2d4/0x670 lib/sbitmap.c:132
       scsi_realloc_sdev_budget_map+0x2a7/0x460 drivers/scsi/scsi_scan.c:246
       scsi_add_lun drivers/scsi/scsi_scan.c:1106 [inline]
       scsi_probe_and_add_lun+0x3173/0x4bd0 drivers/scsi/scsi_scan.c:1287
       __scsi_add_device+0x228/0x2f0 drivers/scsi/scsi_scan.c:1622
       ata_scsi_scan_host+0x236/0x740 drivers/ata/libata-scsi.c:4575
       async_run_entry_fn+0xa8/0x420 kernel/async.c:129
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (&q->q_usage_counter(io)#37){++++}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       bio_queue_enter block/blk.h:75 [inline]
       blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
       __submit_bio+0x2c6/0x560 block/blk-core.c:629
       __submit_bio_noacct_mq block/blk-core.c:710 [inline]
       submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
       swap_writepage_bdev_async mm/page_io.c:451 [inline]
       __swap_writepage+0x5fc/0x1400 mm/page_io.c:474
       swap_writepage+0x8f4/0x1170 mm/page_io.c:289
       pageout mm/vmscan.c:689 [inline]
       shrink_folio_list+0x3c0e/0x8cb0 mm/vmscan.c:1367
       evict_folios+0x5568/0x7be0 mm/vmscan.c:4593
       try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
       shrink_one+0x3b9/0x850 mm/vmscan.c:4834
       shrink_many mm/vmscan.c:4897 [inline]
       lru_gen_shrink_node mm/vmscan.c:4975 [inline]
       shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
       kswapd_shrink_node mm/vmscan.c:6785 [inline]
       balance_pgdat mm/vmscan.c:6977 [inline]
       kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               lock(&q->q_usage_counter(io)#37);
                               lock(fs_reclaim);
  rlock(&q->q_usage_counter(io)#37);

 *** DEADLOCK ***

1 lock held by kswapd0/75:
 #0: ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: balance_pgdat mm/vmscan.c:6864 [inline]
 #0: ffffffff8ea35b00 (fs_reclaim){+.+.}-{0:0}, at: kswapd+0xbf1/0x36f0 mm/vmscan.c:7246

stack backtrace:
CPU: 0 UID: 0 PID: 75 Comm: kswapd0 Not tainted 6.13.0-rc1-syzkaller-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 bio_queue_enter block/blk.h:75 [inline]
 blk_mq_submit_bio+0x1536/0x2390 block/blk-mq.c:3091
 __submit_bio+0x2c6/0x560 block/blk-core.c:629
 __submit_bio_noacct_mq block/blk-core.c:710 [inline]
 submit_bio_noacct_nocheck+0x4d3/0xe30 block/blk-core.c:739
 swap_writepage_bdev_async mm/page_io.c:451 [inline]
 __swap_writepage+0x5fc/0x1400 mm/page_io.c:474
 swap_writepage+0x8f4/0x1170 mm/page_io.c:289
 pageout mm/vmscan.c:689 [inline]
 shrink_folio_list+0x3c0e/0x8cb0 mm/vmscan.c:1367
 evict_folios+0x5568/0x7be0 mm/vmscan.c:4593
 try_to_shrink_lruvec+0x9a6/0xc70 mm/vmscan.c:4789
 shrink_one+0x3b9/0x850 mm/vmscan.c:4834
 shrink_many mm/vmscan.c:4897 [inline]
 lru_gen_shrink_node mm/vmscan.c:4975 [inline]
 shrink_node+0x37c5/0x3e50 mm/vmscan.c:5956
 kswapd_shrink_node mm/vmscan.c:6785 [inline]
 balance_pgdat mm/vmscan.c:6977 [inline]
 kswapd+0x1ca9/0x36f0 mm/vmscan.c:7246
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


Tested on:

commit:         40384c84 Linux 6.13-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.13-rc1
console output: https://syzkaller.appspot.com/x/log.txt?x=101560f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=58639d2215ba9a07
dashboard link: https://syzkaller.appspot.com/bug?extid=404b4b745080b6210c6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=138c4de8580000



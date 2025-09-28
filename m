Return-Path: <linux-fsdevel+bounces-62955-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB601BA7654
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 20:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3468D18947F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 Sep 2025 18:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FEB02586FE;
	Sun, 28 Sep 2025 18:42:24 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59972254848
	for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759084943; cv=none; b=sr6he0urMj+sRZ+YBXH2Sg6fXu5yj+dCKAWI+aLZzK9W0FVk6Dj9PiYb3txfNT2aj33PrMtx/RxMi7FQpW9tO7+Rf5n4dOVb76lXR/HRSDN63crKzsFO0Y8FxkQXOYFuetq613r0snErDbXGfbSeqJ5Zrz6ZIg2WzqjHJv1J1IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759084943; c=relaxed/simple;
	bh=ccQZincAL5ZyhGpKgORekV1QNw66LXSPLwp++bMwA+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=hHMIamY/faBk5MWDF0XmngCPDyieaRJrg8N8nZsN/rqeHK49+1KPAhvi6dbgUi2W8YLgdKq9qxvHTu7meH2UeSKLFJS5xDkHRL1mUTB34aHqUC1B61YnOo52blw6IO39d+nL9r6KAAqpxjKhvaL2ey3ukDV3PFJX25KNC6cufsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-42595318a28so62891645ab.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 28 Sep 2025 11:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759084940; x=1759689740;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsjAgiyqvCt+9DZGFMPpXrkpwO3vzJ5qTcEbSGKlpi8=;
        b=UIq7TDsFl/y6pY8+gHGcTcsPrB3paDFFyLhY04I1RVxXZ83q5pDsxth2jdA9mzdsO3
         rynABMBkJqzl78ZeG4peforXEvkxvaPHjvy4Ce55sZFqUZYCJ0SQQxhk8uVG7ojiDu2B
         yk2Y7Z4uJQ4rQYkPRJZpdEntim27qU0PbX8KXXw41tmjjd1+H38lfmbz8Dgv7Y8HVbOV
         HgH0YMZc3ymn3MFUhpka8mFv+ErZWy2U4kvoWV4H+HsNnjA7BEOMz/BGcxbMh27A7t8F
         1PzVl4sl9Pi460UWBSof4+7+jWFQTYeNc7Nj5sv+GBgoQ6KjkzsDXfMLFXH+E8hUoEh5
         +WNw==
X-Forwarded-Encrypted: i=1; AJvYcCWK+LGt4zMOtFRxN2Aifdw4oTbQcK7ChL4D0hw3FoVq4/0UROI02GMNFh/3cGAVtPIJ2lxXDOcnygC6N25a@vger.kernel.org
X-Gm-Message-State: AOJu0Yx11zUh3FMfZCGLbTKtYThSbNmq7BwwzPBCffrkgChm3RuOp01A
	XxTdpQJCImEOgCpxzEEwaMVdLtwMibm3VyJj8KD2FThquqYozofy7K49k79KgkpIDEYmTe8kC8q
	k3wYB9dVMjEBvBp6pib9lqlTP+vZtl1fTuVtM2NiXilgH2ZrzuOhB1bAIG9c=
X-Google-Smtp-Source: AGHT+IFOMgny6AZoeKClnUtWwvvWlBtfpV/YOGECAMlY6kCDL9+DCaNziVGkIJErsIkHssksFdIXB1lS9Df2ZzUnKrqroofJYo46
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:230a:b0:425:7788:871 with SMTP id
 e9e14a558f8ab-42875791953mr109399565ab.12.1759084940438; Sun, 28 Sep 2025
 11:42:20 -0700 (PDT)
Date: Sun, 28 Sep 2025 11:42:20 -0700
In-Reply-To: <20250928132927.3672537-1-ming.lei@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68d9818c.a00a0220.102ee.002d.GAE@google.com>
Subject: [syzbot ci] Re: loop: improve loop aio perf by IOCB_NOWAIT
From: syzbot ci <syzbot+ci7622762f075d3fa0@syzkaller.appspotmail.com>
To: axboe@kernel.dk, dchinner@redhat.com, hch@lst.de, 
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	ming.lei@redhat.com, mpatocka@redhat.com, zhaoyang.huang@unisoc.com
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot ci has tested the following series

[v1] loop: improve loop aio perf by IOCB_NOWAIT
https://lore.kernel.org/all/20250928132927.3672537-1-ming.lei@redhat.com
* [PATCH V4 1/6] loop: add helper lo_cmd_nr_bvec()
* [PATCH V4 2/6] loop: add helper lo_rw_aio_prep()
* [PATCH V4 3/6] loop: add lo_submit_rw_aio()
* [PATCH V4 4/6] loop: move command blkcg/memcg initialization into loop_queue_work
* [PATCH V4 5/6] loop: try to handle loop aio command via NOWAIT IO first
* [PATCH V4 6/6] loop: add hint for handling aio via IOCB_NOWAIT

and found the following issue:
WARNING in lo_submit_rw_aio

Full report is available here:
https://ci.syzbot.org/series/0ffdb6b4-a5fe-48da-9473-d2a926e780bd

***

WARNING in lo_submit_rw_aio

tree:      torvalds
URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux
base:      07e27ad16399afcd693be20211b0dfae63e0615f
arch:      amd64
compiler:  Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
config:    https://ci.syzbot.org/builds/3aba003b-2400-4e88-9a31-c09ab4e41a84/config
C repro:   https://ci.syzbot.org/findings/dc97454c-d87b-41f5-a44a-7182e666cfd5/c_repro
syz repro: https://ci.syzbot.org/findings/dc97454c-d87b-41f5-a44a-7182e666cfd5/syz_repro

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5958 at drivers/block/loop.c:907 loop_inc_blocking_writes drivers/block/loop.c:907 [inline]
WARNING: CPU: 0 PID: 5958 at drivers/block/loop.c:907 loop_queue_work+0xb3b/0xc30 drivers/block/loop.c:1005
Modules linked in:
CPU: 0 UID: 0 PID: 5958 Comm: udevd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
RIP: 0010:loop_inc_blocking_writes drivers/block/loop.c:907 [inline]
RIP: 0010:loop_queue_work+0xb3b/0xc30 drivers/block/loop.c:1005
Code: 33 bf 08 00 00 00 4c 89 ea e8 c1 89 7e fb 4c 89 f7 48 83 c4 30 5b 41 5c 41 5d 41 5e 41 5f 5d e9 cb 87 71 05 e8 26 36 b4 fb 90 <0f> 0b 90 e9 4e fe ff ff e8 18 36 b4 fb 48 83 c5 18 48 89 e8 48 c1
RSP: 0018:ffffc9000340ef38 EFLAGS: 00010093
RAX: ffffffff860b776a RBX: ffff88802187c000 RCX: ffff88810cee3980
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000681dc4 R12: ffff88802187c158
R13: ffff88802187c110 R14: ffff888021989460 R15: ffff888021989418
FS:  00007f649c5a4c80(0000) GS:ffff8880b8612000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056520d53f000 CR3: 0000000109e48000 CR4: 00000000000006f0
Call Trace:
 <TASK>
 lo_submit_rw_aio+0x493/0x620 drivers/block/loop.c:441
 lo_rw_aio_nowait drivers/block/loop.c:508 [inline]
 loop_queue_rq+0x64d/0x840 drivers/block/loop.c:2026
 __blk_mq_issue_directly block/blk-mq.c:2695 [inline]
 blk_mq_request_issue_directly+0x3c1/0x710 block/blk-mq.c:2782
 blk_mq_issue_direct+0x2a0/0x660 block/blk-mq.c:2803
 blk_mq_dispatch_queue_requests+0x621/0x800 block/blk-mq.c:2878
 blk_mq_flush_plug_list+0x432/0x550 block/blk-mq.c:2961
 __blk_flush_plug+0x3d3/0x4b0 block/blk-core.c:1220
 blk_finish_plug+0x5e/0x90 block/blk-core.c:1247
 read_pages+0x3b2/0x580 mm/readahead.c:173
 page_cache_ra_unbounded+0x6b0/0x7b0 mm/readahead.c:297
 do_page_cache_ra mm/readahead.c:327 [inline]
 force_page_cache_ra mm/readahead.c:356 [inline]
 page_cache_sync_ra+0x3b9/0xb10 mm/readahead.c:572
 filemap_get_pages+0x43c/0x1ea0 mm/filemap.c:2603
 filemap_read+0x3f6/0x11a0 mm/filemap.c:2712
 blkdev_read_iter+0x30a/0x440 block/fops.c:852
 new_sync_read fs/read_write.c:491 [inline]
 vfs_read+0x55a/0xa30 fs/read_write.c:572
 ksys_read+0x145/0x250 fs/read_write.c:715
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f649c116b6a
Code: 00 3d 00 00 41 00 75 0d 50 48 8d 3d 2d 08 0a 00 e8 ea 7d 01 00 31 c0 e9 07 ff ff ff 64 8b 04 25 18 00 00 00 85 c0 75 1b 0f 05 <48> 3d 00 f0 ff ff 76 6c 48 8b 15 8f a2 0d 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffd6597a888 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000040000 RCX: 00007f649c116b6a
RDX: 0000000000040000 RSI: 000056520d500438 RDI: 0000000000000009
RBP: 0000000000040000 R08: 000056520d500410 R09: 0000000000000010
R10: 0000000000004011 R11: 0000000000000246 R12: 000056520d500410
R13: 000056520d500428 R14: 000056520d3cf9c8 R15: 000056520d3cf970
 </TASK>


***

If these findings have caused you to resend the series or submit a
separate fix, please add the following tag to your commit message:
  Tested-by: syzbot@syzkaller.appspotmail.com

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.


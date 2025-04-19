Return-Path: <linux-fsdevel+bounces-46710-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9A9A9424E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 10:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F825441958
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Apr 2025 08:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 284BD1B0F20;
	Sat, 19 Apr 2025 08:36:23 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2881917A2F5
	for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745051782; cv=none; b=Mv6xW5rHq+2wwP1L9fu8+AY0oVJXolxGs2JWj+YzvcILXFD85xDiuT5yVEYAVQ71cIrfyUKVwA9NK6qCXJRmoDoOG7MaxSP72C7OZy/ebDjAcE27QyTHlmA2riu+vNW1/cGojB6+05cZ0eeB8CY13eJBiEpykwtz/5l8RA16eP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745051782; c=relaxed/simple;
	bh=2muuX7Ih62Wo7gja35Okue8CWnhgSewdoNusaP2V7P0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eICr1LZ8qZRdApH+eTu6/Bsrj0exf5ZpY4N0+pwsf5pAhO1NVTMMYtBFT8A0eNeXZJvD7arE9JKgwQfAfP7S+iJ54W1V5VAwrGx7b/3sDgFkcxLwhE/qCM5KxRFrqcsS7TvNHOZ3cp17d9UAia9RvsPQ3IvyvmOSXXMUWZg6Rf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d817cf6e72so23007745ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 19 Apr 2025 01:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745051780; x=1745656580;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viXqPNMRsD79f0RGNVXeE0kyOUVbU86j7clKbfA/SQM=;
        b=qVi3evRTZRU6o24m76yaKXB3HLDMhZqG/9BSvydKh3ND1SnWQQBTnPfaq332gLpGeY
         Ll8L8msJKZv7KRxrsrpnjEwBa1IrW1fNen/WPMtj3BheOzykMXWKqtocKZ+PNY3eVyI1
         ym/NfFr2GBkk+kB1yhf1ROXVNIHi7zS87mtnKtfSG5llPCr2QDz1HFMFTWc7dXyM0NLS
         +hJsFiLhNMdRpYr66/kFJeikj3mwHofHxgL3lF49uQ5OD3m3CqnaM3pSzvPtwQEglyvb
         f7/Ir6qLtmBvRlBs7/6kqjHzRh4m8Dyc570Vr9ZafllGGrvtnk+w39HMoxwDqnmLQnXv
         KRWQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL/5uDp04vbSjqAwLmAaQsmtiK+1NzZXVMubqdg5mhwoQnRrfqf7BAD77Q11GEmy3p7u6AgL0UESc/L8de@vger.kernel.org
X-Gm-Message-State: AOJu0Yzt2KTZBFDWsm1Xlx9w533Y6Wj4T4ficeQx7IJ/Wdh8jwKaIt5c
	PG9P/vpxFrJGRBVCHWcIhI0p/sFlvkzqQ6AQJpM2iNvwyYAZDGaxGwy1iZ1+Bee1JL30EQ9kG+a
	MF2ejcoKf/STLzoC2SMABpP3ir12AI/tGAnpW2t82mZPITKtjb7izGRI=
X-Google-Smtp-Source: AGHT+IHkH/wwUf5d8lEEpuJxnz3SCVRu5KO/+QNvaticspBogfzuSTTlnBcBEi4bqi+Aeol4UGA5h8ZFt1vmaZ6fdEINgQ1UFwDV
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b41:b0:3d5:890b:d9e1 with SMTP id
 e9e14a558f8ab-3d8b694907emr40125955ab.1.1745051780294; Sat, 19 Apr 2025
 01:36:20 -0700 (PDT)
Date: Sat, 19 Apr 2025 01:36:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68036084.050a0220.297747.0018.GAE@google.com>
Subject: [syzbot] [block?] [bcachefs?] kernel panic: KASAN: panic_on_warn set ...
From: syzbot <syzbot+4eb503ec2b8156835f24@syzkaller.appspotmail.com>
To: brauner@kernel.org, jack@suse.cz, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-block@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3088d26962e8 Merge tag 'x86-urgent-2025-04-18' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17aed470580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a31f7155996562
dashboard link: https://syzkaller.appspot.com/bug?extid=4eb503ec2b8156835f24
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-3088d269.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5ec84510bfc9/vmlinux-3088d269.xz
kernel image: https://storage.googleapis.com/syzbot-assets/af58d0bee0a4/bzImage-3088d269.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4eb503ec2b8156835f24@syzkaller.appspotmail.com

Kernel panic - not syncing: KASAN: panic_on_warn set ...
CPU: 0 UID: 0 PID: 47 Comm: kworker/u4:3 Not tainted 6.15.0-rc2-syzkaller-00400-g3088d26962e8 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: loop0 loop_workfn
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 panic+0x349/0x880 kernel/panic.c:354
 check_panic_on_warn+0x86/0xb0 kernel/panic.c:243
 end_report+0x77/0x160 mm/kasan/report.c:227
 kasan_report+0x154/0x180 mm/kasan/report.c:636
 check_region_inline mm/kasan/generic.c:-1 [inline]
 kasan_check_range+0x28f/0x2a0 mm/kasan/generic.c:189
 instrument_atomic_read_write include/linux/instrumented.h:96 [inline]
 atomic_dec include/linux/atomic/atomic-instrumented.h:592 [inline]
 put_bh include/linux/buffer_head.h:301 [inline]
 end_buffer_read_sync+0xc1/0xd0 fs/buffer.c:161
 end_bio_bh_io_sync+0xbf/0x120 fs/buffer.c:2748
 blk_update_request+0x5e5/0x1160 block/blk-mq.c:983
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1145
 lo_rw_aio_do_completion drivers/block/loop.c:317 [inline]
 lo_rw_aio_complete drivers/block/loop.c:325 [inline]
 lo_rw_aio+0xdfd/0xf80 drivers/block/loop.c:398
 do_req_filebacked drivers/block/loop.c:-1 [inline]
 loop_handle_cmd drivers/block/loop.c:1866 [inline]
 loop_process_work+0x8e3/0x11f0 drivers/block/loop.c:1901
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


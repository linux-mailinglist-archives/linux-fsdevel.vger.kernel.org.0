Return-Path: <linux-fsdevel+bounces-26359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B329D9583A1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 12:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 344C91F241E1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Aug 2024 10:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A088118C93B;
	Tue, 20 Aug 2024 10:07:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A0218C93A
	for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 10:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724148450; cv=none; b=aeAhLJer7gyKha87l9VacR0dQ6bF2AExCLWEf8LArf8DJEMfgBznc7MzVTDGIuHknWWUiZ1EZyO90pspcEzziqEvZSAteCNHCe+2wtHauy2WDq1nHkUEqa8l4Q6S6tgyZuXdJFjRy84p0qs50jB4j4p0hXSN0rK7/SN3w+Fg+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724148450; c=relaxed/simple;
	bh=oVvF/McOdfU3iVgHtG/wOM7DdHIFGU5GzGnuR8IbQm8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=im7w6lE8bpy1+9Z5YDEmsZqiCoFZgnwgWe25Tea/IqY7cexyMTMznjzu0OG0zwNghRW0uTOrri3uhN8mB+wnfIKBsb5RLM1Zotl3LdKCStqJ4vRZua8vUwC+SPhwbbuPWg6pEelp9b2zqmU0d3vRz7WlyOo/tsipqnj0zaYaf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-824c925d120so517802139f.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Aug 2024 03:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724148448; x=1724753248;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CXqZnoT89tCdn/rZ++yqUb0Wgp+4J8NF/884jAwy3LI=;
        b=JLpUWZePDyl4e6muVTyG5OVOF4Gle+UmUWyM286CttQ+5FPyrgNoTiZ89vJvzFyllX
         /wzJ1vjMLUvqgu0vOgd/IguS+NXS0lK2n8oNSbHaPQwlJLnylXGgg4MXKfy6dnEDc5UO
         +wCjFgfSdip+8oDSltMGLVILbOMBMfeqBPHDbEMAeXfkv763RexwcimREHuxX+uQJFpH
         njNks5pkIGBGwupYY/WcMoWqgPvR9FpHOnNbGfGEjsxU3xC7f+2uGnYREwnBwIGdxOVt
         Cag3+v20lNkjdVAs3QYkN0igte37t2PVD2MlWy14Y8pTaq8+gt76G1AaM95AQoOhv33e
         dBtA==
X-Forwarded-Encrypted: i=1; AJvYcCU3pUOJIy81terWhn2s3J7rb+Ln1IJxbTXtjtAQ6vYt1wuRn6Kt2YvrmTqhsGKQbHZcvFmMnq/azG53Qo+jNNPy9sXfmRBiFJ+p2jaJIw==
X-Gm-Message-State: AOJu0YwyKRyW+AsNjRakIT19cHJ9i8feedAye2wF3facBWY7Q8oNVvLJ
	pxzfdnFg4yYjRrz0Ly3ZP/uZVhrcm/MBbMySM3tTluPRDbAajb8X8qzLikDvMCHm6U9p4OVmQNH
	zQbIHUXmv/QzltSWrbsfqa01EhI1kkqcaZDmBI1Rl/48w05fCfh4bn80=
X-Google-Smtp-Source: AGHT+IE+/wCasVpl47ORO2tjgymEJodaQWpR5MmKZBp9AwVnmG6q+EkS4QCsdEkhY3wj/3jLe4f+IwMtv13VSmnAIi3GMZyWjy98
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12d4:b0:4ca:7128:6c70 with SMTP id
 8926c6da1cb9f-4cce1747d52mr903259173.6.1724148447690; Tue, 20 Aug 2024
 03:07:27 -0700 (PDT)
Date: Tue, 20 Aug 2024 03:07:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c3d5e806201a97ac@google.com>
Subject: [syzbot] [exfat?] KCSAN: data-race in dio_bio_end_io / dio_new_bio (3)
From: syzbot <syzbot+fed24898593bed518bec@syzkaller.appspotmail.com>
To: hirofumi@mail.parknet.co.jp, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6e4436539ae1 Merge tag 'hid-for-linus-2024081901' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110c8de5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3aa0f597417bf8c7
dashboard link: https://syzkaller.appspot.com/bug?extid=fed24898593bed518bec
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/72e87ae72e3c/disk-6e443653.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/226d5b10603c/vmlinux-6e443653.xz
kernel image: https://storage.googleapis.com/syzbot-assets/edaf634acf3f/bzImage-6e443653.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fed24898593bed518bec@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 8192
==================================================================
BUG: KCSAN: data-race in dio_bio_end_io / dio_new_bio

read-write to 0xffff888114c1e058 of 8 bytes by interrupt on cpu 1:
 dio_bio_end_io+0x53/0xd0 fs/direct-io.c:388
 bio_endio+0x369/0x410 block/bio.c:1646
 blk_update_request+0x382/0x880 block/blk-mq.c:925
 blk_mq_end_request+0x26/0x50 block/blk-mq.c:1053
 lo_complete_rq+0xce/0x180 drivers/block/loop.c:386
 blk_complete_reqs block/blk-mq.c:1128 [inline]
 blk_done_softirq+0x74/0xb0 block/blk-mq.c:1133
 handle_softirqs+0xc3/0x280 kernel/softirq.c:554
 run_ksoftirqd+0x1c/0x30 kernel/softirq.c:928
 smpboot_thread_fn+0x31c/0x4c0 kernel/smpboot.c:164
 kthread+0x1d1/0x210 kernel/kthread.c:389
 ret_from_fork+0x4b/0x60 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

read to 0xffff888114c1e058 of 8 bytes by task 3990 on cpu 0:
 dio_bio_reap fs/direct-io.c:551 [inline]
 dio_new_bio+0x249/0x460 fs/direct-io.c:670
 dio_send_cur_page+0x1f2/0x7a0 fs/direct-io.c:751
 submit_page_section+0x1a3/0x5b0 fs/direct-io.c:816
 do_direct_IO fs/direct-io.c:1031 [inline]
 __blockdev_direct_IO+0x11c1/0x1e90 fs/direct-io.c:1249
 blockdev_direct_IO include/linux/fs.h:3217 [inline]
 fat_direct_IO+0x110/0x1e0 fs/fat/inode.c:282
 generic_file_direct_write+0xaf/0x200 mm/filemap.c:3941
 __generic_file_write_iter+0xae/0x120 mm/filemap.c:4107
 generic_file_write_iter+0x7d/0x1d0 mm/filemap.c:4147
 do_iter_readv_writev+0x3b0/0x470
 vfs_writev+0x2e0/0x880 fs/read_write.c:971
 do_pwritev fs/read_write.c:1072 [inline]
 __do_sys_pwritev2 fs/read_write.c:1131 [inline]
 __se_sys_pwritev2+0x10c/0x1d0 fs/read_write.c:1122
 __x64_sys_pwritev2+0x78/0x90 fs/read_write.c:1122
 x64_sys_call+0x271f/0x2d60 arch/x86/include/generated/asm/syscalls_64.h:329
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

value changed: 0xffff8881151e8e40 -> 0xffff888114d5bd80

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 UID: 0 PID: 3990 Comm: syz.0.161 Not tainted 6.11.0-rc4-syzkaller-00008-g6e4436539ae1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
==================================================================


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


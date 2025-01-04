Return-Path: <linux-fsdevel+bounces-38376-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29AB5A011EC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 03:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B4A41883145
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Jan 2025 02:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3682878276;
	Sat,  4 Jan 2025 02:25:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38D83249F9
	for <linux-fsdevel@vger.kernel.org>; Sat,  4 Jan 2025 02:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735957524; cv=none; b=B12TEUIRDQjzuwR6fI8lcXCEV8YvitrpTz7RRQdH79ISyEV8dgNLAgN+DM9ZkwNlboojUv6jbgwe61J/aOy3Qcxcdiko2VJ0P0gosvcqnns9uJDfpI3269Xs7qi/nZq+3LuvWU97C55DLO0mKvpcJ/OpeK1ZrI1O+WwQp9iGlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735957524; c=relaxed/simple;
	bh=9ZDyRXP0PeqkGT9dbw3DJ8lg/X/Icf/YDuAuDrMiwLU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rkpodzJWT5OS8c3iyem8/I1/aU+2oz6ZrJhg+bocRmZwRdBtB6aMNZXeWqgx80VKvEfGGC+UTyLJkiKFdGnkV2R2XOdV1EyWP5WfIOBEy3uQGptUCnGatQNZPJfNriV4Grc5s39yxuI7F7QDDLoY+0+tFJ9Yl1mEzPs0C2NMKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-844d02766f9so1092329039f.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Jan 2025 18:25:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735957522; x=1736562322;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0CWO+yDr+ffCG2eM2Y9qci19DwnJM+3GKncnHIIWySs=;
        b=F+N4aVy2GSlmSY9ESk5ssXjBQ++EFepUrsZueMoIlVHzk7eTomuOHrjvUAzv26eWqi
         Uo9hHKRVWlp1daLRtV54PrhX2Y4TMOQ4fzP9wm9wZqzxfwlvriMtYDOG0ccLAx67MMcV
         HCd2prYX1CscN0ub/E3oCf7z+djrJ6Up86/QGHBRoTPU24LZdtLKnWxgcHTBx8Kr2EJ4
         0Oz0qdUigZTFNXJBgtCZAn5u9Lsuhfv7qJRof79k6hK5oouLIb83Q7ZCACxv0jhaJAAI
         +iiKKzhw5xek3PwbeXih1GYpWhkcKrmE2pNdgt1W3agVlMuWOocmMWExKnoTvjc8X7+J
         ICng==
X-Gm-Message-State: AOJu0YzxLDArsBJK77hLnRfcdawp7Ct59Egvvyavx0uRO6/v6di3yKJT
	GLwaQK9am5xR81KcLyCo9YAM9F16/AGZCgc4/IsJwmqnKl09dsAfuaYQjQo+vJrXgE5PcT9MIo7
	DsRibKsstfnyGWeOVXV5SbO5DwzzlZzC+N4bGLxtMb1a+9QM5I9qC2oZvvQ==
X-Google-Smtp-Source: AGHT+IFtAHBCDJ+PoL9k6ksv6YIP8WvND6n5SoG1x+MptbPHXoMKawMywDrqpl1N/IJSUgzLJW4tNomGcXDxFuCnLI/YpEV0o4By
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3d07:b0:3a7:99a5:a207 with SMTP id
 e9e14a558f8ab-3c2d17bececmr432323525ab.5.1735957522435; Fri, 03 Jan 2025
 18:25:22 -0800 (PST)
Date: Fri, 03 Jan 2025 18:25:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67789c12.050a0220.3b53b0.0043.GAE@google.com>
Subject: [syzbot] [hfs?] WARNING in check_flush_dependency (3)
From: syzbot <syzbot+3d1442173e1be9889481@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8155b4ef3466 Add linux-next specific files for 20241220
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11df6ac4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c90bb7161a56c88
dashboard link: https://syzkaller.appspot.com/bug?extid=3d1442173e1be9889481
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/98a974fc662d/disk-8155b4ef.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2dea9b72f624/vmlinux-8155b4ef.xz
kernel image: https://storage.googleapis.com/syzbot-assets/593a42b9eb34/bzImage-8155b4ef.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3d1442173e1be9889481@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: WQ_MEM_RECLAIM dio/loop6:dio_aio_complete_work is flushing !WQ_MEM_RECLAIM events_long:flush_mdb
WARNING: CPU: 1 PID: 51 at kernel/workqueue.c:3712 check_flush_dependency+0x329/0x3c0 kernel/workqueue.c:3708
Modules linked in:
CPU: 1 UID: 0 PID: 51 Comm: kworker/1:1 Not tainted 6.13.0-rc3-next-20241220-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: dio/loop6 dio_aio_complete_work
RIP: 0010:check_flush_dependency+0x329/0x3c0 kernel/workqueue.c:3708
Code: 08 4c 89 f7 e8 e8 f6 9d 00 49 8b 16 49 81 c4 78 01 00 00 48 c7 c7 20 d6 09 8c 4c 89 ee 4c 89 e1 4c 8b 04 24 e8 38 3f f8 ff 90 <0f> 0b 90 90 e9 4a ff ff ff 89 d9 80 e1 07 80 c1 03 38 c1 0f 8c 09
RSP: 0018:ffffc90000bb77c0 EFLAGS: 00010046
RAX: 5c710a1b8e2d3500 RBX: ffff88802f455808 RCX: ffff88801e6a5a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000008 R08: ffffffff817feaa2 R09: 1ffffffff1d026d4
R10: dffffc0000000000 R11: fffffbfff1d026d5 R12: ffff88801ac81578
R13: ffff88807c52d178 R14: ffff888020699018 R15: ffff888020699020
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000005632e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 start_flush_work kernel/workqueue.c:4162 [inline]
 __flush_work+0x286/0xc60 kernel/workqueue.c:4199
 flush_work kernel/workqueue.c:4256 [inline]
 flush_delayed_work+0x169/0x1c0 kernel/workqueue.c:4278
 hfs_file_fsync+0xea/0x140 fs/hfs/inode.c:680
 generic_write_sync include/linux/fs.h:2952 [inline]
 dio_complete+0x55c/0x6b0 fs/direct-io.c:313
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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


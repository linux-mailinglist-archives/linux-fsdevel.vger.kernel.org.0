Return-Path: <linux-fsdevel+bounces-31836-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A677F99BFCF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 08:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 173B61F223D6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 06:10:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BE7613DDD3;
	Mon, 14 Oct 2024 06:10:31 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FE82D600
	for <linux-fsdevel@vger.kernel.org>; Mon, 14 Oct 2024 06:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728886231; cv=none; b=kgAMP4IT8A9K13MmWjqz5WSsdVnX9RCxtf88ilTN1gow8cMx8jDz8Ii1akfCaoQ+dKT6J+QQv6d0OiMgy1amWvK7b+Ee734wFJtYQ7z8g2OGwn4iAuY2C8fq+ISX4Neh2e8MJSFnMLltrZYLrnga2eB0zzqOVxUdnFgARrVuud8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728886231; c=relaxed/simple;
	bh=do0VxF7OqQ6ake4Ma2eDjCtwPUt1cvw4UHN2k71Uk8M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DSx+iGSAL2JXC8xQKxGz6gIs2A/ZCegYFMp6SzSIsVvhCImw156q08AT6c0NKMV8rhthK+iS+yn+r5yYO5+ubyR99XKAuHAzIhNT8js8IuubscMnI8ifOYtwvAOaHE3PvNxmnVRFutqCVhvILusQbdsZVioWP6cWqMO2phg5f6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3bcae85a5so12391405ab.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 13 Oct 2024 23:10:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728886228; x=1729491028;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TPfhhO5qUG9J5CacmHWLOTkZYLLMWoOolVBwmexxbAo=;
        b=HrOjEFfbVJCzUX0whCu4Vmtz0XmCRgXfkrbi0X6UzkTwCAc8naE7x8BoOOHHdmvU/0
         mOH/USZuPMC9lZYlTez8kdNbQnbkr6iEHuVrXHlRO5Gshmpw/kgYncj9dx84mnJHgg8i
         dtKqHJ4tppU7iguq1QDkcjdLIKmv4nrowKHbVsEHqfRVGEb1gWUYX7c0BPJLIk+uC22G
         IPX8ZkeVDxBXX5LY+tp/W/KQ/F6JOXQUqUDUPRZh3p9bJ1sjJcO+M6KHVJfezAvV61Y/
         JbRW6kM3btbznmFLJAH6FnfuzCR+3xTIamLTcvSrvBmjITdRR/y7xM+5wlzCJWAkxAlv
         +M/g==
X-Forwarded-Encrypted: i=1; AJvYcCVHruhWFcdOJQyFK4HjeupuabfekeJ5NCg0mZUeeIO+eP36YoRQXNDtDjrMRx+u2JIqMPT3O7KQY2VG9FDo@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6m9tY3nL1d/yHHlnhkoxcLFtwHC01pVucw/eM9coeJ1s2gxEv
	GU+EMWbrxBn3HXzsfqPbJPihPa+dizXzma05vAQPbRReL/8r7O90e1+O08dcn/4An8btuEMgf8H
	Q/wvNUTRXlwQ/Mlcio7TiU02lVssVZbygjOtCSe7qIovdG/UlnQYkKkI=
X-Google-Smtp-Source: AGHT+IFApPwVNettqVx2RNTBBzNIzdL6X9KJnsnP2BNNDCvJzplW4pmK1ALW9Kfvozlx/dcq9OMvSBFxgy39Ng6Sm07ptCY7cMxW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26c:0:b0:3a0:8e7c:b4ae with SMTP id
 e9e14a558f8ab-3a3b5844ab8mr75164165ab.2.1728886228400; Sun, 13 Oct 2024
 23:10:28 -0700 (PDT)
Date: Sun, 13 Oct 2024 23:10:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <670cb5d4.050a0220.3e960.0054.GAE@google.com>
Subject: [syzbot] [netfs?] general protection fault in netfs_write_collection_worker
From: syzbot <syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com>
To: dhowells@redhat.com, jlayton@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netfs@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' of..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136ae580580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b5201b91035a876
dashboard link: https://syzkaller.appspot.com/bug?extid=af5c06208fa71bf31b16
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-e32cde8d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8759dd370e1/vmlinux-e32cde8d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c770fb4b8507/bzImage-e32cde8d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+af5c06208fa71bf31b16@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
CPU: 0 UID: 0 PID: 1109 Comm: kworker/u32:8 Not tainted 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound netfs_write_collection_worker
RIP: 0010:folioq_folio include/linux/folio_queue.h:277 [inline]
RIP: 0010:netfs_writeback_unlock_folios fs/netfs/write_collect.c:107 [inline]
RIP: 0010:netfs_collect_write_results fs/netfs/write_collect.c:493 [inline]
RIP: 0010:netfs_write_collection_worker+0x1c97/0x4780 fs/netfs/write_collect.c:551
Code: 4c 39 fb 0f 83 25 04 00 00 e8 e5 94 54 ff 44 8b 2c 24 41 83 fd 1e 0f 87 77 23 00 00 4a 8d 44 ed 08 48 89 44 24 30 48 c1 e8 03 <42> 80 3c 30 00 0f 85 4f 23 00 00 4a 8b 5c ed 08 48 89 df e8 d1 da
RSP: 0018:ffffc90005d6fae8 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff8238f165
RDX: ffff888026c4a440 RSI: ffffffff8238f40b RDI: 0000000000000005
RBP: 0000000000000000 R08: ffff88805f4fc600 R09: 000000000000001e
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000002c
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88805f4fc5fa
FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055960e035c38 CR3: 0000000056af8000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:folioq_folio include/linux/folio_queue.h:277 [inline]
RIP: 0010:netfs_writeback_unlock_folios fs/netfs/write_collect.c:107 [inline]
RIP: 0010:netfs_collect_write_results fs/netfs/write_collect.c:493 [inline]
RIP: 0010:netfs_write_collection_worker+0x1c97/0x4780 fs/netfs/write_collect.c:551
Code: 4c 39 fb 0f 83 25 04 00 00 e8 e5 94 54 ff 44 8b 2c 24 41 83 fd 1e 0f 87 77 23 00 00 4a 8d 44 ed 08 48 89 44 24 30 48 c1 e8 03 <42> 80 3c 30 00 0f 85 4f 23 00 00 4a 8b 5c ed 08 48 89 df e8 d1 da
RSP: 0018:ffffc90005d6fae8 EFLAGS: 00010202
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff8238f165
RDX: ffff888026c4a440 RSI: ffffffff8238f40b RDI: 0000000000000005
RBP: 0000000000000000 R08: ffff88805f4fc600 R09: 000000000000001e
R10: 0000000000000000 R11: 0000000000000000 R12: 000000000000002c
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88805f4fc5fa
FS:  0000000000000000(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f989f7fd870 CR3: 000000000df7c000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	4c 39 fb             	cmp    %r15,%rbx
   3:	0f 83 25 04 00 00    	jae    0x42e
   9:	e8 e5 94 54 ff       	call   0xff5494f3
   e:	44 8b 2c 24          	mov    (%rsp),%r13d
  12:	41 83 fd 1e          	cmp    $0x1e,%r13d
  16:	0f 87 77 23 00 00    	ja     0x2393
  1c:	4a 8d 44 ed 08       	lea    0x8(%rbp,%r13,8),%rax
  21:	48 89 44 24 30       	mov    %rax,0x30(%rsp)
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1) <-- trapping instruction
  2f:	0f 85 4f 23 00 00    	jne    0x2384
  35:	4a 8b 5c ed 08       	mov    0x8(%rbp,%r13,8),%rbx
  3a:	48 89 df             	mov    %rbx,%rdi
  3d:	e8                   	.byte 0xe8
  3e:	d1 da                	rcr    %edx


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


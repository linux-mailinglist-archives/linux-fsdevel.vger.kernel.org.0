Return-Path: <linux-fsdevel+bounces-803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 424A57D059B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 01:56:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C46D7B21384
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Oct 2023 23:55:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9189347343;
	Thu, 19 Oct 2023 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5140B321AA
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 23:55:53 +0000 (UTC)
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51CF012F
	for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 16:55:51 -0700 (PDT)
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-6c660a0f0e8so356274a34.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Oct 2023 16:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697759750; x=1698364550;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uWSEJ9xYUbBy9cya3rocEpazxIwASpRVIWUfmU2j3cg=;
        b=HgcOZIn2i2XQ2lygOiTw4zmt0F/lMvPdDKPhcQM/ddvJqtxX9oMplonIdDzy8NSpLn
         TdU9MYScJOuzZHqj2FjX1K4TpYTEl9c7C3iSuVNyBJB/CvtS0dNtA88q7wJtN8nLZhS4
         q33MHf6+hEy999gT65xwiuN51TGJdNQZwDl5V9AZJNGLqV9pYlqyHYYWp+iE9DWifq2g
         4NiNurQFVnLqI8JWSjMgygW3oI6a7yiEXHyIeYSyaf/r+I91yhcXvAiLu8/TKCQPUYC7
         SKPL+6CrLnp6zKudXQ5PXo9G4PWp81OhRguPT5AygnHZJXFhg4hMe8skZ+j5JDVh5uLe
         2ZXQ==
X-Gm-Message-State: AOJu0YwKWWXxdj2wljkmzGfN/r1nw1rvrr1zqE3kcQpORKrcqkHDxKVj
	roeJgCzwL5wR/kJ9nyVIuK9fuxUGcz5UuLC/8kL76I7vBo7D
X-Google-Smtp-Source: AGHT+IHDp+QRpTSXHAcCvBFlVlpv+f4IueDYjCTJbN2MkjKh0HDR371FxFBBYf9bJ1/GU7TLewxDySYgN7G3P+ho725Ufj7j0low
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a9d:7518:0:b0:6b9:5156:a493 with SMTP id
 r24-20020a9d7518000000b006b95156a493mr57782otk.4.1697759750681; Thu, 19 Oct
 2023 16:55:50 -0700 (PDT)
Date: Thu, 19 Oct 2023 16:55:50 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000da80e106081a7eed@google.com>
Subject: [syzbot] [btrfs?] WARNING: refcount bug in btrfs_evict_inode (2)
From: syzbot <syzbot+3968e6b73153451563ef@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, josef@toxicpanda.com, 
	linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9a3dad63edbe Merge tag '6.6-rc5-ksmbd-server-fixes' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=126116e5680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=11e478e28144788c
dashboard link: https://syzkaller.appspot.com/bug?extid=3968e6b73153451563ef
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139d2f55680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/33c965444183/disk-9a3dad63.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/337f5c485902/vmlinux-9a3dad63.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4c5f5b84773a/bzImage-9a3dad63.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/263d3fb612d5/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3968e6b73153451563ef@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: underflow; use-after-free.
WARNING: CPU: 1 PID: 5068 at lib/refcount.c:28 refcount_warn_saturate+0x144/0x1b0 lib/refcount.c:28
Modules linked in:
CPU: 1 PID: 5068 Comm: syz-executor.4 Not tainted 6.6.0-rc5-syzkaller-00267-g9a3dad63edbe #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/06/2023
RIP: 0010:refcount_warn_saturate+0x144/0x1b0 lib/refcount.c:28
Code: 0a 01 48 c7 c7 a0 30 59 8b e8 98 97 15 fd 0f 0b eb a9 e8 cf 74 4f fd c6 05 64 cc 46 0a 01 48 c7 c7 00 31 59 8b e8 7c 97 15 fd <0f> 0b eb 8d e8 b3 74 4f fd c6 05 45 cc 46 0a 01 48 c7 c7 40 30 59
RSP: 0018:ffffc9000410f9c8 EFLAGS: 00010246
RAX: 87d3e0a2fce9e500 RBX: ffff8880283d7108 RCX: ffff88807b601dc0
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000003 R08: ffffffff81543302 R09: 1ffff1101732516a
R10: dffffc0000000000 R11: ffffed101732516b R12: ffff888027e3c000
R13: 0000000000000000 R14: ffff8880793fa1fe R15: 1ffff1100d13240f
FS:  0000555555d3f480(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555555d48938 CR3: 000000002a44c000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 btrfs_evict_inode+0x724/0x1000 fs/btrfs/inode.c:5305
 evict+0x2a4/0x620 fs/inode.c:664
 dispose_list fs/inode.c:697 [inline]
 evict_inodes+0x5f8/0x690 fs/inode.c:747
 generic_shutdown_super+0x9d/0x2c0 fs/super.c:672
 kill_anon_super+0x3b/0x70 fs/super.c:1292
 btrfs_kill_super+0x41/0x50 fs/btrfs/super.c:2144
 deactivate_locked_super+0xa4/0x110 fs/super.c:481
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1254
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 resume_user_mode_work include/linux/resume_user_mode.h:49 [inline]
 exit_to_user_mode_loop+0xde/0x100 kernel/entry/common.c:171
 exit_to_user_mode_prepare+0xb1/0x140 kernel/entry/common.c:204
 __syscall_exit_to_user_mode_work kernel/entry/common.c:285 [inline]
 syscall_exit_to_user_mode+0x64/0x280 kernel/entry/common.c:296
 do_syscall_64+0x4d/0xc0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fdf2aa7de17
Code: b0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 0f 1f 44 00 00 31 f6 e9 09 00 00 00 66 0f 1f 84 00 00 00 00 00 b8 a6 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 01 c3 48 c7 c2 b0 ff ff ff f7 d8 64 89 02 b8
RSP: 002b:00007fff45f80ce8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a6
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 00007fdf2aa7de17
RDX: 0000000000000000 RSI: 000000000000000a RDI: 00007fff45f80da0
RBP: 00007fff45f80da0 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000ffffffff R11: 0000000000000246 R12: 00007fff45f81e60
R13: 00007fdf2aac73b9 R14: 000000000006a985 R15: 0000000000000003
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


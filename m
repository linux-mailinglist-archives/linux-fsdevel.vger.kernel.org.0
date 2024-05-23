Return-Path: <linux-fsdevel+bounces-20042-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E15AA8CCFFD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 12:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7C62820A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 10:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF59F13E3EC;
	Thu, 23 May 2024 10:09:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D5F54FA9
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 10:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458968; cv=none; b=QmtmgFvteJFd42Iujmtq9KSD79tbi12KnFvIk+3Iq9H78VEWa2vPFGozdTLupP/iS3C2JydYMSG3unV56mq+R0ci34xtCup+Bae+cf9znhNndqvComEtNAvXGwDGp9NcNzZQgr9gjHaLqUEKh20YaRcyYZqAF1kRgvdKnsDQ8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458968; c=relaxed/simple;
	bh=leIna1Saims9f0MJ61i/z8223fXhgYAjFrM+TRHR1rM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=V/MG4nuHSinMuiBBSuTOLlnsCzMf5IEAJO41Ee4TD6cpE0Sr9Xtsz+BlUX6zwwLHke2eUyvFGE2bgGSsy0aksdRluq+FMi8UxsdJJJ4gcFWStuFVuhTxPscPqpCngQ368I9G7/mtbqhwwMP13ymPG6hnNgwzGSmIuX/yGxNe1eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-36d98ad0c7eso18071095ab.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 03:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458966; x=1717063766;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QCqCCElupnhUJXA4EpZyUcc/f0DGtU0UeYDsUY02AB8=;
        b=H2HsvxtnM1hsq9uBVsezdha6eeWYHgnAhBUTkw6tI/40c1iSAD9IAVYT9ZnLTVYdF6
         mWacuA4xbxf5AIMXgz9yiZVDtYiSx5EyPNd+40SHxlYSAvfOsG1LXRjYw723ARMTisCE
         yK/qrFvZe+AT/Oxuk+jereTFMV39M3bEKukPO08FqzPSWjF/m0tLSwTH25SPTnK6Mbs7
         2eheCn9ybCXUzK6IVZcoCkEsU74Can/spB3TwQz/38/FGKI6kn0geNKLgLVwwIG1OxmB
         izNbwCihWz+i17HzqE8I0smyBodSaK3Tx0Dpfow62ygU6nC2Fme47JO4H5agNkqfgDNL
         PFmA==
X-Forwarded-Encrypted: i=1; AJvYcCV3FgolKQxKVtr3LuPWhWzIcrhNDoMKDJHnBNZwm1N6/+fQz6UUjTA0gqsgs4v/0fI7ouaHF7UIghLpO1y2tSW0Uee7PJZkWtxWXE+8aQ==
X-Gm-Message-State: AOJu0YyWOxIhi8LIH+dd7p6xVh5knH5CUM3DE17P5mwio2HPAfyDWUbX
	a198X+QmlSCMfAzZRs8dcUW+63Q5pyCUjH5mheBT+3kcblFhSqzVE2pkEAuJKOXSGNQqOj9jYiA
	NX6kc1pFiMv+W4Hu2qpIEerU4VBgbGDXEXn8A8TqgydrSBX6VJO9LB/s=
X-Google-Smtp-Source: AGHT+IHU78f9v5ktH4xFXr2K10+J6jztEmGBuNK7W2k1ERjgdEEOToGlFkpOBOaWjP9HahGhxnh4PkfEt1isRbp1KZaCcvU2luAW
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2188:b0:36d:cccb:6842 with SMTP id
 e9e14a558f8ab-371f3e40d12mr3977105ab.0.1716458966380; Thu, 23 May 2024
 03:09:26 -0700 (PDT)
Date: Thu, 23 May 2024 03:09:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f6865106191c3e58@google.com>
Subject: [syzbot] [btrfs?] [overlayfs?] possible deadlock in ovl_copy_up_flags
From: syzbot <syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com>
To: amir73il@gmail.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	jack@suse.cz, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, mszeredi@redhat.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c75962170e49 Add linux-next specific files for 20240517
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1438a5cc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fba88766130220e8
dashboard link: https://syzkaller.appspot.com/bug?extid=85e58cdf5b3136471d4b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=115f3e58980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14f4c97c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/21696f8048a3/disk-c7596217.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b8c71f928633/vmlinux-c7596217.xz
kernel image: https://storage.googleapis.com/syzbot-assets/350bfc6c0a6a/bzImage-c7596217.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/7f6a8434331c/mount_0.gz

The issue was bisected to:

commit 9a87907de3597a339cc129229d1a20bc7365ea5f
Author: Miklos Szeredi <mszeredi@redhat.com>
Date:   Thu May 2 18:35:57 2024 +0000

    ovl: implement tmpfile

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=120f89cc980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=110f89cc980000
console output: https://syzkaller.appspot.com/x/log.txt?x=160f89cc980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+85e58cdf5b3136471d4b@syzkaller.appspotmail.com
Fixes: 9a87907de359 ("ovl: implement tmpfile")

============================================
WARNING: possible recursive locking detected
6.9.0-next-20240517-syzkaller #0 Not tainted
--------------------------------------------
syz-executor489/5091 is trying to acquire lock:
ffff88802f7f2420 (sb_writers#4){.+.+}-{0:0}, at: ovl_do_copy_up fs/overlayfs/copy_up.c:967 [inline]
ffff88802f7f2420 (sb_writers#4){.+.+}-{0:0}, at: ovl_copy_up_one fs/overlayfs/copy_up.c:1168 [inline]
ffff88802f7f2420 (sb_writers#4){.+.+}-{0:0}, at: ovl_copy_up_flags+0x1110/0x4470 fs/overlayfs/copy_up.c:1223

but task is already holding lock:
ffff88802f7f2420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(sb_writers#4);
  lock(sb_writers#4);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor489/5091:
 #0: ffff8880241fe420 (sb_writers#9){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #1: ffff88802f7f2420 (sb_writers#4){.+.+}-{0:0}, at: mnt_want_write+0x3f/0x90 fs/namespace.c:409
 #2: ffff88807f0ea808 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:657 [inline]
 #2: ffff88807f0ea808 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_copy_up_start+0x53/0x310 fs/overlayfs/util.c:719

stack backtrace:
CPU: 1 PID: 5091 Comm: syz-executor489 Not tainted 6.9.0-next-20240517-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
 __sb_start_write include/linux/fs.h:1655 [inline]
 sb_start_write include/linux/fs.h:1791 [inline]
 ovl_start_write+0x11d/0x290 fs/overlayfs/util.c:31
 ovl_do_copy_up fs/overlayfs/copy_up.c:967 [inline]
 ovl_copy_up_one fs/overlayfs/copy_up.c:1168 [inline]
 ovl_copy_up_flags+0x1110/0x4470 fs/overlayfs/copy_up.c:1223
 ovl_create_tmpfile fs/overlayfs/dir.c:1317 [inline]
 ovl_tmpfile+0x262/0x6d0 fs/overlayfs/dir.c:1373
 vfs_tmpfile+0x396/0x510 fs/namei.c:3701
 do_tmpfile+0x156/0x340 fs/namei.c:3764
 path_openat+0x2ab8/0x3280 fs/namei.c:3798
 do_filp_open+0x235/0x490 fs/namei.c:3834
 do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
 do_sys_open fs/open.c:1420 [inline]
 __do_sys_open fs/open.c:1428 [inline]
 __se_sys_open fs/open.c:1424 [inline]
 __x64_sys_open+0x225/0x270 fs/open.c:1424
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fab92feaba9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd714aed18 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007fab92feaba9
RDX: 0000000000000000 RSI: 0000000000410202 RDI: 0000000020000040
RBP: 00007fab930635f0 R08: 000055557e7894c0 R09: 000055557e7894c0
R10: 000055557e7894c0 R11: 0000000000000246 R12: 00007ffd714aed40
R13: 00007ffd714aef68 R14: 431bde82d7b634db R15: 00007fab9303303b
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


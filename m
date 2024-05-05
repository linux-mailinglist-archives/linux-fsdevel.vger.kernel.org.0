Return-Path: <linux-fsdevel+bounces-18767-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE8E8BC301
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 20:25:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46503B20F97
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 May 2024 18:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D678E6CDC0;
	Sun,  5 May 2024 18:25:43 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB666B5E
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 May 2024 18:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714933543; cv=none; b=FoNgtX+bqtnPvAwL5k20ju4dFNvjd4seOrvGte77dfGnxB4h9QcQ6ZiHYfmoMwRq6xb5PuIQt5AihE1mjjt/NhflM3nSXgTzMwkG3XRmwbW4+bkKAojiF0QqNeuEF6FL9zn1z9IJRVNLuKYuDSXWpXvstz/jiAMjuCRvdAaPNU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714933543; c=relaxed/simple;
	bh=NYKyYEu/7lseytFA5e/boCGoX0xT3Ah3F/JRcRuUuBY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SNIApp+1srxCni3YnxLZveLxggqMa2UwGuG0HCnKJaVHqsK7PSBAOFBTdDqTjFsdqyrY04YOiTluvxnFyn7LR/YKZmDXh8EFA3H6iE80Ucl21vVvT2NN1hRgjmaaAeRcmPwqG/QbLSFs4Fn/z4u5Fi+70DosxQA5D6icS5c5SzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-36c96503424so3497985ab.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 05 May 2024 11:25:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714933541; x=1715538341;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEtJyfEmamFxD+SWoERpmk2jFMaVBH8IGlwow7gWw8s=;
        b=TK+USCwD8TbMfk34Al7D90ZQuUIkRaaRIqOTOMeqOKdoGFY1N/2GMbiWdSAqgkKCiA
         GU+T0xJ5UzlLliKH1mX5+JhRJa4GWkJM60H54L3phJA8e2nJ1mni6tPDSbvxhAlvg7+g
         Nilcd1BPZEmhs41lvQKjckGjdudmZrBupdq17CuLytWNp2sYNOwsjfG3mIZG7mOaOiG3
         V1TGcM98fBL/1PdlLjnjvikDNfrohykh1cTBFdQ84sTFnwJ6cdwrLXoLyU2HmMz0NlGy
         RdGMTbuHP4E6XkjnPfqkblFslKUO6hahtEvtILtN+jqKrd5EctjKG4vxB/CDhK/Ttq5t
         +IXg==
X-Forwarded-Encrypted: i=1; AJvYcCVWzjHgR9k/cG9EIieJFFghQKcVI6CAqr7jqghOfnx8H8VeC3fl8npuJ/lT2k6bSZLGHYuGF/HzYDS2d98xROopyKuAOIfirqTZxmalnw==
X-Gm-Message-State: AOJu0YwIPRN/IeSk1+m74Vy+BPM+x2JKYf4gZdMgQ8u2BqbEhnUUaQQo
	4PT7WtyeU5PlLJHl9dAYtkE5GHOmW8cAg72XpzjDeP4YIKQB6ugdmi6XRpFoNGzJXXgvow299zA
	jNqZ2TN/5xVK8fzTEuEV/VQaf3zddu2dqY4Y8TSm8NutrupgwN2mFhbk=
X-Google-Smtp-Source: AGHT+IHYg1j+M0cG78YVRANgQ3648Y2qDWuLxLIZMt7nUHQKLHJDxhwKfsCZERicqSxpqq/TPuQhY1/NTfF30lITgBWNSZsXyMep
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d84:b0:36b:f8:e87e with SMTP id
 h4-20020a056e021d8400b0036b00f8e87emr638066ila.1.1714933541202; Sun, 05 May
 2024 11:25:41 -0700 (PDT)
Date: Sun, 05 May 2024 11:25:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000897f760617b91491@google.com>
Subject: [syzbot] [bcachefs?] [ext4?] WARNING: suspicious RCU usage in bch2_fs_quota_read
From: syzbot <syzbot+a3a9a61224ed3b7f0010@syzkaller.appspotmail.com>
To: bfoster@redhat.com, kent.overstreet@linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7367539ad4b0 Merge tag 'cxl-fixes-6.9-rc7' of git://git.ke..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=131bb31f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2f00edef461175
dashboard link: https://syzkaller.appspot.com/bug?extid=a3a9a61224ed3b7f0010
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12376338980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16047450980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/03bd77f8af70/disk-7367539a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eb03a61f9582/vmlinux-7367539a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4c5c654b571/bzImage-7367539a.xz
mounted in repro #1: https://storage.googleapis.com/syzbot-assets/2f53f765589d/mount_0.gz
mounted in repro #2: https://storage.googleapis.com/syzbot-assets/c67fedea43c0/mount_1.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a3a9a61224ed3b7f0010@syzkaller.appspotmail.com

bcachefs (loop0): mounting version 1.7: mi_btree_bitmap opts=compression=lz4,prjquota,nodiscard,norecovery,nojournal_transaction_names
bcachefs (loop0): recovering from clean shutdown, journal seq 7
bcachefs (loop0): alloc_read... done
bcachefs (loop0): stripes_read... done
bcachefs (loop0): snapshots_read... done
bcachefs (loop0): reading quotas
=============================
WARNING: suspicious RCU usage
6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0 Not tainted
-----------------------------
fs/bcachefs/snapshot.h:45 suspicious rcu_dereference_check() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
4 locks held by syz-executor879/5077:
 #0: ffff888074000278 (&c->state_lock){+.+.}-{3:3}, at: bch2_fs_start+0x45/0x5b0 fs/bcachefs/super.c:1013
 #1: ffff888074004250 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #1: ffff888074004250 (&c->btree_trans_barrier){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:215 [inline]
 #1: ffff888074004250 (&c->btree_trans_barrier){.+.+}-{0:0}, at: __bch2_trans_get+0x8c8/0xc90 fs/bcachefs/btree_iter.c:3069
 #2: ffff88802c42d070 (&dev->mutex){....}-{3:3}, at: six_trylock_type fs/bcachefs/six.h:207 [inline]
 #2: ffff88802c42d070 (&dev->mutex){....}-{3:3}, at: btree_node_lock fs/bcachefs/btree_locking.h:266 [inline]
 #2: ffff88802c42d070 (&dev->mutex){....}-{3:3}, at: btree_path_lock_root fs/bcachefs/btree_iter.c:760 [inline]
 #2: ffff88802c42d070 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_one+0xa85/0x3250 fs/bcachefs/btree_iter.c:1178
 #3: ffff88801bef8870 (&dev->mutex){....}-{3:3}, at: six_trylock_type fs/bcachefs/six.h:207 [inline]
 #3: ffff88801bef8870 (&dev->mutex){....}-{3:3}, at: btree_node_lock fs/bcachefs/btree_locking.h:266 [inline]
 #3: ffff88801bef8870 (&dev->mutex){....}-{3:3}, at: btree_path_lock_root fs/bcachefs/btree_iter.c:760 [inline]
 #3: ffff88801bef8870 (&dev->mutex){....}-{3:3}, at: bch2_btree_path_traverse_one+0xa85/0x3250 fs/bcachefs/btree_iter.c:1178

stack backtrace:
CPU: 0 PID: 5077 Comm: syz-executor879 Not tainted 6.9.0-rc6-syzkaller-00234-g7367539ad4b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 snapshot_t fs/bcachefs/snapshot.h:45 [inline]
 bch2_fs_quota_read_inode fs/bcachefs/quota.c:567 [inline]
 bch2_fs_quota_read+0x195e/0x2770 fs/bcachefs/quota.c:613
 bch2_fs_recovery+0x4b25/0x6390 fs/bcachefs/recovery.c:828
 bch2_fs_start+0x356/0x5b0 fs/bcachefs/super.c:1043
 bch2_fs_open+0xa8d/0xdf0 fs/bcachefs/super.c:2102
 bch2_mount+0x71d/0x1320 fs/bcachefs/fs.c:1903
 legacy_get_tree+0xee/0x190 fs/fs_context.c:662
 vfs_get_tree+0x90/0x2a0 fs/super.c:1779
 do_new_mount+0x2be/0xb40 fs/namespace.c:3352
 do_mount fs/namespace.c:3692 [inline]
 __do_sys_mount fs/namespace.c:3898 [inline]
 __se_sys_mount+0x2d9/0x3c0 fs/namespace.c:3875
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdf4fef3dba
Code: d8 64 89 02 48 c7 c0 ff ff ff ff eb a6 e8 5e 04 00 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdd442cdd8 EFLAGS: 00000282 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffdd442ce20 RCX: 00007fdf4fef3dba
RDX: 0000000020005d80 RSI: 0000000020005dc0 RDI: 00007ffdd442ce20
RBP: 0000000020005dc0 R08: 00007ffdd442ce60 R09: 0000000000005d58
R10: 0000000000000000 R11: 0000000000000282 R12: 0000000020005d80
R13: 0000000000005d5e R14: 00007ffdd442ce60 R15: 0000000000000004
 </TASK>
bcachefs (loop0): bch2_fs_quota_read_inode: snapshot tree 0 not found
bcachefs (loop0): inconsistency detected - emergency read only at journal seq 7
bcachefs (loop0): bch2_fs_quota_read(): error ENOENT_snapshot_tree
bcachefs (loop0): bch2_fs_recovery(): error ENOENT_snapshot_tree
bcachefs (loop0): bch2_fs_start(): error starting filesystem ENOENT_snapshot_tree
bcachefs (loop0): shutting down
bcachefs (loop0): shutdown complete


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

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


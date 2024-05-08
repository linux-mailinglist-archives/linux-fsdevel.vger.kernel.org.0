Return-Path: <linux-fsdevel+bounces-18991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E88BF594
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 07:36:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E991E1F2517F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 05:36:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C19C1773A;
	Wed,  8 May 2024 05:36:21 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8073C14273
	for <linux-fsdevel@vger.kernel.org>; Wed,  8 May 2024 05:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715146581; cv=none; b=Y+2hqNaeYlthZ641/yCwq/sLZHPot7NqF3iE7oCsfPTbHP4RN/GVFasodcqMxY0T0LZ7Ei5FEP5mpNuyRRPywPLZNT/xx10Mof/D3SkRmtzMdd5kQkuRELoSHHYnSQ0hdDHACQg0ZAPMPgzLyKa7jDlDF/L3QrxhNJDXsrdF3Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715146581; c=relaxed/simple;
	bh=S4gEHYymC1ch3jS4q9sF0xemJerl9APW68Fzqb0/fXM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=j+PmdDfXesSybNhm8cfuMWsn6JXi4vfiCc4Wo3z8NvBiW/YblN7GzxutIvTZkCYC0ZZIUDwDHflGkbYcOQINt5Dt9eLLt0c7+SqHHJqKqBOheVbzWu5oLk14NgQPCYDleJ2Ec4OA3p1Nin2xwXHZn3vg+xsLTWeJ57DivEozuGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36c5e4166cfso43752955ab.0
        for <linux-fsdevel@vger.kernel.org>; Tue, 07 May 2024 22:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715146579; x=1715751379;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tS/QKLFbZ72HkGmrCTfWCUyKFvyoD3yXMTX+FI1lu9c=;
        b=mi9+WOX6I3MCG9OyU5wfzsGQd4NRDjgwb5VRaW/T4ByirMc6sZH0W+BcCCgfK6bt11
         xhp2lXmdzaiDXatuQhCJ6MgjcZrRhiQ+SKp5+0heOyzpO8n0PHXnf5TVA+lR+m8QROY6
         c+VKnIc4T/aqdSdZ+f5gImEAqVQ15ir8111jOHoHeCbAtxw+OwiiDXZVzj7vcX5XeGQh
         d4tnn70vbOCPcbpfBRsLtHjSajffQsoiZTAvlKV5GRT4yK3syMmNYc8/yWZ9Ue2Fjc9T
         w5Cwn+GCelFee/0vcfjR3ix3rzg8RtCNodR3Szl87qA6KGwOLj19717ku5G3xsd5YM53
         aaqw==
X-Forwarded-Encrypted: i=1; AJvYcCXmMkH9G6yiIQaMJlogR2MWLLO/jwPkw0ISXPVbyeLocYvZzaro25rpKIdBLBPF8OxjGOShX2TtC2vgMp7GdLVYjHJOVQ7E4c09yOX1Rg==
X-Gm-Message-State: AOJu0Yy+2ozZtCAOnecDN6nXdBCYdkSxCFdAvXRPncJxAiG+oplGI/Id
	rEyZ6S4UgHoMblXP+NS46jzQ+jDLKZ4DVIbsQyZnoxSC5dF1IjI+mL14NwGDQID/MnSBqKDb8Qb
	Qsq9EZKOpopYHIQAaBDu8E7OQlalkWhm2WNwN5o2X1bLbVtEJpiAylXc=
X-Google-Smtp-Source: AGHT+IFkJB2CLj8DbGgNFMRhktqu3E2FTFXBUn2vHLmP+hjKvcpCoqvCsx0jaHNoIHp3V7jGibfWQBR+vp9iFgmYC9WSGEPj6ryA
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d05:b0:369:f7ca:a361 with SMTP id
 e9e14a558f8ab-36caeccc653mr674705ab.1.1715146578791; Tue, 07 May 2024
 22:36:18 -0700 (PDT)
Date: Tue, 07 May 2024 22:36:18 -0700
In-Reply-To: <0000000000006399c80617120daa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091228c0617eaae32@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_seq_start
From: syzbot <syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    dccb07f2914c Merge tag 'for-6.9-rc7-tag' of git://git.kern..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=137daa6c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7ea7de0cb32587
dashboard link: https://syzkaller.appspot.com/bug?extid=4c493dcd5a68168a94b2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1134f3c0980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1367a504980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea1961ce01fe/disk-dccb07f2.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/445a00347402/vmlinux-dccb07f2.xz
kernel image: https://storage.googleapis.com/syzbot-assets/461aed7c4df3/bzImage-dccb07f2.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c493dcd5a68168a94b2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0 Not tainted
------------------------------------------------------
syz-executor149/5078 is trying to acquire lock:
ffff88802a978888 (&of->mutex){+.+.}-{3:3}, at: kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154

but task is already holding lock:
ffff88802d80b540 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (&p->lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       seq_read_iter+0xb7/0xd60 fs/seq_file.c:182
       call_read_iter include/linux/fs.h:2104 [inline]
       copy_splice_read+0x662/0xb60 fs/splice.c:365
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_sendfile+0x515/0xdc0 fs/read_write.c:1301
       __do_sys_sendfile64 fs/read_write.c:1362 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #3 (&pipe->mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       iter_file_splice_write+0x335/0x14e0 fs/splice.c:687
       backing_file_splice_write+0x2bc/0x4c0 fs/backing-file.c:289
       ovl_splice_write+0x3cf/0x500 fs/overlayfs/file.c:379
       do_splice_from fs/splice.c:941 [inline]
       do_splice+0xd77/0x1880 fs/splice.c:1354
       __do_splice fs/splice.c:1436 [inline]
       __do_sys_splice fs/splice.c:1652 [inline]
       __se_sys_splice+0x331/0x4a0 fs/splice.c:1634
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (sb_writers#4){.+.+}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       percpu_down_read include/linux/percpu-rwsem.h:51 [inline]
       __sb_start_write include/linux/fs.h:1664 [inline]
       sb_start_write+0x4d/0x1c0 include/linux/fs.h:1800
       mnt_want_write+0x3f/0x90 fs/namespace.c:409
       ovl_create_object+0x13b/0x370 fs/overlayfs/dir.c:629
       lookup_open fs/namei.c:3497 [inline]
       open_last_lookups fs/namei.c:3566 [inline]
       path_openat+0x1425/0x3240 fs/namei.c:3796
       do_filp_open+0x235/0x490 fs/namei.c:3826
       do_sys_openat2+0x13e/0x1d0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_open fs/open.c:1429 [inline]
       __se_sys_open fs/open.c:1425 [inline]
       __x64_sys_open+0x225/0x270 fs/open.c:1425
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
       inode_lock_shared include/linux/fs.h:805 [inline]
       lookup_slow+0x45/0x70 fs/namei.c:1708
       walk_component+0x2e1/0x410 fs/namei.c:2004
       lookup_last fs/namei.c:2461 [inline]
       path_lookupat+0x16f/0x450 fs/namei.c:2485
       filename_lookup+0x256/0x610 fs/namei.c:2514
       kern_path+0x35/0x50 fs/namei.c:2622
       lookup_bdev+0xc5/0x290 block/bdev.c:1136
       resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
       kernfs_fop_write_iter+0x3a1/0x500 fs/kernfs/file.c:334
       call_write_iter include/linux/fs.h:2110 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa84/0xcb0 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (&of->mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
       traverse+0x14f/0x550 fs/seq_file.c:106
       seq_read_iter+0xc5e/0xd60 fs/seq_file.c:195
       call_read_iter include/linux/fs.h:2104 [inline]
       copy_splice_read+0x662/0xb60 fs/splice.c:365
       do_splice_read fs/splice.c:985 [inline]
       splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
       do_sendfile+0x515/0xdc0 fs/read_write.c:1301
       __do_sys_sendfile64 fs/read_write.c:1362 [inline]
       __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &of->mutex --> &pipe->mutex --> &p->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&p->lock);
                               lock(&pipe->mutex);
                               lock(&p->lock);
  lock(&of->mutex);

 *** DEADLOCK ***

2 locks held by syz-executor149/5078:
 #0: ffff88807de89868 (&pipe->mutex){+.+.}-{3:3}, at: splice_file_to_pipe+0x2e/0x500 fs/splice.c:1292
 #1: ffff88802d80b540 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xb7/0xd60 fs/seq_file.c:182

stack backtrace:
CPU: 0 PID: 5078 Comm: syz-executor149 Not tainted 6.9.0-rc7-syzkaller-00012-gdccb07f2914c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 kernfs_seq_start+0x53/0x3b0 fs/kernfs/file.c:154
 traverse+0x14f/0x550 fs/seq_file.c:106
 seq_read_iter+0xc5e/0xd60 fs/seq_file.c:195
 call_read_iter include/linux/fs.h:2104 [inline]
 copy_splice_read+0x662/0xb60 fs/splice.c:365
 do_splice_read fs/splice.c:985 [inline]
 splice_file_to_pipe+0x299/0x500 fs/splice.c:1295
 do_sendfile+0x515/0xdc0 fs/read_write.c:1301
 __do_sys_sendfile64 fs/read_write.c:1362 [inline]
 __se_sys_sendfile64+0x17c/0x1e0 fs/read_write.c:1348
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7d8d33f8e9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7d8d2b8218 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 00007f7d8d3c9428 RCX: 00007f7d8d33f8e9
RDX: 0000000000000000 RSI: 0000000000000007 RDI: 0000000000000006
RBP: 00007f7d8d3c9420 R08: 00007ffdc82d7c57 R09: 0000000000000000
R10: 0000000000000004 R11: 0000000000000246 R12: 00007f7d8d39606c
R13: 0030656c69662f2e R14: 0079616c7265766f R15: 00007f7d8d39603b
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


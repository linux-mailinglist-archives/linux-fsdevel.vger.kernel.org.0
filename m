Return-Path: <linux-fsdevel+bounces-22698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC6D91B28E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 01:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FF961F23518
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 23:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B53B61A2FBF;
	Thu, 27 Jun 2024 23:13:52 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DD01A2FA0
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530032; cv=none; b=W+4VXP5uKBVvLKoUEGjHC46zcSgkOmCReC+2PvEGdux7S6DhRCpyL5uAbxFndqZiWMDgvuOQpTdkAkl2IbPnCHw0tMq9g0d02OvgSOeQ0JEBKpyW89bdtXqbqtc+m5vIGy/VJZfPJgrQziOHXoIld8uiOOiE3m15/2ocbLzsFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530032; c=relaxed/simple;
	bh=EazZ1+Eks7daWoGpF6OcAwnhZW0x18d4oV+PJszIr1g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=FPUiPHCybZPEwAoMgDPTnN5dtJkB35OaYuKk+YKKIHNrZpwwHYcDBGycMqMO1jKgJ/iyPmG+99cjGNdaOCSr0zk4w6Ch/6P2MnvR11mE4ORupEodhycCBITZL6FpZcz2BvkP1sc0k5D7UI6605Mx1DCsUVAwFC/z/I8CHvcn4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7f3d933ce7dso142001839f.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 27 Jun 2024 16:13:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719530030; x=1720134830;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jj10ORnN6oj6VvX7wqQ7EphmxN4B+rwEvERQ+ZN7VeU=;
        b=i+xYyhDRtquzowwkDuBEiewk2ERuApyf63C8tpjgDaN7seX0T6/Y86veV6l54f/zQA
         YoLMFuMHzxkhnL5nKBlGCe/BCALIfIohbW+640JXCG6ADrTSASz7AXc9AN009Qr5uPF3
         JoOkR179mXEsZIJydaUrEIRyzkvBwy64zNPj4r6OdLPiJDp1fRHnSmnff+Avcxi+uIB8
         JqsvU6JSRRSRRacct+1WUiI6evRJA5weSXAVD1Bp0PHF7ZdUVeNaCUehGSCP/jUg18XP
         4i1lpvkwbsTV8JoEiYrhwQKnp1swWXQwF/xAcyY3vVT8rEe5/q+I15kbXA1IcOM1dMIN
         39wg==
X-Forwarded-Encrypted: i=1; AJvYcCUAC93D1rljNe70uI03dH4m/Cs3iVTa0riR+XDuze2ACJErbfwOjCsdGIuWR4TU0xkJBYgHgBGue7Ee8cVT6YFwcn5thHEB54hBSVKh3Q==
X-Gm-Message-State: AOJu0YzUrmvEgrTIsxFbmCCzhxNXjlAHz6mjaEuajJOLmea7Vm4KPujk
	aiRFO2+gYRt53CMnKLVBwps8IFAgx+7ReP89MjiPIcgdrXD5nuESq8DuWg65d9HIJ5kQIkpaexN
	OlGNEFg4eiIQeMkjfMGltivU1liuf49TBSOzdaEaE3RULgFrvH5ztQuk=
X-Google-Smtp-Source: AGHT+IEI35ZNAYXAVQ7FgLZ+2UqBRKbq0qw5Be1+ZLSyFT+IEGcgARTkYuIHzBCFf6gpQYUNDieBpghaYX0IPodWybG/2DbltqdL
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8c:b0:375:dad7:a664 with SMTP id
 e9e14a558f8ab-3763f74fbc3mr12586135ab.6.1719530029778; Thu, 27 Jun 2024
 16:13:49 -0700 (PDT)
Date: Thu, 27 Jun 2024 16:13:49 -0700
In-Reply-To: <CAKYAXd-YWYRkbPis9wh+hkAX1zPkY=ozK8Bsp1+2PRUPs24rTQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b1e39061be7480a@google.com>
Subject: Re: [syzbot] [exfat?] possible deadlock in exfat_iterate (2)
From: syzbot <syzbot+df3558df41609451e4ac@syzkaller.appspotmail.com>
To: linkinjeon@kernel.org
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> #syz test git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.=
git dev

This crash does not have a reproducer. I cannot test it.

>
> 2024=EB=85=84 6=EC=9B=94 27=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:58,=
 syzbot
> <syzbot+df3558df41609451e4ac@syzkaller.appspotmail.com>=EB=8B=98=EC=9D=B4=
 =EC=9E=91=EC=84=B1:
>>
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    55027e689933 Merge tag 'input-for-v6.10-rc5' of git://gi=
t...
>> git tree:       upstream
>> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16390ac19800=
00
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D53ab35b55612=
9242
>> dashboard link: https://syzkaller.appspot.com/bug?extid=3Ddf3558df416094=
51e4ac
>> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for =
Debian) 2.40
>> userspace arch: i386
>>
>> Unfortunately, I don't have any reproducer for this issue yet.
>>
>> Downloadable assets:
>> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/=
7bc7510fe41f/non_bootable_disk-55027e68.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/a36929b5a065/vmlin=
ux-55027e68.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/d72de6f61ddc/=
bzImage-55027e68.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the com=
mit:
>> Reported-by: syzbot+df3558df41609451e4ac@syzkaller.appspotmail.com
>>
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>> WARNING: possible circular locking dependency detected
>> 6.10.0-rc5-syzkaller-00018-g55027e689933 #0 Not tainted
>> ------------------------------------------------------
>> syz-executor.2/6265 is trying to acquire lock:
>> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux=
/sched/mm.h:334 [inline]
>> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/sl=
ub.c:3891 [inline]
>> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c=
:3981 [inline]
>> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub=
.c:4121 [inline]
>> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_noprof+0xb5/0x4=
20 mm/slub.c:4135
>>
>> but task is already holding lock:
>> ffff88804af1a0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x33f/0=
xad0 fs/exfat/dir.c:256
>>
>> which lock already depends on the new lock.
>>
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #1 (&sbi->s_lock#2){+.+.}-{3:3}:
>>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>>        __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
>>        exfat_evict_inode+0x25b/0x340 fs/exfat/inode.c:725
>>        evict+0x2ed/0x6c0 fs/inode.c:667
>>        iput_final fs/inode.c:1741 [inline]
>>        iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
>>        iput+0x5c/0x80 fs/inode.c:1757
>>        dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
>>        __dentry_kill+0x1d0/0x600 fs/dcache.c:603
>>        shrink_kill fs/dcache.c:1048 [inline]
>>        shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
>>        prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
>>        super_cache_scan+0x32a/0x550 fs/super.c:221
>>        do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
>>        shrink_slab_memcg mm/shrinker.c:548 [inline]
>>        shrink_slab+0xa87/0x1310 mm/shrinker.c:626
>>        shrink_one+0x493/0x7c0 mm/vmscan.c:4790
>>        shrink_many mm/vmscan.c:4851 [inline]
>>        lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
>>        shrink_node mm/vmscan.c:5910 [inline]
>>        kswapd_shrink_node mm/vmscan.c:6720 [inline]
>>        balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
>>        kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
>>        kthread+0x2c1/0x3a0 kernel/kthread.c:389
>>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>>
>> -> #0 (fs_reclaim){+.+.}-{0:0}:
>>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>>        validate_chain kernel/locking/lockdep.c:3869 [inline]
>>        __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>>        lock_acquire kernel/locking/lockdep.c:5754 [inline]
>>        lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>>        __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
>>        fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
>>        might_alloc include/linux/sched/mm.h:334 [inline]
>>        slab_pre_alloc_hook mm/slub.c:3891 [inline]
>>        slab_alloc_node mm/slub.c:3981 [inline]
>>        __do_kmalloc_node mm/slub.c:4121 [inline]
>>        __kmalloc_noprof+0xb5/0x420 mm/slub.c:4135
>>        kmalloc_noprof include/linux/slab.h:664 [inline]
>>        kmalloc_array_noprof include/linux/slab.h:699 [inline]
>>        __exfat_get_dentry_set+0x81e/0xa90 fs/exfat/dir.c:816
>>        exfat_get_dentry_set+0x36/0x210 fs/exfat/dir.c:859
>>        exfat_get_uniname_from_ext_entry fs/exfat/dir.c:39 [inline]
>>        exfat_readdir+0x950/0x1520 fs/exfat/dir.c:155
>>        exfat_iterate+0x3c7/0xad0 fs/exfat/dir.c:261
>>        wrap_directory_iterator+0xa5/0xe0 fs/readdir.c:67
>>        iterate_dir+0x53e/0xb60 fs/readdir.c:110
>>        __do_sys_getdents64 fs/readdir.c:409 [inline]
>>        __se_sys_getdents64 fs/readdir.c:394 [inline]
>>        __ia32_sys_getdents64+0x14f/0x2e0 fs/readdir.c:394
>>        do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>>        __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>>        do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>>        entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>>
>> other info that might help us debug this:
>>
>>  Possible unsafe locking scenario:
>>
>>        CPU0                    CPU1
>>        ----                    ----
>>   lock(&sbi->s_lock#2);
>>                                lock(fs_reclaim);
>>                                lock(&sbi->s_lock#2);
>>   lock(fs_reclaim);
>>
>>  *** DEADLOCK ***
>>
>> 3 locks held by syz-executor.2/6265:
>>  #0: ffff88801db114c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xeb=
/0x180 fs/file.c:1191
>>  #1: ffff8880483da9e8 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: wra=
p_directory_iterator+0x5a/0xe0 fs/readdir.c:56
>>  #2: ffff88804af1a0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x=
33f/0xad0 fs/exfat/dir.c:256
>>
>> stack backtrace:
>> CPU: 0 PID: 6265 Comm: syz-executor.2 Not tainted 6.10.0-rc5-syzkaller-0=
0018-g55027e689933 #0
>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1=
.16.2-1 04/01/2014
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:88 [inline]
>>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
>>  check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
>>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>>  validate_chain kernel/locking/lockdep.c:3869 [inline]
>>  __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>>  lock_acquire kernel/locking/lockdep.c:5754 [inline]
>>  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>>  __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
>>  fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
>>  might_alloc include/linux/sched/mm.h:334 [inline]
>>  slab_pre_alloc_hook mm/slub.c:3891 [inline]
>>  slab_alloc_node mm/slub.c:3981 [inline]
>>  __do_kmalloc_node mm/slub.c:4121 [inline]
>>  __kmalloc_noprof+0xb5/0x420 mm/slub.c:4135
>>  kmalloc_noprof include/linux/slab.h:664 [inline]
>>  kmalloc_array_noprof include/linux/slab.h:699 [inline]
>>  __exfat_get_dentry_set+0x81e/0xa90 fs/exfat/dir.c:816
>>  exfat_get_dentry_set+0x36/0x210 fs/exfat/dir.c:859
>>  exfat_get_uniname_from_ext_entry fs/exfat/dir.c:39 [inline]
>>  exfat_readdir+0x950/0x1520 fs/exfat/dir.c:155
>>  exfat_iterate+0x3c7/0xad0 fs/exfat/dir.c:261
>>  wrap_directory_iterator+0xa5/0xe0 fs/readdir.c:67
>>  iterate_dir+0x53e/0xb60 fs/readdir.c:110
>>  __do_sys_getdents64 fs/readdir.c:409 [inline]
>>  __se_sys_getdents64 fs/readdir.c:394 [inline]
>>  __ia32_sys_getdents64+0x14f/0x2e0 fs/readdir.c:394
>>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>>  __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>> RIP: 0023:0xf72f8579
>> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 =
00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 9=
0 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
>> RSP: 002b:00000000f5ec95ac EFLAGS: 00000292 ORIG_RAX: 00000000000000dc
>> RAX: ffffffffffffffda RBX: 000000000000000a RCX: 0000000020002ec0
>> RDX: 0000000000001000 RSI: 0000000000000000 RDI: 0000000000000000
>> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>> R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
>> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>>  </TASK>
>> ----------------
>> Code disassembly (best guess), 2 bytes skipped:
>>    0:   10 06                   adc    %al,(%rsi)
>>    2:   03 74 b4 01             add    0x1(%rsp,%rsi,4),%esi
>>    6:   10 07                   adc    %al,(%rdi)
>>    8:   03 74 b0 01             add    0x1(%rax,%rsi,4),%esi
>>    c:   10 08                   adc    %cl,(%rax)
>>    e:   03 74 d8 01             add    0x1(%rax,%rbx,8),%esi
>>   1e:   00 51 52                add    %dl,0x52(%rcx)
>>   21:   55                      push   %rbp
>>   22:   89 e5                   mov    %esp,%ebp
>>   24:   0f 34                   sysenter
>>   26:   cd 80                   int    $0x80
>> * 28:   5d                      pop    %rbp <-- trapping instruction
>>   29:   5a                      pop    %rdx
>>   2a:   59                      pop    %rcx
>>   2b:   c3                      ret
>>   2c:   90                      nop
>>   2d:   90                      nop
>>   2e:   90                      nop
>>   2f:   90                      nop
>>   30:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
>>   37:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
>>
>>
>> ---
>> This report is generated by a bot. It may contain errors.
>> See https://goo.gl/tpsmEJ for more information about syzbot.
>> syzbot engineers can be reached at syzkaller@googlegroups.com.
>>
>> syzbot will keep track of this issue. See:
>> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>>
>> If the report is already addressed, let syzbot know by replying with:
>> #syz fix: exact-commit-title
>>
>> If you want to overwrite report's subsystems, reply with:
>> #syz set subsystems: new-subsystem
>> (See the list of subsystem names on the web dashboard)
>>
>> If the report is a duplicate of another one, reply with:
>> #syz dup: exact-subject-of-another-report
>>
>> If you want to undo deduplication, reply with:
>> #syz undup


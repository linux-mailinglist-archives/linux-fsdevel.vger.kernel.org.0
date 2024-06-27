Return-Path: <linux-fsdevel+bounces-22697-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B19BF91B28C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2024 01:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6833C2848B8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jun 2024 23:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8521A2C2B;
	Thu, 27 Jun 2024 23:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUYe/UHr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D942F1CA9F;
	Thu, 27 Jun 2024 23:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719530029; cv=none; b=GVYZ1H1VFF5JEVb0GydrC7RPh+GtNhTT1JFvcw0gGoMN6OJyxkLcj577CdPvjG7cFvr0T4RWZ1flYlSEB9y6S+d1xsZMXSUqApUe/nbOZIP544uF8xdORn2OEi7KiX3/NbHh5U3a2vhAb64jR/n03r0NFi+hjF9+z+1LtdCLALA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719530029; c=relaxed/simple;
	bh=sLopButZu93sLjxaty65tbHl58W3iNdcIGCqQeCxmC0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=twUENrrWk5P9pCjkkItK+v6ygH8dp7BlPyGUA9o+9FmNvypZ1Ys8dRXfmhVoCFaubtoWD+2eHxnmkee9mZpG/lBX1ss4vwi7wTLp7Go+iNlfuxeHbm+LchlG+NzW6qGN7a1zhJZk1jpB2YwIAqBsxwBHOj7/4tslCdBwkJctHJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUYe/UHr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68135C4AF09;
	Thu, 27 Jun 2024 23:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719530028;
	bh=sLopButZu93sLjxaty65tbHl58W3iNdcIGCqQeCxmC0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=lUYe/UHroCVY8HoOt71evyO/cPxo0zcDIcW+m3n/tO6tiMVf+vyoaZkmuSqfqJFwT
	 aRYB91yVJsp3c7p6bq6E3JlXfgG6sSdS7eZLD+56KAhmN4YBpxns4ckW9pdHTcL6P0
	 ZJnsm1x/1JPxZIuim0CTHnb2hgBPBABeeMFzMWB4pYt6lJIlnZ23v7R1CGaasHxi5/
	 QevvU5z2WbrzFoAld7QyFIzeIBkHAYOr1fU45YIezTirkkQKFAZHjnIDwwWLhK7G1P
	 UKjOW2dqio2+ziVjvRaaOOfHQS7L0xLsvTzXdFMBFlGDHg8S5tl7IbUFgCxjcJZGSI
	 C89tb7DRYRQbw==
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-25cae7464f5so22717fac.3;
        Thu, 27 Jun 2024 16:13:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVGgnk4ewRvMX3TXE+RxBadHmu9wzRMvBBgb+Lvang+0/ML3KVrGdX0N18svWgkgZzO42WDPljoUKdef2IDlopk3L5xmZnChu3CRk2K
X-Gm-Message-State: AOJu0YxXm0rWFPST+tKc+MkpWfn8YiwtDQ35zRFqnCnvQrAYbY9uN/E9
	ZlRYwCAK0tKslf6SRd4768M7pBPpBDwFSex9uB0wnC8dEQljZVsx16Auqy6vjR9n0rWy12fP8i3
	h33BnXHahmnk/pllKPUVX/Cp2KD4=
X-Google-Smtp-Source: AGHT+IH1fdeRZt0S5SHK7IuJvx4zaPmVNuVIyE12BjdkD55OepsptU9Su69g1rU6sLlSo4+SMcG+8UaGqW99rAKJWD8=
X-Received: by 2002:a05:6870:470c:b0:254:9570:e5aa with SMTP id
 586e51a60fabf-25d06ef5925mr14781283fac.57.1719530027622; Thu, 27 Jun 2024
 16:13:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000565ec5061bdeafd5@google.com>
In-Reply-To: <000000000000565ec5061bdeafd5@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 28 Jun 2024 08:13:36 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-YWYRkbPis9wh+hkAX1zPkY=ozK8Bsp1+2PRUPs24rTQ@mail.gmail.com>
Message-ID: <CAKYAXd-YWYRkbPis9wh+hkAX1zPkY=ozK8Bsp1+2PRUPs24rTQ@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] possible deadlock in exfat_iterate (2)
To: syzbot <syzbot+df3558df41609451e4ac@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.gi=
t dev

2024=EB=85=84 6=EC=9B=94 27=EC=9D=BC (=EB=AA=A9) =EC=98=A4=ED=9B=84 9:58, s=
yzbot
<syzbot+df3558df41609451e4ac@syzkaller.appspotmail.com>=EB=8B=98=EC=9D=B4 =
=EC=9E=91=EC=84=B1:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    55027e689933 Merge tag 'input-for-v6.10-rc5' of git://git=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16390ac198000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D53ab35b556129=
242
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Ddf3558df4160945=
1e4ac
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> userspace arch: i386
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
bc7510fe41f/non_bootable_disk-55027e68.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a36929b5a065/vmlinu=
x-55027e68.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d72de6f61ddc/b=
zImage-55027e68.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+df3558df41609451e4ac@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.10.0-rc5-syzkaller-00018-g55027e689933 #0 Not tainted
> ------------------------------------------------------
> syz-executor.2/6265 is trying to acquire lock:
> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: might_alloc include/linux/=
sched/mm.h:334 [inline]
> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: slab_pre_alloc_hook mm/slu=
b.c:3891 [inline]
> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: slab_alloc_node mm/slub.c:=
3981 [inline]
> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: __do_kmalloc_node mm/slub.=
c:4121 [inline]
> ffffffff8dd3ab20 (fs_reclaim){+.+.}-{0:0}, at: __kmalloc_noprof+0xb5/0x42=
0 mm/slub.c:4135
>
> but task is already holding lock:
> ffff88804af1a0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x33f/0x=
ad0 fs/exfat/dir.c:256
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&sbi->s_lock#2){+.+.}-{3:3}:
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
>        exfat_evict_inode+0x25b/0x340 fs/exfat/inode.c:725
>        evict+0x2ed/0x6c0 fs/inode.c:667
>        iput_final fs/inode.c:1741 [inline]
>        iput.part.0+0x5a8/0x7f0 fs/inode.c:1767
>        iput+0x5c/0x80 fs/inode.c:1757
>        dentry_unlink_inode+0x295/0x480 fs/dcache.c:400
>        __dentry_kill+0x1d0/0x600 fs/dcache.c:603
>        shrink_kill fs/dcache.c:1048 [inline]
>        shrink_dentry_list+0x140/0x5d0 fs/dcache.c:1075
>        prune_dcache_sb+0xeb/0x150 fs/dcache.c:1156
>        super_cache_scan+0x32a/0x550 fs/super.c:221
>        do_shrink_slab+0x44f/0x11c0 mm/shrinker.c:435
>        shrink_slab_memcg mm/shrinker.c:548 [inline]
>        shrink_slab+0xa87/0x1310 mm/shrinker.c:626
>        shrink_one+0x493/0x7c0 mm/vmscan.c:4790
>        shrink_many mm/vmscan.c:4851 [inline]
>        lru_gen_shrink_node+0x89f/0x1750 mm/vmscan.c:4951
>        shrink_node mm/vmscan.c:5910 [inline]
>        kswapd_shrink_node mm/vmscan.c:6720 [inline]
>        balance_pgdat+0x1105/0x1970 mm/vmscan.c:6911
>        kswapd+0x5ea/0xbf0 mm/vmscan.c:7180
>        kthread+0x2c1/0x3a0 kernel/kthread.c:389
>        ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> -> #0 (fs_reclaim){+.+.}-{0:0}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain kernel/locking/lockdep.c:3869 [inline]
>        __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>        lock_acquire kernel/locking/lockdep.c:5754 [inline]
>        lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>        __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
>        fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
>        might_alloc include/linux/sched/mm.h:334 [inline]
>        slab_pre_alloc_hook mm/slub.c:3891 [inline]
>        slab_alloc_node mm/slub.c:3981 [inline]
>        __do_kmalloc_node mm/slub.c:4121 [inline]
>        __kmalloc_noprof+0xb5/0x420 mm/slub.c:4135
>        kmalloc_noprof include/linux/slab.h:664 [inline]
>        kmalloc_array_noprof include/linux/slab.h:699 [inline]
>        __exfat_get_dentry_set+0x81e/0xa90 fs/exfat/dir.c:816
>        exfat_get_dentry_set+0x36/0x210 fs/exfat/dir.c:859
>        exfat_get_uniname_from_ext_entry fs/exfat/dir.c:39 [inline]
>        exfat_readdir+0x950/0x1520 fs/exfat/dir.c:155
>        exfat_iterate+0x3c7/0xad0 fs/exfat/dir.c:261
>        wrap_directory_iterator+0xa5/0xe0 fs/readdir.c:67
>        iterate_dir+0x53e/0xb60 fs/readdir.c:110
>        __do_sys_getdents64 fs/readdir.c:409 [inline]
>        __se_sys_getdents64 fs/readdir.c:394 [inline]
>        __ia32_sys_getdents64+0x14f/0x2e0 fs/readdir.c:394
>        do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>        __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>        do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>        entry_SYSENTER_compat_after_hwframe+0x84/0x8e
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&sbi->s_lock#2);
>                                lock(fs_reclaim);
>                                lock(&sbi->s_lock#2);
>   lock(fs_reclaim);
>
>  *** DEADLOCK ***
>
> 3 locks held by syz-executor.2/6265:
>  #0: ffff88801db114c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0xeb/=
0x180 fs/file.c:1191
>  #1: ffff8880483da9e8 (&sb->s_type->i_mutex_key#24){++++}-{3:3}, at: wrap=
_directory_iterator+0x5a/0xe0 fs/readdir.c:56
>  #2: ffff88804af1a0e0 (&sbi->s_lock#2){+.+.}-{3:3}, at: exfat_iterate+0x3=
3f/0xad0 fs/exfat/dir.c:256
>
> stack backtrace:
> CPU: 0 PID: 6265 Comm: syz-executor.2 Not tainted 6.10.0-rc5-syzkaller-00=
018-g55027e689933 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.=
16.2-1 04/01/2014
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
>  check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain kernel/locking/lockdep.c:3869 [inline]
>  __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>  lock_acquire kernel/locking/lockdep.c:5754 [inline]
>  lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
>  __fs_reclaim_acquire mm/page_alloc.c:3801 [inline]
>  fs_reclaim_acquire+0x102/0x160 mm/page_alloc.c:3815
>  might_alloc include/linux/sched/mm.h:334 [inline]
>  slab_pre_alloc_hook mm/slub.c:3891 [inline]
>  slab_alloc_node mm/slub.c:3981 [inline]
>  __do_kmalloc_node mm/slub.c:4121 [inline]
>  __kmalloc_noprof+0xb5/0x420 mm/slub.c:4135
>  kmalloc_noprof include/linux/slab.h:664 [inline]
>  kmalloc_array_noprof include/linux/slab.h:699 [inline]
>  __exfat_get_dentry_set+0x81e/0xa90 fs/exfat/dir.c:816
>  exfat_get_dentry_set+0x36/0x210 fs/exfat/dir.c:859
>  exfat_get_uniname_from_ext_entry fs/exfat/dir.c:39 [inline]
>  exfat_readdir+0x950/0x1520 fs/exfat/dir.c:155
>  exfat_iterate+0x3c7/0xad0 fs/exfat/dir.c:261
>  wrap_directory_iterator+0xa5/0xe0 fs/readdir.c:67
>  iterate_dir+0x53e/0xb60 fs/readdir.c:110
>  __do_sys_getdents64 fs/readdir.c:409 [inline]
>  __se_sys_getdents64 fs/readdir.c:394 [inline]
>  __ia32_sys_getdents64+0x14f/0x2e0 fs/readdir.c:394
>  do_syscall_32_irqs_on arch/x86/entry/common.c:165 [inline]
>  __do_fast_syscall_32+0x73/0x120 arch/x86/entry/common.c:386
>  do_fast_syscall_32+0x32/0x80 arch/x86/entry/common.c:411
>  entry_SYSENTER_compat_after_hwframe+0x84/0x8e
> RIP: 0023:0xf72f8579
> Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 0=
0 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90=
 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
> RSP: 002b:00000000f5ec95ac EFLAGS: 00000292 ORIG_RAX: 00000000000000dc
> RAX: ffffffffffffffda RBX: 000000000000000a RCX: 0000000020002ec0
> RDX: 0000000000001000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000292 R12: 0000000000000000
> R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
>  </TASK>
> ----------------
> Code disassembly (best guess), 2 bytes skipped:
>    0:   10 06                   adc    %al,(%rsi)
>    2:   03 74 b4 01             add    0x1(%rsp,%rsi,4),%esi
>    6:   10 07                   adc    %al,(%rdi)
>    8:   03 74 b0 01             add    0x1(%rax,%rsi,4),%esi
>    c:   10 08                   adc    %cl,(%rax)
>    e:   03 74 d8 01             add    0x1(%rax,%rbx,8),%esi
>   1e:   00 51 52                add    %dl,0x52(%rcx)
>   21:   55                      push   %rbp
>   22:   89 e5                   mov    %esp,%ebp
>   24:   0f 34                   sysenter
>   26:   cd 80                   int    $0x80
> * 28:   5d                      pop    %rbp <-- trapping instruction
>   29:   5a                      pop    %rdx
>   2a:   59                      pop    %rcx
>   2b:   c3                      ret
>   2c:   90                      nop
>   2d:   90                      nop
>   2e:   90                      nop
>   2f:   90                      nop
>   30:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
>   37:   8d b4 26 00 00 00 00    lea    0x0(%rsi,%riz,1),%esi
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>
> If you want to undo deduplication, reply with:
> #syz undup


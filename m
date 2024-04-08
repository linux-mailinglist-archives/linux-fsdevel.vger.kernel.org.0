Return-Path: <linux-fsdevel+bounces-16354-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D24989BC8C
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 12:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9382EB2286B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 10:02:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4A3524DE;
	Mon,  8 Apr 2024 10:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XIwsk6d7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD9633DF;
	Mon,  8 Apr 2024 10:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712570533; cv=none; b=jkPtiZBToSCdv4eLqeGZn8NF6ZRGDN94EJnMFIahxhLqno1LWyd1pJlD2vuoWDWBMsWWpEsLjEF0pulr4CLe3kwTsECHk+sPktzW89lzB8FK2eAy8W7T4pJTW9O0HYqZYU7v+uuJ0WwTyUNy4MGIQmaN6vQyuNuSECWuLi+smXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712570533; c=relaxed/simple;
	bh=uRmWadtgleQBXD0iHarzOLul85vywiSXDMSDAPs6MhQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JxQ3gk9J7NiwOvhsSIvVg6TI1osgvDEcYn/eJPjgrpwz2i4c9PzFpY85NQB4xx/KnDPDhgXK9u5jCZDUHtE1Q5Sib6f4vDpuFk0UhKVwiCswm2SzyiEFB7/ObkVgP9dAPXgbdbAUi0jV+siOEftk5mo801liysFFoCuVde5Yby4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XIwsk6d7; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6ea0f0ba3a5so451809a34.3;
        Mon, 08 Apr 2024 03:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712570530; x=1713175330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LSPhSD09Eg506yfPVdIli/CuVlioJKdtZUzov+3w8hc=;
        b=XIwsk6d7h5HRd1w5saC8Wj3jD+8FHFJhWdB4LTYVHB7uzvs72NMdyTrTm6LkyHSVLF
         sdODjDKWgEnHEVIRsJhVlsXXKJyop+QmAonauid+HJtBlQGObMvniNCfAZ027eOnq6zn
         IkdDvzMGvCbLZoBl6a8EEQvLbULojAggpuGqmDOPjhnD3WdwNmeBs7ztfk08ZLXhXRdY
         /0KlWXndDTF0/J3weKSlgFdZ1BaALLKFzCAQoHSqo5qpNUuzaVVHll9neHjjcIUw9MNi
         n0CwAhV+u3KZyuyUvjt6b+EuBjLJXTI9sQXC9idGaGXX3E3ucHokN7GGz42RCLUwXif/
         acvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712570530; x=1713175330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LSPhSD09Eg506yfPVdIli/CuVlioJKdtZUzov+3w8hc=;
        b=wXHKP3+JA0DOHv+Hh6f015cdwT/tbfH9bFOff+xD/4OxUL3BAh+aDT8KxKCbGJr8/z
         1rT6H3/n0sa6fVjCb0AtjRO4E3oJc6wF1FUzgYZuQl40/Nivdl04O+cLtfRLUgbhYiyB
         QKySDbNgswd9uOSJ+mFh9ufuYR4gGu/RZdySVZv1LkzGF3TlUiwmnqf9CftosZud8xst
         Enr5aFCXzjXRNwKBn3y2PsDHhhYbIVGnoJDofcPvAY+lfoXwZURv/o/UM8bdVJxE/EhR
         R2IaNcrMhAkTIc2n35FwmqBGNSJSBsshpl8DHdE0wDaSmtQEbsRxR95N41KfTvKRZN+7
         cTlQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHixfJpZk03+xbD369xDE7QBQqvZekzVIUxJ3GfiiM+HvHHTXld9C7gravwEclfBMUY0EQlRlqK4htW1r3tsqRGQmgtfYwBlSd7Y5SpoFH0MJys9AZWQ2OBk03m256BJpUU5gDukA/R1261Q==
X-Gm-Message-State: AOJu0YxM1j2V7w4dYgLbH3DPZIav/cFICfat4NODPEMoHypwnMGsLMEU
	GxIbXQalAanb73TWkZPP+aWsdIBixrD24xKn2sWDjw2Fgk+NKqQgV9NkrR7DXeLnUrQpDRflbXt
	sDD6wuJYpIQgbuAULNs6D2McRBAk=
X-Google-Smtp-Source: AGHT+IHaT7BSa7Rm8zNh7kSXtzNIh1+rCGSwGVBaSD987df0H1UV63rsdpTvjE0iPcA5KJYcfI/M9qMvTPdyb3hcsCM=
X-Received: by 2002:a05:6830:2012:b0:6ea:fde:f48f with SMTP id
 e18-20020a056830201200b006ea0fdef48fmr4638988otp.27.1712570530611; Mon, 08
 Apr 2024 03:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000007ebc6061585fb7f@google.com>
In-Reply-To: <00000000000007ebc6061585fb7f@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 8 Apr 2024 13:01:59 +0300
Message-ID: <CAOQ4uxibFqnJkT_J+oVFU07ej-MAO1Nm0y6xkmarS_iarZndSQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] possible deadlock in ovl_copy_up_start (3)
To: syzbot <syzbot+5e130dffef394d3f11a6@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 7, 2024 at 9:37=E2=80=AFPM syzbot
<syzbot+5e130dffef394d3f11a6@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kerne=
l..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15f706ad18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d90a36f0cab4=
95a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5e130dffef394d3=
f11a6
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/dis=
k-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinu=
x-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/b=
zImage-fe46a7dd.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5e130dffef394d3f11a6@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> ------------------------------------------------------
> syz-executor.4/8594 is trying to acquire lock:
> ffff88805d9aff38 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_inode_lock=
_interruptible fs/overlayfs/overlayfs.h:654 [inline]
> ffff88805d9aff38 (&ovl_i_lock_key[depth]){+.+.}-{3:3}, at: ovl_copy_up_st=
art+0x53/0x310 fs/overlayfs/util.c:719
>
> but task is already holding lock:
> ffff88805d9afb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inode_loc=
k include/linux/fs.h:793 [inline]
> ffff88805d9afb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: vfs_rmdir=
+0x101/0x4c0 fs/namei.c:4198
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #2 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        down_read+0xb1/0xa40 kernel/locking/rwsem.c:1526
>        inode_lock_shared include/linux/fs.h:803 [inline]
>        lookup_slow+0x45/0x70 fs/namei.c:1708
>        walk_component+0x2e1/0x410 fs/namei.c:2004
>        lookup_last fs/namei.c:2461 [inline]
>        path_lookupat+0x16f/0x450 fs/namei.c:2485
>        filename_lookup+0x256/0x610 fs/namei.c:2514
>        kern_path+0x35/0x50 fs/namei.c:2622
>        lookup_bdev+0xc5/0x290 block/bdev.c:1072
>        resume_store+0x1a0/0x710 kernel/power/hibernate.c:1235
>        kernfs_fop_write_iter+0x3a4/0x500 fs/kernfs/file.c:334
>        call_write_iter include/linux/fs.h:2108 [inline]
>        new_sync_write fs/read_write.c:497 [inline]
>        vfs_write+0xa84/0xcb0 fs/read_write.c:590
>        ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> -> #1 (&of->mutex){+.+.}-{3:3}:
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        kernfs_fop_llseek+0x7e/0x2a0 fs/kernfs/file.c:867
>        ovl_llseek+0x314/0x470 fs/overlayfs/file.c:218
>        vfs_llseek fs/read_write.c:289 [inline]
>        ksys_lseek fs/read_write.c:302 [inline]
>        __do_sys_lseek fs/read_write.c:313 [inline]
>        __se_sys_lseek fs/read_write.c:311 [inline]
>        __x64_sys_lseek+0x153/0x1e0 fs/read_write.c:311
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> -> #0 (&ovl_i_lock_key[depth]){+.+.}-{3:3}:
>        check_prev_add kernel/locking/lockdep.c:3134 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>        validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>        __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>        lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>        __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>        __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>        ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
>        ovl_copy_up_start+0x53/0x310 fs/overlayfs/util.c:719
>        ovl_copy_up_one fs/overlayfs/copy_up.c:1161 [inline]
>        ovl_copy_up_flags+0xbb6/0x4450 fs/overlayfs/copy_up.c:1223
>        ovl_nlink_start+0x9f/0x390 fs/overlayfs/util.c:1157
>        ovl_do_remove+0x1fa/0xd90 fs/overlayfs/dir.c:893
>        vfs_rmdir+0x367/0x4c0 fs/namei.c:4209
>        do_rmdir+0x3b5/0x580 fs/namei.c:4268
>        __do_sys_rmdir fs/namei.c:4287 [inline]
>        __se_sys_rmdir fs/namei.c:4285 [inline]
>        __x64_sys_rmdir+0x49/0x60 fs/namei.c:4285
>        do_syscall_64+0xfb/0x240
>        entry_SYSCALL_64_after_hwframe+0x6d/0x75
>
> other info that might help us debug this:
>
> Chain exists of:
>   &ovl_i_lock_key[depth] --> &of->mutex --> &ovl_i_mutex_dir_key[depth]
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&ovl_i_mutex_dir_key[depth]);
>                                lock(&of->mutex);
>                                lock(&ovl_i_mutex_dir_key[depth]);
>   lock(&ovl_i_lock_key[depth]);
>
>  *** DEADLOCK ***
>
> 3 locks held by syz-executor.4/8594:
>  #0: ffff88802c9d8420 (sb_writers#23){.+.+}-{0:0}, at: mnt_want_write+0x3=
f/0x90 fs/namespace.c:409
>  #1: ffff88805d9aa450 (&ovl_i_mutex_dir_key[depth]/1){+.+.}-{3:3}, at: in=
ode_lock_nested include/linux/fs.h:828 [inline]
>  #1: ffff88805d9aa450 (&ovl_i_mutex_dir_key[depth]/1){+.+.}-{3:3}, at: do=
_rmdir+0x263/0x580 fs/namei.c:4256
>  #2: ffff88805d9afb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: inod=
e_lock include/linux/fs.h:793 [inline]
>  #2: ffff88805d9afb80 (&ovl_i_mutex_dir_key[depth]){++++}-{3:3}, at: vfs_=
rmdir+0x101/0x4c0 fs/namei.c:4198
>
> stack backtrace:
> CPU: 0 PID: 8594 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-08951-g=
fe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
>  check_prev_add kernel/locking/lockdep.c:3134 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>  validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
>  __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
>  lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
>  __mutex_lock_common kernel/locking/mutex.c:608 [inline]
>  __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
>  ovl_inode_lock_interruptible fs/overlayfs/overlayfs.h:654 [inline]
>  ovl_copy_up_start+0x53/0x310 fs/overlayfs/util.c:719
>  ovl_copy_up_one fs/overlayfs/copy_up.c:1161 [inline]
>  ovl_copy_up_flags+0xbb6/0x4450 fs/overlayfs/copy_up.c:1223
>  ovl_nlink_start+0x9f/0x390 fs/overlayfs/util.c:1157
>  ovl_do_remove+0x1fa/0xd90 fs/overlayfs/dir.c:893
>  vfs_rmdir+0x367/0x4c0 fs/namei.c:4209
>  do_rmdir+0x3b5/0x580 fs/namei.c:4268
>  __do_sys_rmdir fs/namei.c:4287 [inline]
>  __se_sys_rmdir fs/namei.c:4285 [inline]
>  __x64_sys_rmdir+0x49/0x60 fs/namei.c:4285
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f3be947dde9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f3bea1720c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000054
> RAX: ffffffffffffffda RBX: 00007f3be95abf80 RCX: 00007f3be947dde9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00000000200002c0
> RBP: 00007f3be94ca47a R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 000000000000000b R14: 00007f3be95abf80 R15: 00007ffd9e6203e8
>  </TASK>
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

#syz dup: possible deadlock in kernfs_fop_llseek

Thanks,
Amir.


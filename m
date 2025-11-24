Return-Path: <linux-fsdevel+bounces-69618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC40FC7EE32
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 04:29:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 299783459FE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 03:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E26F29992B;
	Mon, 24 Nov 2025 03:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GU7SNthY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794C7288525
	for <linux-fsdevel@vger.kernel.org>; Mon, 24 Nov 2025 03:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763954969; cv=none; b=rr+ZBUy8OlEHnQUganZIQEyFIrQ98HCz1Keb5aEaXaJ15JidMUMfjXYXxR3N8NzAnRj0ZaVZWkGEwo1xAAXLCeSrZX1/ruUu8BkrX72MRhrehhAfI9jWa+k9TCKaYsQQy7oBhl1DBOgTmANdJwOCTIJ8CuERuOeNKVkYIARXaOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763954969; c=relaxed/simple;
	bh=yjc3W4OWxnrFM3lzl+RedZqzwBw9Z9TPTQh/LF+yCT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xu1MiSExgpr7SRQ6kU+OBIiXmH3Zqgu8ABOVsNZbaX2B95wWoUCdkRaCKmozGPQj2M81axkQFl4pwtz5xLCA5LTc/0pzwIDe4LDJXTssJRv3R3ZzUOTSr8nWcePLpyGZWPC5bfbPEF9cO75c5uMq46ZysWMZFhAuxtBv4N1hnPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GU7SNthY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b73a9592fb8so238287566b.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 19:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763954966; x=1764559766; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=h55CDjAXETQTi3PMwB4ZlmWNo3oCs5KLxBCrW105QcY=;
        b=GU7SNthYVIwSnbc3u9lwxS1qVHljPaLgo6r1yYJAPPB0Sv2eB7J4hUQZYN8Rbl69PA
         WYyZpuermynIgvZyMl3MP16jth1Vr60Nqa1qzhmWyRxrBK4p/KHgjfNK68cpv6cwiwhV
         2Bin6AsZ2EI5qdegYRrW1jJWi9TEUqkOAaioKzs/sy0kfLeegXWUOfBT2LYyu45CeFx3
         LLXcrbsGPdvTRjCRP6d3eSBHxAm3cvEtDy5dsWFHmKpNugTEKG76lolveRiGcGkCHyTV
         f628fguaBhY8Fgi+KFcp82dV0lpjTE9ESe4M0JZiuIGd/2USNtF4ePwXKUWQk0SmGiUw
         ynOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763954966; x=1764559766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h55CDjAXETQTi3PMwB4ZlmWNo3oCs5KLxBCrW105QcY=;
        b=lkiFD9/va20D6CIaZuDByb/YGOTmkqlp4Oc4XVnWZX8wR5J4cUuQfMhU3IcJ7m/Dez
         H0CQ/oUymWNT9mXuoZZ/M6Fd3HZMmdrjzeRyf+dxoAhxhUhunoUcjVWqaDYazbnaPSSl
         Oyz8uvStQqxIX2RkXllqVaHaCFTMfHNylqNfHTt6jj4sUfs0TC5Eb3GBu8yTDudSd/Te
         1gKScRJZtt0VZ8HPE8K1UrxOgHsg0Yll8QEqqaMeDqzoIWwa7Mm4cuzNVlhV5Q+xG8/Z
         aDmaYJfF3WGomO04skACnEixWmeD9MOqGpbGnIRuckxkAZF4FsSeAL5aKYVPlG7E+9mm
         BgAw==
X-Forwarded-Encrypted: i=1; AJvYcCXo2x/i0SG3d2Oxpv+F8Njp1qoxPytEKmD92R4kobQn5xJrbvGGZfmef9GeTwjUjTYEqzZn2/N3UBDk2Hxh@vger.kernel.org
X-Gm-Message-State: AOJu0YyBh0miRHEpgJXlKHZTGkKsyOyQeQtw73W4HTyvVE8Yd9OExF3X
	a2pApQ18eXZDSAQKTgXQJwOdv3rF5kYhdz6KaPZMTO8k2pIH70sL6dYl
X-Gm-Gg: ASbGncv8t8bVAZKI1eScfdqJu0tc/3F61/aVmgSWzpsWL6MjiIFa2ZF0vawLMeM1BPx
	c2UFNj8J/XCcFYOSm7APdwvubZbLwRN9s0nsXDGyG3qTSGBgIqdyJ07+E1boZwj4ZgI0+rW6ir0
	+4kOb8xInLaHvlJLDjtaSn9UASMqPOK6CDHM9qWuD8xkwTi2iPvgrm4sBUofPBEWjwLHtiZt74g
	RoeGsm93wZJxIddEwuYYfAPiSK2EGEj19Ao8eelICyovCXeilRVNpBQ6S4x47m3PLawSDVarlsp
	YHHGrWqFIt8G3J9ri8dgzmV+PnuXdib7/zBhCXLJ2RyaEl7csGjr2ehmZPNoFsC381nNPAYokFM
	Sz3ZhlFmOCG6hlA1JaKuKXIaPI62fGVih9aDNBmtFYkHD1wI7CCf68EQe1znIZytBkDMagUA822
	dvGIjUtHblukbxpAa4sLfxwSQInPLhM7qC7dAcs9choede3ScHK0brGYTX
X-Google-Smtp-Source: AGHT+IFAdXPH+DgEP9gUTD8+S4WWp/IzK3wTSovDHiIna/gW0o+L+CzLYXzjpl/fyUDpFKAGy8nVWQ==
X-Received: by 2002:a17:907:1ca4:b0:b6d:5dbb:a1e1 with SMTP id a640c23a62f3a-b766ed8362dmr1205730366b.5.1763954965396;
        Sun, 23 Nov 2025 19:29:25 -0800 (PST)
Received: from f (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7654d7a0f4sm1181695466b.26.2025.11.23.19.29.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 19:29:24 -0800 (PST)
Date: Mon, 24 Nov 2025 04:29:03 +0100
From: Mateusz Guzik <mjguzik@gmail.com>
To: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	marc.dionne@auristor.com, ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, 
	viro@zeniv.linux.org.uk
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
Message-ID: <qmudwtflrp63e6wfosnpmgwelcweam55mmqy6whdc5jmckexfz@znsb3w2fvhji>
References: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>

On Sun, Nov 23, 2025 at 02:44:29PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    fe4d0dea039f Add linux-next specific files for 20251119
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=142c0514580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=f20a6db7594dcad7
> dashboard link: https://syzkaller.appspot.com/bug?extid=2fefb910d2c20c0698d8
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11cd7692580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17615658580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/ce4f26d91a01/disk-fe4d0dea.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/6c9b53acf521/vmlinux-fe4d0dea.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/64d37d01cd64/bzImage-fe4d0dea.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/a91529a880b1/mount_0.gz
> 
> The issue was bisected to:
> 
> commit 1e3c3784221ac86401aea72e2bae36057062fc9c
> Author: Mateusz Guzik <mjguzik@gmail.com>
> Date:   Fri Oct 10 22:17:36 2025 +0000
> 
>     fs: rework I_NEW handling to operate without fences
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17739742580000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f39742580000
> console output: https://syzkaller.appspot.com/x/log.txt?x=10f39742580000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com
> Fixes: 1e3c3784221a ("fs: rework I_NEW handling to operate without fences")
> 
> INFO: task syz.0.17:6022 blocked for more than 143 seconds.
>       Not tainted syzkaller #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz.0.17        state:D stack:28744 pid:6022  tgid:6020  ppid:5945   task_flags:0x400040 flags:0x00080002
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5263 [inline]
>  __schedule+0x1836/0x4ed0 kernel/sched/core.c:6871
>  __schedule_loop kernel/sched/core.c:6953 [inline]
>  schedule+0x165/0x360 kernel/sched/core.c:6968
>  schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7025
>  rwsem_down_write_slowpath+0x872/0xfe0 kernel/locking/rwsem.c:1185
>  __down_write_common kernel/locking/rwsem.c:1317 [inline]
>  __down_write kernel/locking/rwsem.c:1326 [inline]
>  down_write_nested+0x1b5/0x200 kernel/locking/rwsem.c:1707
>  inode_lock_nested include/linux/fs.h:1072 [inline]
>  lock_rename fs/namei.c:3681 [inline]
>  __start_renaming+0x148/0x410 fs/namei.c:3777
>  do_renameat2+0x399/0x8e0 fs/namei.c:5991
>  __do_sys_rename fs/namei.c:6059 [inline]
>  __se_sys_rename fs/namei.c:6057 [inline]
>  __x64_sys_rename+0x82/0x90 fs/namei.c:6057
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7ba9b8f749
> RSP: 002b:00007f7ba91dd038 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
> RAX: ffffffffffffffda RBX: 00007f7ba9de6090 RCX: 00007f7ba9b8f749
> RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000200000000340
> RBP: 00007f7ba9c13f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007f7ba9de6128 R14: 00007f7ba9de6090 R15: 00007fff2ce8d188
>  </TASK>
> 
> Showing all locks held in the system:
> 1 lock held by khungtaskd/31:
>  #0: ffffffff8df3d740 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
>  #0: ffffffff8df3d740 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
>  #0: ffffffff8df3d740 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
> 2 locks held by getty/5589:
>  #0: ffff88814d56c0a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
>  #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x43e/0x1400 drivers/tty/n_tty.c:2222
> 3 locks held by syz.0.17/6021:
> 2 locks held by syz.0.17/6022:
>  #0: ffff888030718420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
>  #1: ffff8880631e3dd8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
>  #1: ffff8880631e3dd8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
>  #1: ffff8880631e3dd8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
> 3 locks held by syz.1.18/6048:
> 2 locks held by syz.1.18/6049:
>  #0: ffff888077cbe420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
>  #1: ffff8880632db690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
>  #1: ffff8880632db690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
>  #1: ffff8880632db690 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
> 3 locks held by syz.2.19/6082:
> 2 locks held by syz.2.19/6083:
>  #0: ffff88807945e420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
>  #1: ffff888073281970 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
>  #1: ffff888073281970 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
>  #1: ffff888073281970 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
> 3 locks held by syz.3.20/6107:
> 2 locks held by syz.3.20/6108:
>  #0: ffff88807b0a4420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
>  #1: ffff8880631e1228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
>  #1: ffff8880631e1228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
>  #1: ffff8880631e1228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
> 3 locks held by syz.4.21/6138:
> 2 locks held by syz.4.21/6139:
>  #0: ffff8880587fe420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
>  #1: ffff8880632d8ae0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
>  #1: ffff8880632d8ae0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
>  #1: ffff8880632d8ae0 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
> 3 locks held by syz.5.22/6176:
> 2 locks held by syz.5.22/6177:
>  #0: ffff888026cec420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
>  #1: ffff8880631ce240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
>  #1: ffff8880631ce240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
>  #1: ffff8880631ce240 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
> 3 locks held by syz.6.23/6211:
> 2 locks held by syz.6.23/6212:
>  #0: ffff888027d88420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
>  #1: ffff8880631c9228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
>  #1: ffff8880631c9228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
>  #1: ffff8880631c9228 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
> 3 locks held by syz.7.24/6244:
> 2 locks held by syz.7.24/6245:
>  #0: ffff88807d516420 (sb_writers#12){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:509
>  #1: ffff8880631bdaf8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1072 [inline]
>  #1: ffff8880631bdaf8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: lock_rename fs/namei.c:3681 [inline]
>  #1: ffff8880631bdaf8 (&type->i_mutex_dir_key#8/1){+.+.}-{4:4}, at: __start_renaming+0x148/0x410 fs/namei.c:3777
> 
> =============================================
> 
> NMI backtrace for cpu 0
> CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
>  nmi_cpu_backtrace+0x39e/0x3d0 lib/nmi_backtrace.c:113
>  nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
>  trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
>  __sys_info lib/sys_info.c:157 [inline]
>  sys_info+0x135/0x170 lib/sys_info.c:165
>  check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
>  watchdog+0xfb5/0x1000 kernel/hung_task.c:515
>  kthread+0x711/0x8a0 kernel/kthread.c:463
>  ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
>  </TASK>
> Sending NMI from CPU 0 to CPUs 1:
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 6107 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(full) 
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
> RIP: 0010:hlock_class kernel/locking/lockdep.c:234 [inline]
> RIP: 0010:mark_lock+0x3c/0x190 kernel/locking/lockdep.c:4731
> Code: 00 03 00 83 f9 01 bb 09 00 00 00 83 db 00 83 fa 08 0f 45 da bd 01 00 00 00 89 d9 d3 e5 25 ff 1f 00 00 48 0f a3 05 c4 46 df 11 <73> 10 48 69 c0 c8 00 00 00 48 8d 88 70 f3 1e 93 eb 48 83 3d 4b d6
> RSP: 0018:ffffc90003747518 EFLAGS: 00000007
> RAX: 0000000000000311 RBX: 0000000000000008 RCX: 0000000000000008
> RDX: 0000000000000008 RSI: ffff8880275f48a8 RDI: ffff8880275f3d00
> RBP: 0000000000000100 R08: 0000000000000000 R09: ffffffff8241cc56
> R10: dffffc0000000000 R11: ffffed100e650518 R12: 0000000000000004
> R13: 0000000000000003 R14: ffff8880275f48a8 R15: 0000000000000000
> FS:  00007fc3607da6c0(0000) GS:ffff888125fbc000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000558e8c347168 CR3: 0000000077b26000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  mark_usage kernel/locking/lockdep.c:4674 [inline]
>  __lock_acquire+0x6a8/0xd20 kernel/locking/lockdep.c:5191
>  lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
>  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
>  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
>  spin_lock include/linux/spinlock.h:351 [inline]
>  insert_inode_locked+0x336/0x5d0 fs/inode.c:1837
>  ntfs_new_inode+0xc8/0x100 fs/ntfs3/fsntfs.c:1675
>  ntfs_create_inode+0x606/0x32a0 fs/ntfs3/inode.c:1309
>  ntfs_create+0x3d/0x50 fs/ntfs3/namei.c:110
>  lookup_open fs/namei.c:4409 [inline]
>  open_last_lookups fs/namei.c:4509 [inline]
>  path_openat+0x190f/0x3d90 fs/namei.c:4753
>  do_filp_open+0x1fa/0x410 fs/namei.c:4783
>  do_sys_openat2+0x121/0x1c0 fs/open.c:1432
>  do_sys_open fs/open.c:1447 [inline]
>  __do_sys_openat fs/open.c:1463 [inline]
>  __se_sys_openat fs/open.c:1458 [inline]
>  __x64_sys_openat+0x138/0x170 fs/open.c:1458
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fc35f98f749
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc3607da038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007fc35fbe5fa0 RCX: 00007fc35f98f749
> RDX: 000000000000275a RSI: 00002000000001c0 RDI: ffffffffffffff9c
> RBP: 00007fc35fa13f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fc35fbe6038 R14: 00007fc35fbe5fa0 R15: 00007ffffeb34448
>  </TASK>
> 
> 

#syz test

diff --git a/fs/inode.c b/fs/inode.c
index a62032864ddf..e923f4303872 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -1057,6 +1057,7 @@ static struct inode *find_inode(struct super_block *sb,
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
+		BUG_ON(inode_unhashed(inode));
 		if (unlikely(inode_state_read(inode) & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
@@ -1099,6 +1100,7 @@ static struct inode *find_inode_fast(struct super_block *sb,
 			__wait_on_freeing_inode(inode, is_inode_hash_locked);
 			goto repeat;
 		}
+		BUG_ON(inode_unhashed(inode));
 		if (unlikely(inode_state_read(inode) & I_CREATING)) {
 			spin_unlock(&inode->i_lock);
 			rcu_read_unlock();
@@ -1855,6 +1857,7 @@ int insert_inode_locked(struct inode *inode)
 			spin_unlock(&inode_hash_lock);
 			return 0;
 		}
+		BUG_ON(inode_unhashed(old));
 		if (unlikely(inode_state_read(old) & I_CREATING)) {
 			spin_unlock(&old->i_lock);
 			spin_unlock(&inode_hash_lock);


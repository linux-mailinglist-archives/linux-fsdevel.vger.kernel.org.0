Return-Path: <linux-fsdevel+bounces-29914-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F047983A7B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 01:48:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 321F2283F16
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 23:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74C512D758;
	Mon, 23 Sep 2024 23:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QikXgJaZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8B284A4E
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 23:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727135286; cv=none; b=b6uZ9nU8zaHMaIYXVx8oCmWtZf5L5BDYp6+dHeccAa/QroKfKo3X1KTicmDfeSd8TFHa4fXjYryiRL3aMIZY1mYbyntXGL/3eAqq7+rne+bicHGK+YhsN1s6gAWOV1yS5ReyvGsuyivzrIYnxnz6AhJ75MPjbkIN4Uk0O6Rrz1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727135286; c=relaxed/simple;
	bh=847g93Vo/jOeCpPW+vIwPeQ7sPgttuag1eIOBXpU/Vo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HdP5AXPsdtiZX5kHokb2nRM0Hnfp2wHry7bGNIYqRPKGNZZWZXkB2rGiRSpmlgZAbOOw4PnOMAt0ZabniUHAGUgo7R6SuO3qRpumVWS0nN/kFTeqEApOUUhgFTnfG0wtcxwxC9JNz3xGfsY1SWzMI1KCHUntDc4WdvzPMZHJgr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QikXgJaZ; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-45821ebb4e6so38858051cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 16:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727135282; x=1727740082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3QbHi1VJUuQg1d0T0AG8rjue4fQCDfrIRVDp6qSjxhA=;
        b=QikXgJaZjDYt4PcTPXJH/+Y+Ioob1OL6MrOpo6o03zzMi1WMaISMKF5r2OMiqn0s4/
         aj/E1a1dezOlup3V99GopsTHYudkiUom92PN+Fze8ngjUYnAoIN6h/rY6k4end+W7Zpj
         HXpbjjcQjsUVKK74jPKn+M3OcQXCg1NS4ALuJqmmtLblLAh9KVkvIivypJ5sQe6qIxcm
         PNeKqUl7Hke2Cl3qhjeeR1uE5KgY4XcmLGLNIJyd0HiO7beCCOyy+bHGWJvRzUYewwpf
         GrKx24qLC6gjT5CVdFTq590MkXfx799j3Lm2F3zzBEPyyWfueGFtEDkwmSsjTYxzR1kh
         a/Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727135282; x=1727740082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3QbHi1VJUuQg1d0T0AG8rjue4fQCDfrIRVDp6qSjxhA=;
        b=v9kDcF2LXjRKyJaaz9Dq4QMhnKzZtHxA8ZYDxU4rb1ttVwVBgE4NQfAQAGNsa5RRgB
         ipLw/ZUyrXeqfKas39WYxpNSc4BqD2TFyTCTt8b5N4UN0g9gfv3jZJL5dZt+EXFMrXDC
         VaJ4djfAhhRGwDS7+OTj8/yFueXnI4al+Gjrv0s7w2dYt42SzO5dwI3YrWumG+PiQMg1
         Usz5q3xlF7fYIlkHSgOfz/44h0859GR2Hr+WVxYcesBVf+HTWUe6lzFj7AZB5SK4zduf
         A6ZlKB1StwOP9CHw6bOB+iKErcQhsX9Ft2e/R/XhTYhfBkA7fj7uewP727+aXIp6hYgs
         6j2Q==
X-Forwarded-Encrypted: i=1; AJvYcCUf8ISgqMjvTY/Jszc5EMQqeuqXJVHJWnvOadDSsLUWxZpVcUkVctPrMXE8zAw+5fN0U34OJd79hYbiJPNt@vger.kernel.org
X-Gm-Message-State: AOJu0YwGcqO2/0d9Xd0Hv4JK2uCN0+RmY+wjKDT72s2i8vjhWLsZ3zxZ
	ZJJGOITI1Y0wCJLe31dlOkyGF1oNhh10qZySZuj5O2Nn8P/AyDW59yjuYsBZ8f4X0sNCZbovoRx
	V43v79b+El37UxFLnSeQS+sDHdh3Xka/0hi4=
X-Google-Smtp-Source: AGHT+IErOyvzZp8KhKdXovP7RjALTwovws84/XZIB2DxomzuyhQqAZLC5q4lcSxDIeQYFlZ6gEyWUfLm1ayFrM8T9hU=
X-Received: by 2002:a05:622a:1352:b0:458:3d86:9ab with SMTP id
 d75a77b69052e-45b22920c04mr186733351cf.54.1727135281882; Mon, 23 Sep 2024
 16:48:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529155210.2543295-1-mszeredi@redhat.com> <ZvFEAM6JfrBKsOU0@ly-workstation>
 <CAJnrk1YW10Ex3pxNR1Ew=pm+e1f83qbU4mCAL_TLW-CaEXutZw@mail.gmail.com>
In-Reply-To: <CAJnrk1YW10Ex3pxNR1Ew=pm+e1f83qbU4mCAL_TLW-CaEXutZw@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 23 Sep 2024 16:47:51 -0700
Message-ID: <CAJnrk1YA71v6zTE6iNk297VFK6PVP26SUX+zbb29yF+LG4JM7w@mail.gmail.com>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Peter-Jan Gootzen <pgootzen@nvidia.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Yoray Zack <yorayz@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>, 
	virtualization@lists.linux.dev, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 3:48=E2=80=AFPM Joanne Koong <joannelkoong@gmail.co=
m> wrote:
>
> On Mon, Sep 23, 2024 at 3:34=E2=80=AFAM Lai, Yi <yi1.lai@linux.intel.com>=
 wrote:
> >
> > Hi Miklos Szeredi,
> >
> > Greetings!
> >
> > I used Syzkaller and found that there is WARNING in fuse_request_end in=
 Linux-next tree - next-20240918.
> >
> > After bisection and the first bad commit is:
> > "
> > 5de8acb41c86 fuse: cleanup request queuing towards virtiofs
> > "
> >
> > All detailed into can be found at:
> > https://github.com/laifryiee/syzkaller_logs/tree/main/240922_114402_fus=
e_request_end
> > Syzkaller repro code:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fus=
e_request_end/repro.c
> > Syzkaller repro syscall steps:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fus=
e_request_end/repro.prog
> > Syzkaller report:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fus=
e_request_end/repro.report
> > Kconfig(make olddefconfig):
> > https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fus=
e_request_end/kconfig_origin
> > Bisect info:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fus=
e_request_end/bisect_info.log
> > bzImage:
> > https://github.com/laifryiee/syzkaller_logs/raw/main/240922_114402_fuse=
_request_end/bzImage_55bcd2e0d04c1171d382badef1def1fd04ef66c5
> > Issue dmesg:
> > https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fus=
e_request_end/55bcd2e0d04c1171d382badef1def1fd04ef66c5_dmesg.log
> >
> > "
> > [   31.577123] ------------[ cut here ]------------
> > [   31.578842] WARNING: CPU: 1 PID: 1186 at fs/fuse/dev.c:373 fuse_requ=
est_end+0x7d2/0x910
> > [   31.581269] Modules linked in:
> > [   31.582553] CPU: 1 UID: 0 PID: 1186 Comm: repro Not tainted 6.11.0-n=
ext-20240918-55bcd2e0d04c #1
> > [   31.584332] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), B=
IOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> > [   31.586281] RIP: 0010:fuse_request_end+0x7d2/0x910
> > [   31.587001] Code: ff 48 8b 7d d0 e8 ae 0f 72 ff e9 c2 fb ff ff e8 a4=
 0f 72 ff e9 e7 fb ff ff e8 3a 3b 0a ff 0f 0b e9 17 fa ff ff e8 2e 3b 0a ff=
 <0f> 0b e9 c1 f9 ff ff 4c 89 ff e8 af 0f 72 ff e9 82 f8 ff ff e8 a5
> > [   31.589442] RSP: 0018:ffff88802141f640 EFLAGS: 00010293
> > [   31.590198] RAX: 0000000000000000 RBX: 0000000000000201 RCX: fffffff=
f825d5bb2
> > [   31.591137] RDX: ffff888010b2a500 RSI: ffffffff825d61f2 RDI: 0000000=
000000001
> > [   31.592072] RBP: ffff88802141f680 R08: 0000000000000000 R09: ffffed1=
00356f28e
> > [   31.593010] R10: 0000000000000001 R11: 0000000000000001 R12: ffff888=
01ab79440
> > [   31.594062] R13: ffff88801ab79470 R14: ffff88801dcaa000 R15: ffff888=
00d71fa00
> > [   31.594820] FS:  00007f812eca2640(0000) GS:ffff88806c500000(0000) kn=
lGS:0000000000000000
> > [   31.595670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [   31.596299] CR2: 000055b7baa16b20 CR3: 00000000109b0002 CR4: 0000000=
000770ef0
> > [   31.597054] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000=
000000000
> > [   31.597850] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 0000000=
000000400
> > [   31.598595] PKRU: 55555554
> > [   31.598902] Call Trace:
> > [   31.599180]  <TASK>
> > [   31.599439]  ? show_regs+0x6d/0x80
> > [   31.599805]  ? __warn+0xf3/0x380
> > [   31.600137]  ? report_bug+0x25e/0x4b0
> > [   31.600521]  ? fuse_request_end+0x7d2/0x910
> > [   31.600885]  ? report_bug+0x2cb/0x4b0
> > [   31.601204]  ? fuse_request_end+0x7d2/0x910
> > [   31.601564]  ? fuse_request_end+0x7d3/0x910
> > [   31.601956]  ? handle_bug+0xf1/0x190
> > [   31.602275]  ? exc_invalid_op+0x3c/0x80
> > [   31.602595]  ? asm_exc_invalid_op+0x1f/0x30
> > [   31.602959]  ? fuse_request_end+0x192/0x910
> > [   31.603301]  ? fuse_request_end+0x7d2/0x910
> > [   31.603643]  ? fuse_request_end+0x7d2/0x910
> > [   31.603988]  ? do_raw_spin_unlock+0x15c/0x210
> > [   31.604366]  fuse_dev_queue_req+0x23c/0x2b0
> > [   31.604714]  fuse_send_one+0x1d1/0x360
> > [   31.605031]  fuse_simple_request+0x348/0xd30
> > [   31.605385]  ? lockdep_hardirqs_on+0x89/0x110
> > [   31.605755]  fuse_send_open+0x234/0x2f0
> > [   31.606126]  ? __pfx_fuse_send_open+0x10/0x10
> > [   31.606487]  ? kasan_save_track+0x18/0x40
> > [   31.606834]  ? lockdep_init_map_type+0x2df/0x810
> > [   31.607227]  ? __kasan_check_write+0x18/0x20
> > [   31.607591]  fuse_file_open+0x2bc/0x770
> > [   31.607921]  fuse_do_open+0x5d/0xe0
> > [   31.608215]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> > [   31.608681]  fuse_dir_open+0x138/0x220
> > [   31.609005]  do_dentry_open+0x6be/0x1390
> > [   31.609358]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> > [   31.609861]  ? __pfx_fuse_dir_open+0x10/0x10
> > [   31.610240]  vfs_open+0x87/0x3f0
> > [   31.610523]  ? may_open+0x205/0x430
> > [   31.610834]  path_openat+0x23b7/0x32d0
> > [   31.611161]  ? __pfx_path_openat+0x10/0x10
> > [   31.611502]  ? lock_acquire.part.0+0x152/0x390
> > [   31.611874]  ? __this_cpu_preempt_check+0x21/0x30
> > [   31.612266]  ? lock_is_held_type+0xef/0x150
> > [   31.612611]  ? __this_cpu_preempt_check+0x21/0x30
> > [   31.613002]  do_filp_open+0x1cc/0x420
> > [   31.613316]  ? __pfx_do_filp_open+0x10/0x10
> > [   31.613669]  ? lock_release+0x441/0x870
> > [   31.614043]  ? __pfx_lock_release+0x10/0x10
> > [   31.614404]  ? do_raw_spin_unlock+0x15c/0x210
> > [   31.614784]  do_sys_openat2+0x185/0x1f0
> > [   31.615105]  ? __pfx_do_sys_openat2+0x10/0x10
> > [   31.615470]  ? __this_cpu_preempt_check+0x21/0x30
> > [   31.615854]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> > [   31.616370]  ? lockdep_hardirqs_on+0x89/0x110
> > [   31.616736]  __x64_sys_openat+0x17a/0x240
> > [   31.617067]  ? __pfx___x64_sys_openat+0x10/0x10
> > [   31.617447]  ? __audit_syscall_entry+0x39c/0x500
> > [   31.617870]  x64_sys_call+0x1a52/0x20d0
> > [   31.618194]  do_syscall_64+0x6d/0x140
> > [   31.618504]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [   31.618917] RIP: 0033:0x7f812eb3e8c4
> > [   31.619225] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 76 d3 f5 ff 44=
 8b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05=
 <48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 c8 d3 f5 ff 8b 44
> > [   31.620656] RSP: 002b:00007f812eca1b90 EFLAGS: 00000293 ORIG_RAX: 00=
00000000000101
> > [   31.621255] RAX: ffffffffffffffda RBX: 00007f812eca2640 RCX: 00007f8=
12eb3e8c4
> > [   31.621864] RDX: 0000000000010000 RSI: 0000000020002080 RDI: 0000000=
0ffffff9c
> > [   31.622428] RBP: 0000000020002080 R08: 0000000000000000 R09: 0000000=
000000000
> > [   31.622987] R10: 0000000000000000 R11: 0000000000000293 R12: 0000000=
000010000
> > [   31.623549] R13: 0000000000000006 R14: 00007f812ea9f560 R15: 0000000=
000000000
> > [   31.624123]  </TASK>
> > [   31.624316] irq event stamp: 1655
> > [   31.624595] hardirqs last  enabled at (1663): [<ffffffff8145cb85>] _=
_up_console_sem+0x95/0xb0
> > [   31.625310] hardirqs last disabled at (1670): [<ffffffff8145cb6a>] _=
_up_console_sem+0x7a/0xb0
> > [   31.626039] softirqs last  enabled at (1466): [<ffffffff8128a889>] _=
_irq_exit_rcu+0xa9/0x120
> > [   31.626726] softirqs last disabled at (1449): [<ffffffff8128a889>] _=
_irq_exit_rcu+0xa9/0x120
> > [   31.627405] ---[ end trace 0000000000000000 ]---
> > "
> >
> > I hope you find it useful.
> >
> > Regards,
> > Yi Lai
> >
> > ---
> >
> > If you don't need the following environment to reproduce the problem or=
 if you
> > already have one reproduced environment, please ignore the following in=
formation.
> >
> > How to reproduce:
> > git clone https://gitlab.com/xupengfe/repro_vm_env.git
> > cd repro_vm_env
> > tar -xvf repro_vm_env.tar.gz
> > cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used=
 v7.1.0
> >   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f=
65 v6.2-rc5 kernel
> >   // You could change the bzImage_xxx as you want
> >   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,rea=
donly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> > You could use below command to log in, there is no password for root.
> > ssh -p 10023 root@localhost
> >
> > After login vm(virtual machine) successfully, you could transfer reprod=
uced
> > binary to the vm by below way, and reproduce the problem in vm:
> > gcc -pthread -o repro repro.c
> > scp -P 10023 repro root@localhost:/root/
> >
> > Get the bzImage for target kernel:
> > Please use target kconfig and copy it to kernel_src/.config
> > make olddefconfig
> > make -jx bzImage           //x should equal or less than cpu num your p=
c has
> >
> > Fill the bzImage file into above start3.sh to load the target kernel in=
 vm.
> >
> > Tips:
> > If you already have qemu-system-x86_64, please ignore below info.
> > If you want to install qemu v7.1.0 version:
> > git clone https://github.com/qemu/qemu.git
> > cd qemu
> > git checkout -f v7.1.0
> > mkdir build
> > cd build
> > yum install -y ninja-build.x86_64
> > yum -y install libslirp-devel.x86_64
> > ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc -=
-enable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> > make
> > make install
> >
> > On Wed, May 29, 2024 at 05:52:07PM +0200, Miklos Szeredi wrote:
> > > Virtiofs has its own queing mechanism, but still requests are first q=
ueued
> > > on fiq->pending to be immediately dequeued and queued onto the virtio
> > > queue.
> > >
> > > The queuing on fiq->pending is unnecessary and might even have some
> > > performance impact due to being a contention point.
> > >
> > > Forget requests are handled similarly.
> > >
> > > Move the queuing of requests and forgets into the fiq->ops->*.
> > > fuse_iqueue_ops are renamed to reflect the new semantics.
> > >
> > > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > > ---
> > >  fs/fuse/dev.c       | 159 ++++++++++++++++++++++++------------------=
--
> > >  fs/fuse/fuse_i.h    |  19 ++----
> > >  fs/fuse/virtio_fs.c |  41 ++++--------
> > >  3 files changed, 106 insertions(+), 113 deletions(-)
> > >
> > > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > > index 9eb191b5c4de..a4f510f1b1a4 100644
> > > --- a/fs/fuse/dev.c
> > > +++ b/fs/fuse/dev.c
> > > @@ -192,10 +192,22 @@ unsigned int fuse_len_args(unsigned int numargs=
, struct fuse_arg *args)
> > >  }
> > >  EXPORT_SYMBOL_GPL(fuse_len_args);
> > >
> > > -u64 fuse_get_unique(struct fuse_iqueue *fiq)
> > > +static u64 fuse_get_unique_locked(struct fuse_iqueue *fiq)
> > >  {
> > >       fiq->reqctr +=3D FUSE_REQ_ID_STEP;
> > >       return fiq->reqctr;
> > > +
> > > +}
> > > +
> > > +u64 fuse_get_unique(struct fuse_iqueue *fiq)
> > > +{
> > > +     u64 ret;
> > > +
> > > +     spin_lock(&fiq->lock);
> > > +     ret =3D fuse_get_unique_locked(fiq);
> > > +     spin_unlock(&fiq->lock);
> > > +
> > > +     return ret;
> > >  }
> > >  EXPORT_SYMBOL_GPL(fuse_get_unique);
> > >
> > > @@ -215,22 +227,67 @@ __releases(fiq->lock)
> > >       spin_unlock(&fiq->lock);
> > >  }
> > >
> > > +static void fuse_dev_queue_forget(struct fuse_iqueue *fiq, struct fu=
se_forget_link *forget)
> > > +{
> > > +     spin_lock(&fiq->lock);
> > > +     if (fiq->connected) {
> > > +             fiq->forget_list_tail->next =3D forget;
> > > +             fiq->forget_list_tail =3D forget;
> > > +             fuse_dev_wake_and_unlock(fiq);
> > > +     } else {
> > > +             kfree(forget);
> > > +             spin_unlock(&fiq->lock);
> > > +     }
> > > +}
> > > +
> > > +static void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct=
 fuse_req *req)
> > > +{
> > > +     spin_lock(&fiq->lock);
> > > +     if (list_empty(&req->intr_entry)) {
> > > +             list_add_tail(&req->intr_entry, &fiq->interrupts);
> > > +             /*
> > > +              * Pairs with smp_mb() implied by test_and_set_bit()
> > > +              * from fuse_request_end().
> > > +              */
> > > +             smp_mb();
> > > +             if (test_bit(FR_FINISHED, &req->flags)) {
> > > +                     list_del_init(&req->intr_entry);
> > > +                     spin_unlock(&fiq->lock);
> > > +             }
> > > +             fuse_dev_wake_and_unlock(fiq);
> > > +     } else {
> > > +             spin_unlock(&fiq->lock);
> > > +     }
> > > +}
> > > +
> > > +static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_=
req *req)
> > > +{
> > > +     spin_lock(&fiq->lock);
> > > +     if (fiq->connected) {
> > > +             if (req->in.h.opcode !=3D FUSE_NOTIFY_REPLY)
> > > +                     req->in.h.unique =3D fuse_get_unique_locked(fiq=
);
> > > +             list_add_tail(&req->list, &fiq->pending);
> > > +             fuse_dev_wake_and_unlock(fiq);
> > > +     } else {
> > > +             spin_unlock(&fiq->lock);
> > > +             req->out.h.error =3D -ENOTCONN;
> > > +             fuse_request_end(req);
>
> in the case where the connection has been aborted, this request will
> still have the FR_PENDING flag set on it when it calls
> fuse_request_end(). I think we can just call fuse_put_request() here
> instead.

actually, after looking more at this, I missed that this patch changes
the logic to now call request_wait_answer() (for non-background
requests) even if the connection was aborted.
So maybe just clear_bit(FR_PENDING, &req->flags) before we call
fuse_request_end() is the best.

>
> > > +     }
> > > +}
> > > +


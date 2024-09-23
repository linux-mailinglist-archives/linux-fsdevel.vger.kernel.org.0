Return-Path: <linux-fsdevel+bounces-29912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECED9839E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 01:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44E8F2827CA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Sep 2024 22:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02CD8126BE7;
	Mon, 23 Sep 2024 22:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JvoxH8u1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 326E04D8BB
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 22:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727131696; cv=none; b=M5G5iFQbtmqXQiSYhpwPWgVqA9N7ydRvLOCMi6wgXzFNlfPb9Mz3Bz8uvOG2Pvf7GSkmf2edIIvs30czyrIHMynsA849VY8bOMAQNPpG9zTNdqzS4qt+Cfs6Tse36TshFBdGbDI0Z4xEGZhStmPG39y1QLSfrnYQ19tcoSQerdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727131696; c=relaxed/simple;
	bh=2TfNUhjBuxzXESrdMrzliulZbbGvwZeTYbNhgl4+S7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfinRwD7S5+7K6t3WHsmGC7tEcMO2VZOEXU4FaLAkI518D3Kg/ITJcUigoYDDreItEFCcb/xY68yOPk/R06XIFpRgg0jWY1pscBSA5FT+czlvy7+gjG9OiAA+vV8THdmfOeTfhYXHjz4FXLCo6OUfAiq6bR2DIUgvyecvyw1kmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JvoxH8u1; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-458311b338eso41068601cf.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Sep 2024 15:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727131693; x=1727736493; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Oi/vVL0LE4ZAu1EXvzxKObhVDPyUQBOmmaqxcfVhJyo=;
        b=JvoxH8u1aPchENDYDMPNFP9hi8sA8IAlrD2rC2r3LBRUamQfws8fY+f5exfw+x2los
         CJWxfo45YFJ0SGlZfwxCKNa6qg3qJ9n5U5Mx3fyoqZv9Lnxtae9gf1ghLAiiIl7RHoT5
         oN0iPqkLtl3LeGEd6i3t890F2D9HWI43/4J5+oQgK5KIXOfDZUoMF9cH7WINPknomFJ3
         e5xEiHutonDJ1iztb1wZtHYnrTcHrZ5NczLr1ucRW7JQXvDohi+W0FrGSYyp0EFwtmUS
         K97Z3MmvBwPjsfNfz+FS/pAm6Vluadwf3pUtQhEnvBek/vVIYT0R7vuYVYrhZl7CLJKS
         3QSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727131693; x=1727736493;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Oi/vVL0LE4ZAu1EXvzxKObhVDPyUQBOmmaqxcfVhJyo=;
        b=K1QPiFKdlyCWq3Blk1sR715lYOG+ffmRP4rJXijufOBEgo4CsgPzwsee0NCRtAcCwc
         kE5OuDoviGPwk7uzFN5E08HVkRFRGGbh4Tvtoei62P4Vqx7IwMBTRN5k7ndpnulKfZ18
         Bt7n/Shl23PDnyfb3aokcd8GZ1jOWbqS6Cmk1YyKIZeHqeBFszFDgXCBxYUGlX2u4LQ/
         jlrFOZ70FmXtNSS6ySZvw7z6H9+uV3NWcjayhdFQQPEgLG51O0lQQpaUYIID24ZiURZ1
         CmtU+ijzhKXr0FdqwVw8o00236Crz62hLCA6ouP5rZihJ8Kbx0DJnj/KGSQgXlF2PQ4X
         srjQ==
X-Forwarded-Encrypted: i=1; AJvYcCXRsXBM1Bl+RcchhZ6AeUsucE4fqJFHD2dlxg+jLaRuLn3cgZejWzgG2MmTFAl7mbdbAHB4aePV0AHN0c2c@vger.kernel.org
X-Gm-Message-State: AOJu0YwyWcvVi8QZmTvMVxGa9wUkn6q3Gyyut8gB4hCrkqotvDqTQ2U1
	1mjbLSDMcuaM+/ZiWc/VffcLvOVcJRH2W6k8bhw54JmL4otP9W/GV3ZmOedqO7xHDDkiF/pJZIE
	NM0JkqwV46a3DyyblUIDHqHf4mDg=
X-Google-Smtp-Source: AGHT+IGdtHOCbjwSLtFx5QaVnNoXFoU09skZr5M4aeQcAyG0VDe7JI1hTfgCzuFyBDyRc8ktgMO0B3s20Bxl0o6OVPQ=
X-Received: by 2002:ac8:57d6:0:b0:458:2c40:e08b with SMTP id
 d75a77b69052e-45b20502128mr205454821cf.30.1727131692603; Mon, 23 Sep 2024
 15:48:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529155210.2543295-1-mszeredi@redhat.com> <ZvFEAM6JfrBKsOU0@ly-workstation>
In-Reply-To: <ZvFEAM6JfrBKsOU0@ly-workstation>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Mon, 23 Sep 2024 15:48:01 -0700
Message-ID: <CAJnrk1YW10Ex3pxNR1Ew=pm+e1f83qbU4mCAL_TLW-CaEXutZw@mail.gmail.com>
Subject: Re: [PATCH] fuse: cleanup request queuing towards virtiofs
To: "Lai, Yi" <yi1.lai@linux.intel.com>
Cc: Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org, 
	Peter-Jan Gootzen <pgootzen@nvidia.com>, Jingbo Xu <jefflexu@linux.alibaba.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Yoray Zack <yorayz@nvidia.com>, Vivek Goyal <vgoyal@redhat.com>, 
	virtualization@lists.linux.dev, yi1.lai@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 3:34=E2=80=AFAM Lai, Yi <yi1.lai@linux.intel.com> w=
rote:
>
> Hi Miklos Szeredi,
>
> Greetings!
>
> I used Syzkaller and found that there is WARNING in fuse_request_end in L=
inux-next tree - next-20240918.
>
> After bisection and the first bad commit is:
> "
> 5de8acb41c86 fuse: cleanup request queuing towards virtiofs
> "
>
> All detailed into can be found at:
> https://github.com/laifryiee/syzkaller_logs/tree/main/240922_114402_fuse_=
request_end
> Syzkaller repro code:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fuse_=
request_end/repro.c
> Syzkaller repro syscall steps:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fuse_=
request_end/repro.prog
> Syzkaller report:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fuse_=
request_end/repro.report
> Kconfig(make olddefconfig):
> https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fuse_=
request_end/kconfig_origin
> Bisect info:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fuse_=
request_end/bisect_info.log
> bzImage:
> https://github.com/laifryiee/syzkaller_logs/raw/main/240922_114402_fuse_r=
equest_end/bzImage_55bcd2e0d04c1171d382badef1def1fd04ef66c5
> Issue dmesg:
> https://github.com/laifryiee/syzkaller_logs/blob/main/240922_114402_fuse_=
request_end/55bcd2e0d04c1171d382badef1def1fd04ef66c5_dmesg.log
>
> "
> [   31.577123] ------------[ cut here ]------------
> [   31.578842] WARNING: CPU: 1 PID: 1186 at fs/fuse/dev.c:373 fuse_reques=
t_end+0x7d2/0x910
> [   31.581269] Modules linked in:
> [   31.582553] CPU: 1 UID: 0 PID: 1186 Comm: repro Not tainted 6.11.0-nex=
t-20240918-55bcd2e0d04c #1
> [   31.584332] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [   31.586281] RIP: 0010:fuse_request_end+0x7d2/0x910
> [   31.587001] Code: ff 48 8b 7d d0 e8 ae 0f 72 ff e9 c2 fb ff ff e8 a4 0=
f 72 ff e9 e7 fb ff ff e8 3a 3b 0a ff 0f 0b e9 17 fa ff ff e8 2e 3b 0a ff <=
0f> 0b e9 c1 f9 ff ff 4c 89 ff e8 af 0f 72 ff e9 82 f8 ff ff e8 a5
> [   31.589442] RSP: 0018:ffff88802141f640 EFLAGS: 00010293
> [   31.590198] RAX: 0000000000000000 RBX: 0000000000000201 RCX: ffffffff8=
25d5bb2
> [   31.591137] RDX: ffff888010b2a500 RSI: ffffffff825d61f2 RDI: 000000000=
0000001
> [   31.592072] RBP: ffff88802141f680 R08: 0000000000000000 R09: ffffed100=
356f28e
> [   31.593010] R10: 0000000000000001 R11: 0000000000000001 R12: ffff88801=
ab79440
> [   31.594062] R13: ffff88801ab79470 R14: ffff88801dcaa000 R15: ffff88800=
d71fa00
> [   31.594820] FS:  00007f812eca2640(0000) GS:ffff88806c500000(0000) knlG=
S:0000000000000000
> [   31.595670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [   31.596299] CR2: 000055b7baa16b20 CR3: 00000000109b0002 CR4: 000000000=
0770ef0
> [   31.597054] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [   31.597850] DR3: 0000000000000000 DR6: 00000000ffff07f0 DR7: 000000000=
0000400
> [   31.598595] PKRU: 55555554
> [   31.598902] Call Trace:
> [   31.599180]  <TASK>
> [   31.599439]  ? show_regs+0x6d/0x80
> [   31.599805]  ? __warn+0xf3/0x380
> [   31.600137]  ? report_bug+0x25e/0x4b0
> [   31.600521]  ? fuse_request_end+0x7d2/0x910
> [   31.600885]  ? report_bug+0x2cb/0x4b0
> [   31.601204]  ? fuse_request_end+0x7d2/0x910
> [   31.601564]  ? fuse_request_end+0x7d3/0x910
> [   31.601956]  ? handle_bug+0xf1/0x190
> [   31.602275]  ? exc_invalid_op+0x3c/0x80
> [   31.602595]  ? asm_exc_invalid_op+0x1f/0x30
> [   31.602959]  ? fuse_request_end+0x192/0x910
> [   31.603301]  ? fuse_request_end+0x7d2/0x910
> [   31.603643]  ? fuse_request_end+0x7d2/0x910
> [   31.603988]  ? do_raw_spin_unlock+0x15c/0x210
> [   31.604366]  fuse_dev_queue_req+0x23c/0x2b0
> [   31.604714]  fuse_send_one+0x1d1/0x360
> [   31.605031]  fuse_simple_request+0x348/0xd30
> [   31.605385]  ? lockdep_hardirqs_on+0x89/0x110
> [   31.605755]  fuse_send_open+0x234/0x2f0
> [   31.606126]  ? __pfx_fuse_send_open+0x10/0x10
> [   31.606487]  ? kasan_save_track+0x18/0x40
> [   31.606834]  ? lockdep_init_map_type+0x2df/0x810
> [   31.607227]  ? __kasan_check_write+0x18/0x20
> [   31.607591]  fuse_file_open+0x2bc/0x770
> [   31.607921]  fuse_do_open+0x5d/0xe0
> [   31.608215]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   31.608681]  fuse_dir_open+0x138/0x220
> [   31.609005]  do_dentry_open+0x6be/0x1390
> [   31.609358]  ? __sanitizer_cov_trace_const_cmp4+0x1a/0x20
> [   31.609861]  ? __pfx_fuse_dir_open+0x10/0x10
> [   31.610240]  vfs_open+0x87/0x3f0
> [   31.610523]  ? may_open+0x205/0x430
> [   31.610834]  path_openat+0x23b7/0x32d0
> [   31.611161]  ? __pfx_path_openat+0x10/0x10
> [   31.611502]  ? lock_acquire.part.0+0x152/0x390
> [   31.611874]  ? __this_cpu_preempt_check+0x21/0x30
> [   31.612266]  ? lock_is_held_type+0xef/0x150
> [   31.612611]  ? __this_cpu_preempt_check+0x21/0x30
> [   31.613002]  do_filp_open+0x1cc/0x420
> [   31.613316]  ? __pfx_do_filp_open+0x10/0x10
> [   31.613669]  ? lock_release+0x441/0x870
> [   31.614043]  ? __pfx_lock_release+0x10/0x10
> [   31.614404]  ? do_raw_spin_unlock+0x15c/0x210
> [   31.614784]  do_sys_openat2+0x185/0x1f0
> [   31.615105]  ? __pfx_do_sys_openat2+0x10/0x10
> [   31.615470]  ? __this_cpu_preempt_check+0x21/0x30
> [   31.615854]  ? seqcount_lockdep_reader_access.constprop.0+0xb4/0xd0
> [   31.616370]  ? lockdep_hardirqs_on+0x89/0x110
> [   31.616736]  __x64_sys_openat+0x17a/0x240
> [   31.617067]  ? __pfx___x64_sys_openat+0x10/0x10
> [   31.617447]  ? __audit_syscall_entry+0x39c/0x500
> [   31.617870]  x64_sys_call+0x1a52/0x20d0
> [   31.618194]  do_syscall_64+0x6d/0x140
> [   31.618504]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> [   31.618917] RIP: 0033:0x7f812eb3e8c4
> [   31.619225] Code: 24 20 eb 8f 66 90 44 89 54 24 0c e8 76 d3 f5 ff 44 8=
b 54 24 0c 44 89 e2 48 89 ee 41 89 c0 bf 9c ff ff ff b8 01 01 00 00 0f 05 <=
48> 3d 00 f0 ff ff 77 34 44 89 c7 89 44 24 0c e8 c8 d3 f5 ff 8b 44
> [   31.620656] RSP: 002b:00007f812eca1b90 EFLAGS: 00000293 ORIG_RAX: 0000=
000000000101
> [   31.621255] RAX: ffffffffffffffda RBX: 00007f812eca2640 RCX: 00007f812=
eb3e8c4
> [   31.621864] RDX: 0000000000010000 RSI: 0000000020002080 RDI: 00000000f=
fffff9c
> [   31.622428] RBP: 0000000020002080 R08: 0000000000000000 R09: 000000000=
0000000
> [   31.622987] R10: 0000000000000000 R11: 0000000000000293 R12: 000000000=
0010000
> [   31.623549] R13: 0000000000000006 R14: 00007f812ea9f560 R15: 000000000=
0000000
> [   31.624123]  </TASK>
> [   31.624316] irq event stamp: 1655
> [   31.624595] hardirqs last  enabled at (1663): [<ffffffff8145cb85>] __u=
p_console_sem+0x95/0xb0
> [   31.625310] hardirqs last disabled at (1670): [<ffffffff8145cb6a>] __u=
p_console_sem+0x7a/0xb0
> [   31.626039] softirqs last  enabled at (1466): [<ffffffff8128a889>] __i=
rq_exit_rcu+0xa9/0x120
> [   31.626726] softirqs last disabled at (1449): [<ffffffff8128a889>] __i=
rq_exit_rcu+0xa9/0x120
> [   31.627405] ---[ end trace 0000000000000000 ]---
> "
>
> I hope you find it useful.
>
> Regards,
> Yi Lai
>
> ---
>
> If you don't need the following environment to reproduce the problem or i=
f you
> already have one reproduced environment, please ignore the following info=
rmation.
>
> How to reproduce:
> git clone https://gitlab.com/xupengfe/repro_vm_env.git
> cd repro_vm_env
> tar -xvf repro_vm_env.tar.gz
> cd repro_vm_env; ./start3.sh  // it needs qemu-system-x86_64 and I used v=
7.1.0
>   // start3.sh will load bzImage_2241ab53cbb5cdb08a6b2d4688feb13971058f65=
 v6.2-rc5 kernel
>   // You could change the bzImage_xxx as you want
>   // Maybe you need to remove line "-drive if=3Dpflash,format=3Draw,reado=
nly=3Don,file=3D./OVMF_CODE.fd \" for different qemu version
> You could use below command to log in, there is no password for root.
> ssh -p 10023 root@localhost
>
> After login vm(virtual machine) successfully, you could transfer reproduc=
ed
> binary to the vm by below way, and reproduce the problem in vm:
> gcc -pthread -o repro repro.c
> scp -P 10023 repro root@localhost:/root/
>
> Get the bzImage for target kernel:
> Please use target kconfig and copy it to kernel_src/.config
> make olddefconfig
> make -jx bzImage           //x should equal or less than cpu num your pc =
has
>
> Fill the bzImage file into above start3.sh to load the target kernel in v=
m.
>
> Tips:
> If you already have qemu-system-x86_64, please ignore below info.
> If you want to install qemu v7.1.0 version:
> git clone https://github.com/qemu/qemu.git
> cd qemu
> git checkout -f v7.1.0
> mkdir build
> cd build
> yum install -y ninja-build.x86_64
> yum -y install libslirp-devel.x86_64
> ../configure --target-list=3Dx86_64-softmmu --enable-kvm --enable-vnc --e=
nable-gtk --enable-sdl --enable-usb-redir --enable-slirp
> make
> make install
>
> On Wed, May 29, 2024 at 05:52:07PM +0200, Miklos Szeredi wrote:
> > Virtiofs has its own queing mechanism, but still requests are first que=
ued
> > on fiq->pending to be immediately dequeued and queued onto the virtio
> > queue.
> >
> > The queuing on fiq->pending is unnecessary and might even have some
> > performance impact due to being a contention point.
> >
> > Forget requests are handled similarly.
> >
> > Move the queuing of requests and forgets into the fiq->ops->*.
> > fuse_iqueue_ops are renamed to reflect the new semantics.
> >
> > Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>
> > ---
> >  fs/fuse/dev.c       | 159 ++++++++++++++++++++++++--------------------
> >  fs/fuse/fuse_i.h    |  19 ++----
> >  fs/fuse/virtio_fs.c |  41 ++++--------
> >  3 files changed, 106 insertions(+), 113 deletions(-)
> >
> > diff --git a/fs/fuse/dev.c b/fs/fuse/dev.c
> > index 9eb191b5c4de..a4f510f1b1a4 100644
> > --- a/fs/fuse/dev.c
> > +++ b/fs/fuse/dev.c
> > @@ -192,10 +192,22 @@ unsigned int fuse_len_args(unsigned int numargs, =
struct fuse_arg *args)
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_len_args);
> >
> > -u64 fuse_get_unique(struct fuse_iqueue *fiq)
> > +static u64 fuse_get_unique_locked(struct fuse_iqueue *fiq)
> >  {
> >       fiq->reqctr +=3D FUSE_REQ_ID_STEP;
> >       return fiq->reqctr;
> > +
> > +}
> > +
> > +u64 fuse_get_unique(struct fuse_iqueue *fiq)
> > +{
> > +     u64 ret;
> > +
> > +     spin_lock(&fiq->lock);
> > +     ret =3D fuse_get_unique_locked(fiq);
> > +     spin_unlock(&fiq->lock);
> > +
> > +     return ret;
> >  }
> >  EXPORT_SYMBOL_GPL(fuse_get_unique);
> >
> > @@ -215,22 +227,67 @@ __releases(fiq->lock)
> >       spin_unlock(&fiq->lock);
> >  }
> >
> > +static void fuse_dev_queue_forget(struct fuse_iqueue *fiq, struct fuse=
_forget_link *forget)
> > +{
> > +     spin_lock(&fiq->lock);
> > +     if (fiq->connected) {
> > +             fiq->forget_list_tail->next =3D forget;
> > +             fiq->forget_list_tail =3D forget;
> > +             fuse_dev_wake_and_unlock(fiq);
> > +     } else {
> > +             kfree(forget);
> > +             spin_unlock(&fiq->lock);
> > +     }
> > +}
> > +
> > +static void fuse_dev_queue_interrupt(struct fuse_iqueue *fiq, struct f=
use_req *req)
> > +{
> > +     spin_lock(&fiq->lock);
> > +     if (list_empty(&req->intr_entry)) {
> > +             list_add_tail(&req->intr_entry, &fiq->interrupts);
> > +             /*
> > +              * Pairs with smp_mb() implied by test_and_set_bit()
> > +              * from fuse_request_end().
> > +              */
> > +             smp_mb();
> > +             if (test_bit(FR_FINISHED, &req->flags)) {
> > +                     list_del_init(&req->intr_entry);
> > +                     spin_unlock(&fiq->lock);
> > +             }
> > +             fuse_dev_wake_and_unlock(fiq);
> > +     } else {
> > +             spin_unlock(&fiq->lock);
> > +     }
> > +}
> > +
> > +static void fuse_dev_queue_req(struct fuse_iqueue *fiq, struct fuse_re=
q *req)
> > +{
> > +     spin_lock(&fiq->lock);
> > +     if (fiq->connected) {
> > +             if (req->in.h.opcode !=3D FUSE_NOTIFY_REPLY)
> > +                     req->in.h.unique =3D fuse_get_unique_locked(fiq);
> > +             list_add_tail(&req->list, &fiq->pending);
> > +             fuse_dev_wake_and_unlock(fiq);
> > +     } else {
> > +             spin_unlock(&fiq->lock);
> > +             req->out.h.error =3D -ENOTCONN;
> > +             fuse_request_end(req);

in the case where the connection has been aborted, this request will
still have the FR_PENDING flag set on it when it calls
fuse_request_end(). I think we can just call fuse_put_request() here
instead.

> > +     }
> > +}
> > +
> >  const struct fuse_iqueue_ops fuse_dev_fiq_ops =3D {
> > -     .wake_forget_and_unlock         =3D fuse_dev_wake_and_unlock,
> > -     .wake_interrupt_and_unlock      =3D fuse_dev_wake_and_unlock,
> > -     .wake_pending_and_unlock        =3D fuse_dev_wake_and_unlock,
> > +     .send_forget    =3D fuse_dev_queue_forget,
> > +     .send_interrupt =3D fuse_dev_queue_interrupt,
> > +     .send_req       =3D fuse_dev_queue_req,
> >  };
> >  EXPORT_SYMBOL_GPL(fuse_dev_fiq_ops);
> >
> > -static void queue_request_and_unlock(struct fuse_iqueue *fiq,
> > -                                  struct fuse_req *req)
> > -__releases(fiq->lock)
> > +static void fuse_send_one(struct fuse_iqueue *fiq, struct fuse_req *re=
q)
> >  {
> >       req->in.h.len =3D sizeof(struct fuse_in_header) +
> >               fuse_len_args(req->args->in_numargs,
> >                             (struct fuse_arg *) req->args->in_args);
> > -     list_add_tail(&req->list, &fiq->pending);
> > -     fiq->ops->wake_pending_and_unlock(fiq);
> > +     fiq->ops->send_req(fiq, req);
> >  }
> >
> >  void fuse_queue_forget(struct fuse_conn *fc, struct fuse_forget_link *=
forget,
> > @@ -241,15 +298,7 @@ void fuse_queue_forget(struct fuse_conn *fc, struc=
t fuse_forget_link *forget,
> >       forget->forget_one.nodeid =3D nodeid;
> >       forget->forget_one.nlookup =3D nlookup;
> >
> > -     spin_lock(&fiq->lock);
> > -     if (fiq->connected) {
> > -             fiq->forget_list_tail->next =3D forget;
> > -             fiq->forget_list_tail =3D forget;
> > -             fiq->ops->wake_forget_and_unlock(fiq);
> > -     } else {
> > -             kfree(forget);
> > -             spin_unlock(&fiq->lock);
> > -     }
> > +     fiq->ops->send_forget(fiq, forget);
> >  }
> >
> >  static void flush_bg_queue(struct fuse_conn *fc)
> > @@ -263,9 +312,7 @@ static void flush_bg_queue(struct fuse_conn *fc)
> >               req =3D list_first_entry(&fc->bg_queue, struct fuse_req, =
list);
> >               list_del(&req->list);
> >               fc->active_background++;
> > -             spin_lock(&fiq->lock);
> > -             req->in.h.unique =3D fuse_get_unique(fiq);
> > -             queue_request_and_unlock(fiq, req);
> > +             fuse_send_one(fiq, req);
> >       }
> >  }
> >
> > @@ -335,29 +382,12 @@ static int queue_interrupt(struct fuse_req *req)
> >  {
> >       struct fuse_iqueue *fiq =3D &req->fm->fc->iq;
> >
> > -     spin_lock(&fiq->lock);
> >       /* Check for we've sent request to interrupt this req */
> > -     if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags))) {
> > -             spin_unlock(&fiq->lock);
> > +     if (unlikely(!test_bit(FR_INTERRUPTED, &req->flags)))
> >               return -EINVAL;
> > -     }
> >
> > -     if (list_empty(&req->intr_entry)) {
> > -             list_add_tail(&req->intr_entry, &fiq->interrupts);
> > -             /*
> > -              * Pairs with smp_mb() implied by test_and_set_bit()
> > -              * from fuse_request_end().
> > -              */
> > -             smp_mb();
> > -             if (test_bit(FR_FINISHED, &req->flags)) {
> > -                     list_del_init(&req->intr_entry);
> > -                     spin_unlock(&fiq->lock);
> > -                     return 0;
> > -             }
> > -             fiq->ops->wake_interrupt_and_unlock(fiq);
> > -     } else {
> > -             spin_unlock(&fiq->lock);
> > -     }
> > +     fiq->ops->send_interrupt(fiq, req);
> > +
> >       return 0;
> >  }
> >
> > @@ -412,21 +442,15 @@ static void __fuse_request_send(struct fuse_req *=
req)
> >       struct fuse_iqueue *fiq =3D &req->fm->fc->iq;
> >
> >       BUG_ON(test_bit(FR_BACKGROUND, &req->flags));
> > -     spin_lock(&fiq->lock);
> > -     if (!fiq->connected) {
> > -             spin_unlock(&fiq->lock);
> > -             req->out.h.error =3D -ENOTCONN;
> > -     } else {
> > -             req->in.h.unique =3D fuse_get_unique(fiq);
> > -             /* acquire extra reference, since request is still needed
> > -                after fuse_request_end() */
> > -             __fuse_get_request(req);
> > -             queue_request_and_unlock(fiq, req);
> >
> > -             request_wait_answer(req);
> > -             /* Pairs with smp_wmb() in fuse_request_end() */
> > -             smp_rmb();
> > -     }
> > +     /* acquire extra reference, since request is still needed after
> > +        fuse_request_end() */
> > +     __fuse_get_request(req);
> > +     fuse_send_one(fiq, req);
> > +
> > +     request_wait_answer(req);
> > +     /* Pairs with smp_wmb() in fuse_request_end() */
> > +     smp_rmb();
> >  }
> >
> >  static void fuse_adjust_compat(struct fuse_conn *fc, struct fuse_args =
*args)
> > @@ -581,7 +605,6 @@ static int fuse_simple_notify_reply(struct fuse_mou=
nt *fm,
> >  {
> >       struct fuse_req *req;
> >       struct fuse_iqueue *fiq =3D &fm->fc->iq;
> > -     int err =3D 0;
> >
> >       req =3D fuse_get_req(fm, false);
> >       if (IS_ERR(req))
> > @@ -592,16 +615,9 @@ static int fuse_simple_notify_reply(struct fuse_mo=
unt *fm,
> >
> >       fuse_args_to_req(req, args);
> >
> > -     spin_lock(&fiq->lock);
> > -     if (fiq->connected) {
> > -             queue_request_and_unlock(fiq, req);
> > -     } else {
> > -             err =3D -ENODEV;
> > -             spin_unlock(&fiq->lock);
> > -             fuse_put_request(req);
> > -     }
> > +     fuse_send_one(fiq, req);
> >
> > -     return err;
> > +     return 0;
> >  }
> >
> >  /*
> > @@ -1076,9 +1092,9 @@ __releases(fiq->lock)
> >       return err ? err : reqsize;
> >  }
> >
> > -struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
> > -                                          unsigned int max,
> > -                                          unsigned int *countp)
> > +static struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue=
 *fiq,
> > +                                                 unsigned int max,
> > +                                                 unsigned int *countp)
> >  {
> >       struct fuse_forget_link *head =3D fiq->forget_list_head.next;
> >       struct fuse_forget_link **newhead =3D &head;
> > @@ -1097,7 +1113,6 @@ struct fuse_forget_link *fuse_dequeue_forget(stru=
ct fuse_iqueue *fiq,
> >
> >       return head;
> >  }
> > -EXPORT_SYMBOL(fuse_dequeue_forget);
> >
> >  static int fuse_read_single_forget(struct fuse_iqueue *fiq,
> >                                  struct fuse_copy_state *cs,
> > @@ -1112,7 +1127,7 @@ __releases(fiq->lock)
> >       struct fuse_in_header ih =3D {
> >               .opcode =3D FUSE_FORGET,
> >               .nodeid =3D forget->forget_one.nodeid,
> > -             .unique =3D fuse_get_unique(fiq),
> > +             .unique =3D fuse_get_unique_locked(fiq),
> >               .len =3D sizeof(ih) + sizeof(arg),
> >       };
> >
> > @@ -1143,7 +1158,7 @@ __releases(fiq->lock)
> >       struct fuse_batch_forget_in arg =3D { .count =3D 0 };
> >       struct fuse_in_header ih =3D {
> >               .opcode =3D FUSE_BATCH_FORGET,
> > -             .unique =3D fuse_get_unique(fiq),
> > +             .unique =3D fuse_get_unique_locked(fiq),
> >               .len =3D sizeof(ih) + sizeof(arg),
> >       };
> >
> > @@ -1822,7 +1837,7 @@ static void fuse_resend(struct fuse_conn *fc)
> >       spin_lock(&fiq->lock);
> >       /* iq and pq requests are both oldest to newest */
> >       list_splice(&to_queue, &fiq->pending);
> > -     fiq->ops->wake_pending_and_unlock(fiq);
> > +     fuse_dev_wake_and_unlock(fiq);
> >  }
> >
> >  static int fuse_notify_resend(struct fuse_conn *fc)
> > diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
> > index f23919610313..33b21255817e 100644
> > --- a/fs/fuse/fuse_i.h
> > +++ b/fs/fuse/fuse_i.h
> > @@ -449,22 +449,19 @@ struct fuse_iqueue;
> >   */
> >  struct fuse_iqueue_ops {
> >       /**
> > -      * Signal that a forget has been queued
> > +      * Send one forget
> >        */
> > -     void (*wake_forget_and_unlock)(struct fuse_iqueue *fiq)
> > -             __releases(fiq->lock);
> > +     void (*send_forget)(struct fuse_iqueue *fiq, struct fuse_forget_l=
ink *link);
> >
> >       /**
> > -      * Signal that an INTERRUPT request has been queued
> > +      * Send interrupt for request
> >        */
> > -     void (*wake_interrupt_and_unlock)(struct fuse_iqueue *fiq)
> > -             __releases(fiq->lock);
> > +     void (*send_interrupt)(struct fuse_iqueue *fiq, struct fuse_req *=
req);
> >
> >       /**
> > -      * Signal that a request has been queued
> > +      * Send one request
> >        */
> > -     void (*wake_pending_and_unlock)(struct fuse_iqueue *fiq)
> > -             __releases(fiq->lock);
> > +     void (*send_req)(struct fuse_iqueue *fiq, struct fuse_req *req);
> >
> >       /**
> >        * Clean up when fuse_iqueue is destroyed
> > @@ -1053,10 +1050,6 @@ void fuse_queue_forget(struct fuse_conn *fc, str=
uct fuse_forget_link *forget,
> >
> >  struct fuse_forget_link *fuse_alloc_forget(void);
> >
> > -struct fuse_forget_link *fuse_dequeue_forget(struct fuse_iqueue *fiq,
> > -                                          unsigned int max,
> > -                                          unsigned int *countp);
> > -
> >  /*
> >   * Initialize READ or READDIR request
> >   */
> > diff --git a/fs/fuse/virtio_fs.c b/fs/fuse/virtio_fs.c
> > index 1a52a51b6b07..690e508dbc4d 100644
> > --- a/fs/fuse/virtio_fs.c
> > +++ b/fs/fuse/virtio_fs.c
> > @@ -1089,22 +1089,13 @@ static struct virtio_driver virtio_fs_driver =
=3D {
> >  #endif
> >  };
> >
> > -static void virtio_fs_wake_forget_and_unlock(struct fuse_iqueue *fiq)
> > -__releases(fiq->lock)
> > +static void virtio_fs_send_forget(struct fuse_iqueue *fiq, struct fuse=
_forget_link *link)
> >  {
> > -     struct fuse_forget_link *link;
> >       struct virtio_fs_forget *forget;
> >       struct virtio_fs_forget_req *req;
> > -     struct virtio_fs *fs;
> > -     struct virtio_fs_vq *fsvq;
> > -     u64 unique;
> > -
> > -     link =3D fuse_dequeue_forget(fiq, 1, NULL);
> > -     unique =3D fuse_get_unique(fiq);
> > -
> > -     fs =3D fiq->priv;
> > -     fsvq =3D &fs->vqs[VQ_HIPRIO];
> > -     spin_unlock(&fiq->lock);
> > +     struct virtio_fs *fs =3D fiq->priv;
> > +     struct virtio_fs_vq *fsvq =3D &fs->vqs[VQ_HIPRIO];
> > +     u64 unique =3D fuse_get_unique(fiq);
> >
> >       /* Allocate a buffer for the request */
> >       forget =3D kmalloc(sizeof(*forget), GFP_NOFS | __GFP_NOFAIL);
> > @@ -1124,8 +1115,7 @@ __releases(fiq->lock)
> >       kfree(link);
> >  }
> >
> > -static void virtio_fs_wake_interrupt_and_unlock(struct fuse_iqueue *fi=
q)
> > -__releases(fiq->lock)
> > +static void virtio_fs_send_interrupt(struct fuse_iqueue *fiq, struct f=
use_req *req)
> >  {
> >       /*
> >        * TODO interrupts.
> > @@ -1134,7 +1124,6 @@ __releases(fiq->lock)
> >        * Exceptions are blocking lock operations; for example fcntl(F_S=
ETLKW)
> >        * with shared lock between host and guest.
> >        */
> > -     spin_unlock(&fiq->lock);
> >  }
> >
> >  /* Count number of scatter-gather elements required */
> > @@ -1339,21 +1328,17 @@ static int virtio_fs_enqueue_req(struct virtio_=
fs_vq *fsvq,
> >       return ret;
> >  }
> >
> > -static void virtio_fs_wake_pending_and_unlock(struct fuse_iqueue *fiq)
> > -__releases(fiq->lock)
> > +static void virtio_fs_send_req(struct fuse_iqueue *fiq, struct fuse_re=
q *req)
> >  {
> >       unsigned int queue_id;
> >       struct virtio_fs *fs;
> > -     struct fuse_req *req;
> >       struct virtio_fs_vq *fsvq;
> >       int ret;
> >
> > -     WARN_ON(list_empty(&fiq->pending));
> > -     req =3D list_last_entry(&fiq->pending, struct fuse_req, list);
> > +     if (req->in.h.opcode !=3D FUSE_NOTIFY_REPLY)
> > +             req->in.h.unique =3D fuse_get_unique(fiq);
> > +
> >       clear_bit(FR_PENDING, &req->flags);
> > -     list_del_init(&req->list);
> > -     WARN_ON(!list_empty(&fiq->pending));
> > -     spin_unlock(&fiq->lock);
> >
> >       fs =3D fiq->priv;
> >       queue_id =3D VQ_REQUEST + fs->mq_map[raw_smp_processor_id()];
> > @@ -1393,10 +1378,10 @@ __releases(fiq->lock)
> >  }
> >
> >  static const struct fuse_iqueue_ops virtio_fs_fiq_ops =3D {
> > -     .wake_forget_and_unlock         =3D virtio_fs_wake_forget_and_unl=
ock,
> > -     .wake_interrupt_and_unlock      =3D virtio_fs_wake_interrupt_and_=
unlock,
> > -     .wake_pending_and_unlock        =3D virtio_fs_wake_pending_and_un=
lock,
> > -     .release                        =3D virtio_fs_fiq_release,
> > +     .send_forget    =3D virtio_fs_send_forget,
> > +     .send_interrupt =3D virtio_fs_send_interrupt,
> > +     .send_req       =3D virtio_fs_send_req,
> > +     .release        =3D virtio_fs_fiq_release,
> >  };
> >
> >  static inline void virtio_fs_ctx_set_defaults(struct fuse_fs_context *=
ctx)
> > --
> > 2.45.1
> >
>


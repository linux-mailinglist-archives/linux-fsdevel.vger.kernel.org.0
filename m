Return-Path: <linux-fsdevel+bounces-58868-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8401B32614
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 02:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92E06605EC8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Aug 2025 00:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5311547D2;
	Sat, 23 Aug 2025 00:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M7X41HBl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AC117BA9;
	Sat, 23 Aug 2025 00:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755910779; cv=none; b=ONLpxCIhXKvt++myZnRYzboqMTuesS3qC+SPENoHmGFsI0ShcPPCeGTcxwCc/w6kOmBaEfJdEdVyoLahdz1nylGgfx0ySUmVnlvZr+VvIE0FrbSzQT65tLhLjB4wgI7v1gTcxe0TyLpMTzjYqwT8EinvMYwfCrHW4wIoM+m7OG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755910779; c=relaxed/simple;
	bh=WhTHIrtJD6ig/V+Dqcu/MqbMu9QFWWCzIgEU0MSON8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M8jZ89mSPZWoR8xFauiylgn2kG20Tlhs9iGxqUdHnSQVJRCvfddLK5/uJ1f9747dFPBMfpQfWF3AYadj3J1G6oFdIFX63asXt4MlUrC4QZEiOEp+NO6pY3mytDy4ttsgl/2+s8xF9g/MiIGMg6cUYc6vhuCbGm47aI29uJUGsiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M7X41HBl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A2BC116D0;
	Sat, 23 Aug 2025 00:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755910776;
	bh=WhTHIrtJD6ig/V+Dqcu/MqbMu9QFWWCzIgEU0MSON8E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=M7X41HBl3WWgt2eB1JELXgRefF24A9Ktl80i9LgP5kQvnG4QDRMBSnOYMoFrHHx6x
	 cGoEmfybD/kGnNVUjg+nTNzDm5bTx33JgEyj8i2G6yD0vWuz2X1qJf1k6W1RI3G0Sb
	 AtVobHclKMvQCziJswIhJ1DepqY/5K2vDbgUxIr/PWtxa6+uMaS1QtDopN+628UaK2
	 dvZlCa0fWp+oDw7jSzxmFR2mXjFxkOerSdJlspXkxr3nb+/8o5xQTuAT7mEI7HH30J
	 8lMmR+hpXYbdIUQjNv6VKt1pA3V2by/no3xyFT88i3TAzQMPhjzii/5xfNNzfTq4iU
	 QO38QjwTLOpDQ==
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-61c20e28380so1976034a12.1;
        Fri, 22 Aug 2025 17:59:36 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVaBBmFK+eRnrCUyAinFV8l5Jm2YuDOF3V5U1BbLZpY/w5e4msRI585lxfjMfcIEnKhNgAV3N8AGgbuablUGQ==@vger.kernel.org, AJvYcCWGsqcZ4mWi5GlMMeLmRJYzs9SIW+F+NvWpaPu8PaE/5WyOcpPPc9ZuLtL5RxInt3ZmWB06j1b38avbfUDv@vger.kernel.org, AJvYcCWHYFH+9j5jmnnd0CxI7jm6dgbek+wE9eKFNDv85b7f62+Xee6gSqIorLkjo/bJEkBbYFg4lKZTPcpJ@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8mQ0NKO8ArfUQRz0X/zIhBVSm6qLjF4l9xUZBQ0SGWmV8nz7G
	6xm4Jpk3ZCkVRaciZ2+wk2s9rz/W9n/o/pX5BQgqKn0WcZib0rMHcc498HoG7kVupVgAjlDi3/l
	QPr3cRhDBaYuQUHzaAUbQwxwF0NkEnII=
X-Google-Smtp-Source: AGHT+IETvS6EmVb9SsRL07lUStumjMiBXv7KMAz+tuWOOiILZMbQNkwScTlhem+G+PSHOQg5igqosUJ6tMJmB2j6478=
X-Received: by 2002:a05:6402:52c8:b0:618:20c1:7e43 with SMTP id
 4fb4d7f45d1cf-61c1b70aba6mr3954060a12.29.1755910775362; Fri, 22 Aug 2025
 17:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <68a72860.050a0220.3d78fd.002a.GAE@google.com> <20250822162041.gXcLgwIW@linutronix.de>
In-Reply-To: <20250822162041.gXcLgwIW@linutronix.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 23 Aug 2025 09:59:22 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_koTJzp4hJhojnB9d_=Pgu6jaATySZ61zN4s=vZqe_FA@mail.gmail.com>
X-Gm-Features: Ac12FXx4RqArqi2TOPLn9BW2NusyL7iulzKG_VxY2KxsJFxOsowT10annWLE4cY
Message-ID: <CAKYAXd_koTJzp4hJhojnB9d_=Pgu6jaATySZ61zN4s=vZqe_FA@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] [ext4?] WARNING in __rt_mutex_slowlock_locked
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: syzbot <syzbot+a725ab460fc1def9896f@syzkaller.appspotmail.com>, 
	brauner@kernel.org, jack@suse.cz, linux-ext4@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 23, 2025 at 1:20=E2=80=AFAM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-08-21 07:08:32 [-0700], syzbot wrote:
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3Da725ab460fc1d=
ef9896f
> =E2=80=A6
> > The issue was bisected to:
> >
> > commit d2d6422f8bd17c6bb205133e290625a564194496
> > Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> > Date:   Fri Sep 6 10:59:04 2024 +0000
> >
> >     x86: Allow to enable PREEMPT_RT.
> >
> =E2=80=A6
> > exFAT-fs (loop0): Medium has reported failures. Some data may be lost.
> > exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum=
 : 0xe5674ec2, utbl_chksum : 0xe619d30d)
> > ------------[ cut here ]------------
> > rtmutex deadlock detected
> > WARNING: CPU: 0 PID: 6000 at kernel/locking/rtmutex.c:1674 rt_mutex_han=
dle_deadlock kernel/locking/rtmutex.c:1674 [inline]
> > WARNING: CPU: 0 PID: 6000 at kernel/locking/rtmutex.c:1674 __rt_mutex_s=
lowlock kernel/locking/rtmutex.c:1734 [inline]
> > WARNING: CPU: 0 PID: 6000 at kernel/locking/rtmutex.c:1674 __rt_mutex_s=
lowlock_locked+0xed2/0x25e0 kernel/locking/rtmutex.c:1760
>
> RT detected a deadlock and complained. The same testcase on !RT results
> in:
>
> | [   15.363878] loop0: detected capacity change from 0 to 256
> | [   15.367981] exFAT-fs (loop0): Volume was not properly unmounted. Som=
e data may be corrupt. Please run fsck.
> | [   15.373808] exFAT-fs (loop0): Medium has reported failures. Some dat=
a may be lost.
> | [   15.380396] exFAT-fs (loop0): failed to load upcase table (idx : 0x0=
0010000, chksum : 0xe5674ec2, utbl_chksum : 0xe619d30d)
> | [   62.668182] INFO: task exfat-repro:2155 blocked for more than 30 sec=
onds.
> | [   62.669405]       Not tainted 6.17.0-rc2+ #10
> | [   62.670181] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disab=
les this message.
> | [   62.671612] task:exfat-repro     state:D stack:0     pid:2155  tgid:=
2155  ppid:1      task_flags:0x400140 flags:0x00004006
> | [   62.673557] Call Trace:
> | [   62.674008]  <TASK>
> | [   62.674400]  __schedule+0x4ef/0xbb0
> | [   62.675069]  schedule+0x22/0xd0
> | [   62.675656]  schedule_preempt_disabled+0x10/0x20
> | [   62.676495]  rwsem_down_write_slowpath+0x1e2/0x6c0
> | [   62.679028]  down_write+0x66/0x70
> | [   62.679645]  vfs_rename+0x5c6/0xc30
> | [   62.681734]  do_renameat2+0x3c4/0x570
> | [   62.682395]  __x64_sys_renameat2+0x7b/0xc0
> | [   62.683187]  do_syscall_64+0x7f/0x290
> | [   62.695576]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
> After ctrl+c that testcase terminates but one thread remains in D state.
> This is from
> |         lock_new_subdir =3D new_dir !=3D old_dir || !(flags & RENAME_EX=
CHANGE);
> |         if (is_dir) {
> |                 if (lock_old_subdir)
> |                         inode_lock_nested(source, I_MUTEX_CHILD);
>                           ^^^
> | 5 locks held by exfat-repro/2156:
> |  #0: ffff888113b69400 (sb_writers#11){.+.+}-{0:0}, at: do_renameat2+0x1=
c8/0x580
> |  #1: ffff888113b69710 (&type->s_vfs_rename_key){+.+.}-{4:4}, at: do_ren=
ameat2+0x24d/0x580
> |  #2: ffff88810fb79b88 (&sb->s_type->i_mutex_key#16/1){+.+.}-{4:4}, at: =
lock_two_directories+0x6c/0x110
> |  #3: ffff88810fb7a1c0 (&sb->s_type->i_mutex_key#17/5){+.+.}-{4:4}, at: =
lock_two_directories+0x82/0x110
> |  #4: ffffffff82f618a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_l=
ocks+0x3d/0x184
>
> #2 and #3 are from the "(r =3D=3D p1)" case. The lock it appears to acqui=
re
> is #2.
> Could an exfat take a look, please?
I will take a look.
Thanks!
>
> Sebastian


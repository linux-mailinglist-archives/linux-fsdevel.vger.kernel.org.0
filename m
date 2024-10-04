Return-Path: <linux-fsdevel+bounces-31018-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68FE0990F84
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 22:01:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22991F250CD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 20:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A09971F9A82;
	Fri,  4 Oct 2024 19:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QVw0/2AU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472861F9AA8;
	Fri,  4 Oct 2024 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068679; cv=none; b=aUuD+olHTOodmPrPTc68ob1rYkBZ8zw42XoOzjamb6OptjDoSHVxUD0nk3Necj7zCDCGHFE4O0FInPePKMswnyegTr7ZpcDgOxI3BJj9KxpYyIpjvWQsVGmsZlEq+E8Y/cvNuXBvtCjBIR5V73TsnWCc5nUdiTtznkdT8UOuDCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068679; c=relaxed/simple;
	bh=EYXoxF8J+Y51OPF0Evi9LCP8HPNnSPwukPuNw27WKEc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QmQoSdCBlWXcETXCV9wVTR+MHT7XDC2PAEyPm0UcuOD14Avj8eQvNtNbcVgYQGVyNWdQ7xqWiuH6/sl4OqfMCNh3Ym8qqwrlXe+H2ShFmOozGRx19tPUHL8A1a4/vBCVXQ/Xaqweo++YhVErfKwmWLvnr3cBpdx+tJR1FVamfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QVw0/2AU; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-4585e250f9dso15788871cf.1;
        Fri, 04 Oct 2024 12:04:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728068676; x=1728673476; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EStsrddaAqsEdZHuo7kWeqjRs5ADGW1wT+p+2UhGVJk=;
        b=QVw0/2AUBbJLuF2ZLsNNhwXv6MMD5KfOwtqbPVt/+uS9OqqsrD8eoDW8bo/8irsZA8
         ku0HFlLftytWFaNoyAhRY1T68hRKAFCwfq9zmLDa5w8bbXN5rPvrrR7B08Se6+v55KL5
         BqbBvp5X2TVysiVR6oGsiJqmQIRoKq1KnYRGKnWqmECpzKz8VA5EDH/qsA2K/VyPv8+g
         qfjSKANBkPpZyNEQJSXmG7g1XWT0MlSrDTShtlrKHp1dMEIfQ6wJ0supMpeGX051cIMJ
         UAnWD3qIyb5Fa8vsYzPxQrVgf6zwjm45LNoYOgLvysMIc2wdCguT/1iR6Dvddu1sYUCr
         YpBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728068676; x=1728673476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EStsrddaAqsEdZHuo7kWeqjRs5ADGW1wT+p+2UhGVJk=;
        b=UhN8QflSEgpZmR2jh5fSZFf7C1wXgeOsjQCerMmxaP3pwPoL54fv1pdOvTm8w//XaZ
         WgGBjo0ky5D9HFzB6b22UNZdBnkdP3VUxV5nCOpo2+kuiScDQyVS77hYDNyeeEc8Xqhw
         QodjjjD48lgeTN7ohBbU4YSxjqPD2NVm6gHuOvqFThHkgOdj8DP65iiwtD4fNCV6MUGl
         XDtboG6hbNYGhA28rf+BBPxaFvn1Dy8XCkxUSNe8Me2pW8uqP3q0CmlnDGxnuZkVZ7yW
         Xvxkp+ei8gmMqhjv0Il9uk2YZGILkTfN/1sT1nyDZ2ayzAdUmocOYVg8vuUN7KpWs+Q/
         /nfw==
X-Forwarded-Encrypted: i=1; AJvYcCVWHs804+fIWaHWXE1EUj9hIa0e1vcIO5vrR6X0X4Fe/TBoZE+zsj2UQ4wPOvUlYCCq3YfI3iYv3/fsxIU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpvcZ/oWJvp61eWfTsu5CBKL2Ukwtlc9Ey843K7fiBY1/JUXUh
	B/Roy0YI9VuwOSvFRiNdkjvhnGPpuvO4fs29lFDkQRT7zC/VcC77ncp4u2jckUmDdhB+nyv8SQh
	rSY05Kx05PAzqOtNt9oyb3R9hJ00mjhuj
X-Google-Smtp-Source: AGHT+IE6ecGGBT7nhmFk2o6LxeTZEkQYiEHXxbrFjAKAWH8n5fvpH7/CsF31zubGxANEzTetv3NRCPaF7NPpBBs/2iw=
X-Received: by 2002:ac8:7fd0:0:b0:458:1431:d3ef with SMTP id
 d75a77b69052e-45d9ba2f024mr46004071cf.5.1728068676092; Fri, 04 Oct 2024
 12:04:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66fc4b74.050a0220.f28ec.04c8.GAE@google.com> <CAJnrk1ZrPcDsD_mmNjTHj51NkuVR83g5cgZOJTHez6CB6T31Ww@mail.gmail.com>
In-Reply-To: <CAJnrk1ZrPcDsD_mmNjTHj51NkuVR83g5cgZOJTHez6CB6T31Ww@mail.gmail.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Fri, 4 Oct 2024 12:04:24 -0700
Message-ID: <CAJnrk1ZSZVrMY=EeuLQ0EGonL-9n72aOCEvvbs4=dhQ=xWqZYw@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_writepages
To: syzbot <syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 5:02=E2=80=AFPM Joanne Koong <joannelkoong@gmail.com=
> wrote:
>
> On Tue, Oct 1, 2024 at 12:24=E2=80=AFPM syzbot
> <syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1'=
 of..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D12e8bdd0580=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D1b5201b9103=
5a876
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D217a976dc26ef=
2fa8711
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for=
 Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/a585cdb91cda/d=
isk-e32cde8d.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/dbeec5d7b296/vmli=
nux-e32cde8d.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/000fd790e08a=
/bzImage-e32cde8d.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+217a976dc26ef2fa8711@syzkaller.appspotmail.com
> >
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 5296 at fs/fuse/file.c:1989 fuse_write_file_get fs=
/fuse/file.c:1989 [inline]
> > WARNING: CPU: 0 PID: 5296 at fs/fuse/file.c:1989 fuse_write_file_get fs=
/fuse/file.c:1986 [inline]
> > WARNING: CPU: 0 PID: 5296 at fs/fuse/file.c:1989 fuse_writepages+0x497/=
0x5a0 fs/fuse/file.c:2368
> > Modules linked in:
> > CPU: 0 UID: 0 PID: 5296 Comm: kworker/u8:8 Not tainted 6.12.0-rc1-syzka=
ller-00031-ge32cde8d2bd7 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 09/13/2024
> > Workqueue: writeback wb_workfn (flush-0:52)
> > RIP: 0010:fuse_write_file_get fs/fuse/file.c:1989 [inline]
> > RIP: 0010:fuse_write_file_get fs/fuse/file.c:1986 [inline]
> > RIP: 0010:fuse_writepages+0x497/0x5a0 fs/fuse/file.c:2368
> > Code: 00 00 00 44 89 f8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8=
 79 b6 90 fe 48 8b 7c 24 08 e8 af 6f 27 08 e8 6a b6 90 fe 90 <0f> 0b 90 41 =
bf fb ff ff ff eb 8b e8 59 b6 90 fe 48 8b 7c 24 18 be
> > RSP: 0018:ffffc900044ff4a8 EFLAGS: 00010293
> > RAX: 0000000000000000 RBX: ffffc900044ff4f8 RCX: 0000000000000000
> > RDX: ffff88802d42da00 RSI: ffffffff82fcd286 RDI: 0000000000000001
> > RBP: ffff88805c994aa0 R08: 0000000000000000 R09: ffffed100b9329d7
> > R10: ffff88805c994ebb R11: 0000000000000003 R12: ffffc900044ff840
> > R13: ffff88805c994880 R14: ffff88805f330000 R15: ffff88805c994d50
> > FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000020055000 CR3: 000000005df4a000 CR4: 00000000003526f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  do_writepages+0x1a3/0x7f0 mm/page-writeback.c:2683
> >  __writeback_single_inode+0x166/0xfa0 fs/fs-writeback.c:1658
> >  writeback_sb_inodes+0x603/0xfa0 fs/fs-writeback.c:1954
> >  wb_writeback+0x199/0xb50 fs/fs-writeback.c:2134
> >  wb_do_writeback fs/fs-writeback.c:2281 [inline]
> >  wb_workfn+0x294/0xbc0 fs/fs-writeback.c:2321
> >  process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
> >  process_scheduled_works kernel/workqueue.c:3310 [inline]
> >  worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
> >  kthread+0x2c1/0x3a0 kernel/kthread.c:389
> >  ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
> >  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >  </TASK>
> >
>
> #syz dup: [syzbot] [fuse?] WARNING in fuse_write_file_get (2)
>
> This is the same warning reported in
> https://lore.kernel.org/linux-fsdevel/66fbae38.050a0220.6bad9.0051.GAE@go=
ogle.com/T/#u
>
> The warning is complaining about this WARN_ON here
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/f=
s/fuse/file.c#n1989.
> I think this warning can get triggered if there's a race between a
> write() and a close() where the page is dirty in the cache after the
> release has happened. Then when writeback (eg fuse_writepages()) is
> triggered, we hit this warning. (this possibility has always existed,
> it was surfaced after this refactoring commit 4046d3adcca4: "move fuse
> file initialization to wpa allocation time" but the actual logic
> hasn't been changed).

Actually, it's not clear how this WARN_ON is getting triggered.

I will wait for syzbot to surface a repro first before taking further actio=
n.

>
> I think we can address this by instead calling "data.ff =3D
> __fuse_write_file_get(fi);" in fuse_writepages(). I'll submit a fix
> for this to Miklos's tree.
>
>
> Thanks,
> Joanne
>
> >
> > ---
> > This report is generated by a bot. It may contain errors.
> > See https://goo.gl/tpsmEJ for more information about syzbot.
> > syzbot engineers can be reached at syzkaller@googlegroups.com.
> >
> > syzbot will keep track of this issue. See:
> > https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> >
> > If the report is already addressed, let syzbot know by replying with:
> > #syz fix: exact-commit-title
> >
> > If you want to overwrite report's subsystems, reply with:
> > #syz set subsystems: new-subsystem
> > (See the list of subsystem names on the web dashboard)
> >
> > If the report is a duplicate of another one, reply with:
> > #syz dup: exact-subject-of-another-report
> >
> > If you want to undo deduplication, reply with:
> > #syz undup
> >


Return-Path: <linux-fsdevel+bounces-30618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA6B98CA03
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 02:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BD93B23286
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 00:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7AF23AD;
	Wed,  2 Oct 2024 00:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZnVTM7Mu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0527F1C27;
	Wed,  2 Oct 2024 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727828696; cv=none; b=Cd4F//XSiY1HDx6VgsIXHFTCcDDK+3dfhKG7Xkwvm7f6XTcpM49ts450sk+Ek9uNczujVJFOeIaUsOn2I4YV/Ka6KdxuyoTUSKh8TcPVRCQG0JQLHbM5LYbIfd1oQIk6Lmcp/6Jz1RWY+1AdgAlpTD/lUJ07krsBOv24TboF6Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727828696; c=relaxed/simple;
	bh=YNBa0ViCotx096SRwFeSPpw9A1yRKthX9EnJqix2ZAc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QPZzDmJT7wVXObNAOXp6sipQLWZvnhn4okRL2OeKwUc3qo7o8/BxQEjfPQQvbvGOlFyJyTasaWlFHnEsAJbDWWqhB3n8W7dmMv6hq7XjidwP1BCNVCiQIVzH4gY7hNdZ3pMemFxQTW67xacP+gLsBPjRSgg6/6vjtOKQ4oQIji0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZnVTM7Mu; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-4585e250f9dso40155691cf.1;
        Tue, 01 Oct 2024 17:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727828694; x=1728433494; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XZs6djIavb67qqkmeAMcbALhXbX6YBQKPIAXg2m8YGc=;
        b=ZnVTM7MuCW6a8I2M8yKS1M0/rYMAF3VH35HeznND0j5Hq84hw7F3sS/jT5XIMr7T7W
         nW9jCNeG0u0z1pTcgAtUqwbnShNOZuqnDCQcT/qcCMvTMPC+c2XMUNgtuMTI2ib9lo+t
         CGwd7XziwGF83TktPWSjulfBz1RHaoa4KEUApaXGWYShWWLo99Mn1jKgwyGRkROK6tdU
         jwzFVqFYIbs4MsZJLDXQf0uDZw1eHqyOT9NHcLLAQu3c8gvaA6uO1muyj7S/9PA97Ydz
         KyLvjrOR+u0+A2VxHE+c22dt35Tomb61mdrYvf2NSTWwRWC1D+TzVMxhNC9KhVVU2GLs
         h34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727828694; x=1728433494;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XZs6djIavb67qqkmeAMcbALhXbX6YBQKPIAXg2m8YGc=;
        b=MiqIEgJUS8ClE0LkujCc3fbr42u10OGPE7CLxwvOfQZ0B+tOt78imIpf7rw/ycjt72
         NM/W38XAg5HmVK0kzV9nuBGL2DF7NGgDNQP53HyktoYbtTrSCqCrRxYm7tjdkHOIcmf9
         s6Xuq2T13/gYZAQdPONg3zGptQkDM7sWtrenVRhR9qKOO9MdViKNULdmjYbQbH85kLyl
         mv49DXLRxj2ND37xyhIk+zJeleBL7tdBx+NKi9oOBCvrWWj8ayca4tSKPfwafV5Qg44J
         ouCrUCiNoNzUyT2SamJi78bMpDH1dB3eVIzByl4jCn9bfL4YrLg2vS0gnGlTySznzVVX
         dIAQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtl+0emUWVz4cCN2YAiqKbaI4gQj5+h/Mj4zqOd9ZTI4itrcXlm3Iwaghvg1u9CC6o64LEtjfGsbkboas=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm0ThaZffic6xrLQ6aWIfivkAeigFLNbwim/Mzx56QTvPcGXz3
	cqPCxvjj056iLy9ITQWizROj1hDexL9Hiy3ThBK+CCReWdm70DxsdQJLO30eFCzx8tMm0jtdvu+
	cZXXEOAE8J4P4FUa+xhB0ADjzhNg=
X-Google-Smtp-Source: AGHT+IGQkaNsbYb0geTV1V1A0ZHkJxIru9vzKTAgwuMsqhnYACLQmWIF67taFVKTFktoydpRpkiPK0OCYhbhXWliD9I=
X-Received: by 2002:a05:622a:53cd:b0:458:35fe:51d with SMTP id
 d75a77b69052e-45d80561099mr18765371cf.60.1727828693827; Tue, 01 Oct 2024
 17:24:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <66f7b905.050a0220.46d20.0039.GAE@google.com>
In-Reply-To: <66f7b905.050a0220.46d20.0039.GAE@google.com>
From: Joanne Koong <joannelkoong@gmail.com>
Date: Tue, 1 Oct 2024 17:24:43 -0700
Message-ID: <CAJnrk1YcLR3LyhBmdYeD1PhJag_b=xEw1PomE_qRTmqYm_aS1Q@mail.gmail.com>
Subject: Re: [syzbot] [fuse?] WARNING in fuse_request_end (2)
To: syzbot <syzbot+554c4743d0f2d52d990d@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 28, 2024 at 1:06=E2=80=AFAM syzbot
<syzbot+554c4743d0f2d52d990d@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    4d0326b60bb7 Add linux-next specific files for 20240924
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D119dc99f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D441f6022e7a2d=
b73
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D554c4743d0f2d52=
d990d
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5461991c7c3f/dis=
k-4d0326b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2d44fd40ed13/vmlinu=
x-4d0326b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/25eeeb66df29/b=
zImage-4d0326b6.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+554c4743d0f2d52d990d@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5282 at fs/fuse/dev.c:372 fuse_request_end+0x875/0xa=
d0 fs/fuse/dev.c:372
> Modules linked in:
> CPU: 1 UID: 0 PID: 5282 Comm: kworker/1:6 Not tainted 6.11.0-next-2024092=
4-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 08/06/2024
> Workqueue: events close_work
> RIP: 0010:fuse_request_end+0x875/0xad0 fs/fuse/dev.c:372
> Code: 89 ef e8 4e ab e9 fe 48 8b 45 00 48 39 e8 74 0a e8 80 e9 7f fe e9 2=
8 fc ff ff e8 76 e9 7f fe e9 79 fc ff ff e8 6c e9 7f fe 90 <0f> 0b 90 e9 a9=
 fa ff ff e8 5e e9 7f fe 90 0f 0b 90 e9 dd fa ff ff
> RSP: 0018:ffffc90004297790 EFLAGS: 00010293
> RAX: ffffffff8314f984 RBX: 000000000000028b RCX: ffff88806288da00
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 0000000000000000
> RBP: 0000000000000080 R08: ffffffff8314f428 R09: 1ffff110062c1738
> R10: dffffc0000000000 R11: ffffed10062c1739 R12: ffff88803160b990
> R13: 1ffff110062c1738 R14: ffff88803160b9c0 R15: dffffc0000000000
> FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f570e302d58 CR3: 000000002d052000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  __fuse_request_send fs/fuse/dev.c:475 [inline]
>  __fuse_simple_request+0xaad/0x1840 fs/fuse/dev.c:571
>  fuse_simple_request fs/fuse/fuse_i.h:1156 [inline]
>  fuse_flush+0x69d/0x950 fs/fuse/file.c:542
>  close_work+0x89/0xb0 kernel/acct.c:206
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3391
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
>

#syz fix: fuse: clear FR_PENDING if abort is detected when sending request

This has already been fixed by commit fcd2d9e1fdcd "fuse: clear
FR_PENDING if abort is detected when sending request"


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
>


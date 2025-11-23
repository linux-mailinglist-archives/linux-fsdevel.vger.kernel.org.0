Return-Path: <linux-fsdevel+bounces-69598-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05742C7E9A9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B69223A43CD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:30:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0190625C838;
	Sun, 23 Nov 2025 23:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EScVcjbB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B866915E8B
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 23:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940639; cv=none; b=taq5mbP5pVvSX9VdUo1U2a1+2X5YMBtFDpYpFOmmcJglvgMgIxAgbDiGse5+y6Hfv3ePd4Tsi7At6IItlCZ6wcHOZw8S4MegKIQafiPvw/54b9SdSthKRsMsVt6EUrzmEXJ3/rp/0Oe9na/YB36wmhz8RX4ADUeY8fXb+wkzSAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940639; c=relaxed/simple;
	bh=Pvy+F/m1v4duxz98B8A4THddFFHNKkG0VyGvrA1/Ghc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ij6hgc4r/idyEPoG1SnwrerIr6dZih2F/DBMxbsotqYUIiGqc9Ug+7N4mC7nvubPxWPWjojvGYpvRHiNL9v+OOlrEjf5bRdF+xVEkyRDkQbQeHb13e/G9Gd57wU1ZtdnRbfHc4es9TtIdvHgisiUaxUgAr8DAronVM7x4emUmjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EScVcjbB; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b736cd741c1so638937366b.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 15:30:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940636; x=1764545436; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tv1JE5X/TS2XRlCcr9C03MtYzcReh6WHKJs1xEyd0dc=;
        b=EScVcjbBR/G1eVZPVk4Yskvc9i7BEK/xa7Be3Hf/9eC+9jq9u55sSGJ7yuDctSs8P2
         kkK+2FgnimPzOCRMaVFIKf/3fABrUy+aDD3lzLSSz2WQxSoxBdlJvCi4u57ImsslpDiK
         W0WCVEJ+8vUT/FMZoOqVsC58RgbriGLcKl1ucGsGNCt1JW9hdTRz3UdKzQqDNZivlQoL
         5mSiT5AlxHS5u5zRK7i5aDcauhr9z3bZlgoyT3tLw3pRqFXWGtclvbJcKQcuI1cKbGA4
         kwwpswDmpuqOzRJZS8wJm2rWq7irq2NW7BxCr/S7B1dDrWL+yHjymzuUcdY105/PqEoS
         XRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940636; x=1764545436;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Tv1JE5X/TS2XRlCcr9C03MtYzcReh6WHKJs1xEyd0dc=;
        b=kJLQ2bxGkQjkw2ufJOw8K/iAaLa9uhxdXl3GqV09L9KH7qoZgNAWs73hRNeztVo7d5
         bWXq8hb41fKQ6vNIZy1FhZ4f0gCXOn9J1BRaTefbmBWccY7EgaHany6+0ZcbUq8i6BzN
         FeJOgH8VonbzX3HmnQbdrhgoulk1XQwKL8i1gP629GyamgmUt+R3TahNnKsELlm3GS3L
         A3+mtB/wlRg/IdplvwhbSwV4TxCUFebpVdrM+EAjwvN8yJzMGrGL6rI571bknUFKYhig
         EcR5EGoyI/o4py9xzOAc2Fx7T04bxKSdtwyojhg0M1/x8iXfkCerxqmu0d15Krz//U4/
         uKMg==
X-Forwarded-Encrypted: i=1; AJvYcCW1DNWjK8bXPGEhg162x7x0pm1r/aq7BTd89bjZJV9JWNS0kmn8JCjvYYyopBDwalxOxw331L0K+jkhiRF2@vger.kernel.org
X-Gm-Message-State: AOJu0YxgZRQxNk5ao26+/tTx1fEq/wMpIASah2TLgmYffZIITpRQFOK7
	oDSwPqK/Cg3T5oODFcgDkn5sDiGEgTs3U3N3+34UDL9dSYaFZimE/DQGOSWLwHb0nt85o5hMXlz
	2Ke/fi+hW10RY0yk7GLIujOyFPQujl3w=
X-Gm-Gg: ASbGncuJThW98A8ZzQkQfHso2s5HUQ6MNQovXLlDAd0bu/iIdrVFm4IPZ+hCb3S6729
	9jJLZ+efs8TeLyRxykKWlzN6UygQt4LHHoOqz5YsgRuxPXzWK1xrQPzsum0r2aZq+xUAprJRy66
	xsM40C0dmrAq2nnXF6zP4IJJ7sl7yBt7M95vK47+3/UgwkH6nhKVElif0gpEKN7K5ZqwP6IuQQN
	poCzLNouthbZIlU5GLNw7APdTZsbxYC0Ld7E6UmU/LyDEeon7MzAFRjB1RWpOrXcw/g/GN4IguS
	SGCj2U8BZL8uEdMjRL/osh5O3A==
X-Google-Smtp-Source: AGHT+IFACleFPfRJHavpCopq/JWN/8si0EbIS//Ul6+WVCK4Crm5e9hbCoTl2sh8Dc+b09tn/XsfFa3aiDUK7P/EwP0=
X-Received: by 2002:a17:907:3f0a:b0:b76:3478:7d52 with SMTP id
 a640c23a62f3a-b76716953d5mr1131277866b.38.1763940635991; Sun, 23 Nov 2025
 15:30:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69238e4d.a70a0220.d98e3.006e.GAE@google.com> <CAGudoHG9KjT=srh0H-fwmJDozZSAMiOph+npB938TJboatkWbA@mail.gmail.com>
In-Reply-To: <CAGudoHG9KjT=srh0H-fwmJDozZSAMiOph+npB938TJboatkWbA@mail.gmail.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Nov 2025 00:30:24 +0100
X-Gm-Features: AWmQ_bnRjWi2l5zhUCy1mj4g00Fx_wZn7EMrRH3tB0z1DC07GbSG7TAii6GFwyg
Message-ID: <CAGudoHHmOhtKYTEbqf4MA+1gxOPBwA0akba+sFadNdAC1uA3-Q@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
To: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 12:29=E2=80=AFAM Mateusz Guzik <mjguzik@gmail.com> =
wrote:
>
> On Sun, Nov 23, 2025 at 11:44=E2=80=AFPM syzbot
> <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com> wrote:
> > NMI backtrace for cpu 1
> > CPU: 1 UID: 0 PID: 6107 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT=
(full)
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 10/25/2025
> > RIP: 0010:hlock_class kernel/locking/lockdep.c:234 [inline]
> > RIP: 0010:mark_lock+0x3c/0x190 kernel/locking/lockdep.c:4731
> > Code: 00 03 00 83 f9 01 bb 09 00 00 00 83 db 00 83 fa 08 0f 45 da bd 01=
 00 00 00 89 d9 d3 e5 25 ff 1f 00 00 48 0f a3 05 c4 46 df 11 <73> 10 48 69 =
c0 c8 00 00 00 48 8d 88 70 f3 1e 93 eb 48 83 3d 4b d6
> > RSP: 0018:ffffc90003747518 EFLAGS: 00000007
> > RAX: 0000000000000311 RBX: 0000000000000008 RCX: 0000000000000008
> > RDX: 0000000000000008 RSI: ffff8880275f48a8 RDI: ffff8880275f3d00
> > RBP: 0000000000000100 R08: 0000000000000000 R09: ffffffff8241cc56
> > R10: dffffc0000000000 R11: ffffed100e650518 R12: 0000000000000004
> > R13: 0000000000000003 R14: ffff8880275f48a8 R15: 0000000000000000
> > FS:  00007fc3607da6c0(0000) GS:ffff888125fbc000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000558e8c347168 CR3: 0000000077b26000 CR4: 00000000003526f0
> > Call Trace:
> >  <TASK>
> >  mark_usage kernel/locking/lockdep.c:4674 [inline]
> >  __lock_acquire+0x6a8/0xd20 kernel/locking/lockdep.c:5191
> >  lock_acquire+0x117/0x350 kernel/locking/lockdep.c:5868
> >  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
> >  _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
> >  spin_lock include/linux/spinlock.h:351 [inline]
> >  insert_inode_locked+0x336/0x5d0 fs/inode.c:1837
> >  ntfs_new_inode+0xc8/0x100 fs/ntfs3/fsntfs.c:1675
> >  ntfs_create_inode+0x606/0x32a0 fs/ntfs3/inode.c:1309
> >  ntfs_create+0x3d/0x50 fs/ntfs3/namei.c:110
> >  lookup_open fs/namei.c:4409 [inline]
> >  open_last_lookups fs/namei.c:4509 [inline]
> >  path_openat+0x190f/0x3d90 fs/namei.c:4753
> >  do_filp_open+0x1fa/0x410 fs/namei.c:4783
> >  do_sys_openat2+0x121/0x1c0 fs/open.c:1432
> >  do_sys_open fs/open.c:1447 [inline]
> >  __do_sys_openat fs/open.c:1463 [inline]
> >  __se_sys_openat fs/open.c:1458 [inline]
> >  __x64_sys_openat+0x138/0x170 fs/open.c:1458
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7fc35f98f749
> > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89=
 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007fc3607da038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> > RAX: ffffffffffffffda RBX: 00007fc35fbe5fa0 RCX: 00007fc35f98f749
> > RDX: 000000000000275a RSI: 00002000000001c0 RDI: ffffffffffffff9c
> > RBP: 00007fc35fa13f91 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007fc35fbe6038 R14: 00007fc35fbe5fa0 R15: 00007ffffeb34448
> >  </TASK>
> >
>
> The bug is in ntfs. It calls d_instantiate instead of
> d_instantiate_new and consequently there is no wakeup to begin with.
>
> I'm going to chew on it a little bit, bare mininum d_instantiate
> should warn about it and maybe some other fixups are warranted.

As in I'm about to turn in, will post patches on Monday.


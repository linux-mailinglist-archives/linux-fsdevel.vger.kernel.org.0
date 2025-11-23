Return-Path: <linux-fsdevel+bounces-69597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F137BC7E9A0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Nov 2025 00:30:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8133F4E16D7
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 23:30:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17942673B0;
	Sun, 23 Nov 2025 23:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OwH2GnCJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E21D0DEE
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 23:29:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763940597; cv=none; b=epMOwZwFCE+VCuziQ4Fg7qgwHbhlNYI/GHCHXDjQRADPxaNfjSZVs8r7fG/SxgpG7UksWdB8lZay0APLLF3uaDv1SErYHV9i/nhyLRWNj+2vgTN9OW/Hy1RuKUP8n/1eI4PIByqYZUXt0LhunFJDL3uds2hnvmTFRP8jq37MP0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763940597; c=relaxed/simple;
	bh=onfW0KRCunkrfENCokop5oWDP52dluPbHWVAUJlTB18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GpHG1CpKSmgVtCkUYoa2qLht/SZMHA+NyBV7vC4A0nSXPJtXwru8S+jNuvJQwBqojoXSpC2X1/PbA0lw1loh9kG9ql3cPUxVZCgA0giFV5ofOaxL8DQvZUGg4/N5wWEL+IzzAlqhc7H217hfB7ZW4RMx2TQsMfGashICpLB3wIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OwH2GnCJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-64180bd67b7so4870071a12.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 15:29:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763940594; x=1764545394; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2QCVkHe2B5C1rJZaKqIp5MAgrunRtVbuybu3HA4F0WE=;
        b=OwH2GnCJYBg3lP5JvnfOG7CekPVFtc6+0bOKZKmH+0Op+9R8otmWSOnO5lvBF9xSmC
         od8+7xV0HPchMpxBtnbI1iDGjbbnX0e98cpl9AvjVcG9ZBHUpH8XjBa/3PUlexLmZpEH
         7iI/Cv2MX2eKf1B4kpRBRH5bzye57XC0pk2m09mYId1GB4fQCB6GDbZKhCZhSpNHbENB
         HcAbkFxNyHJbTthDXTfi8rcxKWJHiR4IGfE50S/1sXZ3cHdz+5hsSJxKKCbXVkSJY9V8
         oPiVe0+bvnS79sBIACqa5dFPiaO6Aw+4yaIIcZF5NLGM1mg5BelMu/Va4MVuEskvX9x0
         P54g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763940594; x=1764545394;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2QCVkHe2B5C1rJZaKqIp5MAgrunRtVbuybu3HA4F0WE=;
        b=lVW9qchq3WkIPXYOqsYaHOAqTOGF4iEoOJ7cj/Vhys0ezxxmDMHre9kFwtNClmj1vS
         U04sBjciyin6nZUkbqTAe7Bdsy8xbwYxZJiYpCf3p0pwCg2KjosE+EOj6ReUEQwYSMkg
         EV1srRNgcVo/FsFQe2iMUhEr4pQwmFscDwaNDzuRM3agQIHEh8RWCBjQzEKUtC9k/X9W
         KtBY4G6guvBq/wyDR1nLAs+wNOFhV09GYeXpukc4hzFkVhq6QNysfD6TdZA/Bspz2IFm
         1qiG1c0bMK+E4hejmzb8vTara3lUeDj1jB9Wszl8xqQgf3nTtNF9PM6zCq6+7sFqAnkW
         kkEQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgnGUt1oPwFV54JG3ODl4Bw1kHZN5oFb3kp9slTiv+j5zB598owCXj6KL/fIIoLlFXt25QMe3jTVW4Ix07@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6ZDGC0VmqKsoGGdYgWfV+ipHWSrN6q46nCYZKvhbAInQkKuQV
	idVrHMndtVa42iImATfqm7Mj5u9xUvAFWgfWRwbtY5NDUB5hE9xjvCvtlEdBviO+LTclXb5yhoF
	7cwFtw/bOQUuaEvqEyE4lpTaKJb3zL0A=
X-Gm-Gg: ASbGncvq4aD5NRWd+T8gFcSbQADZhNunNrYg2lcxgbMt4RclVZ1k2y2QAL5TjGqoj6H
	hJzOboQf0B/jXk6BT/3x4kZmtKoEgX4phgroL/schXJ0CulpvLKQZtlbBswfp1HSFsHXZrUcCz+
	pbblmOjDrYEoPf6J+rZGCIXCjE2PtFXp8saQeYuGWvJRI8LHLPl4e31EZ+pMd7+IbydWEemO9tD
	aBlrZw56QgBZ7SoiTNkw+0zsmXKm3wgrn9RODzj+vy8pPGr6u5qBqsxN5m7SD1U6NPfCZrEbYr2
	jEnp0iy7xEcobJunu0b4//fuDPpkp/cAkEuA
X-Google-Smtp-Source: AGHT+IGgKBAH4WW3s6pZ/k0Q+yZ542U3x27zfw+0RPx6LN8evSEWSmV/hGBLBffbW2tyfSHD/D4vHIELW+iB1aUHTZ0=
X-Received: by 2002:a17:907:97d6:b0:b76:2d96:6c28 with SMTP id
 a640c23a62f3a-b76715acbd4mr972617166b.24.1763940593246; Sun, 23 Nov 2025
 15:29:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>
In-Reply-To: <69238e4d.a70a0220.d98e3.006e.GAE@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Mon, 24 Nov 2025 00:29:41 +0100
X-Gm-Features: AWmQ_blW1s24U6SJWaHPmBzqy7U6b1FmGjPf-59EW4w_5ZdHcoASFYaoUUr_f48
Message-ID: <CAGudoHG9KjT=srh0H-fwmJDozZSAMiOph+npB938TJboatkWbA@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] INFO: task hung in __start_renaming
To: syzbot <syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com>
Cc: agruenba@redhat.com, almaz.alexandrovich@paragon-software.com, 
	brauner@kernel.org, dhowells@redhat.com, gfs2@lists.linux.dev, jack@suse.cz, 
	linux-afs@lists.infradead.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 23, 2025 at 11:44=E2=80=AFPM syzbot
<syzbot+2fefb910d2c20c0698d8@syzkaller.appspotmail.com> wrote:
> NMI backtrace for cpu 1
> CPU: 1 UID: 0 PID: 6107 Comm: syz.3.20 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/25/2025
> RIP: 0010:hlock_class kernel/locking/lockdep.c:234 [inline]
> RIP: 0010:mark_lock+0x3c/0x190 kernel/locking/lockdep.c:4731
> Code: 00 03 00 83 f9 01 bb 09 00 00 00 83 db 00 83 fa 08 0f 45 da bd 01 0=
0 00 00 89 d9 d3 e5 25 ff 1f 00 00 48 0f a3 05 c4 46 df 11 <73> 10 48 69 c0=
 c8 00 00 00 48 8d 88 70 f3 1e 93 eb 48 83 3d 4b d6
> RSP: 0018:ffffc90003747518 EFLAGS: 00000007
> RAX: 0000000000000311 RBX: 0000000000000008 RCX: 0000000000000008
> RDX: 0000000000000008 RSI: ffff8880275f48a8 RDI: ffff8880275f3d00
> RBP: 0000000000000100 R08: 0000000000000000 R09: ffffffff8241cc56
> R10: dffffc0000000000 R11: ffffed100e650518 R12: 0000000000000004
> R13: 0000000000000003 R14: ffff8880275f48a8 R15: 0000000000000000
> FS:  00007fc3607da6c0(0000) GS:ffff888125fbc000(0000) knlGS:0000000000000=
000
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
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc3607da038 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 00007fc35fbe5fa0 RCX: 00007fc35f98f749
> RDX: 000000000000275a RSI: 00002000000001c0 RDI: ffffffffffffff9c
> RBP: 00007fc35fa13f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fc35fbe6038 R14: 00007fc35fbe5fa0 R15: 00007ffffeb34448
>  </TASK>
>

The bug is in ntfs. It calls d_instantiate instead of
d_instantiate_new and consequently there is no wakeup to begin with.

I'm going to chew on it a little bit, bare mininum d_instantiate
should warn about it and maybe some other fixups are warranted.


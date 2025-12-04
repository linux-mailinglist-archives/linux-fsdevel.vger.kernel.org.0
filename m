Return-Path: <linux-fsdevel+bounces-70628-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02335CA2ADA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 08:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84CDD3084AA0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 07:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042C03093CA;
	Thu,  4 Dec 2025 07:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWCL66rf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26372FFFBF
	for <linux-fsdevel@vger.kernel.org>; Thu,  4 Dec 2025 07:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764834324; cv=none; b=LF8ZnLSuIvbUCo7mfWA+S4yCh46dvczUrq5j7fCmA1/5nrmMU8bpDS42Ed/J7tpOjMD/F99lsj2bnkcg/fkxtE4I87FflKiH9pa3VKWO3WohAo1hV7BkdJVnd4TFapeD2hgLz+j745o+SuZfLxpsjGoDB13tQjqigz5mVArcqYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764834324; c=relaxed/simple;
	bh=RrTlWpIqtgGY1sds/HoUlGvSPEX0LM6BkRc0xxMvr88=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMONYy0zWoMHddftfkdUSG+L4jw2+GiwSwz7gHQXEHXgR/ys3uhBR/iSN+YYTJNf2gGaizOwSP0yj4/pXCzqshlkqKFa+h6zvqCstoXmOLZIsgYm0Bd6YRP9Ip6JOetRKRI6O8y81q9+JH6s8X+KJ062xchOth09yCxp/+VjE+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UWCL66rf; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6418b55f86dso966791a12.1
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Dec 2025 23:45:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764834320; x=1765439120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GCW6tJSUzkuUwWazSC7GMvke61dgEKEVAI0iICTO6Nw=;
        b=UWCL66rfD8RVQglYzpMF4YGDqIiP5jTjNM3WCl2QzPVowp1+yyVXg8TzwgS/UIUJIx
         zo5B/wAq8pNpq67si61+062fz0ANRKaYkl8BtA7LhJuRFmqSP4iuCYREe7SR3VUwizyY
         CLcBobG06UsQ45H9Qg8NfnHEP6A5XLGBKvughIhxguHx6Gy7Iui9a3raBMhwuG09hXFm
         ivjPuPUaXBggsKl2kU1hqnE4OaowvZ9Vf+GxSx8vJuPpWGVdUYPziMtNOMkE6czuyf74
         BukQb0eDLWNaTG2Bn5XGslnWACAnIIBaURU3BwuWONJ4bqBheDLYRpN6oRe0jSPGOF3k
         FiQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764834320; x=1765439120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GCW6tJSUzkuUwWazSC7GMvke61dgEKEVAI0iICTO6Nw=;
        b=ptCDfdk6FUxpKMwWkw4wawouufrowJpV3u3TKZutLEM6r4pRUpW+TYpAoKrpOzb/5E
         Ndc/nG/IgO+uAMqsm7Eo//hOW+K0ekA/0osFHBDBQhyvBlGC17/vyaB9VLkFfYIOTt3g
         P/1F7djbVOAgNFLtWOa3fAoDx+SK1dfYGL3fdeiZyPDAf71ckGSp0NZP//wVVb0dCEus
         w6EcKd60Egne5nNHFzH9XpIdhMuuBoobRlYEoklrBdEt28uCfiAaSdxNhXuz0psRRV+H
         GmHMnuvw/YIISXG6LyDOwSoPmngvN3n2tDnMvutXg8gZeNc/CxeKkioZuWGYAquZ4bXN
         4NsA==
X-Forwarded-Encrypted: i=1; AJvYcCWDPPV242t2jkBXq7Z6XNpWkUsepEiFfry2ULDn+cusok8v8UUWY8b1UMpuGB8bAetPrUXeoEeEBVbVnHmd@vger.kernel.org
X-Gm-Message-State: AOJu0YzPSe+3U2eRRwTREr/wk4/5EcLewbbgNS0Q6z0ttVQb3Q8Nb98h
	1tXKSAwNSiEMsFHaxCaW6AO9iWOn0rsOYE2zE8m3voFpEayIuWuMQkWu+zmofsSiBMfXBSlNdcA
	a7OGlcq82E8x07dqW7XDxp9LI0Ab7U8Y=
X-Gm-Gg: ASbGnct5awK2YDLbYS3oU/amfb7EQzzEnLRSWBTAEV6k59465mfGjvnfCKj0l+5By9T
	I/Z7LROsKdRJ7TMVBBL8TXIYDA8TddoQXKsU+sVz+Kl0CVCz+6hTqtJd0EjN59nfrjcA7ogOUaM
	4ISRxt96lPKxAGrBF2Fs35CYWUpcYMXbZgKEWRDrwNOwlgW/kSwJf/v3j7ZZPLh8omdJc6ZCFvL
	e1BEf99q1MIb1DMREUjOI+tjvqT/p5nOUmpu+Rh2H753VX3LdaPSCgufcW7mxmYChOsMLPyUbw1
	cixQ8ebKj/Iv7P3sin03nQtrkA==
X-Google-Smtp-Source: AGHT+IEW6nEgFDYPURnv+v93qP+JYZcAoOPn8xbtbhXkHYzDtOGkOndqro2kdjzMhRd2AONz1sK3oRC5iGP7CNBjs+I=
X-Received: by 2002:a05:6402:2696:b0:645:d34b:8166 with SMTP id
 4fb4d7f45d1cf-6479c529581mr4778744a12.26.1764834319966; Wed, 03 Dec 2025
 23:45:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6w4u7ysv6yxdqu3c5ug7pjbbwxlmczwgewukqyrap3ltpazp4s@ozir7zbfyvfj> <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
In-Reply-To: <6930e200.a70a0220.d98e3.01bd.GAE@google.com>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Thu, 4 Dec 2025 08:45:08 +0100
X-Gm-Features: AWmQ_bnrH8oTpt6w8DaWw6tzlnw_HCO8tIUlHCSXHC5ARXQYE1OLwZmDfA5680k
Message-ID: <CAGudoHE0Q-Loi_rsbk5rnzgtGfbvY+Fpo9g=NPJHqLP5G_AaUg@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] [ocfs2?] kernel BUG in link_path_walk
To: syzbot <syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com>
Cc: brauner@kernel.org, jack@suse.cz, jlbec@evilplan.org, 
	joseph.qi@linux.alibaba.com, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, mark@fasheh.com, 
	ocfs2-devel@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 4, 2025 at 2:21=E2=80=AFAM syzbot
<syzbot+d222f4b7129379c3d5bc@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot has tested the proposed patch but the reproducer is still triggeri=
ng an issue:
> kernel BUG in link_path_walk
>
> (syz.0.73,6964,1):ocfs2_find_entry_id:420 ERROR: status =3D -30
> ------------[ cut here ]------------
> kernel BUG at fs/namei.c:2532!

On the commit syzbot is testing on (b2c27842) and with the patch, the
triggered assert is the second one on S_ISDIR:
       VFS_BUG_ON(!d_can_lookup(nd->path.dentry));
       VFS_BUG_ON(!S_ISDIR(nd->path.dentry->d_inode->i_mode));

d_can_lookup is  __d_entry_type(dentry) =3D=3D DCACHE_DIRECTORY_TYPE;

Or to put it differently, lookup got entered with a bogus state of a
dentry claiming it is a directory, with an inode which is not. Per the
i_mode reported in the opening mail it is a regular file instead.

While I don't see how this can happen, I don't think it is *my* bug
either -- merely nothing else asserted on the 2 things being in
tandem.

syzbot likes to operate on corrupted filesystems, so I'm going to
assume things are going haywire in ocfs2 until proven otherwise.

> Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
> CPU: 1 UID: 0 PID: 6964 Comm: syz.0.73 Not tainted syzkaller #0 PREEMPT(f=
ull)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 10/25/2025
> RIP: 0010:link_path_walk+0x1a57/0x1a90 fs/namei.c:2532
> Code: 89 e9 80 e1 07 fe c1 38 c1 0f 8c be fd ff ff 4c 89 ef e8 2c e5 e9 f=
f e9 b1 fd ff ff e8 62 90 83 ff 90 0f 0b e8 5a 90 83 ff 90 <0f> 0b e8 52 90=
 83 ff 90 0f 0b e8 4a 90 83 ff 4c 89 ff 48 c7 c6 40
> RSP: 0018:ffffc9000491f8a0 EFLAGS: 00010293
> RAX: ffffffff823e22d6 RBX: dffffc0000000000 RCX: ffff8880250f3d00
> RDX: 0000000000000000 RSI: 0000000000008000 RDI: 0000000000004000
> RBP: ffff888079181120 R08: ffff8880299ef520 R09: ffff88807acd2000
> R10: ffff8880299ef520 R11: ffff88807acd2000 R12: ffffc9000491fc58
> R13: ffffc9000491fc28 R14: 0000000000008000 R15: 0000000000100000
> FS:  00007ff92e2e36c0(0000) GS:ffff888125f49000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000555575344808 CR3: 0000000025c92000 CR4: 00000000003526f0
> Call Trace:
>  <TASK>
>  path_openat+0x2b3/0x3dd0 fs/namei.c:4787
>  do_filp_open+0x1fa/0x410 fs/namei.c:4818
>  do_sys_openat2+0x121/0x200 fs/open.c:1430
>  do_sys_open fs/open.c:1436 [inline]
>  __do_sys_open fs/open.c:1444 [inline]
>  __se_sys_open fs/open.c:1440 [inline]
>  __x64_sys_open+0x11e/0x150 fs/open.c:1440
>  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>  do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7ff92d38f749
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ff92e2e3038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 00007ff92d5e5fa0 RCX: 00007ff92d38f749
> RDX: 0000000000000000 RSI: 0000000000145142 RDI: 0000200000000240
> RBP: 00007ff92d413f91 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ff92d5e6038 R14: 00007ff92d5e5fa0 R15: 00007ffda4bd0278
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:link_path_walk+0x1a57/0x1a90 fs/namei.c:2532
> Code: 89 e9 80 e1 07 fe c1 38 c1 0f 8c be fd ff ff 4c 89 ef e8 2c e5 e9 f=
f e9 b1 fd ff ff e8 62 90 83 ff 90 0f 0b e8 5a 90 83 ff 90 <0f> 0b e8 52 90=
 83 ff 90 0f 0b e8 4a 90 83 ff 4c 89 ff 48 c7 c6 40
> RSP: 0018:ffffc9000491f8a0 EFLAGS: 00010293
> RAX: ffffffff823e22d6 RBX: dffffc0000000000 RCX: ffff8880250f3d00
> RDX: 0000000000000000 RSI: 0000000000008000 RDI: 0000000000004000
> RBP: ffff888079181120 R08: ffff8880299ef520 R09: ffff88807acd2000
> R10: ffff8880299ef520 R11: ffff88807acd2000 R12: ffffc9000491fc58
> R13: ffffc9000491fc28 R14: 0000000000008000 R15: 0000000000100000
> FS:  00007ff92e2e36c0(0000) GS:ffff888125e49000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f1310116e9c CR3: 0000000025c92000 CR4: 00000000003526f0
>
>
> Tested on:
>
> commit:         b2c27842 Add linux-next specific files for 20251203
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D15d7801a58000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcaadf525b0ab8=
d17
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd222f4b7129379c=
3d5bc
> compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b797=
6-1~exp1~20250708183702.136), Debian LLD 20.1.8
> patch:          https://syzkaller.appspot.com/x/patch.diff?x=3D1281d4c258=
0000
>


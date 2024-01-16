Return-Path: <linux-fsdevel+bounces-8078-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8083582F319
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 18:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24156284246
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jan 2024 17:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7891CAB0;
	Tue, 16 Jan 2024 17:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGI1dL4U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998821C6A4;
	Tue, 16 Jan 2024 17:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705425674; cv=none; b=oHejpmIgzm3xwzdhFCfjGwSWUbCIhh0lEgqnhB1sDSkX07Qvpk6EGouaS4WtzRoSlQ9UMjMc/nHb1kbePg8Ej+Ai0kjEN7S7YaW75nCSYvTqUZR0i6Bw0NZSO3iqVBdIn2fNHeCXA+8qcq7lKkiBhKed6y/h/yU1sydNdLYKtqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705425674; c=relaxed/simple;
	bh=+s7BdUoBCMCiAl6dRO84XtwvPV6yE9mq5T/+vrTEjYo=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=KDWpceq7vPNJZFy7ZL5oyuLMn7isHrkKrnqy3YgCoBNhH6A0x85tfNnn7Iy22sh/O0+4Bk7tAUS0Vv+e9uzb/yaFZvXV3n1HLpMjCqchRelqrbXJqYY50iRbhBt2mbMOJ4HpjK1jmfPo5TGTRrt4fZL78vzpbZdSv0tNUKRnTj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CGI1dL4U; arc=none smtp.client-ip=209.85.222.180
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-783182d4a0aso927131285a.2;
        Tue, 16 Jan 2024 09:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705425672; x=1706030472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsq8qLuFLP0P03sUgsVAOnzZwZpYJQAdEllK5s+twZE=;
        b=CGI1dL4UuUO4rTXDyqePuvIQWi4zHnc54qylLpLR1s0mKnY7CaEybqYD02L6zzOOgY
         YZ6hZuVvkxGfBlZ78WYDDVlfGN2CKGdwwOudBZe8b+oVHb+2kYiuTtiZjAFRxU1EEdeg
         z4thxs9EIdHLnhmysJ2ot+5mdDT1gnUSpLvYsI9BFKxDo+MLfQXc7kpH1tummzB4HuBJ
         GFJ2hMDsX+dyNgBvEqCheRDjucuhpxmCEZzSVFpxnfWXid3TbSOI3GMWbmaop7ftlyKR
         U+/1hHrolozSCofaTU1RDW3cjdR5TbGiTONjzdu+EVoq4T3KmdX7kV6c7UjMze6wBxzI
         ckAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705425672; x=1706030472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsq8qLuFLP0P03sUgsVAOnzZwZpYJQAdEllK5s+twZE=;
        b=wcvo/WA5JrJhfXe6a30gD4eWZ8MoEvxhzJj3DjW8EuScJ8QB+QB4DVwZLyQjVgjRXK
         7LS4KgRuW97DZOrz0PlykAdJ070QWlTGQpD/YhlrNDRDnQo4RhpLJgKFs0msQkdEcyVv
         y3DCAf0jWt6DPFqzQOhIqdBxYqlQCSOVIxzMqjVcvqdSBEDrq6YKGn+E4Alhf/zbTaRk
         E3VPhhnBhl7pac/4eb7QEOOUBF69Sodmdrcuz6qEJdaDLZiozKuzbvbKJWa17szn/zmZ
         sRNvZyuJyb3CvVJLlfczE0lsSsWlR1UD6nmP4kc8Bfj6HqQqbL9h1ZOHsYor8Rs4/m4W
         XxyQ==
X-Gm-Message-State: AOJu0YySCwK8jf/Y1Lv29x3oS2CK3P/m0sExJ2tGBBBORcVIBBQelvg4
	zhK2ZcrJRnu6hdXEv36jC7cSiJnytE8ol0hA9tA=
X-Google-Smtp-Source: AGHT+IEM17ohiDtfRk+FpzNgwDt8eJwd4G4vMG8Q87oVPVjd1t/P5Dg311Nl4sTtne5m2FKN4NoSuUxwHOJrO9toCPo=
X-Received: by 2002:a0c:dd93:0:b0:681:795c:b5b0 with SMTP id
 v19-20020a0cdd93000000b00681795cb5b0mr58807qvk.105.1705425672424; Tue, 16 Jan
 2024 09:21:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000e3d83a060ee5285a@google.com> <B4A8D625-6997-49C8-B105-B2DCFE8C6DDA@oracle.com>
In-Reply-To: <B4A8D625-6997-49C8-B105-B2DCFE8C6DDA@oracle.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Jan 2024 19:21:00 +0200
Message-ID: <CAOQ4uxg8LLj4EN-MiMCR3vcarN3X6EMkgnqZ1uX1=G2DnxNbLQ@mail.gmail.com>
Subject: Re: [syzbot] [nfs?] KMSAN: kernel-infoleak in sys_name_to_handle_at (4)
To: Chuck Lever III <chuck.lever@oracle.com>
Cc: syzbot <syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com>, 
	Christian Brauner <brauner@kernel.org>, Jeff Layton <jlayton@kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux NFS Mailing List <linux-nfs@vger.kernel.org>, 
	"syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>, Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 5:08=E2=80=AFPM Chuck Lever III <chuck.lever@oracle=
.com> wrote:
>
>
>
> > On Jan 14, 2024, at 5:14=E2=80=AFAM, syzbot <syzbot+09b349b3066c2e0b1e9=
6@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    861deac3b092 Linux 6.7-rc7
> > git tree:       upstream
> > console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D155d9131e80=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3De0c7078a6b9=
01aa3
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D09b349b3066c2=
e0b1e96
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D16cefdc9e=
80000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D164fe7e9e80=
000
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/0ea60ee8ed32/d=
isk-861deac3.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/6d69fdc33021/vmli=
nux-861deac3.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/f0158750d452=
/bzImage-861deac3.xz
> > mounted in repro: https://storage.googleapis.com/syzbot-assets/bb450f07=
6a10/mount_0.gz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com
> >
> >         option from the mount to silence this warning.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> > BUG: KMSAN: kernel-infoleak in instrument_copy_to_user include/linux/in=
strumented.h:114 [inline]
> > BUG: KMSAN: kernel-infoleak in _copy_to_user+0xbc/0x100 lib/usercopy.c:=
40
> > instrument_copy_to_user include/linux/instrumented.h:114 [inline]
> > _copy_to_user+0xbc/0x100 lib/usercopy.c:40
> > copy_to_user include/linux/uaccess.h:191 [inline]
> > do_sys_name_to_handle fs/fhandle.c:73 [inline]
> > __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
> > __se_sys_name_to_handle_at+0x949/0xb10 fs/fhandle.c:94
> > __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
> > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
> > entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >
> > Uninit was created at:
> > slab_post_alloc_hook+0x129/0xa70 mm/slab.h:768
> > slab_alloc_node mm/slub.c:3478 [inline]
> > __kmem_cache_alloc_node+0x5c9/0x970 mm/slub.c:3517
> > __do_kmalloc_node mm/slab_common.c:1006 [inline]
> > __kmalloc+0x121/0x3c0 mm/slab_common.c:1020
> > kmalloc include/linux/slab.h:604 [inline]
> > do_sys_name_to_handle fs/fhandle.c:39 [inline]
> > __do_sys_name_to_handle_at fs/fhandle.c:112 [inline]
> > __se_sys_name_to_handle_at+0x441/0xb10 fs/fhandle.c:94
> > __x64_sys_name_to_handle_at+0xe4/0x140 fs/fhandle.c:94
> > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
> > entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >
> > Bytes 18-19 of 20 are uninitialized
> > Memory access of size 20 starts at ffff888128a46380
> > Data copied to user address 0000000020000240
> >
> > CPU: 0 PID: 5006 Comm: syz-executor975 Not tainted 6.7.0-rc7-syzkaller =
#0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 11/17/2023
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> Hi Amir-
>
> The kmalloc() at fs/fhandle.c:39 could be made a kzalloc().
>
> But I wonder if those uninitialized bytes in the file_handle
> buffer are actually a logic bug in do_sys_name_to_handle().
>

I am not sure I understand from the report which bytes are not initialized.
If it's the bytes of the opaque f_handle, then it sounds like a
filesystem (nilfs) bug.

Thanks,
Amir.


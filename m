Return-Path: <linux-fsdevel+bounces-23180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CFB9281A2
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 08:02:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 283FA1C225D0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jul 2024 06:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D50014374F;
	Fri,  5 Jul 2024 06:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVukKZnK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7DA13D624;
	Fri,  5 Jul 2024 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720159339; cv=none; b=CSzm+bQvslmPPLZAbVTFAbvxqyWICFkktHkJRO2R/N2jIlGnojFYx3YIRpSB+ZNl6cpU9CtItShFOtq9qpNtNtZTAfAljVq9bU0fh/nzOHATAz3/6XMfWAU2Kl/Hic9bqERq8HawaDwqDd9MkCYHqlJiWxwH2st2ialogMt7v8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720159339; c=relaxed/simple;
	bh=IHsjp5xudc9gfFZTXT7Gw4oO03SDutplf/954zUnnR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aiwQ+NoW+QWmYekeYK6ADQad+EbL/7JZkXzv/499JcNw60IAaUcS6Z7UbCscRKjN3ULq0JpJG3vpk575y2gkJ79qhq4bGGD+PSGrTsML7ef9gLt5IYJTVU2IU98OCrQ4lZby/oCIPUvQRH5cm77Oi4ARyJC7cluRU/lzFHLxHnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVukKZnK; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-79c2c05638cso84528585a.3;
        Thu, 04 Jul 2024 23:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720159337; x=1720764137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iDSMPCWgkzUmCVOS/wkYm8ZHue8LS0ngt+Yu+GT8Vd8=;
        b=HVukKZnKRUe0qRGdSBQRg9iUQKhoBvuaI3DGcQ8Fs1P2ZRuh7AMl0s0IMMcbXWLOoe
         yh9qmc11rQZQ/9X1Uitd3QEmzx3x9XU9pqzq5iMOh3HhpzX6Mnnqq82lXmDClAP0ZuRu
         uewb5xq4j4jobRZx9O+dK3zGEnyMXgNIk5MNYvD5B/cb95GItS2PMKZ3h2otV/EHmugU
         TGMUJAbAZOt0fLXhAYugKJ3HP0bB8u7ZUi1wohsWdrCtnibhtQsbbgg2oFYh2cERxLKK
         SBDqCAn14W44dR+WrzsPC6JeKGdV9uDcBqsCAmVDmLog0LRA4GxG/l2qKJp1MsHI9hw/
         v9kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720159337; x=1720764137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iDSMPCWgkzUmCVOS/wkYm8ZHue8LS0ngt+Yu+GT8Vd8=;
        b=eH0g41cjekyYQcjE/bDpFtLZnG68Z8vyxJMVa0PffkYSCK4Dvli3PHcI+8nsf+LpA/
         N2VZoKAasA26Oy2pZj3ZJd3dGd0DQUQniRpg0blP7CsCJA+EH3f3HuxwCbjvQyFYl1h2
         e9uMtP9tWmxIK8OPd6v/49KRFYrNmC2unNTqmUiHCN+Eujj5wXnWcPdWPifk6Hlgmgtl
         F0FszVuy+z35FKLFUDM2I6o37ynuxwLyvH8jAHFCVv9OWZgIFoVoaGLOuTEmXCvuPlf/
         tQ+dcQG3Ev8wcJCBoA9bkdMFE41Etuy0BJXDBHk0r0ePrEj4WC39d05MkrV1lKhImJ4+
         qkbQ==
X-Forwarded-Encrypted: i=1; AJvYcCVkjaZg/lmcT1yKzvwE65OjPS+a0Cj8WWxLXfgwyYQfdu7jQq3PVbGG4lua5nZ2hWnkhmuTGSIY66yHgZBWJAsbwFdIRP1CS7jFHCqQB+DrjBqIvVbwv8Q7O8+1hH76A3+7VERtxel8ahknzA==
X-Gm-Message-State: AOJu0YxakhEygAafTEfA8VZUR25jfEia4EKp27ZwaR2JjFkHZAWIf/Sj
	nLDGz6398L86SMzrmNIUtsPhn0sQu/SF8AvwJKEUWm/qgXbbLjtaBKNnaWa4X2qEL/BzGxsSzyo
	T5+mTo+kICWlnxEcDI4JrT+Ltd5w=
X-Google-Smtp-Source: AGHT+IFNFUWtWzbWlKxZiKNMBdGsDJpC8kblNGIslO0Z1lEWehJMVUGkLRvGeTYXmYj7PibCus0P/XQMiJyA6j7oWrc=
X-Received: by 2002:ac8:5886:0:b0:441:5a6c:6b7d with SMTP id
 d75a77b69052e-447cbf9bfc7mr41084871cf.55.1720159336900; Thu, 04 Jul 2024
 23:02:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000dc5b12061c6cac00@google.com> <CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com>
In-Reply-To: <CACT4Y+Zk0ohwwwHSD63U2-PQ=UuamXczr1mKBD6xtj2dyYKBvA@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 5 Jul 2024 09:02:05 +0300
Message-ID: <CAOQ4uxj78ZbHgB+Vyhd-mRKNjbv+kPX8hMsrkSZPkmr5MAvQWg@mail.gmail.com>
Subject: Re: [syzbot] [fs?] KCSAN: data-race in __fsnotify_parent /
 __fsnotify_recalc_mask (5)
To: Dmitry Vyukov <dvyukov@google.com>
Cc: syzbot <syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com>, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 5:28=E2=80=AFPM Dmitry Vyukov <dvyukov@google.com> w=
rote:
>
> On Thu, 4 Jul 2024 at 16:22, syzbot
> <syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com> wrote:
> >
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    795c58e4c7fc Merge tag 'trace-v6.10-rc6' of git://git.k=
ern..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16a6b6b9980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D5b9537cd00b=
e479e
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D701037856c25b=
143f1ad
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/3d1d205c1fdf/d=
isk-795c58e4.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/641c78d42b7a/vmli=
nux-795c58e4.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/45ecf25d8ba3=
/bzImage-795c58e4.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+701037856c25b143f1ad@syzkaller.appspotmail.com
> >
> > EXT4-fs (loop3): unmounting filesystem 00000000-0000-0000-0000-00000000=
0000.
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > BUG: KCSAN: data-race in __fsnotify_parent / __fsnotify_recalc_mask
> >
> > write to 0xffff8881001c9d44 of 4 bytes by task 6671 on cpu 1:
> >  __fsnotify_recalc_mask+0x216/0x320 fs/notify/mark.c:248
> >  fsnotify_recalc_mask fs/notify/mark.c:265 [inline]
> >  fsnotify_add_mark_locked+0x703/0x870 fs/notify/mark.c:781
> >  fsnotify_add_inode_mark_locked include/linux/fsnotify_backend.h:812 [i=
nline]
> >  inotify_new_watch fs/notify/inotify/inotify_user.c:620 [inline]
> >  inotify_update_watch fs/notify/inotify/inotify_user.c:647 [inline]
> >  __do_sys_inotify_add_watch fs/notify/inotify/inotify_user.c:786 [inlin=
e]
> >  __se_sys_inotify_add_watch+0x66f/0x810 fs/notify/inotify/inotify_user.=
c:729
> >  __x64_sys_inotify_add_watch+0x43/0x50 fs/notify/inotify/inotify_user.c=
:729
> >  x64_sys_call+0x2af1/0x2d70 arch/x86/include/generated/asm/syscalls_64.=
h:255
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > read to 0xffff8881001c9d44 of 4 bytes by task 10004 on cpu 0:
> >  fsnotify_object_watched fs/notify/fsnotify.c:187 [inline]
> >  __fsnotify_parent+0xd4/0x370 fs/notify/fsnotify.c:217
> >  fsnotify_parent include/linux/fsnotify.h:96 [inline]
> >  fsnotify_file include/linux/fsnotify.h:131 [inline]
> >  fsnotify_open include/linux/fsnotify.h:401 [inline]
> >  vfs_open+0x1be/0x1f0 fs/open.c:1093
> >  do_open fs/namei.c:3654 [inline]
> >  path_openat+0x1ad9/0x1fa0 fs/namei.c:3813
> >  do_filp_open+0xf7/0x200 fs/namei.c:3840
> >  do_sys_openat2+0xab/0x120 fs/open.c:1413
> >  do_sys_open fs/open.c:1428 [inline]
> >  __do_sys_openat fs/open.c:1444 [inline]
> >  __se_sys_openat fs/open.c:1439 [inline]
> >  __x64_sys_openat+0xf3/0x120 fs/open.c:1439
> >  x64_sys_call+0x1057/0x2d70 arch/x86/include/generated/asm/syscalls_64.=
h:258
> >  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> >  do_syscall_64+0xc9/0x1c0 arch/x86/entry/common.c:83
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> >
> > value changed: 0x00000000 -> 0x00002008
> >
> > Reported by Kernel Concurrency Sanitizer on:
> > CPU: 0 PID: 10004 Comm: syz-executor Not tainted 6.10.0-rc6-syzkaller-0=
0069-g795c58e4c7fc #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 06/07/2024
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> I think __fsnotify_recalc_mask() can be compiled along the lines of:
>
> *fsnotify_conn_mask_p(conn) =3D 0;
> hlist_for_each_entry(mark, &conn->list, obj_list) {
>    ...
>    *fsnotify_conn_mask_p(conn) |=3D fsnotify_calc_mask(mark);
>    ...
> }
>
> And then fsnotify_object_watched() may falsely return that it's not
> watched (if it observes 0, or any other incomplete value).

As far as I know, this is by design that fsnotify_object_watched()
is a relaxed test that allows for false negatives right after watch was add=
ed.
At least this has always been the case.

The question is whether a system call (e.g. open) that started strictly
after the inotify_add_watch() syscall returned success can realistically
observe an incomplete mask, because if the two syscalls are racing
this data race is not interesting.

Jan,

WDYT?
If this is the case, then is there a way to annotate access to
*_fsnotify_mask to
silence KCSAN warnings?

Thanks,
Amir.


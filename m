Return-Path: <linux-fsdevel+bounces-70329-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 352ABC96CE1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 12:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C75B04E15A0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 11:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73BC6306B17;
	Mon,  1 Dec 2025 11:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZRvYSu7P"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433D7302149
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 11:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764587282; cv=none; b=THMgrTJ+GJcm6/qaIgF/oUxrO2+tLZxFm3Z4xLcyuYMBZUR6pvvfxDVN3hmXA4pbPA3QeiLb8TsuPT06xe6oWv03rNZjHDr2jkTwPNVWnhn8OFNJW0qiKQ+Q9I3bjzC3+Dh/mi2Jh96vNxKRm/L1U/NikxMCv4T49g0fnSV77aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764587282; c=relaxed/simple;
	bh=Htfu+EUoy3OIQ4l99ZkD3lX15TBCC97XWt0K2FDNeIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DxLcLv+Wb7bltuE/GFWy0M2+YQu9lBpWIlpWOYO32AyxZ3sr9uxCvb36uOZF6ESoRt2gxNyILrq+58Tf2KBkpA4EW9He8d8fPc1MmxAjnwjG++YwP5GWpGnJ+FmhNzGZf6ZHh7/XmREvlpg8OtIkCeNEYNvMoPwx7k/YHYetiK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZRvYSu7P; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-65749fe614bso633493eaf.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 03:08:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1764587279; x=1765192079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TEzBQLyk4mWg+RUWOYgGvTBZIbad3i6PFsXwcCg3bJ4=;
        b=ZRvYSu7PnN27mo2Q2G9jhqQM7YPcjFA44fFsyc6gr9LLbi/N8inO2TxeiR/owCqL7D
         LxfDGxkFWe3LT+JmDnUWOlh1taaTdwOzqyGlVlzKKcdsBUx/qOMaKpEozA41zugXV9Ry
         ublmbBOGQZQ4jKtgwuABaEC/h34CPv+iwrn2LfLozjRQ6WrQpJRty9wS8ZJ24Rg7XFE8
         Ww/b9TPcWeXBc5m1Ul65lJOo/tFS8YFYbR0O5uiXmRXW36dAZFqnEh7HOYoLI1Dprg8/
         Y7TKhAssUpMakC59hBJZKThJY7l6F7t+vIofZ9LrkapLC1P7zaKq6a5D4uUtyHPwXaiD
         OnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764587279; x=1765192079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TEzBQLyk4mWg+RUWOYgGvTBZIbad3i6PFsXwcCg3bJ4=;
        b=FNFK3gJpO8BUedRojYqP1ejzw6/m1WkYP15HJirbaosHjLSuuaiuYbF3q61GzgBXOQ
         TD3dEz4Gd/0LTQruRs9WklTOLeuygHPzOV0p9IYcAwFvz0LzYcyGtxKEiB/4VU76dFou
         hf6nusRoK/AzM8nHsapwsUbFE1luGr5AOI7u80IFsJRkLYdDgQC5hqJI1v9Py+KWCPP+
         /6Y9fWqx7LwqDJc/eINhd0SfSVZ3Tjn143bsnyfSK38U+LpXU1ePDQMFnc1kDBA0pM7r
         KQc4/a9nwLBi12R0Wp6j6wbV0GXcgYiVIJuiktwGwDUsNoPbrfeYJi/h+Qz+FUvNDI2n
         Cztw==
X-Forwarded-Encrypted: i=1; AJvYcCXB/qj1qwXaLoq6z0bPlqxOYVFDrLAlBf+oD8axW4/froPDGUYJRqDFRcFhI2LY3f6Dy5r0IC5CgJSmc2hc@vger.kernel.org
X-Gm-Message-State: AOJu0YxkslJok0azoMVHgxuxvJMwgAJ6j29DiXZ+o2r++3HSqYC5txeV
	78UJ3EFjI/hwzPixRoRGkpJMauaXuEvqarQ7MdMNmvdHDkfYuQ5nPzMXVgVO5U3Lbj+7Iz/EuNP
	3fQwEJGlR126byA8khuEmD/NmZwVT5KwccHMjhzHv
X-Gm-Gg: ASbGnct1IYonx3JmbLUT5seSI1cQ3oD2lAj/dFJp5u8Jyt90xtQnhdjWDnaomPXO8Lu
	TzDL/qNNKz1IMHcKZ95bdV8/Z54+0oHc+EQm9KsB52GHtQvzPFaJzPSywT2XaQm8G+SFzs/gN4R
	+rQwFuOQG2I7oQnAkfe5J4EBCiHXmD9Ae9bOaQu+9VZ7W2kTRQqKwXSjVAnQRBFA5re1sdAeZdk
	1KUnFe4ijgNiqdQDnv2M+7T3lIksIhYwdg9yy4Tj6tgA1aLu8nWlj8J9zgjqyJYSzjR4kil/ktn
	F/eRU3unqG7y9HGC1yQT1QixtswB8KIaMRBeng7uHQd7wKRv7smGjzyFqqACzftDtSaxAk8=
X-Google-Smtp-Source: AGHT+IH658FiO/O1KIjOnohlPuHjIUHtBdcDuFxLQZXT4Wp2F0+jjP+D3cJWc61UcGWrM1u1DFecOzOBNVniOO1JfjQ=
X-Received: by 2002:a05:6820:1349:b0:653:827d:1abb with SMTP id
 006d021491bc7-65792160fe7mr11687906eaf.2.1764587279138; Mon, 01 Dec 2025
 03:07:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <692aef93.a70a0220.d98e3.015b.GAE@google.com> <CAOQ4uxhPEt76ij9zBtdKf0qYwSjeXquGGkLHeArO5t1LhdTHOg@mail.gmail.com>
 <CANp29Y56-h6SqKMGR5FF=4PNVj2a45nuX9nQAA9f2ZfiVrNSrw@mail.gmail.com> <CAOQ4uxisEzWmAWE8HfTRSe32ANZ4ov+i43Ts86DEA0sEXCC17A@mail.gmail.com>
In-Reply-To: <CAOQ4uxisEzWmAWE8HfTRSe32ANZ4ov+i43Ts86DEA0sEXCC17A@mail.gmail.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 1 Dec 2025 12:07:47 +0100
X-Gm-Features: AWmQ_bnNM-LJP2jN6PKgYx0QVDRaUPRUUAvD_a9ASXreMcBkFR5AE9EvKTBZGFM
Message-ID: <CANp29Y7o6pS9cMwqzMSxiriOqbGu-pM08RvmHRGDOOU7xuYZHg@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in fast_dput
To: Amir Goldstein <amir73il@gmail.com>
Cc: syzbot <syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com>, 
	NeilBrown <neil@brown.name>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 12:05=E2=80=AFPM Amir Goldstein <amir73il@gmail.com>=
 wrote:
>
> On Mon, Dec 1, 2025 at 10:08=E2=80=AFAM Aleksandr Nogikh <nogikh@google.c=
om> wrote:
> >
> > On Mon, Dec 1, 2025 at 9:58=E2=80=AFAM Amir Goldstein <amir73il@gmail.c=
om> wrote:
> > >
> > > On Sat, Nov 29, 2025 at 2:05=E2=80=AFPM syzbot
> > > <syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    7d31f578f323 Add linux-next specific files for 2025=
1128
> > > > git tree:       linux-next
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14db5f4=
2580000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6336d8e=
94a7c517d
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db74150fd2=
ef40e716ca2
> > > > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f9=
09b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1780a=
112580000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10f6be9=
2580000
> > > >
> > > > Downloadable assets:
> > > > disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad90=
de/disk-7d31f578.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca7/=
vmlinux-7d31f578.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/fc0448ab=
2411/bzImage-7d31f578.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > WARNING: fs/dcache.c:829 at fast_dput+0x334/0x430 fs/dcache.c:829, =
CPU#1: syz.0.17/6053
> > > > Modules linked in:
> > > > CPU: 1 UID: 0 PID: 6053 Comm: syz.0.17 Not tainted syzkaller #0 PRE=
EMPT(full)
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 10/25/2025
> > > > RIP: 0010:fast_dput+0x334/0x430 fs/dcache.c:829
> > > > Code: e3 81 ff 48 b8 00 00 00 00 00 fc ff df 41 0f b6 44 05 00 84 c=
0 0f 85 e2 00 00 00 41 80 0e 40 e9 fd fe ff ff e8 4d e3 81 ff 90 <0f> 0b 90=
 e9 ef fe ff ff 44 89 e6 81 e6 00 00 04 00 31 ff e8 74 e7
> > > > RSP: 0018:ffffc90003407cd8 EFLAGS: 00010293
> > > > RAX: ffffffff823fcfe3 RBX: ffff88806c44ac78 RCX: ffff88802e41bd00
> > > > RDX: 0000000000000000 RSI: 00000000ffffff80 RDI: 0000000000000001
> > > > RBP: 00000000ffffff80 R08: 0000000000000003 R09: 0000000000000004
> > > > R10: dffffc0000000000 R11: fffff52000680f8c R12: dffffc0000000000
> > > > R13: 1ffff1100d889597 R14: ffff88806c44abc0 R15: ffff88806c44acb8
> > > > FS:  00005555820e4500(0000) GS:ffff888125f4f000(0000) knlGS:0000000=
000000000
> > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > CR2: 0000001b31b63fff CR3: 0000000072c78000 CR4: 00000000003526f0
> > > > Call Trace:
> > > >  <TASK>
> > > >  dput+0xe8/0x1a0 fs/dcache.c:924
> > > >  __fput+0x68e/0xa70 fs/file_table.c:476
> > > >  task_work_run+0x1d4/0x260 kernel/task_work.c:233
> > > >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
> > > >  __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
> > > >  exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
> > > >  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [=
inline]
> > > >  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h=
:256 [inline]
> > > >  syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [i=
nline]
> > > >  syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline=
]
> > > >  do_syscall_64+0x2e3/0xf80 arch/x86/entry/syscall_64.c:100
> > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > RIP: 0033:0x7f4966f8f749
> > > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 4=
8 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01=
 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > > RSP: 002b:00007ffc01c51258 EFLAGS: 00000246 ORIG_RAX: 0000000000000=
1b4
> > > > RAX: 0000000000000000 RBX: 000000000001a7a1 RCX: 00007f4966f8f749
> > > > RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> > > > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000201c5154f
> > > > R10: 0000001b30f20000 R11: 0000000000000246 R12: 00007f49671e5fac
> > > > R13: 00007f49671e5fa0 R14: ffffffffffffffff R15: 0000000000000004
> > > >  </TASK>
> > > >
> > >
> > > Any idea why this was tagged as overlayfs?
> > > I do not see overlayfs anywhere in the repro, logs, or stack trace.
> >
> > Looks like the crash title is too generic, so we ended up with a
> > collection of unrelated crashes here. However, several issues are
> > indeed related to overlayfs:
> > https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D143464b4580000
> > https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D1683a112580000
> >
>
> OK but which repo, if any, are those crashes related to?
> I am not exactly sure how to process this information.

See the crashes at "2025/11/28 23:23" and at "2025/11/29 06:18" at the
bottom of the page here:
https://syzkaller.appspot.com/bug?extid=3Db74150fd2ef40e716ca2

Both were found on next-20251128.

>
> Thanks,
> Amir.


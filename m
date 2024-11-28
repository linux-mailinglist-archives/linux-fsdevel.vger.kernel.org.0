Return-Path: <linux-fsdevel+bounces-36112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F05959DBE20
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Nov 2024 00:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C42AB218C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Nov 2024 23:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F12A1448F2;
	Thu, 28 Nov 2024 23:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xdozwbon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7A8135A63
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 23:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732836675; cv=none; b=n7jpn9rnXCMFuSPekCnhl0VtVVtVnfhH1/+nIqjxzmdDxIi9S85KIZ32HqpaAgw9WsOT2L24AmIvAhtefABCa0raZXP5RvWUM+gKqWja6KNF2ahcgFItkZvAA+sCF4zFIh4z3G5W5kZX74fkwYOgzDjPwP40IYKLOkbu3hZOfzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732836675; c=relaxed/simple;
	bh=EQXAJ08tUnlBvyrjKDbPFZFspw50tpSxRdVT8Q7hr5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=txjHlJbJ2UBlq/SxjbXbPttMFriu0F/wGeN9HsuzRiVYlFzYZzkxHkT9a5mTMYiWKiDAS4yUdZWR7e6em1YxAXGcsxDcKNTITv+zmC+wzf2QyytsNxWhnvoYKtniMSVhgQKXd+eY8+ou8Kt/ux+g/KV7xt1bahCyEHsbgsfig1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xdozwbon; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cfc18d5259so10231a12.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 Nov 2024 15:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1732836672; x=1733441472; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgYjQEiw9LHmDSPL4yUSc4EUk9VqZlNda+SIAj1FUFk=;
        b=xdozwbongmdEt1zexvqq+LEa6mvAsfUnpgl3WuEgol5x/XjlaD9qJLh9a91o35C6Qe
         zGjG8jweM+s77c47cCsvo83zXuyPdCMn5got24cV1UXzFEe6fXEGhjlYD/QvfpMoZMLL
         BUOoq6sNo1QKUrMXhZWD8QC6KKhuWm4BRE3hoHnWpKy0mAAA2VBd5MDeULmBM0A9aua8
         8j2U+msQWkkbcNSdo48D8qUHrvSp2kx9DCJnTC8rnvAw5wRbaO2P8dve495vCYr3Q+Tb
         y1dXHLeDk3D87/K+f5h5WKpSsjAVK8XPfs3p5YZh4c6aBHTwOB5vpq+hfpgiyAt4qzrG
         3k6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732836672; x=1733441472;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NgYjQEiw9LHmDSPL4yUSc4EUk9VqZlNda+SIAj1FUFk=;
        b=av6aEd1dHK6aem8xPvOcvPSMjuvuCxlnTSlJNEvdF638PCLwhCiKcffqVIRSx2uyun
         8pxxMP2/zEzNYndETMaG9+vdo2JFDYOs58bdnlkKzvLMVSPolgzkTlgypIBztAWxBXAI
         Zel+VPvh9BN/8PELvRW4fI92ypRY6iE4WIrMAxKlmjfbIVn58kxsEhTzayXlh+wpe/Xm
         xrMkyNCZXYokQ9iguWmEnUa+UXGz6eXk4VGvLQiKzJg0+MglSAGUcmRpVASs7eLa9amD
         cCA+XHXEZq+ij3kD9jGBibHZ0ETxE4FJmH/+om2vbWAsSbzaIKB4eaeMu/mmOAxYWhNY
         J9Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXcUlS3kkBL5WbH5GZZK/wk/8DHAQSKKEwP6n4MnKugdeXZphXUD5X7G16fUtcHOfAkg5US/j8p1d/1jhfE@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8x7vabUmWMbsTr8U16UXdnMAZfFk7Xs1GbCA0tjpoEefuE1iq
	AF8dkaWLCo0Ifs+nvNYSbhhbKVnriqAmdZ95a9q41OMvwmcJKB7lTsXTUGVZOcVQzLJzwKMZpHk
	pzCQoqO7vpr8/ZJX9O6IWJK200MOE0lzJw3aO
X-Gm-Gg: ASbGncs/bjUaZ7txvcEl1Vz6PP4yQvVzQZ5TAzfogf54HdLQMIYZ0QKYWNh3i6hhy2Q
	H6jIQH3vxfV7I9qp/wiUxX6D1IRt58VWY6o61qPPCB/JD+LQCv3yHKwqS/BQ=
X-Google-Smtp-Source: AGHT+IH+TVxMX3dg0faFFoM9K64QmaJRCnPpv51YUm8E8cf99TmdKomtFn7U/+TGYymaHS5h356gf4BPsFZKAIngk3k=
X-Received: by 2002:a50:fb86:0:b0:5d0:f39:9c7 with SMTP id 4fb4d7f45d1cf-5d09827c3f0mr72367a12.7.1732836671653;
 Thu, 28 Nov 2024 15:31:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <673c1643.050a0220.87769.0066.GAE@google.com>
In-Reply-To: <673c1643.050a0220.87769.0066.GAE@google.com>
From: Jann Horn <jannh@google.com>
Date: Fri, 29 Nov 2024 00:30:35 +0100
Message-ID: <CAG48ez0uhdGNCopX2nspLzWZKfuZp0XLyUk90kYku=sP7wsWfg@mail.gmail.com>
Subject: Re: [syzbot] [io-uring?] WARNING in __io_uring_free
To: syzbot <syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com>, 
	Matthew Wilcox <willy@infradead.org>
Cc: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

+Matthew for xarray

On Tue, Nov 19, 2024 at 5:38=E2=80=AFAM syzbot
<syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    cfaaa7d010d1 Merge tag 'net-6.12-rc8' of git://git.kernel=
...
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13005cc058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dd2aeec8c0b2e4=
20c
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dcc36d44ec9f368e=
443d3
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7=
feb34a89c2a/non_bootable_disk-cfaaa7d0.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/63eae0d3e67f/vmlinu=
x-cfaaa7d0.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6495d9e4ddee/b=
zImage-cfaaa7d0.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+cc36d44ec9f368e443d3@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 16 at io_uring/tctx.c:51 __io_uring_free+0xfa/0x140 =
io_uring/tctx.c:51

This warning is a check for WARN_ON_ONCE(!xa_empty(&tctx->xa)); and as
Jens pointed out, this was triggered after error injection caused a
memory allocation inside xa_store() to fail.

Is there maybe an issue where xa_store() can fail midway through while
allocating memory for the xarray, so that xa_empty() is no longer true
even though there is nothing in the xarray? (And if yes, is that
working as intended?)

> Modules linked in:
> CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.12.0-rc7-syzkaller-=
00125-gcfaaa7d010d1 #0
> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.=
16.3-2~bpo12+1 04/01/2014
> RIP: 0010:__io_uring_free+0xfa/0x140 io_uring/tctx.c:51
> Code: 80 7c 25 00 00 74 08 4c 89 f7 e8 a1 8a 49 fd 49 c7 06 00 00 00 00 5=
b 41 5c 41 5d 41 5e 41 5f c3 cc cc cc cc e8 37 ad df fc 90 <0f> 0b 90 e9 6a=
 ff ff ff e8 29 ad df fc 90 0f 0b 90 eb 84 e8 1e ad
> RSP: 0018:ffffc900004279b8 EFLAGS: 00010246
> RAX: ffffffff84b53cd9 RBX: ffff88804fc3b8e0 RCX: ffff88801b7e8000
> RDX: 0000000000000100 RSI: 0000000000000000 RDI: ffff88801f058000
> RBP: 0000000000000001 R08: ffffffff8154d881 R09: 1ffff11003e0b005
> R10: dffffc0000000000 R11: ffffed1003e0b006 R12: dffffc0000000000
> R13: 1ffff11003e0b120 R14: ffff88801f058900 R15: ffff88804fc3b800
> FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005594393ad338 CR3: 000000000e734000 CR4: 0000000000352ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  io_uring_free include/linux/io_uring.h:31 [inline]
>  __put_task_struct+0xd5/0x290 kernel/fork.c:975
>  put_task_struct include/linux/sched/task.h:144 [inline]
>  delayed_put_task_struct+0x125/0x300 kernel/exit.c:228
>  rcu_do_batch kernel/rcu/tree.c:2567 [inline]
>  rcu_core+0xaaa/0x17a0 kernel/rcu/tree.c:2823
>  handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
>  run_ksoftirqd+0xca/0x130 kernel/softirq.c:927
>  smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
>
>
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


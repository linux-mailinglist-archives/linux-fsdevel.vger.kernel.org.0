Return-Path: <linux-fsdevel+bounces-70333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8D76C97300
	for <lists+linux-fsdevel@lfdr.de>; Mon, 01 Dec 2025 13:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC5BE4E21E2
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Dec 2025 12:11:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108D53093D7;
	Mon,  1 Dec 2025 12:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkwDgH7t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752393090CB
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Dec 2025 12:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764591100; cv=none; b=KmflxouSg4wZk6FzGeOwqUSF2N+pRL1fqEsdwaKOBLsGFANLPlzfWTfvj4+e2MtHYnLyF1Ccae8laZSgMhhJBp7LWdP0NLOUvvaGZwgF9x6ULTFg8WNZr90mR5Hcrk6D5IE3cKQtUXrCIL3KPP1BxXv/POSPq2LtJcaJoNM8JN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764591100; c=relaxed/simple;
	bh=GEC6jsBDzR3pIEmMvoQo5UGmT6af0RNEyClaAGysjVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RxGiXeOoGLrG0ZRgBPMGL5eaONAI9t2LfB+NlvunbzzCsAWnVifFDZHwWTuLJkPbOTlFGEMDqMyhQ/G6DiazwIIJV/JyTPWutSlAAYsgxepORvKSNOMSpdeS0YEwdzjXIorYvJfY+eXK0D8r3Xm0JZkEKWXePgbz3IVcFO60JMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LkwDgH7t; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so7859277a12.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 01 Dec 2025 04:11:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764591097; x=1765195897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Kwv01GlWE0xYDVjwz+NHA0l0yfYs9VvTdBTljvm64GA=;
        b=LkwDgH7t+gKmrnpEw45TNxBB0y5xWwYj1bTrvr+Ir9xQaW6+whIdIeNA9LLw1/ZnRf
         7h7J5NNyejbypxyJxxZ0PUw9slFp4JhBTzNeyfnKShvnj5B/IuqS6qS/yXiat9zdQJAs
         aJUMWct7PqTNnkT9lHz/X6eCS2uz9y3eZZP+oM+tpqDp8yKljEkfSmA2JLqYh+rQNKkb
         /eyKk5m/TAYHdA3qXEKrBkmH4pH02tLcF5HGoFhpqo2U8QPKLA0U8Z3FPohfwfOsTdnW
         vd3SLiit5NIYKlnsjkm//VshT59mkgVlqtlm9J8ErobS/e/WeHmD41pSGXSP5tENrXFq
         iUQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764591097; x=1765195897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Kwv01GlWE0xYDVjwz+NHA0l0yfYs9VvTdBTljvm64GA=;
        b=efl0wspN1E4PNb1dj1uJnT3cc2clh5UWFuqWmFdL1OcdS3uAAoKic+AWiC6YL2pHP6
         eHAsbI3YdRp5oO7j2g7Z6cDX61tYz3j9HtgUNm//ddb9K0YIKIoSWLdHW/n8e6Q4NxPo
         mvaX0YTv4osRcop91Y7m/7E4yR3K3v6HM3hdeFjpgBbPXJfiWpcFgvPDAjj49300IFLO
         RDaBno4OshSoLVBwkhuwZeR/GW/EeAqHGUlNgDd2tNzhbSV4NE9ZSEUNku/riWRm3P4s
         6AVANqOc6mT6cb/OqbqEkR55u5rrqaKQSygpPHRWZiHNsKvn7piRruH5UpyZT/5gzUPL
         8sBw==
X-Forwarded-Encrypted: i=1; AJvYcCV5hwoJz57gmv1mPcuEZqvtsOvKzXZrRaJQli72BUe45SYzxL/ARygvMIEJU1c58LRx0sPVSNt8TK2M87Fb@vger.kernel.org
X-Gm-Message-State: AOJu0YwKCSfptjd6jSjSV3yqmQ/BnAPuMFdUnUK13g5v+cHi/2WRT4yQ
	2vNIIzvth9wzoebrXel7ftzE4VFpRXYzv0ynw46wRuQrzTJRmffJROcs+h9bEfXRBC8O0/ePA7o
	1m2ZaZv78UVKoHZgnBW1kBHDDw1Mrxc8=
X-Gm-Gg: ASbGncsbaPbIZoWCUfCNtAemY9WZok41u9uX5TJOHcf9OeLDIPPSfxfoe2Tcv3TCdcQ
	Y6CMBtFxuNP06vqXDxhEaIbccemXdlBGbfuDupz09EY+l6dpdozSGoSbqZZwfRINNNEOZ3P/B59
	6xlYD6RrYX9H5dG8ezIP8llhfGY702j1Qoz13EGNAdJnJboFaNRlBVDzcFp8jHAmoi9whgWZGv8
	bSNTMsEuEq+j/fP4UV/h4T4j49c5+7ITdpug+BXgUG5Mtxxp6wlCnQCwkYJzffNLBnDcDcMaEQx
	N8zeIhahFSMbylLH6sJ2LBsXRLC8
X-Google-Smtp-Source: AGHT+IEnE+AI+SQrtbnFkGOMDowGuZUx1EH+NJVfmo2HuDmFAUYXlT8PsVRToeYVlZaSdBS9gVRJZLmOrnu1cEithOM=
X-Received: by 2002:a05:6402:1eca:b0:643:8301:d10f with SMTP id
 4fb4d7f45d1cf-6455469c74dmr34001997a12.31.1764591096430; Mon, 01 Dec 2025
 04:11:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <692aef93.a70a0220.d98e3.015b.GAE@google.com> <CAOQ4uxhPEt76ij9zBtdKf0qYwSjeXquGGkLHeArO5t1LhdTHOg@mail.gmail.com>
 <CANp29Y56-h6SqKMGR5FF=4PNVj2a45nuX9nQAA9f2ZfiVrNSrw@mail.gmail.com>
 <CAOQ4uxisEzWmAWE8HfTRSe32ANZ4ov+i43Ts86DEA0sEXCC17A@mail.gmail.com> <CANp29Y7o6pS9cMwqzMSxiriOqbGu-pM08RvmHRGDOOU7xuYZHg@mail.gmail.com>
In-Reply-To: <CANp29Y7o6pS9cMwqzMSxiriOqbGu-pM08RvmHRGDOOU7xuYZHg@mail.gmail.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Mon, 1 Dec 2025 13:11:25 +0100
X-Gm-Features: AWmQ_blshGxjICYCN8Ha0xe0N6edPUMs_olA3gJ5XYUa7UI2paFTqMmNciNuKu8
Message-ID: <CAOQ4uxghnKSduHdJnV7dQ_7sTJ1AxQMSrxVKZq0SYRG8gYyb+g@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in fast_dput
To: Aleksandr Nogikh <nogikh@google.com>
Cc: syzbot <syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com>, 
	NeilBrown <neil@brown.name>, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 1, 2025 at 12:08=E2=80=AFPM Aleksandr Nogikh <nogikh@google.com=
> wrote:
>
> On Mon, Dec 1, 2025 at 12:05=E2=80=AFPM Amir Goldstein <amir73il@gmail.co=
m> wrote:
> >
> > On Mon, Dec 1, 2025 at 10:08=E2=80=AFAM Aleksandr Nogikh <nogikh@google=
.com> wrote:
> > >
> > > On Mon, Dec 1, 2025 at 9:58=E2=80=AFAM Amir Goldstein <amir73il@gmail=
.com> wrote:
> > > >
> > > > On Sat, Nov 29, 2025 at 2:05=E2=80=AFPM syzbot
> > > > <syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.com> wrote:
> > > > >
> > > > > Hello,
> > > > >
> > > > > syzbot found the following issue on:
> > > > >
> > > > > HEAD commit:    7d31f578f323 Add linux-next specific files for 20=
251128
> > > > > git tree:       linux-next
> > > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D14db5=
f42580000
> > > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D6336d=
8e94a7c517d
> > > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Db74150f=
d2ef40e716ca2
> > > > > compiler:       Debian clang version 20.1.8 (++20250708063551+0c9=
f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
> > > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D178=
0a112580000
> > > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D10f6b=
e92580000
> > > > >
> > > > > Downloadable assets:
> > > > > disk image: https://storage.googleapis.com/syzbot-assets/6b49d8ad=
90de/disk-7d31f578.raw.xz
> > > > > vmlinux: https://storage.googleapis.com/syzbot-assets/dbe2d4988ca=
7/vmlinux-7d31f578.xz
> > > > > kernel image: https://storage.googleapis.com/syzbot-assets/fc0448=
ab2411/bzImage-7d31f578.xz
> > > > >
> > > > > IMPORTANT: if you fix the issue, please add the following tag to =
the commit:
> > > > > Reported-by: syzbot+b74150fd2ef40e716ca2@syzkaller.appspotmail.co=
m
> > > > >
> > > > > ------------[ cut here ]------------
> > > > > WARNING: fs/dcache.c:829 at fast_dput+0x334/0x430 fs/dcache.c:829=
, CPU#1: syz.0.17/6053
> > > > > Modules linked in:
> > > > > CPU: 1 UID: 0 PID: 6053 Comm: syz.0.17 Not tainted syzkaller #0 P=
REEMPT(full)
> > > > > Hardware name: Google Google Compute Engine/Google Compute Engine=
, BIOS Google 10/25/2025
> > > > > RIP: 0010:fast_dput+0x334/0x430 fs/dcache.c:829
> > > > > Code: e3 81 ff 48 b8 00 00 00 00 00 fc ff df 41 0f b6 44 05 00 84=
 c0 0f 85 e2 00 00 00 41 80 0e 40 e9 fd fe ff ff e8 4d e3 81 ff 90 <0f> 0b =
90 e9 ef fe ff ff 44 89 e6 81 e6 00 00 04 00 31 ff e8 74 e7
> > > > > RSP: 0018:ffffc90003407cd8 EFLAGS: 00010293
> > > > > RAX: ffffffff823fcfe3 RBX: ffff88806c44ac78 RCX: ffff88802e41bd00
> > > > > RDX: 0000000000000000 RSI: 00000000ffffff80 RDI: 0000000000000001
> > > > > RBP: 00000000ffffff80 R08: 0000000000000003 R09: 0000000000000004
> > > > > R10: dffffc0000000000 R11: fffff52000680f8c R12: dffffc0000000000
> > > > > R13: 1ffff1100d889597 R14: ffff88806c44abc0 R15: ffff88806c44acb8
> > > > > FS:  00005555820e4500(0000) GS:ffff888125f4f000(0000) knlGS:00000=
00000000000
> > > > > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > CR2: 0000001b31b63fff CR3: 0000000072c78000 CR4: 00000000003526f0
> > > > > Call Trace:
> > > > >  <TASK>
> > > > >  dput+0xe8/0x1a0 fs/dcache.c:924
> > > > >  __fput+0x68e/0xa70 fs/file_table.c:476
> > > > >  task_work_run+0x1d4/0x260 kernel/task_work.c:233
> > > > >  resume_user_mode_work include/linux/resume_user_mode.h:50 [inlin=
e]
> > > > >  __exit_to_user_mode_loop kernel/entry/common.c:44 [inline]
> > > > >  exit_to_user_mode_loop+0xff/0x4f0 kernel/entry/common.c:75
> > > > >  __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226=
 [inline]
> > > > >  syscall_exit_to_user_mode_prepare include/linux/irq-entry-common=
.h:256 [inline]
> > > > >  syscall_exit_to_user_mode_work include/linux/entry-common.h:159 =
[inline]
> > > > >  syscall_exit_to_user_mode include/linux/entry-common.h:194 [inli=
ne]
> > > > >  do_syscall_64+0x2e3/0xf80 arch/x86/entry/syscall_64.c:100
> > > > >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > > > > RIP: 0033:0x7f4966f8f749
> > > > > Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8=
 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> > > > > RSP: 002b:00007ffc01c51258 EFLAGS: 00000246 ORIG_RAX: 00000000000=
001b4
> > > > > RAX: 0000000000000000 RBX: 000000000001a7a1 RCX: 00007f4966f8f749
> > > > > RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
> > > > > RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000201c5154f
> > > > > R10: 0000001b30f20000 R11: 0000000000000246 R12: 00007f49671e5fac
> > > > > R13: 00007f49671e5fa0 R14: ffffffffffffffff R15: 0000000000000004
> > > > >  </TASK>
> > > > >
> > > >
> > > > Any idea why this was tagged as overlayfs?
> > > > I do not see overlayfs anywhere in the repro, logs, or stack trace.
> > >
> > > Looks like the crash title is too generic, so we ended up with a
> > > collection of unrelated crashes here. However, several issues are
> > > indeed related to overlayfs:
> > > https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D143464b45800=
00
> > > https://syzkaller.appspot.com/text?tag=3DCrashReport&x=3D1683a1125800=
00
> > >
> >
> > OK but which repo, if any, are those crashes related to?
> > I am not exactly sure how to process this information.
>
> See the crashes at "2025/11/28 23:23" and at "2025/11/29 06:18" at the
> bottom of the page here:
> https://syzkaller.appspot.com/bug?extid=3Db74150fd2ef40e716ca2
>
> Both were found on next-20251128.
>

I see.
I'll take Al's word for it, that these are all related to the same merge is=
sue
in the point in time next-20251128
that will be fixed in the next linux-next tag.

Thanks,
Amir.


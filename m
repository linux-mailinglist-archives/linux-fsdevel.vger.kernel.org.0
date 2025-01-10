Return-Path: <linux-fsdevel+bounces-38862-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B30A08EF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 12:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 604281661E7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 11:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD75120A5E9;
	Fri, 10 Jan 2025 11:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LSyGauMp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DFC1A4F1F;
	Fri, 10 Jan 2025 11:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736507668; cv=none; b=I3WiuTsDtTh2onJREWgoZ/dheVMyRqpcdC2Y07A+4NpntIADlVcIydYshebvK6fX43J8mvZifsl3+iW3JWgVhpNfC5pCoFaGlN7d8zEDp9AHwdMhf9nZtG9+HF5jUfvbaDHv4C9Xn0LAmvisr8mtN0VwMfkjVMOuxaJyZ8OWYy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736507668; c=relaxed/simple;
	bh=MhWdT/RqEe3w7S7YZL+p2ArH8fActThJHdaOOhyWxCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BS8F39A8f3guZN9GN6AhcGiiiwern/Mg8WW/hi1nlu6BhR4JnFy1UOgmoWW1aCuRpzHOZ5pqpSIy7FLR4ioOUHf6r8fEJL/TKmY7JLpS/lFV7IN7AawgAevwF2YC7oZ0FMOMN5avtk20tieFU8WQ8HORkfnsghGHpPffMud0c0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LSyGauMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC56BC4CEE1;
	Fri, 10 Jan 2025 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736507666;
	bh=MhWdT/RqEe3w7S7YZL+p2ArH8fActThJHdaOOhyWxCg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=LSyGauMpwZFGVX7Rv9Rith11aUNbJlpD1sDfT7gWpUsXg+21iWIx1iJcmNiawwy8R
	 1SMm0vJ4EcikzGt6apjV3mK639Ct+N9NNodLYqGg5Xr0c1coqCWQjQ7KqQ8BF910Zu
	 o3ql4dc/VYWFf2WpuADN+ed0Z0vEzcJ4H5iSgbngMAxL+PYmzNMGTa+uU9SQaQtEB6
	 q5qtUvBr+K3SqENYWFYKQhrmi0NtbPNDqqNi+ZxUlUytu+7gAu7B29TznEsLHHmLD1
	 4rBnCXZq9Z0on6GHhwODtJawjGgD4mS9rfwvra1wNGIX06gp8w+gUuJSX/r6uBrhaq
	 cX31Kj3vO0smg==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-29ff8053384so1005969fac.3;
        Fri, 10 Jan 2025 03:14:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVDuG4MCkDt9OwuzHTIcv/eTdX7NWTdkBXPxSYTaoI9E6qnMayrtJx15RRbp/ETHMwEdwsJGsMHQqxMhLaZ@vger.kernel.org, AJvYcCVvSdtMGNUr2N3Y4sJBTuvwTUQFZXrvuj7CJy0HhlTJAEqq5CKdKMPAsm5GTt3GOHDjH8oaFg5ktP+w8bSI@vger.kernel.org
X-Gm-Message-State: AOJu0YxvK3hstltA88osaf4TSF/hh4moCIxMSDNLF4E9hkfruCcprZHa
	31xk8A1Z1yuQZrL1asgHGCzHG47cHmkd+Na43WKvNUyoAGsala4clQiYQwDE+QhlBSXxGO4BZfk
	TOakqB6PU+VRRyPWBGk0Stw3WDwE=
X-Google-Smtp-Source: AGHT+IE0t/gZnvlcEcdM+A0ZoacdyjtcyskUhjHh1sKWCty9CpO9jUhUkc8O6xVXo/7n+oShscmJ5y8tW91wl6MpnEo=
X-Received: by 2002:a05:6870:a54d:b0:296:e88f:8f56 with SMTP id
 586e51a60fabf-2aa0690edeamr2297838fac.26.1736507665890; Fri, 10 Jan 2025
 03:14:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8F76A19F-2EFD-4DD4-A4B1-9F5C644B69EA@m.fudan.edu.cn> <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn>
In-Reply-To: <04205AC4-F899-4FA0-A7C1-9B1D661EB4EA@m.fudan.edu.cn>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 10 Jan 2025 20:14:14 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
X-Gm-Features: AbW1kvaoVQMKYzHvYE9gcTJJHbSg-JcepiofSSg332t8wuCxWetRcTMUCFc4C0A
Message-ID: <CAKYAXd_Zs4r2aX4M0DDQe2oYQaUwKrPq_qoNKj4kBFTSC2ynpg@mail.gmail.com>
Subject: Re: Bug: soft lockup in exfat_clear_bitmap
To: Kun Hu <huk23@m.fudan.edu.cn>
Cc: sj1557.seo@samsung.com, yuezhang.mo@sony.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	"jjtan24@m.fudan.edu.cn" <jjtan24@m.fudan.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 10, 2025 at 6:31=E2=80=AFPM Kun Hu <huk23@m.fudan.edu.cn> wrote=
:
>
>
>
> > 2025=E5=B9=B41=E6=9C=886=E6=97=A5 16:45=EF=BC=8CKun Hu <huk23@m.fudan.e=
du.cn> =E5=86=99=E9=81=93=EF=BC=9A
> >
> > Hello,
> >
> > When using our customized fuzzer tool to fuzz the latest Linux kernel, =
the following crash
> > was triggered.
> >
> > HEAD commit: fc033cf25e612e840e545f8d5ad2edd6ba613ed5
> > git tree: upstream
> > Console output: https://drive.google.com/file/d/1aWtDTAUFlAzvMI7YM_TLWb=
fbyqKFB71i/view?usp=3Ddrive_link
> > Kernel config: https://drive.google.com/file/d/1n2sLNg-YcIgZqhhQqyMPTDW=
M_N1Pqz73/view?usp=3Dsharing
> > C reproducer: https://drive.google.com/file/d/1oXFZgdxZDCrcZTmyatmI6TeY=
oHCaIxEA/view?usp=3Ddrive_link
> > Syzlang reproducer: https://drive.google.com/file/d/1KX9cnANDRzXZ1FjKl3=
uv6rSFC-5kLsko/view?usp=3Dsharing
> >
> >
> > If you fix this issue, please add the following tag to the commit:
> > Reported-by: Kun Hu <huk23@m.fudan.edu.cn>, Jiaji Qin <jjtan24@m.fudan.=
edu.cn>
> >
> > watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [syz-executor140:420]
> > Modules linked in:
> > irq event stamp: 163590
> > hardirqs last  enabled at (163589): [<ffffffff9c4d07eb>] irqentry_exit+=
0x3b/0x90 kernel/entry/common.c:357
> > hardirqs last disabled at (163590): [<ffffffff9c4cedbf>] sysvec_apic_ti=
mer_interrupt+0xf/0xb0 arch/x86/kernel/apic/apic.c:1049
> > softirqs last  enabled at (163576): [<ffffffff9450f554>] softirq_handle=
_end kernel/softirq.c:407 [inline]
> > softirqs last  enabled at (163576): [<ffffffff9450f554>] handle_softirq=
s+0x544/0x870 kernel/softirq.c:589
> > softirqs last disabled at (163555): [<ffffffff9451120e>] __do_softirq k=
ernel/softirq.c:595 [inline]
> > softirqs last disabled at (163555): [<ffffffff9451120e>] invoke_softirq=
 kernel/softirq.c:435 [inline]
> > softirqs last disabled at (163555): [<ffffffff9451120e>] __irq_exit_rcu=
 kernel/softirq.c:662 [inline]
> > softirqs last disabled at (163555): [<ffffffff9451120e>] irq_exit_rcu+0=
xee/0x140 kernel/softirq.c:678
> > CPU: 1 UID: 0 PID: 420 Comm: syz-executor140 Not tainted 6.13.0-rc5 #1
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubu=
ntu1.1 04/01/2014
> > RIP: 0010:exfat_clear_bitmap+0x3f1/0x580 fs/exfat/balloc.c:174
> > Code: 24 60 01 00 00 b9 40 0c 00 00 4c 89 fa e8 57 10 ff 01 bf a1 ff ff=
 ff 89 c3 89 c6 e8 49 52 5f ff 83 fb a1 74 13 48 83 c4 18 5b <5d> 41 5c 41 =
5d 41 5e 41 5f e9 01 50 5f ff e8 fc 4f 5f ff 49 8d b4
> > RSP: 0018:ffa00000035f7a90 EFLAGS: 00000286
> > RAX: 0000000000000000 RBX: 0000000000006ccc RCX: ffffffff952a4d03
> > RDX: 0000000000000011 RSI: ff110000118ba340 RDI: 0000000000000003
> > RBP: ff110000131cc000 R08: 0000000000000000 R09: fffffbfff4d5f0ed
> > R10: fffffbfff4d5f0ec R11: 0000000000000001 R12: ff110000131ce000
> > R13: 0000000000000011 R14: 0000000000000000 R15: 0000000006cccf6b
> > FS:  000055556ed2d880(0000) GS:ff11000053a80000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007ffe1b6fdd18 CR3: 000000000db32002 CR4: 0000000000771ef0
> > PKRU: 55555554
> > Call Trace:
> > <IRQ>
> > </IRQ>
> > <TASK>
> > __exfat_free_cluster+0x775/0x980 fs/exfat/fatent.c:192
> > exfat_free_cluster+0x7a/0x100 fs/exfat/fatent.c:232
> > __exfat_truncate+0x6bf/0x900 fs/exfat/file.c:235
> > exfat_evict_inode+0x10d/0x1a0 fs/exfat/inode.c:683
> > evict+0x403/0x880 fs/inode.c:796
> > iput_final fs/inode.c:1946 [inline]
> > iput fs/inode.c:1972 [inline]
> > iput+0x51c/0x830 fs/inode.c:1958
> > do_unlinkat+0x5c7/0x750 fs/namei.c:4594
> > __do_sys_unlink fs/namei.c:4635 [inline]
> > __se_sys_unlink fs/namei.c:4633 [inline]
> > __x64_sys_unlink+0x40/0x50 fs/namei.c:4633
> > do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> > do_syscall_64+0xc3/0x1d0 arch/x86/entry/common.c:83
> > entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7ff5d82fb1db
> > Code: 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e=
 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 57 00 00 00 0f 05 <48> 3d 01 f0 =
ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffe1b6ff558 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
> > RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007ff5d82fb1db
> > RDX: 00007ffe1b6ff580 RSI: 00007ffe1b6ff580 RDI: 00007ffe1b6ff610
> > RBP: 00007ffe1b6ff610 R08: 0000000000000001 R09: 00007ffe1b6ff3e0
> > R10: 00000000fffffff7 R11: 0000000000000206 R12: 00007ffe1b700710
> > R13: 000055556ed36bb0 R14: 00007ffe1b6ff578 R15: 0000000000000001
> > </TASK>
> >
> >
> > ---------------
> > thanks,
> > Kun Hu
>
>
> Hi,
>
> I=E2=80=99m not sure if this is sufficient to help locate the bug? If you=
 need additional information, please let me know.
Please try to reproduce it with linux-next or the latest Linus tree.
>
> Thanks,
> Kun Hu
>


Return-Path: <linux-fsdevel+bounces-45888-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E4FA7E276
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 16:47:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D199189ABD9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Apr 2025 14:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A3C1FF60A;
	Mon,  7 Apr 2025 14:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D3IO+2BN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oa1-f43.google.com (mail-oa1-f43.google.com [209.85.160.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2139D1E0B67;
	Mon,  7 Apr 2025 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744036460; cv=none; b=pNkwNg/yzZnnDl1mi542h6g7Tz1jluShi2516OnCs4pa9fFAOSKfJtecps8IjJswPHGDWEnNc0USAM/HdlC4lUlGjNrft4tdFlWA5HSsrEY3EzAYJ1nLmWax/L3GH6cBqZp/OxZ8NpfSFlQaLogi66XilAehNbMlZ0VrS3BrgC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744036460; c=relaxed/simple;
	bh=10hQjwiVl9auh+4TsVLGd2jmvqVvAN1BWWQoRX/5x6Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GiUwR6uYdgfs7IyrH6U9sGlpDAyC9H4PpBkqyzYdQ/gQlK+yQjbsxjoY8inrrIhDBcTkHUNKdNpioiiDchZFhHDt6VKRXQ4yUpIBSXSsTCamXpv5ExPSaqDwAIgRFSd359Q9mS8ijCsvhrx56Odlh2ye046lt4y+B7t9MsG5a/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D3IO+2BN; arc=none smtp.client-ip=209.85.160.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f43.google.com with SMTP id 586e51a60fabf-2b8e26063e4so2351314fac.3;
        Mon, 07 Apr 2025 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744036457; x=1744641257; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTopRkudXEUzQeJOvfu4l8bVu6j+srbmnKpDNdQn7Dg=;
        b=D3IO+2BNmgrwV3/DAIdpyTcCuToSQr/4KYJkT3AeyTA4R3zWiyhmmij0odPrwraWPo
         ikOwzye2luqBXKVLJPkTpyI/cscAako5jTP0AWVukbVCWi8x1imLiVBrKMLuVA/9W3tk
         ukbDccSEIsS0E50j23BTRV65aeZow7wtHDm7tJBcRivn7GKcB1ZP3UCbiIJwyEvgC/nr
         6WjsuD6TPkH4JkylVG4dDxVEZNVVMyRoYtez8IivxxFQaSWO3v9el67WJZT/IdLvTUCr
         qWSfOg/I+djimCo09JqU5cnLfvfIRcGWFO1X9aN+71b1juPaB8ZrNzyZYIjlM6rahkEa
         Hfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744036457; x=1744641257;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTopRkudXEUzQeJOvfu4l8bVu6j+srbmnKpDNdQn7Dg=;
        b=ZQuu3wr57o57eQkpHSjpUxKArYDSF5GIW/yOGuewcCbdI3ZEepqUVKn/k8iagTCNW+
         R3kgATl8tJom/PlCX7hE9XaDGXVeiWd9JvxQ61aTR4uE7c2wjvVK+l/d4Xm2bDVLsBhH
         g1dRRbM5wW2RCDMaVnVW/idl/L8VVD1D44yx+lwmPG2wq2w7dYkHZuNLB1WBjin4Bap5
         YqP2itzLZSQ6yOtW5Eq5kCwfiyHlXIvz8D2xn8LK/CZsPTUIDNCKU/hQKy4Xxt4BCe/O
         Jc9hfTLQgMaBs4YqziLE/lseZnyWezoGHos5AgHIVc9npN3BCY/INvM/yMAyzRgDC6nk
         zTjA==
X-Forwarded-Encrypted: i=1; AJvYcCXR90XBbXItcFqwMWEVbasn3lilUo6gpajywtirkj2jEr3Qw15i3/+eSyu4+yiIGH5LR57yAfFp4KZUV/c5@vger.kernel.org, AJvYcCXYH0VGLkqxtsZjQ98yhYSVOnsiEN8TrcIhShJ7B+kmYD4XTiRROQ/d9l1bob5G05pKKphPNSzqBuIUfJb/@vger.kernel.org
X-Gm-Message-State: AOJu0Yyipw8lB2rilPvdMROJnGgoOk0UBCuTHkUFEbPiZPnyX3ZFkALu
	zl6eAmDDd8wigwZhjQx6oqREt5Dhl0E/uS9Ha7kMfZfqaEOdRrLY30xq7URgzy2xaI1SEus25UV
	og6UqoilTtvYSZPr7XCchlTMcf7aKM6bXOHo8kZzdI1c=
X-Gm-Gg: ASbGncurfSRsfi+WPt9JAkuj35YoVa8cmwX5PA+xc/DAes1oOgaZxZfuYN+dtwkYRaA
	KOSA7ZcNzJsZSd/I22Hw5zMG5jEoES0g/1R1v0aFzGl6hYYYw65el9lbR0prlNtVXk085wP/2vd
	eDy4LaodzeKHB4if9OUJVdpWHc0923VZR8SC6e2CU=
X-Google-Smtp-Source: AGHT+IHoSUeAPlBLGV9BvARB2DD4S5ZyaQrQObowA6idaD/1jh0KU0IzXBy11xH1xWIDoU/m5TY9IPIpNq/IxwsCPT0=
X-Received: by 2002:a05:6871:22cb:b0:2b8:306f:c5b5 with SMTP id
 586e51a60fabf-2cd32e21919mr5284274fac.7.1744036456603; Mon, 07 Apr 2025
 07:34:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABXGCsPXitW-5USFdP4fTGt5vh5J8MRZV+8J873tn7NYXU61wQ@mail.gmail.com>
 <20250407-unmodern-abkam-ce0395573fc2@brauner>
In-Reply-To: <20250407-unmodern-abkam-ce0395573fc2@brauner>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 7 Apr 2025 19:34:04 +0500
X-Gm-Features: ATxdqUHwaNprJBZd_SsiuQ3oNZG7V6WOmgD8MjTowTBc0TIjBrydrP4HByYiD4Q
Message-ID: <CABXGCsNk2ycAKBtOG6fum016sa_-O9kD04betBVyiUTWwuBqsQ@mail.gmail.com>
Subject: Re: 6.15-rc1/regression/bisected - commit 474f7825d533 is broke
 systemd-nspawn on my system
To: Christian Brauner <brauner@kernel.org>
Cc: sforshee@kernel.org, linux-fsdevel@vger.kernel.org, 
	Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, 
	Linux regressions mailing list <regressions@lists.linux.dev>, lennart@poettering.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 7, 2025 at 7:15=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> I'm a bit confused by your git bisect log and the dmesg output you're
> showing. The dmesg output suggests you did actually test on:
>
> [    0.000000] Linux version 6.15.0-rc1 (mikhail@primary-ws) (gcc (GCC) 1=
4.2.1 20241104 (Red Hat 14.2.1-6), GNU ld version 2.44-3.fc43) #4 SMP PREEM=
PT_DYNAMIC Mon Apr  7 10:58:22 +05 2025
>
> But your git bisect starts at 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
> according to:
>
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95] Merge tag 'net-next-6.1=
5' of git://git.kernel.
> git bisect bad 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
>
> Which is way before -rc1. Where you testing on actual v6.15-rc1 released
> yesterday or were you testing on
> 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95? If the latter, please test
> actual v6.15-rc1 as I suspect this is caused by faulty locking in
> clone_private_mount() which I fixed.

I don't want to upset you.
But I checked bisect between 1a9239bb4253 and b3ee1e460951 commits,
but the final test was made at 6.15-rc1 (0af2f6be1b42) before posting
the bug report here.
It's clear from the attached full log that systemd-nspawn hangs and
continues to hang, and the issue is not fixed at 6.15-rc1
(0af2f6be1b42).

--=20
Best Regards,
Mike Gavrilov.

On Mon, Apr 7, 2025 at 7:15=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> On Mon, Apr 07, 2025 at 12:14:01PM +0500, Mikhail Gavrilov wrote:
> > Hi,
> > I use Fedora. On Fedora systemd-nspawn is used for creating a clean
> > build environment for packaging.
> > I noted that on fresh kernels I can't build packages any more because
> > the command "mock -r fedora-rawhide-i386 --rebuild" is stuck.
> > I started debugging and found that systemd-nspawn was hanging.
> > Sending SysRq for  displaying list of blocked (D state) tasks gave me
> > this trace:
> > [  743.382717] sysrq: Show Blocked State
> > [  743.383154] task:systemd-nspawn  state:D stack:27120 pid:4609
> > tgid:4609  ppid:4435   task_flags:0x400140 flags:0x00000002
> > [  743.383164] Call Trace:
> > [  743.383167]  <TASK>
> > [  743.383171]  __schedule+0x895/0x1bf0
> > [  743.383178]  ? __pfx___schedule+0x10/0x10
> > [  743.383182]  ? __pfx_do_raw_spin_trylock+0x10/0x10
> > [  743.383187]  ? __raw_spin_unlock_irqrestore+0x5d/0x80
> > [  743.383191]  ? rcu_is_watching+0x12/0xc0
> > [  743.383195]  ? schedule+0x1d5/0x260
> > [  743.383199]  schedule+0xd4/0x260
> > [  743.383202]  fuse_get_req+0x92d/0x1060 [fuse]
> > [  743.383218]  ? rcu_is_watching+0x12/0xc0
> > [  743.383222]  ? __pfx_fuse_get_req+0x10/0x10 [fuse]
> > [  743.383233]  ? rcu_is_watching+0x12/0xc0
> > [  743.383236]  ? __pfx_autoremove_wake_function+0x10/0x10
> > [  743.383240]  ? rcu_is_watching+0x12/0xc0
> > [  743.383243]  ? is_bpf_text_address+0x64/0x100
> > [  743.383247]  ? __pfx_stack_trace_consume_entry+0x10/0x10
> > [  743.383252]  __fuse_simple_request+0x8f/0xab0 [fuse]
> > [  743.383263]  ? kernel_text_address+0x145/0x160
> > [  743.383268]  ? __kernel_text_address+0x12/0x40
> > [  743.383272]  fuse_getxattr+0x2cd/0x3e0 [fuse]
> > [  743.383287]  ? __pfx_fuse_getxattr+0x10/0x10 [fuse]
> > [  743.383299]  ? rcu_is_watching+0x12/0xc0
> > [  743.383304]  ? rcu_is_watching+0x12/0xc0
> > [  743.383307]  ? is_bpf_text_address+0x64/0x100
> > [  743.383310]  ? lock_release+0xb7/0xf0
> > [  743.383314]  ? is_bpf_text_address+0x6e/0x100
> > [  743.383318]  ? kernel_text_address+0x145/0x160
> > [  743.383323]  fuse_xattr_get+0x64/0x90 [fuse]
> > [  743.383333]  __vfs_getxattr+0xf0/0x150
> > [  743.383338]  ? __pfx___vfs_getxattr+0x10/0x10
> > [  743.383344]  get_vfs_caps_from_disk+0x138/0x450
> > [  743.383349]  ? __pfx_get_vfs_caps_from_disk+0x10/0x10
> > [  743.383353]  ? rcu_is_watching+0x12/0xc0
> > [  743.383356]  ? handle_path+0x27c/0x6b0
> > [  743.383360]  ? lock_release+0xb7/0xf0
> > [  743.383363]  ? handle_path+0x281/0x6b0
> > [  743.383368]  audit_copy_inode+0x339/0x4f0
> > [  743.383372]  ? __pfx_audit_copy_inode+0x10/0x10
> > [  743.383376]  ? path_lookupat+0x16a/0x670
> > [  743.383381]  filename_lookup+0x391/0x550
> > [  743.383386]  ? __pfx_filename_lookup+0x10/0x10
> > [  743.383394]  ? audit_alloc_name+0x398/0x490
> > [  743.383398]  ? __audit_getname+0x10b/0x160
> > [  743.383402]  ? getname_flags.part.0+0x1a5/0x510
> > [  743.383406]  user_path_at+0x9e/0xe0
> > [  743.383411]  __x64_sys_mount_setattr+0x247/0x340
> > [  743.383415]  ? __pfx___x64_sys_mount_setattr+0x10/0x10
> > [  743.383418]  ? seqcount_lockdep_reader_access.constprop.0+0xa5/0xb0
> > [  743.383422]  ? seqcount_lockdep_reader_access.constprop.0+0xa5/0xb0
> > [  743.383426]  ? ktime_get_coarse_real_ts64+0x41/0xd0
> > [  743.383431]  do_syscall_64+0x97/0x190
> > [  743.383437]  ? rcu_is_watching+0x12/0xc0
> > [  743.383440]  ? rcu_read_unlock+0x17/0x60
> > [  743.383444]  ? lock_release+0xb7/0xf0
> > [  743.383448]  ? handle_mm_fault+0x4e5/0xa60
> > [  743.383451]  ? exc_page_fault+0x7e/0x110
> > [  743.383456]  ? rcu_is_watching+0x12/0xc0
> > [  743.383458]  ? exc_page_fault+0x7e/0x110
> > [  743.383462]  ? do_user_addr_fault+0x8cb/0xe70
> > [  743.383466]  ? irqentry_exit_to_user_mode+0xa2/0x290
> > [  743.383469]  ? rcu_is_watching+0x12/0xc0
> > [  743.383472]  ? irqentry_exit_to_user_mode+0xa2/0x290
> > [  743.383475]  ? trace_hardirqs_on_prepare+0xdf/0x120
> > [  743.383480]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
> > [  743.383483] RIP: 0033:0x7fac4ff0419e
> > [  743.383499] RSP: 002b:00007ffc843092f8 EFLAGS: 00000246 ORIG_RAX:
> > 00000000000001ba
> > [  743.383504] RAX: ffffffffffffffda RBX: 000000000000000b RCX: 00007fa=
c4ff0419e
> > [  743.383507] RDX: 0000000000009000 RSI: 00007fac503472a8 RDI: 0000000=
00000000b
> > [  743.383509] RBP: 00007ffc843093a0 R08: 0000000000000020 R09: 00007fa=
c4fff6ac0
> > [  743.383512] R10: 00007ffc84309340 R11: 0000000000000246 R12: 0000000=
000000009
> > [  743.383514] R13: 000056069822b629 R14: 000056069822b635 R15: 0000000=
000000007
> > [  743.383519]  </TASK>
> >
> > > sudo /usr/bin/systemd-nspawn -q --ephemeral -D /var/lib/mock/fedora-r=
awhide-x86_64/root
> > [sudo] password for mikhail:
> > ^CShort read while reading whether to enable FUSE.
> > mikhail@primary-ws ~ [1]>
> >
> > And started bisecting the issue and the first bad commit is
> > 474f7825d5335798742b92f067e1d22365013107.
> >
> > Author: Christian Brauner <brauner@kernel.org>
> > Date:   Tue Jan 28 11:33:40 2025 +0100
> >
> >     fs: add copy_mount_setattr() helper
> >
> >     Split out copy_mount_setattr() from mount_setattr() so we can use i=
t in
> >     later patches.
> >
> >     Link: https://lore.kernel.org/r/20250128-work-mnt_idmap-update-v2-v=
1-2-c25feb0d2eb3@kernel.org
> >     Reviewed-by: "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>
> >     Signed-off-by: Christian Brauner <brauner@kernel.org>
> >
> > Unfortunately I can't test the revert of this commit because of conflic=
ts.
> >
> > > git revert -n 474f7825d5335798742b92f067e1d22365013107
> > Auto-merging fs/namespace.c
> > CONFLICT (content): Merge conflict in fs/namespace.c
> > error: could not revert 474f7825d533... fs: add copy_mount_setattr() he=
lper
> > hint: after resolving the conflicts, mark the corrected paths
> > hint: with 'git add <paths>' or 'git rm <paths>'
> > hint: Disable this message with "git config set advice.mergeConflict fa=
lse"
> >
> > My machine spec: https://linux-hardware.org/?probe=3D619658e7cf
> > And I attached below my build config and full kernel log.
> >
> > Christian, can you look please?
>
> I'm a bit confused by your git bisect log and the dmesg output you're
> showing. The dmesg output suggests you did actually test on:
>
> [    0.000000] Linux version 6.15.0-rc1 (mikhail@primary-ws) (gcc (GCC) 1=
4.2.1 20241104 (Red Hat 14.2.1-6), GNU ld version 2.44-3.fc43) #4 SMP PREEM=
PT_DYNAMIC Mon Apr  7 10:58:22 +05 2025
>
> But your git bisect starts at 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
> according to:
>
> git bisect start
> # status: waiting for both good and bad commits
> # bad: [1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95] Merge tag 'net-next-6.1=
5' of git://git.kernel.
> git bisect bad 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95
>
> Which is way before -rc1. Where you testing on actual v6.15-rc1 released
> yesterday or were you testing on
> 1a9239bb4253f9076b5b4b2a1a4e8d7defd77a95? If the latter, please test
> actual v6.15-rc1 as I suspect this is caused by faulty locking in
> clone_private_mount() which I fixed.



--=20
Best Regards,
Mike Gavrilov.


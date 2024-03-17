Return-Path: <linux-fsdevel+bounces-14565-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF48D87DD40
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 14:06:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AE651C209F3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 17 Mar 2024 13:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 469AF1BC39;
	Sun, 17 Mar 2024 13:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO4Rg3Wl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D1171A4;
	Sun, 17 Mar 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710680766; cv=none; b=MAsJmcuLWdAk6zaRx5nBq8QBsNkSZHQCKCmRdUxR3CdkHp8vtQgYK5kElCCIB1MoUaehFKJtcIVPjkVVAEemD2EP+6z+pIfJscoz12aItoxieZ0njpnYJE4qzJWYIe1B0CqkliSsPNkw2d/XCr3dn9Tde06TfsA53SmQnoUzbJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710680766; c=relaxed/simple;
	bh=PORDvklZEkq6kUgsl6Md6PVWPRt9MNeIUs1P3Yq4va0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JVuj+twJaWHF3PvuS9MzsnegzYkbdGn+Bi2BFVc41g5gEA5meCfUVWw8OgCQNpJWLsBB5p/j6n4gFwgdq+e4umiFOSHWzQ2yCsZ6bvRPfamczNXcFR1TDkLvsHoL/2KpuUXsnqTeiXOpZNMXKWEqVK2gLziYxcilcEUlo4nzTX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RO4Rg3Wl; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-690db6edb2bso21738136d6.2;
        Sun, 17 Mar 2024 06:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710680764; x=1711285564; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rx+lfrWpdu3oUBbAObNn2+Hup8mz4nmDLsswb+AlZvA=;
        b=RO4Rg3WllaLWEs5AH2p4AO5G7g+41KxI47dqlWHU5bf7WQH/RyGmej44j5ADVwIr4t
         ET4sDRjlOMFvfB58CUJu6Uukkvmforqp+Jia8BmI2ziWa5Ych2r239bz/Spfk7b08APV
         UJg+SkUJVhq6sHuPuQRguH3Q0mXeIoBTVxHHO2ID3AHQVNKCISeuJfpJHDr41QDVQLzo
         vuf+Ue4VKx5mtba13avke3aPktpI/Vs7tbMDtqlCvc1qVmDpLj6rx4DFfhAxkM1DB8qC
         R5W4V2LODqE5UDqPlK9n5Z2hAgQSMddg54TU8chel3zXrEBEjlTnX4+77fVMigcJVkV2
         YxEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710680764; x=1711285564;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rx+lfrWpdu3oUBbAObNn2+Hup8mz4nmDLsswb+AlZvA=;
        b=TmpleyipLzzlE0N1B+QXSl+QaLuRFZyT+EU9EDvG/iLgaNo8r7AT994T39Ith02Ar8
         VkqKnIYbSxJhmvetWMeOw8Z4gXoNQchNWWT7eeDPvekoKeO0ZQ1DEnBzQBOJ4BuqBR0D
         ay0xqhm0bUpT260vcVEkQ1nL+8aSkT1tkTDV5bJNn3vlzEOzWRv5fdaTNA+iphMheLiA
         /zet/5tT+7Sbow1+XSUh+7xjgLv7fryur0RdOpcE6elg6SztItl0V34U2F2LtRZa6jrB
         S6zgmgGC0NoWovDGzk2P42mg1r4dLZyyvjDG94Nn1TzCVyQhonfqW5s6GHaki5iz6sCF
         Z0Hg==
X-Forwarded-Encrypted: i=1; AJvYcCUuv25a3K2pTTglkNgn1divnqOGYakZNtGucXF8HGopkja7K7bpfdV3qF/YqLBccQ4uZLcwCZ670cSzgw5G9kQ0bHxshadH+deKnUdrmlLsvI3M4hcSRu4xwdKybSYnRPG3efzMXZxkBiYRUA==
X-Gm-Message-State: AOJu0Yy3mdKyaSnPLL1yN4wBIVZuU1C2zA7WZdVV6uEPpDXC4moxwxHc
	ZTPuPirqi19Wo/ODh67E8LTc2ofzjAEVv1LtF2hwDZS8eQoi8H9WxX7u6vZZaNa6SbBx8FKmuek
	g2YflnAd107NrmxfPaBJErr7ofjKG01P7Vp4=
X-Google-Smtp-Source: AGHT+IGaL+wGRodFHmMm/uvoTR3HPBVYArPkWKhfAThZxQdtznc1U4pAvNx83AF2e/FScFISeEQdPGKCCqUlJjneePM=
X-Received: by 2002:a0c:e283:0:b0:690:d98e:e70f with SMTP id
 r3-20020a0ce283000000b00690d98ee70fmr10330499qvl.31.1710680763951; Sun, 17
 Mar 2024 06:06:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <00000000000043c5e70613882ad1@google.com>
In-Reply-To: <00000000000043c5e70613882ad1@google.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Sun, 17 Mar 2024 15:05:52 +0200
Message-ID: <CAOQ4uxjdGyN84GV7rA3FTWYzvSTTY6+bza2PvHn2mNpHTPfxFA@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] WARNING in ovl_copy_up_file
To: syzbot <syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, miklos@szeredi.hu, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:23=E2=80=AFPM syzbot
<syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-trackin=
g..
> git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux=
.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1785a85918000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcaeac3f3565b0=
57a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3abd99031b42acf=
367ef
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1115ada6180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1626870a18000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/dis=
k-707081b6.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinu=
x-707081b6.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/I=
mage-707081b6.gz.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3abd99031b42acf367ef@syzkaller.appspotmail.com
>

#syz test: https://github.com/amir73il/linux ovl-fixes

Thanks,
Amir.

> evm: overlay not supported
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6187 at fs/overlayfs/copy_up.c:239 ovl_copy_up_file+=
0x624/0x674 fs/overlayfs/copy_up.c:330
> Modules linked in:
> CPU: 0 PID: 6187 Comm: syz-executor136 Not tainted 6.8.0-rc7-syzkaller-g7=
07081b61156 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 01/25/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : ovl_copy_up_file+0x624/0x674 fs/overlayfs/copy_up.c:330
> lr : ovl_verify_area fs/overlayfs/copy_up.c:239 [inline]
> lr : ovl_copy_up_file+0x620/0x674 fs/overlayfs/copy_up.c:330
> sp : ffff800097997180
> x29: ffff800097997280 x28: 00000000fffffffb x27: ffff700012f32e3c
> x26: 0000000000800000 x25: 0000000000800000 x24: ffff800097997240
> x23: ffff800097997220 x22: ffffffffffa64000 x21: ffffffffffa64000
> x20: ffff0000d9fc1900 x19: dfff800000000000 x18: 1ffff00012f32dee
> x17: ffff80008ec9d000 x16: ffff80008ad6b1c0 x15: 0000000000000001
> x14: 1fffe0001b9177f2 x13: 0000000000000000 x12: 0000000000000000
> x11: 0000000000000001 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d7568000 x7 : ffff80008108d924 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff80008031a200
> x2 : 00000ffffffff000 x1 : ffffffffffa64000 x0 : ffffffffffffffff
> Call trace:
>  ovl_copy_up_file+0x624/0x674 fs/overlayfs/copy_up.c:330
>  ovl_copy_up_tmpfile fs/overlayfs/copy_up.c:863 [inline]
>  ovl_do_copy_up fs/overlayfs/copy_up.c:976 [inline]
>  ovl_copy_up_one fs/overlayfs/copy_up.c:1168 [inline]
>  ovl_copy_up_flags+0x16d0/0x3694 fs/overlayfs/copy_up.c:1223
>  ovl_copy_up+0x24/0x34 fs/overlayfs/copy_up.c:1263
>  ovl_setattr+0xfc/0x4e4 fs/overlayfs/inode.c:41
>  notify_change+0x9d4/0xc8c fs/attr.c:499
>  chmod_common+0x23c/0x418 fs/open.c:648
>  do_fchmodat fs/open.c:696 [inline]
>  __do_sys_fchmodat fs/open.c:715 [inline]
>  __se_sys_fchmodat fs/open.c:712 [inline]
>  __arm64_sys_fchmodat+0x118/0x1dc fs/open.c:712
>  __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
>  el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
>  el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
> irq event stamp: 862
> hardirqs last  enabled at (861): [<ffff8000831abcb4>] percpu_counter_add_=
batch+0x210/0x30c lib/percpu_counter.c:102
> hardirqs last disabled at (862): [<ffff80008ad66988>] el1_dbg+0x24/0x80 a=
rch/arm64/kernel/entry-common.c:470
> softirqs last  enabled at (62): [<ffff80008002189c>] softirq_handle_end k=
ernel/softirq.c:399 [inline]
> softirqs last  enabled at (62): [<ffff80008002189c>] __do_softirq+0xac8/0=
xce4 kernel/softirq.c:582
> softirqs last disabled at (53): [<ffff80008002ab48>] ____do_softirq+0x14/=
0x20 arch/arm64/kernel/irq.c:81
> ---[ end trace 0000000000000000 ]---
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
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
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


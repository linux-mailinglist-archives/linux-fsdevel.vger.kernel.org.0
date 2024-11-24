Return-Path: <linux-fsdevel+bounces-35720-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D659D77C4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 20:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65AA92817FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 19:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17309149E00;
	Sun, 24 Nov 2024 19:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IR71H55f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992672F26;
	Sun, 24 Nov 2024 19:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732475638; cv=none; b=onXciEyvrBv4ICHcY3Gk7zqgJzWDj7xrQ6/TJRd2isP9VhFvjOpXSGxFNDuFtpMxul1oJssM4+JFfOlMamLPLXHs3t5qp8kWG6Aq3JBx7IRqbC2TQ271CCydHn1xinZ7nCyY4xckknQxxS/2PMcZZlUcZ1X28jfQNv1R/cH6WX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732475638; c=relaxed/simple;
	bh=qbWW84vipAIpdjuMHGybyR6BmjEHuQrInzn2Q3iz5XY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Brthr509JVsjArE8NFlmCBgzhWHq9/XgveNAzzFNNU+cGgc1gUv/g5vm9iOL3kUG4c1d+9NBFUMsQKW9ygQeuxkpSLpkv6Bi8YprY1/B8Sq6n60SPMaPjsN3JGZWhDs6roSui/BoiigMcUJ7dADZu8S3GwtODMgM4Y0WHoshdgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IR71H55f; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ceca0ec4e7so4615818a12.0;
        Sun, 24 Nov 2024 11:13:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732475630; x=1733080430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zcmh9AtX+ZzMDVuijubZlBMt8MnAP4EMK1Qh6l3LJcQ=;
        b=IR71H55fgvDh54o+qcsZkxSRcGl/mtrdSHvPx8MLPgGjDPMcqO/E7+rWf5z03vYS7l
         r+w361OAnQ7vNmX12Zl2Lwzivf8ci6sFKKTVnttNX6NNm+6OzCEmpL3YCWXSaEX9d7eR
         3xc/4b34UVijxDVAPGhg9WYhMO8FN+JdXlj+R+kpNfBdHiZCuf/3H8Ks7efLci9y+ONR
         oZ0qupjyos9Rddbb27a1upxPq01QkOC3TIZvtCQ1hvdibghlliRQayWV6uMneiGGR21s
         VdxCjfTPRXexGaM+WdAXGFmRgnsj2Km2rm3fiUZ4SlDqjL+3tVyabOHeAKV3+9LIVN4T
         ZQ+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732475630; x=1733080430;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zcmh9AtX+ZzMDVuijubZlBMt8MnAP4EMK1Qh6l3LJcQ=;
        b=Xr28pqcKftREkIqsAUiqIykHeVlt1vCjmtQx8s7XUV4eyWhcUgqdq1dje8IpB3YSbo
         yjekUsLed7J7AO9yKlO4ZH/ROTttn/vVCIREX6tQEfn8dkyZZVVdw1yk8QwMUN0MLZhU
         9tKJck25mgIoi/jUZcsQq9LUROvXAKghGpfgFjC9BVo+kiQ6Vky7IsLT59RYxKWy/90J
         XPB2Wl6RRW9MwO2dubO6zyn6io4BzINu0FHSwkp3l5e+6wjTJijId+rZNoQoDEI92KVd
         nG14emexCWRTUL8zdoxW0xKTyghlkf5Jj6f5ma9PQBfvmjI/rbQ7h6GeJehueGxzUll+
         6XSg==
X-Forwarded-Encrypted: i=1; AJvYcCX94NWKLxsoM25g8MyCP8X+Rs0R4xwJy2WilyNUcLR21HXPD/l1+taCTz67we3mg7LFtL5Zqyo9ibK4fD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8LEeGfJTfoMyUEhoazivhBxkfUxeQ7vLkf050CpuaZbOmPlcf
	kMzoyykQTT4DL8WMCQz26b4T/hjYVZg333RcNmE23orYryaNqxNjYol++G/eIQSxj185fhe1AOW
	QP0AiRO9lOWn5LO9ZrqjUsv5VjvZYWw==
X-Gm-Gg: ASbGnctf/XLESZz7OXSJo8XRMn0DCGApcnqEt18UuVIAbtXw5baznUEE/nUb6yOY8D9
	dcf7i1GQ5cNPjaj0qBa46OqEVfw7YxNgCwiugqLWDRIXKFw8uOqVzzpTILEyxXB5yAw==
X-Google-Smtp-Source: AGHT+IGCF1OYZQHP/GAYy5UK6wYOk4SgoVScCRPYiQugmUOStAE3+qkB6i1GpmmcQS5zpM2F8yYFspgpwM/6hEQK2C4=
X-Received: by 2002:a05:6402:4010:b0:5cf:c97c:821d with SMTP id
 4fb4d7f45d1cf-5d01ffd8a65mr10397699a12.0.1732475629210; Sun, 24 Nov 2024
 11:13:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6740d107.050a0220.3c9d61.0195.GAE@google.com>
In-Reply-To: <6740d107.050a0220.3c9d61.0195.GAE@google.com>
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Mon, 25 Nov 2024 00:43:11 +0530
Message-ID: <CAHiZj8jbd9SQwKj6mvDQ3Kgi2z8rrCCwsqgjOgFtCzsk5MVPzQ@mail.gmail.com>
Subject: Re: [syzbot] [fs?] WARNING in minix_unlink
To: syzbot <syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="0000000000007677050627ad6ae9"

--0000000000007677050627ad6ae9
Content-Type: multipart/alternative; boundary="0000000000007677040627ad6ae7"

--0000000000007677040627ad6ae7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Sat, Nov 23, 2024 at 12:14=E2=80=AFAM syzbot <
syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    7b1d1d4cfac0 Merge remote-tracking branch
> 'iommu/arm/smmu'..
> git tree:       git://
> git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D16a3cb7858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Ddfe1e340fbee3=
d16
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D320c57a47bdabc1f294b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> Debian) 2.40
> userspace arch: arm64
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11d31930580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D129b76c058000=
0
>
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/354fe38e2935/disk-7b1d1d4c.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/f12e0b1ef3fd/vmlinux-7b1d1d4=
c.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/291dbc519bb3/Image-7b1d1d4c.=
gz.xz
> mounted in repro:
> https://storage.googleapis.com/syzbot-assets/54e0ad660b2f/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com
>
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Not tainted
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b6433b9
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bac135e x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd609af0 x19: ffff0000dd609aa8 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86ed5e6 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86ed5e7 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 14240
> hardirqs last  enabled at (14239): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (14239): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (14240): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (13948): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (13948): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (13941): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b66a6ce
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001babf963 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd5fcb18 x19: ffff0000dd5fcad0 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86e55de x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86e55df x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 18414
> hardirqs last  enabled at (18413): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (18413): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (18414): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (18126): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (18126): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (18107): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b683270
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bae2163 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd710b18 x19: ffff0000dd710ad0 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86deaf6 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86deaf7 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 22134
> hardirqs last  enabled at (22133): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (22133): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (22134): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (21124): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (21122): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b6a6a9f
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001babfd59 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd5feac8 x19: ffff0000dd5fea80 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8ab2fe6 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8ab2fe7 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 25870
> hardirqs last  enabled at (25869): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (25869): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (25870): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (25760): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (25758): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019b8c9b4
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bae2559 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd712ac8 x19: ffff0000dd712a80 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8ab2086 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8ab2087 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 29568
> hardirqs last  enabled at (29567): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (29567): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (29568): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (29364): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (29362): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b6a9585
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001babff54 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd5ffaa0 x19: ffff0000dd5ffa58 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8ab2fe6 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8ab2fe7 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 34332
> hardirqs last  enabled at (34331): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (34331): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (34332): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (34044): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (34044): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (34025): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b68475b
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bad035e x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd681af0 x19: ffff0000dd681aa8 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86f389e x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86f389f x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 38582
> hardirqs last  enabled at (38581): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (38581): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (38582): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (38300): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (38300): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (38263): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b3fcafd
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bad0754 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd683aa0 x19: ffff0000dd683a58 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8d8c7be x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8d8c7bf x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 42828
> hardirqs last  enabled at (42827): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (42827): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (42828): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (42544): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (42544): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (42535): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019b98a12
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001badf163 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd6f8b18 x19: ffff0000dd6f8ad0 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86f4d76 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86f4d77 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 46512
> hardirqs last  enabled at (46511): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (46511): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (46512): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (46264): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (46264): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (46255): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019b980c9
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001badf35e x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd6f9af0 x19: ffff0000dd6f9aa8 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8707326 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8707327 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 50766
> hardirqs last  enabled at (50765): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (50765): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (50766): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (50100): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (50098): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b699b8a
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001baced59 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd676ac8 x19: ffff0000dd676a80 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8707326 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8707327 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 54686
> hardirqs last  enabled at (54685): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (54685): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (54686): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (54570): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (54568): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b686b8a
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bad5963 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd6acb18 x19: ffff0000dd6acad0 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86ec2de x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86ec2df x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 58854
> hardirqs last  enabled at (58853): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (58853): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (58854): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (58796): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (58796): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (58787): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b69f7b9
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bad5d59 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd6aeac8 x19: ffff0000dd6aea80 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86eedfe x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86eedff x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 63018
> hardirqs last  enabled at (63017): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (63017): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (63018): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (62716): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (62716): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (62691): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b66ac6b
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bacb963 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd65cb18 x19: ffff0000dd65cad0 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86de36e x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86de36f x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 67566
> hardirqs last  enabled at (67565): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (67565): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (67566): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (67266): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (67266): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (67251): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b637241
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bad4963 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd6a4b18 x19: ffff0000dd6a4ad0 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8708cb6 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8708cb7 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 71272
> hardirqs last  enabled at (71271): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (71271): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (71272): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (70252): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (70250): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b5a4a70
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bacbb5e x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd65daf0 x19: ffff0000dd65daa8 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86f4d76 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86f4d77 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 75078
> hardirqs last  enabled at (75077): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (75077): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (75078): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (74954): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (74952): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b690e9f
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001bad4d59 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd6a6ac8 x19: ffff0000dd6a6a80 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8708cae x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8708caf x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 78816
> hardirqs last  enabled at (78815): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (78815): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (78816): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (78694): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (78694): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (78685): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019bd9d56
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001baea963 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd754b18 x19: ffff0000dd754ad0 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86de36e x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86de36f x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 82554
> hardirqs last  enabled at (82553): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (82553): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (82554): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (82488): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (82486): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b680b5b
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001baead59 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd756ac8 x19: ffff0000dd756a80 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff870675e x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff870675f x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 86326
> hardirqs last  enabled at (86325): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (86325): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (86326): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (86260): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (86260): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (86239): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019bd840d
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001baeaf54 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd757aa0 x19: ffff0000dd757a58 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8ab3946 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8ab3947 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 90150
> hardirqs last  enabled at (90149): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (90149): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (90150): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (90030): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (90028): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001badd270
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001baee163 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd770b18 x19: ffff0000dd770ad0 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86f54ce x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86f54cf x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 94386
> hardirqs last  enabled at (94385): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (94385): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (94386): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (94268): [<ffff80008002f3d8>]
> local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
> softirqs last disabled at (94266): [<ffff80008002f3a4>]
> local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b67fcc9
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001baedb5e x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd76daf0 x19: ffff0000dd76daa8 x18: 1fffe000366c6876
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff8ab3946 x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff8ab3947 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 98122
> hardirqs last  enabled at (98121): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inline]
> hardirqs last  enabled at (98121): [<ffff8000802c423c>]
> finish_lock_switch+0xbc/0x1e4 kernel/sched/core.c:5082
> hardirqs last disabled at (98122): [<ffff80008b4b302c>] el1_dbg+0x24/0x80
> arch/arm64/kernel/entry-common.c:488
> softirqs last  enabled at (98074): [<ffff80008020396c>] softirq_handle_en=
d
> kernel/softirq.c:400 [inline]
> softirqs last  enabled at (98074): [<ffff80008020396c>]
> handle_softirqs+0xa38/0xbf8 kernel/softirq.c:582
> softirqs last disabled at (98053): [<ffff800080020db4>]
> __do_softirq+0x14/0x20 kernel/softirq.c:588
> ---[ end trace 0000000000000000 ]---
> minix_free_block (loop0:20): bit already cleared
> minix_free_block (loop0:21): bit already cleared
> minix_free_block (loop0:19): bit already cleared
> minix_free_block (loop0:22): bit already cleared
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138
> fs/inode.c:336
> Modules linked in:
> CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G        W
> 6.12.0-syzkaller-g7b1d1d4cfac0 #0
> Tainted: [W]=3DWARN
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> pc : drop_nlink+0xe4/0x138 fs/inode.c:336
> lr : drop_nlink+0xe4/0x138 fs/inode.c:336
> sp : ffff8000a3857a60
> x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b5e189a
> x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003
> x23: 1fffe0001baedf54 x22: dfff800000000000 x21: 0000000000000000
> x20: ffff0000dd76faa0 x19: ffff0000dd76fa58 x18: 1fffe000366cb076
> x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001
> x14: 1fffffbff86f4c7e x13: 0000000000000000 x12: 0000000000000000
> x11: ffff7fbff86f4c7f x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000
> x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4
> x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000
> Call trace:
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (P)
>  drop_nlink+0xe4/0x138 fs/inode.c:336 (L)
>  inode_dec_link_count include/linux/fs.h:2510 [inline]
>  minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157
>  vfs_unlink+0x2f0/0x534 fs/namei.c:4469
>  do_unlinkat+0x4d0/0x700 fs/namei.c:4533
>  __do_sys_unlinkat fs/namei.c:4576 [inline]
>  __se_sys_unlinkat fs/namei.c:4569 [inline]
>  __arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569
>  __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
>  invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
>  el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
>  do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
>  el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744
>  el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762
>  el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600
> irq event stamp: 101832
> hardirqs last  enabled at (101831): [<ffff8000802c423c>]
> raw_spin_rq_unlock_irq kernel/sched/sched.h:1518 [inl
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion visit
> https://groups.google.com/d/msgid/syzkaller-bugs/6740d107.050a0220.3c9d61=
.0195.GAE%40google.com
> .
>

--0000000000007677040627ad6ae7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">#syz test<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Nov 23, 2024 at 12:14=E2=80=AFAM syzb=
ot &lt;<a href=3D"mailto:syzbot%2B320c57a47bdabc1f294b@syzkaller.appspotmai=
l.com">syzbot+320c57a47bdabc1f294b@syzkaller.appspotmail.com</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
syzbot found the following issue on:<br>
<br>
HEAD commit:=C2=A0 =C2=A0 7b1d1d4cfac0 Merge remote-tracking branch &#39;io=
mmu/arm/smmu&#39;..<br>
git tree:=C2=A0 =C2=A0 =C2=A0 =C2=A0git://<a href=3D"http://git.kernel.org/=
pub/scm/linux/kernel/git/arm64/linux.git" rel=3D"noreferrer" target=3D"_bla=
nk">git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git</a> for-kernelc=
i<br>
console output: <a href=3D"https://syzkaller.appspot.com/x/log.txt?x=3D16a3=
cb78580000" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.=
com/x/log.txt?x=3D16a3cb78580000</a><br>
kernel config:=C2=A0 <a href=3D"https://syzkaller.appspot.com/x/.config?x=
=3Ddfe1e340fbee3d16" rel=3D"noreferrer" target=3D"_blank">https://syzkaller=
.appspot.com/x/.config?x=3Ddfe1e340fbee3d16</a><br>
dashboard link: <a href=3D"https://syzkaller.appspot.com/bug?extid=3D320c57=
a47bdabc1f294b" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.apps=
pot.com/bug?extid=3D320c57a47bdabc1f294b</a><br>
compiler:=C2=A0 =C2=A0 =C2=A0 =C2=A0Debian clang version 15.0.6, GNU ld (GN=
U Binutils for Debian) 2.40<br>
userspace arch: arm64<br>
syz repro:=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://syzkaller.appspot.com/x/r=
epro.syz?x=3D11d31930580000" rel=3D"noreferrer" target=3D"_blank">https://s=
yzkaller.appspot.com/x/repro.syz?x=3D11d31930580000</a><br>
C reproducer:=C2=A0 =C2=A0<a href=3D"https://syzkaller.appspot.com/x/repro.=
c?x=3D129b76c0580000" rel=3D"noreferrer" target=3D"_blank">https://syzkalle=
r.appspot.com/x/repro.c?x=3D129b76c0580000</a><br>
<br>
Downloadable assets:<br>
disk image: <a href=3D"https://storage.googleapis.com/syzbot-assets/354fe38=
e2935/disk-7b1d1d4c.raw.xz" rel=3D"noreferrer" target=3D"_blank">https://st=
orage.googleapis.com/syzbot-assets/354fe38e2935/disk-7b1d1d4c.raw.xz</a><br=
>
vmlinux: <a href=3D"https://storage.googleapis.com/syzbot-assets/f12e0b1ef3=
fd/vmlinux-7b1d1d4c.xz" rel=3D"noreferrer" target=3D"_blank">https://storag=
e.googleapis.com/syzbot-assets/f12e0b1ef3fd/vmlinux-7b1d1d4c.xz</a><br>
kernel image: <a href=3D"https://storage.googleapis.com/syzbot-assets/291db=
c519bb3/Image-7b1d1d4c.gz.xz" rel=3D"noreferrer" target=3D"_blank">https://=
storage.googleapis.com/syzbot-assets/291dbc519bb3/Image-7b1d1d4c.gz.xz</a><=
br>
mounted in repro: <a href=3D"https://storage.googleapis.com/syzbot-assets/5=
4e0ad660b2f/mount_0.gz" rel=3D"noreferrer" target=3D"_blank">https://storag=
e.googleapis.com/syzbot-assets/54e0ad660b2f/mount_0.gz</a><br>
<br>
IMPORTANT: if you fix the issue, please add the following tag to the commit=
:<br>
Reported-by: <a href=3D"mailto:syzbot%2B320c57a47bdabc1f294b@syzkaller.apps=
potmail.com" target=3D"_blank">syzbot+320c57a47bdabc1f294b@syzkaller.appspo=
tmail.com</a><br>
<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Not tainted 6.12.0-syzkaller-=
g7b1d1d4cfac0 #0<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b6433b9<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bac135e x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd609af0 x19: ffff0000dd609aa8 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86ed5e6 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86ed5e7 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 14240<br>
hardirqs last=C2=A0 enabled at (14239): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (14239): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (14240): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (13948): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (13948): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (13941): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b66a6ce<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001babf963 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd5fcb18 x19: ffff0000dd5fcad0 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86e55de x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86e55df x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 18414<br>
hardirqs last=C2=A0 enabled at (18413): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (18413): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (18414): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (18126): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (18126): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (18107): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b683270<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bae2163 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd710b18 x19: ffff0000dd710ad0 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86deaf6 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86deaf7 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 22134<br>
hardirqs last=C2=A0 enabled at (22133): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (22133): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (22134): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (21124): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (21122): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b6a6a9f<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001babfd59 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd5feac8 x19: ffff0000dd5fea80 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8ab2fe6 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8ab2fe7 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 25870<br>
hardirqs last=C2=A0 enabled at (25869): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (25869): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (25870): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (25760): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (25758): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019b8c9b4<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bae2559 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd712ac8 x19: ffff0000dd712a80 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8ab2086 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8ab2087 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 29568<br>
hardirqs last=C2=A0 enabled at (29567): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (29567): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (29568): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (29364): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (29362): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b6a9585<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001babff54 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd5ffaa0 x19: ffff0000dd5ffa58 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8ab2fe6 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8ab2fe7 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 34332<br>
hardirqs last=C2=A0 enabled at (34331): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (34331): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (34332): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (34044): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (34044): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (34025): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b68475b<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bad035e x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd681af0 x19: ffff0000dd681aa8 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86f389e x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86f389f x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 38582<br>
hardirqs last=C2=A0 enabled at (38581): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (38581): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (38582): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (38300): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (38300): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (38263): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b3fcafd<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bad0754 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd683aa0 x19: ffff0000dd683a58 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8d8c7be x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8d8c7bf x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 42828<br>
hardirqs last=C2=A0 enabled at (42827): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (42827): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (42828): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (42544): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (42544): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (42535): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019b98a12<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001badf163 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd6f8b18 x19: ffff0000dd6f8ad0 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86f4d76 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86f4d77 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 46512<br>
hardirqs last=C2=A0 enabled at (46511): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (46511): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (46512): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (46264): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (46264): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (46255): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019b980c9<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001badf35e x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd6f9af0 x19: ffff0000dd6f9aa8 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8707326 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8707327 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 50766<br>
hardirqs last=C2=A0 enabled at (50765): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (50765): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (50766): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (50100): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (50098): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b699b8a<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001baced59 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd676ac8 x19: ffff0000dd676a80 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8707326 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8707327 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 54686<br>
hardirqs last=C2=A0 enabled at (54685): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (54685): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (54686): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (54570): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (54568): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b686b8a<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bad5963 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd6acb18 x19: ffff0000dd6acad0 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86ec2de x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86ec2df x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 58854<br>
hardirqs last=C2=A0 enabled at (58853): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (58853): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (58854): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (58796): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (58796): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (58787): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b69f7b9<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bad5d59 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd6aeac8 x19: ffff0000dd6aea80 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86eedfe x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86eedff x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 63018<br>
hardirqs last=C2=A0 enabled at (63017): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (63017): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (63018): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (62716): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (62716): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (62691): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b66ac6b<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bacb963 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd65cb18 x19: ffff0000dd65cad0 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86de36e x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86de36f x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 67566<br>
hardirqs last=C2=A0 enabled at (67565): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (67565): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (67566): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (67266): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (67266): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (67251): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b637241<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bad4963 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd6a4b18 x19: ffff0000dd6a4ad0 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8708cb6 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8708cb7 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 71272<br>
hardirqs last=C2=A0 enabled at (71271): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (71271): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (71272): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (70252): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (70250): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b5a4a70<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bacbb5e x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd65daf0 x19: ffff0000dd65daa8 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86f4d76 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86f4d77 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 75078<br>
hardirqs last=C2=A0 enabled at (75077): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (75077): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (75078): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (74954): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (74952): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b690e9f<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001bad4d59 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd6a6ac8 x19: ffff0000dd6a6a80 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8708cae x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8708caf x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 78816<br>
hardirqs last=C2=A0 enabled at (78815): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (78815): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (78816): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (78694): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (78694): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (78685): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019bd9d56<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001baea963 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd754b18 x19: ffff0000dd754ad0 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86de36e x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86de36f x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 82554<br>
hardirqs last=C2=A0 enabled at (82553): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (82553): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (82554): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (82488): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (82486): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b680b5b<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001baead59 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd756ac8 x19: ffff0000dd756a80 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff870675e x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff870675f x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 86326<br>
hardirqs last=C2=A0 enabled at (86325): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (86325): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (86326): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (86260): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (86260): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (86239): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe00019bd840d<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001baeaf54 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd757aa0 x19: ffff0000dd757a58 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8ab3946 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8ab3947 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 90150<br>
hardirqs last=C2=A0 enabled at (90149): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (90149): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (90150): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (90030): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (90028): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001badd270<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001baee163 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd770b18 x19: ffff0000dd770ad0 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86f54ce x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86f54cf x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 94386<br>
hardirqs last=C2=A0 enabled at (94385): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (94385): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (94386): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (94268): [&lt;ffff80008002f3d8&gt;] local_bh=
_enable+0x10/0x34 include/linux/bottom_half.h:32<br>
softirqs last disabled at (94266): [&lt;ffff80008002f3a4&gt;] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 0 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 0 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b67fcc9<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001baedb5e x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd76daf0 x19: ffff0000dd76daa8 x18: 1fffe000366c6876<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff8ab3946 x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff8ab3947 x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 98122<br>
hardirqs last=C2=A0 enabled at (98121): [&lt;ffff8000802c423c&gt;] raw_spin=
_rq_unlock_irq kernel/sched/sched.h:1518 [inline]<br>
hardirqs last=C2=A0 enabled at (98121): [&lt;ffff8000802c423c&gt;] finish_l=
ock_switch+0xbc/0x1e4 kernel/sched/core.c:5082<br>
hardirqs last disabled at (98122): [&lt;ffff80008b4b302c&gt;] el1_dbg+0x24/=
0x80 arch/arm64/kernel/entry-common.c:488<br>
softirqs last=C2=A0 enabled at (98074): [&lt;ffff80008020396c&gt;] softirq_=
handle_end kernel/softirq.c:400 [inline]<br>
softirqs last=C2=A0 enabled at (98074): [&lt;ffff80008020396c&gt;] handle_s=
oftirqs+0xa38/0xbf8 kernel/softirq.c:582<br>
softirqs last disabled at (98053): [&lt;ffff800080020db4&gt;] __do_softirq+=
0x14/0x20 kernel/softirq.c:588<br>
---[ end trace 0000000000000000 ]---<br>
minix_free_block (loop0:20): bit already cleared<br>
minix_free_block (loop0:21): bit already cleared<br>
minix_free_block (loop0:19): bit already cleared<br>
minix_free_block (loop0:22): bit already cleared<br>
------------[ cut here ]------------<br>
WARNING: CPU: 1 PID: 6420 at fs/inode.c:336 drop_nlink+0xe4/0x138 fs/inode.=
c:336<br>
Modules linked in:<br>
CPU: 1 UID: 0 PID: 6420 Comm: syz-executor256 Tainted: G=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 W=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 6.12.0-syzkaller-g7b1d1d4cfa=
c0 #0<br>
Tainted: [W]=3DWARN<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)<br>
pc : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
lr : drop_nlink+0xe4/0x138 fs/inode.c:336<br>
sp : ffff8000a3857a60<br>
x29: ffff8000a3857a60 x28: dfff800000000000 x27: 1fffe0001b5e189a<br>
x26: 1ffff0001470af54 x25: dfff800000000000 x24: 0000000000000003<br>
x23: 1fffe0001baedf54 x22: dfff800000000000 x21: 0000000000000000<br>
x20: ffff0000dd76faa0 x19: ffff0000dd76fa58 x18: 1fffe000366cb076<br>
x17: ffff80008f81d000 x16: ffff8000802a7fe0 x15: 0000000000000001<br>
x14: 1fffffbff86f4c7e x13: 0000000000000000 x12: 0000000000000000<br>
x11: ffff7fbff86f4c7f x10: 0000000000ff0100 x9 : 0000000000000000<br>
x8 : ffff0000d9638000 x7 : ffff800080c93b64 x6 : 0000000000000000<br>
x5 : 0000000000000000 x4 : 0000000000000001 x3 : ffff8000811989e4<br>
x2 : 0000000000000001 x1 : 0000000000000000 x0 : 0000000000000000<br>
Call trace:<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (P)<br>
=C2=A0drop_nlink+0xe4/0x138 fs/inode.c:336 (L)<br>
=C2=A0inode_dec_link_count include/linux/fs.h:2510 [inline]<br>
=C2=A0minix_unlink+0x1f8/0x2e8 fs/minix/namei.c:157<br>
=C2=A0vfs_unlink+0x2f0/0x534 fs/namei.c:4469<br>
=C2=A0do_unlinkat+0x4d0/0x700 fs/namei.c:4533<br>
=C2=A0__do_sys_unlinkat fs/namei.c:4576 [inline]<br>
=C2=A0__se_sys_unlinkat fs/namei.c:4569 [inline]<br>
=C2=A0__arm64_sys_unlinkat+0xc8/0xf8 fs/namei.c:4569<br>
=C2=A0__invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]<br>
=C2=A0invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49<br>
=C2=A0el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132<br>
=C2=A0do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151<br>
=C2=A0el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:744<br>
=C2=A0el0t_64_sync_handler+0x84/0x108 arch/arm64/kernel/entry-common.c:762<=
br>
=C2=A0el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:600<br>
irq event stamp: 101832<br>
hardirqs last=C2=A0 enabled at (101831): [&lt;ffff8000802c423c&gt;] raw_spi=
n_rq_unlock_irq kernel/sched/sched.h:1518 [inl<br>
<br>
---<br>
This report is generated by a bot. It may contain errors.<br>
See <a href=3D"https://goo.gl/tpsmEJ" rel=3D"noreferrer" target=3D"_blank">=
https://goo.gl/tpsmEJ</a> for more information about syzbot.<br>
syzbot engineers can be reached at <a href=3D"mailto:syzkaller@googlegroups=
.com" target=3D"_blank">syzkaller@googlegroups.com</a>.<br>
<br>
syzbot will keep track of this issue. See:<br>
<a href=3D"https://goo.gl/tpsmEJ#status" rel=3D"noreferrer" target=3D"_blan=
k">https://goo.gl/tpsmEJ#status</a> for how to communicate with syzbot.<br>
<br>
If the report is already addressed, let syzbot know by replying with:<br>
#syz fix: exact-commit-title<br>
<br>
If you want syzbot to run the reproducer, reply with:<br>
#syz test: git://repo/address.git branch-or-commit-hash<br>
If you attach or paste a git patch, syzbot will apply it before testing.<br=
>
<br>
If you want to overwrite report&#39;s subsystems, reply with:<br>
#syz set subsystems: new-subsystem<br>
(See the list of subsystem names on the web dashboard)<br>
<br>
If the report is a duplicate of another one, reply with:<br>
#syz dup: exact-subject-of-another-report<br>
<br>
If you want to undo deduplication, reply with:<br>
#syz undup<br>
<br>
-- <br>
You received this message because you are subscribed to the Google Groups &=
quot;syzkaller-bugs&quot; group.<br>
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to <a href=3D"mailto:syzkaller-bugs%2Bunsubscribe@googlegroups.com" ta=
rget=3D"_blank">syzkaller-bugs+unsubscribe@googlegroups.com</a>.<br>
To view this discussion visit <a href=3D"https://groups.google.com/d/msgid/=
syzkaller-bugs/6740d107.050a0220.3c9d61.0195.GAE%40google.com" rel=3D"noref=
errer" target=3D"_blank">https://groups.google.com/d/msgid/syzkaller-bugs/6=
740d107.050a0220.3c9d61.0195.GAE%40google.com</a>.<br>
</blockquote></div>

--0000000000007677040627ad6ae7--
--0000000000007677050627ad6ae9
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-fix-WARNING-in-minix_unlink.patch"
Content-Disposition: attachment; 
	filename="0001-fix-WARNING-in-minix_unlink.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m3vz8e2p0>
X-Attachment-Id: f_m3vz8e2p0

RnJvbSBmOTlkOGU5YzRjZDcxNGM1NjEyYjRhNjBjYjFhZTFhZmJiZWYxMjQ4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBTb25hd2FuZSA8c3VyYWpzb25hd2FuZTAyMTVAZ21h
aWwuY29tPgpEYXRlOiBNb24sIDI1IE5vdiAyMDI0IDAwOjM4OjQ3ICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gZml4IFdBUk5JTkcgaW4gbWluaXhfdW5saW5rCgpzeXogdGVzdAoKU2lnbmVkLW9mZi1i
eTogU3VyYWogU29uYXdhbmUgPHN1cmFqc29uYXdhbmUwMjE1QGdtYWlsLmNvbT4KLS0tCiBmcy9t
aW5peC9iaXRtYXAuYyB8IDggKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvbWluaXgvYml0bWFwLmMgYi9mcy9t
aW5peC9iaXRtYXAuYwppbmRleCA3ZGE2NmNhMTguLjE4YzZmZTU0NCAxMDA2NDQKLS0tIGEvZnMv
bWluaXgvYml0bWFwLmMKKysrIGIvZnMvbWluaXgvYml0bWFwLmMKQEAgLTYwLDExICs2MCwxNSBA
QCB2b2lkIG1pbml4X2ZyZWVfYmxvY2soc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgbG9u
ZyBibG9jaykKIAl9CiAJYmggPSBzYmktPnNfem1hcFt6b25lXTsKIAlzcGluX2xvY2soJmJpdG1h
cF9sb2NrKTsKLQlpZiAoIW1pbml4X3Rlc3RfYW5kX2NsZWFyX2JpdChiaXQsIGJoLT5iX2RhdGEp
KQorCWlmIChtaW5peF90ZXN0X2FuZF9jbGVhcl9iaXQoYml0LCBiaC0+Yl9kYXRhKSkgeworCQkv
KiBQcm9jZWVkIG9ubHkgaWYgdGhlIGJpdCB3YXMgc2V0ICovCisJCW1hcmtfYnVmZmVyX2RpcnR5
KGJoKTsKKwl9IGVsc2UgewogCQlwcmludGsoIm1pbml4X2ZyZWVfYmxvY2sgKCVzOiVsdSk6IGJp
dCBhbHJlYWR5IGNsZWFyZWRcbiIsCiAJCSAgICAgICBzYi0+c19pZCwgYmxvY2spOworCX0KKwog
CXNwaW5fdW5sb2NrKCZiaXRtYXBfbG9jayk7Ci0JbWFya19idWZmZXJfZGlydHkoYmgpOwogCXJl
dHVybjsKIH0KIAotLSAKMi4zNC4xCgo=
--0000000000007677050627ad6ae9--


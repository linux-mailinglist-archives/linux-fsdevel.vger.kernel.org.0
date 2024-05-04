Return-Path: <linux-fsdevel+bounces-18735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 336898BBD9D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 20:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3B385B21126
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 May 2024 18:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D729774416;
	Sat,  4 May 2024 18:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdUNsydj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1BA11711;
	Sat,  4 May 2024 18:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714847214; cv=none; b=ECBdDr0XvOz/h4EE8rPTuh2IA9jRk3zZ4OQRQogVIkl8HbaWkEfpx+p5hJN/Z8QCnGO2DzuecKLtn8MI1qYyqNMZiOpgV/2v2Zoi0Xxrz1Zkbb6SmldmhuIb6AM9X8hc8O4RgD2RIQq3fwI1doOGLwJ14RizFwh8n1BL2YBZkUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714847214; c=relaxed/simple;
	bh=lKT+dJGRVa9nO+Whcn2AOhSg0sUWKwZyVQKy1RwKXlM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eUAa8zL+EQambCipIiKWJV3PhJ73/z9Y12XOawyrrggvvVsQLVjtp4/oYez+lW+w39sd7JR7I3o/u/XVPr/5sai8uToSa3lg3vhYpQGoJlizz20WH67ataBe9oIq3yjB6lVF0Wfp5F7AwWRWk91OO9kzJFBr8BrBh/Ax6dGkAW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LdUNsydj; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51ab4ee9df8so849139e87.1;
        Sat, 04 May 2024 11:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714847210; x=1715452010; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoaahDx30Yjm+Yu/cdeLoE3Gay/twrbht60gp9bVA6o=;
        b=LdUNsydjK9b2tPTre1vJmUl06JI806U3XPYWLciDtgIccA26a4z9C3GgDtVjrcGAl1
         kel7Z1iH/ZxciDYnZaQNwVTCcZuMLGX5ueQ+lEzpLmGFSb1rpQSPO8NxuXVzlKhXWQlA
         XDrxWNXT3FBwX1T+gHIkjsQIG1+qhO7TIL14XCQFIn2fTJFN8EtiUbA2yhDke23TmFWN
         RX95lpPCeUqJu6YLSAirVXW+sVz7Ch6jl5ARO/1T3vYoOhMtOtX/g7kaYBq3k1TDfbZH
         w7R8nn6doQxR3q6OEJgZN9cwn8CJW9T/xG2457TqAICudlNxF1uD1Nv9AWKNijttMD9E
         YDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714847210; x=1715452010;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zoaahDx30Yjm+Yu/cdeLoE3Gay/twrbht60gp9bVA6o=;
        b=ekAizl0fR1l9KD05tma48HPtX9lBgAS+i1IyMC68lc9b5fBhkUWudM3phBp6ed/11Y
         iL2NpItGMi717inpnntSs0XLDMj0W+DebFcUbzcHze5oSe8T0BaF60xcaYdWs9hZBG4X
         ObpzNDkDrsChGdwrFbB94Vef4XbKT6cltuetc2toC2uQpfWhHTSadmsXTMow0fxCFGTP
         xvMxeQ/Qs0nrH/NOmV3pOEWX7gVI+W75J/NWBZHVZCo0iajdZmzf7wOU9AS+8LVdaFFF
         Xt+KbZ9WWXzMvkVw0oKzPhyEiDyW3eEVJBIjWRQvNw1tLd/m1eVcsxTxBQdVMh+ZgdpE
         FBKg==
X-Forwarded-Encrypted: i=1; AJvYcCVAf9YVC9KudX/PeOwJItqq5Cts4Cn7D/GngSqevnrch8sZgm1774ZZYjcVVb+6byTtUbhnQ5rFy2FAIkic3Ub/O8++d2OIERSuUlUL/k1c03t+t5dSP+MXeiYDlDDTfsYA6e/0LnJ1Uis=
X-Gm-Message-State: AOJu0YzfbOqvBXEllgFRR9EH9cfEfNagLW9XN+i474BpGPNFmxdXjSfq
	WyK1uUcmtvw59iV9sJrV2wuyPUx7XMv8pUaWZpTTmqSAaiy0tYp2J/QZAf6sg0Co+2YL35f7F5Z
	BIZMdyfmarhV7nBBAOXCLwUtMHGA=
X-Google-Smtp-Source: AGHT+IHi4hynLsRFJw62K7MVajcMudTrVZKNnD2uIBnw0tn9COIwbkXGGd2mjhNGSqG1Wz0p0GK29VoLq9d07Y7kVa4=
X-Received: by 2002:a05:6512:131d:b0:51c:f21c:518f with SMTP id
 x29-20020a056512131d00b0051cf21c518fmr4921496lfu.12.1714847209888; Sat, 04
 May 2024 11:26:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003002be06179e2f61@google.com>
In-Reply-To: <0000000000003002be06179e2f61@google.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sun, 5 May 2024 03:26:33 +0900
Message-ID: <CAKFNMo=EA9GHn8LehR8kbgs+z92G5v=FCmTcafwjtnV3+T3AOA@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] kernel BUG in __block_write_begin_int (2)
To: syzbot <syzbot+d3abed1ad3d367fa2627@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, May 4, 2024 at 7:20=E2=80=AFPM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    9e4bc4bcae01 Merge tag 'nfs-for-6.9-2' of git://git.linux=
-..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D12f2ae8718000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3714fc09f933e=
505
> dashboard link: https://syzkaller.appspot.com/bug?extid=3Dd3abed1ad3d367f=
a2627
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D150c697f180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D140de53718000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/b98a742ff5ed/dis=
k-9e4bc4bc.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/207a8191df7c/vmlinu=
x-9e4bc4bc.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/7dd86c3ad0ba/b=
zImage-9e4bc4bc.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/d35001c4b7=
48/mount_0.gz
>
> Bisection is inconclusive: the issue happens on the oldest tested release=
.
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15526d3718=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17526d3718=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13526d3718000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+d3abed1ad3d367fa2627@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:2083!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN NOPTI
> CPU: 0 PID: 5084 Comm: syz-executor283 Not tainted 6.9.0-rc6-syzkaller-00=
012-g9e4bc4bcae01 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> RIP: 0010:__block_write_begin_int+0x19a7/0x1a70 fs/buffer.c:2083
> Code: 31 ff e8 ac 35 78 ff 48 89 d8 48 25 ff 0f 00 00 74 27 e8 bc 30 78 f=
f e9 c6 e7 ff ff e8 b2 30 78 ff 90 0f 0b e8 aa 30 78 ff 90 <0f> 0b e8 a2 30=
 78 ff 90 0f 0b e8 ca 5d 62 09 48 8b 5c 24 08 48 89
> RSP: 0018:ffffc90003327760 EFLAGS: 00010293
> RAX: ffffffff821ddf06 RBX: 0000000000007b54 RCX: ffff88802eff3c00
> RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000000007b54
> RBP: ffffc900033278c8 R08: ffffffff821dc733 R09: 1ffffd400006f810
> R10: dffffc0000000000 R11: fffff9400006f811 R12: 00fff0000000920d
> R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000007b54
> FS:  000055556494d480(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055838a10d7f0 CR3: 0000000078508000 CR4: 0000000000350ef0
> Call Trace:
>  <TASK>
>  nilfs_prepare_chunk fs/nilfs2/dir.c:86 [inline]
>  nilfs_set_link+0xc5/0x2a0 fs/nilfs2/dir.c:411
>  nilfs_rename+0x5b2/0xaf0 fs/nilfs2/namei.c:416
>  vfs_rename+0xbdd/0xf00 fs/namei.c:4880
>  do_renameat2+0xd94/0x13f0 fs/namei.c:5037
>  __do_sys_rename fs/namei.c:5084 [inline]
>  __se_sys_rename fs/namei.c:5082 [inline]
>  __x64_sys_rename+0x86/0xa0 fs/namei.c:5082
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa292c67f99
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffd9d3b0198 EFLAGS: 00000246 ORIG_RAX: 0000000000000052
> RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fa292c67f99
> RDX: 00007fa292c67f99 RSI: 0000000020000040 RDI: 0000000020000180
> RBP: 0000000000000000 R08: 00007ffd9d3b01d0 R09: 00007ffd9d3b01d0
> R10: 0000000000000f69 R11: 0000000000000246 R12: 00007ffd9d3b01d0
> R13: 00007ffd9d3b0458 R14: 431bde82d7b634db R15: 00007fa292cb103b
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:__block_write_begin_int+0x19a7/0x1a70 fs/buffer.c:2083
> Code: 31 ff e8 ac 35 78 ff 48 89 d8 48 25 ff 0f 00 00 74 27 e8 bc 30 78 f=
f e9 c6 e7 ff ff e8 b2 30 78 ff 90 0f 0b e8 aa 30 78 ff 90 <0f> 0b e8 a2 30=
 78 ff 90 0f 0b e8 ca 5d 62 09 48 8b 5c 24 08 48 89
> RSP: 0018:ffffc90003327760 EFLAGS: 00010293
> RAX: ffffffff821ddf06 RBX: 0000000000007b54 RCX: ffff88802eff3c00
> RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000000000007b54
> RBP: ffffc900033278c8 R08: ffffffff821dc733 R09: 1ffffd400006f810
> R10: dffffc0000000000 R11: fffff9400006f811 R12: 00fff0000000920d
> R13: 0000000000000000 R14: 0000000000001000 R15: 0000000000007b54
> FS:  000055556494d480(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000055838a039e38 CR3: 0000000078508000 CR4: 0000000000350ef0
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> For information about bisection process see: https://goo.gl/tpsmEJ#bisect=
ion
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

This appears to be an issue with the same cause as the automatically
obsoleted issue below:

https://syzkaller.appspot.com/bug?extid=3D4936b06b07f365af31cc

I would like to take a closer look.

Ryusuke Konishi


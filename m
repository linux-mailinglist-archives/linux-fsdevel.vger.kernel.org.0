Return-Path: <linux-fsdevel+bounces-18159-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E888B60E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 20:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 286AE1C2194C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2024 18:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD26F12839E;
	Mon, 29 Apr 2024 18:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YR1o4cnH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B379D71727;
	Mon, 29 Apr 2024 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414339; cv=none; b=OZNYZ96+tRg/ZVQgqwJ6ilVONHSWM2MxZbJD8sYFUJZBkaDvr5k/1IuG0zpWfWHZnkH+zE5RArxq33uTCf0x5iVb+Px4nVEnTiHZJI7UT8Xd6kI8phSNmYshKOsZYEX/uwdxV87xVnA+Q9h0DgFlzkpk90czdT4fHubO+a3P+so=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414339; c=relaxed/simple;
	bh=BW0i6c46YpvFeDpm64F5A3mTWwxarhkD/Lp52q/xz8E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h32Xozjupz+YNtRGxII0dM6LGCeXFN9jr4IFCdrkeBrwDq5fyu6HshdYcRd5pU/yjOY7cJmuQ1ujcIExv7LVy5lj2bSSN3u7VA7Ps375GaG7vB3Vo4xtvVr1OrVesj5+bCB0mCzbljt9dSVaO0cH5tC3kuYcYxb/GoRNnI4fejs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YR1o4cnH; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so5250777276.1;
        Mon, 29 Apr 2024 11:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714414337; x=1715019137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Idt4073Hn+28gETqqRqIRV0SGXzVPtybMzDfU+l919o=;
        b=YR1o4cnHxLCGhWF0s5tqSHfCcemCVwUrJEUxkAr6xFiOSgebMBsCaIH37WjWRJCYOc
         4xt2N2zE+FLMuj9NvDoWEhjBCOHH5DacjxgGnn/CAE8nGg9myJFw9TE2dIWuTRJvnvVJ
         jRpW35HWLf70kUeIv2w5AkAng5q6MrDkjp9Y75VkWt0e4qYeyNtH8GABp0Q38ze8a1bm
         OZUdMP7utezw4IicsjFxKDZtqwJyQFGGCh2QFmBJieVmZwk5ZCJYgkXTHTK3rA9ODys6
         luU9ETDek5xiw7iKywYil45XSU4AiMIh6KTT9+mTq6Ni5bdWaHpBKa8V8qMWOq/BDjwb
         iKgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414337; x=1715019137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Idt4073Hn+28gETqqRqIRV0SGXzVPtybMzDfU+l919o=;
        b=tJ55Jyxlf294hzPMwXffDhQUSeNSKlB9hLbOMTaauwOuISfdODOzwJkFIVuIjfpzxB
         gU8MG4uQxSVF1WPS54hlcRpRY768FsQ7IQn17gZYiIUwlvw/0Fb0+TAkxWG6/ojWw/k0
         a78KwmE9gBuG06/EceWKa6z0XEFqdhLa2Wsz/6eV/qMEntAprIc6ZZ66FOSeSZMXOUA1
         OsVEJLvLGniW4WTWuKqkWq+J59ETMPPjwkRQ51kUBRAp8JLwLYcJAhIpvrhcgLdbNBIv
         4fLv6YKqoexkKypDJlSoRNsN6UjD5B09161tVH0gZEnvdN8LGwt5dV+8EWtOoYvmVWvw
         gOww==
X-Forwarded-Encrypted: i=1; AJvYcCVBW8s/GvLJ+FXqxyuEoUm4QfVke8E0n2UC97i7c1/RUIz7dtprLmLS/hB+fGCfEXib2ZyrwIAzOR45NmKew0S4wVsdJIzhZ8JbuEY58pUBuX5FSqdCIl8gFnlJ3tQA15ZAr7+xw4+oxUsFip6PI1jZ7Hyv54y15iZXmYOgmNjtenXwwLi6nglf
X-Gm-Message-State: AOJu0YwGLKugIDxJQWnSeq0/BbQTAxIupten6r8vtt9IRsCS8oXDwtxK
	9YlJxvhOGXy0qhbX6lPrr6yT6fbnv+asFnLkguaufi2TipBEMZSiIPQGlRLGimr6c1rdnMuYbCG
	XERM/taSI06V6roYJ7Q0H0/8Fty5m9ZK3
X-Google-Smtp-Source: AGHT+IEmebc4BnOVSnISOrIXN52NV/yW1/G+sh2i8EGQdYxz972K4e8bicqprIx6+cAXhOKoZy+m+P3tcgc1Y9VzlZA=
X-Received: by 2002:a25:5505:0:b0:de5:53ed:bce9 with SMTP id
 j5-20020a255505000000b00de553edbce9mr10462713ybb.46.1714414336606; Mon, 29
 Apr 2024 11:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000ff44c506173c1642@google.com>
In-Reply-To: <000000000000ff44c506173c1642@google.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Tue, 30 Apr 2024 03:11:58 +0900
Message-ID: <CAKFNMomcZcWO8xBNEcxnCJBTZBqTbGcsKn469=J667bKh2srag@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] kernel BUG in nilfs_delete_entry
To: syzbot <syzbot+32c3706ebf5d95046ea1@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 29, 2024 at 10:18=E2=80=AFPM syzbot wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    5eb4573ea63d Merge tag 'soc-fixes-6.9-2' of git://git.ker=
n..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D1591a5e898000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D3d46aa9d7a44f=
40d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D32c3706ebf5d950=
46ea1
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1213956b180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ac32ef18000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7e4c1378cbb1/dis=
k-5eb4573e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/8e4487ecdd86/vmlinu=
x-5eb4573e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/d84518ee028f/b=
zImage-5eb4573e.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/350446b=
af90d/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/e66542e=
7352f/mount_2.gz
>
> The issue was bisected to:
>
> commit 602ce7b8e1343b19c0cf93a3dd1926838ac5a1cc
> Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Date:   Fri Jan 27 13:22:02 2023 +0000
>
>     nilfs2: prevent WARNING in nilfs_dat_commit_end()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D15d757d898=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D17d757d898=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D13d757d898000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+32c3706ebf5d95046ea1@syzkaller.appspotmail.com
> Fixes: 602ce7b8e134 ("nilfs2: prevent WARNING in nilfs_dat_commit_end()")
>
> ------------[ cut here ]------------
> kernel BUG at fs/nilfs2/dir.c:545!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 1 PID: 5115 Comm: syz-executor410 Not tainted 6.9.0-rc5-syzkaller-00=
296-g5eb4573ea63d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> RIP: 0010:nilfs_delete_entry+0x349/0x350 fs/nilfs2/dir.c:545
> Code: 8d fe e9 de fd ff ff 44 89 f9 80 e1 07 fe c1 38 c1 0f 8c 20 ff ff f=
f 4c 89 ff e8 f2 a6 8d fe e9 13 ff ff ff e8 68 56 2c fe 90 <0f> 0b 0f 1f 44=
 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc900036078b8 EFLAGS: 00010293
> RAX: ffffffff8369aa08 RBX: 0000000000000050 RCX: ffff888018339e00
> RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 0000000000000000
> RBP: 00000000fffffffb R08: ffffffff8369a8de R09: 1ffff1100806d722
> R10: dffffc0000000000 R11: ffffed100806d723 R12: ffffea00010fed80
> R13: ffff888043fb6038 R14: 0000000000000020 R15: ffff888043fb6020
> FS:  00007fa2992ee6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007ffd3dbd8b98 CR3: 0000000024b86000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  nilfs_rename+0x57d/0xaf0 fs/nilfs2/namei.c:413
>  vfs_rename+0xbdb/0xf00 fs/namei.c:4880
>  do_renameat2+0xd94/0x13f0 fs/namei.c:5037
>  __do_sys_renameat2 fs/namei.c:5071 [inline]
>  __se_sys_renameat2 fs/namei.c:5068 [inline]
>  __x64_sys_renameat2+0xd2/0xf0 fs/namei.c:5068
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fa299358f49
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fa2992ee218 EFLAGS: 00000246 ORIG_RAX: 000000000000013c
> RAX: ffffffffffffffda RBX: 00007fa2993e16d8 RCX: 00007fa299358f49
> RDX: 0000000000000006 RSI: 0000000020000100 RDI: 0000000000000005
> RBP: 00007fa2993e16d0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000020000580 R11: 0000000000000246 R12: 00007fa2993ade20
> R13: 00007fa2993adb68 R14: 0030656c69662f2e R15: 3e2efc42dc31fca1
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:nilfs_delete_entry+0x349/0x350 fs/nilfs2/dir.c:545
> Code: 8d fe e9 de fd ff ff 44 89 f9 80 e1 07 fe c1 38 c1 0f 8c 20 ff ff f=
f 4c 89 ff e8 f2 a6 8d fe e9 13 ff ff ff e8 68 56 2c fe 90 <0f> 0b 0f 1f 44=
 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc900036078b8 EFLAGS: 00010293
>
> RAX: ffffffff8369aa08 RBX: 0000000000000050 RCX: ffff888018339e00
> RDX: 0000000000000000 RSI: 00000000fffffffb RDI: 0000000000000000
> RBP: 00000000fffffffb R08: ffffffff8369a8de R09: 1ffff1100806d722
> R10: dffffc0000000000 R11: ffffed100806d723 R12: ffffea00010fed80
> R13: ffff888043fb6038 R14: 0000000000000020 R15: ffff888043fb6020
> FS:  00007fa2992ee6c0(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fa2993149f0 CR3: 0000000024b86000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400

According to the stack trace, syzbot was hitting a legacy part that
uses BUG_ON() instead of returning errors in the directory code, so I
would like to fix it to cover this.

The bisected commit itself detects metadata corruption generated by
syzbot and handles it as an error, so it doesn't seem to be a problem.
  I'm guessing that the commit just affected reproducibility.

Ryusuke Konishi


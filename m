Return-Path: <linux-fsdevel+bounces-32467-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C41A9A659D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 13:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C80A1C225DB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Oct 2024 11:00:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9721E7C2C;
	Mon, 21 Oct 2024 10:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMIKVmzO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF4A1E47B0;
	Mon, 21 Oct 2024 10:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729508273; cv=none; b=q8eHF7gcceJa67Nr8Yzf1onmuztDgB4lhQ7BAagOCkn1iErRj6Qj2xTd1q158iNW8kQaE+VOolm69WE7bnqLn68dVaStCukl5c2s5y4T8sDUPByNfB+VQZnGPTnaUIS57SCaf9D2k+hLLoylpoLnnyA0HsdLxIc+avfGsJIRBjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729508273; c=relaxed/simple;
	bh=JkL5pxTXYV1c+ASK7POPGo88nBVN/dbvdwl7ADh887Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aQLK/BdChobjeaEUZA4kYAwVQ77FZgJ/bJWUH/J2UC92Nq7qUFgDpc1uNNgjp03Mj7FOr+6FfcsOnX9nlydN9LYkf6NpOcJWRvOJvxtfo3qPMQC3S/nZe5clWYgJJy9wdQ7gFBGCR+DukIzRaleNLrQEwhUeiZ1CYsn5MaBnats=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMIKVmzO; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f58c68c5so6337192e87.3;
        Mon, 21 Oct 2024 03:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729508270; x=1730113070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mNFkWYmfRQmEEsZqscUsIfG3JnH/ACkJuFsvDLPow8s=;
        b=GMIKVmzOhIMyeXlv2ToyT7v2DBrl4TJNOWKzlRHEd3bM6fMcpej5oWBItVbHADj91y
         yIaFTuz0vcvtn1oTuZzhkuly1D5Ic/rYHTYW7BIOhRA7FvmZmKOjFa/O/JaHp8hPsLuV
         GC7cdmMPlCTzih3FvgUYoKVLceoCTel5xEHt2E43Xc8x8TR2PAog19R76UDAF1SfqAex
         XYo+fFAW+GjUX5vul8nqLg+ig0UgiSbClMQRm1FEzzLlcig/VGwv0wJxfFsGAaVa89c9
         rVDY0Dt6+tcxfuihqsc6zz1KA3d4qOqxWF53IefpmoOugkswg/wDCQ9WkM1aTe4feyPh
         ys0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729508270; x=1730113070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNFkWYmfRQmEEsZqscUsIfG3JnH/ACkJuFsvDLPow8s=;
        b=WNmZ7pqFOpymjCSuqofWvY3TVvcXgh4PdtAZv96/BOVv2G/ocnGaDItqibUYKP6zeH
         hE9gKpaYMQAyyauQtvlJvQToHFzQoTdY3ugZQN0weyKl7/UxcCetaQAUFPSCrJ0VJors
         PglyWLmTCZRB1fUPyFGJYK1J3T/NVtPN6gGzHjkua+/p2ittQzk4vtDg0DOWr5hHfYD9
         hdyixpybN/6Os0x2B41NC5smZ5XHy0k5f/2gxXcFIcIWirEeII2RwTZ+i4XcFCuEX8qA
         wT1v+4nW4Ev4lo+BlNUR9xfyq7k0GROsCCXU1ezhN9tRcQPF/lrgDKNfXq6R9KQdGyJF
         c8Pg==
X-Forwarded-Encrypted: i=1; AJvYcCUUoSB0nhYUeBkyoc8TE7/9GVM8k+vLC6rg1OI7twBHfjIVuAkfT0KVp8nIyL9IfWBK8RzpcoLd18Dkp/Q=@vger.kernel.org, AJvYcCWHAcroFaJ28AVBjT792gIx9X4xKXqLE/h6zSN1168Vb6mAD9algiEJkoxhO0jdKiA/IGICSBSDjcxZAFZR@vger.kernel.org, AJvYcCX+aMpvL6Oq1CHn9fAhGufm+8PzprNIkB7RPPy51+nDvf15RMYO0i4vhffnCJPulBF3ITJRr2DQVOI7nYj+@vger.kernel.org
X-Gm-Message-State: AOJu0YzzyuNrCUsIhw4EYGiYpoWMqU1IlJ4ZQeNGqanRkGhIjXSHo4Uc
	34DMftdhh7zXrhoMF1fN8ES2toI76BbhuNmdWozirGNlW2i5aKkD3tftjbWpD/yaZlaW3izRRSU
	/+iOYXK5DUdDDS1ZfJR6H5xxOUxd94xe+
X-Google-Smtp-Source: AGHT+IHn1EHXBFSGk2RgzQqKNIjb5LnBYa3Wgd2udgTG2ZiWf1OnUyWjFfM7/XBOqkiaVvP6T+i+WYtfeSDcS8dg7Dk=
X-Received: by 2002:a05:6512:318b:b0:536:a695:9414 with SMTP id
 2adb3069b0e04-53a15340881mr8921169e87.6.1729508269405; Mon, 21 Oct 2024
 03:57:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb3f6.050a0220.3e960.0052.GAE@google.com> <67162374.050a0220.10f4f4.0045.GAE@google.com>
In-Reply-To: <67162374.050a0220.10f4f4.0045.GAE@google.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 21 Oct 2024 19:57:32 +0900
Message-ID: <CAKFNMonk7-DOE_knZLG8N_JijauKZ-DLgfA9GwsU0nDsbjKcSw@mail.gmail.com>
Subject: Re: [syzbot] [nilfs] [fs] kernel BUG in submit_bh_wbc (3)
To: syzbot <syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, brauner@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 6:48=E2=80=AFPM syzbot
<syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    42f7652d3eb5 Linux 6.12-rc4
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D10c66a4058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D41330fd2db038=
93d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D985ada84bf055a5=
75c07
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1541e430580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1181e0a798000=
0

The kernel bug reproduced by this C-reproducer is fixed by the patch
"nilfs2: fix kernel bug due to missing clearing of buffer delay flag"
on the way upstream.  I actually performed a follow-up test of this
C-reproducer and confirmed it.

This should be closed by the patch, so although there are additional
messages sent by syzbot, I will leave it without closing it manually.

Ryusuke Konishi


>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/21f56ec05989/dis=
k-42f7652d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d295ea00e68a/vmlinu=
x-42f7652d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/6c4b95c7f67f/b=
zImage-42f7652d.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/709e6e3=
2762f/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/6576d88=
61c23/mount_7.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:2785!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 5235 Comm: syz-executor372 Not tainted 6.12.0-rc4-syzk=
aller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> RIP: 0010:submit_bh_wbc+0x556/0x560 fs/buffer.c:2785
> Code: 89 fa e8 dd 76 cc 02 e9 95 fe ff ff e8 73 85 74 ff 90 0f 0b e8 6b 8=
5 74 ff 90 0f 0b e8 63 85 74 ff 90 0f 0b e8 5b 85 74 ff 90 <0f> 0b e8 53 85=
 74 ff 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90003b6f0d8 EFLAGS: 00010293
> RAX: ffffffff82206235 RBX: 0000000000000154 RCX: ffff88802d490000
> RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
> RBP: 0000000000000100 R08: ffffffff82205df9 R09: 1ffff1100ef571d0
> R10: dffffc0000000000 R11: ffffed100ef571d1 R12: 0000000000000000
> R13: ffff888077ab8e80 R14: 0000000000000000 R15: 1ffff1100ef571d0
> FS:  0000555573f7e380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbda422e00a CR3: 000000002fc1e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  submit_bh fs/buffer.c:2824 [inline]
>  block_read_full_folio+0x93b/0xcd0 fs/buffer.c:2451
>  do_mpage_readpage+0x1a73/0x1c80 fs/mpage.c:317
>  mpage_read_folio+0x108/0x1e0 fs/mpage.c:392
>  filemap_read_folio+0x14b/0x630 mm/filemap.c:2367
>  do_read_cache_folio+0x3f5/0x850 mm/filemap.c:3825
>  read_mapping_folio include/linux/pagemap.h:1011 [inline]
>  nilfs_get_folio+0x4b/0x240 fs/nilfs2/dir.c:190
>  nilfs_find_entry+0x13d/0x660 fs/nilfs2/dir.c:313
>  nilfs_inode_by_name+0xad/0x240 fs/nilfs2/dir.c:394
>  nilfs_lookup+0xed/0x210 fs/nilfs2/namei.c:63
>  lookup_open fs/namei.c:3573 [inline]
>  open_last_lookups fs/namei.c:3694 [inline]
>  path_openat+0x11a7/0x3590 fs/namei.c:3930
>  do_filp_open+0x235/0x490 fs/namei.c:3960
>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_openat fs/open.c:1446 [inline]
>  __se_sys_openat fs/open.c:1441 [inline]
>  __x64_sys_openat+0x247/0x2a0 fs/open.c:1441
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbda41e54a9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffe5e610168 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fbda41e54a9
> RDX: 000000000000275a RSI: 0000000020000180 RDI: 00000000ffffff9c
> RBP: 0000000000000000 R08: 00000000000051a5 R09: 000000002000a440
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffe5e61019c
> R13: 0000000000000007 R14: 431bde82d7b634db R15: 00007ffe5e6101d0
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:submit_bh_wbc+0x556/0x560 fs/buffer.c:2785
> Code: 89 fa e8 dd 76 cc 02 e9 95 fe ff ff e8 73 85 74 ff 90 0f 0b e8 6b 8=
5 74 ff 90 0f 0b e8 63 85 74 ff 90 0f 0b e8 5b 85 74 ff 90 <0f> 0b e8 53 85=
 74 ff 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc90003b6f0d8 EFLAGS: 00010293
> RAX: ffffffff82206235 RBX: 0000000000000154 RCX: ffff88802d490000
> RDX: 0000000000000000 RSI: 0000000000000100 RDI: 0000000000000000
> RBP: 0000000000000100 R08: ffffffff82205df9 R09: 1ffff1100ef571d0
> R10: dffffc0000000000 R11: ffffed100ef571d1 R12: 0000000000000000
> R13: ffff888077ab8e80 R14: 0000000000000000 R15: 1ffff1100ef571d0
> FS:  0000555573f7e380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fbd9cbff000 CR3: 000000002fc1e000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.


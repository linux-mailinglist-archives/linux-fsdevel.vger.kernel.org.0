Return-Path: <linux-fsdevel+bounces-31873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F3499C678
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 11:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D713828350F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Oct 2024 09:53:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BA3215855D;
	Mon, 14 Oct 2024 09:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxKjDBd+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F14146D55;
	Mon, 14 Oct 2024 09:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899633; cv=none; b=hujpwU5WJ1PDLK/H2wJw1408gsmG13hnf7UlPVjeuJsGPLQ6nz41/XKZabb+H9kXAP9z3l2HvRI7l2j0o/TcnuC/agrwNvcizEJgbcFn2TmeFwI0CHAMVPF4DhOPBc7mgtFnM+X0na0KiyCB5JSTTzZk9Zl0ofR6uh7wbhfJHVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899633; c=relaxed/simple;
	bh=5cjk8iUobFGFzWz9q45XgRHJrGFZmeeY8r3AbkL4hAk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i0JU01St3/SzhYmqaW+qwOHuzPemohHBWn5ZEnpIdrQG5kTJxRwmxuSaahWVPlzG5CnuMl+V2EZVT8poR6lSfa45etPZIApHhendB+7LyrT3RBafIe7+PL5/xXNab6VDxhGwaed8/txnab0G06TlxUuBT/Jj4JNfNWx9IBayCd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxKjDBd+; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-539fb49c64aso527819e87.0;
        Mon, 14 Oct 2024 02:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728899630; x=1729504430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nTJCAbsfL5kAFzil++rWGNYvs34Y3ujnFp8XvG65VYM=;
        b=UxKjDBd+PA8x3Mlj2t6EHf+yRv9DfSeelyapoDBFpCIPFC/iuPSa3ut0P6B3okqtbA
         /MrneE8oG3z3a0JsExBzcuOt/31YA7cXqhAdm86MYOIlTItcKhUy4uLHIAD3Ir6iLCKl
         I8HEqix4ms7wHxVWg9HmKaEhH3/G1UMlSxBlZLkfUjXSIzUeHGcMOrtlVQCaEkaGyLSg
         qiZYizaM3NdZ534FU360AV2v9xw4s/brr3xQaMcP6Og7LsJ1rS0BZXuN3s64mogg3nhw
         40S0zwNHz43Nf5jT1wCx7XeKeZKRrSa4kPYGXX6KUaS3mgsQizYrLsNAP72zpTOZjD7n
         6pAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728899630; x=1729504430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nTJCAbsfL5kAFzil++rWGNYvs34Y3ujnFp8XvG65VYM=;
        b=UCPRyMChwNclTb3u//rtz1tMHgOBq4nZ3UDc8jesABJrDcOR3D8QapQAyeQzmUPkYZ
         Lr0yTjxr29jMk/UpzcbMJGl80tBATOBzvPNwC0TOyyOYeKMho7RfrUAMuqQ6I/PYReY4
         Ng+qAjea0hph36rbgOxPrBK5L5YHp+VUR5ecPSxwNCNEHE6jrH0NHM226eza7FxNPbWH
         w5KZjF/UmHO8Ayh/vPpt949BH+IPtQQEP5zltiA6Wbm9QYDAYTkXAlCZAyMwJxfbaZgn
         gSVHRHQfzJ42II5IPSlGZ1HKVizaTqEdGJJBZZwcIy36crx/efMJQav9ufkQUZXJ9Zov
         lMog==
X-Forwarded-Encrypted: i=1; AJvYcCUwiuw056yAn4q9EPifPKkitGIKG5sj5oIHNEXiYrW/DNFT/67T3Ex/53fpmSOk+avhWr4p4qHPOApgltNZ@vger.kernel.org, AJvYcCVORXrwthYEkhXMTy3Yhx9NfJLbpojXNmoE/AWK8/z0pDILHW8oyCBC5K6/gXqAsJL4XEj4U7Z/SNVdoX6H@vger.kernel.org, AJvYcCW3F0O5bOYN2GR2FwZCMz6n9I4Cj71px5b4qntyXgwZn4pLa9Kz5Z9GCSl8aQ28EOKbU96lG73bndFhl2A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZgt1FqEJ+y883+tgLZdOkPekEqpzI1oiZhij467fJuqCGw7GM
	JfT8Z5znk2vX4HOSLF6TyuAtNGZPlTyb5PBQCVmLM7NDntZPrKFrelEUvOlWh9JL7CWng2FGFSP
	FEw2nHWyexwoGPfPZCef9IU1dnZ8=
X-Google-Smtp-Source: AGHT+IFqx8TcKXiv/Re9D241u030wW+khWtByCMfrfX8RLhIUB/l6/xMKzx/arboRN6kooM7tP4z+Lxl5ZB0NKdU8zk=
X-Received: by 2002:a05:6512:2346:b0:52c:e10b:cb33 with SMTP id
 2adb3069b0e04-539e57267ddmr3864409e87.50.1728899629474; Mon, 14 Oct 2024
 02:53:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <670cb3f6.050a0220.3e960.0052.GAE@google.com>
In-Reply-To: <670cb3f6.050a0220.3e960.0052.GAE@google.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 14 Oct 2024 18:53:33 +0900
Message-ID: <CAKFNMomwgmzwxbRKtDvbK-N0wWJ8iY9Xg-c_mBKzC3W90pXUMg@mail.gmail.com>
Subject: Re: [syzbot] [fs?] kernel BUG in submit_bh_wbc (3)
To: syzbot <syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com>
Cc: syzkaller-bugs@googlegroups.com, linux-nilfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 14, 2024 at 3:02=E2=80=AFPM syzbot
<syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    6485cf5ea253 Merge tag 'hid-for-linus-2024101301' of git:=
/..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D142f585f98000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D164d2822debd8=
b0d
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D985ada84bf055a5=
75c07
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/f39f2ba63ff0/dis=
k-6485cf5e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/1b68f3c352ce/vmlinu=
x-6485cf5e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/38070176e828/b=
zImage-6485cf5e.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+985ada84bf055a575c07@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:2785!
> Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 UID: 0 PID: 5968 Comm: syz.0.65 Not tainted 6.12.0-rc3-syzkaller-0=
0007-g6485cf5ea253 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> RIP: 0010:submit_bh_wbc+0x556/0x560 fs/buffer.c:2785
> Code: 89 fa e8 dd d7 cb 02 e9 95 fe ff ff e8 63 9b 74 ff 90 0f 0b e8 5b 9=
b 74 ff 90 0f 0b e8 53 9b 74 ff 90 0f 0b e8 4b 9b 74 ff 90 <0f> 0b e8 43 9b=
 74 ff 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc9000303e9f8 EFLAGS: 00010287
> RAX: ffffffff82204bb5 RBX: 0000000000000154 RCX: 0000000000040000
> RDX: ffffc900044b1000 RSI: 0000000000000a81 RDI: 0000000000000a82
> RBP: 0000000000000100 R08: ffffffff82204779 R09: 1ffff1100ae83f79
> R10: dffffc0000000000 R11: ffffed100ae83f7a R12: 0000000000000000
> R13: ffff88805741fbc8 R14: 0000000000000000 R15: 1ffff1100ae83f79
> FS:  00007fbfb2dcc6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f08b6361160 CR3: 000000005f354000 CR4: 00000000003526f0
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
>  nilfs_find_entry+0x138/0x650 fs/nilfs2/dir.c:313
>  nilfs_inode_by_name+0xa8/0x210 fs/nilfs2/dir.c:393
>  nilfs_lookup+0x76/0x110 fs/nilfs2/namei.c:62
>  __lookup_slow+0x28c/0x3f0 fs/namei.c:1732
>  lookup_slow fs/namei.c:1749 [inline]
>  lookup_one_unlocked+0x1a4/0x290 fs/namei.c:2912
>  ovl_lookup_positive_unlocked fs/overlayfs/namei.c:210 [inline]
>  ovl_lookup_single+0x200/0xbd0 fs/overlayfs/namei.c:240
>  ovl_lookup_layer+0x417/0x510 fs/overlayfs/namei.c:333
>  ovl_lookup+0x5d8/0x2a60 fs/overlayfs/namei.c:1068
>  lookup_open fs/namei.c:3573 [inline]
>  open_last_lookups fs/namei.c:3694 [inline]
>  path_openat+0x11a7/0x3590 fs/namei.c:3930
>  do_filp_open+0x235/0x490 fs/namei.c:3960
>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1415
>  do_sys_open fs/open.c:1430 [inline]
>  __do_sys_open fs/open.c:1438 [inline]
>  __se_sys_open fs/open.c:1434 [inline]
>  __x64_sys_open+0x225/0x270 fs/open.c:1434
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7fbfb1f7dff9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fbfb2dcc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000002
> RAX: ffffffffffffffda RBX: 00007fbfb2135f80 RCX: 00007fbfb1f7dff9
> RDX: 0000000000000000 RSI: 000000000014d27e RDI: 0000000020000180
> RBP: 00007fbfb1ff0296 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 0000000000000000 R14: 00007fbfb2135f80 R15: 00007ffe859206a8
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:submit_bh_wbc+0x556/0x560 fs/buffer.c:2785
> Code: 89 fa e8 dd d7 cb 02 e9 95 fe ff ff e8 63 9b 74 ff 90 0f 0b e8 5b 9=
b 74 ff 90 0f 0b e8 53 9b 74 ff 90 0f 0b e8 4b 9b 74 ff 90 <0f> 0b e8 43 9b=
 74 ff 90 0f 0b 90 90 90 90 90 90 90 90 90 90 90 90
> RSP: 0018:ffffc9000303e9f8 EFLAGS: 00010287
> RAX: ffffffff82204bb5 RBX: 0000000000000154 RCX: 0000000000040000
> RDX: ffffc900044b1000 RSI: 0000000000000a81 RDI: 0000000000000a82
> RBP: 0000000000000100 R08: ffffffff82204779 R09: 1ffff1100ae83f79
> R10: dffffc0000000000 R11: ffffed100ae83f7a R12: 0000000000000000
> R13: ffff88805741fbc8 R14: 0000000000000000 R15: 1ffff1100ae83f79
> FS:  00007fbfb2dcc6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007f08b6361160 CR3: 000000005f354000 CR4: 00000000003526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
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

I can't say for sure, but from the stack trace, this seems to be an
issue with nilfs2, so I'll add the nilfs tag:

#syz set subsystems: nilfs, fs

Ryusuke Konishi


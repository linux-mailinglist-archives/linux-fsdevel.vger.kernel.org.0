Return-Path: <linux-fsdevel+bounces-22806-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8E891CB85
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 09:31:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB8E283A73
	for <lists+linux-fsdevel@lfdr.de>; Sat, 29 Jun 2024 07:31:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9F13376E9;
	Sat, 29 Jun 2024 07:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO0WA2vK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6A2EC5;
	Sat, 29 Jun 2024 07:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719646274; cv=none; b=rcE1zW4k37rbnMMM0CW5c1hZMRdcMlEw5GTzrfwC+5IPXAaWJcsCprTJa+P0gydjd6k2+eV22/eEaP6GtWxD01XXihJRIdGTMCfmhC5Pw9I2jwbEDfa3EpUudHZA8MVXLFdxS4mDm95XafFlPDqsOvHOpXYrjB3cBMB/C9cwHpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719646274; c=relaxed/simple;
	bh=+8uouc+q8RWe7tEuUZKaqus7l7eQj+2kCBWXrs8ulis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DddBzQVq7M/QrcLGhgw6TtYkIuLr0UKNUvk0Yqa74I3oaXfNKxpZO3T7a7x+Vcv6g8Ka03LPiu/mh8QAoj4sVNC3APiOZnmebsqRNSeQtcj9YBtfr/V4m+LyYQyFvVVCaQpFKK5u5FGMp9oXtOLhX1fZwwavWIsIPPQmTIah2ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HO0WA2vK; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-52bbf73f334so1157528e87.2;
        Sat, 29 Jun 2024 00:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719646270; x=1720251070; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jiq0v4OU9Wj5MDOC4dybFdNlnqYKEAGOTuCED6DRP1g=;
        b=HO0WA2vKXdf9KDd2WZYT0qxuJYtwpgB9Xo0mRJoDz288Kq7KrhkpGw/p2biNcMWszf
         Q6Si99MHsyg0BeAEqAMFV10eTdJp0KrZy3QFAXxVC8GCeJUiRQXeLG2MKHS3kLzCJuWb
         LUkpJ2DavoAJqCZVF1/Y9J+qOuvw+KvliVsEJA9+d/RkY33Ata4V1CJ0dl60m55AgRQY
         tROMNkel4Z+pTWqWQ99sawqjKNX3uyRg+A7+go3lzuVADiP3Ua2RJCeRgXI9Gef/wEV+
         Udew8bb+pkHZ0fcdXR7yzppGZAuk/iFIwvyJthdibXEHSc1gtGguOZX3oBmTYU7cphgz
         P0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719646270; x=1720251070;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jiq0v4OU9Wj5MDOC4dybFdNlnqYKEAGOTuCED6DRP1g=;
        b=M7L6D1CXvfDMkzPOJiGDwor5zX7YrMb3xBfpqKnTtZiGTig8XRRdF43wRTo/2E0rwH
         39RAvDOUsD7mtO1A5tBIzjWWiE/RE3fstaMrdUSRsrJajAyW9HmeVFNhZH9VlG8ST8H3
         ZwariZGDSEMHyqy/FhNxEUiVqYCwqNyv6DCwAUFcpKC+DfN6G/i/bmwcVPEOlsya22bT
         CB0ywHkF19BmyChblI8FDnnrtptLVY70K+VaLfKdhwmM9AQctSo7cvp+55O8/HewdDid
         OtMG5gCjIv4HSaKah+3gn8u5tV4z4pd4ne26CfGr0nMl7D04kqDkuysCuLr7K2sWMxOU
         MhNg==
X-Forwarded-Encrypted: i=1; AJvYcCUMaJ4gvHbEa3m3fvqJ9/tDR6/nbCAs4KqSSjp7RlIcsh6t4ZLWgTdNGiw5twqhnNDFrxaKkcwL1RiQM2LBkxuLDxbR27KzVEYYF3uvVbAHwsQefiZK/jeKxGfpJRaKAlk4J6inXEgiApfwAZfiYlUJ90Ij/ux38B0ShEh49bM/QNdB8CvcRLyF
X-Gm-Message-State: AOJu0YxNm/GP2eBWAKrIZuFSsn8F6zxfHF1oeOTzpPfgLwxSUkq0HNas
	e9QdyV2a1cJ6Cz8+1wBVmaMifZhJ7akSiuDc3s5FkJNPR57SPsanf3mn3lmGm2I6AIdGhnMrBsT
	EA1z7TLc3jCld1WszznozbSKZsCERUrMc
X-Google-Smtp-Source: AGHT+IF/SWJYjF7/yMtnIHUzDM4GeX3U3awBtLEAFq/vpYxfI8QgukjV/761c0ciMhtgLR/E4NT4MZAC1k0Kpz5cftI=
X-Received: by 2002:a05:6512:3497:b0:52e:764d:7409 with SMTP id
 2adb3069b0e04-52e8266eac0mr276771e87.19.1719646270207; Sat, 29 Jun 2024
 00:31:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000005c66ec061902110a@google.com>
In-Reply-To: <0000000000005c66ec061902110a@google.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Sat, 29 Jun 2024 16:30:53 +0900
Message-ID: <CAKFNMokpj+TkVwrYZ=mYmHKxx4eaKDEUyy_y+zqC+z0o2UmgBQ@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] [btrfs?] WARNING in filemap_unaccount_folio
To: syzbot <syzbot+026119922c20a8915631@syzkaller.appspotmail.com>
Cc: linux-nilfs@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	brauner@kernel.org, clm@fb.com, dsterba@suse.com, jack@suse.cz, 
	josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 11:55=E2=80=AFAM syzbot
<syzbot+026119922c20a8915631@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    b6394d6f7159 Merge tag 'pull-misc' of git://git.kernel.or=
g..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D142a7cb298000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D713476114e57e=
ef3
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D026119922c20a89=
15631
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D14d43f84980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11d4fadc98000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/e8e1377d4772/dis=
k-b6394d6f.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/19fbbb3b6dd5/vmlinu=
x-b6394d6f.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4dcce16af95d/b=
zImage-b6394d6f.xz
> mounted in repro #1: https://storage.googleapis.com/syzbot-assets/e197bb1=
019a1/mount_0.gz
> mounted in repro #2: https://storage.googleapis.com/syzbot-assets/1c62d47=
5ecf4/mount_2.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+026119922c20a8915631@syzkaller.appspotmail.com
>
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5096 at mm/filemap.c:217 filemap_unaccount_folio+0x6=
be/0xe40 mm/filemap.c:216
> Modules linked in:
> CPU: 1 PID: 5096 Comm: syz-executor306 Not tainted 6.9.0-syzkaller-10729-=
gb6394d6f7159 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 04/02/2024
> RIP: 0010:filemap_unaccount_folio+0x6be/0xe40 mm/filemap.c:216
> Code: 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 0f 85 e=
5 00 00 00 8b 6d 00 ff c5 e9 45 fa ff ff e8 c3 66 ca ff 90 <0f> 0b 90 48 b8=
 00 00 00 00 00 fc ff df 41 80 3c 06 00 74 0a 48 8b
> RSP: 0018:ffffc9000382f1f8 EFLAGS: 00010093
> RAX: ffffffff81cbd3ad RBX: ffff888079ef0380 RCX: ffff88802d4f5a00
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: 0000000000000003 R08: ffffffff81cbd2c9 R09: 1ffffd40000c1ec8
> R10: dffffc0000000000 R11: fffff940000c1ec9 R12: 1ffffd40000c1ec8
> R13: ffffea000060f640 R14: 1ffff1100f3de070 R15: ffffea000060f648
> FS:  00007f13ab0c76c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000000 CR3: 000000002ca92000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  delete_from_page_cache_batch+0x173/0xc70 mm/filemap.c:341
>  truncate_inode_pages_range+0x364/0xfc0 mm/truncate.c:359
>  truncate_inode_pages mm/truncate.c:439 [inline]
>  truncate_pagecache mm/truncate.c:732 [inline]
>  truncate_setsize+0xcf/0xf0 mm/truncate.c:757
>  simple_setattr+0xbe/0x110 fs/libfs.c:886
>  notify_change+0xbb4/0xe70 fs/attr.c:499
>  do_truncate+0x220/0x310 fs/open.c:65
>  handle_truncate fs/namei.c:3308 [inline]
>  do_open fs/namei.c:3654 [inline]
>  path_openat+0x2a3d/0x3280 fs/namei.c:3807
>  do_filp_open+0x235/0x490 fs/namei.c:3834
>  do_sys_openat2+0x13e/0x1d0 fs/open.c:1405
>  do_sys_open fs/open.c:1420 [inline]
>  __do_sys_creat fs/open.c:1496 [inline]
>  __se_sys_creat fs/open.c:1490 [inline]
>  __x64_sys_creat+0x123/0x170 fs/open.c:1490
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f13ab131c99
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 18 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f13ab0c7198 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 00007f13ab1bf6d8 RCX: 00007f13ab131c99
> RDX: 00007f13ab131c99 RSI: 0000000000000000 RDI: 00000000200001c0
> RBP: 00007f13ab1bf6d0 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 00007f13ab18c160
> R13: 000000000000006e R14: 0030656c69662f2e R15: 00007f13ab186bc0
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

#syz fix: nilfs2: add missing check for inode numbers on directory entries

I have confirmed that this issue will be fixed by the above commit,
which is in the process of being sent upstream.

This was one of the issues caused by an internal inode being exposed
in the namespace in a corrupted filesystem image.

Ryusuke Konishi


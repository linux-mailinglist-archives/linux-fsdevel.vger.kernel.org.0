Return-Path: <linux-fsdevel+bounces-16902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFDE8A47E8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 08:16:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FFDA1C220BB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Apr 2024 06:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85523EEBB;
	Mon, 15 Apr 2024 06:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GNrwivZo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E3414265;
	Mon, 15 Apr 2024 06:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161789; cv=none; b=FhjRnlRKW9tEdhMgvnCf/NLHc/RvGtvf/vF/rLyBF2iBjZBMaRectWkMHjc5s8aV7jxAlR1BZVlNBfw6SNmSeKMBegCLCP40lre7LkaFtQProytE6h0nSrTMa5D2Gx39s8r0FY9i692mkjiiLKjCzvQ33Dyx1C7WmsaNIyINyvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161789; c=relaxed/simple;
	bh=4KEOHtj5tI29sfxUuyTReaaZnOyBqpsOPUgBnUqkuyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7buH1tr8MWCP+m9JRIeh3hdQD73KEdpIRUyuD/W05WEmeAdDCPOuyABRu+Awsoa3RyhzuN2uRzmrYAbkshsyiT3pnMx4s+fquux2I2ha6/QtSyKIGm8qwaxTv3sK7NvhvgD2TPV02KxDRZBi7Qd7n1n4ABoEDRHiKWtaZUAQU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GNrwivZo; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d87660d5c9so26895511fa.2;
        Sun, 14 Apr 2024 23:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713161785; x=1713766585; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naeTXnTw4Y1Bfz5JDXwZOE1/uNjfe7Y1NDIloqvAKoM=;
        b=GNrwivZon5b1lyiu+pSocbsLUQ5hddlsEF7zsaD6qWd0u75UVqLVDEU05T/gZPMZPa
         iY81AEAxKjZphJwCN/2hAXbmxmGn/+WmT2xa9GTWH00n62A2902ksbDJj8ti5dCTItVo
         Ejy+u3XMo3W3e+gznZwWOHlNN7T26kKyQn1XLzAGFlK5ylRHtIZz0/XIIgjJ0VjmpAAO
         zLk5Y6oVIB6r55oy0xhw8ASZyJo1Ab1HT0nOTZs2eewH7QM+ur4zYIMYMJOCAo3JLIbq
         LuWLG6MN0EWTZKuhjYLhdc7NQ58a1FBN2PnRZFFgkn8EaqJfJSYULLLmVpmgrdHWldjv
         Hxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713161785; x=1713766585;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naeTXnTw4Y1Bfz5JDXwZOE1/uNjfe7Y1NDIloqvAKoM=;
        b=KIdfbHWziK/NeRNl/ir9cixB2RtyWUXIAyKZXSqC4cLrnC2NuXOm5R3iNVdIDC0Vka
         cE6qCLbn+o+/Qng8LFvIcuaoWg4u5FvkNGBK3/GrhqixiZbSRxj2wjv7rW6ABUw9zQn9
         pbEmoBeEhU2GwRA/3+vWjvXBO02Af8YAXwUfAOLol9tKbGBTBDfUvIuN3jP0k+QPW3UQ
         MeGJcpwhkIb9vyHG9Cl0HdnqHjnc8skWeRNaEYuXS7wVfyJvZTiND4doYmvEXbrWYx16
         kTEzQm5KJ9/yv3zQPQf30wFL78OFiOqrGeqqrIaHDDj1+j0+3ZIvunpR8QYIACr/5UrC
         daEA==
X-Forwarded-Encrypted: i=1; AJvYcCWifzJzNWbz/+NxSYHhc/ymka1Sbq+YAiMf5An0QlnQoh45wgWbs6SSL2UnqgkmNPfBW5bqIivmOIOFqSt294X8yEsRIZBJfNfkFPp29Yg1TGtC3J9cwpynFlZ7w2ZUD9Ui/uD2531m6sQv0ij6G7ZzTGfQdPPqx4VASsnN+PYXc8/MJ9SyuH6/
X-Gm-Message-State: AOJu0YzxUHY7iULqjd8a7dvDHJ4/d5BbAQWoCPyB31ByB/ZX+W7GjKJU
	HXPn0YDfAU1+wVlqohUDdmgtNNot3adDPoa7DXq4Wm7W1C/SWSn57m32t7P8Syrs6QJrPmhRSzg
	mt1aX9g+lMzl2q6OoJqwK0lpDdVUPHOch
X-Google-Smtp-Source: AGHT+IGYqtJcoTa4yQDAMz5nYaYXTpo58151RPjuv2w2f7pc0oIxyUf9GufgOdquxReNHrggDyP6+cUWNtogoe+GX2w=
X-Received: by 2002:a2e:91c9:0:b0:2d8:6787:eaed with SMTP id
 u9-20020a2e91c9000000b002d86787eaedmr7272644ljg.2.1713161784869; Sun, 14 Apr
 2024 23:16:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000eab13906161775e8@google.com>
In-Reply-To: <000000000000eab13906161775e8@google.com>
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Mon, 15 Apr 2024 15:16:08 +0900
Message-ID: <CAKFNMonB=ZU45f9=sxTnxw3ZdboiObkDQQUVyHUm1rR5Cz+ngg@mail.gmail.com>
Subject: Re: [syzbot] [nilfs?] kernel BUG in submit_bh_wbc
To: syzbot <syzbot+3a841e887ad90c07541a@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:11=E2=80=AFAM syzbot
<syzbot+3a841e887ad90c07541a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kerne=
l..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D13f8135b18000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3D4d90a36f0cab4=
95a
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3a841e887ad90c0=
7541a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11a7a983180=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D16c5a29d18000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/72ab73815344/dis=
k-fe46a7dd.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/2d6d6b0d7071/vmlinu=
x-fe46a7dd.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/48e275e5478b/b=
zImage-fe46a7dd.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/12d8fad50c=
e0/mount_0.gz
>
> The issue was bisected to:
>
> commit 602ce7b8e1343b19c0cf93a3dd1926838ac5a1cc
> Author: Ryusuke Konishi <konishi.ryusuke@gmail.com>
> Date:   Fri Jan 27 13:22:02 2023 +0000
>
>     nilfs2: prevent WARNING in nilfs_dat_commit_end()
>
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=3D128df91318=
0000
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=3D118df91318=
0000
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D168df91318000=
0
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+3a841e887ad90c07541a@syzkaller.appspotmail.com
> Fixes: 602ce7b8e134 ("nilfs2: prevent WARNING in nilfs_dat_commit_end()")
>
> NILFS (loop0): discard dirty block: blocknr=3D18446744073709551615, size=
=3D1024
> NILFS (loop0): nilfs_get_block (ino=3D18): a race condition while inserti=
ng a data block at offset=3D0
> ------------[ cut here ]------------
> kernel BUG at fs/buffer.c:2768!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 0 PID: 5056 Comm: syz-executor429 Not tainted 6.8.0-syzkaller-08951-=
gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> RIP: 0010:submit_bh_wbc+0x543/0x560 fs/buffer.c:2768
> Code: 07 7d ff be 00 10 00 00 48 c7 c7 80 f8 26 8e 4c 89 fa e8 f0 cd be 0=
2 e9 98 fe ff ff e8 86 07 7d ff 90 0f 0b e8 7e 07 7d ff 90 <0f> 0b e8 76 07=
 7d ff 90 0f 0b e8 6e 07 7d ff 90 0f 0b e8 66 07 7d
> RSP: 0018:ffffc9000399f838 EFLAGS: 00010293
> RAX: ffffffff8217ecd2 RBX: 0000000000000000 RCX: ffff88807cfe3c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff8217e833 R09: 1ffff1100f095cae
> R10: dffffc0000000000 R11: ffffed100f095caf R12: 0000000000000000
> R13: ffff8880784ae570 R14: 0000000000000000 R15: 1ffff1100f095cae
> FS:  00005555917ee380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000066c7e0 CR3: 000000007f430000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  submit_bh fs/buffer.c:2809 [inline]
>  __bh_read fs/buffer.c:3074 [inline]
>  bh_read_nowait include/linux/buffer_head.h:417 [inline]
>  __block_write_begin_int+0x12d0/0x1a70 fs/buffer.c:2134
>  __block_write_begin fs/buffer.c:2154 [inline]
>  block_write_begin+0x9b/0x1e0 fs/buffer.c:2213
>  nilfs_write_begin+0xa0/0x110 fs/nilfs2/inode.c:262
>  generic_perform_write+0x322/0x640 mm/filemap.c:3930
>  __generic_file_write_iter+0x1b8/0x230 mm/filemap.c:4022
>  generic_file_write_iter+0xaf/0x310 mm/filemap.c:4051
>  call_write_iter include/linux/fs.h:2108 [inline]
>  new_sync_write fs/read_write.c:497 [inline]
>  vfs_write+0xa84/0xcb0 fs/read_write.c:590
>  ksys_write+0x1a0/0x2c0 fs/read_write.c:643
>  do_syscall_64+0xfb/0x240
>  entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7f3d6ccdd9f9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 61 17 00 00 90 48 89 f8 48 89 f=
7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc74baec58 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
> RAX: ffffffffffffffda RBX: 0073746e6576652e RCX: 00007f3d6ccdd9f9
> RDX: 0000000000000020 RSI: 0000000020000140 RDI: 0000000000000005
> RBP: 652e79726f6d656d R08: 00000000000b15f8 R09: 00000000000b15f8
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> R13: 00007ffc74baee28 R14: 0000000000000001 R15: 0000000000000001
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:submit_bh_wbc+0x543/0x560 fs/buffer.c:2768
> Code: 07 7d ff be 00 10 00 00 48 c7 c7 80 f8 26 8e 4c 89 fa e8 f0 cd be 0=
2 e9 98 fe ff ff e8 86 07 7d ff 90 0f 0b e8 7e 07 7d ff 90 <0f> 0b e8 76 07=
 7d ff 90 0f 0b e8 6e 07 7d ff 90 0f 0b e8 66 07 7d
> RSP: 0018:ffffc9000399f838 EFLAGS: 00010293
> RAX: ffffffff8217ecd2 RBX: 0000000000000000 RCX: ffff88807cfe3c00
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> RBP: 0000000000000000 R08: ffffffff8217e833 R09: 1ffff1100f095cae
> R10: dffffc0000000000 R11: ffffed100f095caf R12: 0000000000000000
> R13: ffff8880784ae570 R14: 0000000000000000 R15: 1ffff1100f095cae
> FS:  00005555917ee380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000000066c7e0 CR3: 000000007f430000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>
>
> ---

#syz fix: nilfs2: prevent kernel bug at submit_bh_wbc()

This issue has already been fixed and the patch has been backported to
stable trees.

The kernel used for testing in this report was older than that.

Also, the reported issue looks the same as below, but with a different
title and id.

https://syzkaller.appspot.com/bug?extid=3Dcfed5b56649bddf80d6e

The bisected patch is also not the real cause.


Ryusuke Konishi



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


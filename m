Return-Path: <linux-fsdevel+bounces-31803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8422699B5E5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 17:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B98D282DAF
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Oct 2024 15:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADA852E822;
	Sat, 12 Oct 2024 15:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GT1umggE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89B6282F4;
	Sat, 12 Oct 2024 15:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728747561; cv=none; b=hE4xyGoLzQ+yHjO1EmNolrdQ86ZSQSNaUgUjgTZpqJeY8hB1yv/Zfc/h6qfSgfgKLbJ5f0ZmYtDkMBFhnw0NhiT8kmY97tSosJ2KcW2GiVVcPH2U3tysFrOyE7KU7zwVT1cDPiZFh2Gr8/hdXt9rkH8EwsMMiolKT43LiwOailA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728747561; c=relaxed/simple;
	bh=x6UOYFc2f9zYQLTQRgy6wBwUzJ/jShvSV8zO6ALlQAw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H06Z/dLhdmNastrR1yOYUB96dlGI1JShsUNB7+3DdZ5KgZDsKyg3m5WyI/AIdEFG0FMLM3OQQQ9MacOIpEBi3wQB4trGFZV8NPSWQ31982CVJ4UORRDaBjIOaiXVGwdGRnTu7czSGGBFodMysOLBaWBGxNugCJwBwxYh6RKYtcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GT1umggE; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5c935d99dc5so3038043a12.1;
        Sat, 12 Oct 2024 08:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728747557; x=1729352357; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lbiMvm8ot9KDmewKweJFlc3o+QwAUqgbDv0JaNk9x9A=;
        b=GT1umggE/2phgOtpRhuspqjn+v9lKvNSRtSLvMdi33bwK75ZSivhB3LRkegWrr1VLq
         ewW0ArYVx9kXjI14uKhoCGlB81WPa+wf24PP3cumuhRdHReUnq8SRv4l9pn8IYKlDBcS
         lAzCAh+gdDeOq7JBBUDw3Bt2qT1pioG/ocR1jIIT6nUUfw29qQhhzejhliQL/3hAWCVg
         cEX+EYi/Pu86JU5ZhbfSycVEBuIyahnuEoOkckrEdTGQxh5e4pJ7cUs2+sCuwpNh9eiC
         QrfqwcWYPb9zlkBJnWtZM2DJIGJgTZ/C6kcvMOOMQxLvcdlXYElKPRg444dNxBFIjLNc
         ZU/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728747557; x=1729352357;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lbiMvm8ot9KDmewKweJFlc3o+QwAUqgbDv0JaNk9x9A=;
        b=brh29ZVEr51E0xSl+mm3m1hH35JqHx46Y67Pxq4ZiOlo0gGHxwaPnm7xx/5Eau+bBP
         AlX2tRSgynSWs9tlXsQaO0FJY/IUHxpTCd9zGTDZ9W9mPyorydaBWHgjY23hCYssPu/J
         pMkdrHuyCPIsk1W2ImAACK5reNfytFhQ8eNbzXPYMEoSa7dT0Z80Br8L00IgC0qtTTla
         FowlCmKv0TjJiWGu0Ny+5rVSpx7fGMiW4c0ZedXywPjd6K4IlDxxy6wJO9BlZZv/L2tR
         LUgDGRt92W98FVfKRt3gIej6FtchwgWSw9ZC8IIUhmBJAv/Cyq7UZHFLEidOoLJ7ypFd
         SGEg==
X-Forwarded-Encrypted: i=1; AJvYcCW+HjqQAop4WU0CvW/IAnrsQdZIjxhA/F9MA0ay39CANXNgXAzwVan0SVq29n8ZR5mCAku+0qRTXN6ymZ4h@vger.kernel.org, AJvYcCWxvB9s/nygpMlVAm/K4CO7aTZSYJspVnaV4UYd8rMVpNpLOhZgSQjCXmDihDHMR1PudKSwqce2gIzcLW+9@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Rya9SU5rsmzoFqK6plRW5FTf3IRJeHOupqFSRam113n3fgN9
	ZVTgWZLRIZCJnKUbU/I7l1qq4jkIVHLxIOf4KYDNCSkr7vgQGc1OKr20TApEXpGBBCB6FlrFQbV
	skhYZlAVzW6DQyQtNLqO2S00Q7WE=
X-Google-Smtp-Source: AGHT+IGGjX2TwXTUw9WYIOcpRt99IjLoKLXuK/FioZfko1d5aBPrWe//dvVPxH0mbouIzVVCMl8mt4gj+IM9juldn04=
X-Received: by 2002:a05:6402:34ca:b0:5c9:68f9:8af3 with SMTP id
 4fb4d7f45d1cf-5c968f9a259mr961071a12.17.1728747556789; Sat, 12 Oct 2024
 08:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67014df7.050a0220.49194.04c0.GAE@google.com>
In-Reply-To: <67014df7.050a0220.49194.04c0.GAE@google.com>
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Sat, 12 Oct 2024 21:08:40 +0530
Message-ID: <CAHiZj8jQ4OHmkKKMbvo-sFYBb_19C-z+n5tf_V0-qkG-ijam-g@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
To: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
Cc: linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: multipart/mixed; boundary="00000000000007abbd0624496876"

--00000000000007abbd0624496876
Content-Type: multipart/alternative; boundary="00000000000007abbb0624496874"

--00000000000007abbb0624496874
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Sat, Oct 5, 2024 at 8:02=E2=80=AFPM syzbot <
syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com> wrote:

> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1'
> of..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16cf7dd058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db1fd45f2013d8=
12f
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=3D01218003be74b5e1213a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
> Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11cf7dd0580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11d0658058000=
0
>
> Downloadable assets:
> disk image:
> https://storage.googleapis.com/syzbot-assets/16d4da549bf4/disk-e32cde8d.r=
aw.xz
> vmlinux:
> https://storage.googleapis.com/syzbot-assets/a01bc9a0e174/vmlinux-e32cde8=
d.xz
> kernel image:
> https://storage.googleapis.com/syzbot-assets/93f4dfad6909/bzImage-e32cde8=
d.xz
> mounted in repro:
> https://storage.googleapis.com/syzbot-assets/433ba0700154/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit:
> Reported-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com
>
> exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum :
> 0x726052d3, utbl_chksum : 0xe619d30d)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in __exfat_get_dentry_set+0x10ca/0x14d0
> fs/exfat/dir.c:804
>  __exfat_get_dentry_set+0x10ca/0x14d0 fs/exfat/dir.c:804
>  exfat_get_dentry_set+0x58/0xec0 fs/exfat/dir.c:859
>  __exfat_write_inode+0x3c1/0xe30 fs/exfat/inode.c:46
>  __exfat_truncate+0x7f3/0xbb0 fs/exfat/file.c:211
>  exfat_truncate+0xee/0x2a0 fs/exfat/file.c:257
>  exfat_write_failed fs/exfat/inode.c:421 [inline]
>  exfat_direct_IO+0x5a3/0x900 fs/exfat/inode.c:485
>  generic_file_direct_write+0x275/0x6a0 mm/filemap.c:3977
>  __generic_file_write_iter+0x242/0x460 mm/filemap.c:4141
>  exfat_file_write_iter+0x894/0xfb0 fs/exfat/file.c:598
>  do_iter_readv_writev+0x88a/0xa30
>  vfs_writev+0x56a/0x14f0 fs/read_write.c:1064
>  do_pwritev fs/read_write.c:1165 [inline]
>  __do_sys_pwritev2 fs/read_write.c:1224 [inline]
>  __se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215
>  __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215
>  x64_sys_call+0x2edb/0x3ba0
> arch/x86/include/generated/asm/syscalls_64.h:329
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> Uninit was stored to memory at:
>  memcpy_to_iter lib/iov_iter.c:65 [inline]
>  iterate_bvec include/linux/iov_iter.h:123 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
>  iterate_and_advance include/linux/iov_iter.h:328 [inline]
>  _copy_to_iter+0xe53/0x2b30 lib/iov_iter.c:185
>  copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362
>  shmem_file_read_iter+0xa09/0x12b0 mm/shmem.c:3167
>  do_iter_readv_writev+0x88a/0xa30
>  vfs_iter_read+0x278/0x760 fs/read_write.c:923
>  lo_read_simple drivers/block/loop.c:283 [inline]
>  do_req_filebacked drivers/block/loop.c:516 [inline]
>  loop_handle_cmd drivers/block/loop.c:1910 [inline]
>  loop_process_work+0x20fc/0x3750 drivers/block/loop.c:1945
>  loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1976
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
>  worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was stored to memory at:
>  memcpy_from_iter lib/iov_iter.c:73 [inline]
>  iterate_bvec include/linux/iov_iter.h:123 [inline]
>  iterate_and_advance2 include/linux/iov_iter.h:304 [inline]
>  iterate_and_advance include/linux/iov_iter.h:328 [inline]
>  __copy_from_iter lib/iov_iter.c:249 [inline]
>  copy_page_from_iter_atomic+0x12b7/0x3100 lib/iov_iter.c:481
>  copy_folio_from_iter_atomic include/linux/uio.h:201 [inline]
>  generic_perform_write+0x8d1/0x1080 mm/filemap.c:4066
>  shmem_file_write_iter+0x2ba/0x2f0 mm/shmem.c:3221
>  do_iter_readv_writev+0x88a/0xa30
>  vfs_iter_write+0x44d/0xd40 fs/read_write.c:988
>  lo_write_bvec drivers/block/loop.c:243 [inline]
>  lo_write_simple drivers/block/loop.c:264 [inline]
>  do_req_filebacked drivers/block/loop.c:511 [inline]
>  loop_handle_cmd drivers/block/loop.c:1910 [inline]
>  loop_process_work+0x15e6/0x3750 drivers/block/loop.c:1945
>  loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1976
>  process_one_work kernel/workqueue.c:3229 [inline]
>  process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310
>  worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391
>  kthread+0x3e2/0x540 kernel/kthread.c:389
>  ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> Uninit was created at:
>  __alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756
>  alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265
>  alloc_pages_noprof mm/mempolicy.c:2345 [inline]
>  folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352
>  filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010
>  __filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952
>  block_write_begin+0x6e/0x2b0 fs/buffer.c:2226
>  exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434
>  exfat_extend_valid_size fs/exfat/file.c:553 [inline]
>  exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:588
>  do_iter_readv_writev+0x88a/0xa30
>  vfs_writev+0x56a/0x14f0 fs/read_write.c:1064
>  do_pwritev fs/read_write.c:1165 [inline]
>  __do_sys_pwritev2 fs/read_write.c:1224 [inline]
>  __se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215
>  __x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215
>  x64_sys_call+0x2edb/0x3ba0
> arch/x86/include/generated/asm/syscalls_64.h:329
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 0 UID: 0 PID: 5188 Comm: syz-executor221 Not tainted
> 6.12.0-rc1-syzkaller-00031-ge32cde8d2bd7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS
> Google 09/13/2024
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
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
>
> --
> You received this message because you are subscribed to the Google Groups
> "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an
> email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit
> https://groups.google.com/d/msgid/syzkaller-bugs/67014df7.050a0220.49194.=
04c0.GAE%40google.com
> .
>

--00000000000007abbb0624496874
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">#syz test<br></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">On Sat, Oct 5, 2024 at 8:02=E2=80=AFPM syzbot=
 &lt;<a href=3D"mailto:syzbot%2B01218003be74b5e1213a@syzkaller.appspotmail.=
com">syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com</a>&gt; wrote:<b=
r></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex=
;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hello,<br>
<br>
syzbot found the following issue on:<br>
<br>
HEAD commit:=C2=A0 =C2=A0 e32cde8d2bd7 Merge tag &#39;sched_ext-for-6.12-rc=
1-fixes-1&#39; of..<br>
git tree:=C2=A0 =C2=A0 =C2=A0 =C2=A0upstream<br>
console+strace: <a href=3D"https://syzkaller.appspot.com/x/log.txt?x=3D16cf=
7dd0580000" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.appspot.=
com/x/log.txt?x=3D16cf7dd0580000</a><br>
kernel config:=C2=A0 <a href=3D"https://syzkaller.appspot.com/x/.config?x=
=3Db1fd45f2013d812f" rel=3D"noreferrer" target=3D"_blank">https://syzkaller=
.appspot.com/x/.config?x=3Db1fd45f2013d812f</a><br>
dashboard link: <a href=3D"https://syzkaller.appspot.com/bug?extid=3D012180=
03be74b5e1213a" rel=3D"noreferrer" target=3D"_blank">https://syzkaller.apps=
pot.com/bug?extid=3D01218003be74b5e1213a</a><br>
compiler:=C2=A0 =C2=A0 =C2=A0 =C2=A0Debian clang version 15.0.6, GNU ld (GN=
U Binutils for Debian) 2.40<br>
syz repro:=C2=A0 =C2=A0 =C2=A0 <a href=3D"https://syzkaller.appspot.com/x/r=
epro.syz?x=3D11cf7dd0580000" rel=3D"noreferrer" target=3D"_blank">https://s=
yzkaller.appspot.com/x/repro.syz?x=3D11cf7dd0580000</a><br>
C reproducer:=C2=A0 =C2=A0<a href=3D"https://syzkaller.appspot.com/x/repro.=
c?x=3D11d06580580000" rel=3D"noreferrer" target=3D"_blank">https://syzkalle=
r.appspot.com/x/repro.c?x=3D11d06580580000</a><br>
<br>
Downloadable assets:<br>
disk image: <a href=3D"https://storage.googleapis.com/syzbot-assets/16d4da5=
49bf4/disk-e32cde8d.raw.xz" rel=3D"noreferrer" target=3D"_blank">https://st=
orage.googleapis.com/syzbot-assets/16d4da549bf4/disk-e32cde8d.raw.xz</a><br=
>
vmlinux: <a href=3D"https://storage.googleapis.com/syzbot-assets/a01bc9a0e1=
74/vmlinux-e32cde8d.xz" rel=3D"noreferrer" target=3D"_blank">https://storag=
e.googleapis.com/syzbot-assets/a01bc9a0e174/vmlinux-e32cde8d.xz</a><br>
kernel image: <a href=3D"https://storage.googleapis.com/syzbot-assets/93f4d=
fad6909/bzImage-e32cde8d.xz" rel=3D"noreferrer" target=3D"_blank">https://s=
torage.googleapis.com/syzbot-assets/93f4dfad6909/bzImage-e32cde8d.xz</a><br=
>
mounted in repro: <a href=3D"https://storage.googleapis.com/syzbot-assets/4=
33ba0700154/mount_0.gz" rel=3D"noreferrer" target=3D"_blank">https://storag=
e.googleapis.com/syzbot-assets/433ba0700154/mount_0.gz</a><br>
<br>
IMPORTANT: if you fix the issue, please add the following tag to the commit=
:<br>
Reported-by: <a href=3D"mailto:syzbot%2B01218003be74b5e1213a@syzkaller.apps=
potmail.com" target=3D"_blank">syzbot+01218003be74b5e1213a@syzkaller.appspo=
tmail.com</a><br>
<br>
exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum : 0=
x726052d3, utbl_chksum : 0xe619d30d)<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
BUG: KMSAN: uninit-value in __exfat_get_dentry_set+0x10ca/0x14d0 fs/exfat/d=
ir.c:804<br>
=C2=A0__exfat_get_dentry_set+0x10ca/0x14d0 fs/exfat/dir.c:804<br>
=C2=A0exfat_get_dentry_set+0x58/0xec0 fs/exfat/dir.c:859<br>
=C2=A0__exfat_write_inode+0x3c1/0xe30 fs/exfat/inode.c:46<br>
=C2=A0__exfat_truncate+0x7f3/0xbb0 fs/exfat/file.c:211<br>
=C2=A0exfat_truncate+0xee/0x2a0 fs/exfat/file.c:257<br>
=C2=A0exfat_write_failed fs/exfat/inode.c:421 [inline]<br>
=C2=A0exfat_direct_IO+0x5a3/0x900 fs/exfat/inode.c:485<br>
=C2=A0generic_file_direct_write+0x275/0x6a0 mm/filemap.c:3977<br>
=C2=A0__generic_file_write_iter+0x242/0x460 mm/filemap.c:4141<br>
=C2=A0exfat_file_write_iter+0x894/0xfb0 fs/exfat/file.c:598<br>
=C2=A0do_iter_readv_writev+0x88a/0xa30<br>
=C2=A0vfs_writev+0x56a/0x14f0 fs/read_write.c:1064<br>
=C2=A0do_pwritev fs/read_write.c:1165 [inline]<br>
=C2=A0__do_sys_pwritev2 fs/read_write.c:1224 [inline]<br>
=C2=A0__se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215<br>
=C2=A0__x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215<br>
=C2=A0x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64=
.h:329<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
<br>
Uninit was stored to memory at:<br>
=C2=A0memcpy_to_iter lib/iov_iter.c:65 [inline]<br>
=C2=A0iterate_bvec include/linux/iov_iter.h:123 [inline]<br>
=C2=A0iterate_and_advance2 include/linux/iov_iter.h:304 [inline]<br>
=C2=A0iterate_and_advance include/linux/iov_iter.h:328 [inline]<br>
=C2=A0_copy_to_iter+0xe53/0x2b30 lib/iov_iter.c:185<br>
=C2=A0copy_page_to_iter+0x419/0x880 lib/iov_iter.c:362<br>
=C2=A0shmem_file_read_iter+0xa09/0x12b0 mm/shmem.c:3167<br>
=C2=A0do_iter_readv_writev+0x88a/0xa30<br>
=C2=A0vfs_iter_read+0x278/0x760 fs/read_write.c:923<br>
=C2=A0lo_read_simple drivers/block/loop.c:283 [inline]<br>
=C2=A0do_req_filebacked drivers/block/loop.c:516 [inline]<br>
=C2=A0loop_handle_cmd drivers/block/loop.c:1910 [inline]<br>
=C2=A0loop_process_work+0x20fc/0x3750 drivers/block/loop.c:1945<br>
=C2=A0loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1976<br>
=C2=A0process_one_work kernel/workqueue.c:3229 [inline]<br>
=C2=A0process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310<br>
=C2=A0worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391<br>
=C2=A0kthread+0x3e2/0x540 kernel/kthread.c:389<br>
=C2=A0ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147<br>
=C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244<br>
<br>
Uninit was stored to memory at:<br>
=C2=A0memcpy_from_iter lib/iov_iter.c:73 [inline]<br>
=C2=A0iterate_bvec include/linux/iov_iter.h:123 [inline]<br>
=C2=A0iterate_and_advance2 include/linux/iov_iter.h:304 [inline]<br>
=C2=A0iterate_and_advance include/linux/iov_iter.h:328 [inline]<br>
=C2=A0__copy_from_iter lib/iov_iter.c:249 [inline]<br>
=C2=A0copy_page_from_iter_atomic+0x12b7/0x3100 lib/iov_iter.c:481<br>
=C2=A0copy_folio_from_iter_atomic include/linux/uio.h:201 [inline]<br>
=C2=A0generic_perform_write+0x8d1/0x1080 mm/filemap.c:4066<br>
=C2=A0shmem_file_write_iter+0x2ba/0x2f0 mm/shmem.c:3221<br>
=C2=A0do_iter_readv_writev+0x88a/0xa30<br>
=C2=A0vfs_iter_write+0x44d/0xd40 fs/read_write.c:988<br>
=C2=A0lo_write_bvec drivers/block/loop.c:243 [inline]<br>
=C2=A0lo_write_simple drivers/block/loop.c:264 [inline]<br>
=C2=A0do_req_filebacked drivers/block/loop.c:511 [inline]<br>
=C2=A0loop_handle_cmd drivers/block/loop.c:1910 [inline]<br>
=C2=A0loop_process_work+0x15e6/0x3750 drivers/block/loop.c:1945<br>
=C2=A0loop_rootcg_workfn+0x2b/0x40 drivers/block/loop.c:1976<br>
=C2=A0process_one_work kernel/workqueue.c:3229 [inline]<br>
=C2=A0process_scheduled_works+0xae0/0x1c40 kernel/workqueue.c:3310<br>
=C2=A0worker_thread+0xea7/0x14f0 kernel/workqueue.c:3391<br>
=C2=A0kthread+0x3e2/0x540 kernel/kthread.c:389<br>
=C2=A0ret_from_fork+0x6d/0x90 arch/x86/kernel/process.c:147<br>
=C2=A0ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244<br>
<br>
Uninit was created at:<br>
=C2=A0__alloc_pages_noprof+0x9d6/0xe70 mm/page_alloc.c:4756<br>
=C2=A0alloc_pages_mpol_noprof+0x299/0x990 mm/mempolicy.c:2265<br>
=C2=A0alloc_pages_noprof mm/mempolicy.c:2345 [inline]<br>
=C2=A0folio_alloc_noprof+0x1db/0x310 mm/mempolicy.c:2352<br>
=C2=A0filemap_alloc_folio_noprof+0xa6/0x440 mm/filemap.c:1010<br>
=C2=A0__filemap_get_folio+0xac4/0x1550 mm/filemap.c:1952<br>
=C2=A0block_write_begin+0x6e/0x2b0 fs/buffer.c:2226<br>
=C2=A0exfat_write_begin+0xfb/0x400 fs/exfat/inode.c:434<br>
=C2=A0exfat_extend_valid_size fs/exfat/file.c:553 [inline]<br>
=C2=A0exfat_file_write_iter+0x474/0xfb0 fs/exfat/file.c:588<br>
=C2=A0do_iter_readv_writev+0x88a/0xa30<br>
=C2=A0vfs_writev+0x56a/0x14f0 fs/read_write.c:1064<br>
=C2=A0do_pwritev fs/read_write.c:1165 [inline]<br>
=C2=A0__do_sys_pwritev2 fs/read_write.c:1224 [inline]<br>
=C2=A0__se_sys_pwritev2+0x280/0x470 fs/read_write.c:1215<br>
=C2=A0__x64_sys_pwritev2+0x11f/0x1a0 fs/read_write.c:1215<br>
=C2=A0x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64=
.h:329<br>
=C2=A0do_syscall_x64 arch/x86/entry/common.c:52 [inline]<br>
=C2=A0do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83<br>
=C2=A0entry_SYSCALL_64_after_hwframe+0x77/0x7f<br>
<br>
CPU: 0 UID: 0 PID: 5188 Comm: syz-executor221 Not tainted 6.12.0-rc1-syzkal=
ler-00031-ge32cde8d2bd7 #0<br>
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 09/13/2024<br>
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D<br>
<br>
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
To view this discussion on the web visit <a href=3D"https://groups.google.c=
om/d/msgid/syzkaller-bugs/67014df7.050a0220.49194.04c0.GAE%40google.com" re=
l=3D"noreferrer" target=3D"_blank">https://groups.google.com/d/msgid/syzkal=
ler-bugs/67014df7.050a0220.49194.04c0.GAE%40google.com</a>.<br>
</blockquote></div>

--00000000000007abbb0624496874--
--00000000000007abbd0624496876
Content-Type: text/x-patch; charset="US-ASCII"; name="0001-fs-fix-uinit.patch"
Content-Disposition: attachment; filename="0001-fs-fix-uinit.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m26bmsb60>
X-Attachment-Id: f_m26bmsb60

RnJvbSBhNTkyM2FjYTgyMWM1YjNhNWQ0OTgwYmQ3ZDYwNDA2MmE1MjE1ZGZjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBTb25hd2FuZSA8c3VyYWpzb25hd2FuZTAyMTVAZ21h
aWwuY29tPgpEYXRlOiBTYXQsIDEyIE9jdCAyMDI0IDIxOjA0OjQxICswNTMwClN1YmplY3Q6IFtQ
QVRDSF0gZnM6IGZpeCB1aW5pdAoKRml4IHRoZSB1bmluaXRpYWxpemVkIHN5bWJvbAoKU2lnbmVk
LW9mZi1ieTogU3VyYWogU29uYXdhbmUgPHN1cmFqc29uYXdhbmUwMjE1QGdtYWlsLmNvbT4KLS0t
CiBmcy9leGZhdC9kaXIuYyB8IDcgKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9u
cygrKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMKaW5kZXgg
NzQ0NmJmMDlhLi42ZWZiYjU3ODcgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L2Rpci5jCisrKyBiL2Zz
L2V4ZmF0L2Rpci5jCkBAIC03OTEsNiArNzkxLDcgQEAgc3RhdGljIGludCBfX2V4ZmF0X2dldF9k
ZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLAogCWVzLT5tb2RpZmll
ZCA9IGZhbHNlOwogCWVzLT5zdGFydF9vZmYgPSBvZmY7CiAJZXMtPmJoID0gZXMtPl9fYmg7CisJ
bWVtc2V0KGVzLT5fX2JoLCAwLCBzaXplb2YoZXMtPl9fYmgpKTsKIAogCWJoID0gc2JfYnJlYWQo
c2IsIHNlYyk7CiAJaWYgKCFiaCkKQEAgLTgwMSw2ICs4MDIsMTIgQEAgc3RhdGljIGludCBfX2V4
ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLAogCQlz
dHJ1Y3QgZXhmYXRfZGVudHJ5ICplcDsKIAogCQllcCA9IGV4ZmF0X2dldF9kZW50cnlfY2FjaGVk
KGVzLCBFU19JRFhfRklMRSk7CisKKwkJaWYgKCFlcCkgeworCQkJYnJlbHNlKGJoKTsKKwkJCXJl
dHVybiAtRUlPOworCQl9CisKIAkJaWYgKGVwLT50eXBlICE9IEVYRkFUX0ZJTEUpIHsKIAkJCWJy
ZWxzZShiaCk7CiAJCQlyZXR1cm4gLUVJTzsKLS0gCjIuMzQuMQoK
--00000000000007abbd0624496876--


Return-Path: <linux-fsdevel+bounces-32407-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8F19A4B21
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 06:01:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D48601F231D3
	for <lists+linux-fsdevel@lfdr.de>; Sat, 19 Oct 2024 04:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57B91D0F56;
	Sat, 19 Oct 2024 04:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b+cMVNuc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AE02F2F;
	Sat, 19 Oct 2024 04:01:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729310481; cv=none; b=ufZ9+7JDNfvORaKQLMifQraBmTnxRJmBerIjp6lTpZKYMvG6jjU5JX/VCylq35SyiJEL/Au9eXfNW6PTtjRCFUU7irRIc8nOadmOSeizGDFs1RZk61kh6iUbINTi+lQJ9SBrn6jO+P++57zkKzDG4drL7rCu2Il05DeNsCRFPyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729310481; c=relaxed/simple;
	bh=4NS7RxG0vMGE/L95ZgRLWU48YstocNYLztGIXqPAxEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtoSAxw9b5mXTbDqozEdYQUTw2cQyoB/1oAmdU8A7cxtNuMbj+Wmp8pYkrhNGKHmNt+H7kXJ0TdmhKDpnMMp6ICE4LyJ5ma07reas6dvm6hF/IxJQjlfxvaDsImXImGqn6YhmF+D9oJ3Mv5jGfbzri/elTtFHr/VIQm2pq96fB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b+cMVNuc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B62C4CED2;
	Sat, 19 Oct 2024 04:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729310480;
	bh=4NS7RxG0vMGE/L95ZgRLWU48YstocNYLztGIXqPAxEs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=b+cMVNuc6agZOmYksR0xAoe46AcZ9bg0XBiPEIHjAzMQj98EmMSo0oOHGn2kECIXw
	 hDx4gc+63K/LBbE2jlAcvnyfwRkD0p4+1wp2QoCt23CaumNHABKKlwJEmiLg5lP8ET
	 qi+n/rBNw7o0HGDg21zj7lvCfe6ZGS+IzMFNpdp+mpL2l4oSXwahMI188SR3h/yJl3
	 0CBEGgONutO++rJqLmisumaqZLs4Mt6yvVh+n8zyXrtOO90mA5Wbcc+pCQ+WDId5Vg
	 kXOzQZfcGHwkLghgrB3ommBg8ytGjWif9i1sucjt7DPA6DWKZ0JizMQGAHALF+WMXV
	 MF6iRCW4HyT+Q==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-27ce4f37afeso1461060fac.0;
        Fri, 18 Oct 2024 21:01:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXVGIHpqS2TP9lqztw0WdDqIZY4R0YYHkeI2DDnxjEpqs+kqM3EskVfVM4XKgdJTev8ookahBb/eS/Tvj8=@vger.kernel.org
X-Gm-Message-State: AOJu0YysfhNn5rW9d5SyoJPIwSGnSeGDqT0c46a8fxjIbDeY2DKCO/18
	UOtsrPP9D2QCP01gWS3a8rT3RM/aq0GIg/N4aCfUWMShSDBX3ejdTbIyxaaX3yTD4GRBVXeYPbW
	WL06+vUZCsAWRWXO6lZGKvBNtMfw=
X-Google-Smtp-Source: AGHT+IGFoVJPOp4RfZsJlltEw9AF594tRj/kGzqwDdn465hxmX/9lLsXoto4RnGGOJ0IpXaMd6IjupXgz674HlshzR0=
X-Received: by 2002:a05:6870:304a:b0:288:60d3:a257 with SMTP id
 586e51a60fabf-2892c5a2037mr4007947fac.40.1729310479659; Fri, 18 Oct 2024
 21:01:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67014df7.050a0220.49194.04c0.GAE@google.com>
In-Reply-To: <67014df7.050a0220.49194.04c0.GAE@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 19 Oct 2024 13:01:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Sai7+S1AnAhLtnYWKwZMoAUgUmq_9HRG=oKSg4p-CnQ@mail.gmail.com>
Message-ID: <CAKYAXd8Sai7+S1AnAhLtnYWKwZMoAUgUmq_9HRG=oKSg4p-CnQ@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
To: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: multipart/mixed; boundary="000000000000d8d86f0624cc789b"

--000000000000d8d86f0624cc789b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

#syz test

On Sat, Oct 5, 2024 at 11:32=E2=80=AFPM syzbot
<syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    e32cde8d2bd7 Merge tag 'sched_ext-for-6.12-rc1-fixes-1' o=
f..
> git tree:       upstream
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=3D16cf7dd058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Db1fd45f2013d8=
12f
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D01218003be74b5e=
1213a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D11cf7dd0580=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D11d0658058000=
0
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/16d4da549bf4/dis=
k-e32cde8d.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/a01bc9a0e174/vmlinu=
x-e32cde8d.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/93f4dfad6909/b=
zImage-e32cde8d.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/433ba07001=
54/mount_0.gz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com
>
> exFAT-fs (loop0): failed to load upcase table (idx : 0x00010000, chksum :=
 0x726052d3, utbl_chksum : 0xe619d30d)
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> BUG: KMSAN: uninit-value in __exfat_get_dentry_set+0x10ca/0x14d0 fs/exfat=
/dir.c:804
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
>  x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
329
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
>  x64_sys_call+0x2edb/0x3ba0 arch/x86/include/generated/asm/syscalls_64.h:=
329
>  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>  do_syscall_64+0xcd/0x1e0 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
>
> CPU: 0 UID: 0 PID: 5188 Comm: syz-executor221 Not tainted 6.12.0-rc1-syzk=
aller-00031-ge32cde8d2bd7 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
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

--000000000000d8d86f0624cc789b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-exfat-fix-uninit-value-use-in-__exfat_get_dentry_set.patch"
Content-Disposition: attachment; 
	filename="0001-exfat-fix-uninit-value-use-in-__exfat_get_dentry_set.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m2fms99y0>
X-Attachment-Id: f_m2fms99y0

RnJvbSAwMWRjZjk1ZWRmMDI2M2M3ZjI5Y2FhN2EwNDc3YWIxYjhjNGM3Y2E3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBTYXQsIDE5IE9jdCAyMDI0IDEyOjU5OjA1ICswOTAwClN1YmplY3Q6IFtQQVRDSF0gZXhm
YXQ6IGZpeCB1bmluaXQtdmFsdWUgdXNlIGluIF9fZXhmYXRfZ2V0X2RlbnRyeV9zZXQKClNpZ25l
ZC1vZmYtYnk6IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+Ci0tLQogZnMvZXhm
YXQvZGlyLmMgfCAxMiArKysrKysrKystLS0KIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZGlyLmMgYi9mcy9leGZh
dC9kaXIuYwppbmRleCA3NDQ2YmYwOWEwNGEuLjhlZTNjOTllMjY2NiAxMDA2NDQKLS0tIGEvZnMv
ZXhmYXQvZGlyLmMKKysrIGIvZnMvZXhmYXQvZGlyLmMKQEAgLTc0MSw5ICs3NDEsMTUgQEAgc3Rh
dGljIGJvb2wgZXhmYXRfdmFsaWRhdGVfZW50cnkodW5zaWduZWQgaW50IHR5cGUsCiBzdHJ1Y3Qg
ZXhmYXRfZGVudHJ5ICpleGZhdF9nZXRfZGVudHJ5X2NhY2hlZCgKIAlzdHJ1Y3QgZXhmYXRfZW50
cnlfc2V0X2NhY2hlICplcywgaW50IG51bSkKIHsKLQlpbnQgb2ZmID0gZXMtPnN0YXJ0X29mZiAr
IG51bSAqIERFTlRSWV9TSVpFOwotCXN0cnVjdCBidWZmZXJfaGVhZCAqYmggPSBlcy0+YmhbRVhG
QVRfQl9UT19CTEsob2ZmLCBlcy0+c2IpXTsKLQljaGFyICpwID0gYmgtPmJfZGF0YSArIEVYRkFU
X0JMS19PRkZTRVQob2ZmLCBlcy0+c2IpOworCXN0cnVjdCBidWZmZXJfaGVhZCAqYmg7CisJaW50
IG9mZjsKKwljaGFyICpwOworCisJaWYgKGNoZWNrX2FkZF9vdmVyZmxvdyhlcy0+c3RhcnRfb2Zm
LCBudW0gKiBERU5UUllfU0laRSwgJm9mZikpCisJCXJldHVybiBOVUxMOworCisJYmggPSBlcy0+
YmhbRVhGQVRfQl9UT19CTEsob2ZmLCBlcy0+c2IpXTsKKwlwID0gYmgtPmJfZGF0YSArIEVYRkFU
X0JMS19PRkZTRVQob2ZmLCBlcy0+c2IpOwogCiAJcmV0dXJuIChzdHJ1Y3QgZXhmYXRfZGVudHJ5
ICopcDsKIH0KLS0gCjIuMjUuMQoK
--000000000000d8d86f0624cc789b--


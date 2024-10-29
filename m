Return-Path: <linux-fsdevel+bounces-33098-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1C79B418D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 05:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B41C91F23025
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Oct 2024 04:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F4C11FF5F6;
	Tue, 29 Oct 2024 04:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3rHtxEe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12B01DC05D;
	Tue, 29 Oct 2024 04:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730175434; cv=none; b=mdS0/DUtih4E8YfFWFbBXgCqXNlqj+96J3K64b5qZbT+ZGmtcL/0Gijr9H54g4Oxil2tDR50QsRS/qBR9/Ty9zhMkO9GXUpFSl2dd1nB8fOoCdcxil6OcJp9krnm64q2d6sOyHH5rv+BwKiXNmWQG41tQ0X1xtpwJsHj9cznY/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730175434; c=relaxed/simple;
	bh=RKHYedL3g+YcC1whE+lrjzQFGsTH7O/wS2r9LScdask=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=po1rKZ8LXjWAUlUqcavxzzq8Xb9aRZmzoC35JmOE/s/VeG4Ff5ENdk/2K823Ii2J64IktPUPj35RzCEMDrF5qz3RbE+FPzYvK3a9M5AoGmbxTOG71Q/s5EiSJDSCGZV6SSMxDgceSIE+ekY5LGGfP1jehqsrwJhQ5RQjJLnJD1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3rHtxEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E28FC4CEE6;
	Tue, 29 Oct 2024 04:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730175434;
	bh=RKHYedL3g+YcC1whE+lrjzQFGsTH7O/wS2r9LScdask=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=F3rHtxEenmfxI79Pdpq3K+wIl06yqw6LjLsWY2+ZAhjnso72pbThHEaq8m//ZWpnh
	 2iKmKQQPi7iarMaPuhNL6VCveyVXHRMU8rvSZq/1KX33hiwJtUz1onVWAkFQ5aTkai
	 QloB0aKldgqqb4oRtxoOHEyzacAL/LPeOOGLLVYL+1DuisB58SQOv8e0IcFajjVqwW
	 K5QBG975yw4FZNSlwi5bEumhvdjiySxuYeQ5uxyxWclZdu9hjnaa9Fm1VVTXc9ggeM
	 LgLkptRoWFAzgTAQlhTbENrx2dcVBAnqDqf2M+6TDSdDJ3PNOit/Lv/XSyXPVy72eh
	 KDz87v+WxNrog==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-28c654c9e79so3420121fac.0;
        Mon, 28 Oct 2024 21:17:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXJIg2XfqlLv5f04oAqqbETDm/HodQEU9wmdQ50XGvoXvAhNovtSOv7LrC6MxtRiy9dk2HlUHe90vAD6hc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jovGWg3g0jvSX5lNeFgQhTu7vg/ujM0SWOrw457ZL+6ibmqj
	Gn/Id+JvgkeGswSNNltWL0xcnlnMXmQttdOhchpWyZzflF48TqBa6bLY4nhRofXMfFO7/MdDXHf
	IG0/oC+D/lP2XNfwFuJmT+vfFLFM=
X-Google-Smtp-Source: AGHT+IFkdsLQqCsNUI/rwxJgrn2piEZpQY1D7MgYbWYhArEk968SnKnTwkyq8izXP90qKiEqYhpoV9VxuJ3/tOFEu20=
X-Received: by 2002:a05:6870:8899:b0:277:d790:6e99 with SMTP id
 586e51a60fabf-29103df1f58mr497237fac.18.1730175433543; Mon, 28 Oct 2024
 21:17:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <67014df7.050a0220.49194.04c0.GAE@google.com>
In-Reply-To: <67014df7.050a0220.49194.04c0.GAE@google.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 29 Oct 2024 13:17:01 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-v5nQVkE58bvuk0V-kGTN+Q7vbsf678A7v3zb-Z2d8Kg@mail.gmail.com>
Message-ID: <CAKYAXd-v5nQVkE58bvuk0V-kGTN+Q7vbsf678A7v3zb-Z2d8Kg@mail.gmail.com>
Subject: Re: [syzbot] [exfat?] KMSAN: uninit-value in __exfat_get_dentry_set
To: syzbot <syzbot+01218003be74b5e1213a@syzkaller.appspotmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, yuezhang.mo@sony.com
Content-Type: multipart/mixed; boundary="0000000000001db9f2062595dc41"

--0000000000001db9f2062595dc41
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

--0000000000001db9f2062595dc41
Content-Type: application/x-patch; 
	name="0001-exfat-fix-uninit-value-in-__exfat_get_dentry_set.patch"
Content-Disposition: attachment; 
	filename="0001-exfat-fix-uninit-value-in-__exfat_get_dentry_set.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m2txpzik0>
X-Attachment-Id: f_m2txpzik0

RnJvbSBiYzM4NWVlOGZjZWYwOGQ4M2Q3MDk0MTVkNTAwZWYyZTJhYzg3NDU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBOYW1qYWUgSmVvbiA8bGlua2luamVvbkBrZXJuZWwub3JnPgpE
YXRlOiBUdWUsIDI5IE9jdCAyMDI0IDEwOjIyOjMxICswOTAwClN1YmplY3Q6IFtQQVRDSF0gZXhm
YXQ6IGZpeCB1bmluaXQtdmFsdWUgaW4gX19leGZhdF9nZXRfZGVudHJ5X3NldAoKVGhlcmUgaXMg
bm8gY2hlY2sgaWYgc3RyZWFtIHNpemUgYW5kIHN0YXJ0X2NsdSBhcmUgaW52YWxpZC4KSWYgc3Rh
cnRfY2x1IGlzIEVPRiBjbHVzdGVyIGFuZCBzdHJlYW0gc2l6ZSBpcyA0MDk2LCBJdCB3aWxsIGNh
dXNlCnVuaW5pdCB2YWx1ZSBhY2Nlc3MuIGJlY2F1c2UgZWktPmhpbnRfZmVtcC5laWR4IGNvdWxk
IGJlIDEyOChpZiBjbHVzdGVyCnNpemUgaXMgNEspIGFuZCB3cm9uZyBoaW50IHdpbGwgYWxsb2Nh
dGUgbmV4dCBjbHVzdGVyLiBhbmQgdGhpcyBjbHVzdGVyCndpbGwgYmUgc2FtZSB3aXRoIHRoZSBj
bHVzdGVyIHRoYXQgaXMgYWxsb2NhdGVkIGJ5CmV4ZmF0X2V4dGVuZF92YWxpZF9zaXplKCkuIFRo
ZSBwcmV2aW91cyBwYXRjaCB3aWxsIGNoZWNrIGludmFsaWQgc3RhcnRfY2x1LApidXQgZm9yIGNs
YXJpdHksIEluaXRpYWxpemUgaGludF9mZW1wLmVpZHggdG8gemVyby4KClNpZ25lZC1vZmYtYnk6
IE5hbWphZSBKZW9uIDxsaW5raW5qZW9uQGtlcm5lbC5vcmc+Ci0tLQogZnMvZXhmYXQvbmFtZWku
YyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZnMv
ZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMKaW5kZXggMmM0YzQ0MjI5MzUyLi5jNTMw
MmI5MTQwNjYgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMKKysrIGIvZnMvZXhmYXQvbmFt
ZWkuYwpAQCAtMzQ1LDYgKzM0NSw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmluZF9lbXB0eV9lbnRy
eShzdHJ1Y3QgaW5vZGUgKmlub2RlLAogCQlpZiAoZWktPnN0YXJ0X2NsdSA9PSBFWEZBVF9FT0Zf
Q0xVU1RFUikgewogCQkJZWktPnN0YXJ0X2NsdSA9IGNsdS5kaXI7CiAJCQlwX2Rpci0+ZGlyID0g
Y2x1LmRpcjsKKwkJCWhpbnRfZmVtcC5laWR4ID0gMDsKIAkJfQogCiAJCS8qIGFwcGVuZCB0byB0
aGUgRkFUIGNoYWluICovCi0tIAoyLjM0LjEKCg==
--0000000000001db9f2062595dc41--


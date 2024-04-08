Return-Path: <linux-fsdevel+bounces-16385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B9189CDB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 23:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CBC9284142
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Apr 2024 21:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1E148854;
	Mon,  8 Apr 2024 21:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="frNwmEJl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3021442F3
	for <linux-fsdevel@vger.kernel.org>; Mon,  8 Apr 2024 21:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612285; cv=none; b=GPuehHGmXV3TjuiT/qJrykbFQzT1HycBLAcZMMgBjIbDnBdYxGzs+Ahvh0lBmBhb3mTgvSs49IGXJHTWVY/lHqFL3/BgQuNemHJQwx6j5ePNei5W7tdf5lzEjHQ1tPNRzXDcjFrTU6Wv2tG1YXggGTCMjJNp0FY+qQPx22+A7Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612285; c=relaxed/simple;
	bh=rJMyqwHoU1d+ASrMu4S2K5MKtPpKPCIIsm3W1KdmAbY=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=mi5c/LZ+YkK/QzW7JrWc1xJxo7lqKprhWD+1/aoDZ38KvvNNkwRcmiZJ5TIS54YhU+oLvZo3HfneVRIzbQK51AFZzSF05JbDnZowr561vW1sltZ/hLSMWcY0bCjmcqbWu95d3luH6OJAq4RCcViIyItGBA/5jX1SicEoZDkzUsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=frNwmEJl; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6eaf1005fcaso3383532b3a.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 08 Apr 2024 14:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1712612282; x=1713217082; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=QGF3F8oncbzFUH6AnD5StgM85q5b3PMLB3TKzAJ1uZo=;
        b=frNwmEJl1GxJpI3S/O0mvAV7/xa1T6X4SDTKz8FRMk5ntxoSnzwsmvFOKd1rJRSuXx
         UWdz4QIohbjsQrNg0poqcX0kcTq5SrzFQW1ooYUQkyT5OLHu6zjWpkV1I9f6TtHbMiOj
         Gnl+zx8603WarJj0ZcBhc15rTYDDnPdw64tCAsr91w8yXaakaX5WsWQl738+zyf8rSjC
         ZOW0OSa/h5n1PT/DJsGuwa9RP0p4GTcVWb9BYDtEvGUppq+jJBrApjHUG3KmQqaAa6Kn
         Pri3DpO4PlQRb8kBLdAGX98HeYOfFvbzJ+HNM/ul+CIMSnLA+Oy4CGwJdiodjHEudFbb
         g44A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612282; x=1713217082;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGF3F8oncbzFUH6AnD5StgM85q5b3PMLB3TKzAJ1uZo=;
        b=mUsXyGuXUj0D4QEmtPyuEk6QJtbghMM6Pjem0JwR43xbrmGpoE832sql250in2WtnZ
         S2DDo/UT8aaYG0p7f+3oNSMdNgy9SKAC0pbvbS/XDMVEd309xm/+q/Y2lEyMr6QsCu7Z
         22uei857wo30trdVFcY/MPMgJv41BqSJZTzweUi02eEprEJUQA6Ve+rfjEHEKI8zZnzM
         eJ5XPft19Nozup+QPb5SSg/Is+D1hb3Zv5fZVaR2KfDyBpsIdohQg66/fpk0VIsXEMZF
         vcHEP4GsZOCaq4ZUHVX+EGlYtkqacUlFGcPat5TINJeH3SmVJi8mqqfS8eQCgmUxONh4
         tp9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUieFUm3uXGQhexxOSkS8X85i395Ov3jROavjP7y3kbuNIitxMlc6D60bT0RzKW/H0lYo0RbFZDauKXZDk3nsmh9PY1i4SrltT4w0xSXw==
X-Gm-Message-State: AOJu0Ywmi6tWqneucJ1E4Z2R4QA5gz0yN91Un6cei34B2PdOxsze7pEr
	1ITnISu8QFkutclAorvWn1n4iYa8gBzCZzy1EuWSIuI8lb3lxsicqnISt3+URvI=
X-Google-Smtp-Source: AGHT+IFp4g3vWs97qoNz3DNm/p/AJag+Q1FEIti5ov0rir4wYGv5DVtm524UNMuxbraaOLiAAb45/A==
X-Received: by 2002:a05:6a21:1a3:b0:1a7:6eb1:583c with SMTP id le35-20020a056a2101a300b001a76eb1583cmr4415188pzb.3.1712612282432;
        Mon, 08 Apr 2024 14:38:02 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id q20-20020a62ae14000000b006e6233563cesm7031053pff.218.2024.04.08.14.38.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Apr 2024 14:38:01 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <2CFF0603-0952-4EBA-AE88-DB696EAAF6B0@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_73E2C4F6-8DAC-4513-9FCE-2F05F2149FA3";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [syzbot] [ext4?] possible deadlock in ext4_xattr_inode_iget (3)
Date: Mon, 8 Apr 2024 15:38:00 -0600
In-Reply-To: <000000000000163e1406152c6877@google.com>
Cc: Ext4 Developers List <linux-ext4@vger.kernel.org>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 syzkaller-bugs@googlegroups.com,
 Theodore Ts'o <tytso@mit.edu>
To: syzbot <syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com>
References: <000000000000163e1406152c6877@google.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_73E2C4F6-8DAC-4513-9FCE-2F05F2149FA3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


> On Apr 3, 2024, at 1:45 AM, syzbot =
<syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com> wrote:
>=20
> Hello,
>=20
> syzbot found the following issue on:
>=20
> HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of =
git://git.kernel..
> git tree:       upstream
> console+strace: =
https://syzkaller.appspot.com/x/log.txt?x=3D11a1e52d180000
> kernel config:  =
https://syzkaller.appspot.com/x/.config?x=3D1a07d5da4eb21586
> dashboard link: =
https://syzkaller.appspot.com/bug?extid=3Dee72b9a7aad1e5a77c5c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils =
for Debian) 2.40
> syz repro:      =
https://syzkaller.appspot.com/x/repro.syz?x=3D12407f45180000
> C reproducer:   =
https://syzkaller.appspot.com/x/repro.c?x=3D140d9db1180000
>=20
> Downloadable assets:
> disk image: =
https://storage.googleapis.com/syzbot-assets/b42ab0fd4947/disk-fe46a7dd.ra=
w.xz
> vmlinux: =
https://storage.googleapis.com/syzbot-assets/b8a6e7231930/vmlinux-fe46a7dd=
.xz
> kernel image: =
https://storage.googleapis.com/syzbot-assets/4fbf3e4ce6f8/bzImage-fe46a7dd=
.xz
> mounted in repro: =
https://storage.googleapis.com/syzbot-assets/5d293cee060a/mount_0.gz
>=20
> IMPORTANT: if you fix the issue, please add the following tag to the =
commit:
> Reported-by: syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com
>=20
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
> ------------------------------------------------------
> syz-executor545/5275 is trying to acquire lock:
> ffff888077730400 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock =
include/linux/fs.h:793 [inline]
> ffff888077730400 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: =
ext4_xattr_inode_iget+0x173/0x440 fs/ext4/xattr.c:461
>=20
> but task is already holding lock:
> ffff888077730c88 (&ei->i_data_sem/3){++++}-{3:3}, at: =
ext4_setattr+0x1ba0/0x29d0 fs/ext4/inode.c:5417
>=20
> which lock already depends on the new lock.

This seems like a false positive?  There are two different inodes =
involved
in this case - the "real" inode, and the inode holding the xattr.  I =
guess
this needs to be annotated so that lockdep doesn't complain about the =
order.

Cheers, Andreas

>=20
> the existing dependency chain (in reverse order) is:
>=20
> -> #1 (&ei->i_data_sem/3){++++}-{3:3}:
>       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
>       ext4_update_i_disksize fs/ext4/ext4.h:3383 [inline]
>       ext4_xattr_inode_write fs/ext4/xattr.c:1446 [inline]
>       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1594 [inline]
>       ext4_xattr_set_entry+0x3a14/0x3cf0 fs/ext4/xattr.c:1719
>       ext4_xattr_ibody_set+0x126/0x380 fs/ext4/xattr.c:2287
>       ext4_xattr_set_handle+0x98d/0x1480 fs/ext4/xattr.c:2444
>       ext4_xattr_set+0x149/0x380 fs/ext4/xattr.c:2558
>       __vfs_setxattr+0x176/0x1e0 fs/xattr.c:200
>       __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:234
>       __vfs_setxattr_locked+0x182/0x260 fs/xattr.c:295
>       vfs_setxattr+0x146/0x350 fs/xattr.c:321
>       do_setxattr+0x146/0x170 fs/xattr.c:629
>       setxattr+0x15d/0x180 fs/xattr.c:652
>       path_setxattr+0x179/0x1e0 fs/xattr.c:671
>       __do_sys_lsetxattr fs/xattr.c:694 [inline]
>       __se_sys_lsetxattr fs/xattr.c:690 [inline]
>       __x64_sys_lsetxattr+0xc1/0x160 fs/xattr.c:690
>       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>       do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
>       entry_SYSCALL_64_after_hwframe+0x6d/0x75
>=20
> -> #0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
>       check_prev_add kernel/locking/lockdep.c:3134 [inline]
>       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
>       validate_chain kernel/locking/lockdep.c:3869 [inline]
>       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
>       lock_acquire kernel/locking/lockdep.c:5754 [inline]
>       lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
>       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
>       inode_lock include/linux/fs.h:793 [inline]
>       ext4_xattr_inode_iget+0x173/0x440 fs/ext4/xattr.c:461
>       ext4_xattr_inode_get+0x16c/0x870 fs/ext4/xattr.c:535
>       ext4_xattr_move_to_block fs/ext4/xattr.c:2640 [inline]
>       ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
>       ext4_expand_extra_isize_ea+0x1367/0x1ae0 fs/ext4/xattr.c:2834
>       __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:5789
>       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
>       __ext4_mark_inode_dirty+0x55a/0x860 fs/ext4/inode.c:5910
>       ext4_setattr+0x1c14/0x29d0 fs/ext4/inode.c:5420
>       notify_change+0x745/0x11c0 fs/attr.c:497
>       do_truncate+0x15c/0x220 fs/open.c:65
>       handle_truncate fs/namei.c:3300 [inline]
>       do_open fs/namei.c:3646 [inline]
>       path_openat+0x24b9/0x2990 fs/namei.c:3799
>       do_filp_open+0x1dc/0x430 fs/namei.c:3826
>       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
>       do_sys_open fs/open.c:1421 [inline]
>       __do_sys_openat fs/open.c:1437 [inline]
>       __se_sys_openat fs/open.c:1432 [inline]
>       __x64_sys_openat+0x175/0x210 fs/open.c:1432
>       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>       do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
>       entry_SYSCALL_64_after_hwframe+0x6d/0x75
>=20
> other info that might help us debug this:
>=20
> Possible unsafe locking scenario:
>=20
>       CPU0                    CPU1
>       ----                    ----
>  lock(&ei->i_data_sem/3);
>                               lock(&ea_inode->i_rwsem#8/1);
>                               lock(&ei->i_data_sem/3);
>  lock(&ea_inode->i_rwsem#8/1);
>=20
> *** DEADLOCK ***
>=20
> 5 locks held by syz-executor545/5275:
> #0: ffff888022da6420 (sb_writers#4){.+.+}-{0:0}, at: do_open =
fs/namei.c:3635 [inline]
> #0: ffff888022da6420 (sb_writers#4){.+.+}-{0:0}, at: =
path_openat+0x1fba/0x2990 fs/namei.c:3799
> #1: ffff888077730e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: =
inode_lock include/linux/fs.h:793 [inline]
> #1: ffff888077730e00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: =
do_truncate+0x14b/0x220 fs/open.c:63
> #2: ffff888077730fa0 (mapping.invalidate_lock){++++}-{3:3}, at: =
filemap_invalidate_lock include/linux/fs.h:838 [inline]
> #2: ffff888077730fa0 (mapping.invalidate_lock){++++}-{3:3}, at: =
ext4_setattr+0xdfd/0x29d0 fs/ext4/inode.c:5378
> #3: ffff888077730c88 (&ei->i_data_sem/3){++++}-{3:3}, at: =
ext4_setattr+0x1ba0/0x29d0 fs/ext4/inode.c:5417
> #4: ffff888077730ac8 (&ei->xattr_sem){++++}-{3:3}, at: =
ext4_write_trylock_xattr fs/ext4/xattr.h:162 [inline]
> #4: ffff888077730ac8 (&ei->xattr_sem){++++}-{3:3}, at: =
ext4_try_to_expand_extra_isize fs/ext4/inode.c:5829 [inline]
> #4: ffff888077730ac8 (&ei->xattr_sem){++++}-{3:3}, at: =
__ext4_mark_inode_dirty+0x4cf/0x860 fs/ext4/inode.c:5910
>=20
> stack backtrace:
> CPU: 1 PID: 5275 Comm: syz-executor545 Not tainted =
6.8.0-syzkaller-08951-gfe46a7dd189e #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, =
BIOS Google 03/27/2024
> Call Trace:
> <TASK>
> __dump_stack lib/dump_stack.c:88 [inline]
> dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
> check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2187
> check_prev_add kernel/locking/lockdep.c:3134 [inline]
> check_prevs_add kernel/locking/lockdep.c:3253 [inline]
> validate_chain kernel/locking/lockdep.c:3869 [inline]
> __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
> lock_acquire kernel/locking/lockdep.c:5754 [inline]
> lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
> down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
> inode_lock include/linux/fs.h:793 [inline]
> ext4_xattr_inode_iget+0x173/0x440 fs/ext4/xattr.c:461
> ext4_xattr_inode_get+0x16c/0x870 fs/ext4/xattr.c:535
> ext4_xattr_move_to_block fs/ext4/xattr.c:2640 [inline]
> ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
> ext4_expand_extra_isize_ea+0x1367/0x1ae0 fs/ext4/xattr.c:2834
> __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:5789
> ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
> __ext4_mark_inode_dirty+0x55a/0x860 fs/ext4/inode.c:5910
> ext4_setattr+0x1c14/0x29d0 fs/ext4/inode.c:5420
> notify_change+0x745/0x11c0 fs/attr.c:497
> do_truncate+0x15c/0x220 fs/open.c:65
> handle_truncate fs/namei.c:3300 [inline]
> do_open fs/namei.c:3646 [inline]
> path_openat+0x24b9/0x2990 fs/namei.c:3799
> do_filp_open+0x1dc/0x430 fs/namei.c:3826
> do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
> do_sys_open fs/open.c:1421 [inline]
> __do_sys_openat fs/open.c:1437 [inline]
> __se_sys_openat fs/open.c:1432 [inline]
> __x64_sys_openat+0x175/0x210 fs/open.c:1432
> do_syscall_x64 arch/x86/entry/common.c:52 [inline]
> do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
> entry_SYSCALL_64_after_hwframe+0x6d/0x75
> RIP: 0033:0x7fc7c030b2e9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 21 18 00 00 90 48 89 f8 48 =
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d =
01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffc3c4a0608 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
> RAX: ffffffffffffffda RBX: 0031656c69662f2e RCX: 00007fc7c030b2e9
> RDX: 0000000000143362 RSI: 00000000200000c0 RDI: 00000000ffffff9c
> RBP: 6c6c616c65646f6e R08: 00007ffc3c4a0640 R09: 00007ffc3c4a0640
> R10: 000000000a000000 R11: 0000000000000246 R12: 00007ffc3c4a062c
> R13: 0000000000000040 R14: 431bde82d7b634db R15: 00007ffc3c4a0660
> </TASK>
>=20
>=20
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>=20
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>=20
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
>=20
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before =
testing.
>=20
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
>=20
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
>=20
> If you want to undo deduplication, reply with:
> #syz undup


Cheers, Andreas






--Apple-Mail=_73E2C4F6-8DAC-4513-9FCE-2F05F2149FA3
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYUY7gACgkQcqXauRfM
H+DF7xAAsYpF6ta9tyMu7cN5yzDTUDBykRhTN8Z/4YZNxKXG7ckQuMuMqFEZgUYZ
t4sLSwlrfjL/uLwuyfKg/96NZCGpg91XMH1tC8NZEcnl2b5eJ3J2eIAX3QdeQHKl
+/9RtlPrifZnc0QrENCK5Y/dd0HpP8QthxbSnVa5gqBikJntHu1J3Po3cCfUGAPf
cPk3gSYtVIWkhEnhof88lsFsMT3aUdWcl1zjgHVCs2RNyfp7P0t8thLF0Z9R9/KH
6sbE1ZiO6+UIS+ll1B2Hi2PQOwcez4/F7bRZLTd2cvPevjEow8LzlHu7PzB8JsEN
3XLUxTbcIW/wMf0cd4SSWmAf5xSe+epT1GDyqQqAABuigRsEyw8/kC8AMuUOmhje
GoZFuNcfoRymgMS4g19Aq8bpjc2nV29GT8Buw7N/DxmAoMjFjkHpXmwBfPeeH4Yt
HMJuvN74dOxpcKsA1xNSp0diNXGk1aXbW5YA6Fx03wLY6j27yBzny5jjtX6kixek
kzUhnYsnntJe1u9aI4ix+9qw5n2TM2iid/QSn/pGV+uz3RCc6KReZcUg7S7qWwbl
OBQ0AGtsJJpA39QN+e8C2USD0LP/zQwP3Grx04BVNE+UP/Hflrg+yFYr1g2Ifdim
MmAhLoYauEE5GdI2TiQwG7g4ebSJP9xGdhffBhCey5gUb8aFios=
=gtQw
-----END PGP SIGNATURE-----

--Apple-Mail=_73E2C4F6-8DAC-4513-9FCE-2F05F2149FA3--


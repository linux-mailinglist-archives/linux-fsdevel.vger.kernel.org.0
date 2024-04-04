Return-Path: <linux-fsdevel+bounces-16092-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 271F6897D8C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 04:00:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFB54285B2D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 02:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7CC18EB0;
	Thu,  4 Apr 2024 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GTa4dWd4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BBD848A;
	Thu,  4 Apr 2024 02:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712196022; cv=none; b=NnOMEFoFOtkUDbzQW1wjFCQ/eCG3gOnouLU2FXjnJD709wf8MIZfJ9lEK77GTsRhnBv186M+Q9x7dKpgOvJQ64mR2hMSB2b+bgMqu5Eqx2yTvAd6uEUzLpOUYT0GOD1vU0fA3Keu1rl7p4iFtmAQz4jL006z36Z6v36hMsmm+p4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712196022; c=relaxed/simple;
	bh=xerEG+8N8nCTgARu5M7AdqsxFqpZMrwGBzgBaPp1tIA=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=qYNuPSTHcvZPgsRE0D58/D+HwGOMg/OGZSMVmNxXIkF0h6IxOntlqO5yHQBaxPPJ8PAcftK/PeF52btal3na2XJYdvnKv13OuM0uuVwatOVwBStleZV+XJ1DDGXW7yEktQ/JnoTqyrOOJvTXchPVUOFJIGCAHQgd1EEHXuPZbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GTa4dWd4; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712196014; bh=ViSNtgHnCNE5YxBy8AFH6efCU+13yYO35unT+ShIbj0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GTa4dWd4DHmdF4azQgF2ZzHfx3VsY9Z8PuJh0aAu0CPpXWNrTocIGTu4RMrLVgbJr
	 tEVadhEQvahiSqdv8EU++XVC5Jb+9gD09KWyedzKJJH/X4lLIucFamKfgUW05BXL8L
	 6k00hkgzYy/UehGdmNECgo0XZyqaRV5OOUZkJ+xc=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id D821765E; Thu, 04 Apr 2024 09:54:02 +0800
X-QQ-mid: xmsmtpt1712195642t7gfqscp2
Message-ID: <tencent_9E9EB81B474B0E1B23256EBA05BB79332408@qq.com>
X-QQ-XMAILINFO: ORuEwgb9eurkGoRu8Pan7ArhgPYRTS2ypdLfcHiG2dteOZpfVLGmS3l7666+vJ
	 05wDKGTrJ0mqQYfxYPO+FyFSWpZnEo1FBNfynew7OsGQrzhPHaJ1O9NkAIoqoNJNIKx338rVbI96
	 hNkLgnZsK189jpWUzQMmHEsk1n1nwaicPgTY0h4p58T3VhNSrBXxoJL7zvUVu5kMA825iWI3jL5p
	 kQjZ2pjAoiBnXBJVVTRpjC9cITM7DTtrBSTyhRIrP9ttFcOWzDzTaEDk6qFfaryM7ch6svyFfDbl
	 +4/j8BWNRP43wQ0WEp6wtsHj7t2LMvsQLuVdthfkRwwMrEkvv2CUtrolyjyMg6hQMvCv1zmeP/JV
	 UC/IbZE109vuKOpxepqbRIE8FWIRiqZjBNCtyUQgVM1tjcsP/+lPv/dEdQ5Jeal6I+yJG6IZFTXr
	 zi0lJ8el/6dQhK8bC5Jsy9Q6WrbmWCwN5i4jj4zpPsnDral6hN5M0/uly8x1nJJ+4UgKRINN3aIG
	 OJyl7x80W10yzCcqf/x59VL7NmjkvMOtZLVinWPyIy6efSOtP+w2B5QSZLHXfM1C5+U7eu1EQaqo
	 nioYs58qH2jQ0sNMUNBxZ2WEwUVYQ3JOBiKQvGf8u8q53h2Y+KpmRspi1u5gCezGspMNDOgYRbWB
	 cala8kPdRSNkQ6PYba7/B0wszBVRCDtTRe4WeL8qcdrmHPxp9O44094jejzii9Q4ExsRH08Rn0Q/
	 lsYvbC9qr+wJXDMrbbIbdL1RbeXDHV9+C1PPeF/baJduAswzsjzLL1wJHYz3akkUOewcoQl+/dDb
	 X9gT+yg4kBKyQrN4iFmjxlDSecVELiLWYwq5YCEodChYb8A0wKXqWVrckxWzar6hEtygF2QaVSpY
	 yBS4tznlqjQOB5BV7SGejbaHBcJWw1cZmm0zc/hatIk/sYaPqExn+Rzj0n7evb7IiGEBkLmAi7
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	tytso@mit.edu
Subject: [PATCH] ext4: fix deadlock in ext4_xattr_inode_iget
Date: Thu,  4 Apr 2024 09:54:02 +0800
X-OQ-MSGID: <20240404015401.4076261-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000163e1406152c6877@google.com>
References: <000000000000163e1406152c6877@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[Syzbot reported]
WARNING: possible circular locking dependency detected
6.8.0-syzkaller-08951-gfe46a7dd189e #0 Not tainted
------------------------------------------------------
syz-executor545/5275 is trying to acquire lock:
ffff888077730400 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: inode_lock include/linux/fs.h:793 [inline]
ffff888077730400 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}, at: ext4_xattr_inode_iget+0x173/0x440 fs/ext4/xattr.c:461

but task is already holding lock:
ffff888077730c88 (&ei->i_data_sem/3){++++}-{3:3}, at: ext4_setattr+0x1ba0/0x29d0 fs/ext4/inode.c:5417

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&ei->i_data_sem/3){++++}-{3:3}:
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       ext4_update_i_disksize fs/ext4/ext4.h:3383 [inline]
       ext4_xattr_inode_write fs/ext4/xattr.c:1446 [inline]
       ext4_xattr_inode_lookup_create fs/ext4/xattr.c:1594 [inline]
       ext4_xattr_set_entry+0x3a14/0x3cf0 fs/ext4/xattr.c:1719
       ext4_xattr_ibody_set+0x126/0x380 fs/ext4/xattr.c:2287
       ext4_xattr_set_handle+0x98d/0x1480 fs/ext4/xattr.c:2444
       ext4_xattr_set+0x149/0x380 fs/ext4/xattr.c:2558
       __vfs_setxattr+0x176/0x1e0 fs/xattr.c:200
       __vfs_setxattr_noperm+0x127/0x5e0 fs/xattr.c:234
       __vfs_setxattr_locked+0x182/0x260 fs/xattr.c:295
       vfs_setxattr+0x146/0x350 fs/xattr.c:321
       do_setxattr+0x146/0x170 fs/xattr.c:629
       setxattr+0x15d/0x180 fs/xattr.c:652
       path_setxattr+0x179/0x1e0 fs/xattr.c:671
       __do_sys_lsetxattr fs/xattr.c:694 [inline]
       __se_sys_lsetxattr fs/xattr.c:690 [inline]
       __x64_sys_lsetxattr+0xc1/0x160 fs/xattr.c:690
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

-> #0 (&ea_inode->i_rwsem#8/1){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain kernel/locking/lockdep.c:3869 [inline]
       __lock_acquire+0x2478/0x3b30 kernel/locking/lockdep.c:5137
       lock_acquire kernel/locking/lockdep.c:5754 [inline]
       lock_acquire+0x1b1/0x540 kernel/locking/lockdep.c:5719
       down_write+0x3a/0x50 kernel/locking/rwsem.c:1579
       inode_lock include/linux/fs.h:793 [inline]
       ext4_xattr_inode_iget+0x173/0x440 fs/ext4/xattr.c:461
       ext4_xattr_inode_get+0x16c/0x870 fs/ext4/xattr.c:535
       ext4_xattr_move_to_block fs/ext4/xattr.c:2640 [inline]
       ext4_xattr_make_inode_space fs/ext4/xattr.c:2742 [inline]
       ext4_expand_extra_isize_ea+0x1367/0x1ae0 fs/ext4/xattr.c:2834
       __ext4_expand_extra_isize+0x346/0x480 fs/ext4/inode.c:5789
       ext4_try_to_expand_extra_isize fs/ext4/inode.c:5832 [inline]
       __ext4_mark_inode_dirty+0x55a/0x860 fs/ext4/inode.c:5910
       ext4_setattr+0x1c14/0x29d0 fs/ext4/inode.c:5420
       notify_change+0x745/0x11c0 fs/attr.c:497
       do_truncate+0x15c/0x220 fs/open.c:65
       handle_truncate fs/namei.c:3300 [inline]
       do_open fs/namei.c:3646 [inline]
       path_openat+0x24b9/0x2990 fs/namei.c:3799
       do_filp_open+0x1dc/0x430 fs/namei.c:3826
       do_sys_openat2+0x17a/0x1e0 fs/open.c:1406
       do_sys_open fs/open.c:1421 [inline]
       __do_sys_openat fs/open.c:1437 [inline]
       __se_sys_openat fs/open.c:1432 [inline]
       __x64_sys_openat+0x175/0x210 fs/open.c:1432
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xd5/0x260 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x6d/0x75

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&ei->i_data_sem/3);
                               lock(&ea_inode->i_rwsem#8/1);
                               lock(&ei->i_data_sem/3);
  lock(&ea_inode->i_rwsem#8/1);

 *** DEADLOCK ***
[Fix]
According to mark inode dirty context, it does not need to be protected by lock
i_data_sem, and if it is protected by i_data_sem, a deadlock will occur.

Reported-by: syzbot+ee72b9a7aad1e5a77c5c@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 fs/ext4/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 537803250ca9..d2cbe3dddfab 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5417,6 +5417,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			down_write(&EXT4_I(inode)->i_data_sem);
 			old_disksize = EXT4_I(inode)->i_disksize;
 			EXT4_I(inode)->i_disksize = attr->ia_size;
+			up_write(&EXT4_I(inode)->i_data_sem);
 			rc = ext4_mark_inode_dirty(handle, inode);
 			if (!error)
 				error = rc;
@@ -5425,6 +5426,7 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 * with i_disksize to avoid races with writeback code
 			 * running ext4_wb_update_i_disksize().
 			 */
+			down_write(&EXT4_I(inode)->i_data_sem);
 			if (!error)
 				i_size_write(inode, attr->ia_size);
 			else
-- 
2.43.0



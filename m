Return-Path: <linux-fsdevel+bounces-65788-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 109D1C10F25
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 20:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F26151A27E71
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 19:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE4A202963;
	Mon, 27 Oct 2025 19:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ea0gW6JP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776622D8377;
	Mon, 27 Oct 2025 19:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761592870; cv=none; b=P0Ks3LL2mkeaE7kiraB4t7aFat2Zd0kvoRvRA6ILlAsTZf/iuNImbQQmrPV/8sg299uQsNGNPG5mhDvL7uX/GUulvlJFPSiuUipTp/a6xFP8+a0Hhzrp5/G4euX5MfM597drkYsIkkaG1dGc4brO7jb5Rzt31p1LVajamSwCCus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761592870; c=relaxed/simple;
	bh=xeMObYoLgmoFSY4R0nHyIOsoq7aiRB2pRxIiALWll34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NmGuklKPVvEXl/9FixYfJrvHwe8d6cKPAo+2NuQygbqgLgZ5Q17Kq7uaWqOzXTMbwTL2xb4xinJAhBryByBMoqVdrLiIbyF7vzDMYzHZYQDv9Al58qL8brvFZJZYjVkuqad8M1iGeEWYoX+E+GdYzXnzD8+ZcfofSEQXDWd+miQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ea0gW6JP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE2B4C4CEFD;
	Mon, 27 Oct 2025 19:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1761592870;
	bh=xeMObYoLgmoFSY4R0nHyIOsoq7aiRB2pRxIiALWll34=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ea0gW6JPy7jsbSnzpWdfB6KmS6xvNGKkkkTxqGxGsWBy9wV/QU5igZev7weMqgawK
	 sVZoZX8gcifmsIg/LqR0/ya5A5HigD8NF1qmP/DfIZEwAfIhPS8uYg8+Zm9pnVuXaG
	 LL1dJD0J4A1XNA/JnjxFr9aUySj7S5VzU6DXW88k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jakub Acs <acsjakub@amazon.de>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 6.12 044/117] fs/notify: call exportfs_encode_fid with s_umount
Date: Mon, 27 Oct 2025 19:36:10 +0100
Message-ID: <20251027183455.182140414@linuxfoundation.org>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251027183453.919157109@linuxfoundation.org>
References: <20251027183453.919157109@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jakub Acs <acsjakub@amazon.de>

commit a7c4bb43bfdc2b9f06ee9d036028ed13a83df42a upstream.

Calling intotify_show_fdinfo() on fd watching an overlayfs inode, while
the overlayfs is being unmounted, can lead to dereferencing NULL ptr.

This issue was found by syzkaller.

Race Condition Diagram:

Thread 1                           Thread 2
--------                           --------

generic_shutdown_super()
 shrink_dcache_for_umount
  sb->s_root = NULL

                    |
                    |             vfs_read()
                    |              inotify_fdinfo()
                    |               * inode get from mark *
                    |               show_mark_fhandle(m, inode)
                    |                exportfs_encode_fid(inode, ..)
                    |                 ovl_encode_fh(inode, ..)
                    |                  ovl_check_encode_origin(inode)
                    |                   * deref i_sb->s_root *
                    |
                    |
                    v
 fsnotify_sb_delete(sb)

Which then leads to:

[   32.133461] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN NOPTI
[   32.134438] KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
[   32.135032] CPU: 1 UID: 0 PID: 4468 Comm: systemd-coredum Not tainted 6.17.0-rc6 #22 PREEMPT(none)

<snip registers, unreliable trace>

[   32.143353] Call Trace:
[   32.143732]  ovl_encode_fh+0xd5/0x170
[   32.144031]  exportfs_encode_inode_fh+0x12f/0x300
[   32.144425]  show_mark_fhandle+0xbe/0x1f0
[   32.145805]  inotify_fdinfo+0x226/0x2d0
[   32.146442]  inotify_show_fdinfo+0x1c5/0x350
[   32.147168]  seq_show+0x530/0x6f0
[   32.147449]  seq_read_iter+0x503/0x12a0
[   32.148419]  seq_read+0x31f/0x410
[   32.150714]  vfs_read+0x1f0/0x9e0
[   32.152297]  ksys_read+0x125/0x240

IOW ovl_check_encode_origin derefs inode->i_sb->s_root, after it was set
to NULL in the unmount path.

Fix it by protecting calling exportfs_encode_fid() from
show_mark_fhandle() with s_umount lock.

This form of fix was suggested by Amir in [1].

[1]: https://lore.kernel.org/all/CAOQ4uxhbDwhb+2Brs1UdkoF0a3NSdBAOQPNfEHjahrgoKJpLEw@mail.gmail.com/

Fixes: c45beebfde34 ("ovl: support encoding fid from inode with no alias")
Signed-off-by: Jakub Acs <acsjakub@amazon.de>
Cc: Jan Kara <jack@suse.cz>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Christian Brauner <brauner@kernel.org>
Cc: linux-unionfs@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/notify/fdinfo.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -17,6 +17,7 @@
 #include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
+#include "../internal.h"
 
 #if defined(CONFIG_PROC_FS)
 
@@ -46,7 +47,12 @@ static void show_mark_fhandle(struct seq
 
 	size = f->handle_bytes >> 2;
 
+	if (!super_trylock_shared(inode->i_sb))
+		return;
+
 	ret = exportfs_encode_fid(inode, (struct fid *)f->f_handle, &size);
+	up_read(&inode->i_sb->s_umount);
+
 	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
 




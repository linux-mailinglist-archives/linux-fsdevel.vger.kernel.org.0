Return-Path: <linux-fsdevel+bounces-65641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68538C0AD1C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 17:05:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C1FE18A15A8
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 Oct 2025 16:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4F4214228;
	Sun, 26 Oct 2025 16:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cVtW0NKe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD845C0B;
	Sun, 26 Oct 2025 16:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761494701; cv=none; b=CSr62wCUTNzU7FYBZXTDeANpTmpY1xH5PERbSFVWgeTgqLTIVNEJzYS9m8VKdPC7lCMc455x7xDpFWwVVGOw85kd2AW083gsIHQmrb4K+BU3sbx2Xir3Fi6PjMRKDUEN0jnI5YYUdbHnx+SI5rg42+JNnXDRIfBbb1axXnla1Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761494701; c=relaxed/simple;
	bh=l7JPkliu+UAJY5jgLqKO+0m/pMNLoNR87mNscuCPqhU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZVwcl7R94FKOADTOEJA3xYIi0iTV1FVp53wNOj+nR8gi6xZosseAearHn922EbTmWdWiuEzLGH+3W07aNhFdpZOO8TzTYJ92RlPVeprzIfnA4yuhYl7I99lUj8JB9+0FC67ZUfLhiBM9cilI4f6P74edLoysu1CiUAVVoO3jy0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cVtW0NKe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D019DC4CEE7;
	Sun, 26 Oct 2025 16:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761494700;
	bh=l7JPkliu+UAJY5jgLqKO+0m/pMNLoNR87mNscuCPqhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cVtW0NKeE9+CKIn2dxUtvyxQTcVBo2OzidnfN8htCwbPWpSB1XMuemJIcPEWAZM3b
	 bRe0TG/rWB1cLfzjIjYD7wZyRZgR9Fj1c1uNFQWRKnPag6j7Qwwf82h7YJAdDWJ6Ab
	 yxGHmGJ/pgobJEX/BFUsh2wqo8YGQp9I1nmjS6uNsNwj2U6RrUcwrnOgONCRvKIi2P
	 Usva7N/bsQXopbVKo5FzJ1xPU5ROegU21mq6V4hmzKXq3VLFFYJMlSnQ8aIDZN43HX
	 q9IlwrPhYYIw8UXDnyYDB/kXwzR87H2UCv5D2+wro75USR+JwwtiKs1JGhIuxfJnu1
	 EovmCwQVFBcBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jakub Acs <acsjakub@amazon.de>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Christian Brauner <brauner@kernel.org>,
	linux-unionfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] fs/notify: call exportfs_encode_fid with s_umount
Date: Sun, 26 Oct 2025 12:04:56 -0400
Message-ID: <20251026160456.99836-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025102612-kissing-atrocious-4949@gregkh>
References: <2025102612-kissing-atrocious-4949@gregkh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jakub Acs <acsjakub@amazon.de>

[ Upstream commit a7c4bb43bfdc2b9f06ee9d036028ed13a83df42a ]

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
[ Adjust context ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/notify/fdinfo.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/notify/fdinfo.c b/fs/notify/fdinfo.c
index 26655572975d3..1aa7de55094cd 100644
--- a/fs/notify/fdinfo.c
+++ b/fs/notify/fdinfo.c
@@ -17,6 +17,7 @@
 #include "fanotify/fanotify.h"
 #include "fdinfo.h"
 #include "fsnotify.h"
+#include "../internal.h"
 
 #if defined(CONFIG_PROC_FS)
 
@@ -50,7 +51,12 @@ static void show_mark_fhandle(struct seq_file *m, struct inode *inode)
 	f.handle.handle_bytes = sizeof(f.pad);
 	size = f.handle.handle_bytes >> 2;
 
+	if (!super_trylock_shared(inode->i_sb))
+		return;
+
 	ret = exportfs_encode_fid(inode, (struct fid *)f.handle.f_handle, &size);
+	up_read(&inode->i_sb->s_umount);
+
 	if ((ret == FILEID_INVALID) || (ret < 0))
 		return;
 
-- 
2.51.0



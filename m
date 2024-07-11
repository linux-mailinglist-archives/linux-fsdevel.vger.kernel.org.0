Return-Path: <linux-fsdevel+bounces-23544-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDF092E0E5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 09:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02F8B227A5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jul 2024 07:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CBCD14B077;
	Thu, 11 Jul 2024 07:32:48 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29C284DFF;
	Thu, 11 Jul 2024 07:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720683167; cv=none; b=rLxSTQ8OvcuC2O24k1O+YhA49UGp6Fb/v8r5j4Z6qoN/bbz5VbPNm3PTQd2phZxAbq0V4GkT3QKUhnuQQIi2yVo7coOT2g6ZL/8hRUkwdAH3PuoAJslQRinmCRxdXmmG5lTJjvbeBDrG1x2Ehn+f50fU20DBalO2LY1UeNKSMcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720683167; c=relaxed/simple;
	bh=/23hgjDbKqVhjagfAAqkPbHRMJhRBbfHbSrh29obScA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iAw+xVe7+dfaIYuiIqsGMY+e1sNVBjKNHdTTUAvYuypw71EloePpJHd3cfhWjSbeQcEV4PP7CGG52WNqwubEhqGOWMtJB9fyZtE2+3A9OkmB1i9YiZdiP3ORFVShAynlCWwEgHgobB0mZAAWvWy2+tzRWC8SJFaw0I3gz4u4Zxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id E18472F20251; Thu, 11 Jul 2024 07:32:42 +0000 (UTC)
X-Spam-Level: 
Received: from localhost.localdomain (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 2A3F52F20251;
	Thu, 11 Jul 2024 07:32:42 +0000 (UTC)
From: kovalev@altlinux.org
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aivazian.tigran@gmail.com,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	Markus.Elfring@web.de,
	syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Subject: [PATCHv2 fs/bfs 1/2] bfs: prevent null pointer dereference in bfs_move_block()
Date: Thu, 11 Jul 2024 10:32:37 +0300
Message-Id: <20240711073238.44399-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240711073238.44399-1-kovalev@altlinux.org>
References: <20240711073238.44399-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

Detect a failed sb_getblk() call (before copying data)
so that null pointer dereferences should not happen any more.

Found by Syzkaller:

KASAN: null-ptr-deref in range [0x0000000000000028-0x000000000000002f]
CPU: 1 PID: 1069 Comm: mark_buffer_dir Tainted: G W 6.10.0-un-def-alt0.rc7
RIP: 0010:bfs_get_block+0x3ab/0xe80 [bfs]
Call Trace:
<TASK>
? show_regs+0x8d/0xa0
? die_addr+0x50/0xd0
? exc_general_protection+0x148/0x220
? asm_exc_general_protection+0x22/0x30
? bfs_get_block+0x3ab/0xe80 [bfs]
? bfs_get_block+0x370/0xe80 [bfs]
? __pfx_bfs_get_block+0x10/0x10 [bfs]
__block_write_begin_int+0x4ae/0x16a0
? __pfx_bfs_get_block+0x10/0x10 [bfs]
? __pfx___block_write_begin_int+0x10/0x10
block_write_begin+0xb5/0x410
? __pfx_bfs_get_block+0x10/0x10 [bfs]
bfs_write_begin+0x32/0xe0 [bfs]
generic_perform_write+0x265/0x610
? __pfx_generic_perform_write+0x10/0x10
? generic_write_checks+0x323/0x4a0
? __pfx_generic_file_write_iter+0x10/0x10
__generic_file_write_iter+0x16a/0x1b0
generic_file_write_iter+0xf0/0x360
? __pfx_generic_file_write_iter+0x10/0x10
vfs_write+0x670/0x1120
? __pfx_vfs_write+0x10/0x10
ksys_write+0x127/0x260
? __pfx_ksys_write+0x10/0x10
do_syscall_64+0x9f/0x190
? __ct_user_enter+0x74/0xc0
? syscall_exit_to_user_mode+0xbb/0x1d0
? do_syscall_64+0xab/0x190
? ct_kernel_exit.isra.0+0xbb/0xe0
? __ct_user_enter+0x74/0xc0
? syscall_exit_to_user_mode+0xbb/0x1d0
? do_syscall_64+0xab/0x190
? ct_kernel_exit.isra.0+0xbb/0xe0
? clear_bhb_loop+0x45/0xa0
? clear_bhb_loop+0x45/0xa0
? clear_bhb_loop+0x45/0xa0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f2bc708ed29

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/bfs/file.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 0dceefc54b48a..e99dc8ace2027 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -34,16 +34,22 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 					struct super_block *sb)
 {
 	struct buffer_head *bh, *new;
+	int ret = 0;
 
 	bh = sb_bread(sb, from);
 	if (!bh)
 		return -EIO;
 	new = sb_getblk(sb, to);
+	if (unlikely(!new)) {
+		ret = -EIO;
+		goto out_err_new;
+	}
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
-	bforget(bh);
 	brelse(new);
-	return 0;
+out_err_new:
+	bforget(bh);
+	return ret;
 }
 
 static int bfs_move_blocks(struct super_block *sb, unsigned long start,
-- 
2.33.8



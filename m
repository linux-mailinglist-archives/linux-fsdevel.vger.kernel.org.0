Return-Path: <linux-fsdevel+bounces-23516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3F092D8CE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 21:12:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE2251F252EB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 19:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05455198857;
	Wed, 10 Jul 2024 19:11:34 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31337197555;
	Wed, 10 Jul 2024 19:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638693; cv=none; b=rWrYq/C/+TGTgBtlAVnnfNs8wHoC8Od9tkU5ChxqMp6KnXNJCexhdNU7XaJgQUfsHLKxRH6pbXtbDh0T9dOF+tsp3M8cQbig38VDlT03raDBRACtrdy+FTg7hPuBUtmc2uawEEpRfpvleYYHt1HbLxc1VnPsSEcAeA/7FRuR5EE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638693; c=relaxed/simple;
	bh=iCjKR+0uwApwwANBuPIhL5yiGAH7VAahKd4jV41id60=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=syCLFQLkQqPFWb1MC1Ip4vCQev5+ydnXp1AlXww9EU6t2fpRbnl2FFycOhxxcoTiMkOO0QyR3qzbtE2/eueFlLkN8DgWlKiYmR1YMsGyZEZibfqeZpfwLddwfbRa66JsuJCZNnTjL0Bs8FgfDbiI8XlKIJK3U9WlMdNp02H35Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 1978F2F2025C; Wed, 10 Jul 2024 19:11:23 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 33EC32F20250;
	Wed, 10 Jul 2024 19:11:22 +0000 (UTC)
From: kovalev@altlinux.org
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aivazian.tigran@gmail.com,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Subject: [PATCH fs/bfs 1/2] bfs: fix null-ptr-deref in bfs_move_block
Date: Wed, 10 Jul 2024 22:11:17 +0300
Message-Id: <20240710191118.40431-2-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240710191118.40431-1-kovalev@altlinux.org>
References: <20240710191118.40431-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

Add a check to ensure 'sb_getblk' did not return NULL before copying data.

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
index a778411574a96b..cb41ca2a2854e4 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -35,16 +35,22 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 					struct super_block *sb)
 {
 	struct buffer_head *bh, *new;
+	int err;
 
 	bh = sb_bread(sb, from);
 	if (!bh)
 		return -EIO;
 	new = sb_getblk(sb, to);
+	if (unlikely(!new)) {
+		err = -EIO;
+		goto out_err_new;
+	}
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
-	bforget(bh);
 	brelse(new);
-	return 0;
+out_err_new:
+	bforget(bh);
+	return err;
 }
 
 static int bfs_move_blocks(struct super_block *sb, unsigned long start,
-- 
2.33.8



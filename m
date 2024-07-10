Return-Path: <linux-fsdevel+bounces-23514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C318692D8CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 21:11:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AEC2B23FCE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Jul 2024 19:11:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16239197A90;
	Wed, 10 Jul 2024 19:11:33 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488401EB2B;
	Wed, 10 Jul 2024 19:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638692; cv=none; b=fxKI4RGtQMYjkyZvGuiQI/rxbmhKZvxf+aLKCPR/VJyCpvxTy2EUCjpd1v5MQtUfa3Ig7VF5ZEDkDk35zVehMMCJK14I74JGDe1L/NQKn0N23kzhFSBVh4E5oQi+QrjF52XrFZ6PSz0qXkiekEWhU+Q9a375R2nlhzybEnNg/yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638692; c=relaxed/simple;
	bh=acT33HyP5ZKEMhoZCgsT32Rn7WpTC0aKocaNoafKgF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UESnMkFw1OhI9OgEp7EI8CJWbh0e6FjkXAlRyIMdaWBSscmkTD+BPkK2wI8nAjFrLG3b/EUZejUPvu0NJjFvqJpRrX8ZlbO6SccYFttKydcxLUVK4qCNg0NcWJFP9UqOOtv46uA+Mk0EkNSt91uq8U99cKFtDrMzfHhamRcKgbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 3F4682F20259; Wed, 10 Jul 2024 19:11:28 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	by air.basealt.ru (Postfix) with ESMTPSA id 462352F20250;
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
Subject: [PATCH fs/bfs 2/2] bfs: add buffer_uptodate check before mark_buffer_dirty call
Date: Wed, 10 Jul 2024 22:11:18 +0300
Message-Id: <20240710191118.40431-3-kovalev@altlinux.org>
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

Add a check in bfs_move_block to ensure the new buffer is up-to-date
(buffer_uptodate) before calling mark_buffer_dirty.

Found by Syzkaller:

WARNING: CPU: 1 PID: 1046 at fs/buffer.c:1183 mark_buffer_dirty+0x394/0x3f0
CPU: 1 PID: 1046 Comm: mark_buffer_dir Not tainted 6.10.0-un-def-alt0.rc7.kasan
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-alt1 04/01/2014
RIP: 0010:mark_buffer_dirty+0x394/0x3f0
Call Trace:
<TASK>
? show_regs+0x8d/0xa0
? __warn+0xe6/0x380
? mark_buffer_dirty+0x394/0x3f0
? report_bug+0x348/0x480
? handle_bug+0x60/0xc0
? exc_invalid_op+0x13/0x50
? asm_exc_invalid_op+0x16/0x20
? mark_buffer_dirty+0x394/0x3f0
? mark_buffer_dirty+0x394/0x3f0
bfs_get_block+0x3ec/0xe80 [bfs]
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
? do_syscall_64+0xab/0x190
? syscall_exit_to_user_mode+0xbb/0x1d0
? do_syscall_64+0xab/0x190
? lock_release+0x241/0x730
? __ct_user_enter+0xb3/0xc0
? __pfx_lock_release+0x10/0x10
? get_vtime_delta+0x116/0x270
? ct_kernel_exit.isra.0+0xbb/0xe0
? __ct_user_enter+0x74/0xc0
? syscall_exit_to_user_mode+0xbb/0x1d0
? do_syscall_64+0xab/0x190
? do_syscall_64+0xab/0x190
? ct_kernel_exit.isra.0+0xbb/0xe0
? clear_bhb_loop+0x45/0xa0
? clear_bhb_loop+0x45/0xa0
? clear_bhb_loop+0x45/0xa0
entry_SYSCALL_64_after_hwframe+0x76/0x7e
RIP: 0033:0x7f5bb79a4d2

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/bfs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index cb41ca2a2854e4..da91af8f41e097 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -45,8 +45,13 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 		err = -EIO;
 		goto out_err_new;
 	}
+	if (!buffer_uptodate(new)) {
+		err = -EIO;
+		goto out_err;
+	}
 	memcpy(new->b_data, bh->b_data, bh->b_size);
 	mark_buffer_dirty(new);
+out_err:
 	brelse(new);
 out_err_new:
 	bforget(bh);
-- 
2.33.8



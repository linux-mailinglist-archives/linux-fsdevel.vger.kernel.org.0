Return-Path: <linux-fsdevel+bounces-26810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D5E95BBAC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 18:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23BEF28A4EC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 16:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984731CDA06;
	Thu, 22 Aug 2024 16:19:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C54F4206E;
	Thu, 22 Aug 2024 16:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724343578; cv=none; b=kY8DglZJCEAlwt2ET/PoQeRzV9WKzIFeAECpErEpfDYna/jb2mUs696tK1ShdH0NMg524QCtYsiTnDyBqQlhzAb3FkcjaN+UhHtUXxkcOE1VM0h2lALQ0vAQH/F7HgyG+LUR17bxo0ygqYmwyYND4YtjcddAJ+gtOs/zu4Gk4NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724343578; c=relaxed/simple;
	bh=dxPZv2Aio0a3aAwHBW4baonIUHBW0jWQCPIJdVeW6xk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UWT3dMaFgPePRW4XP4Zf1ecE5n/HN2UJJE12uAHvTGry9aFvUrvjZr+W2XyI82CoCdbfOUW2QC0Jhj1h9ojaDUf6mi5Zdox/RKsdu0hKuZWOd2K4ULHWLSNOAiudIMTK4nKQO03plJoeR4aJFY+pDvGeCxaK2DPCn7FkzesMeAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: by air.basealt.ru (Postfix, from userid 490)
	id 7C8062F2024C; Thu, 22 Aug 2024 16:12:23 +0000 (UTC)
X-Spam-Level: 
Received: from altlinux.malta.altlinux.ru (obninsk.basealt.ru [217.15.195.17])
	by air.basealt.ru (Postfix) with ESMTPSA id 331562F2024D;
	Thu, 22 Aug 2024 16:12:23 +0000 (UTC)
From: kovalev@altlinux.org
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aivazian.tigran@gmail.com,
	stable@vger.kernel.org
Cc: lvc-patches@linuxtesting.org,
	dutyrok@altlinux.org,
	kovalev@altlinux.org,
	syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Subject: [PATCH v3 2/2] bfs: ensure buffer is marked uptodate before marking it dirty
Date: Thu, 22 Aug 2024 19:12:19 +0300
Message-Id: <20240822161219.459054-3-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
In-Reply-To: <20240822161219.459054-1-kovalev@altlinux.org>
References: <20240822161219.459054-1-kovalev@altlinux.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vasiliy Kovalev <kovalev@altlinux.org>

Add a call to `set_buffer_uptodate(new)` in `bfs_move_block` before
marking the buffer as dirty. This change ensures the buffer is correctly
flagged as containing valid data after copying, preventing potential data
inconsistencies or corruption during writeback.

Found by Syzkaller:

WARNING: CPU: 1 PID: 5055 at fs/buffer.c:1176 mark_buffer_dirty+0x37b/0x3f0 fs/buffer.c:1176
Modules linked in:
CPU: 1 PID: 5055 Comm: syz-executor162 Not tainted 6.8.0-rc1-syzkaller-00049-g6098d87eaf31 #0
Hardware name: Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:mark_buffer_dirty+0x37b/0x3f0 fs/buffer.c:1176
Call Trace:

 bfs_move_block fs/bfs/file.c:44 [inline]
 bfs_move_blocks fs/bfs/file.c:57 [inline]
 bfs_get_block+0x3e5/0xeb0 fs/bfs/file.c:126
 __block_write_begin_int+0x4fb/0x16e0 fs/buffer.c:2103
 __block_write_begin fs/buffer.c:2152 [inline]
 block_write_begin+0xb1/0x490 fs/buffer.c:2211
 bfs_write_begin+0x31/0xd0 fs/bfs/file.c:179
 generic_perform_write+0x278/0x600 mm/filemap.c:3930
 __generic_file_write_iter+0x1f9/0x240 mm/filemap.c:4025
 generic_file_write_iter+0xe3/0x350 mm/filemap.c:4051
 call_write_iter include/linux/fs.h:2085 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6d5/0x1100 fs/read_write.c:590
 ksys_write+0x12f/0x250 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xd3/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: syzbot+d98fd19acd08b36ff422@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d98fd19acd08b36ff422
Cc: stable@vger.kernel.org
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 fs/bfs/file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/bfs/file.c b/fs/bfs/file.c
index 23773e62994024..3f0c506584560e 100644
--- a/fs/bfs/file.c
+++ b/fs/bfs/file.c
@@ -44,6 +44,7 @@ static int bfs_move_block(unsigned long from, unsigned long to,
 		return -EIO;
 	}
 	memcpy(new->b_data, bh->b_data, bh->b_size);
+	set_buffer_uptodate(new);
 	mark_buffer_dirty(new);
 	bforget(bh);
 	brelse(new);
-- 
2.33.8



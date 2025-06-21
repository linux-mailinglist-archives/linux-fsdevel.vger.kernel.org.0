Return-Path: <linux-fsdevel+bounces-52380-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ACABBAE2A77
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 19:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C7E33B99F2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Jun 2025 17:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D663A1D6DB9;
	Sat, 21 Jun 2025 17:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="oaXgOkPA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1427F23774;
	Sat, 21 Jun 2025 17:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750526160; cv=none; b=oH8K8bmqFbKnl+AoQP/uCRx84TXSxk/97jWvh9tRG2GU6gJJSUqOwk96zJZTz+Ci2NJp1q3s5LRCmcngDsrbUsTvvvDdLzwD6xKrnTTHGEf29JTBGVr41BNCS4I2KFUgBzmf6aHFbX8WmK3pojwCsrIRxvQfTHNrcIlt3bZ+V48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750526160; c=relaxed/simple;
	bh=Mp1+rOXGv2rJw4OpimMo2D0L5w8oPmSBucuZSeNNowU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hRkPjjottrr+XkyN6VBdqgcNFN0rT7tK8mPdfZNdYBROPYdPhwTGpNpkL6imJOxowtnIBs2aMGHoKyVX7rlAlk0mE+ClyOy5FsKAZFR38i8EowS3ndW4rOrIRKNc8QdHCnqUT81ls6wGc0Y4aQ75c4iAWAKq3h8QSsD7aoLGbQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=oaXgOkPA; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=3x
	NFDTVICOmQII4bpxC9EylMmJp+OdhmQkqvvlvB3sI=; b=oaXgOkPABowmc3wQTU
	8YNokkfZjhb5BUu7P/eqfjHdkKeyamOuyUiGOa/cNN3/J9IPg3BL87Inb97NlVzF
	BYIp5WtNUm2cqd5xiu7nDv3Q0Y+b+ENvSkJNhyi2YOF5miNw7awbemNtyqSTSldy
	Ve95sNvU8m/3eMlDmS92q5yoY=
Received: from ThinkBook-14.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAHZEWw6FZoUNUDBA--.9633S2;
	Sun, 22 Jun 2025 01:15:29 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: Alistair Popple <apopple@nvidia.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Dan Williams <dan.j.williams@intel.com>,
	linux-fsdevel@vger.kernel.org (open list:FUSE: FILESYSTEM IN USERSPACE),
	linux-kernel@vger.kernel.org (open list)
Cc: Haiyue Wang <haiyuewa@163.com>
Subject: [PATCH v3] fuse: Fix runtime warning on truncate_folio_batch_exceptionals()
Date: Sun, 22 Jun 2025 01:13:51 +0800
Message-ID: <20250621171507.3770-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAHZEWw6FZoUNUDBA--.9633S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZFWUArW5Zw1UAw1fCw1xXwb_yoWrKF4rpF
	yYyF1UGr48Wr1UJr18A3WUtr1FvayDAF4UXr4xAr18tF17uw1DXr1qkr48KF98Jr1xX39r
	trnrXw4vqryxXaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zieT5dUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiYBBya2hUqsLhZQABs4

The WARN_ON_ONCE is introduced on truncate_folio_batch_exceptionals() to
capture whether the filesystem has removed all DAX entries or not.

And the fix has been applied on the filesystem xfs and ext4 by the
commit 0e2f80afcfa6 ("fs/dax: ensure all pages are idle prior to filesystem unmount").

Apply the missed fix on filesystem fuse to fix the runtime warning:

[    2.011450] ------------[ cut here ]------------
[    2.011873] WARNING: CPU: 0 PID: 145 at mm/truncate.c:89 truncate_folio_batch_exceptionals+0x272/0x2b0
[    2.012468] Modules linked in:
[    2.012718] CPU: 0 UID: 1000 PID: 145 Comm: weston Not tainted 6.16.0-rc2-WSL2-STABLE #2 PREEMPT(undef)
[    2.013292] RIP: 0010:truncate_folio_batch_exceptionals+0x272/0x2b0
[    2.013704] Code: 48 63 d0 41 29 c5 48 8d 1c d5 00 00 00 00 4e 8d 6c 2a 01 49 c1 e5 03 eb 09 48 83 c3 08 49 39 dd 74 83 41 f6 44 1c 08 01 74 ef <0f> 0b 49 8b 34 1e 48 89 ef e8 10 a2 17 00 eb df 48 8b 7d 00 e8 35
[    2.014845] RSP: 0018:ffffa47ec33f3b10 EFLAGS: 00010202
[    2.015279] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    2.015884] RDX: 0000000000000000 RSI: ffffa47ec33f3ca0 RDI: ffff98aa44f3fa80
[    2.016377] RBP: ffff98aa44f3fbf0 R08: ffffa47ec33f3ba8 R09: 0000000000000000
[    2.016942] R10: 0000000000000001 R11: 0000000000000000 R12: ffffa47ec33f3ca0
[    2.017437] R13: 0000000000000008 R14: ffffa47ec33f3ba8 R15: 0000000000000000
[    2.017972] FS:  000079ce006afa40(0000) GS:ffff98aade441000(0000) knlGS:0000000000000000
[    2.018510] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    2.018987] CR2: 000079ce03e74000 CR3: 000000010784f006 CR4: 0000000000372eb0
[    2.019518] Call Trace:
[    2.019729]  <TASK>
[    2.019901]  truncate_inode_pages_range+0xd8/0x400
[    2.020280]  ? timerqueue_add+0x66/0xb0
[    2.020574]  ? get_nohz_timer_target+0x2a/0x140
[    2.020904]  ? timerqueue_add+0x66/0xb0
[    2.021231]  ? timerqueue_del+0x2e/0x50
[    2.021646]  ? __remove_hrtimer+0x39/0x90
[    2.022017]  ? srso_alias_untrain_ret+0x1/0x10
[    2.022497]  ? psi_group_change+0x136/0x350
[    2.023046]  ? _raw_spin_unlock+0xe/0x30
[    2.023514]  ? finish_task_switch.isra.0+0x8d/0x280
[    2.024068]  ? __schedule+0x532/0xbd0
[    2.024551]  fuse_evict_inode+0x29/0x190
[    2.025131]  evict+0x100/0x270
[    2.025641]  ? _atomic_dec_and_lock+0x39/0x50
[    2.026316]  ? __pfx_generic_delete_inode+0x10/0x10
[    2.026843]  __dentry_kill+0x71/0x180
[    2.027335]  dput+0xeb/0x1b0
[    2.027725]  __fput+0x136/0x2b0
[    2.028054]  __x64_sys_close+0x3d/0x80
[    2.028469]  do_syscall_64+0x6d/0x1b0
[    2.028832]  ? clear_bhb_loop+0x30/0x80
[    2.029182]  ? clear_bhb_loop+0x30/0x80
[    2.029533]  ? clear_bhb_loop+0x30/0x80
[    2.029902]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    2.030423] RIP: 0033:0x79ce03d0d067
[    2.030820] Code: b8 ff ff ff ff e9 3e ff ff ff 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 c3 a7 f8 ff
[    2.032354] RSP: 002b:00007ffef0498948 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[    2.032939] RAX: ffffffffffffffda RBX: 00007ffef0498960 RCX: 000079ce03d0d067
[    2.033612] RDX: 0000000000000003 RSI: 0000000000001000 RDI: 000000000000000d
[    2.034289] RBP: 00007ffef0498a30 R08: 000000000000000d R09: 0000000000000000
[    2.034944] R10: 00007ffef0498978 R11: 0000000000000246 R12: 0000000000000001
[    2.035610] R13: 00007ffef0498960 R14: 000079ce03e09ce0 R15: 0000000000000003
[    2.036301]  </TASK>
[    2.036532] ---[ end trace 0000000000000000 ]---

Fixes: bde708f1a65d ("fs/dax: always remove DAX page-cache entries when breaking layouts")

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
v3:
  - Rewrite the commit message to make things clean
v2: https://lore.kernel.org/linux-fsdevel/20250608042418.358-1-haiyuewa@163.com/
  - Use 'FUSE_IS_DAX()' to control DAX checking
v1: https://lore.kernel.org/linux-fsdevel/20250604142251.2426-1-haiyuewa@163.com/
---
 fs/fuse/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bfe8d8af46f3..9572bdef49ee 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -9,6 +9,7 @@
 #include "fuse_i.h"
 #include "dev_uring_i.h"
 
+#include <linux/dax.h>
 #include <linux/pagemap.h>
 #include <linux/slab.h>
 #include <linux/file.h>
@@ -162,6 +163,9 @@ static void fuse_evict_inode(struct inode *inode)
 	/* Will write inode on close/munmap and in all other dirtiers */
 	WARN_ON(inode->i_state & I_DIRTY_INODE);
 
+	if (FUSE_IS_DAX(inode))
+		dax_break_layout_final(inode);
+
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
-- 
2.49.0



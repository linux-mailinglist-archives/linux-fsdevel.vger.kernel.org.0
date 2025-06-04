Return-Path: <linux-fsdevel+bounces-50616-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20914ACE035
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 16:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70497189A732
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA68628FFDE;
	Wed,  4 Jun 2025 14:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="QnuKjDkE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A36824B26;
	Wed,  4 Jun 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749047003; cv=none; b=IAsHGuoCck/VhtuKZXFePJhtozNFSukrEI0Z+T00QOvYhriR7S61t66wlQu4+CQ9opp7nVTrL8E9kKMz0wSDR7jN6VE211GXzAEb0zWpVhpjZgCC1+fQE4ZaqBsoBEzbplU3MCTCrunr0fVjq542H2XCS23jzn6+NJNI0ljiKuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749047003; c=relaxed/simple;
	bh=MDkX1Sqi5J1QcmBOq4GZ0qQaDD6qOGoaWcifw/EI+Do=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZJmeA0o/9LnGBFdPIS7vBY3LBucx+VuImJHdxsAjFMcXrcZdpS5WTV9wXzZ8lhCWYLGb+gk6xLaB2UD+nLgfQRx0OMz/QGQcRz45JmlvCOqt2rqcM5IBT1nOXOqrz/cjrv318jgbkTP2MtA0CmnBuneLrOc7K5XOtTJ0SFASMWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=QnuKjDkE; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=dN
	Z/a8tbXf4DBa1ZYWDgiUOhFwpf+JyNU7c9G/Mo10U=; b=QnuKjDkEIAI9WulC16
	RPqeobB14LDoN7AVJ6hNGc1E864d4MZ/IRmILSPd+s9g6GcPK0jMoCMJtQrmbOkc
	YSMJJwJdqA5pWQzV7/bfpxxGOaZclNKuBqHIubBNZ46CQIjHHesD/xDOjfmZiqXX
	jHKRtMJMFrVGdWIRgNXD6NckA=
Received: from ThinkBook-14.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wAXO93FVkBoxFzOFw--.7244S2;
	Wed, 04 Jun 2025 22:23:03 +0800 (CST)
From: Haiyue Wang <haiyuewa@163.com>
To: linux-fsdevel@vger.kernel.org
Cc: apopple@nvidia.com,
	Haiyue Wang <haiyuewa@163.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v1] fuse: ensure all DAX pages are idle prior to filesystem unmount
Date: Wed,  4 Jun 2025 22:22:37 +0800
Message-ID: <20250604142251.2426-1-haiyuewa@163.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAXO93FVkBoxFzOFw--.7244S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxZF43JFy8tF1DuFy7JF1fWFg_yoWrtF15pF
	y5tw1UCF48JrWUGay0yF1jvr1Ut3ZrAF48Xr1Iyr1xXF1UZw1UJr1kAr1UGF1DJrWUZr9x
	tF4DG3WSqw18WaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zE9mROUUUUU=
X-CM-SenderInfo: 5kdl53xhzdqiywtou0bp/1tbiSgRia2hAVQQxkAAAsf

The commit 0e2f80afcfa6 ("fs/dax: ensure all pages are idle prior to filesystem unmount")
can fix the below warnning:

[    4.149368] ------------[ cut here ]------------
[    4.150031] WARNING: CPU: 3 PID: 138 at mm/truncate.c:89 truncate_folio_batch_exceptionals+0x26d/0x2a0
[    4.151602] Modules linked in:
[    4.152388] CPU: 3 UID: 1000 PID: 138 Comm: weston Not tainted 6.15.0-WSL2-STABLE #1 PREEMPT(undef)
[    4.153230] RIP: 0010:truncate_folio_batch_exceptionals+0x26d/0x2a0
[    4.153839] Code: 48 63 d0 41 29 c5 48 8d 1c d5 00 00 00 00 4e 8d 6c 2a 01 49 c1 e5 03 eb 09 48 83 c3 08 49 39 dd 74 84 41 f6 44 1c 08 01 74 ef <0f> 0b 49 8b 34 1e 48 89 ef e8 c5 b5 17 00 eb df 48 8b 7d 00 e8 8a
[    4.155347] RSP: 0018:ffffaf6083383760 EFLAGS: 00010202
[    4.155872] RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
[    4.156620] RDX: 0000000000000000 RSI: ffffaf60833838f0 RDI: ffff98dc20debb80
[    4.157426] RBP: ffff98dc20debcf0 R08: ffffaf60833837f8 R09: 00000000f751f000
[    4.158278] R10: 0000000000000001 R11: 0000000000000001 R12: ffffaf60833838f0
[    4.159257] R13: 0000000000000008 R14: ffffaf60833837f8 R15: 0000000000000000
[    4.163733] FS:  00007b3d87bc2a40(0000) GS:ffff98dc9dd67000(0000) knlGS:0000000000000000
[    4.165457] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    4.166366] CR2: 00007b3d876b0080 CR3: 0000000102bdc002 CR4: 0000000000372eb0
[    4.167295] Call Trace:
[    4.169320]  <TASK>
[    4.169787]  truncate_inode_pages_range+0xd8/0x410
[    4.170417]  ? virtqueue_add_sgs+0x5f7/0x6c0
[    4.171077]  ? get_nohz_timer_target+0x2a/0x140
[    4.172338]  ? timerqueue_add+0x66/0xb0
[    4.172805]  ? timerqueue_del+0x2e/0x50
[    4.173300]  ? __remove_hrtimer+0x39/0x90
[    4.173707]  ? sched_clock+0x10/0x30
[    4.174456]  ? srso_alias_untrain_ret+0x1/0x10
[    4.175266]  ? psi_group_change+0x137/0x330
[    4.176163]  ? _raw_spin_unlock+0xe/0x30
[    4.176983]  ? finish_task_switch.isra.0+0x8d/0x280
[    4.179818]  ? __schedule+0x523/0xbc0
[    4.180785]  fuse_evict_inode+0x29/0x190
[    4.181252]  evict+0x103/0x270
[    4.181631]  ? _atomic_dec_and_lock+0x39/0x50
[    4.182069]  ? __pfx_generic_delete_inode+0x10/0x10
[    4.182483]  __dentry_kill+0x71/0x180
[    4.182845]  dput+0xeb/0x1b0
[    4.183154]  __fput+0x136/0x2a0
[    4.183507]  __x64_sys_close+0x3d/0x80
[    4.183841]  do_syscall_64+0x6d/0x1b0
[    4.184162]  ? vms_clear_ptes.part.0+0x10d/0x140
[    4.184628]  ? vms_complete_munmap_vmas+0x152/0x1c0
[    4.185072]  ? do_vmi_align_munmap+0x1da/0x200
[    4.185485]  ? do_vmi_munmap+0xd1/0x160
[    4.186011]  ? __vm_munmap+0xf2/0x180
[    4.186436]  ? __x64_sys_munmap+0x1b/0x30
[    4.187217]  ? do_syscall_64+0x6d/0x1b0
[    4.189313]  ? count_memcg_events+0x143/0x180
[    4.190122]  ? handle_mm_fault+0xb6/0x2f0
[    4.190861]  ? do_user_addr_fault+0x173/0x680
[    4.191621]  ? clear_bhb_loop+0x30/0x80
[    4.192182]  ? clear_bhb_loop+0x30/0x80
[    4.192907]  ? clear_bhb_loop+0x30/0x80
[    4.193430]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[    4.195789] RIP: 0033:0x7b3d8b220067
[    4.197509] Code: b8 ff ff ff ff e9 3e ff ff ff 66 0f 1f 84 00 00 00 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 41 c3 48 83 ec 18 89 7c 24 0c e8 c3 a7 f8 ff
[    4.199585] RSP: 002b:00007ffd1e3bc3b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000003
[    4.200346] RAX: ffffffffffffffda RBX: 00007ffd1e3bc3d0 RCX: 00007b3d8b220067
[    4.201071] RDX: 0000000000000003 RSI: 0000000000001000 RDI: 000000000000000d
[    4.201822] RBP: 00007ffd1e3bc4a0 R08: 000000000000000d R09: 0000000000000000
[    4.202465] R10: 00007ffd1e3bc3e8 R11: 0000000000000246 R12: 0000000000000001
[    4.203224] R13: 00007ffd1e3bc3d0 R14: 00007b3d8b31cce0 R15: 0000000000000003
[    4.204100]  </TASK>
[    4.204414] ---[ end trace 0000000000000000 ]---

Signed-off-by: Haiyue Wang <haiyuewa@163.com>
---
 fs/fuse/inode.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index bfe8d8af46f3..5561fcddc84f 100644
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
 
+	if (IS_DAX(inode))
+		dax_break_layout_final(inode);
+
 	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 	if (inode->i_sb->s_flags & SB_ACTIVE) {
-- 
2.49.0



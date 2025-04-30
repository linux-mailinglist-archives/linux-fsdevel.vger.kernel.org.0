Return-Path: <linux-fsdevel+bounces-47690-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C37AA408A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 03:24:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4604F7A7AA1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 01:23:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC1014AD20;
	Wed, 30 Apr 2025 01:23:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FBA82DC788;
	Wed, 30 Apr 2025 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745976236; cv=none; b=ljol+SAHaLRgvWTM07zCImJvVcYjPdDxYVfrUhg/PWI4lHikENiJsSB0C9mxsgLhrqbFtkOUGsksX3Vxk6ULtie6myeUevt3D2BEmQaPoWCfKtxkMdSMkiGE0D9PxjATDHwHdnNIiMyTFduoB+D8MqHIfl06WM3DNxNGQJNhKO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745976236; c=relaxed/simple;
	bh=vrTXKcD7lg0ZrlY3co1o6Vs22J3lMqn6dH0Axk2nQmM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY7TL3faJTwYP6LzodRMLgUoS4tS5e8/MqHxSXJzNd5T+r+W6n90cbv9ehEhNdZw97pkNUt+q5aWKvPI7FyIG3qTxx77XikIKYuUAH3vCBirPskLeg4GLVOE5lmP5kRgJ06pGTcrf6VF13GnEIdWnPuQriGuS/NvgW+wYdJIuLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZnKFb11j2z4f3jt8;
	Wed, 30 Apr 2025 09:23:31 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 160B11A09ED;
	Wed, 30 Apr 2025 09:23:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGCbexFov3rkKw--.18493S4;
	Wed, 30 Apr 2025 09:23:47 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	wanghaichi0403@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 1/4] ext4: fix out of bounds punch offset
Date: Wed, 30 Apr 2025 09:12:58 +0800
Message-ID: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGCbexFov3rkKw--.18493S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4fXryxAF4xXr4DWw1DAwb_yoW5uF45pr
	y7GrWUGr48Wr1UCF48Jr17Jr4Uta17CFW7XF1xWrWUAF1fZ3WjgF1UKr47uF1UJr48Xr1S
	qF1DXw10qw1YyaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Y14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x
	0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
	zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
	4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
	nIWIevJa73UjIFyTuYvjfUonmRUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Punching a hole with a start offset that exceeds max_end is not
permitted and will result in a negative length in the
truncate_inode_partial_folio() function while truncating the page cache,
potentially leading to undesirable consequences.

A simple reproducer:

  truncate -s 9895604649994 /mnt/foo
  xfs_io -c "pwrite 8796093022208 4096" /mnt/foo
  xfs_io -c "fpunch 8796093022213 25769803777" /mnt/foo

  kernel BUG at include/linux/highmem.h:275!
  Oops: invalid opcode: 0000 [#1] SMP PTI
  CPU: 3 UID: 0 PID: 710 Comm: xfs_io Not tainted 6.15.0-rc3
  Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.16.3-2.fc40 04/01/2014
  RIP: 0010:zero_user_segments.constprop.0+0xd7/0x110
  RSP: 0018:ffffc90001cf3b38 EFLAGS: 00010287
  RAX: 0000000000000005 RBX: ffffea0001485e40 RCX: 0000000000001000
  RDX: 000000000040b000 RSI: 0000000000000005 RDI: 000000000040b000
  RBP: 000000000040affb R08: ffff888000000000 R09: ffffea0000000000
  R10: 0000000000000003 R11: 00000000fffc7fc5 R12: 0000000000000005
  R13: 000000000040affb R14: ffffea0001485e40 R15: ffff888031cd3000
  FS:  00007f4f63d0b780(0000) GS:ffff8880d337d000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: 000000001ae0b038 CR3: 00000000536aa000 CR4: 00000000000006f0
  DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
  DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
  Call Trace:
   <TASK>
   truncate_inode_partial_folio+0x3dd/0x620
   truncate_inode_pages_range+0x226/0x720
   ? bdev_getblk+0x52/0x3e0
   ? ext4_get_group_desc+0x78/0x150
   ? crc32c_arch+0xfd/0x180
   ? __ext4_get_inode_loc+0x18c/0x840
   ? ext4_inode_csum+0x117/0x160
   ? jbd2_journal_dirty_metadata+0x61/0x390
   ? __ext4_handle_dirty_metadata+0xa0/0x2b0
   ? kmem_cache_free+0x90/0x5a0
   ? jbd2_journal_stop+0x1d5/0x550
   ? __ext4_journal_stop+0x49/0x100
   truncate_pagecache_range+0x50/0x80
   ext4_truncate_page_cache_block_range+0x57/0x3a0
   ext4_punch_hole+0x1fe/0x670
   ext4_fallocate+0x792/0x17d0
   ? __count_memcg_events+0x175/0x2a0
   vfs_fallocate+0x121/0x560
   ksys_fallocate+0x51/0xc0
   __x64_sys_fallocate+0x24/0x40
   x64_sys_call+0x18d2/0x4170
   do_syscall_64+0xa7/0x220
   entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fix this by filtering out cases where the punching start offset exceeds
max_end.

Fixes: 982bf37da09d ("ext4: refactor ext4_punch_hole()")
Reported-by: Liebes Wang <wanghaichi0403@gmail.com>
Closes: https://lore.kernel.org/linux-ext4/ac3a58f6-e686-488b-a9ee-fc041024e43d@huawei.com/
Tested-by: Liebes Wang <wanghaichi0403@gmail.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..4ec4a80b6879 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4016,7 +4016,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
 	/* No need to punch hole beyond i_size */
-	if (offset >= inode->i_size)
+	if (offset >= inode->i_size || offset >= max_end)
 		return 0;
 
 	/*
-- 
2.46.1



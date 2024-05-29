Return-Path: <linux-fsdevel+bounces-20390-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA748D2A3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 04:00:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F3831C234E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 May 2024 02:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071FB15B140;
	Wed, 29 May 2024 01:59:25 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9DF15AAD9;
	Wed, 29 May 2024 01:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716947964; cv=none; b=hhEiKWUh/M7uFewHHWkVXBO8Fb/lEWTFGYv7vETkxU7ag5ig+7r7RjA3SmoLUuHuW2nbd/ZrOBGraSSBE+plFvS5z3/dsBhutuDZgBRnTXbiSgy2lCSei0Lvvtp68xBs12MKP66Y8eYLtAEp1AdN+8CKL2zi5K1Aa0SHmJ5Ll8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716947964; c=relaxed/simple;
	bh=25KBZBHt/e9frPug4/2IwbXcYndgkcYnsmEzSEbR1rE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qJAq9Fl01GIeeVOO7DoQ+XNiVbSh8eLyshCt9xzz+gYVeyySz83EN4pKQn+84vkhoHrWF9EXVvm8aHfSJqE1sloG25ElASZpiMM0PRRLumikdSjGvedSJXAUw5qTxcpDO+VqJ0djswn4nB6AjqU7buV5JOqIjxtgDL5c9l82KTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vpsxp5d6Lz4f3jJ2;
	Wed, 29 May 2024 09:59:10 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 150341A0572;
	Wed, 29 May 2024 09:59:20 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g7wi1Zmr3XbNw--.12147S10;
	Wed, 29 May 2024 09:59:19 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	djwong@kernel.org,
	hch@infradead.org,
	brauner@kernel.org,
	david@fromorbit.com,
	chandanbabu@kernel.org,
	jack@suse.cz,
	willy@infradead.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH v4 6/8] xfs: correct the truncate blocksize of realtime inode
Date: Wed, 29 May 2024 17:52:04 +0800
Message-Id: <20240529095206.2568162-7-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g7wi1Zmr3XbNw--.12147S10
X-Coremail-Antispam: 1UD129KBjvJXoWxXw1rJr47CF1kAw4kWrWDXFb_yoW5GFW3pF
	Z2k3WUGrWDG340k3WxJFn0qw1UKa4kAr47Ary5Wrn7X3WDJr1fXrn2qryYgw43trs7XFn0
	gFn8C3y7Z345AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
	c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
	CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1I6r4U
	MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r
	1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRHa0PUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

When unaligned truncating down a realtime file which sb_rextsize is
bigger than one block, xfs_truncate_page() only zeros out the tail EOF
block, this could expose stale data since commit '943bc0882ceb ("iomap:
don't increase i_size if it's not a write operation")'.

If we truncate file that contains a large enough written extent:

     |<    rxext    >|<    rtext    >|
  ...WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW
        ^ (new EOF)      ^ old EOF

Since we only zeros out the tail of the EOF block, and
xfs_itruncate_extents() unmap the whole ailgned extents, it becomes
this state:

     |<    rxext    >|
  ...WWWzWWWWWWWWWWWWW
        ^ new EOF

Then if we do an extending write like this, the blocks in the previous
tail extent becomes stale:

     |<    rxext    >|
  ...WWWzSSSSSSSSSSSSS..........WWWWWWWWWWWWWWWWW
        ^ old EOF               ^ append start  ^ new EOF

Fix this by zeroing out the tail allocation uint and also make sure
xfs_itruncate_extents() unmap rtextsize aligned extents.

Fixes: 943bc0882ceb ("iomap: don't increase i_size if it's not a write operation")
Reported-by: Chandan Babu R <chandanbabu@kernel.org>
Link: https://lore.kernel.org/linux-xfs/0b92a215-9d9b-3788-4504-a520778953c2@huaweicloud.com
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_inode.c | 3 +++
 fs/xfs/xfs_iops.c  | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 58fb7a5062e1..db35167acef6 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -35,6 +35,7 @@
 #include "xfs_trans_priv.h"
 #include "xfs_log.h"
 #include "xfs_bmap_btree.h"
+#include "xfs_rtbitmap.h"
 #include "xfs_reflink.h"
 #include "xfs_ag.h"
 #include "xfs_log_priv.h"
@@ -1512,6 +1513,8 @@ xfs_itruncate_extents_flags(
 	 * the page cache can't scale that far.
 	 */
 	first_unmap_block = XFS_B_TO_FSB(mp, (xfs_ufsize_t)new_size);
+	if (xfs_inode_has_bigrtalloc(ip))
+		first_unmap_block = xfs_rtb_roundup_rtx(mp, first_unmap_block);
 	if (!xfs_verify_fileoff(mp, first_unmap_block)) {
 		WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
 		return 0;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index d24927075022..ec7b7bdf8825 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -865,7 +865,7 @@ xfs_setattr_size(
 	 */
 	write_back = newsize > ip->i_disk_size && oldsize != ip->i_disk_size;
 	if (newsize < oldsize) {
-		unsigned int blocksize = i_blocksize(inode);
+		unsigned int blocksize = xfs_inode_alloc_unitsize(ip);
 
 		/*
 		 * Zeroing out the partial EOF block and the rest of the extra
-- 
2.39.2



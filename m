Return-Path: <linux-fsdevel+bounces-16604-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3C189FB32
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 17:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37B331F2F04B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 15:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 485FB16F0DA;
	Wed, 10 Apr 2024 15:11:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8FC016DEC8;
	Wed, 10 Apr 2024 15:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712761915; cv=none; b=QodBsDXWnJHu2kawlK/bsy0MTzhjZ9h7XhRQ2K4zraD7DpNXKyo8DpdH4vuKIO0m/8ZKxRvHO3REsIPTZvFYOe+1sVuD5gvUDBL0G4j8Mte4DhCcbSW6LG//+p7+143zsda6NNJbv5hRT33hgmTz9j+vGT1166I69ct7hSvw9Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712761915; c=relaxed/simple;
	bh=z0e1nJBpJ3j2ORyj+wbTmxTK78UizHU0ZhI0HrL3yd4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HelXoDRT+fpi2KCRbS03jNLqTGYFCZMkk7tOWiphW0HNp2b4yuaufOj+Tmzin0sE/h61MVTp4viZHQQCZROPqQcO5nZWMxMlQyWdMPi212es1I97UAOQqOH3n8WFENSABCzV0eLXwlz/EL0ILOo5Ork8cjx2igXl8Oz2peeKcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VF5rs6cBdz4f3mHN;
	Wed, 10 Apr 2024 23:11:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 907B01A0572;
	Wed, 10 Apr 2024 23:11:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn9g4orBZmFSt+Jg--.51485S7;
	Wed, 10 Apr 2024 23:11:50 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v4 32/34] ext4: enable large folio for regular file with iomap buffered IO path
Date: Wed, 10 Apr 2024 23:03:11 +0800
Message-Id: <20240410150313.2820364-4-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn9g4orBZmFSt+Jg--.51485S7
X-Coremail-Antispam: 1UD129KBjvJXoWxGw17XrWxCFWrtF17ur4xCrg_yoW5uF1Upr
	nIkF1fGrW8X34DuFs5Kr1jqr1Ut3W8Kw4Uu3yS93WkuryDAryIqF1jgF48AFW2yrW8Aw4I
	gFW0kr1UZr1fKrJanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmEb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUWw
	A2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
	6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
	Ij6xIIjxv20xvE14v26r126r1DMcIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_
	Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7xvrVCFI7AF6II2Y40_Zr0_Gr1UM4x0x7Aq67IIx4
	CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2Iq
	xVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r
	106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AK
	xVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcI
	k0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8Jr0_Cr1UMIIF0xvEx4A2jsIEc7CjxVAFwI0_
	GcCE3sUvcSsGvfC2KfnxnUUI43ZEXa7xRN0PSUUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Since we've convert buffered IO path to iomap for regular files, we can
enable large foilo together, that should be able to bring a lot of
performance gains for large IO. These are fio tests with psync on Intel
Xeon Gold 6240 CPU with 400GB system ram, 200GB ramdisk and 1TB nvme ssd
disk.

 buffer read:

                buffer head        iomap + large folio
 type     bs    IOPS    BW(MiB/s)  IOPS    BW(MiB/s)
 ----------------------------------------------------
 hole     64K   45.1k   2820       78.1k   4879
 hole     1M    2744    2744       4890    4891
 ramdisk  64K   29.6k   1848       44.0k   2747
 ramdisk  1M    1994    1995       2809    2809
 nvme     64K   19.3k   1208       24.3k   1517
 nvme     1M    1694    1694       2256    2256

 buffer write:

                                      buffer head   iomap + large folio
 type   Overwrite Sync Writeback bs   IOPS   BW     IOPS   BW
 -------------------------------------------------------------
 cache    N       N    N         64K  30.8k  1928   80.1k  5005
 cache    N       N    N         1M   1963   1963   5641   5642
 cache    Y       N    N         64K  33.0k  2063   80.8k  5051
 cache    Y       N    N         1M   2103   2103   5588   5589
 ramdisk  N       N    Y         64K  22.4k  1399   64.8k  4050
 ramdisk  N       N    Y         1M   1670   1670   4559   4560
 ramdisk  N       Y    N         64K  5834   365    10.1k  629
 ramdisk  N       Y    N         1M   1011   1011   2064   2064
 ramdisk  Y       N    Y         64K  29.2k  1827   73.6k  4597
 ramdisk  Y       N    Y         1M   1837   1837   4985   4985
 ramdisk  Y       Y    N         64K  17.7k  1109   33.7k  2105
 ramdisk  Y       Y    N         1M   1128   1129   1790   1791
 nvme     N       N    Y         64K  21.5k  1343   57.4k  3590
 nvme     N       N    Y         1M   1308   1308   3664   3664
 nvme     N       Y    N         64K  5962   373    8598   537
 nvme     N       Y    N         1M   676    677    1417   1418
 nvme     Y       N    Y         64K  26.7k  1670   56.8k  3547
 nvme     Y       N    Y         1M   1745   1746   3586   3586
 nvme     Y       Y    N         64K  13.0k  813    21.0k  1311
 nvme     Y       Y    N         1M   683    683    1368   1369

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ialloc.c      | 4 +++-
 fs/ext4/inode.c       | 4 +++-
 fs/ext4/move_extent.c | 1 +
 3 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 956b9d69c559..5a22fe5aa46b 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1336,8 +1336,10 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
-	if (ext4_should_use_buffered_iomap(inode))
+	if (ext4_should_use_buffered_iomap(inode)) {
 		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+		mapping_set_large_folios(inode->i_mapping);
+	}
 
 	if (ext4_handle_valid(handle)) {
 		ei->i_sync_tid = handle->h_transaction->t_tid;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 624eac0cc705..1cb219d347af 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5400,8 +5400,10 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 	if (ret)
 		goto bad_inode;
 
-	if (ext4_should_use_buffered_iomap(inode))
+	if (ext4_should_use_buffered_iomap(inode)) {
 		ext4_set_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+		mapping_set_large_folios(inode->i_mapping);
+	}
 
 	if (S_ISREG(inode->i_mode)) {
 		inode->i_op = &ext4_file_inode_operations;
diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
index 3db255385367..6722b39049cf 100644
--- a/fs/ext4/move_extent.c
+++ b/fs/ext4/move_extent.c
@@ -560,6 +560,7 @@ static int ext4_disable_buffered_iomap_aops(struct inode *inode)
 	truncate_inode_pages(inode->i_mapping, 0);
 
 	ext4_clear_inode_state(inode, EXT4_STATE_BUFFERED_IOMAP);
+	mapping_clear_large_folios(inode->i_mapping);
 	ext4_set_aops(inode);
 	filemap_invalidate_unlock(inode->i_mapping);
 
-- 
2.39.2



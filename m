Return-Path: <linux-fsdevel+bounces-21624-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AF4906814
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 11:04:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D614FB24C2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Jun 2024 09:02:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810BB1422A5;
	Thu, 13 Jun 2024 09:01:15 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B76413E897;
	Thu, 13 Jun 2024 09:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718269275; cv=none; b=ep7t3ULouI4vX+WsAgtaqFOsw9/9FPQ+BUP29oGFallwkwMeZ0YvY+EtT6x/EVK9sr2qkMGtE8DrWdscz60VcvUF2FOJ+21Wh1PMwHe846FAzH71VYTIFBog0AHYZGL5PTfJo4k5LensfaXiaeft2QzJIRpFC5QYiBLTIsRrKTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718269275; c=relaxed/simple;
	bh=qlgBcelue/cx58rj3054/jng7dtRnGsdILX5JaM24+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BjAb9bhQmShdSLWivuzchhgWjpRycI8XGCa0JDR7+UN5GSgsBBugu1GVSRhUhMRqI1XpmAPdJsYxrNDTFx+wri6wVnfSd4lKRNpRXsEQwNAqcv/sNZSrYAkAnX3lUrS2LjSfRSMAV+v3y5AQByhOEt9l58vuSIxWEzSGsWY98rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W0Gbg3kBjz4f3kk5;
	Thu, 13 Jun 2024 17:01:03 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1FCE61A0568;
	Thu, 13 Jun 2024 17:01:10 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFOtWpmHK1uPQ--.16895S11;
	Thu, 13 Jun 2024 17:01:09 +0800 (CST)
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
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH -next v5 7/8] xfs: speed up truncating down a big realtime inode
Date: Thu, 13 Jun 2024 17:00:32 +0800
Message-Id: <20240613090033.2246907-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
References: <20240613090033.2246907-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFOtWpmHK1uPQ--.16895S11
X-Coremail-Antispam: 1UD129KBjvJXoWxAFy5Cry5ZFy8Zw4xAF4fXwb_yoW5Cw17pF
	Z7Ka45GrWkt3429aykZF4qqw1Y9as2ya1UCrW5XryxA3Z8Jw1Skrn3t34rJw4Utr4vqa4q
	qF1vk3y7Z3W3XFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr
	0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUA
	rcfUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

If we truncate down a big realtime inode, zero out the entire aligned
EOF extent could gets slow down as the rtextsize increases. Fortunately,
__xfs_bunmapi() would align the unmapped range to rtextsize, split and
convert the blocks beyond EOF to unwritten. So speed up this by
adjusting the unitsize to the filesystem blocksize when truncating down
a large realtime inode, let __xfs_bunmapi() convert the tail blocks to
unwritten, this could improve the performance significantly.

 # mkfs.xfs -f -rrtdev=/dev/pmem1s -f -m reflink=0,rmapbt=0, \
            -d rtinherit=1 -r extsize=$rtextsize /dev/pmem2s
 # mount -ortdev=/dev/pmem1s /dev/pmem2s /mnt/scratch
 # for i in {1..1000}; \
   do dd if=/dev/zero of=/mnt/scratch/$i bs=$rtextsize count=1024; done
 # sync
 # time for i in {1..1000}; \
   do xfs_io -c "truncate 4k" /mnt/scratch/$i; done

 rtextsize       8k      16k      32k      64k     256k     1024k
 before:       9.601s  10.229s  11.153s  12.086s  12.259s  20.141s
 after:        9.710s   9.642s   9.958s   9.441s  10.021s  10.526s

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/xfs/xfs_inode.c | 10 ++++++++--
 fs/xfs/xfs_iops.c  |  9 +++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/fs/xfs/xfs_inode.c b/fs/xfs/xfs_inode.c
index 92daa2279053..5e837ed093b0 100644
--- a/fs/xfs/xfs_inode.c
+++ b/fs/xfs/xfs_inode.c
@@ -1487,6 +1487,7 @@ xfs_itruncate_extents_flags(
 	struct xfs_trans	*tp = *tpp;
 	xfs_fileoff_t		first_unmap_block;
 	int			error = 0;
+	unsigned int		unitsize = xfs_inode_alloc_unitsize(ip);
 
 	xfs_assert_ilocked(ip, XFS_ILOCK_EXCL);
 	if (atomic_read(&VFS_I(ip)->i_count))
@@ -1510,9 +1511,14 @@ xfs_itruncate_extents_flags(
 	 *
 	 * We have to free all the blocks to the bmbt maximum offset, even if
 	 * the page cache can't scale that far.
+	 *
+	 * For big realtime inode, don't aligned to allocation unitsize,
+	 * it'll split the extent and convert the tail blocks to unwritten.
 	 */
-	first_unmap_block = XFS_B_TO_FSB(mp,
-			roundup_64(new_size, xfs_inode_alloc_unitsize(ip)));
+	if (xfs_inode_has_bigrtalloc(ip))
+		unitsize = i_blocksize(VFS_I(ip));
+	first_unmap_block = XFS_B_TO_FSB(mp, roundup_64(new_size, unitsize));
+
 	if (!xfs_verify_fileoff(mp, first_unmap_block)) {
 		WARN_ON_ONCE(first_unmap_block > XFS_MAX_FILEOFF);
 		return 0;
diff --git a/fs/xfs/xfs_iops.c b/fs/xfs/xfs_iops.c
index 8af13fd37f1b..1903c06d39bc 100644
--- a/fs/xfs/xfs_iops.c
+++ b/fs/xfs/xfs_iops.c
@@ -862,6 +862,15 @@ xfs_setattr_truncate_data(
 	/* Truncate down */
 	blocksize = xfs_inode_alloc_unitsize(ip);
 
+	/*
+	 * If it's a big realtime inode, zero out the entire EOF extent could
+	 * get slow down as the rtextsize increases, speed it up by adjusting
+	 * the blocksize to the filesystem blocksize, let __xfs_bunmapi() to
+	 * split the extent and convert the tail blocks to unwritten.
+	 */
+	if (xfs_inode_has_bigrtalloc(ip))
+		blocksize = i_blocksize(inode);
+
 	/*
 	 * iomap won't detect a dirty page over an unwritten block (or a cow
 	 * block over a hole) and subsequently skips zeroing the newly post-EOF
-- 
2.39.2



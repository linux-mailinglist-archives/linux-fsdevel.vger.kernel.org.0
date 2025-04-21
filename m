Return-Path: <linux-fsdevel+bounces-46768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8622AA94AD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 04:27:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844707A735C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Apr 2025 02:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B61B258CF5;
	Mon, 21 Apr 2025 02:25:38 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D051C2571B0;
	Mon, 21 Apr 2025 02:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745202337; cv=none; b=l6Fer50o/YFo4YKfsn+8DFsOlUdXo4Qp0uYh+4BFhxx/JG43Kq/oRrFM9C31VxoY9Mwppa79x0LPS/fzsPiiYukdzvLKWDclCcQS5Ws21zWFsPapirskGEzU/Wf5Gi3PLXBNf2fVze+Jx9hrUIcdB8C0ofV2U7Gkx7inrtNinzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745202337; c=relaxed/simple;
	bh=RJ5rsc6/wjBPB905LyP4tfh4gFfFqZBmsP4Wy4Fovc8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRkdnQiwhvmf54i3n+ge2XnCWGpLqc3D61vW5wYbEZULGkDVo4g3MB+4RyD2SpQ+Z1ASUisHEe8h201oBJoNJ2ICjaXoGMgeBDO8wU/ixhDze7KIYbjfr0Am4frGrydHcGrMnVH8Hkk6U4JeBRDIIMugeAFHNU8pphPvNTUIkwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Zgq2q5qndz4f3lgS;
	Mon, 21 Apr 2025 10:25:07 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 332EA1A018D;
	Mon, 21 Apr 2025 10:25:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgA3m1+MrAVoFxZkKA--.3102S11;
	Mon, 21 Apr 2025 10:25:32 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-block@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hch@lst.de,
	tytso@mit.edu,
	djwong@kernel.org,
	john.g.garry@oracle.com,
	bmarzins@redhat.com,
	chaitanyak@nvidia.com,
	shinichiro.kawasaki@wdc.com,
	brauner@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH v4 07/11] fs: statx add write zeroes unmap attribute
Date: Mon, 21 Apr 2025 10:15:05 +0800
Message-ID: <20250421021509.2366003-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
References: <20250421021509.2366003-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgA3m1+MrAVoFxZkKA--.3102S11
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45Zr4fWry3uw4DAw45GFg_yoW5Aw45pF
	WkGFy8GF4FgFWUuw4vk3W7Zw15t3WYkr4UA3yUKw10kFWDtr1IgF93CFyjyrnYqrZ7C3y3
	XF9rK347uay2k3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRQJ5wUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add a new attribute flag to statx to determine whether a bdev or a file
supports the unmap write zeroes command.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 block/bdev.c              | 4 ++++
 fs/ext4/inode.c           | 9 ++++++---
 include/uapi/linux/stat.h | 1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 4844d1e27b6f..29b0e5feb138 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1304,6 +1304,10 @@ void bdev_statx(struct path *path, struct kstat *stat,
 			queue_atomic_write_unit_max_bytes(bd_queue));
 	}
 
+	if (bdev_write_zeroes_unmap(bdev))
+		stat->attributes |= STATX_ATTR_WRITE_ZEROES_UNMAP;
+	stat->attributes_mask |= STATX_ATTR_WRITE_ZEROES_UNMAP;
+
 	stat->blksize = bdev_io_min(bdev);
 
 	blkdev_put_no_open(bdev);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..38caf2f39c6d 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5653,6 +5653,7 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 	struct inode *inode = d_inode(path->dentry);
 	struct ext4_inode *raw_inode;
 	struct ext4_inode_info *ei = EXT4_I(inode);
+	struct block_device *bdev = inode->i_sb->s_bdev;
 	unsigned int flags;
 
 	if ((request_mask & STATX_BTIME) &&
@@ -5672,8 +5673,6 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 
 		stat->result_mask |= STATX_DIOALIGN;
 		if (dio_align == 1) {
-			struct block_device *bdev = inode->i_sb->s_bdev;
-
 			/* iomap defaults */
 			stat->dio_mem_align = bdev_dma_alignment(bdev) + 1;
 			stat->dio_offset_align = bdev_logical_block_size(bdev);
@@ -5695,6 +5694,9 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
 	}
 
+	if (S_ISREG(inode->i_mode) && bdev_write_zeroes_unmap(bdev))
+		stat->attributes |= STATX_ATTR_WRITE_ZEROES_UNMAP;
+
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 	if (flags & EXT4_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
@@ -5714,7 +5716,8 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 				  STATX_ATTR_ENCRYPTED |
 				  STATX_ATTR_IMMUTABLE |
 				  STATX_ATTR_NODUMP |
-				  STATX_ATTR_VERITY);
+				  STATX_ATTR_VERITY |
+				  STATX_ATTR_WRITE_ZEROES_UNMAP);
 
 	generic_fillattr(idmap, request_mask, inode, stat);
 	return 0;
diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
index f78ee3670dd5..279ce7e34df7 100644
--- a/include/uapi/linux/stat.h
+++ b/include/uapi/linux/stat.h
@@ -251,6 +251,7 @@ struct statx {
 #define STATX_ATTR_VERITY		0x00100000 /* [I] Verity protected file */
 #define STATX_ATTR_DAX			0x00200000 /* File is currently in DAX state */
 #define STATX_ATTR_WRITE_ATOMIC		0x00400000 /* File supports atomic write operations */
+#define STATX_ATTR_WRITE_ZEROES_UNMAP	0x00800000 /* File supports unmap write zeroes */
 
 
 #endif /* _UAPI_LINUX_STAT_H */
-- 
2.46.1



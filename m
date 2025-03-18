Return-Path: <linux-fsdevel+bounces-44283-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D695A66CC5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 08:52:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC27816CC1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 07:48:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC93B209F4B;
	Tue, 18 Mar 2025 07:44:22 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF662066F4;
	Tue, 18 Mar 2025 07:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283862; cv=none; b=YTLr0wRa1U2M6r72UX+YmdU3z3TNSG8D9Gy83/bSP+kyDHGWZVwq2xLQtfPkenJVKA8uu8lzCYB9PtEAYhGeE1X6OsFj/msXg0FEsQ+6chjq7eNm67DTRDiYUZtRlcuXntcF6Xr/1V7Do6E8/kAOkbp73FahzO99ivKNEqgXlUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283862; c=relaxed/simple;
	bh=lNqSEZtRhtDg1oDyM4rlYBmQoW00uSDc7hIT4DDoSsY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pbkcK+cWCxXxICMNXu95f765yTqdDC5uqV0Fq4a5OogKVjN5lkk14VRMnfwKZne0pKJTa181pMjOi8Nswlo3TrqZ11Q+TOhd2Sdie5mruJ7pv3ed6BYiN5/6614SDU46A+IV71vu0n1JO1uBzL20fVwrc5Yd8SmcoJTmYvCGWQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZH3kR2lP8z4f3jtt;
	Tue, 18 Mar 2025 15:43:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 96D6D1A1741;
	Tue, 18 Mar 2025 15:44:16 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCH6189JNlnEt1YGw--.55732S14;
	Tue, 18 Mar 2025 15:44:16 +0800 (CST)
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
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH -next v3 10/10] ext4: add FALLOC_FL_WRITE_ZEROES support
Date: Tue, 18 Mar 2025 15:35:45 +0800
Message-ID: <20250318073545.3518707-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
References: <20250318073545.3518707-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH6189JNlnEt1YGw--.55732S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry7Ar13Xw13XFy8XFW3GFg_yoW7GF4UpF
	Z8XF1rKFWIq3429r4fCw4kurn0q3WkKry5WrWSgry093yUJr1fKFn09Fy8uas0gFW8AF45
	Xa1Y9ryDK3W7A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUma14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjx
	v20xvE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1l
	F7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2
	IY04v7MxkF7I0En4kS14v26r4a6rW5MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26ryj6F1UMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCw
	CI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsG
	vfC2KfnxnUUI43ZEXa7sRitxhPUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add support for FALLOC_FL_WRITE_ZEROES. This first allocates blocks as
unwritten, then issues a zero command outside of the running journal
handle, and finally converts them to a written state.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c           | 59 ++++++++++++++++++++++++++++++-------
 include/trace/events/ext4.h |  3 +-
 2 files changed, 50 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1b028be19193..e937a714085c 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4483,6 +4483,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	struct ext4_map_blocks map;
 	unsigned int credits;
 	loff_t epos, old_size = i_size_read(inode);
+	unsigned int blkbits = inode->i_blkbits;
+	bool alloc_zero = false;
 
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
 	map.m_lblk = offset;
@@ -4495,6 +4497,17 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	if (len <= EXT_UNWRITTEN_MAX_LEN)
 		flags |= EXT4_GET_BLOCKS_NO_NORMALIZE;
 
+	/*
+	 * Do the actual write zero during a running journal transaction
+	 * costs a lot. First allocate an unwritten extent and then
+	 * convert it to written after zeroing it out.
+	 */
+	if (flags & EXT4_GET_BLOCKS_ZERO) {
+		flags &= ~EXT4_GET_BLOCKS_ZERO;
+		flags |= EXT4_GET_BLOCKS_UNWRIT_EXT;
+		alloc_zero = true;
+	}
+
 	/*
 	 * credits to insert 1 extent into extent tree
 	 */
@@ -4531,9 +4544,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 		 * allow a full retry cycle for any remaining allocations
 		 */
 		retries = 0;
-		map.m_lblk += ret;
-		map.m_len = len = len - ret;
-		epos = (loff_t)map.m_lblk << inode->i_blkbits;
+		epos = (loff_t)(map.m_lblk + ret) << blkbits;
 		inode_set_ctime_current(inode);
 		if (new_size) {
 			if (epos > new_size)
@@ -4553,6 +4564,21 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 		ret2 = ret3 ? ret3 : ret2;
 		if (unlikely(ret2))
 			break;
+
+		if (alloc_zero &&
+		    (map.m_flags & (EXT4_MAP_MAPPED | EXT4_MAP_UNWRITTEN))) {
+			ret2 = ext4_issue_zeroout(inode, map.m_lblk, map.m_pblk,
+						  map.m_len);
+			if (likely(!ret2))
+				ret2 = ext4_convert_unwritten_extents(NULL,
+					inode, (loff_t)map.m_lblk << blkbits,
+					(loff_t)map.m_len << blkbits);
+			if (ret2)
+				break;
+		}
+
+		map.m_lblk += ret;
+		map.m_len = len = len - ret;
 	}
 	if (ret == -ENOSPC && ext4_should_retry_alloc(inode->i_sb, &retries))
 		goto retry;
@@ -4618,7 +4644,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
 	if (end_lblk > start_lblk) {
 		ext4_lblk_t zero_blks = end_lblk - start_lblk;
 
-		flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN | EXT4_EX_NOCACHE);
+		if (mode & FALLOC_FL_WRITE_ZEROES)
+			flags = EXT4_GET_BLOCKS_CREATE_ZERO | EXT4_EX_NOCACHE;
+		else
+			flags |= (EXT4_GET_BLOCKS_CONVERT_UNWRITTEN |
+				  EXT4_EX_NOCACHE);
 		ret = ext4_alloc_file_blocks(file, start_lblk, zero_blks,
 					     new_size, flags);
 		if (ret)
@@ -4730,8 +4760,8 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 
 	/* Return error if mode is not supported */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
-		     FALLOC_FL_INSERT_RANGE))
+		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_COLLAPSE_RANGE |
+		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_WRITE_ZEROES))
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
@@ -4762,16 +4792,23 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (ret)
 		goto out_invalidate_lock;
 
-	if (mode & FALLOC_FL_PUNCH_HOLE)
+	switch (mode & FALLOC_FL_MODE_MASK) {
+	case FALLOC_FL_PUNCH_HOLE:
 		ret = ext4_punch_hole(file, offset, len);
-	else if (mode & FALLOC_FL_COLLAPSE_RANGE)
+		break;
+	case FALLOC_FL_COLLAPSE_RANGE:
 		ret = ext4_collapse_range(file, offset, len);
-	else if (mode & FALLOC_FL_INSERT_RANGE)
+		break;
+	case FALLOC_FL_INSERT_RANGE:
 		ret = ext4_insert_range(file, offset, len);
-	else if (mode & FALLOC_FL_ZERO_RANGE)
+		break;
+	case FALLOC_FL_ZERO_RANGE:
+	case FALLOC_FL_WRITE_ZEROES:
 		ret = ext4_zero_range(file, offset, len, mode);
-	else
+		break;
+	default:
 		ret = -EOPNOTSUPP;
+	}
 
 out_invalidate_lock:
 	filemap_invalidate_unlock(mapping);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 156908641e68..6f9cf2811733 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -92,7 +92,8 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
 	{ FALLOC_FL_PUNCH_HOLE,		"PUNCH_HOLE"},		\
 	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
-	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
+	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"},		\
+	{ FALLOC_FL_WRITE_ZEROES,	"WRITE_ZEROES"})
 
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_XATTR);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_CROSS_RENAME);
-- 
2.46.1



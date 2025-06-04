Return-Path: <linux-fsdevel+bounces-50563-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D6ACD574
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 04:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A1331899670
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Jun 2025 02:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C958F1D8A0A;
	Wed,  4 Jun 2025 02:21:55 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D12FF1A00F0;
	Wed,  4 Jun 2025 02:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749003715; cv=none; b=pWdiACD1gFjltsa4ur3xdMp/t00HmiHcWVj46kQw/K6fvAwzJ1In7LsMgU2mNLwDFaejKg4G6Q5/JlszkdMAhlCzFvrV2MD1v+rBlsR35MHYP+LDA/k9mA2B3cqC7cqtN1gYKHblFXjFCmYkE965HjzGGyVByO8fqgria/5cbtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749003715; c=relaxed/simple;
	bh=6o1IqCwgxbk3qR0I4Xfs7mXPEtDhI5mvMvR7b+aRJpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dvi2o23izK+Bnp4XRj26IjFwiIe4L/sFdFVia9ATcpDZUmEm2Cj37HQo9udHDctcPruMDN811qaaY7m86sgF+5vzgInQCG3EYiL61P0SqqO+kTBJd1RgiO9i/Xa3hjmnYCU/wD0C0W6alIvnpaLI17Rnt4n6Vn9l0Pw2LqaqpVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bBrtm44yZzKHN3v;
	Wed,  4 Jun 2025 10:21:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id E69741A1589;
	Wed,  4 Jun 2025 10:21:50 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCnCl+nrT9oedfBOQ--.14997S14;
	Wed, 04 Jun 2025 10:21:50 +0800 (CST)
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
	martin.petersen@oracle.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 10/10] ext4: add FALLOC_FL_WRITE_ZEROES support
Date: Wed,  4 Jun 2025 10:08:50 +0800
Message-ID: <20250604020850.1304633-11-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
References: <20250604020850.1304633-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCnCl+nrT9oedfBOQ--.14997S14
X-Coremail-Antispam: 1UD129KBjvJXoW3Xry7Ar1DWF43tr1DZr17GFg_yoW7Cr1rpF
	Z8XF1rKa4Iq34a9r4fCw4kurn0q3WkKry5WrWSgry093yDJr1fKFn0gFyrZF90gFWUAF45
	Xa1Y9ryDC3W7A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUmS14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
	bVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67
	AF67kF1VAFwI0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI
	42IY6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF
	4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBI
	daVFxhVjvjDU0xZFpf9x0pRiF4iUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add support for FALLOC_FL_WRITE_ZEROES if the underlying device enable
the unmap write zeroes operation. This first allocates blocks as
unwritten, then issues a zero command outside of the running journal
handle, and finally converts them to a written state.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c           | 66 ++++++++++++++++++++++++++++++-------
 include/trace/events/ext4.h |  3 +-
 2 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b543a46fc809..29ce9f6287d0 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4501,6 +4501,8 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
 	struct ext4_map_blocks map;
 	unsigned int credits;
 	loff_t epos, old_size = i_size_read(inode);
+	unsigned int blkbits = inode->i_blkbits;
+	bool alloc_zero = false;
 
 	BUG_ON(!ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS));
 	map.m_lblk = offset;
@@ -4513,6 +4515,17 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
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
@@ -4549,9 +4562,7 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
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
@@ -4571,6 +4582,21 @@ static int ext4_alloc_file_blocks(struct file *file, ext4_lblk_t offset,
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
@@ -4636,7 +4662,11 @@ static long ext4_zero_range(struct file *file, loff_t offset,
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
@@ -4745,11 +4775,18 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 	if (IS_ENCRYPTED(inode) &&
 	    (mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
+	/*
+	 * Don't allow writing zeroes if the underlying device does not
+	 * enable the unmap write zeroes operation.
+	 */
+	if (!bdev_write_zeroes_unmap(inode->i_sb->s_bdev) &&
+	    (mode & FALLOC_FL_WRITE_ZEROES))
+		return -EOPNOTSUPP;
 
 	/* Return error if mode is not supported */
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
-		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_ZERO_RANGE |
-		     FALLOC_FL_INSERT_RANGE))
+		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_COLLAPSE_RANGE |
+		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_WRITE_ZEROES))
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
@@ -4780,16 +4817,23 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
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



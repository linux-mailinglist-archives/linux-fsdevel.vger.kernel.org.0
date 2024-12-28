Return-Path: <linux-fsdevel+bounces-38177-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B60B9FD8C9
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 02:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356C41631B2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Dec 2024 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 234B470816;
	Sat, 28 Dec 2024 01:49:59 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB53D3B8;
	Sat, 28 Dec 2024 01:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735350598; cv=none; b=AyVRZQ/U4pm63bP815JH1xZwOsKMWCAX3vSIexfPcAdaZw4tdfZ3DusmFdrL9KJnzVK2TVFSsHodFB8macPWq02AC+cZ5KO/+Q1WFry0gVM8dGY1pK6R7gEGr03t/2THhs1h6wJoYYVziAwc37LCg7FT0zFuFJv3/ixU+kST2gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735350598; c=relaxed/simple;
	bh=ZOX580lH6VoMPh1GMn3kpm1paH3qlwAybkviFezGTjQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IOtbQEt07BW4LLI3OFWuwzYxNsMT7XIr33oeMsus48YQE0chhOKPTAev+slCZYjchAcH+5BgMELgaJi7gcoyrC/7LeTT4pL3v8BDyJygHP/oxUs92QkLDcZbCJyTpXyAfGpI/PUu9c49aheTu6/0/ikgKgHWho26XwpEWfMjcnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YKlfP2f34z4f3jqw;
	Sat, 28 Dec 2024 09:49:33 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 140E51A018D;
	Sat, 28 Dec 2024 09:49:48 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP4 (Coremail) with SMTP id gCh0CgB3U4cuWW9nXPNWFw--.42357S6;
	Sat, 28 Dec 2024 09:49:47 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	tytso@mit.edu,
	djwong@kernel.org,
	adilger.kernel@dilger.ca,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [RFC PATCH 2/2] ext4: add FALLOC_FL_FORCE_ZERO support
Date: Sat, 28 Dec 2024 09:45:22 +0800
Message-Id: <20241228014522.2395187-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
References: <20241228014522.2395187-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgB3U4cuWW9nXPNWFw--.42357S6
X-Coremail-Antispam: 1UD129KBjvJXoWxGw4ruw4kJw4DXw4kCr45Wrg_yoWrArWkpF
	Z8ZF1rKayIq3429r4fCw4Durn8Ka4kGryUWrWSgryruayUJr1fKFs0gFy8ZayFgrW8AF45
	Xw4YkryUG3W7A37anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUl9a9UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add support for FALLOC_FL_FORCE_ZERO. This first allocates blocks as
unwritten, then issues a zero command outside of the running journal
handle, and finally converts them to a written state.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents.c           | 42 +++++++++++++++++++++++++++++++------
 include/trace/events/ext4.h |  3 ++-
 2 files changed, 38 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 1b028be19193..dcb3ef4ca1d4 100644
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
+		if (mode & FALLOC_FL_FORCE_ZERO)
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
+		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_FORCE_ZERO |
+		     FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE))
 		return -EOPNOTSUPP;
 
 	inode_lock(inode);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 156908641e68..1ac29dc637a9 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -92,7 +92,8 @@ TRACE_DEFINE_ENUM(ES_REFERENCED_B);
 	{ FALLOC_FL_KEEP_SIZE,		"KEEP_SIZE"},		\
 	{ FALLOC_FL_PUNCH_HOLE,		"PUNCH_HOLE"},		\
 	{ FALLOC_FL_COLLAPSE_RANGE,	"COLLAPSE_RANGE"},	\
-	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"})
+	{ FALLOC_FL_ZERO_RANGE,		"ZERO_RANGE"},		\
+	{ FALLOC_FL_FORCE_ZERO,		"FORCE_ZERO"})
 
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_XATTR);
 TRACE_DEFINE_ENUM(EXT4_FC_REASON_CROSS_RENAME);
-- 
2.39.2



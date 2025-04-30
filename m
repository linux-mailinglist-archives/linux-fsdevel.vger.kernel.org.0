Return-Path: <linux-fsdevel+bounces-47691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA5EAA408B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 03:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CBDA9A621A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Apr 2025 01:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A5715ECD7;
	Wed, 30 Apr 2025 01:23:56 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B0F12B63;
	Wed, 30 Apr 2025 01:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745976236; cv=none; b=YddOVkRUQkWMMz7kTWnegENgP8Zr1zi+EArmKJxRSsTRrGxy7I+a8sgrWw2YQGLrOy4lPLfYEK7qezec+uOwIyaVq6CECyeP1U/PKJomFyzm4iZIh2ClNIcx+3nfhiK9B8z5YnTBwPbCN3imCffwob4kcpOD3nxEtv4G9sLJv/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745976236; c=relaxed/simple;
	bh=sjaEaqv+cMuXxqla/mLlSH/WBihEOWuMmNWRfowekfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZT0QQmeQFFCh7n+AU4qX/Th+rEX3BtOL5hCGUO0kKBX20MOuQYTqj61bCBYWVUedBwGcVExfKWaJ6I61Tituf62yWRWN89oLxCfpgqnbS0IweTtyeo1+j0ahVWP3Lc6cyhI7REihz6ymbxDaRX2Hzv/W6tH5GktltA4km6sig7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4ZnKG00bs8zKHMmX;
	Wed, 30 Apr 2025 09:23:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 085221A018D;
	Wed, 30 Apr 2025 09:23:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGCbexFov3rkKw--.18493S6;
	Wed, 30 Apr 2025 09:23:50 +0800 (CST)
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
Subject: [PATCH 3/4] ext4: factor out ext4_get_maxbytes()
Date: Wed, 30 Apr 2025 09:13:00 +0800
Message-ID: <20250430011301.1106457-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
References: <20250430011301.1106457-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBHrGCbexFov3rkKw--.18493S6
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4UJry7ur18KFyrWFy8Xwb_yoW5ZFykp3
	sxAFy8Jr4xZ39ru3ykKF4UZr1Yy3ZFkw48XrWrCr1YgFyxX340qFySkF40k3WYgrWrCF1Y
	q3WDKry7Jw1akrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWU
	JVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67
	kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY
	6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0x
	vEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVj
	vjDU0xZFpf9x0JUQXo7UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

There are several locations that get the correct maxbytes value based on
the inode's block type. It would be beneficial to extract a common
helper function to make the code more clear.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h    | 7 +++++++
 fs/ext4/extents.c | 7 +------
 fs/ext4/file.c    | 7 +------
 fs/ext4/inode.c   | 8 +-------
 4 files changed, 10 insertions(+), 19 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 5a20e9cd7184..8664bb5367c5 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -3378,6 +3378,13 @@ static inline unsigned int ext4_flex_bg_size(struct ext4_sb_info *sbi)
 	return 1 << sbi->s_log_groups_per_flex;
 }
 
+static inline loff_t ext4_get_maxbytes(struct inode *inode)
+{
+	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
+		return inode->i_sb->s_maxbytes;
+	return EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
+}
+
 #define ext4_std_error(sb, errno)				\
 do {								\
 	if ((errno))						\
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index c616a16a9f36..b294d2f35a26 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4931,12 +4931,7 @@ static const struct iomap_ops ext4_iomap_xattr_ops = {
 
 static int ext4_fiemap_check_ranges(struct inode *inode, u64 start, u64 *len)
 {
-	u64 maxbytes;
-
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		maxbytes = inode->i_sb->s_maxbytes;
-	else
-		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
+	u64 maxbytes = ext4_get_maxbytes(inode);
 
 	if (*len == 0)
 		return -EINVAL;
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index beb078ee4811..b845a25f7932 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -929,12 +929,7 @@ static int ext4_file_open(struct inode *inode, struct file *filp)
 loff_t ext4_llseek(struct file *file, loff_t offset, int whence)
 {
 	struct inode *inode = file->f_mapping->host;
-	loff_t maxbytes;
-
-	if (!(ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS)))
-		maxbytes = EXT4_SB(inode->i_sb)->s_bitmap_maxbytes;
-	else
-		maxbytes = inode->i_sb->s_maxbytes;
+	loff_t maxbytes = ext4_get_maxbytes(inode);
 
 	switch (whence) {
 	default:
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f9725e6347c7..9f32af1241ff 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4006,7 +4006,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	struct inode *inode = file_inode(file);
 	struct super_block *sb = inode->i_sb;
 	ext4_lblk_t start_lblk, end_lblk;
-	loff_t max_end;
+	loff_t max_end = ext4_get_maxbytes(inode) - sb->s_blocksize;
 	loff_t end = offset + length;
 	handle_t *handle;
 	unsigned int credits;
@@ -4015,12 +4015,6 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
 	trace_ext4_punch_hole(inode, offset, length, 0);
 	WARN_ON_ONCE(!inode_is_locked(inode));
 
-	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
-		max_end = sb->s_maxbytes;
-	else
-		max_end = EXT4_SB(sb)->s_bitmap_maxbytes;
-	max_end -= sb->s_blocksize;
-
 	/* No need to punch hole beyond i_size */
 	if (offset >= inode->i_size || offset >= max_end)
 		return 0;
-- 
2.46.1



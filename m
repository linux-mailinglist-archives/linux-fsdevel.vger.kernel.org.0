Return-Path: <linux-fsdevel+bounces-19570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E78C7230
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 09:41:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D11D6282947
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 07:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAA7134433;
	Thu, 16 May 2024 07:40:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CEF2031D;
	Thu, 16 May 2024 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715845242; cv=none; b=AYmDI7tXpNotnY+ptYo3u4UagPcF/MGfsZKfNNZ+sZfmTR+bvixywqWymfDMoLU6T9P+RQ4e9UNxMfPbRtkiKwHkqxLuWAAfNXFOzoiKKV7ZvzmBY8ivgPwfocHV91PgsnoFPO3+93Z0m5vqf0J+U2nPfh6f4PYXI3+2MqSka5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715845242; c=relaxed/simple;
	bh=Qzq9lHoKYDCGofPPRE8CXWW/Db7FcpxSOiT5KWlK7Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Lwy3fer/EE4pXbuTHdAU6/JS1IZ+OQJSbvFSv5oxnGjPcfhA0NlV3QYrPPR1aOcah33qyuFMd93EgKsmhaSXwqBFn3k36s1zzGcqqobXPN9TCq9OXsFiykUG1xMLfxtU+/KEsPq9MNRzwCXJ33/+IJ83Ho9Ldxs/3v4bWEmSXCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vg27Y4kNcz4f3lfY;
	Thu, 16 May 2024 15:40:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id D6D861A1068;
	Thu, 16 May 2024 15:40:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFtuEVmQuY4Mw--.31554S6;
	Thu, 16 May 2024 15:40:35 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
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
Subject: [PATCH v2 2/3] fsdax: pass blocksize to dax_truncate_page()
Date: Thu, 16 May 2024 15:30:00 +0800
Message-Id: <20240516073001.1066373-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240516073001.1066373-1-yi.zhang@huaweicloud.com>
References: <20240516073001.1066373-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBFtuEVmQuY4Mw--.31554S6
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrKF15GF1kJw45JFyxXwb_yoW5tr48pF
	1DGa15G397X34j9F1kWF1jvw15t3WkCF409ryxArs3Zr9Fqr1IyF18KF1YkF4UKr4xZ3yj
	qFZ8K3y7Gr1rAFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUAGYLUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

dax_truncate_page() always assumes the block size of the truncating
inode is i_blocksize(), this is not always true for some filesystems,
e.g. XFS does extent size alignment for realtime inodes. Drop this
assumption and pass the block size for zeroing into dax_truncate_page(),
allow filesystems to indicate the correct block size.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/dax.c            | 11 ++++++-----
 fs/ext2/inode.c     |  4 ++--
 fs/xfs/xfs_iomap.c  |  2 +-
 include/linux/dax.h |  4 ++--
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/fs/dax.c b/fs/dax.c
index 423fc1607dfa..f672c9a663c1 100644
--- a/fs/dax.c
+++ b/fs/dax.c
@@ -1403,16 +1403,17 @@ int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 }
 EXPORT_SYMBOL_GPL(dax_zero_range);
 
-int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops)
+int dax_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
+		bool *did_zero, const struct iomap_ops *ops)
 {
-	unsigned int blocksize = i_blocksize(inode);
-	unsigned int off = pos & (blocksize - 1);
+	loff_t start = pos;
+	unsigned int off = is_power_of_2(blocksize) ? (pos & (blocksize - 1)) :
+			   do_div(pos, blocksize);
 
 	/* Block boundary? Nothing to do */
 	if (!off)
 		return 0;
-	return dax_zero_range(inode, pos, blocksize - off, did_zero, ops);
+	return dax_zero_range(inode, start, blocksize - off, did_zero, ops);
 }
 EXPORT_SYMBOL_GPL(dax_truncate_page);
 
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index f3d570a9302b..fbbd479f3c4e 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -1278,8 +1278,8 @@ static int ext2_setsize(struct inode *inode, loff_t newsize)
 	inode_dio_wait(inode);
 
 	if (IS_DAX(inode))
-		error = dax_truncate_page(inode, newsize, NULL,
-					  &ext2_iomap_ops);
+		error = dax_truncate_page(inode, newsize, i_blocksize(inode),
+					  NULL, &ext2_iomap_ops);
 	else
 		error = block_truncate_page(inode->i_mapping,
 				newsize, ext2_get_block);
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 31ac07bb8425..4958cc3337bc 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1470,7 +1470,7 @@ xfs_truncate_page(
 	unsigned int		blocksize = i_blocksize(inode);
 
 	if (IS_DAX(inode))
-		return dax_truncate_page(inode, pos, did_zero,
+		return dax_truncate_page(inode, pos, blocksize, did_zero,
 					&xfs_dax_write_iomap_ops);
 	return iomap_truncate_page(inode, pos, blocksize, did_zero,
 				   &xfs_buffered_write_iomap_ops);
diff --git a/include/linux/dax.h b/include/linux/dax.h
index 9d3e3327af4c..4aa8ef7c8fd4 100644
--- a/include/linux/dax.h
+++ b/include/linux/dax.h
@@ -210,8 +210,8 @@ int dax_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int dax_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 		const struct iomap_ops *ops);
-int dax_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops);
+int dax_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
+		bool *did_zero, const struct iomap_ops *ops);
 
 #if IS_ENABLED(CONFIG_DAX)
 int dax_read_lock(void);
-- 
2.39.2



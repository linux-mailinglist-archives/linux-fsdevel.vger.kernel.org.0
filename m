Return-Path: <linux-fsdevel+bounces-19567-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0748C7224
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 09:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25D4B2104C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2024 07:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87C7662177;
	Thu, 16 May 2024 07:40:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8151E48A;
	Thu, 16 May 2024 07:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715845241; cv=none; b=M7EN5imKMBsB6Kb7dlv42U/uWC7vUXZRrLI+DNUFT/QfoeHKgwZuXP3BuyTWLPBv8YAOE9e5W+jPdRize0TPkKO8O8Jc5uGh0B8kCIp2PoQg2Tm5YC18bm+/jEc+SQVDVg8yt6ZogpJfRR1rL8qJqVXEcDtRuClSbNQcK6ycXUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715845241; c=relaxed/simple;
	bh=jDQwl8Y4BlqEUdQLRvrfv8kz3CAp8eziDazdfgLrvGQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JDWSWbwGsHjUQPK2Dm2YaDwQsbbWZyO6DcRrFCe0QyKBAhbvYoad/f6dLvLzm7P9nexiJF1DD4ntB8mGEOP2uI6HOiRGg9aOwXD2k9IG3TR7DBi7UK8DQ2xM95T97kFJnbkEYZxNzqs6feLQxXKjtZbo+1afHauNzWcfJ6CT8mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vg27Y0wTwz4f3lfr;
	Thu, 16 May 2024 15:40:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 55F161A0B17;
	Thu, 16 May 2024 15:40:35 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBFtuEVmQuY4Mw--.31554S5;
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
Subject: [PATCH v2 1/3] iomap: pass blocksize to iomap_truncate_page()
Date: Thu, 16 May 2024 15:29:59 +0800
Message-Id: <20240516073001.1066373-2-yi.zhang@huaweicloud.com>
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
X-CM-TRANSID:cCh0CgBXKBFtuEVmQuY4Mw--.31554S5
X-Coremail-Antispam: 1UD129KBjvJXoWxuFyrKF15GFykZr4xWw1rJFb_yoW5CFW3pF
	1qkF45Gws7Xry09F1kWFyjvw1FyF1DCF409ryrKrZxZrnFqr1IyFn2ka1jvF1jqr4xur4j
	vFZ8K3y8Xr15AFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUSYLPUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

iomap_truncate_page() always assumes the block size of the truncating
inode is i_blocksize(), this is not always true for some filesystems,
e.g. XFS does extent size alignment for realtime inodes. Drop this
assumption and pass the block size for zeroing into
iomap_truncate_page(), allow filesystems to indicate the correct block
size.

Suggested-by: Dave Chinner <david@fromorbit.com>
Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/iomap/buffered-io.c | 11 ++++++-----
 fs/xfs/xfs_iomap.c     |  3 ++-
 include/linux/iomap.h  |  4 ++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 0926d216a5af..229dfa3c4906 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -1445,16 +1445,17 @@ iomap_zero_range(struct inode *inode, loff_t pos, loff_t len, bool *did_zero,
 EXPORT_SYMBOL_GPL(iomap_zero_range);
 
 int
-iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops)
+iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
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
-	return iomap_zero_range(inode, pos, blocksize - off, did_zero, ops);
+	return iomap_zero_range(inode, start, blocksize - off, did_zero, ops);
 }
 EXPORT_SYMBOL_GPL(iomap_truncate_page);
 
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 2857ef1b0272..31ac07bb8425 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1467,10 +1467,11 @@ xfs_truncate_page(
 	bool			*did_zero)
 {
 	struct inode		*inode = VFS_I(ip);
+	unsigned int		blocksize = i_blocksize(inode);
 
 	if (IS_DAX(inode))
 		return dax_truncate_page(inode, pos, did_zero,
 					&xfs_dax_write_iomap_ops);
-	return iomap_truncate_page(inode, pos, did_zero,
+	return iomap_truncate_page(inode, pos, blocksize, did_zero,
 				   &xfs_buffered_write_iomap_ops);
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..d67bf86ec582 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -273,8 +273,8 @@ int iomap_file_unshare(struct inode *inode, loff_t pos, loff_t len,
 		const struct iomap_ops *ops);
 int iomap_zero_range(struct inode *inode, loff_t pos, loff_t len,
 		bool *did_zero, const struct iomap_ops *ops);
-int iomap_truncate_page(struct inode *inode, loff_t pos, bool *did_zero,
-		const struct iomap_ops *ops);
+int iomap_truncate_page(struct inode *inode, loff_t pos, unsigned int blocksize,
+		bool *did_zero, const struct iomap_ops *ops);
 vm_fault_t iomap_page_mkwrite(struct vm_fault *vmf,
 			const struct iomap_ops *ops);
 int iomap_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
-- 
2.39.2



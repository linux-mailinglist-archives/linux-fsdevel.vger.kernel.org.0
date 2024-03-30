Return-Path: <linux-fsdevel+bounces-15770-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A5F892B1D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 13:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96491B21ED0
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 Mar 2024 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA6434084D;
	Sat, 30 Mar 2024 12:10:41 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D224F374C2;
	Sat, 30 Mar 2024 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711800641; cv=none; b=IeI2ITdafxtoxodwgbOEj2N0KMfH1ro6LV3lepMIqA6BJcj1cLGbEKreO7HqvA1ytyavZv5/NpV8x5VNBAsLLpbEkQh+aIgQgJieVht9Dkc1iKaTYHDNYrSIwRj1lg3JBc4xCthxnqwTNm/dHvtxe4nLOQpULk/YsR8WSeQdXs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711800641; c=relaxed/simple;
	bh=mCuJ7Zj9uVgdiN88diVmhioXmMGhe9NSmtzJCYi5LP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fsJ2669A0vGhGIrflIoFWhp5UA78fhPD9jRtkvXvkKEyGJGsbH8xY547EsuCX8IGUSP2GtXGuw1nOAxxZkU5DPNqDRj1jqsehLRDSai4en173wuf8QI9jWSe6yhQ9lNQEfK3kpG7y0l8sO6ym3FoLxXL8IzXR3KmGypgNo5WfsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V6GLm6PQwz4f3m7g;
	Sat, 30 Mar 2024 20:10:24 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 266A11A0B35;
	Sat, 30 Mar 2024 20:10:33 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAn+REsAQhmkPEjIg--.10652S8;
	Sat, 30 Mar 2024 20:10:32 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH 4/7] ext4: make ext4_da_reserve_space() reserve multi-clusters
Date: Sat, 30 Mar 2024 20:02:33 +0800
Message-Id: <20240330120236.3789589-5-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240330120236.3789589-1-yi.zhang@huaweicloud.com>
References: <20240330120236.3789589-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAn+REsAQhmkPEjIg--.10652S8
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1fZr4DXF48tr1rKr48Zwb_yoWrXF1xpF
	s8AF43WryxZ34kWFWxZr4DZF1S9a4SqFWUtFZ7WFyxXry5J3WSgF17KF1YvF1rKrWkCw1q
	qay5u348u3Wjg37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9C14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCF04k20xvY0x0EwIxGrw
	CFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE
	14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2
	IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxK
	x2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI
	0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUQSdkUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add 'nr_resv' parameter to ext4_da_reserve_space(), which indicates the
number of clusters wants to reserve, make it reserve multi-clusters once
a time.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/inode.c             | 18 +++++++++---------
 include/trace/events/ext4.h | 10 ++++++----
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 7918ae707716..429fb99e937a 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1450,9 +1450,9 @@ static int ext4_journalled_write_end(struct file *file,
 }
 
 /*
- * Reserve space for a single cluster
+ * Reserve space for 'nr_resv' clusters
  */
-static int ext4_da_reserve_space(struct inode *inode)
+static int ext4_da_reserve_space(struct inode *inode, int nr_resv)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	struct ext4_inode_info *ei = EXT4_I(inode);
@@ -1463,18 +1463,18 @@ static int ext4_da_reserve_space(struct inode *inode)
 	 * us from metadata over-estimation, though we may go over by
 	 * a small amount in the end.  Here we just reserve for data.
 	 */
-	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, 1));
+	ret = dquot_reserve_block(inode, EXT4_C2B(sbi, nr_resv));
 	if (ret)
 		return ret;
 
 	spin_lock(&ei->i_block_reservation_lock);
-	if (ext4_claim_free_clusters(sbi, 1, 0)) {
+	if (ext4_claim_free_clusters(sbi, nr_resv, 0)) {
 		spin_unlock(&ei->i_block_reservation_lock);
-		dquot_release_reservation_block(inode, EXT4_C2B(sbi, 1));
+		dquot_release_reservation_block(inode, EXT4_C2B(sbi, nr_resv));
 		return -ENOSPC;
 	}
-	ei->i_reserved_data_blocks++;
-	trace_ext4_da_reserve_space(inode);
+	ei->i_reserved_data_blocks += nr_resv;
+	trace_ext4_da_reserve_space(inode, nr_resv);
 	spin_unlock(&ei->i_block_reservation_lock);
 
 	return 0;       /* success */
@@ -1649,7 +1649,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	 * extents status tree doesn't get a match.
 	 */
 	if (sbi->s_cluster_ratio == 1) {
-		ret = ext4_da_reserve_space(inode);
+		ret = ext4_da_reserve_space(inode, 1);
 		if (ret != 0)   /* ENOSPC */
 			return ret;
 	} else {   /* bigalloc */
@@ -1661,7 +1661,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 				if (ret < 0)
 					return ret;
 				if (ret == 0) {
-					ret = ext4_da_reserve_space(inode);
+					ret = ext4_da_reserve_space(inode, 1);
 					if (ret != 0)   /* ENOSPC */
 						return ret;
 				} else {
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 6b41ac61310f..cc5e9b7b2b44 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -1246,14 +1246,15 @@ TRACE_EVENT(ext4_da_update_reserve_space,
 );
 
 TRACE_EVENT(ext4_da_reserve_space,
-	TP_PROTO(struct inode *inode),
+	TP_PROTO(struct inode *inode, int nr_resv),
 
-	TP_ARGS(inode),
+	TP_ARGS(inode, nr_resv),
 
 	TP_STRUCT__entry(
 		__field(	dev_t,	dev			)
 		__field(	ino_t,	ino			)
 		__field(	__u64,	i_blocks		)
+		__field(	int,	reserve_blocks		)
 		__field(	int,	reserved_data_blocks	)
 		__field(	__u16,  mode			)
 	),
@@ -1262,16 +1263,17 @@ TRACE_EVENT(ext4_da_reserve_space,
 		__entry->dev	= inode->i_sb->s_dev;
 		__entry->ino	= inode->i_ino;
 		__entry->i_blocks = inode->i_blocks;
+		__entry->reserve_blocks = nr_resv;
 		__entry->reserved_data_blocks = EXT4_I(inode)->i_reserved_data_blocks;
 		__entry->mode	= inode->i_mode;
 	),
 
-	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu "
+	TP_printk("dev %d,%d ino %lu mode 0%o i_blocks %llu reserve_blocks %d"
 		  "reserved_data_blocks %d",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->mode, __entry->i_blocks,
-		  __entry->reserved_data_blocks)
+		  __entry->reserve_blocks, __entry->reserved_data_blocks)
 );
 
 TRACE_EVENT(ext4_da_release_space,
-- 
2.39.2



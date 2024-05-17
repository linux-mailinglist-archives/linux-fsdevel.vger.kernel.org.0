Return-Path: <linux-fsdevel+bounces-19673-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33C3F8C8692
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 14:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEF762838A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2024 12:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58A6456768;
	Fri, 17 May 2024 12:51:04 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 213024EB44;
	Fri, 17 May 2024 12:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715950264; cv=none; b=hoFe8M4Qnn6CtzJS9A9ZLAUFNn8lFJPsKo3313FUtYw76+wM64jhSMruVexQpomthAs6xeLsyPiFORgpoQRLI/jvJ6mCHwqrUKCV4IFdkweBXinAJnbMbwhEJe4xM2mxR3dcZZOoVtNkIZRAzF/AfHG+kB4SOo+hMeJo4Z2Hzaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715950264; c=relaxed/simple;
	bh=2wWaa6VSQLwvEqpvvzQtkNzjtCzXSwJMnGI3vJyiJH0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N78+YkAkrMtV1AaH8yn66PRLgqGUYjf9AQxMvvA7bg0ooaijoA3ShrpbGoUnkQF4rSsDJxDb44pojrplEvRyVZXJgSzG5IZSP2G1sHeOnPJGdPyOV1pP9jO+30MApiOosSvAD9/a7xc1b65Vw9qkFWZlzEUwou/v78VCKBB2+mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VgmzJ2j1Sz4f3jqP;
	Fri, 17 May 2024 20:50:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 0354E1A01A7;
	Fri, 17 May 2024 20:50:58 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgBXKBGdUkdmdAmqMw--.14380S11;
	Fri, 17 May 2024 20:50:57 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [PATCH v5 07/10] ext4: make ext4_da_reserve_space() reserve multi-clusters
Date: Fri, 17 May 2024 20:40:02 +0800
Message-Id: <20240517124005.347221-8-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
References: <20240517124005.347221-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgBXKBGdUkdmdAmqMw--.14380S11
X-Coremail-Antispam: 1UD129KBjvJXoWxXF1DGFyUGr13ZF17urWDCFg_yoWrXFWDpF
	s8AFW7WryxZ34kWFWxZr4DZF4S9a4SqFWUtFZ7WFyxXry5J3WSqF1UKF1YvF1rtrWkGw4q
	qa45u348ua1jgFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP214x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JV
	WxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VU17G
	YJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add 'nr_resv' parameter to ext4_da_reserve_space(), which indicates the
number of clusters wants to reserve, make it reserve multiple clusters
at a time.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c             | 18 +++++++++---------
 include/trace/events/ext4.h | 10 ++++++----
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index f64fe8b873ce..0c52969654ac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1479,9 +1479,9 @@ static int ext4_journalled_write_end(struct file *file,
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
@@ -1492,18 +1492,18 @@ static int ext4_da_reserve_space(struct inode *inode)
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
@@ -1678,7 +1678,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
 	 * extents status tree doesn't get a match.
 	 */
 	if (sbi->s_cluster_ratio == 1) {
-		ret = ext4_da_reserve_space(inode);
+		ret = ext4_da_reserve_space(inode, 1);
 		if (ret != 0)   /* ENOSPC */
 			return ret;
 	} else {   /* bigalloc */
@@ -1690,7 +1690,7 @@ static int ext4_insert_delayed_block(struct inode *inode, ext4_lblk_t lblk)
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



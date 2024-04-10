Return-Path: <linux-fsdevel+bounces-16595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7480C89FA63
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 16:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29A3A2881E5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Apr 2024 14:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138AC181334;
	Wed, 10 Apr 2024 14:38:47 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A7117BB36;
	Wed, 10 Apr 2024 14:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712759926; cv=none; b=cSHvvx76+Oz4UYijg2EWAGxqczYHY639boLD4eeaww5pcTWPlDAYi2o2zfp4Tv8NKCgOOcpMEUc9/VT8/yvJBlhN+UF1ekR9GpMRtHvgfGHpQOulFLRYPOWGl+exAVLjCnV+FwVDHnPub7Q+nbrFUcS4+h/YcaNhuT4OjJznbYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712759926; c=relaxed/simple;
	bh=REqaiYcbviIXN7AfKS0rn3G78vsOc5DubRO5KYheWbg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bv4NhmNiaMGx6lR2E3nwZnJRGee4T7aygPhsnHcXVj99FDMJnida7ur6gfhvxgDGTh0NplNWlLxgMJa8CSWtdr9wpE9hYsBDAbpmfDPZy5ec2Y1oY/24ixaE5Ke+MlBo5b2yoTXAD8k+fkGd0m5STZXftPLASukYv/mKyZE6wPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VF56c3mg7z4f3knP;
	Wed, 10 Apr 2024 22:38:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5D3A11A0DB0;
	Wed, 10 Apr 2024 22:38:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX6RFSpBZmcwR8Jg--.63000S25;
	Wed, 10 Apr 2024 22:38:39 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v4 21/34] ext4: introduce seq counter for the extent status entry
Date: Wed, 10 Apr 2024 22:29:35 +0800
Message-Id: <20240410142948.2817554-22-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
References: <20240410142948.2817554-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX6RFSpBZmcwR8Jg--.63000S25
X-Coremail-Antispam: 1UD129KBjvJXoW3Wry3GrW7GF18AF4xJw4ruFg_yoW7uFWfpa
	s7ArWUWrZ5Xw4j9a1xXw10qr43Xa48WrW7Gr9IgryrZFWftrn8WF1DtFyjvF90qFW0kr17
	XFW0kryDA3W7WFDanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUHI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr1j6r
	xdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0D
	M2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4
	xG6I80ewAv7VC0I7IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCa
	FVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI4
	02YVCY1x02628vn2kIc2xKxwCY1x0262kKe7AKxVW8ZVWrXwCF04k20xvY0x0EwIxGrwCF
	x2IqxVCFs4IE7xkEbVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWDJVCq3wCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr
	1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr1j6F4U
	JwCI42IY6I8E87Iv6xkF7I0E14v26rxl6s0DYxBIdaVFxhVjvjDU0xZFpf9x0pRDPE-UUU
	UU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add a modify counter for the extent status entry, which indicates the
version of extent status of one inode, increase it once extent changes.
It it a preparation for the conversion of the regular file's buffered
write path from bh to iomap.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h              |  1 +
 fs/ext4/extents_status.c    | 13 ++++++++++++-
 fs/ext4/super.c             |  1 +
 include/trace/events/ext4.h | 20 ++++++++++++++------
 4 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 8d126654019e..7e27e1e7c579 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1115,6 +1115,7 @@ struct ext4_inode_info {
 	ext4_lblk_t i_es_shrink_lblk;	/* Offset where we start searching for
 					   extents to shrink. Protected by
 					   i_es_lock  */
+	unsigned int i_es_seq;		/* modify counter for extents */
 
 	/* ialloc */
 	ext4_group_t	i_last_alloc_group;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 926669d8eb3e..90b58cf42cdd 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -209,6 +209,13 @@ static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
 	return es->es_lblk + es->es_len - 1;
 }
 
+static inline void ext4_es_inc_seq(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	WRITE_ONCE(ei->i_es_seq, READ_ONCE(ei->i_es_seq) + 1);
+}
+
 /*
  * search through the tree for an delayed extent with a given offset.  If
  * it can't be found, try to find next extent.
@@ -876,6 +883,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	BUG_ON(end < lblk);
 	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
 
+	ext4_es_inc_seq(inode);
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, pblk, status);
@@ -1530,13 +1538,15 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-	trace_ext4_es_remove_extent(inode, lblk, len);
 	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
 		 lblk, len, inode->i_ino);
 
 	if (!len)
 		return;
 
+	ext4_es_inc_seq(inode);
+	trace_ext4_es_remove_extent(inode, lblk, len);
+
 	end = lblk + len - 1;
 	BUG_ON(end < lblk);
 
@@ -2111,6 +2121,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (!len)
 		return;
 
+	ext4_es_inc_seq(inode);
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, ~0, EXTENT_STATUS_DELAYED);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 044135796f2b..5fce4d2b3b87 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1421,6 +1421,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_es_all_nr = 0;
 	ei->i_es_shk_nr = 0;
 	ei->i_es_shrink_lblk = 0;
+	ei->i_es_seq = 0;
 	ei->i_reserved_data_blocks = 0;
 	spin_lock_init(&(ei->i_block_reservation_lock));
 	ext4_init_pending_tree(&ei->i_pending_tree);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index cc5e9b7b2b44..4d583d0248d9 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2183,6 +2183,7 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 		__field(	ext4_lblk_t,	len		)
 		__field(	ext4_fsblk_t,	pblk		)
 		__field(	char, status	)
+		__field(	unsigned int,	seq		)
 	),
 
 	TP_fast_assign(
@@ -2192,13 +2193,15 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 		__entry->len	= es->es_len;
 		__entry->pblk	= ext4_es_show_pblock(es);
 		__entry->status	= ext4_es_status(es);
+		__entry->seq	= EXT4_I(inode)->i_es_seq;
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s",
+	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s seq %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->lblk, __entry->len,
-		  __entry->pblk, show_extent_status(__entry->status))
+		  __entry->pblk, show_extent_status(__entry->status),
+		  __entry->seq)
 );
 
 DEFINE_EVENT(ext4__es_extent, ext4_es_insert_extent,
@@ -2223,6 +2226,7 @@ TRACE_EVENT(ext4_es_remove_extent,
 		__field(	ino_t,	ino			)
 		__field(	loff_t,	lblk			)
 		__field(	loff_t,	len			)
+		__field(	unsigned int, seq		)
 	),
 
 	TP_fast_assign(
@@ -2230,12 +2234,13 @@ TRACE_EVENT(ext4_es_remove_extent,
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
+		__entry->seq	= EXT4_I(inode)->i_es_seq;
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%lld/%lld)",
+	TP_printk("dev %d,%d ino %lu es [%lld/%lld) seq %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
-		  __entry->lblk, __entry->len)
+		  __entry->lblk, __entry->len, __entry->seq)
 );
 
 TRACE_EVENT(ext4_es_find_extent_range_enter,
@@ -2495,6 +2500,7 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 		__field(	char,		status		)
 		__field(	bool,		lclu_allocated	)
 		__field(	bool,		end_allocated	)
+		__field(	unsigned int,	seq		)
 	),
 
 	TP_fast_assign(
@@ -2506,15 +2512,17 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 		__entry->status		= ext4_es_status(es);
 		__entry->lclu_allocated	= lclu_allocated;
 		__entry->end_allocated	= end_allocated;
+		__entry->seq		= EXT4_I(inode)->i_es_seq;
 	),
 
 	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s "
-		  "allocated %d %d",
+		  "allocated %d %d seq %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->lblk, __entry->len,
 		  __entry->pblk, show_extent_status(__entry->status),
-		  __entry->lclu_allocated, __entry->end_allocated)
+		  __entry->lclu_allocated, __entry->end_allocated,
+		  __entry->seq)
 );
 
 /* fsmap traces */
-- 
2.39.2



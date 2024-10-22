Return-Path: <linux-fsdevel+bounces-32562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 564B89A96C1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 05:16:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0848A285F23
	for <lists+linux-fsdevel@lfdr.de>; Tue, 22 Oct 2024 03:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F8A01CB33A;
	Tue, 22 Oct 2024 03:13:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2135142E78;
	Tue, 22 Oct 2024 03:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729566785; cv=none; b=SONKffdL0qFhKUyjqwZi2C1EwvtRyzq6By6+oG2EQG5RV237UF72bpkuG1OdjN9qnfjuYNS1uzo9ov+nKW8a+sbHtmsFPw6pG2KiMwXXiL1w/Opn5tRiAyIWtQvYV6abVVFgNC/DV2GVRHPb8Fd2KNTLX/4MwLbLATygJ+8Uh+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729566785; c=relaxed/simple;
	bh=wA/+byRUE9HEVfAVPo0uMAiN7r+pgEmHZjo59/JZv7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c9wdkTPijzBpGuONDJL2IK4oF9uqsdzH9Dt35ucD7XZcmu479iYM9SQ9hvdwEh7HcfmD8hW67oApdPZJTbX9FZzXabQ3tuK0AkUeXPSyJjYohXEXlP8RJ6Au+MhCrMseH7Ej39TK1/mvXIw/73XEuljRusOus/AE+j6vHRQeWys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4XXcgC3PVqz4f3jY2;
	Tue, 22 Oct 2024 11:12:39 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D0FE91A018D;
	Tue, 22 Oct 2024 11:12:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.112.188])
	by APP4 (Coremail) with SMTP id gCh0CgCXysYlGBdnPSwWEw--.716S16;
	Tue, 22 Oct 2024 11:12:56 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	david@fromorbit.com,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH 12/27] ext4: introduce seq counter for the extent status entry
Date: Tue, 22 Oct 2024 19:10:43 +0800
Message-ID: <20241022111059.2566137-13-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
References: <20241022111059.2566137-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXysYlGBdnPSwWEw--.716S16
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW8WF4fuF1UCFWkuF15urg_yoW3GFWxpa
	9rAr15GrWkXw4q93WxZw4rWr43Wa48CrW7Gr9IgFWFvFW8tr1DKF1UtF1jvF98tFW0yrnr
	XFWFy34DA3WUWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUQl14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2048vs2IY02
	0E87I2jVAFwI0_JF0E3s1l82xGYIkIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0
	rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6x
	IIjxv20xvEc7CjxVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK
	6I8E87Iv6xkF7I0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4
	xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8
	JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20V
	AGYxC7M4IIrI8v6xkF7I0E8cxan2IY04v7MxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVW8ZVWrXwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r4j6ryUMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UMIIF0x
	vE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv
	6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7sRRgAFtUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

In the iomap_write_iter(), the iomap buffered write frame does not hold
any locks between querying the inode extent mapping info and performing
page cache writes. As a result, the extent mapping can be changed due to
concurrent I/O in flight. Similarly, in the iomap_writepage_map(), the
write-back process faces a similar problem: concurrent changes can
invalidate the extent mapping before the I/O is submitted.

Therefore, both of these processes must recheck the mapping info after
acquiring the folio lock. To address this, similar to XFS, we propose
introducing an extent sequence number to serve as a validity cookie for
the extent. We will increment this number whenever the extent status
tree changes, thereby preparing for the buffered write iomap conversion.
Besides, it also changes the trace code style to make checkpatch.pl
happy.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h              |  1 +
 fs/ext4/extents_status.c    | 13 ++++++++-
 fs/ext4/super.c             |  1 +
 include/trace/events/ext4.h | 57 +++++++++++++++++++++----------------
 4 files changed, 46 insertions(+), 26 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6d0267afd4c1..44f6867d3037 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1123,6 +1123,7 @@ struct ext4_inode_info {
 	ext4_lblk_t i_es_shrink_lblk;	/* Offset where we start searching for
 					   extents to shrink. Protected by
 					   i_es_lock  */
+	unsigned int i_es_seq;		/* Change counter for extents */
 
 	/* ialloc */
 	ext4_group_t	i_last_alloc_group;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index c786691dabd3..bea4f87db502 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -204,6 +204,13 @@ static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
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
@@ -872,6 +879,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	BUG_ON(end < lblk);
 	WARN_ON_ONCE(status & EXTENT_STATUS_DELAYED);
 
+	ext4_es_inc_seq(inode);
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, pblk, status);
@@ -1519,13 +1527,15 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
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
 
@@ -2107,6 +2117,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	WARN_ON_ONCE((EXT4_B2C(sbi, lblk) == EXT4_B2C(sbi, end)) &&
 		     end_allocated);
 
+	ext4_es_inc_seq(inode);
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, ~0, EXTENT_STATUS_DELAYED);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a4ce704460..a01e0bbe57c8 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1409,6 +1409,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_es_all_nr = 0;
 	ei->i_es_shk_nr = 0;
 	ei->i_es_shrink_lblk = 0;
+	ei->i_es_seq = 0;
 	ei->i_reserved_data_blocks = 0;
 	spin_lock_init(&(ei->i_block_reservation_lock));
 	ext4_init_pending_tree(&ei->i_pending_tree);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 156908641e68..6f2bf9035216 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2176,12 +2176,13 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 	TP_ARGS(inode, es),
 
 	TP_STRUCT__entry(
-		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
-		__field(	ext4_lblk_t,	lblk		)
-		__field(	ext4_lblk_t,	len		)
-		__field(	ext4_fsblk_t,	pblk		)
-		__field(	char, status	)
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(ext4_lblk_t,	lblk)
+		__field(ext4_lblk_t,	len)
+		__field(ext4_fsblk_t,	pblk)
+		__field(char,		status)
+		__field(unsigned int,	seq)
 	),
 
 	TP_fast_assign(
@@ -2191,13 +2192,15 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
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
@@ -2218,10 +2221,11 @@ TRACE_EVENT(ext4_es_remove_extent,
 	TP_ARGS(inode, lblk, len),
 
 	TP_STRUCT__entry(
-		__field(	dev_t,	dev			)
-		__field(	ino_t,	ino			)
-		__field(	loff_t,	lblk			)
-		__field(	loff_t,	len			)
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(loff_t,		lblk)
+		__field(loff_t,		len)
+		__field(unsigned int,	seq)
 	),
 
 	TP_fast_assign(
@@ -2229,12 +2233,13 @@ TRACE_EVENT(ext4_es_remove_extent,
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
@@ -2486,14 +2491,15 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 	TP_ARGS(inode, es, lclu_allocated, end_allocated),
 
 	TP_STRUCT__entry(
-		__field(	dev_t,		dev		)
-		__field(	ino_t,		ino		)
-		__field(	ext4_lblk_t,	lblk		)
-		__field(	ext4_lblk_t,	len		)
-		__field(	ext4_fsblk_t,	pblk		)
-		__field(	char,		status		)
-		__field(	bool,		lclu_allocated	)
-		__field(	bool,		end_allocated	)
+		__field(dev_t,		dev)
+		__field(ino_t,		ino)
+		__field(ext4_lblk_t,	lblk)
+		__field(ext4_lblk_t,	len)
+		__field(ext4_fsblk_t,	pblk)
+		__field(char,		status)
+		__field(bool,		lclu_allocated)
+		__field(bool,		end_allocated)
+		__field(unsigned int,	seq)
 	),
 
 	TP_fast_assign(
@@ -2505,15 +2511,16 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 		__entry->status		= ext4_es_status(es);
 		__entry->lclu_allocated	= lclu_allocated;
 		__entry->end_allocated	= end_allocated;
+		__entry->seq		= EXT4_I(inode)->i_es_seq;
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s "
-		  "allocated %d %d",
+	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s allocated %d %d seq %u",
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
2.46.1



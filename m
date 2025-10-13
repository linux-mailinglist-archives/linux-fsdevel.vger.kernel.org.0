Return-Path: <linux-fsdevel+bounces-63878-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2306DBD1263
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 03:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5171C3C182B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 01:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FA72F5324;
	Mon, 13 Oct 2025 01:52:51 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C91B2F1FD1;
	Mon, 13 Oct 2025 01:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760320370; cv=none; b=T0rxu87lXTB6Le6BPnLDViHarPQQetG+V32vs+WwK8ySO6I76eWxmqQCL1gHmNPnWz0WTSXIipLjVOM9I18XAJOFkS/7nHAdY5CtAGTXmNDsGoVVmISWMBGJH3akI3ZuswhaaGtXvJA0bbbo4hXY/b4wtczxo5ydBbj6GsjsozQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760320370; c=relaxed/simple;
	bh=gfXHwnkcrbxsGS9YWwNB2M+cSNzyC3eTDoTV3rbZoys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WgteuVFOp1xoyU/NZt2wchGNowAhHrsjW+HOD6rOKclvd8TQuSz2v9/cPf9eedQ/D0vMu3iIWN7R6xye/sHb0luo6zdIF901cwSMLAkXoATNX9qK9evg4Juc8oLLaUoj5H+sHArb6p8S5OMu5qLtaEgkjiman1JyZ8y7XhlXWTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4clL1r6kf0zYQtlj;
	Mon, 13 Oct 2025 09:52:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 8A2AC1A1AE3;
	Mon, 13 Oct 2025 09:52:39 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.85.155])
	by APP2 (Coremail) with SMTP id Syh0CgCn_UVfW+xoNhu7AA--.53067S6;
	Mon, 13 Oct 2025 09:52:39 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	libaokun1@huawei.com,
	yukuai3@huawei.com,
	yangerkun@huawei.com
Subject: [PATCH v4 02/12] ext4: introduce seq counter for the extent status entry
Date: Mon, 13 Oct 2025 09:51:18 +0800
Message-ID: <20251013015128.499308-3-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
References: <20251013015128.499308-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgCn_UVfW+xoNhu7AA--.53067S6
X-Coremail-Antispam: 1UD129KBjvJXoWxtrW8WF4Uur1kZw1DWr45Wrg_yoWfJF1DpF
	ZxAry5WrWfXw4j9ayxXw1UXr15Xa48WrW7Jr9Fg34fZFWrJFyqgF1DtFyjvF90qrWFvrnx
	XFWFyryDC3WUWa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUm014x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
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

In the iomap_write_iter(), the iomap buffered write frame does not hold
any locks between querying the inode extent mapping info and performing
page cache writes. As a result, the extent mapping can be changed due to
concurrent I/O in flight. Similarly, in the iomap_writepage_map(), the
write-back process faces a similar problem: concurrent changes can
invalidate the extent mapping before the I/O is submitted.

Therefore, both of these processes must recheck the mapping info after
acquiring the folio lock. To address this, similar to XFS, we propose
introducing an extent sequence number to serve as a validity cookie for
the extent. After commit 24b7a2331fcd ("ext4: clairfy the rules for
modifying extents"), we can ensure the extent information should always
be processed through the extent status tree, and the extent status tree
is always uptodate under i_rwsem or invalidate_lock or folio lock, so
it's safe to introduce this sequence number. The sequence number will be
increased whenever the extent status tree changes, preparing for the
buffered write iomap conversion.

Besides, this mechanism is also applicable for the moving extents case.
In move_extent_per_page(), it also needs to reacquire data_sem and check
the mapping info again under the folio lock.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h              |  2 ++
 fs/ext4/extents_status.c    | 25 +++++++++++++++++++++----
 fs/ext4/super.c             |  1 +
 include/trace/events/ext4.h | 23 +++++++++++++++--------
 4 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 57087da6c7be..eff97b3a1093 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1138,6 +1138,8 @@ struct ext4_inode_info {
 	ext4_lblk_t i_es_shrink_lblk;	/* Offset where we start searching for
 					   extents to shrink. Protected by
 					   i_es_lock  */
+	u64 i_es_seq;			/* Change counter for extents.
+					   Protected by i_es_lock */
 
 	/* ialloc */
 	ext4_group_t	i_last_alloc_group;
diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 31dc0496f8d0..c3daa57ecd35 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -235,6 +235,13 @@ static inline ext4_lblk_t ext4_es_end(struct extent_status *es)
 	return es->es_lblk + es->es_len - 1;
 }
 
+static inline void ext4_es_inc_seq(struct inode *inode)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+
+	WRITE_ONCE(ei->i_es_seq, ei->i_es_seq + 1);
+}
+
 /*
  * search through the tree for an delayed extent with a given offset.  If
  * it can't be found, try to find next extent.
@@ -906,7 +913,6 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, pblk, status);
-	trace_ext4_es_insert_extent(inode, &newes);
 
 	ext4_es_insert_extent_check(inode, &newes);
 
@@ -955,6 +961,11 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		}
 		pending = err3;
 	}
+	/*
+	 * TODO: For cache on-disk extents, there is no need to increment
+	 * the sequence counter, this requires future optimization.
+	 */
+	ext4_es_inc_seq(inode);
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	/*
@@ -981,6 +992,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (err1 || err2 || err3 < 0)
 		goto retry;
 
+	trace_ext4_es_insert_extent(inode, &newes);
 	ext4_es_print_tree(inode);
 	return;
 }
@@ -1550,7 +1562,6 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
 		return;
 
-	trace_ext4_es_remove_extent(inode, lblk, len);
 	es_debug("remove [%u/%u) from extent status tree of inode %lu\n",
 		 lblk, len, inode->i_ino);
 
@@ -1570,16 +1581,21 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
 	 */
 	write_lock(&EXT4_I(inode)->i_es_lock);
 	err = __es_remove_extent(inode, lblk, end, &reserved, es);
+	if (err)
+		goto error;
 	/* Free preallocated extent if it didn't get used. */
 	if (es) {
 		if (!es->es_len)
 			__es_free_extent(es);
 		es = NULL;
 	}
+	ext4_es_inc_seq(inode);
+error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	if (err)
 		goto retry;
 
+	trace_ext4_es_remove_extent(inode, lblk, len);
 	ext4_es_print_tree(inode);
 	ext4_da_release_space(inode, reserved);
 }
@@ -2140,8 +2156,6 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, ~0, EXTENT_STATUS_DELAYED);
-	trace_ext4_es_insert_delayed_extent(inode, &newes, lclu_allocated,
-					    end_allocated);
 
 	ext4_es_insert_extent_check(inode, &newes);
 
@@ -2196,11 +2210,14 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 			pr2 = NULL;
 		}
 	}
+	ext4_es_inc_seq(inode);
 error:
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 	if (err1 || err2 || err3 < 0)
 		goto retry;
 
+	trace_ext4_es_insert_delayed_extent(inode, &newes, lclu_allocated,
+					    end_allocated);
 	ext4_es_print_tree(inode);
 	ext4_print_pending_tree(inode);
 	return;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 33e7c08c9529..760c9d7588be 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1406,6 +1406,7 @@ static struct inode *ext4_alloc_inode(struct super_block *sb)
 	ei->i_es_all_nr = 0;
 	ei->i_es_shk_nr = 0;
 	ei->i_es_shrink_lblk = 0;
+	ei->i_es_seq = 0;
 	ei->i_reserved_data_blocks = 0;
 	spin_lock_init(&(ei->i_block_reservation_lock));
 	ext4_init_pending_tree(&ei->i_pending_tree);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index a374e7ea7e57..6a0754d38acf 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2210,7 +2210,8 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 		__field(	ext4_lblk_t,	lblk		)
 		__field(	ext4_lblk_t,	len		)
 		__field(	ext4_fsblk_t,	pblk		)
-		__field(	char, status	)
+		__field(	char,		status		)
+		__field(	u64,		seq		)
 	),
 
 	TP_fast_assign(
@@ -2220,13 +2221,15 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 		__entry->len	= es->es_len;
 		__entry->pblk	= ext4_es_show_pblock(es);
 		__entry->status	= ext4_es_status(es);
+		__entry->seq	= EXT4_I(inode)->i_es_seq;
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s",
+	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s seq %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->lblk, __entry->len,
-		  __entry->pblk, show_extent_status(__entry->status))
+		  __entry->pblk, show_extent_status(__entry->status),
+		  __entry->seq)
 );
 
 DEFINE_EVENT(ext4__es_extent, ext4_es_insert_extent,
@@ -2251,6 +2254,7 @@ TRACE_EVENT(ext4_es_remove_extent,
 		__field(	ino_t,	ino			)
 		__field(	loff_t,	lblk			)
 		__field(	loff_t,	len			)
+		__field(	u64,	seq			)
 	),
 
 	TP_fast_assign(
@@ -2258,12 +2262,13 @@ TRACE_EVENT(ext4_es_remove_extent,
 		__entry->ino	= inode->i_ino;
 		__entry->lblk	= lblk;
 		__entry->len	= len;
+		__entry->seq	= EXT4_I(inode)->i_es_seq;
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%lld/%lld)",
+	TP_printk("dev %d,%d ino %lu es [%lld/%lld) seq %llu",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
-		  __entry->lblk, __entry->len)
+		  __entry->lblk, __entry->len, __entry->seq)
 );
 
 TRACE_EVENT(ext4_es_find_extent_range_enter,
@@ -2523,6 +2528,7 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 		__field(	char,		status		)
 		__field(	bool,		lclu_allocated	)
 		__field(	bool,		end_allocated	)
+		__field(	u64,		seq		)
 	),
 
 	TP_fast_assign(
@@ -2534,15 +2540,16 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 		__entry->status		= ext4_es_status(es);
 		__entry->lclu_allocated	= lclu_allocated;
 		__entry->end_allocated	= end_allocated;
+		__entry->seq		= EXT4_I(inode)->i_es_seq;
 	),
 
-	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s "
-		  "allocated %d %d",
+	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s allocated %d %d seq %llu",
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



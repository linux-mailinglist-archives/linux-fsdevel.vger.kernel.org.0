Return-Path: <linux-fsdevel+bounces-9168-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA63083E966
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 03:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7471C210E7
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jan 2024 02:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D028B28DBC;
	Sat, 27 Jan 2024 02:02:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419B124B32;
	Sat, 27 Jan 2024 02:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320974; cv=none; b=lzptCdRmoQMWj/ZoCDxEdzWxpNaSctxhuTqs+Pnt+VSzr/nfW5GmOe4wo9EIkGf8+7JnmTs37fLjpS8IjXxcHuEAkU8KeQxEiWmJpRrrPjMj37KkReBkTa5KE+gT8rUc43v2E7d5f3azudeEd7T4cQi3nDMwE3TVRLHCKhrYmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320974; c=relaxed/simple;
	bh=55yETJWKGFyn7cuVmAYluzUa+XCk8LO94/gPNQ1RhJE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eirAqfNJGcF5x5E9QNhXzZ6GBKICuB9fz8KPHRg63svTAe6+ccPOVB9eXmoj0Ynf5kuOfPBEQIJFVXtXoQkcniZTeYviks67XTplLf62VSaKg0a9uarkh6rAhpzxWQ48JL4oDAI1BOgVgBl9rNx2FsmyOGpPRTxnBpNimWEouts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4TMHrk6XMHz4f3k6R;
	Sat, 27 Jan 2024 10:02:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 5358C1A0171;
	Sat, 27 Jan 2024 10:02:49 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgAX5g40ZLRlGJtmCA--.7377S19;
	Sat, 27 Jan 2024 10:02:49 +0800 (CST)
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
	willy@infradead.org,
	zokeefe@google.com,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com,
	wangkefeng.wang@huawei.com
Subject: [RFC PATCH v3 15/26] ext4: introduce seq counter for extent entry
Date: Sat, 27 Jan 2024 09:58:14 +0800
Message-Id: <20240127015825.1608160-16-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
References: <20240127015825.1608160-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgAX5g40ZLRlGJtmCA--.7377S19
X-Coremail-Antispam: 1UD129KBjvJXoW3Jw1kZw4xGFy8Jr4DGF15urg_yoW7Zr43pa
	97AryUGrZ3Xw4j9a1xXw10qr45Za48urW7Gr9Ig34rXFWftrn0gF1DtFyjvF90qFW0kr17
	XFW0kryDAa17WFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUPI14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JF0E3s1l82xGYI
	kIc2x26xkF7I0E14v26ryj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2
	z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F
	4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq
	3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7
	IYx2IY67AKxVWUXVWUAwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4U
	M4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2
	kIc2xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E
	14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_GFv_WrylIx
	kGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAF
	wI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr
	0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUl
	2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Add a modify counter for extents to indicate the version of one inode's
extent status, increase it once extent changes, it will be used for
converting regular file's buffered write path to iomap.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/ext4.h              |  1 +
 fs/ext4/extents_status.c    | 13 ++++++++++++-
 fs/ext4/super.c             |  1 +
 include/trace/events/ext4.h | 19 +++++++++++++------
 4 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 55195909d32f..287284a3f128 100644
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
index 324a6b0a6283..b0a4aa60b311 100644
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
@@ -876,6 +883,7 @@ void ext4_es_insert_extent(struct inode *inode, ext4_lblk_t lblk,
 		WARN_ON(1);
 	}
 
+	ext4_es_inc_seq(inode);
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, pblk, status);
@@ -1503,13 +1511,15 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
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
 
@@ -2080,6 +2090,7 @@ void ext4_es_insert_delayed_extent(struct inode *inode, ext4_lblk_t lblk,
 	if (!len)
 		return;
 
+	ext4_es_inc_seq(inode);
 	newes.es_lblk = lblk;
 	newes.es_len = len;
 	ext4_es_store_pblock_status(&newes, ~0, EXTENT_STATUS_DELAYED);
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c5fcf377ab1f..d4afaae8ab38 100644
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
index 53aa7a7fb3be..6ae504c43de7 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2186,6 +2186,7 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
 		__field(	ext4_lblk_t,	len		)
 		__field(	ext4_fsblk_t,	pblk		)
 		__field(	char, status	)
+		__field(	unsigned int,	seq		)
 	),
 
 	TP_fast_assign(
@@ -2195,13 +2196,15 @@ DECLARE_EVENT_CLASS(ext4__es_extent,
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
@@ -2226,6 +2229,7 @@ TRACE_EVENT(ext4_es_remove_extent,
 		__field(	ino_t,	ino			)
 		__field(	loff_t,	lblk			)
 		__field(	loff_t,	len			)
+		__field(	unsigned int, seq		)
 	),
 
 	TP_fast_assign(
@@ -2233,12 +2237,13 @@ TRACE_EVENT(ext4_es_remove_extent,
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
@@ -2497,6 +2502,7 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 		__field(	ext4_fsblk_t,	pblk		)
 		__field(	char,		status		)
 		__field(	bool,		allocated	)
+		__field(	unsigned int,	seq		)
 	),
 
 	TP_fast_assign(
@@ -2507,15 +2513,16 @@ TRACE_EVENT(ext4_es_insert_delayed_extent,
 		__entry->pblk		= ext4_es_show_pblock(es);
 		__entry->status		= ext4_es_status(es);
 		__entry->allocated	= allocated;
+		__entry->seq		= EXT4_I(inode)->i_es_seq;
 	),
 
 	TP_printk("dev %d,%d ino %lu es [%u/%u) mapped %llu status %s "
-		  "allocated %d",
+		  "allocated %d seq %u",
 		  MAJOR(__entry->dev), MINOR(__entry->dev),
 		  (unsigned long) __entry->ino,
 		  __entry->lblk, __entry->len,
 		  __entry->pblk, show_extent_status(__entry->status),
-		  __entry->allocated)
+		  __entry->allocated, __entry->seq)
 );
 
 /* fsmap traces */
-- 
2.39.2



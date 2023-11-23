Return-Path: <linux-fsdevel+bounces-3520-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A78487F5F64
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 13:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D781A1C21072
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Nov 2023 12:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF9A24B3F;
	Thu, 23 Nov 2023 12:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554D8D40;
	Thu, 23 Nov 2023 04:52:03 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4SbdKn2rYdz4f3kKH;
	Thu, 23 Nov 2023 20:51:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 244F31A03BD;
	Thu, 23 Nov 2023 20:52:00 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDn6xHdSl9lSfnfBg--.20473S5;
	Thu, 23 Nov 2023 20:51:59 +0800 (CST)
From: Zhang Yi <yi.zhang@huaweicloud.com>
To: linux-ext4@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org,
	tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	ritesh.list@gmail.com,
	hch@infradead.org,
	djwong@kernel.org,
	yi.zhang@huawei.com,
	yi.zhang@huaweicloud.com,
	chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: [RFC PATCH 01/18] ext4: introduce ext4_es_skip_hole_extent() to skip hole extents
Date: Thu, 23 Nov 2023 20:51:03 +0800
Message-Id: <20231123125121.4064694-2-yi.zhang@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
References: <20231123125121.4064694-1-yi.zhang@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDn6xHdSl9lSfnfBg--.20473S5
X-Coremail-Antispam: 1UD129KBjvJXoWxXF15ZFykZFyUurWfCF13XFb_yoWrJrWfpF
	9xZ345K3yrWwsF9ayfGw17Xr1Yqa48CrW7Jr9xKr1rK3WIqr9akF1UtFy2vF9YqrW8tr1Y
	qFW0k34DGa12ga7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBE14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kIc2
	xKxwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v2
	6r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2
	Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_
	Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMI
	IF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JU4T5dUUUUU
	=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

From: Zhang Yi <yi.zhang@huawei.com>

Introduce a new helper ext4_es_skip_hole_extent() to skip all hole
extents in a search range, return the valid lblk of next not hole extent
entry. It's useful to estimate and limit the length of a potential hole
returned when querying mapping status in ext4_map_blocks().

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/ext4/extents_status.c    | 32 ++++++++++++++++++++++++++++++++
 fs/ext4/extents_status.h    |  2 ++
 include/trace/events/ext4.h | 28 ++++++++++++++++++++++++++++
 3 files changed, 62 insertions(+)

diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
index 6f7de14c0fa8..1b1b1a8848a8 100644
--- a/fs/ext4/extents_status.c
+++ b/fs/ext4/extents_status.c
@@ -944,6 +944,38 @@ void ext4_es_cache_extent(struct inode *inode, ext4_lblk_t lblk,
 	write_unlock(&EXT4_I(inode)->i_es_lock);
 }
 
+/*
+ * ext4_es_skip_hole_extent() skip hole extents and loops up the next
+ * delayed/unwritten/mapped extent in extent status tree from lblk to
+ * end.
+ */
+ext4_lblk_t ext4_es_skip_hole_extent(struct inode *inode, ext4_lblk_t lblk,
+				     ext4_lblk_t len)
+{
+	struct extent_status *es = NULL;
+	ext4_lblk_t next_lblk;
+	struct rb_node *node;
+
+	read_lock(&EXT4_I(inode)->i_es_lock);
+	es = __es_tree_search(&EXT4_I(inode)->i_es_tree.root, lblk);
+
+	while (es && es->es_lblk < lblk + len) {
+		if (!ext4_es_is_hole(es))
+			break;
+		node = rb_next(&es->rb_node);
+		es = rb_entry(node, struct extent_status, rb_node);
+	}
+	if (!es || es->es_lblk >= lblk + len)
+		next_lblk = lblk + len;
+	else
+		next_lblk = es->es_lblk;
+
+	trace_ext4_es_skip_hole_extent(inode, lblk, len, next_lblk);
+	read_unlock(&EXT4_I(inode)->i_es_lock);
+
+	return next_lblk;
+}
+
 /*
  * ext4_es_lookup_extent() looks up an extent in extent status tree.
  *
diff --git a/fs/ext4/extents_status.h b/fs/ext4/extents_status.h
index d9847a4a25db..4f69322dd626 100644
--- a/fs/ext4/extents_status.h
+++ b/fs/ext4/extents_status.h
@@ -139,6 +139,8 @@ extern void ext4_es_find_extent_range(struct inode *inode,
 				      int (*match_fn)(struct extent_status *es),
 				      ext4_lblk_t lblk, ext4_lblk_t end,
 				      struct extent_status *es);
+ext4_lblk_t ext4_es_skip_hole_extent(struct inode *inode, ext4_lblk_t lblk,
+				     ext4_lblk_t len);
 extern int ext4_es_lookup_extent(struct inode *inode, ext4_lblk_t lblk,
 				 ext4_lblk_t *next_lblk,
 				 struct extent_status *es);
diff --git a/include/trace/events/ext4.h b/include/trace/events/ext4.h
index 65029dfb92fb..84421cecec0b 100644
--- a/include/trace/events/ext4.h
+++ b/include/trace/events/ext4.h
@@ -2291,6 +2291,34 @@ TRACE_EVENT(ext4_es_find_extent_range_exit,
 		  __entry->pblk, show_extent_status(__entry->status))
 );
 
+TRACE_EVENT(ext4_es_skip_hole_extent,
+	TP_PROTO(struct inode *inode, ext4_lblk_t lblk,
+		 ext4_lblk_t len, ext4_lblk_t next_lblk),
+
+	TP_ARGS(inode, lblk, len, next_lblk),
+
+	TP_STRUCT__entry(
+		__field(	dev_t,		dev		)
+		__field(	ino_t,		ino		)
+		__field(	ext4_lblk_t,	lblk		)
+		__field(	ext4_lblk_t,	len		)
+		__field(	ext4_lblk_t,	next		)
+	),
+
+	TP_fast_assign(
+		__entry->dev	= inode->i_sb->s_dev;
+		__entry->ino	= inode->i_ino;
+		__entry->lblk	= lblk;
+		__entry->len	= len;
+		__entry->next	= next_lblk;
+	),
+
+	TP_printk("dev %d,%d ino %lu [%u/%u) next_lblk %u",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  (unsigned long) __entry->ino, __entry->lblk,
+		  __entry->len, __entry->next)
+);
+
 TRACE_EVENT(ext4_es_lookup_extent_enter,
 	TP_PROTO(struct inode *inode, ext4_lblk_t lblk),
 
-- 
2.39.2



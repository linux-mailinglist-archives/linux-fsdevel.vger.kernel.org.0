Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FFB5A7732
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 09:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiHaHKM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 03:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230422AbiHaHKH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:10:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A9CD11C07;
        Wed, 31 Aug 2022 00:10:05 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MHZwb08D9zlWfH;
        Wed, 31 Aug 2022 15:06:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 15:10:02 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>,
        <ntfs3@lists.linux.dev>, <ocfs2-devel@oss.oracle.com>,
        <reiserfs-devel@vger.kernel.org>
CC:     <jack@suse.cz>, <tytso@mit.edu>, <akpm@linux-foundation.org>,
        <axboe@kernel.dk>, <viro@zeniv.linux.org.uk>,
        <rpeterso@redhat.com>, <agruenba@redhat.com>,
        <almaz.alexandrovich@paragon-software.com>, <mark@fasheh.com>,
        <dushistov@mail.ru>, <hch@infradead.org>, <yi.zhang@huawei.com>,
        <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 02/14] fs/buffer: add some new buffer read helpers
Date:   Wed, 31 Aug 2022 15:20:59 +0800
Message-ID: <20220831072111.3569680-3-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220831072111.3569680-1-yi.zhang@huawei.com>
References: <20220831072111.3569680-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Current ll_rw_block() helper is fragile because it assumes that locked
buffer means it's under IO which is submitted by some other who hold
the lock, it skip buffer if it failed to get the lock, so it's only
safe on the readahead path. Unfortunately, now that most filesystems
still use this helper mistakenly on the sync metadata read path. There
is no guarantee that the one who hold the buffer lock always submit IO
(e.g. buffer_migrate_folio_norefs() after commit 88dbcbb3a484 ("blkdev:
avoid migration stalls for blkdev pages"), it could lead to false
positive -EIO when submitting reading IO.

This patch add some friendly buffer read helpers to prepare replace
ll_rw_block() and similar calls. We can only call bh_readahead_[]
helpers for the readahead paths.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/buffer.c                 | 68 +++++++++++++++++++++++++++++++++++++
 include/linux/buffer_head.h | 37 ++++++++++++++++++++
 2 files changed, 105 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index a0b70b3239f3..a663191903ed 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3017,6 +3017,74 @@ int bh_uptodate_or_lock(struct buffer_head *bh)
 }
 EXPORT_SYMBOL(bh_uptodate_or_lock);
 
+/**
+ * __bh_read - Submit read for a locked buffer
+ * @bh: struct buffer_head
+ * @op_flags: appending REQ_OP_* flags besides REQ_OP_READ
+ * @wait: wait until reading finish
+ *
+ * Returns zero on success or don't wait, and -EIO on error.
+ */
+int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait)
+{
+	int ret = 0;
+
+	BUG_ON(!buffer_locked(bh));
+
+	if (buffer_uptodate(bh)) {
+		unlock_buffer(bh);
+		return ret;
+	}
+
+	get_bh(bh);
+	bh->b_end_io = end_buffer_read_sync;
+	submit_bh(REQ_OP_READ | op_flags, bh);
+	if (wait) {
+		wait_on_buffer(bh);
+		if (!buffer_uptodate(bh))
+			ret = -EIO;
+	}
+	return ret;
+}
+EXPORT_SYMBOL(__bh_read);
+
+/**
+ * __bh_read_batch - Submit read for a batch of unlocked buffers
+ * @bhs: a batch of struct buffer_head
+ * @nr: number of this batch
+ * @op_flags: appending REQ_OP_* flags besides REQ_OP_READ
+ * @force_lock: force to get a lock on the buffer if set, otherwise drops any
+ *              buffer that cannot lock.
+ *
+ * Returns zero on success or don't wait, and -EIO on error.
+ */
+void __bh_read_batch(struct buffer_head *bhs[],
+		     int nr, blk_opf_t op_flags, bool force_lock)
+{
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		struct buffer_head *bh = bhs[i];
+
+		if (buffer_uptodate(bh))
+			continue;
+		if (!trylock_buffer(bh)) {
+			if (!force_lock)
+				continue;
+			lock_buffer(bh);
+		}
+		if (buffer_uptodate(bh)) {
+			unlock_buffer(bh);
+			continue;
+		}
+
+		bh->b_end_io = end_buffer_read_sync;
+		get_bh(bh);
+		submit_bh(REQ_OP_READ | op_flags, bh);
+	}
+}
+EXPORT_SYMBOL(__bh_read_batch);
+
 /**
  * bh_submit_read - Submit a locked buffer for reading
  * @bh: struct buffer_head
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index c3863c417b00..8a01c07c0418 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -232,6 +232,9 @@ void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
 int bh_submit_read(struct buffer_head *bh);
+int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
+void __bh_read_batch(struct buffer_head *bhs[],
+		     int nr, blk_opf_t op_flags, bool force_lock);
 
 extern int buffer_heads_over_limit;
 
@@ -399,6 +402,40 @@ static inline struct buffer_head *__getblk(struct block_device *bdev,
 	return __getblk_gfp(bdev, block, size, __GFP_MOVABLE);
 }
 
+static inline void bh_readahead(struct buffer_head *bh, blk_opf_t op_flags)
+{
+	if (trylock_buffer(bh))
+		__bh_read(bh, op_flags, false);
+}
+
+static inline void bh_read_nowait(struct buffer_head *bh, blk_opf_t op_flags)
+{
+	lock_buffer(bh);
+	__bh_read(bh, op_flags, false);
+}
+
+static inline int bh_read(struct buffer_head *bh, blk_opf_t op_flags)
+{
+	lock_buffer(bh);
+	return __bh_read(bh, op_flags, true);
+}
+
+static inline int bh_read_locked(struct buffer_head *bh, blk_opf_t op_flags)
+{
+	return __bh_read(bh, op_flags, true);
+}
+
+static inline void bh_read_batch(struct buffer_head *bhs[], int nr)
+{
+	__bh_read_batch(bhs, nr, 0, true);
+}
+
+static inline void bh_readahead_batch(struct buffer_head *bhs[], int nr,
+				      blk_opf_t op_flags)
+{
+	__bh_read_batch(bhs, nr, op_flags, false);
+}
+
 /**
  *  __bread() - reads a specified block and returns the bh
  *  @bdev: the block_device to read from
-- 
2.31.1


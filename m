Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22BBB5A98C6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 15:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbiIANZ3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 09:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbiIANYU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:24:20 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B7B28E28;
        Thu,  1 Sep 2022 06:24:08 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJM9g5tNTzlWhS;
        Thu,  1 Sep 2022 21:20:39 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 21:24:05 +0800
From:   Zhang Yi <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cluster-devel@redhat.com>,
        <ntfs3@lists.linux.dev>, <ocfs2-devel@oss.oracle.com>,
        <reiserfs-devel@vger.kernel.org>, <jack@suse.cz>
CC:     <tytso@mit.edu>, <akpm@linux-foundation.org>, <axboe@kernel.dk>,
        <viro@zeniv.linux.org.uk>, <rpeterso@redhat.com>,
        <agruenba@redhat.com>, <almaz.alexandrovich@paragon-software.com>,
        <mark@fasheh.com>, <dushistov@mail.ru>, <hch@infradead.org>,
        <yi.zhang@huawei.com>, <chengzhihao1@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH v2 09/14] reiserfs: replace ll_rw_block()
Date:   Thu, 1 Sep 2022 21:35:00 +0800
Message-ID: <20220901133505.2510834-10-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220901133505.2510834-1-yi.zhang@huawei.com>
References: <20220901133505.2510834-1-yi.zhang@huawei.com>
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

ll_rw_block() is not safe for the sync read/write path because it cannot
guarantee that submitting read/write IO if the buffer has been locked.
We could get false positive EIO after wait_on_buffer() in read path if
the buffer has been locked by others. So stop using ll_rw_block() in
reiserfs. We also switch to new bh_readahead_batch() helper for the
buffer array readahead path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/reiserfs/journal.c | 11 ++++++-----
 fs/reiserfs/stree.c   |  4 ++--
 fs/reiserfs/super.c   |  4 +---
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/fs/reiserfs/journal.c b/fs/reiserfs/journal.c
index 94addfcefede..9f62da7471c9 100644
--- a/fs/reiserfs/journal.c
+++ b/fs/reiserfs/journal.c
@@ -868,7 +868,7 @@ static int write_ordered_buffers(spinlock_t * lock,
 		 */
 		if (buffer_dirty(bh) && unlikely(bh->b_page->mapping == NULL)) {
 			spin_unlock(lock);
-			ll_rw_block(REQ_OP_WRITE, 1, &bh);
+			write_dirty_buffer(bh, 0);
 			spin_lock(lock);
 		}
 		put_bh(bh);
@@ -1054,7 +1054,7 @@ static int flush_commit_list(struct super_block *s,
 		if (tbh) {
 			if (buffer_dirty(tbh)) {
 		            depth = reiserfs_write_unlock_nested(s);
-			    ll_rw_block(REQ_OP_WRITE, 1, &tbh);
+			    write_dirty_buffer(tbh, 0);
 			    reiserfs_write_lock_nested(s, depth);
 			}
 			put_bh(tbh) ;
@@ -2240,7 +2240,7 @@ static int journal_read_transaction(struct super_block *sb,
 		}
 	}
 	/* read in the log blocks, memcpy to the corresponding real block */
-	ll_rw_block(REQ_OP_READ, get_desc_trans_len(desc), log_blocks);
+	bh_read_batch(get_desc_trans_len(desc), log_blocks);
 	for (i = 0; i < get_desc_trans_len(desc); i++) {
 
 		wait_on_buffer(log_blocks[i]);
@@ -2342,10 +2342,11 @@ static struct buffer_head *reiserfs_breada(struct block_device *dev,
 		} else
 			bhlist[j++] = bh;
 	}
-	ll_rw_block(REQ_OP_READ, j, bhlist);
+	bh = bhlist[0];
+	bh_read_nowait(bh, 0);
+	bh_readahead_batch(j - 1, &bhlist[1], 0);
 	for (i = 1; i < j; i++)
 		brelse(bhlist[i]);
-	bh = bhlist[0];
 	wait_on_buffer(bh);
 	if (buffer_uptodate(bh))
 		return bh;
diff --git a/fs/reiserfs/stree.c b/fs/reiserfs/stree.c
index 9a293609a022..84c12a1947b2 100644
--- a/fs/reiserfs/stree.c
+++ b/fs/reiserfs/stree.c
@@ -579,7 +579,7 @@ static int search_by_key_reada(struct super_block *s,
 		if (!buffer_uptodate(bh[j])) {
 			if (depth == -1)
 				depth = reiserfs_write_unlock_nested(s);
-			ll_rw_block(REQ_OP_READ | REQ_RAHEAD, 1, bh + j);
+			bh_readahead(bh[j], REQ_RAHEAD);
 		}
 		brelse(bh[j]);
 	}
@@ -685,7 +685,7 @@ int search_by_key(struct super_block *sb, const struct cpu_key *key,
 			if (!buffer_uptodate(bh) && depth == -1)
 				depth = reiserfs_write_unlock_nested(sb);
 
-			ll_rw_block(REQ_OP_READ, 1, &bh);
+			bh_read_nowait(bh, 0);
 			wait_on_buffer(bh);
 
 			if (depth != -1)
diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index c88cd2ce0665..a5ffec0c7517 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1702,9 +1702,7 @@ static int read_super_block(struct super_block *s, int offset)
 /* after journal replay, reread all bitmap and super blocks */
 static int reread_meta_blocks(struct super_block *s)
 {
-	ll_rw_block(REQ_OP_READ, 1, &SB_BUFFER_WITH_SB(s));
-	wait_on_buffer(SB_BUFFER_WITH_SB(s));
-	if (!buffer_uptodate(SB_BUFFER_WITH_SB(s))) {
+	if (bh_read(SB_BUFFER_WITH_SB(s), 0) < 0) {
 		reiserfs_warning(s, "reiserfs-2504", "error reading the super");
 		return 1;
 	}
-- 
2.31.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB87F5A7729
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 09:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbiHaHKZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 03:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230454AbiHaHKL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:10:11 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 013D117056;
        Wed, 31 Aug 2022 00:10:09 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MHZwN44tbz1N7gY;
        Wed, 31 Aug 2022 15:06:28 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 31 Aug
 2022 15:10:06 +0800
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
Subject: [PATCH 06/14] jbd2: replace ll_rw_block()
Date:   Wed, 31 Aug 2022 15:21:03 +0800
Message-ID: <20220831072111.3569680-7-yi.zhang@huawei.com>
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

ll_rw_block() is not safe for the sync read path because it cannot
guarantee that submitting read IO if the buffer has been locked. We
could get false positive EIO after wait_on_buffer() if the buffer has
been locked by others. So stop using ll_rw_block() in
journal_get_superblock(). We also switch to new bh_readahead_batch()
for the buffer array readahead path.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
---
 fs/jbd2/journal.c  |  7 +++----
 fs/jbd2/recovery.c | 16 ++++++++++------
 2 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 6350d3857c89..5a903aae6aad 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1893,15 +1893,14 @@ static int journal_get_superblock(journal_t *journal)
 {
 	struct buffer_head *bh;
 	journal_superblock_t *sb;
-	int err = -EIO;
+	int err;
 
 	bh = journal->j_sb_buffer;
 
 	J_ASSERT(bh != NULL);
 	if (!buffer_uptodate(bh)) {
-		ll_rw_block(REQ_OP_READ, 1, &bh);
-		wait_on_buffer(bh);
-		if (!buffer_uptodate(bh)) {
+		err = bh_read(bh, 0);
+		if (err) {
 			printk(KERN_ERR
 				"JBD2: IO error reading journal superblock\n");
 			goto out;
diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
index f548479615c6..ee56a30b71cf 100644
--- a/fs/jbd2/recovery.c
+++ b/fs/jbd2/recovery.c
@@ -100,7 +100,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
 		if (!buffer_uptodate(bh) && !buffer_locked(bh)) {
 			bufs[nbufs++] = bh;
 			if (nbufs == MAXBUF) {
-				ll_rw_block(REQ_OP_READ, nbufs, bufs);
+				bh_readahead_batch(bufs, nbufs, 0);
 				journal_brelse_array(bufs, nbufs);
 				nbufs = 0;
 			}
@@ -109,7 +109,7 @@ static int do_readahead(journal_t *journal, unsigned int start)
 	}
 
 	if (nbufs)
-		ll_rw_block(REQ_OP_READ, nbufs, bufs);
+		bh_readahead_batch(bufs, nbufs, 0);
 	err = 0;
 
 failed:
@@ -152,9 +152,14 @@ static int jread(struct buffer_head **bhp, journal_t *journal,
 		return -ENOMEM;
 
 	if (!buffer_uptodate(bh)) {
-		/* If this is a brand new buffer, start readahead.
-                   Otherwise, we assume we are already reading it.  */
-		if (!buffer_req(bh))
+		/*
+		 * If this is a brand new buffer, start readahead.
+		 * Otherwise, we assume we are already reading it.
+		 */
+		bool need_readahead = !buffer_req(bh);
+
+		bh_read_nowait(bh, 0);
+		if (need_readahead)
 			do_readahead(journal, offset);
 		wait_on_buffer(bh);
 	}
@@ -687,7 +692,6 @@ static int do_one_pass(journal_t *journal,
 					mark_buffer_dirty(nbh);
 					BUFFER_TRACE(nbh, "marking uptodate");
 					++info->nr_replays;
-					/* ll_rw_block(WRITE, 1, &nbh); */
 					unlock_buffer(nbh);
 					brelse(obh);
 					brelse(nbh);
-- 
2.31.1


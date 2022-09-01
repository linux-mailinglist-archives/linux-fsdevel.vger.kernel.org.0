Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 972145A98A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 15:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbiIAN0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 09:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbiIANYd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 09:24:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4580813D5B;
        Thu,  1 Sep 2022 06:24:13 -0700 (PDT)
Received: from canpemm500005.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MJM9T646DzkWrK;
        Thu,  1 Sep 2022 21:20:29 +0800 (CST)
Received: from huawei.com (10.175.127.227) by canpemm500005.china.huawei.com
 (7.192.104.229) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 21:24:09 +0800
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
Subject: [PATCH v2 14/14] fs/buffer: remove bh_submit_read() helper
Date:   Thu, 1 Sep 2022 21:35:05 +0800
Message-ID: <20220901133505.2510834-15-yi.zhang@huawei.com>
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

bh_submit_read() has no user anymore, just remove it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/buffer.c                 | 25 -------------------------
 include/linux/buffer_head.h |  1 -
 2 files changed, 26 deletions(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index 2cccc7586b99..b4c9fff3ab6c 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -3025,31 +3025,6 @@ void __bh_read_batch(int nr, struct buffer_head *bhs[],
 }
 EXPORT_SYMBOL(__bh_read_batch);
 
-/**
- * bh_submit_read - Submit a locked buffer for reading
- * @bh: struct buffer_head
- *
- * Returns zero on success and -EIO on error.
- */
-int bh_submit_read(struct buffer_head *bh)
-{
-	BUG_ON(!buffer_locked(bh));
-
-	if (buffer_uptodate(bh)) {
-		unlock_buffer(bh);
-		return 0;
-	}
-
-	get_bh(bh);
-	bh->b_end_io = end_buffer_read_sync;
-	submit_bh(REQ_OP_READ, bh);
-	wait_on_buffer(bh);
-	if (buffer_uptodate(bh))
-		return 0;
-	return -EIO;
-}
-EXPORT_SYMBOL(bh_submit_read);
-
 void __init buffer_init(void)
 {
 	unsigned long nrpages;
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index b415d8bc2a09..9b6556d3f110 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -230,7 +230,6 @@ int submit_bh(blk_opf_t, struct buffer_head *);
 void write_boundary_block(struct block_device *bdev,
 			sector_t bblock, unsigned blocksize);
 int bh_uptodate_or_lock(struct buffer_head *bh);
-int bh_submit_read(struct buffer_head *bh);
 int __bh_read(struct buffer_head *bh, blk_opf_t op_flags, bool wait);
 void __bh_read_batch(int nr, struct buffer_head *bhs[],
 		     blk_opf_t op_flags, bool force_lock);
-- 
2.31.1


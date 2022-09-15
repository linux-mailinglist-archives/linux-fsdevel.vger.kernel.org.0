Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D5B5B97B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 11:43:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiIOJmZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 05:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiIOJmR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:42:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400D289CD3;
        Thu, 15 Sep 2022 02:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Sn1STluEcmAEl2IDkRqQTtdfy5beUs4WRE2QQKAsD/8=; b=os6+qAq+Yh06rcP0f4OouU/22o
        oWMxav2lmp8ydZQlV6kYJHiVg8ZVYPX5Z5bUp7SoaxqFj/nUS4D885nff+ExvyS+/ZeTUGV4jsgEU
        ER77a8FARvGVxYQc08pU28vamvOLA93UJlOYB+wMD6hJYfaFlwU7gVGEBvA4QBbVOudz8qGi3zl6j
        PD4HWCk7kfMEuJEharZdxwNNq3YjLexhD9ZuJU9XTK/fP5VUj1cnMn1ePeBY44Kxrp22zlpCAneVa
        pYT72nSZOveSvkojw81g64FzZrU9pT28Z+dU81UCAkWPRoOJZqNkQwmhvF/DotA52n+uG+9hsXvG2
        598sGqsQ==;
Received: from [185.122.133.20] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYlNq-005b3C-78; Thu, 15 Sep 2022 09:42:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>, Gao Xiang <xiang@kernel.org>,
        Chao Yu <chao@kernel.org>, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-erofs@lists.ozlabs.org, linux-mm@kvack.org
Subject: [PATCH 3/5] btrfs: add manual PSI accounting for compressed reads
Date:   Thu, 15 Sep 2022 10:41:58 +0100
Message-Id: <20220915094200.139713-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220915094200.139713-1-hch@lst.de>
References: <20220915094200.139713-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

btrfs compressed reads try to always read the entire compressed chunk,
even if only a subset is requested.  Currently this is covered by the
magic PSI accounting underneath submit_bio, but that is about to go
away. Instead add manual psi_memstall_{enter,leave} annotations.

Note that for readahead this really should be using readahead_expand,
but the additionals reads are also done for plain ->read_folio where
readahead_expand can't work, so this overall logic is left as-is for
now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: David Sterba <dsterba@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 fs/btrfs/compression.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/compression.c b/fs/btrfs/compression.c
index e84d22c5c6a83..370788b9b1249 100644
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@ -15,6 +15,7 @@
 #include <linux/string.h>
 #include <linux/backing-dev.h>
 #include <linux/writeback.h>
+#include <linux/psi.h>
 #include <linux/slab.h>
 #include <linux/sched/mm.h>
 #include <linux/log2.h>
@@ -519,7 +520,8 @@ static u64 bio_end_offset(struct bio *bio)
  */
 static noinline int add_ra_bio_pages(struct inode *inode,
 				     u64 compressed_end,
-				     struct compressed_bio *cb)
+				     struct compressed_bio *cb,
+				     unsigned long *pflags)
 {
 	struct btrfs_fs_info *fs_info = btrfs_sb(inode->i_sb);
 	unsigned long end_index;
@@ -588,6 +590,9 @@ static noinline int add_ra_bio_pages(struct inode *inode,
 			continue;
 		}
 
+		if (PageWorkingset(page))
+			psi_memstall_enter(pflags);
+
 		ret = set_page_extent_mapped(page);
 		if (ret < 0) {
 			unlock_page(page);
@@ -674,6 +679,8 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 	u64 em_len;
 	u64 em_start;
 	struct extent_map *em;
+	/* Initialize to 1 to make skip psi_memstall_leave unless needed */
+	unsigned long pflags = 1;
 	blk_status_t ret;
 	int ret2;
 	int i;
@@ -729,7 +736,7 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		goto fail;
 	}
 
-	add_ra_bio_pages(inode, em_start + em_len, cb);
+	add_ra_bio_pages(inode, em_start + em_len, cb, &pflags);
 
 	/* include any pages we added in add_ra-bio_pages */
 	cb->len = bio->bi_iter.bi_size;
@@ -810,6 +817,9 @@ void btrfs_submit_compressed_read(struct inode *inode, struct bio *bio,
 		}
 	}
 
+	if (!pflags)
+		psi_memstall_leave(&pflags);
+
 	if (refcount_dec_and_test(&cb->pending_ios))
 		finish_compressed_bio_read(cb);
 	return;
-- 
2.30.2


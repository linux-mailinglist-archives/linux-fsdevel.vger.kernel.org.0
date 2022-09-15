Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7368A5B97BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Sep 2022 11:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbiIOJmf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Sep 2022 05:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiIOJmX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Sep 2022 05:42:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8767E8992D;
        Thu, 15 Sep 2022 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=PzlrQ8oKvfWNjDBiduvx+RzNOBIgqE2Y/9GDFrAa5zA=; b=bXeNhFFDCpfkRWHXmWzdHwlB5U
        ebzGk7+4exPACeou4fI+Sm6JQFfbX33mPhr7e+OY/vsBOl+7KB4pjS4bZIZmQBKspIrcU6Do7JYgB
        H66JJ5LEpcNzjlgpmde8OXP0YN93isg92RFIGpYP4eIsiAM2zsRgJ64ui9RH8ZXVhVfDu0YBFF3LE
        M5dml3Id3wks6W5Ui9PYxUv0W0G0mv5pIbLUdioFpLJQdNk+eUZyJq95PBmrV2Ra3D8ir74eOeDfy
        DZdcZFhb46yvO66ykAJ0TjIXLo+uKG2Nxo+zFLhSQr8Qeiaf7+ctmRj1h1E2s4mnsAnzj/LV9UNQv
        0kRBcInw==;
Received: from [185.122.133.20] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oYlNu-005b8U-Qp; Thu, 15 Sep 2022 09:42:15 +0000
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
Subject: [PATCH 5/5] block: remove PSI accounting from the bio layer
Date:   Thu, 15 Sep 2022 10:42:00 +0100
Message-Id: <20220915094200.139713-6-hch@lst.de>
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

PSI accounting is now done by the VM code, where it should have been
since the beginning.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
 block/bio.c               |  8 --------
 block/blk-core.c          | 17 -----------------
 fs/direct-io.c            |  2 --
 include/linux/blk_types.h |  1 -
 4 files changed, 28 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 3d3a2678fea25..d10c4e888cdcf 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1065,9 +1065,6 @@ void __bio_add_page(struct bio *bio, struct page *page,
 
 	bio->bi_iter.bi_size += len;
 	bio->bi_vcnt++;
-
-	if (!bio_flagged(bio, BIO_WORKINGSET) && unlikely(PageWorkingset(page)))
-		bio_set_flag(bio, BIO_WORKINGSET);
 }
 EXPORT_SYMBOL_GPL(__bio_add_page);
 
@@ -1276,9 +1273,6 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
  * fit into the bio, or are requested in @iter, whatever is smaller. If
  * MM encounters an error pinning the requested pages, it stops. Error
  * is returned only if 0 pages could be pinned.
- *
- * It's intended for direct IO, so doesn't do PSI tracking, the caller is
- * responsible for setting BIO_WORKINGSET if necessary.
  */
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1294,8 +1288,6 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
 
-	/* don't account direct I/O as memory stall */
-	bio_clear_flag(bio, BIO_WORKINGSET);
 	return bio->bi_vcnt ? 0 : ret;
 }
 EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
diff --git a/block/blk-core.c b/block/blk-core.c
index a0d1104c5590c..9e19195af6f5b 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -37,7 +37,6 @@
 #include <linux/t10-pi.h>
 #include <linux/debugfs.h>
 #include <linux/bpf.h>
-#include <linux/psi.h>
 #include <linux/part_stat.h>
 #include <linux/sched/sysctl.h>
 #include <linux/blk-crypto.h>
@@ -829,22 +828,6 @@ void submit_bio(struct bio *bio)
 		count_vm_events(PGPGOUT, bio_sectors(bio));
 	}
 
-	/*
-	 * If we're reading data that is part of the userspace workingset, count
-	 * submission time as memory stall.  When the device is congested, or
-	 * the submitting cgroup IO-throttled, submission can be a significant
-	 * part of overall IO time.
-	 */
-	if (unlikely(bio_op(bio) == REQ_OP_READ &&
-	    bio_flagged(bio, BIO_WORKINGSET))) {
-		unsigned long pflags;
-
-		psi_memstall_enter(&pflags);
-		submit_bio_noacct(bio);
-		psi_memstall_leave(&pflags);
-		return;
-	}
-
 	submit_bio_noacct(bio);
 }
 EXPORT_SYMBOL(submit_bio);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index f669163d5860f..03d381377ae10 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -421,8 +421,6 @@ static inline void dio_bio_submit(struct dio *dio, struct dio_submit *sdio)
 	unsigned long flags;
 
 	bio->bi_private = dio;
-	/* don't account direct I/O as memory stall */
-	bio_clear_flag(bio, BIO_WORKINGSET);
 
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	dio->refcount++;
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 1ef99790f6ed3..8b1858df21752 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -321,7 +321,6 @@ enum {
 	BIO_NO_PAGE_REF,	/* don't put release vec pages */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
-	BIO_WORKINGSET,		/* contains userspace workingset pages */
 	BIO_QUIET,		/* Make BIO Quiet */
 	BIO_CHAIN,		/* chained bio, ->bi_remaining in effect */
 	BIO_REFFED,		/* bio has elevated ->bi_cnt */
-- 
2.30.2


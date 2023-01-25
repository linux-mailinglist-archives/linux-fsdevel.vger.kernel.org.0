Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1745867B362
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 14:34:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235473AbjAYNez (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 08:34:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234759AbjAYNex (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 08:34:53 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A30B956EF6;
        Wed, 25 Jan 2023 05:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=T2C8sCZx2VTip67EbxZ++0B2OBKUBUFgCJpLY05V/n4=; b=1OkYkmeC3ChehQGkCBhUBzHODi
        QSMoBl9rcdqYF7decsoyhscAM9vM9Hpnw/L4odKQ1gkjYKFwq/0oZkYxYu1aloIMtWAc08/FcY9ZL
        nSts4tqADKXgGbJWMAO8oSrFfsj2Yu7AtBHdLX8S1kDMvbf1Q1zrwua6XOWKJjmu1hStbMqfuaBsY
        tOmLvdjNBUEzgRogLqECDJPUjmGuxm3RCnXRaS/03B4XTS5sSIRIYxGfSgQ/f+q+LMmQ7E7fVG/ux
        gn9BdYL2Lq9oN8+PWNupsXpCM8PU0ttxtNTKJ6HOlMnWPrY11+sneV5vmaRixQQ0r4aNAUW5GTqng
        TN1Ky4mw==;
Received: from [2001:4bb8:19a:27af:c78f:9b0d:b95c:d248] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKfvK-007P1y-Ni; Wed, 25 Jan 2023 13:34:47 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ira Weiny <ira.weiny@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-block@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 2/7] mm: remove the swap_readpage return value
Date:   Wed, 25 Jan 2023 14:34:31 +0100
Message-Id: <20230125133436.447864-3-hch@lst.de>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230125133436.447864-1-hch@lst.de>
References: <20230125133436.447864-1-hch@lst.de>
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

swap_readpage always returns 0, and no caller checks the return value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/page_io.c | 16 +++++-----------
 mm/swap.h    |  7 +++----
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/mm/page_io.c b/mm/page_io.c
index 3a5f921b932e82..6f7166fdc4b2bb 100644
--- a/mm/page_io.c
+++ b/mm/page_io.c
@@ -445,11 +445,9 @@ static void swap_readpage_fs(struct page *page,
 		*plug = sio;
 }
 
-int swap_readpage(struct page *page, bool synchronous,
-		  struct swap_iocb **plug)
+void swap_readpage(struct page *page, bool synchronous, struct swap_iocb **plug)
 {
 	struct bio *bio;
-	int ret = 0;
 	struct swap_info_struct *sis = page_swap_info(page);
 	bool workingset = PageWorkingset(page);
 	unsigned long pflags;
@@ -481,15 +479,12 @@ int swap_readpage(struct page *page, bool synchronous,
 		goto out;
 	}
 
-	if (sis->flags & SWP_SYNCHRONOUS_IO) {
-		ret = bdev_read_page(sis->bdev, swap_page_sector(page), page);
-		if (!ret) {
-			count_vm_event(PSWPIN);
-			goto out;
-		}
+	if ((sis->flags & SWP_SYNCHRONOUS_IO) &&
+	    !bdev_read_page(sis->bdev, swap_page_sector(page), page)) {
+		count_vm_event(PSWPIN);
+		goto out;
 	}
 
-	ret = 0;
 	bio = bio_alloc(sis->bdev, 1, REQ_OP_READ, GFP_KERNEL);
 	bio->bi_iter.bi_sector = swap_page_sector(page);
 	bio->bi_end_io = end_swap_bio_read;
@@ -521,7 +516,6 @@ int swap_readpage(struct page *page, bool synchronous,
 		psi_memstall_leave(&pflags);
 	}
 	delayacct_swapin_end();
-	return ret;
 }
 
 void __swap_read_unplug(struct swap_iocb *sio)
diff --git a/mm/swap.h b/mm/swap.h
index f78065c8ef524b..f5eb5069d28c2e 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -8,8 +8,7 @@
 /* linux/mm/page_io.c */
 int sio_pool_init(void);
 struct swap_iocb;
-int swap_readpage(struct page *page, bool do_poll,
-		  struct swap_iocb **plug);
+void swap_readpage(struct page *page, bool do_poll, struct swap_iocb **plug);
 void __swap_read_unplug(struct swap_iocb *plug);
 static inline void swap_read_unplug(struct swap_iocb *plug)
 {
@@ -64,8 +63,8 @@ static inline unsigned int folio_swap_flags(struct folio *folio)
 }
 #else /* CONFIG_SWAP */
 struct swap_iocb;
-static inline int swap_readpage(struct page *page, bool do_poll,
-				struct swap_iocb **plug)
+static inline void swap_readpage(struct page *page, bool do_poll,
+		struct swap_iocb **plug)
 {
 	return 0;
 }
-- 
2.39.0


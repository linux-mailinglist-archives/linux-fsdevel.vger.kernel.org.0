Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D40E267BDAF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 22:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236701AbjAYVI6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 16:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbjAYVIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2FD659B42
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 13:07:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674680844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+R2Fab+zsp5/4JKdTrc4PXZk8RqADa0qecJwQvHEwc=;
        b=fCcZ5pcsXqpPcWAA+evUuZ4fzjiVAWP/R3ZGtB5E5aisuRYNeol7ltTgel6/veubzMaX2h
        /FoUfjFOp0j+aJ9Gy2Exk2ie3OqmtistP5M4eGMlMYCqxCAV9pjmyXBAhNHlwkXqEROq0p
        yE6Z2x+u4tC3gmP7tTbuppm0Q+SqvhM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-47-63ymXbHLOMShaBfr1SrLhg-1; Wed, 25 Jan 2023 16:07:21 -0500
X-MC-Unique: 63ymXbHLOMShaBfr1SrLhg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0770285CCE0;
        Wed, 25 Jan 2023 21:07:20 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF1B12026D4B;
        Wed, 25 Jan 2023 21:07:17 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v10 6/8] block: Add BIO_PAGE_PINNED and associated infrastructure
Date:   Wed, 25 Jan 2023 21:06:55 +0000
Message-Id: <20230125210657.2335748-7-dhowells@redhat.com>
In-Reply-To: <20230125210657.2335748-1-dhowells@redhat.com>
References: <20230125210657.2335748-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add BIO_PAGE_PINNED to indicate that the pages in a bio are pinned
(FOLL_PIN) and that the pin will need removing.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: John Hubbard <jhubbard@nvidia.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jan Kara <jack@suse.cz>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: linux-block@vger.kernel.org
---

Notes:
    ver #10)
     - Drop bio_set_cleanup_mode(), open coding it instead.
    
    ver #9)
     - Only consider pinning in bio_set_cleanup_mode().  Ref'ing pages in
       struct bio is going away.
     - page_put_unpin() is removed; call unpin_user_page() and put_page()
       directly.
     - Use bio_release_page() in __bio_release_pages().
     - BIO_PAGE_PINNED and BIO_PAGE_REFFED can't both be set, so use if-else
       when testing both of them.
    
    ver #8)
     - Move the infrastructure to clean up pinned pages to this patch [hch].
     - Put BIO_PAGE_PINNED before BIO_PAGE_REFFED as the latter should
       probably be removed at some point.  FOLL_PIN can then be renumbered
       first.

 block/bio.c               |  6 +++---
 block/blk.h               | 12 ++++++++++++
 include/linux/bio.h       |  3 ++-
 include/linux/blk_types.h |  1 +
 4 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 851c23641a0d..fc45aaa97696 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1176,7 +1176,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		bio_release_page(bio, bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1496,8 +1496,8 @@ void bio_set_pages_dirty(struct bio *bio)
  * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO from
- * here on.  It will run one put_page() against each page and will run one
- * bio_put() against the BIO.
+ * here on.  It will unpin each page and will run one bio_put() against the
+ * BIO.
  */
 
 static void bio_dirty_fn(struct work_struct *work);
diff --git a/block/blk.h b/block/blk.h
index 4c3b3325219a..f02381405311 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -425,6 +425,18 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 		struct page *page, unsigned int len, unsigned int offset,
 		unsigned int max_sectors, bool *same_page);
 
+/*
+ * Clean up a page appropriately, where the page may be pinned, may have a
+ * ref taken on it or neither.
+ */
+static inline void bio_release_page(struct bio *bio, struct page *page)
+{
+	if (bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_page(page);
+	else if (bio_flagged(bio, BIO_PAGE_REFFED))
+		put_page(page);
+}
+
 struct request_queue *blk_alloc_queue(int node_id);
 
 int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 805957c99147..b2c09997d79c 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -484,7 +484,8 @@ void zero_fill_bio(struct bio *bio);
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (bio_flagged(bio, BIO_PAGE_REFFED))
+	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
+	    bio_flagged(bio, BIO_PAGE_PINNED))
 		__bio_release_pages(bio, mark_dirty);
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 7daa261f4f98..a0e339ff3d09 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -318,6 +318,7 @@ struct bio {
  * bio flags
  */
 enum {
+	BIO_PAGE_PINNED,	/* Unpin pages in bio_release_pages() */
 	BIO_PAGE_REFFED,	/* put pages in bio_release_pages() */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */


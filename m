Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F9A16BB9F0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:38:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbjCOQia (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbjCOQhs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:37:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA9836B960
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 09:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HEPrb4kIqMqW7eebyDDmobfSBttcdx5+yTOr0krGf5g=;
        b=I0m7/5T5gCGBPtOl56YzxQj/rmazAmoVw/ZxtT+4BxmO3+fRF4R+gQ32fMYqXQ4TKPj+Mp
        dyFCtonSADrsUrr62BI0qP1Krz9hNrNwTkq8kMxgwg10KQe16Lebo4NxtfOjgmh6Vs9VG2
        ncm+pg5XBpUNXzWDvgZrRZSnZD97qvQ=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-vcA44ovXN1e4qlJZz1bDQA-1; Wed, 15 Mar 2023 12:36:33 -0400
X-MC-Unique: vcA44ovXN1e4qlJZz1bDQA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6ED473814594;
        Wed, 15 Mar 2023 16:36:32 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 54816400F4F;
        Wed, 15 Mar 2023 16:36:30 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v19 13/15] block: Add BIO_PAGE_PINNED and associated infrastructure
Date:   Wed, 15 Mar 2023 16:35:47 +0000
Message-Id: <20230315163549.295454-14-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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
index 4ff96a0e4091..51ae957cc4b6 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1168,7 +1168,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		bio_release_page(bio, bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1488,8 +1488,8 @@ void bio_set_pages_dirty(struct bio *bio)
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
index cc4e8873dfde..d65d96994a94 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -432,6 +432,18 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
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
 
 int disk_scan_partitions(struct gendisk *disk, fmode_t mode);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index b537d03377f0..d8c30c791a9a 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -488,7 +488,8 @@ void zero_fill_bio(struct bio *bio);
 
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


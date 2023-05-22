Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A73A70CBCD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 May 2023 22:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjEVU7e (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 May 2023 16:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235289AbjEVU7V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 May 2023 16:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B590FF
        for <linux-fsdevel@vger.kernel.org>; Mon, 22 May 2023 13:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684789086;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xt8MS4tNW7WMUMs3pTsS0U26gIFNlNPWhaB+SXg4cNY=;
        b=SVcXfvMJjboQRg3u6w2idGYtBcrOlTq9/Aroxlhlt4/zzAAFL4u1ESBh9y2OMEsydlNnrs
        7CDzq8gX4qENjJtM1tM3S8PT4PEk0dti+Sso5blH1SCgT7uGuIy2ju24hCBCUcCnMPfXzm
        hc7Tn4ZvI7YCc/su2dJ8RKM/XQVoiaI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-325-raSTpLIKOaCh0l3iPTbjyg-1; Mon, 22 May 2023 16:58:03 -0400
X-MC-Unique: raSTpLIKOaCh0l3iPTbjyg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F811802E58;
        Mon, 22 May 2023 20:58:02 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.192.68])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83F4540CFD45;
        Mon, 22 May 2023 20:57:59 +0000 (UTC)
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
Subject: [PATCH v21 4/6] block: Add BIO_PAGE_PINNED and associated infrastructure
Date:   Mon, 22 May 2023 21:57:42 +0100
Message-Id: <20230522205744.2825689-5-dhowells@redhat.com>
In-Reply-To: <20230522205744.2825689-1-dhowells@redhat.com>
References: <20230522205744.2825689-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
index 8516adeaea26..17bd01ecde36 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1169,7 +1169,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		bio_release_page(bio, bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1489,8 +1489,8 @@ void bio_set_pages_dirty(struct bio *bio)
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
index 45547bcf1119..e1ded2ccb3ca 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -420,6 +420,18 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
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
index 0922729acd26..8588bcfbc6ef 100644
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
index dfd2c2cb909d..8ef209e3aa96 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -323,6 +323,7 @@ struct bio {
  * bio flags
  */
 enum {
+	BIO_PAGE_PINNED,	/* Unpin pages in bio_release_pages() */
 	BIO_PAGE_REFFED,	/* put pages in bio_release_pages() */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */


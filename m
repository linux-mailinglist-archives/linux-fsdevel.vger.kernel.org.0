Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3332679F55
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Jan 2023 17:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbjAXQ7X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Jan 2023 11:59:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjAXQ7W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:59:22 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBA1145BC1;
        Tue, 24 Jan 2023 08:59:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q20iUbFBo/EcilBlEOdYiKbbeE+E9KmIcH2y2ndCPzk=; b=LyEZb98S6B9XMIA36VIxeHHP10
        CgK2aWuT4/E+GXo1cKuqntP1JpAv1b9g34KBlFRM2yvTpFsyYkjcBFEQED6r7RqnBEGZItbuiOTjB
        CULh2BtVvwMGEYtPLK2d4sPM+0dGz1hxSG3dC7vm60GOVvXfvnebeUJelkYqEl94Ifcam5USBN+9G
        LAejGHvl9T+qx/6TR8r3lbuW9Jmkpj1t7tYEadZRYpqmbxSvY1MaeJZeuOYp1vKJq2a+uYurbo0w7
        /tDZGOdLxq15qt8QRHRtIP2Dp4REGGz+Mhw4Ok5Ad2EwwumdBlXwVJXHZfOkejeV4WZ9LJ10ol5KG
        A5t+q5OQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pKMdd-004kcJ-Tw; Tue, 24 Jan 2023 16:59:13 +0000
Date:   Tue, 24 Jan 2023 08:59:13 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 07/10] block: Switch to pinning pages.
Message-ID: <Y9AOYXpU1cRAHfQz@infradead.org>
References: <Y8/xApRVtqK7IlYT@infradead.org>
 <2431ffa0-4a37-56a2-17fa-74a5f681bcb8@redhat.com>
 <20230123173007.325544-1-dhowells@redhat.com>
 <20230123173007.325544-8-dhowells@redhat.com>
 <874829.1674571671@warthog.procyon.org.uk>
 <875433.1674572633@warthog.procyon.org.uk>
 <Y9AK+yW7mZ2SNMcj@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y9AK+yW7mZ2SNMcj@infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This is the incremental patch.  Doesn't do the FOLL_PIN to bool
conversion for the extra helper yet, and needs to be folded into the
original patches still.


diff --git a/block/bio.c b/block/bio.c
index 6dc54bf3ed27d4..bd8433f3644fd7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1170,14 +1170,20 @@ bool bio_add_folio(struct bio *bio, struct folio *folio, size_t len,
 
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	unsigned int gup_flags = bio_to_gup_flags(bio);
+	bool pinned = bio_flagged(bio, BIO_PAGE_PINNED);
+	bool reffed = bio_flagged(bio, BIO_PAGE_REFFED);
 	struct bvec_iter_all iter_all;
 	struct bio_vec *bvec;
 
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		page_put_unpin(bvec->bv_page, gup_flags);
+
+		if (pinned)
+			unpin_user_page(bvec->bv_page);
+		/* this can go away once direct-io.c is converted: */
+		else if (reffed)
+			put_page(bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
diff --git a/block/blk.h b/block/blk.h
index 294044d696e09f..a16d4425d2751c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -430,27 +430,19 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
  */
 static inline void bio_set_cleanup_mode(struct bio *bio, struct iov_iter *iter)
 {
-	unsigned int cleanup_mode = iov_iter_extract_mode(iter);
-
-	if (cleanup_mode & FOLL_GET)
-		bio_set_flag(bio, BIO_PAGE_REFFED);
-	if (cleanup_mode & FOLL_PIN)
+	if (iov_iter_extract_mode(iter) & FOLL_PIN)
 		bio_set_flag(bio, BIO_PAGE_PINNED);
 }
 
-static inline unsigned int bio_to_gup_flags(struct bio *bio)
-{
-	return (bio_flagged(bio, BIO_PAGE_REFFED) ? FOLL_GET : 0) |
-		(bio_flagged(bio, BIO_PAGE_PINNED) ? FOLL_PIN : 0);
-}
-
 /*
  * Clean up a page appropriately, where the page may be pinned, may have a
  * ref taken on it or neither.
  */
 static inline void bio_release_page(struct bio *bio, struct page *page)
 {
-	page_put_unpin(page, bio_to_gup_flags(bio));
+	WARN_ON_ONCE(bio_flagged(bio, BIO_PAGE_REFFED));
+	if (bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_page(page);
 }
 
 struct request_queue *blk_alloc_queue(int node_id);

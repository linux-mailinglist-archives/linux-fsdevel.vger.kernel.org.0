Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBAC766D2B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Jan 2023 00:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbjAPXLh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Jan 2023 18:11:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235287AbjAPXKX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Jan 2023 18:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47AC2A178
        for <linux-fsdevel@vger.kernel.org>; Mon, 16 Jan 2023 15:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673910554;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oIg4SI8jd35c8Kgm0gG6JOeWye+BZTFoEmJg3h8S5uc=;
        b=U2tzO5L3eVNH/bQdMw6iswVDw9ustmx7Epejj7BdzETs54WzgrtNc9UrOplwKgbcyEavA3
        eMx2DVnwi4i8JKpy2CszKB05h0s32PoiWHY18Ou6d3Jh245F3arAT+yniYgB86//dRteOM
        ERWiUN43pqSVHfsRs+nw/dFxOSpllvs=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-21-t5kEwhkRNwqeCqPIKbDeXQ-1; Mon, 16 Jan 2023 18:09:08 -0500
X-MC-Unique: t5kEwhkRNwqeCqPIKbDeXQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3F7A22A59556;
        Mon, 16 Jan 2023 23:09:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D489D492B00;
        Mon, 16 Jan 2023 23:09:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v6 09/34] bio: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED and
 invert the meaning
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, dhowells@redhat.com,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 16 Jan 2023 23:09:06 +0000
Message-ID: <167391054631.2311931.7588488803802952158.stgit@warthog.procyon.org.uk>
In-Reply-To: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
References: <167391047703.2311931.8115712773222260073.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED and invert the meaning.  In a
following patch I intend to add a BIO_PAGE_PINNED flag to indicate that the
page needs unpinning and this way both flags have the same logic.

Changes
=======
ver #5)
 - Split from patch that uses iov_iter_extract_pages().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jan Kara <jack@suse.cz>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: linux-block@vger.kernel.org

Link: https://lore.kernel.org/r/167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk/ # v4
Link: https://lore.kernel.org/r/167344730802.2425628.14034153595667416149.stgit@warthog.procyon.org.uk/ # v5
---

 block/bio.c               |    9 ++++++++-
 include/linux/bio.h       |    2 +-
 include/linux/blk_types.h |    2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 867cf4db87ea..5b6a76c3e620 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -243,6 +243,10 @@ static void bio_free(struct bio *bio)
  * Users of this function have their own bio allocation. Subsequently,
  * they must remember to pair any call to bio_init() with bio_uninit()
  * when IO has completed, or when the bio is released.
+ *
+ * We set the initial assumption that pages attached to the bio will be
+ * released with put_page() by setting BIO_PAGE_REFFED; if the pages
+ * should not be put, this flag should be cleared.
  */
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 	      unsigned short max_vecs, blk_opf_t opf)
@@ -274,6 +278,7 @@ void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec *table,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	bio->bi_integrity = NULL;
 #endif
+	bio_set_flag(bio, BIO_PAGE_REFFED);
 	bio->bi_vcnt = 0;
 
 	atomic_set(&bio->__bi_remaining, 1);
@@ -302,6 +307,7 @@ void bio_reset(struct bio *bio, struct block_device *bdev, blk_opf_t opf)
 {
 	bio_uninit(bio);
 	memset(bio, 0, BIO_RESET_BYTES);
+	bio_set_flag(bio, BIO_PAGE_REFFED);
 	atomic_set(&bio->__bi_remaining, 1);
 	bio->bi_bdev = bdev;
 	if (bio->bi_bdev)
@@ -812,6 +818,7 @@ EXPORT_SYMBOL(bio_put);
 static int __bio_clone(struct bio *bio, struct bio *bio_src, gfp_t gfp)
 {
 	bio_set_flag(bio, BIO_CLONED);
+	bio_clear_flag(bio, BIO_PAGE_REFFED);
 	bio->bi_ioprio = bio_src->bi_ioprio;
 	bio->bi_iter = bio_src->bi_iter;
 
@@ -1198,7 +1205,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
 	bio->bi_iter.bi_bvec_done = iter->iov_offset;
 	bio->bi_iter.bi_size = size;
-	bio_set_flag(bio, BIO_NO_PAGE_REF);
+	bio_clear_flag(bio, BIO_PAGE_REFFED);
 	bio_set_flag(bio, BIO_CLONED);
 }
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 3f7ba7fe48ac..69b32c5532f6 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -496,7 +496,7 @@ void zero_fill_bio(struct bio *bio);
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+	if (bio_flagged(bio, BIO_PAGE_REFFED))
 		__bio_release_pages(bio, mark_dirty);
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..86711fb0534a 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -318,7 +318,7 @@ struct bio {
  * bio flags
  */
 enum {
-	BIO_NO_PAGE_REF,	/* don't put release vec pages */
+	BIO_PAGE_REFFED,	/* Pages need refs putting (equivalent to FOLL_GET) */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */



Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A419667BDAC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 22:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbjAYVIv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 16:08:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236426AbjAYVIo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:08:44 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2AD59994
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 13:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674680841;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NpRga8VxfxN6lE75EkYWgLaBl9tiTC43SRcsCFIIcl8=;
        b=dWSPeEO6BWUi4bZUpbKDr3Eba1wjKKYrC07/V6HlVao1jjpFknGjjfUi4VZO7mte07K0GO
        E5aPd58N7Us/tO/f7NYELfhwgjvUtyGUORbnSgPzmttkqlxcNOZUj2WjyKztKbu63s/8Nn
        p5xvMIkcU2+lv5qe9P1SB3S16wBjDAU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-AkuViztfMFmk_DNAx--MGQ-1; Wed, 25 Jan 2023 16:07:18 -0500
X-MC-Unique: AkuViztfMFmk_DNAx--MGQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 29AE6858F09;
        Wed, 25 Jan 2023 21:07:17 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22ED4492B02;
        Wed, 25 Jan 2023 21:07:15 +0000 (UTC)
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
Subject: [PATCH v10 5/8] block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted logic
Date:   Wed, 25 Jan 2023 21:06:54 +0000
Message-Id: <20230125210657.2335748-6-dhowells@redhat.com>
In-Reply-To: <20230125210657.2335748-1-dhowells@redhat.com>
References: <20230125210657.2335748-1-dhowells@redhat.com>
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

From: Christoph Hellwig <hch@lst.de>

Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
meaning is only set when a page reference has been acquired that needs to
be released by bio_release_pages().

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
    ver #8)
     - Don't default to BIO_PAGE_REFFED [hch].
    
    ver #5)
     - Split from patch that uses iov_iter_extract_pages().

 block/bio.c               | 2 +-
 block/blk-map.c           | 1 +
 fs/direct-io.c            | 2 ++
 fs/iomap/direct-io.c      | 1 -
 include/linux/bio.h       | 2 +-
 include/linux/blk_types.h | 2 +-
 6 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 683444e6b711..851c23641a0d 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1198,7 +1198,6 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
 	bio->bi_iter.bi_bvec_done = iter->iov_offset;
 	bio->bi_iter.bi_size = size;
-	bio_set_flag(bio, BIO_NO_PAGE_REF);
 	bio_set_flag(bio, BIO_CLONED);
 }
 
@@ -1343,6 +1342,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		return 0;
 	}
 
+	bio_set_flag(bio, BIO_PAGE_REFFED);
 	do {
 		ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
diff --git a/block/blk-map.c b/block/blk-map.c
index 7db52ad5b2d0..0e2b0a861ba3 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -282,6 +282,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	if (blk_queue_pci_p2pdma(rq->q))
 		extraction_flags |= ITER_ALLOW_P2PDMA;
 
+	bio_set_flag(bio, BIO_PAGE_REFFED);
 	while (iov_iter_count(iter)) {
 		struct page **pages, *stack_pages[UIO_FASTIOV];
 		ssize_t bytes;
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 03d381377ae1..07810465fc9d 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -403,6 +403,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 		bio->bi_end_io = dio_bio_end_aio;
 	else
 		bio->bi_end_io = dio_bio_end_io;
+	/* for now require references for all pages */
+	bio_set_flag(bio, BIO_PAGE_REFFED);
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
 }
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 47db4ead1e74..c0e75900e754 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -202,7 +202,6 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	bio_set_flag(bio, BIO_NO_PAGE_REF);
 	__bio_add_page(bio, page, len, 0);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 10366b8bdb13..805957c99147 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -484,7 +484,7 @@ void zero_fill_bio(struct bio *bio);
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+	if (bio_flagged(bio, BIO_PAGE_REFFED))
 		__bio_release_pages(bio, mark_dirty);
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..7daa261f4f98 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -318,7 +318,7 @@ struct bio {
  * bio flags
  */
 enum {
-	BIO_NO_PAGE_REF,	/* don't put release vec pages */
+	BIO_PAGE_REFFED,	/* put pages in bio_release_pages() */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */


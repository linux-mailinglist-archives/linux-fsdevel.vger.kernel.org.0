Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 375DD7090EB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 May 2023 09:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231383AbjESHrB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 May 2023 03:47:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbjESHqk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 May 2023 03:46:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 270C52711
        for <linux-fsdevel@vger.kernel.org>; Fri, 19 May 2023 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1684482162;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TuE+HSvYodh9xYXD2lD0nf71BaZqaWOFZeqfoTjFcWg=;
        b=L3HFXI2TKmyN3fDBOOsuyxD/lEktqQ6jjNZmrzp0XOcpd+f27a18bCjfE1uCiRsKNZHE45
        aAoDLlrObmptWxBdbe5ubUM+3Gm/1PzydMR0UZ16TAEFSRfHr39oAWcaHo8lglop6OPhyr
        4dOghZe1PcinwWtzDA7pU2NQG6T0mDo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-qF_O3km6NpKFWdiM07-vLQ-1; Fri, 19 May 2023 03:42:39 -0400
X-MC-Unique: qF_O3km6NpKFWdiM07-vLQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 41BD880027F;
        Fri, 19 May 2023 07:42:38 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.221])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CB432026D49;
        Fri, 19 May 2023 07:42:35 +0000 (UTC)
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
Subject: [PATCH v20 29/32] block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted logic
Date:   Fri, 19 May 2023 08:40:44 +0100
Message-Id: <20230519074047.1739879-30-dhowells@redhat.com>
In-Reply-To: <20230519074047.1739879-1-dhowells@redhat.com>
References: <20230519074047.1739879-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>

Replace BIO_NO_PAGE_REF with a BIO_PAGE_REFFED flag that has the inverted
meaning is only set when a page reference has been acquired that needs to
be released by bio_release_pages().

Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: David Howells <dhowells@redhat.com>
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
     - Split out from another patch [hch].
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
index 043944fd46eb..8516adeaea26 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1191,7 +1191,6 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
 	bio->bi_iter.bi_bvec_done = iter->iov_offset;
 	bio->bi_iter.bi_size = size;
-	bio_set_flag(bio, BIO_NO_PAGE_REF);
 	bio_set_flag(bio, BIO_CLONED);
 }
 
@@ -1336,6 +1335,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		return 0;
 	}
 
+	bio_set_flag(bio, BIO_PAGE_REFFED);
 	do {
 		ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));
diff --git a/block/blk-map.c b/block/blk-map.c
index 04c55f1c492e..33d9f6e89ba6 100644
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
index 0b380bb8a81e..ad20f3428bab 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -402,6 +402,8 @@ dio_bio_alloc(struct dio *dio, struct dio_submit *sdio,
 		bio->bi_end_io = dio_bio_end_aio;
 	else
 		bio->bi_end_io = dio_bio_end_io;
+	/* for now require references for all pages */
+	bio_set_flag(bio, BIO_PAGE_REFFED);
 	sdio->bio = bio;
 	sdio->logical_offset_in_bio = sdio->cur_page_fs_offset;
 }
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 66a9f10e3207..08873f0627dd 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -203,7 +203,6 @@ static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
 	bio->bi_private = dio;
 	bio->bi_end_io = iomap_dio_bio_end_io;
 
-	bio_set_flag(bio, BIO_NO_PAGE_REF);
 	__bio_add_page(bio, page, len, 0);
 	iomap_dio_submit_bio(iter, dio, bio, pos);
 }
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7f53be035cf0..0922729acd26 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -488,7 +488,7 @@ void zero_fill_bio(struct bio *bio);
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+	if (bio_flagged(bio, BIO_PAGE_REFFED))
 		__bio_release_pages(bio, mark_dirty);
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 740afe80f297..dfd2c2cb909d 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -323,7 +323,7 @@ struct bio {
  * bio flags
  */
 enum {
-	BIO_NO_PAGE_REF,	/* don't put release vec pages */
+	BIO_PAGE_REFFED,	/* put pages in bio_release_pages() */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */


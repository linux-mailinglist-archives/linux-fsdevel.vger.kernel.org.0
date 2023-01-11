Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A0C665E0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jan 2023 15:34:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjAKOeI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Jan 2023 09:34:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238606AbjAKOcL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:32:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1941EAF5
        for <linux-fsdevel@vger.kernel.org>; Wed, 11 Jan 2023 06:28:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673447313;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=78gt1tV6YuWzjUMppuc9FVKAQ/1A9299UaaLagqn+ik=;
        b=QZZyBib1NzvVBFgdAgmhQbXwabbVVrExmJScBopxiUavXYR6hWa0ju3SKTYpYbHwXyTF5E
        nayn32eZeem6Ln5A2evvyIqdHlEppBPO/RZwVyGvGRYL/xoflSi9j5bVx1o7aZSS4p6lEv
        bSx9NGp0G25Jj1G6WzucWtOcJTNmKcE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-425-Pa9QBOowMkKbz4G4OI1VQg-1; Wed, 11 Jan 2023 09:28:30 -0500
X-MC-Unique: Pa9QBOowMkKbz4G4OI1VQg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1166B101A55E;
        Wed, 11 Jan 2023 14:28:30 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A073D492C14;
        Wed, 11 Jan 2023 14:28:28 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v5 7/9] bio: Rename BIO_NO_PAGE_REF to BIO_PAGE_REFFED and
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
Date:   Wed, 11 Jan 2023 14:28:28 +0000
Message-ID: <167344730802.2425628.14034153595667416149.stgit@warthog.procyon.org.uk>
In-Reply-To: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
References: <167344725490.2425628.13771289553670112965.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
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
---

 block/bio.c               |    9 ++++++++-
 include/linux/bio.h       |    2 +-
 include/linux/blk_types.h |    2 +-
 3 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5f96fcae3f75..0fa140789d16 100644
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
index 22078a28d7cb..63bfd91793f9 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -482,7 +482,7 @@ void zero_fill_bio(struct bio *bio);
 
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+	if (bio_flagged(bio, BIO_PAGE_REFFED))
 		__bio_release_pages(bio, mark_dirty);
 }
 
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..2f64b3606397 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -318,7 +318,7 @@ struct bio {
  * bio flags
  */
 enum {
-	BIO_NO_PAGE_REF,	/* don't put release vec pages */
+	BIO_PAGE_REFFED,	/* Pages need refs putting (see FOLL_GET) */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */



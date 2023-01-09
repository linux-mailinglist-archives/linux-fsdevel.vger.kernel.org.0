Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9490E6633E7
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 23:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232796AbjAIWY5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 17:24:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjAIWYz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 17:24:55 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25F6E09A
        for <linux-fsdevel@vger.kernel.org>; Mon,  9 Jan 2023 14:24:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673303050;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GgiboeYkvIe2GRHXMolVdzhyJfIsJ3v5wqSotBQmt0I=;
        b=Cw9QnWFIDH9J0f0WVFJHDdJW42grEA3sdF1fYRKd999kDw3YpwkzVPNi5xWESTUeXI/+nw
        2ld6/2zUefv/QFHFNDsEy1Au4ZH6B7aDIYZE6jwtpk2KtP3mQoSuVwLF4lWKddt/vy0M9y
        8JHArZVm8gqi5v5NGtizztQnnvxLwh0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-ndBcVny2OPuBzEHSaQi-AQ-1; Mon, 09 Jan 2023 17:24:08 -0500
X-MC-Unique: ndBcVny2OPuBzEHSaQi-AQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2973C18E6204;
        Mon,  9 Jan 2023 22:24:08 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB0E6140EBF5;
        Mon,  9 Jan 2023 22:24:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <d0bb04e7-7e58-d494-0e39-6e98f3368a7b@kernel.dk>
References: <d0bb04e7-7e58-d494-0e39-6e98f3368a7b@kernel.dk> <20230109173513.htfqbkrtqm52pnye@quack3> <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk> <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk> <2008444.1673300255@warthog.procyon.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     dhowells@redhat.com, Jan Kara <jack@suse.cz>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages rather than ref'ing if appropriate
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2084838.1673303046.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 09 Jan 2023 22:24:06 +0000
Message-ID: <2084839.1673303046@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Would you be okay with me flipping the logic of BIO_NO_PAGE_REF, so I end =
up
with:

	static void bio_release_page(struct bio *bio, struct page *page)
	{
		if (bio_flagged(bio, BIO_PAGE_PINNED))
			unpin_user_page(page);
		if (bio_flagged(bio, BIO_PAGE_REFFED))
			put_page(page);
	}

See attached patch.

David
---
iov_iter, block: Make bio structs pin pages rather than ref'ing if appropr=
iate

Convert the block layer's bio code to use iov_iter_extract_pages() instead
of iov_iter_get_pages().  This will pin pages or leave them unaltered
rather than getting a ref on them as appropriate to the source iterator.

The pages need to be pinned for DIO-read rather than having refs taken on
them to prevent VM copy-on-write from malfunctioning during a concurrent
fork() (the result of the I/O would otherwise end up only visible to the
child process and not the parent).

To implement this:

 (1) The BIO_NO_PAGE_REF flag is renamed to BIO_PAGE_REFFED and has it's
     logic inverted.  If set, this causes attached pages to be passed to
     put_page() during cleanup.

 (2) A BIO_PAGE_PINNED flag is provided as well.  If set, this causes
     attached pages to be passed to unpin_user_page() during cleanup.

 (3) BIO_PAGE_REFFED is set by default and BIO_PAGE_PINNED is cleared by
     default when the bio is (re-)initialised.

 (4) If iov_iter_extract_pages() indicates FOLL_GET, this causes
     BIO_PAGE_REFFED to be set and if FOLL_PIN is indicated, this causes
     BIO_PAGE_PINNED to be set.  If it returns neither FOLL_* flag, then
     both BIO_PAGE_* flags will be cleared.  Mixed sets are not supported.

 (5) Cloned bio structs have both flags cleared.

 (6) bio_release_pages() will do the release if either BIO_PAGE_* flag is
     set.

[!] Note that this is tested a bit with ext4, but nothing else.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
---
 block/bio.c               |   60 ++++++++++++++++++++++++++++++++++------=
------
 include/linux/bio.h       |    3 +-
 include/linux/blk_types.h |    3 +-
 3 files changed, 49 insertions(+), 17 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5f96fcae3f75..5b9f9fc62345 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -243,6 +243,11 @@ static void bio_free(struct bio *bio)
  * Users of this function have their own bio allocation. Subsequently,
  * they must remember to pair any call to bio_init() with bio_uninit()
  * when IO has completed, or when the bio is released.
+ *
+ * We set the initial assumption that pages attached to the bio will be
+ * released with put_page() by setting BIO_PAGE_REFFED, but this should b=
e set
+ * to BIO_PAGE_PINNED if the page should be unpinned instead; if the page=
s
+ * should not be put or unpinned, these flags should be cleared.
  */
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec =
*table,
 	      unsigned short max_vecs, blk_opf_t opf)
@@ -274,6 +279,7 @@ void bio_init(struct bio *bio, struct block_device *bd=
ev, struct bio_vec *table,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	bio->bi_integrity =3D NULL;
 #endif
+	bio_set_flag(bio, BIO_PAGE_REFFED);
 	bio->bi_vcnt =3D 0;
 =

 	atomic_set(&bio->__bi_remaining, 1);
@@ -302,6 +308,8 @@ void bio_reset(struct bio *bio, struct block_device *b=
dev, blk_opf_t opf)
 {
 	bio_uninit(bio);
 	memset(bio, 0, BIO_RESET_BYTES);
+	bio_set_flag(bio, BIO_PAGE_REFFED);
+	bio_clear_flag(bio, BIO_PAGE_PINNED);
 	atomic_set(&bio->__bi_remaining, 1);
 	bio->bi_bdev =3D bdev;
 	if (bio->bi_bdev)
@@ -814,6 +822,8 @@ static int __bio_clone(struct bio *bio, struct bio *bi=
o_src, gfp_t gfp)
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio =3D bio_src->bi_ioprio;
 	bio->bi_iter =3D bio_src->bi_iter;
+	bio_clear_flag(bio, BIO_PAGE_REFFED);
+	bio_clear_flag(bio, BIO_PAGE_PINNED);
 =

 	if (bio->bi_bdev) {
 		if (bio->bi_bdev =3D=3D bio_src->bi_bdev &&
@@ -1168,6 +1178,18 @@ bool bio_add_folio(struct bio *bio, struct folio *f=
olio, size_t len,
 	return bio_add_page(bio, &folio->page, len, off) > 0;
 }
 =

+/*
+ * Clean up a page according to the mode indicated by iov_iter_extract_pa=
ges(),
+ * where the page is may be pinned or may have a ref taken on it.
+ */
+static void bio_release_page(struct bio *bio, struct page *page)
+{
+	if (bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_page(page);
+	if (bio_flagged(bio, BIO_PAGE_REFFED))
+		put_page(page);
+}
+
 void __bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	struct bvec_iter_all iter_all;
@@ -1176,7 +1198,7 @@ void __bio_release_pages(struct bio *bio, bool mark_=
dirty)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if (mark_dirty && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+		bio_release_page(bio, bvec->bv_page);
 	}
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
@@ -1198,7 +1220,7 @@ void bio_iov_bvec_set(struct bio *bio, struct iov_it=
er *iter)
 	bio->bi_io_vec =3D (struct bio_vec *)iter->bvec;
 	bio->bi_iter.bi_bvec_done =3D iter->iov_offset;
 	bio->bi_iter.bi_size =3D size;
-	bio_set_flag(bio, BIO_NO_PAGE_REF);
+	bio_clear_flag(bio, BIO_PAGE_REFFED);
 	bio_set_flag(bio, BIO_CLONED);
 }
 =

@@ -1213,7 +1235,7 @@ static int bio_iov_add_page(struct bio *bio, struct =
page *page,
 	}
 =

 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 =

@@ -1227,7 +1249,7 @@ static int bio_iov_add_zone_append_page(struct bio *=
bio, struct page *page,
 			queue_max_zone_append_sectors(q), &same_page) !=3D len)
 		return -EINVAL;
 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 =

@@ -1238,10 +1260,10 @@ static int bio_iov_add_zone_append_page(struct bio=
 *bio, struct page *page,
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be mapped
  *
- * Pins pages from *iter and appends them to @bio's bvec array. The
- * pages will have to be released using put_page() when done.
- * For multi-segment *iter, this function only adds pages from the
- * next non-empty segment of the iov iterator.
+ * Pins pages from *iter and appends them to @bio's bvec array.  The page=
s will
+ * have to be released using put_page() or unpin_user_page() when done as
+ * according to bi_cleanup_mode.  For multi-segment *iter, this function =
only
+ * adds pages from the next non-empty segment of the iov iterator.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *ite=
r)
 {
@@ -1249,7 +1271,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio,=
 struct iov_iter *iter)
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
-	unsigned int gup_flags =3D 0;
+	unsigned int gup_flags =3D 0, cleanup_mode;
 	ssize_t size, left;
 	unsigned len, i =3D 0;
 	size_t offset, trim;
@@ -1273,12 +1295,20 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
o, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size =3D iov_iter_get_pages(iter, pages,
-				  UINT_MAX - bio->bi_iter.bi_size,
-				  nr_pages, &offset, gup_flags);
+	size =3D iov_iter_extract_pages(iter, &pages,
+				      UINT_MAX - bio->bi_iter.bi_size,
+				      nr_pages, gup_flags,
+				      &offset, &cleanup_mode);
 	if (unlikely(size <=3D 0))
 		return size ? size : -EFAULT;
 =

+	bio_clear_flag(bio, BIO_PAGE_REFFED);
+	bio_clear_flag(bio, BIO_PAGE_PINNED);
+	if (cleanup_mode & FOLL_GET)
+		bio_set_flag(bio, BIO_PAGE_REFFED);
+	if (cleanup_mode & FOLL_PIN)
+		bio_set_flag(bio, BIO_PAGE_PINNED);
+
 	nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
 =

 	trim =3D size & (bdev_logical_block_size(bio->bi_bdev) - 1);
@@ -1308,7 +1338,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio,=
 struct iov_iter *iter)
 	iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)
-		put_page(pages[i++]);
+		bio_release_page(bio, pages[i++]);
 =

 	return ret;
 }
@@ -1489,8 +1519,8 @@ void bio_set_pages_dirty(struct bio *bio)
  * the BIO and re-dirty the pages in process context.
  *
  * It is expected that bio_check_pages_dirty() will wholly own the BIO fr=
om
- * here on.  It will run one put_page() against each page and will run on=
e
- * bio_put() against the BIO.
+ * here on.  It will run one put_page() or unpin_user_page() against each=
 page
+ * and will run one bio_put() against the BIO.
  */
 =

 static void bio_dirty_fn(struct work_struct *work);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 22078a28d7cb..1c6f051f6ff2 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -482,7 +482,8 @@ void zero_fill_bio(struct bio *bio);
 =

 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
-	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
+	if (bio_flagged(bio, BIO_PAGE_REFFED) ||
+	    bio_flagged(bio, BIO_PAGE_PINNED))
 		__bio_release_pages(bio, mark_dirty);
 }
 =

diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..7a2d2b2cf3a0 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -318,7 +318,8 @@ struct bio {
  * bio flags
  */
 enum {
-	BIO_NO_PAGE_REF,	/* don't put release vec pages */
+	BIO_PAGE_REFFED,	/* Pages need refs putting (see FOLL_GET) */
+	BIO_PAGE_PINNED,	/* Pages need pins unpinning (see FOLL_PIN) */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */


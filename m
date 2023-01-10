Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1C0C66436C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jan 2023 15:38:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233423AbjAJOiy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Jan 2023 09:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjAJOix (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Jan 2023 09:38:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57804BD44
        for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jan 2023 06:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1673361485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d/PUsI7flPAl9MQtQKsylT8uqyHzbZfDDAXm2Wxm1ZY=;
        b=afMMoeoqkGgtRfsolzpWGu2JJxUmGXQ7FaNgpFiauK6kLLebVkDAkj+dVHp2h24hIL0WI/
        U/r3DrDffPZ1ix11o4sDIDvugGjbbdE5UflO2Pv7IjpDUWyRfwzJ8UUjCRztYHdu2s96ae
        34N+QwFLoFWSSzYfpYyjvJPzEefStrU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-115-OOT5peUrOrurAwatzypfzQ-1; Tue, 10 Jan 2023 09:37:59 -0500
X-MC-Unique: OOT5peUrOrurAwatzypfzQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1668A1C0040E;
        Tue, 10 Jan 2023 14:37:14 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5FE26422A9;
        Tue, 10 Jan 2023 14:37:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <bbd9cde3-7cbb-f3e4-a2a4-7b1b5ae392e0@kernel.dk>
References: <bbd9cde3-7cbb-f3e4-a2a4-7b1b5ae392e0@kernel.dk> <d0bb04e7-7e58-d494-0e39-6e98f3368a7b@kernel.dk> <20230109173513.htfqbkrtqm52pnye@quack3> <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk> <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk> <2008444.1673300255@warthog.procyon.org.uk> <2084839.1673303046@warthog.procyon.org.uk>
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
Content-ID: <2155740.1673361430.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Tue, 10 Jan 2023 14:37:10 +0000
Message-ID: <2155741.1673361430@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Jens Axboe <axboe@kernel.dk> wrote:

> I think it makes more sense to have NO_REF check, to be honest, as that
> means the general path doesn't have to set that flag. But I don't feel
> too strongly about that part.

It's just that the logic seems weird with BIO_NO_PAGE_REF and BIO_PAGE_PIN=
NED
being kind of opposite polarity.

Anyway, see attached.

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

 (1) The BIO_NO_PAGE_REF flag, if unset, indicates the page needs putting
     or unpinning.

 (2) A BIO_PAGE_PINNED flag is added.  If set, this causes attached pages
     to be passed to unpin_user_page() during cleanup instead of
     put_page().

 (3) BIO_NO_PAGE_REF and BIO_PAGE_PINNED are both cleared by default when
     the bio is (re-)initialised.

 (4) If iov_iter_extract_pages() indicates FOLL_PIN, then BIO_PAGE_PINNED
     is set; if it indicates 0, BIO_NO_PAGE_REF is set; and if it indicate=
s
     FOLL_GET, then neither flag is set.  If it indicates anything else, a
     WARN_ON_ONCE will be triggered and BIO_NO_PAGE_REF will be set.

     Mixed sets are not supported - all the pages must be handled in the
     same way.

 (5) Cloned bio structs have BIO_NO_PAGE_REF as they don't own their own
     pages.

 (6) bio_release_pages() will do the release if BIO_NO_PAGE_REF flag is
     not set.

[!] Note that this is tested a bit with ext4, but nothing else.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
---
 block/bio.c               |   66 ++++++++++++++++++++++++++++++++++++----=
------
 include/linux/blk_types.h |    1 =

 2 files changed, 53 insertions(+), 14 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 5f96fcae3f75..88dfa0e34e81 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -243,6 +243,12 @@ static void bio_free(struct bio *bio)
  * Users of this function have their own bio allocation. Subsequently,
  * they must remember to pair any call to bio_init() with bio_uninit()
  * when IO has completed, or when the bio is released.
+ *
+ * We set the initial assumption that pages attached to the bio will be
+ * released with put_page() by setting neither BIO_NO_PAGE_REF nor
+ * BIO_PAGE_PINNED; BIO_PAGE_PINNED should be set if the page should be
+ * unpinned instead and BIO_NO_PAGE_REF should be set if the pages should=
 not
+ * be put or unpinned.
  */
 void bio_init(struct bio *bio, struct block_device *bdev, struct bio_vec =
*table,
 	      unsigned short max_vecs, blk_opf_t opf)
@@ -814,6 +820,8 @@ static int __bio_clone(struct bio *bio, struct bio *bi=
o_src, gfp_t gfp)
 	bio_set_flag(bio, BIO_CLONED);
 	bio->bi_ioprio =3D bio_src->bi_ioprio;
 	bio->bi_iter =3D bio_src->bi_iter;
+	bio_set_flag(bio, BIO_NO_PAGE_REF);
+	bio_clear_flag(bio, BIO_PAGE_PINNED);
 =

 	if (bio->bi_bdev) {
 		if (bio->bi_bdev =3D=3D bio_src->bi_bdev &&
@@ -1168,6 +1176,20 @@ bool bio_add_folio(struct bio *bio, struct folio *f=
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
+	if (bio_flagged(bio, BIO_NO_PAGE_REF))
+		return;
+	if (bio_flagged(bio, BIO_PAGE_PINNED))
+		unpin_user_page(page);
+	else
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

@@ -1238,10 +1260,11 @@ static int bio_iov_add_zone_append_page(struct bio=
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
+ * according to BIO_NO_PAGE_REF and BIO_PAGE_PINNED.  For multi-segment *=
iter,
+ * this function only adds pages from the next non-empty segment of the i=
ov
+ * iterator.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *ite=
r)
 {
@@ -1249,7 +1272,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio,=
 struct iov_iter *iter)
 	unsigned short entries_left =3D bio->bi_max_vecs - bio->bi_vcnt;
 	struct bio_vec *bv =3D bio->bi_io_vec + bio->bi_vcnt;
 	struct page **pages =3D (struct page **)bv;
-	unsigned int gup_flags =3D 0;
+	unsigned int gup_flags =3D 0, cleanup_mode;
 	ssize_t size, left;
 	unsigned len, i =3D 0;
 	size_t offset, trim;
@@ -1273,12 +1296,27 @@ static int __bio_iov_iter_get_pages(struct bio *bi=
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

+	switch (cleanup_mode) {
+	case FOLL_GET:
+		break;
+	case FOLL_PIN:
+		bio_set_flag(bio, BIO_PAGE_PINNED);
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		fallthrough;
+	case 0:
+		bio_set_flag(bio, BIO_NO_PAGE_REF);
+		break;
+	}
+
 	nr_pages =3D DIV_ROUND_UP(offset + size, PAGE_SIZE);
 =

 	trim =3D size & (bdev_logical_block_size(bio->bi_bdev) - 1);
@@ -1308,7 +1346,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio,=
 struct iov_iter *iter)
 	iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)
-		put_page(pages[i++]);
+		bio_release_page(bio, pages[i++]);
 =

 	return ret;
 }
@@ -1489,8 +1527,8 @@ void bio_set_pages_dirty(struct bio *bio)
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
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 99be590f952f..38e22a27d029 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -319,6 +319,7 @@ struct bio {
  */
 enum {
 	BIO_NO_PAGE_REF,	/* don't put release vec pages */
+	BIO_PAGE_PINNED,	/* Pages need unpinning rather than putting */
 	BIO_CLONED,		/* doesn't own data */
 	BIO_BOUNCED,		/* bio is a bounce bio */
 	BIO_QUIET,		/* Make BIO Quiet */


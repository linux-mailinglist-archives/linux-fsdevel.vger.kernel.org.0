Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BED06BB9F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Mar 2023 17:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232618AbjCOQic (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Mar 2023 12:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjCOQhu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Mar 2023 12:37:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 535AE7A905
        for <linux-fsdevel@vger.kernel.org>; Wed, 15 Mar 2023 09:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1678898201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7b6tezcmsCRtrHxO2uDV+B0gtFM5s5ObrJQQe5H2QZI=;
        b=HAwWi3tRb3H1uODIqQO+dtwF+RtpYnIuK6cYO/BFOcD7ay0dKJ1/12vS/jRGViFH+8RBNs
        0DmRuUmxT2AndKVISX+Si5MGR8869a9FUEtOpXkprtpeZNeE/4+F1o0n4352Atrlo22chz
        rOxnNDNuzio/mwNq54Xv2GDQOcfZf6E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-166-eXTazPypPp6eK0h5OKSezQ-1; Wed, 15 Mar 2023 12:36:36 -0400
X-MC-Unique: eXTazPypPp6eK0h5OKSezQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 40B00185A792;
        Wed, 15 Mar 2023 16:36:35 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 22FDE2A68;
        Wed, 15 Mar 2023 16:36:33 +0000 (UTC)
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
Subject: [PATCH v19 14/15] block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
Date:   Wed, 15 Mar 2023 16:35:48 +0000
Message-Id: <20230315163549.295454-15-dhowells@redhat.com>
In-Reply-To: <20230315163549.295454-1-dhowells@redhat.com>
References: <20230315163549.295454-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This will pin pages or leave them unaltered rather than getting a ref on
them as appropriate to the iterator.

The pages need to be pinned for DIO rather than having refs taken on them to
prevent VM copy-on-write from malfunctioning during a concurrent fork() (the
result of the I/O could otherwise end up being affected by/visible to the
child process).

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
    
    ver #8)
     - Split the patch up a bit [hch].
     - We should only be using pinned/non-pinned pages and not ref'd pages,
       so adjust the comments appropriately.
    
    ver #7)
     - Don't treat BIO_PAGE_REFFED/PINNED as being the same as FOLL_GET/PIN.
    
    ver #5)
     - Transcribe the FOLL_* flags returned by iov_iter_extract_pages() to
       BIO_* flags and got rid of bi_cleanup_mode.
     - Replaced BIO_NO_PAGE_REF to BIO_PAGE_REFFED in the preceding patch.

 block/bio.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 51ae957cc4b6..fc98c1c723ca 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1204,7 +1204,7 @@ static int bio_iov_add_page(struct bio *bio, struct page *page,
 	}
 
 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 
@@ -1218,7 +1218,7 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
 			queue_max_zone_append_sectors(q), &same_page) != len)
 		return -EINVAL;
 	if (same_page)
-		put_page(page);
+		bio_release_page(bio, page);
 	return 0;
 }
 
@@ -1229,10 +1229,10 @@ static int bio_iov_add_zone_append_page(struct bio *bio, struct page *page,
  * @bio: bio to add pages to
  * @iter: iov iterator describing the region to be mapped
  *
- * Pins pages from *iter and appends them to @bio's bvec array. The
- * pages will have to be released using put_page() when done.
- * For multi-segment *iter, this function only adds pages from the
- * next non-empty segment of the iov iterator.
+ * Extracts pages from *iter and appends them to @bio's bvec array.  The pages
+ * will have to be cleaned up in the way indicated by the BIO_PAGE_PINNED flag.
+ * For a multi-segment *iter, this function only adds pages from the next
+ * non-empty segment of the iov iterator.
  */
 static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 {
@@ -1264,9 +1264,9 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	 * result to ensure the bio's total size is correct. The remainder of
 	 * the iov data will be picked up in the next bio iteration.
 	 */
-	size = iov_iter_get_pages(iter, pages,
-				  UINT_MAX - bio->bi_iter.bi_size,
-				  nr_pages, &offset, extraction_flags);
+	size = iov_iter_extract_pages(iter, &pages,
+				      UINT_MAX - bio->bi_iter.bi_size,
+				      nr_pages, extraction_flags, &offset);
 	if (unlikely(size <= 0))
 		return size ? size : -EFAULT;
 
@@ -1299,7 +1299,7 @@ static int __bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	iov_iter_revert(iter, left);
 out:
 	while (i < nr_pages)
-		put_page(pages[i++]);
+		bio_release_page(bio, pages[i++]);
 
 	return ret;
 }
@@ -1334,7 +1334,8 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 		return 0;
 	}
 
-	bio_set_flag(bio, BIO_PAGE_REFFED);
+	if (iov_iter_extract_will_pin(iter))
+		bio_set_flag(bio, BIO_PAGE_PINNED);
 	do {
 		ret = __bio_iov_iter_get_pages(bio, iter);
 	} while (!ret && iov_iter_count(iter) && !bio_full(bio, 0));


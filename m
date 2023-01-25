Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6377467BDB7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 22:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbjAYVJU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 16:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236424AbjAYVIx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:08:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6D75AA62
        for <linux-fsdevel@vger.kernel.org>; Wed, 25 Jan 2023 13:07:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674680850;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HxbGCr5tQJM018IcUZUsOd5DaRqruIG+kHm6Wg5+DfQ=;
        b=N7sBlBpcmTgPlaWK4n/9yGziIa5Bht2wMnuHxoMnfTDrtNTgiLEUg4pi8FVCcFMZwFaUBc
        K0y/hERNSJKXaRilOSsM57yhSGQA8YVLlgvVulJC237i6lSltBguK2t/+ah8y+w2FqKw7/
        JyqQYIlk2YrVepX6AH2Y/Z1L2qAewxo=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-R8pex_C2NICT8VgrohPLJQ-1; Wed, 25 Jan 2023 16:07:26 -0500
X-MC-Unique: R8pex_C2NICT8VgrohPLJQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A1591C0A58E;
        Wed, 25 Jan 2023 21:07:25 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9317A14171BB;
        Wed, 25 Jan 2023 21:07:23 +0000 (UTC)
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
Subject: [PATCH v10 8/8] block: convert bio_map_user_iov to use iov_iter_extract_pages
Date:   Wed, 25 Jan 2023 21:06:57 +0000
Message-Id: <20230125210657.2335748-9-dhowells@redhat.com>
In-Reply-To: <20230125210657.2335748-1-dhowells@redhat.com>
References: <20230125210657.2335748-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
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

The pages need to be pinned for DIO rather than having refs taken on them
to prevent VM copy-on-write from malfunctioning during a concurrent fork()
(the result of the I/O could otherwise end up being visible to/affected by
the child process).

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

 block/blk-map.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index 0e2b0a861ba3..9c7ccea3f334 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -281,22 +281,21 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 
 	if (blk_queue_pci_p2pdma(rq->q))
 		extraction_flags |= ITER_ALLOW_P2PDMA;
+	if (iov_iter_extract_will_pin(iter))
+		bio_set_flag(bio, BIO_PAGE_PINNED);
 
-	bio_set_flag(bio, BIO_PAGE_REFFED);
 	while (iov_iter_count(iter)) {
-		struct page **pages, *stack_pages[UIO_FASTIOV];
+		struct page *stack_pages[UIO_FASTIOV];
+		struct page **pages = stack_pages;
 		ssize_t bytes;
 		size_t offs;
 		int npages;
 
-		if (nr_vecs <= ARRAY_SIZE(stack_pages)) {
-			pages = stack_pages;
-			bytes = iov_iter_get_pages(iter, pages, LONG_MAX,
-						   nr_vecs, &offs, extraction_flags);
-		} else {
-			bytes = iov_iter_get_pages_alloc(iter, &pages,
-						LONG_MAX, &offs, extraction_flags);
-		}
+		if (nr_vecs > ARRAY_SIZE(stack_pages))
+			pages = NULL;
+
+		bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
+					       nr_vecs, extraction_flags, &offs);
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
@@ -318,7 +317,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
 						     max_sectors, &same_page)) {
 					if (same_page)
-						put_page(page);
+						bio_release_page(bio, page);
 					break;
 				}
 
@@ -330,7 +329,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		 * release the pages we didn't map into the bio, if any
 		 */
 		while (j < npages)
-			put_page(pages[j++]);
+			bio_release_page(bio, pages[j++]);
 		if (pages != stack_pages)
 			kvfree(pages);
 		/* couldn't stuff something into bio? */


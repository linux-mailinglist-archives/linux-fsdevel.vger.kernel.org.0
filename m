Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D67B678339
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jan 2023 18:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233448AbjAWRcy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 23 Jan 2023 12:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjAWRck (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:32:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 572A02ED4C
        for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jan 2023 09:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674495038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zi65h8kb+iIzTHBTD5yjY8npgp3PwB4fOrnEoPzlk1s=;
        b=iUoscgl/quBZkUH7UL6Bye19nNd3XnfGcYbpfvont0ZYfsoTb0AkB+tGL/HNdkZtlnN9aa
        GxO2CMnE/Zv5DqmGtxprRf1YsSXlHU+zh9AwzScko7LHzB4nsnA0ZxVPkP5UpDwcXt7PQo
        SfOyNiwtWl6MvwH85bxPcpYbiikm4yM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-659-FeZB6NtzO5eUR41mHESISA-1; Mon, 23 Jan 2023 12:30:33 -0500
X-MC-Unique: FeZB6NtzO5eUR41mHESISA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4FD0B1C0896F;
        Mon, 23 Jan 2023 17:30:32 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E0742492C1B;
        Mon, 23 Jan 2023 17:30:30 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH v8 09/10] block: convert bio_map_user_iov to use iov_iter_extract_pages
Date:   Mon, 23 Jan 2023 17:30:06 +0000
Message-Id: <20230123173007.325544-10-dhowells@redhat.com>
In-Reply-To: <20230123173007.325544-1-dhowells@redhat.com>
References: <20230123173007.325544-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Jens Axboe <axboe@kernel.dk>
cc: Jan Kara <jack@suse.cz>
cc: Christoph Hellwig <hch@lst.de>
cc: Matthew Wilcox <willy@infradead.org>
cc: Logan Gunthorpe <logang@deltatee.com>
cc: linux-block@vger.kernel.org
---

Notes:
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

 block/blk-map.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/block/blk-map.c b/block/blk-map.c
index a4ada4389d5e..b9b36af3c3f7 100644
--- a/block/blk-map.c
+++ b/block/blk-map.c
@@ -282,21 +282,19 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 	if (blk_queue_pci_p2pdma(rq->q))
 		extract_flags |= ITER_ALLOW_P2PDMA;
 
-	bio_set_flag(bio, BIO_PAGE_REFFED);
+	bio_set_cleanup_mode(bio, iter);
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
-						   nr_vecs, &offs, extract_flags);
-		} else {
-			bytes = iov_iter_get_pages_alloc(iter, &pages,
-						LONG_MAX, &offs, extract_flags);
-		}
+		if (nr_vecs > ARRAY_SIZE(stack_pages))
+			pages = NULL;
+
+		bytes = iov_iter_extract_pages(iter, &pages, LONG_MAX,
+					       nr_vecs, extract_flags, &offs);
 		if (unlikely(bytes <= 0)) {
 			ret = bytes ? bytes : -EFAULT;
 			goto out_unmap;
@@ -318,7 +316,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 				if (!bio_add_hw_page(rq->q, bio, page, n, offs,
 						     max_sectors, &same_page)) {
 					if (same_page)
-						put_page(page);
+						bio_release_page(bio, page);
 					break;
 				}
 
@@ -330,7 +328,7 @@ static int bio_map_user_iov(struct request *rq, struct iov_iter *iter,
 		 * release the pages we didn't map into the bio, if any
 		 */
 		while (j < npages)
-			put_page(pages[j++]);
+			bio_release_page(bio, pages[j++]);
 		if (pages != stack_pages)
 			kvfree(pages);
 		/* couldn't stuff something into bio? */


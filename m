Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77630798A53
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 18:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244738AbjIHQET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 12:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244733AbjIHQER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:04:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920B71FDC
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694189015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8QArWqYjany3/3Kdac4mEmfhyAbXGy4THe9mhs3GeTM=;
        b=Y6qBqgnQFIWMIuSOBESqLLWVrc/sInb2umZVcxL/nOIGME6ZgPKRJyEHezlKLPnXHaJVuL
        ZHoPPifEcC1RIN1Wudq8DR41hPSdmWMZJeDORyT4MwG7ETARsbqCSVyROHTORJCwECGL2y
        Mm0+dMz8ZrkouZQibkDo34q06ZEP1mg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-ChoFSJu6N1CkSRVz_hnIRQ-1; Fri, 08 Sep 2023 12:03:32 -0400
X-MC-Unique: ChoFSJu6N1CkSRVz_hnIRQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C7392101CA84;
        Fri,  8 Sep 2023 16:03:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0C70F2026D4B;
        Fri,  8 Sep 2023 16:03:29 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] iov_iter: Fix iov_iter_extract_pages()
Date:   Fri,  8 Sep 2023 17:03:20 +0100
Message-ID: <20230908160322.1714302-2-dhowells@redhat.com>
In-Reply-To: <20230908160322.1714302-1-dhowells@redhat.com>
References: <20230908160322.1714302-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

iov_iter_extract_pages() doesn't correctly handle skipping over initial
zero-length entries in ITER_KVEC and ITER_BVEC-type iterators.  The problem is
that it accidentally reduces maxsize to 0 when it skipping and thus runs to
the end of the array and returns 0.

Fix this by sticking the calculated size-to-copy in a new variable rather
than back in maxsize.

Fixes: 7d58fe731028 ("iov_iter: Add a function to extract a page list from an iterator")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: linux-mm@kvack.org
cc: linux-block@vger.kernel.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/iov_iter.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index b31597b0ca20..27234a820eeb 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1654,14 +1654,14 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 					   size_t *offset0)
 {
 	struct page **p, *page;
-	size_t skip = i->iov_offset, offset;
+	size_t skip = i->iov_offset, offset, size;
 	int k;
 
 	for (;;) {
 		if (i->nr_segs == 0)
 			return 0;
-		maxsize = min(maxsize, i->bvec->bv_len - skip);
-		if (maxsize)
+		size = min(maxsize, i->bvec->bv_len - skip);
+		if (size)
 			break;
 		i->iov_offset = 0;
 		i->nr_segs--;
@@ -1674,16 +1674,16 @@ static ssize_t iov_iter_extract_bvec_pages(struct iov_iter *i,
 	offset = skip % PAGE_SIZE;
 	*offset0 = offset;
 
-	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	maxpages = want_pages_array(pages, size, offset, maxpages);
 	if (!maxpages)
 		return -ENOMEM;
 	p = *pages;
 	for (k = 0; k < maxpages; k++)
 		p[k] = page + k;
 
-	maxsize = min_t(size_t, maxsize, maxpages * PAGE_SIZE - offset);
-	iov_iter_advance(i, maxsize);
-	return maxsize;
+	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
+	iov_iter_advance(i, size);
+	return size;
 }
 
 /*
@@ -1698,14 +1698,14 @@ static ssize_t iov_iter_extract_kvec_pages(struct iov_iter *i,
 {
 	struct page **p, *page;
 	const void *kaddr;
-	size_t skip = i->iov_offset, offset, len;
+	size_t skip = i->iov_offset, offset, len, size;
 	int k;
 
 	for (;;) {
 		if (i->nr_segs == 0)
 			return 0;
-		maxsize = min(maxsize, i->kvec->iov_len - skip);
-		if (maxsize)
+		size = min(maxsize, i->kvec->iov_len - skip);
+		if (size)
 			break;
 		i->iov_offset = 0;
 		i->nr_segs--;
@@ -1717,13 +1717,13 @@ static ssize_t iov_iter_extract_kvec_pages(struct iov_iter *i,
 	offset = (unsigned long)kaddr & ~PAGE_MASK;
 	*offset0 = offset;
 
-	maxpages = want_pages_array(pages, maxsize, offset, maxpages);
+	maxpages = want_pages_array(pages, size, offset, maxpages);
 	if (!maxpages)
 		return -ENOMEM;
 	p = *pages;
 
 	kaddr -= offset;
-	len = offset + maxsize;
+	len = offset + size;
 	for (k = 0; k < maxpages; k++) {
 		size_t seg = min_t(size_t, len, PAGE_SIZE);
 
@@ -1737,9 +1737,9 @@ static ssize_t iov_iter_extract_kvec_pages(struct iov_iter *i,
 		kaddr += PAGE_SIZE;
 	}
 
-	maxsize = min_t(size_t, maxsize, maxpages * PAGE_SIZE - offset);
-	iov_iter_advance(i, maxsize);
-	return maxsize;
+	size = min_t(size_t, size, maxpages * PAGE_SIZE - offset);
+	iov_iter_advance(i, size);
+	return size;
 }
 
 /*


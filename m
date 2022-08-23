Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 699A459E839
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Aug 2022 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241971AbiHWRBk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Aug 2022 13:01:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343948AbiHWRAj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:00:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38E54A2A87
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 Aug 2022 07:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661263941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XXAzfA+fOYtv11LNMO9ob47ffQq5WUBN0kv6KdmFv7Q=;
        b=SBm5Q/6as9mEGGFTARIqJotOP1dLvCdnban2hDCb4KsB6XA0rQJv1XI8UpZk3Y6ypeVrvW
        ZOVTxxcvV0aGjy3tfbwqCGbhi+leVE8L0/dZKL35TxXPifz9dka2btKCdfa3Z4wvJ2N3+c
        v4zzjHsHGjapvfVV0Ru1edOdpXMOl3k=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-91-O7HXFN1wPZO0QXKkMJ5rJA-1; Tue, 23 Aug 2022 10:12:17 -0400
X-MC-Unique: O7HXFN1wPZO0QXKkMJ5rJA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDF08101A56D;
        Tue, 23 Aug 2022 14:12:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ACA2D1121315;
        Tue, 23 Aug 2022 14:12:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/7] iov_iter: Add a function to extract an iter's buffers to
 a bvec iter
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 23 Aug 2022 15:12:14 +0100
Message-ID: <166126393409.708021.16165278011941496946.stgit@warthog.procyon.org.uk>
In-Reply-To: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
References: <166126392703.708021.14465850073772688008.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Copy cifs's setup_aio_ctx_iter() and to lib/iov_iter.c and generalise it as
extract_iter_to_iter().  This allocates and sets up an array of bio_vecs
for all the page fragments in an I/O iterator and sets a second supplied
iterator to bvec-type pointing to the array.

This is can be used when setting up for a direct I/O or an asynchronous I/O
to set up a record of the page fragments that are going to contribute to
the buffer, paging them all in to prevent DIO->mmap loops and allowing the
original iterator to be deallocated (it may be on the stack of the caller).

Note that extract_iter_to_iter() doesn't actually need to make a separate
allocation for the page array.  It can place the page array at the end of
the bvec array storage, provided it traverses both arrays from the 0th
element forwards.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 include/linux/uio.h |    4 ++
 lib/iov_iter.c      |   93 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 97 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index 5896af36199c..88fd93508710 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -251,6 +251,10 @@ ssize_t iov_iter_get_pages2(struct iov_iter *i, struct page **pages,
 			size_t maxsize, unsigned maxpages, size_t *start);
 ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i, struct page ***pages,
 			size_t maxsize, size_t *start);
+ssize_t extract_iter_to_iter(struct iov_iter *orig,
+			     size_t orig_len,
+			     struct iov_iter *new,
+			     struct bio_vec **_bv);
 int iov_iter_npages(const struct iov_iter *i, int maxpages);
 void iov_iter_restore(struct iov_iter *i, struct iov_iter_state *state);
 
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 4b7fce72e3e5..c07bf978b935 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1518,6 +1518,99 @@ ssize_t iov_iter_get_pages_alloc2(struct iov_iter *i,
 }
 EXPORT_SYMBOL(iov_iter_get_pages_alloc2);
 
+/**
+ * extract_iter_to_iter - Extract the pages from one iterator into another
+ * @orig: The original iterator
+ * @orig_len: The amount of iterator to copy
+ * @new: The iterator to be set up
+ * @_bv: Where to store the allocated bvec table pointer, if allocated
+ *
+ * Extract the page fragments from the given amount of the source iterator and
+ * build up a second iterator that refers to all of those bits.  This allows
+ * the original iterator to disposed of.
+ *
+ * If a bvec array is created, the number of pages in the array is returned and
+ * a pointer to the array is saved into *@_bv;
+ */
+ssize_t extract_iter_to_iter(struct iov_iter *orig,
+			     size_t orig_len,
+			     struct iov_iter *new,
+			     struct bio_vec **_bv)
+{
+	struct bio_vec *bv = NULL;
+	struct page **pages;
+	unsigned int cur_npages;
+	unsigned int max_pages = iov_iter_npages(orig, INT_MAX);
+	unsigned int npages = 0;
+	unsigned int i;
+	size_t count = orig_len;
+	ssize_t ret;
+	size_t bv_size, pg_size;
+	size_t start;
+	size_t len;
+
+	*_bv = NULL;
+
+	if (iov_iter_is_kvec(orig) || iov_iter_is_discard(orig)) {
+		*new = *orig;
+		iov_iter_advance(orig, count);
+		return 0;
+	}
+
+	bv_size = array_size(max_pages, sizeof(*bv));
+	bv = kvmalloc(bv_size, GFP_KERNEL);
+	if (!bv)
+		return -ENOMEM;
+
+	/* Put the page list at the end of the bvec list storage.  bvec
+	 * elements are larger than page pointers, so as long as we work
+	 * 0->last, we should be fine.
+	 */
+	pg_size = array_size(max_pages, sizeof(*pages));
+	pages = (void *)bv + bv_size - pg_size;
+
+	while (count && npages < max_pages) {
+		ret = iov_iter_get_pages2(orig, pages, count, max_pages - npages,
+					  &start);
+		if (ret < 0) {
+			pr_err("Couldn't get user pages (rc=%zd)\n", ret);
+			break;
+		}
+
+		if (ret > count) {
+			pr_err("get_pages rc=%zd more than %zu\n", ret, count);
+			break;
+		}
+
+		iov_iter_advance(orig, ret);
+		count -= ret;
+		ret += start;
+		cur_npages = DIV_ROUND_UP(ret, PAGE_SIZE);
+
+		if (npages + cur_npages > max_pages) {
+			pr_err("Out of bvec array capacity (%u vs %u)\n",
+			       npages + cur_npages, max_pages);
+			break;
+		}
+
+		for (i = 0; i < cur_npages; i++) {
+			len = ret > PAGE_SIZE ? PAGE_SIZE : ret;
+			bv[npages + i].bv_page	 = *pages++;
+			bv[npages + i].bv_offset = start;
+			bv[npages + i].bv_len	 = len - start;
+			ret -= len;
+			start = 0;
+		}
+
+		npages += cur_npages;
+	}
+
+	*_bv = bv;
+	iov_iter_bvec(new, iov_iter_rw(orig), bv, npages, orig_len - count);
+	return npages;
+}
+EXPORT_SYMBOL(extract_iter_to_iter);
+
 size_t csum_and_copy_from_iter(void *addr, size_t bytes, __wsum *csum,
 			       struct iov_iter *i)
 {



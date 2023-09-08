Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 161B5798A60
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Sep 2023 18:04:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244877AbjIHQEn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Sep 2023 12:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239174AbjIHQEm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Sep 2023 12:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17D882100
        for <linux-fsdevel@vger.kernel.org>; Fri,  8 Sep 2023 09:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694189023;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c5qKGDJOH0h32jOCU9/toIJ7m/LhliQCTlgTlpbMOlk=;
        b=YbT8QYTgGzFC4l2CGs31p0htaCdPrxk6DFn97yNQ994rbC2dj8FUcBCBgt+Id6dfebWrEI
        TXJafuUhpFKV8DgG+oDxz3z226/pPig+DubZejkhmTrfItz6EZBVv1kiXuVlI3BRbSLazt
        6XV3YuWJnpwauEDNV+/l7lf00km4Msk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-614-qVvRZSWPMUOFjFvB_AMgfg-1; Fri, 08 Sep 2023 12:03:38 -0400
X-MC-Unique: qVvRZSWPMUOFjFvB_AMgfg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F2BAC101A529;
        Fri,  8 Sep 2023 16:03:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 25E5FC03295;
        Fri,  8 Sep 2023 16:03:35 +0000 (UTC)
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
Subject: [PATCH 3/3] iov_iter: Kunit tests for page extraction
Date:   Fri,  8 Sep 2023 17:03:22 +0100
Message-ID: <20230908160322.1714302-4-dhowells@redhat.com>
In-Reply-To: <20230908160322.1714302-1-dhowells@redhat.com>
References: <20230908160322.1714302-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

Add some kunit tests for page extraction for ITER_BVEC, ITER_KVEC and
ITER_XARRAY type iterators.  ITER_UBUF and ITER_IOVEC aren't dealt with as
they require userspace VM interaction.  ITER_DISCARD isn't dealt with
either as that can't be extracted.

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
 lib/kunit_iov_iter.c | 240 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 240 insertions(+)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 25a910187d17..859b67c4d697 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -519,6 +519,243 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 	KUNIT_SUCCEED();
 }
 
+/*
+ * Test the extraction of ITER_KVEC-type iterators.
+ */
+static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct page **bpages, *pagelist[8], **pages = pagelist;
+	struct kvec kvec[8];
+	u8 *buffer;
+	ssize_t len;
+	size_t bufsize, size = 0, npages;
+	int i, from;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	buffer = iov_kunit_create_buffer(test, &bpages, npages);
+
+	iov_kunit_load_kvec(test, &iter, READ, kvec, ARRAY_SIZE(kvec),
+			    buffer, bufsize, kvec_test_ranges);
+	size = iter.count;
+
+	pr = kvec_test_ranges;
+	from = pr->from;
+	do {
+		size_t offset0 = LONG_MAX;
+
+		for (i = 0; i < ARRAY_SIZE(pagelist); i++)
+			pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+
+		len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
+					     ARRAY_SIZE(pagelist), 0, &offset0);
+		KUNIT_EXPECT_GE(test, len, 0);
+		if (len < 0)
+			break;
+		KUNIT_EXPECT_GE(test, (ssize_t)offset0, 0);
+		KUNIT_EXPECT_LT(test, offset0, PAGE_SIZE);
+		KUNIT_EXPECT_LE(test, len, size);
+		KUNIT_EXPECT_EQ(test, iter.count, size - len);
+		size -= len;
+
+		if (len == 0)
+			break;
+
+		for (i = 0; i < ARRAY_SIZE(pagelist); i++) {
+			struct page *p;
+			ssize_t part = min_t(ssize_t, len, PAGE_SIZE - offset0);
+			int ix;
+
+			KUNIT_ASSERT_GE(test, part, 0);
+			while (from == pr->to) {
+				pr++;
+				from = pr->from;
+				if (from < 0)
+					goto stop;
+			}
+			ix = from / PAGE_SIZE;
+			KUNIT_ASSERT_LT(test, ix, npages);
+			p = bpages[ix];
+			KUNIT_EXPECT_PTR_EQ(test, pagelist[i], p);
+			KUNIT_EXPECT_EQ(test, offset0, from % PAGE_SIZE);
+			from += part;
+			len -= part;
+			KUNIT_ASSERT_GE(test, len, 0);
+			if (len == 0)
+				break;
+			offset0 = 0;
+		}
+
+		if (test->status == KUNIT_FAILURE)
+			break;
+	} while (iov_iter_count(&iter) > 0);
+
+stop:
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_EQ(test, iter.count, 0);
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Test the extraction of ITER_BVEC-type iterators.
+ */
+static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
+{
+	const struct bvec_test_range *pr;
+	struct iov_iter iter;
+	struct page **bpages, *pagelist[8], **pages = pagelist;
+	struct bio_vec bvec[8];
+	ssize_t len;
+	size_t bufsize, size = 0, npages;
+	int i, from;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	iov_kunit_create_buffer(test, &bpages, npages);
+	iov_kunit_load_bvec(test, &iter, READ, bvec, ARRAY_SIZE(bvec),
+			    bpages, npages, bufsize, bvec_test_ranges);
+	size = iter.count;
+
+	pr = bvec_test_ranges;
+	from = pr->from;
+	do {
+		size_t offset0 = LONG_MAX;
+
+		for (i = 0; i < ARRAY_SIZE(pagelist); i++)
+			pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+
+		len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
+					     ARRAY_SIZE(pagelist), 0, &offset0);
+		KUNIT_EXPECT_GE(test, len, 0);
+		if (len < 0)
+			break;
+		KUNIT_EXPECT_GE(test, (ssize_t)offset0, 0);
+		KUNIT_EXPECT_LT(test, offset0, PAGE_SIZE);
+		KUNIT_EXPECT_LE(test, len, size);
+		KUNIT_EXPECT_EQ(test, iter.count, size - len);
+		size -= len;
+
+		if (len == 0)
+			break;
+
+		for (i = 0; i < ARRAY_SIZE(pagelist); i++) {
+			struct page *p;
+			ssize_t part = min_t(ssize_t, len, PAGE_SIZE - offset0);
+			int ix;
+
+			KUNIT_ASSERT_GE(test, part, 0);
+			while (from == pr->to) {
+				pr++;
+				from = pr->from;
+				if (from < 0)
+					goto stop;
+			}
+			ix = pr->page + from / PAGE_SIZE;
+			KUNIT_ASSERT_LT(test, ix, npages);
+			p = bpages[ix];
+			KUNIT_EXPECT_PTR_EQ(test, pagelist[i], p);
+			KUNIT_EXPECT_EQ(test, offset0, from % PAGE_SIZE);
+			from += part;
+			len -= part;
+			KUNIT_ASSERT_GE(test, len, 0);
+			if (len == 0)
+				break;
+			offset0 = 0;
+		}
+
+		if (test->status == KUNIT_FAILURE)
+			break;
+	} while (iov_iter_count(&iter) > 0);
+
+stop:
+	KUNIT_EXPECT_EQ(test, size, 0);
+	KUNIT_EXPECT_EQ(test, iter.count, 0);
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Test the extraction of ITER_XARRAY-type iterators.
+ */
+static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
+{
+	const struct kvec_test_range *pr;
+	struct iov_iter iter;
+	struct xarray *xarray;
+	struct page **bpages, *pagelist[8], **pages = pagelist;
+	ssize_t len;
+	size_t bufsize, size = 0, npages;
+	int i, from;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	xarray = iov_kunit_create_xarray(test);
+
+	iov_kunit_create_buffer(test, &bpages, npages);
+	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
+
+	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+		from = pr->from;
+		size = pr->to - from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_xarray(&iter, WRITE, xarray, from, size);
+
+		do {
+			size_t offset0 = LONG_MAX;
+
+			for (i = 0; i < ARRAY_SIZE(pagelist); i++)
+				pagelist[i] = (void *)(unsigned long)0xaa55aa55aa55aa55ULL;
+
+			len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
+						     ARRAY_SIZE(pagelist), 0, &offset0);
+			KUNIT_EXPECT_GE(test, len, 0);
+			if (len < 0)
+				break;
+			KUNIT_EXPECT_LE(test, len, size);
+			KUNIT_EXPECT_EQ(test, iter.count, size - len);
+			if (len == 0)
+				break;
+			size -= len;
+			KUNIT_EXPECT_GE(test, (ssize_t)offset0, 0);
+			KUNIT_EXPECT_LT(test, offset0, PAGE_SIZE);
+
+			for (i = 0; i < ARRAY_SIZE(pagelist); i++) {
+				struct page *p;
+				ssize_t part = min_t(ssize_t, len, PAGE_SIZE - offset0);
+				int ix;
+
+				KUNIT_ASSERT_GE(test, part, 0);
+				ix = from / PAGE_SIZE;
+				KUNIT_ASSERT_LT(test, ix, npages);
+				p = bpages[ix];
+				KUNIT_EXPECT_PTR_EQ(test, pagelist[i], p);
+				KUNIT_EXPECT_EQ(test, offset0, from % PAGE_SIZE);
+				from += part;
+				len -= part;
+				KUNIT_ASSERT_GE(test, len, 0);
+				if (len == 0)
+					break;
+				offset0 = 0;
+			}
+
+			if (test->status == KUNIT_FAILURE)
+				goto stop;
+		} while (iov_iter_count(&iter) > 0);
+
+		KUNIT_EXPECT_EQ(test, size, 0);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		KUNIT_EXPECT_EQ(test, iter.iov_offset, pr->to - pr->from);
+	}
+
+stop:
+	KUNIT_SUCCEED();
+}
+
 static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_to_kvec),
 	KUNIT_CASE(iov_kunit_copy_from_kvec),
@@ -526,6 +763,9 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_from_bvec),
 	KUNIT_CASE(iov_kunit_copy_to_xarray),
 	KUNIT_CASE(iov_kunit_copy_from_xarray),
+	KUNIT_CASE(iov_kunit_extract_pages_kvec),
+	KUNIT_CASE(iov_kunit_extract_pages_bvec),
+	KUNIT_CASE(iov_kunit_extract_pages_xarray),
 	{}
 };
 


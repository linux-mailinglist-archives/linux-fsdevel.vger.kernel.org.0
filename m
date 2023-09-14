Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F10C07A10AE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 00:16:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbjINWQi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 18:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbjINWQb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:16:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 821DF271B
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 15:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694729741;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4ut+h9nLVtpMfUa14begCRaPNr+Lp71R8/RKDVqE44g=;
        b=crh+LU4juCMX/WjVoY3p+MRqWNm78wee9YKtN7yHYuaUHTgTJyMtYSXPlG9ovL1mMDGel4
        UqM1qy1Wjgf40JqRQI4NBK4zdNWRqrBPxfZVZhZIfJyCGHe1xLFqz2wX+dJ1LuaAwh7Fzi
        0Ij60NAoZCTdhy5I7F9UXXNPuxmxggA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-615-Dibw7jBuPtiY53bSfV_A_Q-1; Thu, 14 Sep 2023 18:15:37 -0400
X-MC-Unique: Dibw7jBuPtiY53bSfV_A_Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9C577101B456;
        Thu, 14 Sep 2023 22:15:36 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3D31410069B4;
        Thu, 14 Sep 2023 22:15:34 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, linux-mm@kvack.org,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 2/9] iov_iter: Consolidate some of the repeated code into helpers
Date:   Thu, 14 Sep 2023 23:15:19 +0100
Message-ID: <20230914221526.3153402-3-dhowells@redhat.com>
In-Reply-To: <20230914221526.3153402-1-dhowells@redhat.com>
References: <20230914221526.3153402-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Consolidate some of the repeated code snippets into helper functions to
reduce the line count.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Brendan Higgins <brendanhiggins@google.com>
cc: David Gow <davidgow@google.com>
cc: linux-kselftest@vger.kernel.org
cc: kunit-dev@googlegroups.com
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/kunit_iov_iter.c | 189 +++++++++++++++++++------------------------
 1 file changed, 84 insertions(+), 105 deletions(-)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 4a6c0efd33f5..ee586eb652b4 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -19,18 +19,18 @@ MODULE_AUTHOR("David Howells <dhowells@redhat.com>");
 MODULE_LICENSE("GPL");
 
 struct kvec_test_range {
-	int	from, to;
+	int	page, from, to;
 };
 
 static const struct kvec_test_range kvec_test_ranges[] = {
-	{ 0x00002, 0x00002 },
-	{ 0x00027, 0x03000 },
-	{ 0x05193, 0x18794 },
-	{ 0x20000, 0x20000 },
-	{ 0x20000, 0x24000 },
-	{ 0x24000, 0x27001 },
-	{ 0x29000, 0xffffb },
-	{ 0xffffd, 0xffffe },
+	{ 0, 0x00002, 0x00002 },
+	{ 0, 0x00027, 0x03000 },
+	{ 0, 0x05193, 0x18794 },
+	{ 0, 0x20000, 0x20000 },
+	{ 0, 0x20000, 0x24000 },
+	{ 0, 0x24000, 0x27001 },
+	{ 0, 0x29000, 0xffffb },
+	{ 0, 0xffffd, 0xffffe },
 	{ -1 }
 };
 
@@ -69,6 +69,57 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 	return buffer;
 }
 
+/*
+ * Build the reference pattern in the scratch buffer that we expect to see in
+ * the iterator buffer (ie. the result of copy *to*).
+ */
+static void iov_kunit_build_to_reference_pattern(struct kunit *test, u8 *scratch,
+						 size_t bufsize,
+						 const struct kvec_test_range *pr)
+{
+	int i, patt = 0;
+
+	memset(scratch, 0, bufsize);
+	for (; pr->page >= 0; pr++)
+		for (i = pr->from; i < pr->to; i++)
+			scratch[i] = pattern(patt++);
+}
+
+/*
+ * Build the reference pattern in the iterator buffer that we expect to see in
+ * the scratch buffer (ie. the result of copy *from*).
+ */
+static void iov_kunit_build_from_reference_pattern(struct kunit *test, u8 *buffer,
+						   size_t bufsize,
+						   const struct kvec_test_range *pr)
+{
+	size_t i = 0, j;
+
+	memset(buffer, 0, bufsize);
+	for (; pr->page >= 0; pr++) {
+		for (j = pr->from; j < pr->to; j++) {
+			buffer[i++] = pattern(j);
+			if (i >= bufsize)
+				return;
+		}
+	}
+}
+
+/*
+ * Compare two kernel buffers to see that they're the same.
+ */
+static void iov_kunit_check_pattern(struct kunit *test, const u8 *buffer,
+				    const u8 *scratch, size_t bufsize)
+{
+	size_t i;
+
+	for (i = 0; i < bufsize; i++) {
+		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
+		if (buffer[i] != scratch[i])
+			return;
+	}
+}
+
 static void __init iov_kunit_load_kvec(struct kunit *test,
 				       struct iov_iter *iter, int dir,
 				       struct kvec *kvec, unsigned int kvmax,
@@ -79,7 +130,7 @@ static void __init iov_kunit_load_kvec(struct kunit *test,
 	int i;
 
 	for (i = 0; i < kvmax; i++, pr++) {
-		if (pr->from < 0)
+		if (pr->page < 0)
 			break;
 		KUNIT_ASSERT_GE(test, pr->to, pr->from);
 		KUNIT_ASSERT_LE(test, pr->to, bufsize);
@@ -97,13 +148,12 @@ static void __init iov_kunit_load_kvec(struct kunit *test,
  */
 static void __init iov_kunit_copy_to_kvec(struct kunit *test)
 {
-	const struct kvec_test_range *pr;
 	struct iov_iter iter;
 	struct page **spages, **bpages;
 	struct kvec kvec[8];
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, patt;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -125,20 +175,8 @@ static void __init iov_kunit_copy_to_kvec(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
 	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
 
-	/* Build the expected image in the scratch buffer. */
-	patt = 0;
-	memset(scratch, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
-		for (i = pr->from; i < pr->to; i++)
-			scratch[i] = pattern(patt++);
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
-		if (buffer[i] != scratch[i])
-			return;
-	}
-
+	iov_kunit_build_to_reference_pattern(test, scratch, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -147,13 +185,12 @@ static void __init iov_kunit_copy_to_kvec(struct kunit *test)
  */
 static void __init iov_kunit_copy_from_kvec(struct kunit *test)
 {
-	const struct kvec_test_range *pr;
 	struct iov_iter iter;
 	struct page **spages, **bpages;
 	struct kvec kvec[8];
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, j;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -175,25 +212,8 @@ static void __init iov_kunit_copy_from_kvec(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, iter.count, 0);
 	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
 
-	/* Build the expected image in the main buffer. */
-	i = 0;
-	memset(buffer, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		for (j = pr->from; j < pr->to; j++) {
-			buffer[i++] = pattern(j);
-			if (i >= bufsize)
-				goto stop;
-		}
-	}
-stop:
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
-		if (scratch[i] != buffer[i])
-			return;
-	}
-
+	iov_kunit_build_from_reference_pattern(test, buffer, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -210,7 +230,7 @@ static const struct bvec_test_range bvec_test_ranges[] = {
 	{ 5, 0x0000, 0x1000 },
 	{ 6, 0x0000, 0x0ffb },
 	{ 6, 0x0ffd, 0x0ffe },
-	{ -1, -1, -1 }
+	{ -1 }
 };
 
 static void __init iov_kunit_load_bvec(struct kunit *test,
@@ -225,7 +245,7 @@ static void __init iov_kunit_load_bvec(struct kunit *test,
 	int i;
 
 	for (i = 0; i < bvmax; i++, pr++) {
-		if (pr->from < 0)
+		if (pr->page < 0)
 			break;
 		KUNIT_ASSERT_LT(test, pr->page, npages);
 		KUNIT_ASSERT_LT(test, pr->page * PAGE_SIZE, bufsize);
@@ -288,20 +308,14 @@ static void __init iov_kunit_copy_to_bvec(struct kunit *test)
 	b = 0;
 	patt = 0;
 	memset(scratch, 0, bufsize);
-	for (pr = bvec_test_ranges; pr->from >= 0; pr++, b++) {
+	for (pr = bvec_test_ranges; pr->page >= 0; pr++, b++) {
 		u8 *p = scratch + pr->page * PAGE_SIZE;
 
 		for (i = pr->from; i < pr->to; i++)
 			p[i] = pattern(patt++);
 	}
 
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
-		if (buffer[i] != scratch[i])
-			return;
-	}
-
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -341,7 +355,7 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 	/* Build the expected image in the main buffer. */
 	i = 0;
 	memset(buffer, 0, bufsize);
-	for (pr = bvec_test_ranges; pr->from >= 0; pr++) {
+	for (pr = bvec_test_ranges; pr->page >= 0; pr++) {
 		size_t patt = pr->page * PAGE_SIZE;
 
 		for (j = pr->from; j < pr->to; j++) {
@@ -352,13 +366,7 @@ static void __init iov_kunit_copy_from_bvec(struct kunit *test)
 	}
 stop:
 
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
-		if (scratch[i] != buffer[i])
-			return;
-	}
-
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -409,7 +417,7 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 	struct page **spages, **bpages;
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, patt;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -426,7 +434,7 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
 
 	i = 0;
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+	for (pr = kvec_test_ranges; pr->page >= 0; pr++) {
 		size = pr->to - pr->from;
 		KUNIT_ASSERT_LE(test, pr->to, bufsize);
 
@@ -439,20 +447,8 @@ static void __init iov_kunit_copy_to_xarray(struct kunit *test)
 		i += size;
 	}
 
-	/* Build the expected image in the scratch buffer. */
-	patt = 0;
-	memset(scratch, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
-		for (i = pr->from; i < pr->to; i++)
-			scratch[i] = pattern(patt++);
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
-		if (buffer[i] != scratch[i])
-			return;
-	}
-
+	iov_kunit_build_to_reference_pattern(test, scratch, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -467,7 +463,7 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 	struct page **spages, **bpages;
 	u8 *scratch, *buffer;
 	size_t bufsize, npages, size, copied;
-	int i, j;
+	int i;
 
 	bufsize = 0x100000;
 	npages = bufsize / PAGE_SIZE;
@@ -484,7 +480,7 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
 
 	i = 0;
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+	for (pr = kvec_test_ranges; pr->page >= 0; pr++) {
 		size = pr->to - pr->from;
 		KUNIT_ASSERT_LE(test, pr->to, bufsize);
 
@@ -497,25 +493,8 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 		i += size;
 	}
 
-	/* Build the expected image in the main buffer. */
-	i = 0;
-	memset(buffer, 0, bufsize);
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
-		for (j = pr->from; j < pr->to; j++) {
-			buffer[i++] = pattern(j);
-			if (i >= bufsize)
-				goto stop;
-		}
-	}
-stop:
-
-	/* Compare the images */
-	for (i = 0; i < bufsize; i++) {
-		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
-		if (scratch[i] != buffer[i])
-			return;
-	}
-
+	iov_kunit_build_from_reference_pattern(test, buffer, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, buffer, scratch, bufsize);
 	KUNIT_SUCCEED();
 }
 
@@ -573,7 +552,7 @@ static void __init iov_kunit_extract_pages_kvec(struct kunit *test)
 			while (from == pr->to) {
 				pr++;
 				from = pr->from;
-				if (from < 0)
+				if (pr->page < 0)
 					goto stop;
 			}
 			ix = from / PAGE_SIZE;
@@ -651,7 +630,7 @@ static void __init iov_kunit_extract_pages_bvec(struct kunit *test)
 			while (from == pr->to) {
 				pr++;
 				from = pr->from;
-				if (from < 0)
+				if (pr->page < 0)
 					goto stop;
 			}
 			ix = pr->page + from / PAGE_SIZE;
@@ -698,7 +677,7 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 	iov_kunit_create_buffer(test, &bpages, npages);
 	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
 
-	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
+	for (pr = kvec_test_ranges; pr->page >= 0; pr++) {
 		from = pr->from;
 		size = pr->to - from;
 		KUNIT_ASSERT_LE(test, pr->to, bufsize);


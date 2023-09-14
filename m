Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 493A47A10BC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 00:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjINWRL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 18:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjINWRF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:17:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B2FA2726
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 15:15:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694729752;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VtAwaM2B3p8HaWMuYOi3rMk0MQyqz+yXDmdiAqy5Wgk=;
        b=XmiIZYlafDOcP22lTGR2pnjapkZ/2DSlHnTOnoWQcGVAtYb6z/4b93hV7B/FkF1/xBprUs
        d+G+m0CzNWd0KEsc22dbyzBhJBaAH6++VVcTG3NhbWw9RmVV0wozejz+rQFqOikhSqkK3y
        acx2H87qX5uWKxgnTqjlE410nayUrAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-680-F6lxP1o9O8qZVNHtllb3dg-1; Thu, 14 Sep 2023 18:15:49 -0400
X-MC-Unique: F6lxP1o9O8qZVNHtllb3dg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CDD9D800159;
        Thu, 14 Sep 2023 22:15:48 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DF992156A27;
        Thu, 14 Sep 2023 22:15:46 +0000 (UTC)
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
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: [RFC PATCH 6/9] iov_iter: Add copy kunit tests for ITER_UBUF and ITER_IOVEC
Date:   Thu, 14 Sep 2023 23:15:23 +0100
Message-ID: <20230914221526.3153402-7-dhowells@redhat.com>
In-Reply-To: <20230914221526.3153402-1-dhowells@redhat.com>
References: <20230914221526.3153402-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Add copy kunit tests for ITER_UBUF- and ITER_IOVEC-type iterators.  This
attaches a userspace VM with a mapped file in it temporarily to the test
thread.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@linux-foundation.org>
cc: Christoph Hellwig <hch@lst.de>
cc: Christian Brauner <brauner@kernel.org>
cc: Jens Axboe <axboe@kernel.dk>
cc: Al Viro <viro@zeniv.linux.org.uk>
cc: Matthew Wilcox <willy@infradead.org>
cc: David Hildenbrand <david@redhat.com>
cc: John Hubbard <jhubbard@nvidia.com>
cc: Brendan Higgins <brendanhiggins@google.com>
cc: David Gow <davidgow@google.com>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: linux-kselftest@vger.kernel.org
cc: kunit-dev@googlegroups.com
---
 lib/kunit_iov_iter.c | 200 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 3353bca9c40f..78f566ebd4a6 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -309,6 +309,202 @@ static u8 __user *__init iov_kunit_create_user_buf(struct kunit *test,
 	return buffer;
 }
 
+/*
+ * Test copying to an ITER_UBUF-type iterator.
+ */
+static void __init iov_kunit_copy_to_ubuf(struct kunit *test)
+{
+	const struct iov_kunit_range *pr;
+	struct iov_iter iter;
+	struct page **spages;
+	u8 __user *buffer;
+	u8 *scratch;
+	ssize_t uncleared;
+	size_t bufsize, npages, size, copied;
+	int i;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	for (i = 0; i < bufsize; i++)
+		scratch[i] = pattern(i);
+
+	buffer = iov_kunit_create_user_buf(test, npages, NULL);
+	uncleared = clear_user(buffer, bufsize);
+	KUNIT_EXPECT_EQ(test, uncleared, 0);
+	if (uncleared)
+		return;
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->page >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_ubuf(&iter, ITER_DEST, buffer + pr->from, size);
+		copied = copy_to_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		KUNIT_EXPECT_EQ(test, iter.iov_offset, size);
+		if (test->status == KUNIT_FAILURE)
+			break;
+		i += size;
+	}
+
+	iov_kunit_build_to_reference_pattern(test, scratch, bufsize, kvec_test_ranges);
+	iov_kunit_check_user_pattern(test, buffer, scratch, bufsize);
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Test copying from an ITER_UBUF-type iterator.
+ */
+static void __init iov_kunit_copy_from_ubuf(struct kunit *test)
+{
+	const struct iov_kunit_range *pr;
+	struct iov_iter iter;
+	struct page **spages;
+	u8 __user *buffer;
+	u8 *scratch, *reference;
+	size_t bufsize, npages, size, copied;
+	int i;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	buffer = iov_kunit_create_user_buf(test, npages, NULL);
+	iov_kunit_fill_user_buf(test, buffer, bufsize);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	memset(scratch, 0, bufsize);
+
+	reference = iov_kunit_create_buffer(test, &spages, npages);
+
+	i = 0;
+	for (pr = kvec_test_ranges; pr->page >= 0; pr++) {
+		size = pr->to - pr->from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_ubuf(&iter, ITER_SOURCE, buffer + pr->from, size);
+		copied = copy_from_iter(scratch + i, size, &iter);
+
+		KUNIT_EXPECT_EQ(test, copied, size);
+		KUNIT_EXPECT_EQ(test, iter.count, 0);
+		KUNIT_EXPECT_EQ(test, iter.iov_offset, size);
+		if (test->status == KUNIT_FAILURE)
+			break;
+		i += size;
+	}
+
+	iov_kunit_build_from_reference_pattern(test, reference, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, scratch, reference, bufsize);
+	KUNIT_SUCCEED();
+}
+
+static void __init iov_kunit_load_iovec(struct kunit *test,
+					struct iov_iter *iter, int dir,
+					struct iovec *iov, unsigned int iovmax,
+					u8 __user *buffer, size_t bufsize,
+					const struct iov_kunit_range *pr)
+{
+	size_t size = 0;
+	int i;
+
+	for (i = 0; i < iovmax; i++, pr++) {
+		if (pr->page < 0)
+			break;
+		KUNIT_ASSERT_GE(test, pr->to, pr->from);
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+		iov[i].iov_base = buffer + pr->from;
+		iov[i].iov_len = pr->to - pr->from;
+		size += pr->to - pr->from;
+	}
+	KUNIT_ASSERT_LE(test, size, bufsize);
+
+	iov_iter_init(iter, dir, iov, i, size);
+}
+
+/*
+ * Test copying to an ITER_IOVEC-type iterator.
+ */
+static void __init iov_kunit_copy_to_iovec(struct kunit *test)
+{
+	struct iov_iter iter;
+	struct page **spages;
+	struct iovec iov[8];
+	u8 __user *buffer;
+	u8 *scratch;
+	ssize_t uncleared;
+	size_t bufsize, npages, size, copied;
+	int i;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	for (i = 0; i < bufsize; i++)
+		scratch[i] = pattern(i);
+
+	buffer = iov_kunit_create_user_buf(test, npages, NULL);
+	uncleared = clear_user(buffer, bufsize);
+	KUNIT_EXPECT_EQ(test, uncleared, 0);
+	if (uncleared)
+		return;
+
+	iov_kunit_load_iovec(test, &iter, ITER_DEST, iov, ARRAY_SIZE(iov),
+			     buffer, bufsize, kvec_test_ranges);
+	size = iter.count;
+
+	copied = copy_to_iter(scratch, size, &iter);
+
+	KUNIT_EXPECT_EQ(test, copied, size);
+	KUNIT_EXPECT_EQ(test, iter.count, 0);
+	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
+
+	iov_kunit_build_to_reference_pattern(test, scratch, bufsize, kvec_test_ranges);
+	iov_kunit_check_user_pattern(test, buffer, scratch, bufsize);
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Test copying from an ITER_IOVEC-type iterator.
+ */
+static void __init iov_kunit_copy_from_iovec(struct kunit *test)
+{
+	struct iov_iter iter;
+	struct page **spages;
+	struct iovec iov[8];
+	u8 __user *buffer;
+	u8 *scratch, *reference;
+	size_t bufsize, npages, size, copied;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	buffer = iov_kunit_create_user_buf(test, npages, NULL);
+	iov_kunit_fill_user_buf(test, buffer, bufsize);
+
+	scratch = iov_kunit_create_buffer(test, &spages, npages);
+	memset(scratch, 0, bufsize);
+
+	reference = iov_kunit_create_buffer(test, &spages, npages);
+
+	iov_kunit_load_iovec(test, &iter, ITER_SOURCE, iov, ARRAY_SIZE(iov),
+			     buffer, bufsize, kvec_test_ranges);
+	size = iter.count;
+
+	copied = copy_from_iter(scratch, size, &iter);
+
+	KUNIT_EXPECT_EQ(test, copied, size);
+	KUNIT_EXPECT_EQ(test, iter.count, 0);
+	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
+
+	iov_kunit_build_from_reference_pattern(test, reference, bufsize, kvec_test_ranges);
+	iov_kunit_check_pattern(test, reference, scratch, bufsize);
+	KUNIT_SUCCEED();
+}
+
 static void __init iov_kunit_load_kvec(struct kunit *test,
 				       struct iov_iter *iter, int dir,
 				       struct kvec *kvec, unsigned int kvmax,
@@ -884,6 +1080,10 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 }
 
 static struct kunit_case __refdata iov_kunit_cases[] = {
+	KUNIT_CASE(iov_kunit_copy_to_ubuf),
+	KUNIT_CASE(iov_kunit_copy_from_ubuf),
+	KUNIT_CASE(iov_kunit_copy_to_iovec),
+	KUNIT_CASE(iov_kunit_copy_from_iovec),
 	KUNIT_CASE(iov_kunit_copy_to_kvec),
 	KUNIT_CASE(iov_kunit_copy_from_kvec),
 	KUNIT_CASE(iov_kunit_copy_to_bvec),


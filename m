Return-Path: <linux-fsdevel+bounces-2905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5859D7EC7C7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 16:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9C641F27C2A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 15:51:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF043BB53;
	Wed, 15 Nov 2023 15:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RkwY84pZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 330BB31755
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 15:50:26 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78FE91999
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700063420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwCPpplnarkjsvZJB79Uk8vm91RohI86seZogpCcfg4=;
	b=RkwY84pZ8vWkBtXovNfLWZuyGtI3yxkjJSFB1lTuNp+qYxZRxpJGtV14DyFTFCB67L80yT
	kK1c0EQe6aR80cDqe95ca9RqMLp24FACFl0DIA744LnAg9dpLZlA2hX9vhQoF+BwkUVch2
	2w3k6peaVC/kF83zp/pFSL0nXo2ioAo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-166-paADNiDcMD-8KlevGlnejA-1; Wed, 15 Nov 2023 10:50:15 -0500
X-MC-Unique: paADNiDcMD-8KlevGlnejA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CC4F811E92;
	Wed, 15 Nov 2023 15:50:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9D07F2166B27;
	Wed, 15 Nov 2023 15:50:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Christoph Hellwig <hch@lst.de>,
	David Laight <David.Laight@ACULAB.COM>,
	Matthew Wilcox <willy@infradead.org>,
	Brendan Higgins <brendanhiggins@google.com>,
	David Gow <davidgow@google.com>,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	John Hubbard <jhubbard@nvidia.com>
Subject: [PATCH v3 06/10] iov_iter: Add copy kunit tests for ITER_UBUF and ITER_IOVEC
Date: Wed, 15 Nov 2023 15:49:42 +0000
Message-ID: <20231115154946.3933808-7-dhowells@redhat.com>
In-Reply-To: <20231115154946.3933808-1-dhowells@redhat.com>
References: <20231115154946.3933808-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

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
 lib/kunit_iov_iter.c | 236 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 236 insertions(+)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 63e4dd1e7c1b..34f0d82674ee 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -117,6 +117,23 @@ static void *__init iov_kunit_create_buffer(struct kunit *test,
 	return buffer;
 }
 
+/*
+ * Fill a user buffer with a recognisable pattern.
+ */
+static void iov_kunit_fill_user_buf(struct kunit *test,
+				    u8 __user *buffer, size_t bufsize)
+{
+	size_t i;
+	int err;
+
+	for (i = 0; i < bufsize; i++) {
+		err = put_user(pattern(i), &buffer[i]);
+		KUNIT_EXPECT_EQ(test, err, 0);
+		if (test->status == KUNIT_FAILURE)
+			return;
+	}
+}
+
 /*
  * Build the reference pattern in the scratch buffer that we expect to see in
  * the iterator buffer (ie. the result of copy *to*).
@@ -172,6 +189,25 @@ static void iov_kunit_check_pattern(struct kunit *test, const u8 *buffer,
 	}
 }
 
+/*
+ * Compare a user and a scratch buffer to see that they're the same.
+ */
+static void iov_kunit_check_user_pattern(struct kunit *test, const u8 __user *buffer,
+					 const u8 *scratch, size_t bufsize)
+{
+	size_t i;
+	int err;
+	u8 c;
+
+	for (i = 0; i < bufsize; i++) {
+		err = get_user(c, &buffer[i]);
+		KUNIT_EXPECT_EQ(test, err, 0);
+		KUNIT_EXPECT_EQ_MSG(test, c, scratch[i], "at i=%x", i);
+		if (c != scratch[i])
+			return;
+	}
+}
+
 static const struct file_operations iov_kunit_user_file_fops = {
 	.mmap = generic_file_mmap,
 };
@@ -294,6 +330,202 @@ static u8 __user *__init iov_kunit_create_user_buf(struct kunit *test,
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
@@ -869,6 +1101,10 @@ static void __init iov_kunit_extract_pages_xarray(struct kunit *test)
 }
 
 static struct kunit_case __refdata iov_kunit_cases[] = {
+	KUNIT_CASE(iov_kunit_copy_to_ubuf),
+	KUNIT_CASE(iov_kunit_copy_from_ubuf),
+	KUNIT_CASE(iov_kunit_copy_to_iovec),
+	KUNIT_CASE(iov_kunit_copy_from_iovec),
 	KUNIT_CASE(iov_kunit_copy_to_kvec),
 	KUNIT_CASE(iov_kunit_copy_from_kvec),
 	KUNIT_CASE(iov_kunit_copy_to_bvec),



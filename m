Return-Path: <linux-fsdevel+bounces-2907-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 675D17EC7D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 16:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6211C20B92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 15:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27317433A6;
	Wed, 15 Nov 2023 15:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AK+gtyqp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFAC31755
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 15:50:35 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB451BD2
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700063425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zNOJj+YS6mMGjsLK5S7tjKltIfgKSXCOHuT8F0vbcKQ=;
	b=AK+gtyqp/CM+y44wSJQOBdEXebFWvF3cHOmLgElYS2O5hASfCjqfACnDxc0b4D3fpXXNjf
	rHIJhbA++Ii7v4f0vfTyTzz/AlkcCLdqK35NQl5uZrDe3qNsPF5VrnsG76PSaDk6BLW+8Z
	h2zGEYNNj9plYsU6SkWOniOsIsWCZ6Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-aUOqZDu2NJavfuyT2sjYzQ-1; Wed,
 15 Nov 2023 10:50:19 -0500
X-MC-Unique: aUOqZDu2NJavfuyT2sjYzQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB4C33C000B4;
	Wed, 15 Nov 2023 15:50:17 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 040352166B27;
	Wed, 15 Nov 2023 15:50:14 +0000 (UTC)
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
Subject: [PATCH v3 07/10] iov_iter: Add extract kunit tests for ITER_UBUF and ITER_IOVEC
Date: Wed, 15 Nov 2023 15:49:43 +0000
Message-ID: <20231115154946.3933808-8-dhowells@redhat.com>
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

Add extraction kunit tests for ITER_UBUF- and ITER_IOVEC-type iterators.
This attaches a userspace VM with a mapped file in it temporarily to the
test thread.

[!] Note that this requires the kernel thread running the test to obtain
and deploy an mm_struct so that a user-side buffer can be created with mmap
- basically it has to emulated part of execve().  Doing so requires access
to additional core symbols: mm_alloc(), vm_area_alloc(), insert_vm_struct()
and arch_pick_mmap_layout().  See the iov_kunit_create_user_buf() function
added in the patch.

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
 lib/kunit_iov_iter.c | 164 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 34f0d82674ee..fdf598e49c0b 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -863,6 +863,168 @@ static void __init iov_kunit_copy_from_xarray(struct kunit *test)
 	KUNIT_SUCCEED();
 }
 
+/*
+ * Test the extraction of ITER_UBUF-type iterators.
+ */
+static void __init iov_kunit_extract_pages_ubuf(struct kunit *test)
+{
+	const struct iov_kunit_range *pr;
+	struct iov_iter iter;
+	struct page **bpages, *pagelist[8], **pages = pagelist;
+	ssize_t len;
+	size_t bufsize, size = 0, npages;
+	int i, from;
+	u8 __user *buffer;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	buffer = iov_kunit_create_user_buf(test, npages, &bpages);
+
+	for (pr = kvec_test_ranges; pr->page >= 0; pr++) {
+		from = pr->from;
+		size = pr->to - from;
+		KUNIT_ASSERT_LE(test, pr->to, bufsize);
+
+		iov_iter_ubuf(&iter, ITER_SOURCE, buffer + pr->from, size);
+
+		do {
+			size_t offset0 = LONG_MAX;
+
+			for (i = 0; i < ARRAY_SIZE(pagelist); i++)
+				pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;
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
+			/* We're only checking the page pointers */
+			unpin_user_pages(pages, (offset0 + len) / PAGE_SIZE);
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
+/*
+ * Test the extraction of ITER_IOVEC-type iterators.
+ */
+static void __init iov_kunit_extract_pages_iovec(struct kunit *test)
+{
+	const struct iov_kunit_range *pr;
+	struct iov_iter iter;
+	struct iovec iov[8];
+	struct page **bpages, *pagelist[8], **pages = pagelist;
+	ssize_t len;
+	size_t bufsize, size = 0, npages;
+	int i, from;
+	u8 __user *buffer;
+
+	bufsize = 0x100000;
+	npages = bufsize / PAGE_SIZE;
+
+	buffer = iov_kunit_create_user_buf(test, npages, &bpages);
+
+	iov_kunit_load_iovec(test, &iter, ITER_SOURCE, iov, ARRAY_SIZE(iov),
+			     buffer, bufsize, kvec_test_ranges);
+	size = iter.count;
+
+	pr = kvec_test_ranges;
+	from = pr->from;
+	do {
+		size_t offset0 = LONG_MAX;
+
+		for (i = 0; i < ARRAY_SIZE(pagelist); i++)
+			pagelist[i] = (void *)POISON_POINTER_DELTA + 0x5a;
+
+		len = iov_iter_extract_pages(&iter, &pages, 100 * 1024,
+					     ARRAY_SIZE(pagelist), 0, &offset0);
+		KUNIT_EXPECT_GE(test, len, 0);
+		if (len < 0)
+			break;
+		KUNIT_EXPECT_LE(test, len, size);
+		KUNIT_EXPECT_EQ(test, iter.count, size - len);
+		if (len == 0)
+			break;
+		size -= len;
+		KUNIT_EXPECT_GE(test, (ssize_t)offset0, 0);
+		KUNIT_EXPECT_LT(test, offset0, PAGE_SIZE);
+
+		/* We're only checking the page pointers */
+		unpin_user_pages(pages, (offset0 + len) / PAGE_SIZE);
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
+				if (pr->page < 0)
+					goto stop;
+			}
+
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
 /*
  * Test the extraction of ITER_KVEC-type iterators.
  */
@@ -1111,6 +1273,8 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_copy_from_bvec),
 	KUNIT_CASE(iov_kunit_copy_to_xarray),
 	KUNIT_CASE(iov_kunit_copy_from_xarray),
+	KUNIT_CASE(iov_kunit_extract_pages_ubuf),
+	KUNIT_CASE(iov_kunit_extract_pages_iovec),
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),



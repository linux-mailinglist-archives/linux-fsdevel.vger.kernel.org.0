Return-Path: <linux-fsdevel+bounces-2909-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 562057EC7DF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 16:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C90801F27CF0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 15:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0679041234;
	Wed, 15 Nov 2023 15:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fJ38K8KK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2597433DE
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 15:50:50 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35A31FD5
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700063440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YZNprSzbt9e8k58JcxEUqpXJf2zPy5yDQe5/rD+YGMw=;
	b=fJ38K8KKdUYk6WiiUPwBw2rPn0NfUqcDkpgvtBaYtw/UOtRGWgJN+LrdLczFFmHATGvClH
	eiTvprWt6NUNkS4cihi9GHlZQMK7IDGNMAaU98H2OLWGd73fzmRUK5L0UcwtbjhiQ02oYv
	P2KpvzDzgjJRYfWaf21zFB5il4MA95A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-_sSUMIArNcOe3p2xkegZtQ-1; Wed,
 15 Nov 2023 10:50:33 -0500
X-MC-Unique: _sSUMIArNcOe3p2xkegZtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E6A23C000BB;
	Wed, 15 Nov 2023 15:50:32 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 043102166B27;
	Wed, 15 Nov 2023 15:50:27 +0000 (UTC)
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
Subject: [PATCH v3 10/10] iov_iter: Add benchmarking kunit tests for UBUF/IOVEC
Date: Wed, 15 Nov 2023 15:49:46 +0000
Message-ID: <20231115154946.3933808-11-dhowells@redhat.com>
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

Add kunit tests to benchmark 256MiB copies to a UBUF iterator and an IOVEC
iterator.  This attaches a userspace VM with a mapped file in it
temporarily to the test thread.

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
cc: linux-kselftest@vger.kernel.org
cc: kunit-dev@googlegroups.com
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
---
 lib/kunit_iov_iter.c | 95 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index 2fbe6f2afb26..d5b7517f4f47 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -1325,6 +1325,99 @@ static void *__init iov_kunit_create_source(struct kunit *test, size_t npages)
 	return scratch;
 }
 
+/*
+ * Time copying 256MiB through an ITER_UBUF.
+ */
+static void __init iov_kunit_benchmark_ubuf(struct kunit *test)
+{
+	struct iov_iter iter;
+	unsigned int samples[IOV_KUNIT_NR_SAMPLES];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size = 256 * 1024 * 1024, npages = size / PAGE_SIZE;
+	void *scratch;
+	int i;
+	u8 __user *buffer;
+
+	/* Allocate a huge buffer and populate it with pages. */
+	buffer = iov_kunit_create_user_buf(test, npages, NULL);
+
+	/* Create a single large buffer to copy to/from. */
+	scratch = iov_kunit_create_source(test, npages);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over UBUF:\n");
+	for (i = 0; i < IOV_KUNIT_NR_SAMPLES; i++) {
+		size_t remain = size;
+
+		a = ktime_get_real();
+		do {
+			size_t part = min(remain, PAGE_SIZE);
+
+			iov_iter_ubuf(&iter, ITER_SOURCE, buffer, part);
+			copied = copy_from_iter(scratch, part, &iter);
+			KUNIT_EXPECT_EQ(test, copied, part);
+			remain -= part;
+		} while (remain > 0);
+		b = ktime_get_real();
+		samples[i] = ktime_to_us(ktime_sub(b, a));
+	}
+
+	iov_kunit_benchmark_print_stats(test, samples);
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Time copying 256MiB through an ITER_IOVEC.
+ */
+static void __init iov_kunit_benchmark_iovec(struct kunit *test)
+{
+	struct iov_iter iter;
+	struct iovec *iov;
+	unsigned int samples[IOV_KUNIT_NR_SAMPLES];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size = 256 * 1024 * 1024, npages = size / PAGE_SIZE, part;
+	size_t ioc = size / PAGE_SIZE;
+	void *scratch;
+	int i;
+	u8 __user *buffer;
+
+	iov = kunit_kmalloc_array(test, ioc, sizeof(*iov), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, iov);
+
+	/* Allocate a huge buffer and populate it with pages. */
+	buffer = iov_kunit_create_user_buf(test, npages, NULL);
+
+	/* Create a single large buffer to copy to/from. */
+	scratch = iov_kunit_create_source(test, npages);
+
+	/* Split the target over a number of iovecs */
+	copied = 0;
+	for (i = 0; i < ioc; i++) {
+		part = size / ioc;
+		iov[i].iov_base = buffer + copied;
+		iov[i].iov_len = part;
+		copied += part;
+	}
+	iov[i - 1].iov_len += size - part;
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over IOVEC:\n");
+	for (i = 0; i < IOV_KUNIT_NR_SAMPLES; i++) {
+		iov_iter_init(&iter, ITER_SOURCE, iov, npages, size);
+
+		a = ktime_get_real();
+		copied = copy_from_iter(scratch, size, &iter);
+		b = ktime_get_real();
+		KUNIT_EXPECT_EQ(test, copied, size);
+		samples[i] = ktime_to_us(ktime_sub(b, a));
+	}
+
+	iov_kunit_benchmark_print_stats(test, samples);
+	KUNIT_SUCCEED();
+}
+
 /*
  * Time copying 256MiB through an ITER_KVEC.
  */
@@ -1611,6 +1704,8 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
+	KUNIT_CASE(iov_kunit_benchmark_ubuf),
+	KUNIT_CASE(iov_kunit_benchmark_iovec),
 	KUNIT_CASE(iov_kunit_benchmark_kvec),
 	KUNIT_CASE(iov_kunit_benchmark_bvec),
 	KUNIT_CASE(iov_kunit_benchmark_bvec_split),



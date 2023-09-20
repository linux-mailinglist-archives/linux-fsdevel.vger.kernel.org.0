Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F8C97A82D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 15:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236524AbjITNGf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 09:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236522AbjITNGM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:06:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F509E
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695215121;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WKL59oxitSx6DOUyNJ+1H0DeRSBlY0vVZI1oz1R1zFg=;
        b=D145kSTw3sldAEnPmqVZgf/m1dURXMWuuJxha2BBAY0C/sCTdMQuqmqROz/DlXcI6qY6ZY
        UYV9Q1CA91rU8G1zNybYECMcMpOZ4pMgTa3jY1qwQnZQoaaJ4IXQ62CQjPxG8C4eh9KMqM
        SSatHN9co34dTMDefZkzId80wbBv9lM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-653-5VCNNxRlNwuawrr7coWaQA-1; Wed, 20 Sep 2023 09:05:18 -0400
X-MC-Unique: 5VCNNxRlNwuawrr7coWaQA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D5BEF2999B36;
        Wed, 20 Sep 2023 13:05:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 698FE51E3;
        Wed, 20 Sep 2023 13:05:14 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: [RFC PATCH v2 9/9] iov_iter: Add benchmarking kunit tests for UBUF/IOVEC
Date:   Wed, 20 Sep 2023 14:04:00 +0100
Message-ID: <20230920130400.203330-10-dhowells@redhat.com>
In-Reply-To: <20230920130400.203330-1-dhowells@redhat.com>
References: <20230920130400.203330-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

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
index 17f85f24b239..4ee939a1c5ec 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -1324,6 +1324,99 @@ static void *__init iov_kunit_create_source(struct kunit *test, size_t npages)
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
@@ -1524,6 +1617,8 @@ static struct kunit_case __refdata iov_kunit_cases[] = {
 	KUNIT_CASE(iov_kunit_extract_pages_kvec),
 	KUNIT_CASE(iov_kunit_extract_pages_bvec),
 	KUNIT_CASE(iov_kunit_extract_pages_xarray),
+	KUNIT_CASE(iov_kunit_benchmark_ubuf),
+	KUNIT_CASE(iov_kunit_benchmark_iovec),
 	KUNIT_CASE(iov_kunit_benchmark_kvec),
 	KUNIT_CASE(iov_kunit_benchmark_bvec),
 	KUNIT_CASE(iov_kunit_benchmark_bvec_split),


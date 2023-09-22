Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383E87AB0F2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Sep 2023 13:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233761AbjIVLc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Sep 2023 07:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233745AbjIVLcU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Sep 2023 07:32:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA48CCA
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Sep 2023 04:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695382280;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YZNprSzbt9e8k58JcxEUqpXJf2zPy5yDQe5/rD+YGMw=;
        b=TFxSkctqToVg/Nfm+QeiLMYjPf08sP9mOd5a5Zyhhfa/OtemUTjaJKubrzTqJnGSya8UP9
        qlww4ygd5K4hQCAL3Cgqg7ADjqVHjhj9dS37r7RMZeUwCS+MrpKlDieNQwenlXZKbsjuWT
        qmwqgwu+rAnFYN8I7yTJvXUhZEDzA2Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-44-75ozITHwPxqfRUZSOFIvLw-1; Fri, 22 Sep 2023 07:31:16 -0400
X-MC-Unique: 75ozITHwPxqfRUZSOFIvLw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6EA2B101A529;
        Fri, 22 Sep 2023 11:31:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0CD1420268D6;
        Fri, 22 Sep 2023 11:31:12 +0000 (UTC)
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
Subject: [PATCH v3 10/10] iov_iter: Add benchmarking kunit tests for UBUF/IOVEC
Date:   Fri, 22 Sep 2023 12:30:38 +0100
Message-ID: <20230922113038.1135236-11-dhowells@redhat.com>
In-Reply-To: <20230922113038.1135236-1-dhowells@redhat.com>
References: <20230922113038.1135236-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
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


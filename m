Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B947A1AD0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 11:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233726AbjIOJjg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 05:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233595AbjIOJjg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 05:39:36 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7BFD02D5A
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 02:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694770703;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1kkiG5L/a/xceIw2PPIGBdgyPVq7y6221yleAsPibq4=;
        b=Tgoz1LZTR+XC2x5+a1Jw4s1JiMtLpotBsyrziv4eIgxA9lPIAsUQ2PG/PXdBbr9K2Kh1KY
        FfhQS5BhpDLMsMxLrokWCl7DFWnOzRnjuFaXKDwO9tInaT3cUgNIQTxkMso8pqATDGiyGV
        Scyf5fAqoR65aIDcbkMy7skKzDUBtXg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-260-Zfaqv3swO7urejhYiLIkNA-1; Fri, 15 Sep 2023 05:38:17 -0400
X-MC-Unique: Zfaqv3swO7urejhYiLIkNA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0647681DA99;
        Fri, 15 Sep 2023 09:38:17 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D167428FD;
        Fri, 15 Sep 2023 09:38:14 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <445a78b0ff3047fea20d3c8058a5ff6a@AcuMS.aculab.com>
References: <445a78b0ff3047fea20d3c8058a5ff6a@AcuMS.aculab.com> <20230913165648.2570623-1-dhowells@redhat.com> <20230913165648.2570623-6-dhowells@redhat.com>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Christian Brauner" <christian@brauner.io>,
        Matthew Wilcox <willy@infradead.org>,
        "Jeff Layton" <jlayton@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 05/13] iov: Move iterator functions to a header file
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3369773.1694770694.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 15 Sep 2023 10:38:14 +0100
Message-ID: <3369774.1694770694@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> > Move the iterator functions to a header file so that other operations =
that
> > need to scan over an iterator can be added.  For instance, the rbd dri=
ver
> > could use this to scan a buffer to see if it is all zeros and libceph =
could
> > use this to generate a crc.
> =

> These all look a bit big for being more generally inlined.
> =

> I know you want to avoid the indirect call in the normal cases,
> but maybe it would be ok for other uses?

So you'd advocate for something like:

	size_t generic_iterate(struct iov_iter *iter, size_t len, void *priv,
			       void *priv2, iov_ustep_f ustep, iov_step_f step)
	{
		return iterate_and_advance2(iter, len, priv, priv2,
					    ustep, step);
	}
	EXPORT_SYMBOL(generic_iterate);

in lib/iov_iter.c and then call that from the places that want to use it?

I tried benchmarking that (see attached patch - it needs to go on top of m=
y
iov patches).  Running the insmod thrice and then filtering out and sortin=
g
the results:

	iov_kunit_benchmark_bvec: avg 3174 uS, stddev 68 uS
	iov_kunit_benchmark_bvec: avg 3176 uS, stddev 61 uS
	iov_kunit_benchmark_bvec: avg 3180 uS, stddev 64 uS
	iov_kunit_benchmark_bvec_outofline: avg 3678 uS, stddev 4 uS
	iov_kunit_benchmark_bvec_outofline: avg 3678 uS, stddev 5 uS
	iov_kunit_benchmark_bvec_outofline: avg 3679 uS, stddev 6 uS
	iov_kunit_benchmark_xarray: avg 3560 uS, stddev 5 uS
	iov_kunit_benchmark_xarray: avg 3560 uS, stddev 6 uS
	iov_kunit_benchmark_xarray: avg 3570 uS, stddev 16 uS
	iov_kunit_benchmark_xarray_outofline: avg 4125 uS, stddev 13 uS
	iov_kunit_benchmark_xarray_outofline: avg 4125 uS, stddev 2 uS
	iov_kunit_benchmark_xarray_outofline: avg 4125 uS, stddev 6 uS

It adds almost 16% overhead:

	(gdb) p 4125/3560.0
	$2 =3D 1.1587078651685394
	(gdb) p 3678/3174.0
	$3 =3D 1.1587901701323251

I'm guessing a lot of that is due to function pointer mitigations.

Now, part of the code size expansion can be mitigated by using, say,
iterate_and_advance_kernel() if you know you aren't going to encounter
user-backed iterators, or even using, say, iterate_bvec() if you know you'=
re
only going to see a specific iterator type.

David
---
iov_iter: Benchmark out of line generic iterator

diff --git a/include/linux/iov_iter.h b/include/linux/iov_iter.h
index 2ebb86c041b6..8f562e80473b 100644
--- a/include/linux/iov_iter.h
+++ b/include/linux/iov_iter.h
@@ -293,4 +293,7 @@ size_t iterate_and_advance_kernel(struct iov_iter *ite=
r, size_t len, void *priv,
 	return progress;
 }
 =

+size_t generic_iterate(struct iov_iter *iter, size_t len, void *priv, voi=
d *priv2,
+		       iov_ustep_f ustep, iov_step_f step);
+
 #endif /* _LINUX_IOV_ITER_H */
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 8f7a10c4a295..f9643dd02676 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -1684,3 +1684,10 @@ ssize_t iov_iter_extract_pages(struct iov_iter *i,
 	return -EFAULT;
 }
 EXPORT_SYMBOL_GPL(iov_iter_extract_pages);
+
+size_t generic_iterate(struct iov_iter *iter, size_t len, void *priv, voi=
d *priv2,
+		       iov_ustep_f ustep, iov_step_f step)
+{
+	return iterate_and_advance2(iter, len, priv, priv2, ustep, step);
+}
+EXPORT_SYMBOL(generic_iterate);
diff --git a/lib/kunit_iov_iter.c b/lib/kunit_iov_iter.c
index cc9c64663a73..f208516a68c9 100644
--- a/lib/kunit_iov_iter.c
+++ b/lib/kunit_iov_iter.c
@@ -18,6 +18,7 @@
 #include <linux/writeback.h>
 #include <linux/uio.h>
 #include <linux/bvec.h>
+#include <linux/iov_iter.h>
 #include <kunit/test.h>
 =

 MODULE_DESCRIPTION("iov_iter testing");
@@ -1571,6 +1572,124 @@ static void __init iov_kunit_benchmark_xarray(stru=
ct kunit *test)
 	KUNIT_SUCCEED();
 }
 =

+static noinline
+size_t shovel_to_user_iter(void __user *iter_to, size_t progress,
+			   size_t len, void *from, void *priv2)
+{
+	if (should_fail_usercopy())
+		return len;
+	if (access_ok(iter_to, len)) {
+		from +=3D progress;
+		instrument_copy_to_user(iter_to, from, len);
+		len =3D raw_copy_to_user(iter_to, from, len);
+	}
+	return len;
+}
+
+static noinline
+size_t shovel_to_kernel_iter(void *iter_to, size_t progress,
+			     size_t len, void *from, void *priv2)
+{
+	memcpy(iter_to, from + progress, len);
+	return 0;
+}
+
+/*
+ * Time copying 256MiB through an ITER_BVEC with an out-of-line copier
+ * function.
+ */
+static void __init iov_kunit_benchmark_bvec_outofline(struct kunit *test)
+{
+	struct iov_iter iter;
+	struct bio_vec *bvec;
+	struct page *page;
+	unsigned int samples[IOV_KUNIT_NR_SAMPLES];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size =3D 256 * 1024 * 1024, npages =3D size / PAGE_SIZE;
+	void *scratch;
+	int i;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page =3D alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	kunit_add_action_or_reset(test, iov_kunit_free_page, page);
+
+	bvec =3D kunit_kmalloc_array(test, npages, sizeof(bvec[0]), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, bvec);
+	for (i =3D 0; i < npages; i++)
+		bvec_set_page(&bvec[i], page, PAGE_SIZE, 0);
+
+	/* Create a single large buffer to copy to/from. */
+	scratch =3D iov_kunit_create_source(test, npages);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over BVEC:\n");
+	for (i =3D 0; i < IOV_KUNIT_NR_SAMPLES; i++) {
+		iov_iter_bvec(&iter, ITER_DEST, bvec, npages, size);
+		a =3D ktime_get_real();
+		copied =3D generic_iterate(&iter, size, scratch, NULL,
+					 shovel_to_user_iter,
+					 shovel_to_kernel_iter);
+		b =3D ktime_get_real();
+		KUNIT_EXPECT_EQ(test, copied, size);
+		samples[i] =3D ktime_to_us(ktime_sub(b, a));
+	}
+
+	iov_kunit_benchmark_print_stats(test, samples);
+	KUNIT_SUCCEED();
+}
+
+/*
+ * Time copying 256MiB through an ITER_XARRAY with an out-of-line copier
+ * function.
+ */
+static void __init iov_kunit_benchmark_xarray_outofline(struct kunit *tes=
t)
+{
+	struct iov_iter iter;
+	struct xarray *xarray;
+	struct page *page;
+	unsigned int samples[IOV_KUNIT_NR_SAMPLES];
+	ktime_t a, b;
+	ssize_t copied;
+	size_t size =3D 256 * 1024 * 1024, npages =3D size / PAGE_SIZE;
+	void *scratch;
+	int i;
+
+	/* Allocate a page and tile it repeatedly in the buffer. */
+	page =3D alloc_page(GFP_KERNEL);
+	KUNIT_ASSERT_NOT_NULL(test, page);
+	kunit_add_action_or_reset(test, iov_kunit_free_page, page);
+
+	xarray =3D iov_kunit_create_xarray(test);
+
+	for (i =3D 0; i < npages; i++) {
+		void *x =3D xa_store(xarray, i, page, GFP_KERNEL);
+
+		KUNIT_ASSERT_FALSE(test, xa_is_err(x));
+	}
+
+	/* Create a single large buffer to copy to/from. */
+	scratch =3D iov_kunit_create_source(test, npages);
+
+	/* Perform and time a bunch of copies. */
+	kunit_info(test, "Benchmarking copy_to_iter() over XARRAY:\n");
+	for (i =3D 0; i < IOV_KUNIT_NR_SAMPLES; i++) {
+		iov_iter_xarray(&iter, ITER_DEST, xarray, 0, size);
+		a =3D ktime_get_real();
+
+		copied =3D generic_iterate(&iter, size, scratch, NULL,
+					 shovel_to_user_iter,
+					 shovel_to_kernel_iter);
+		b =3D ktime_get_real();
+		KUNIT_EXPECT_EQ(test, copied, size);
+		samples[i] =3D ktime_to_us(ktime_sub(b, a));
+	}
+
+	iov_kunit_benchmark_print_stats(test, samples);
+	KUNIT_SUCCEED();
+}
+
 static struct kunit_case __refdata iov_kunit_cases[] =3D {
 	KUNIT_CASE(iov_kunit_copy_to_ubuf),
 	KUNIT_CASE(iov_kunit_copy_from_ubuf),
@@ -1593,6 +1712,8 @@ static struct kunit_case __refdata iov_kunit_cases[]=
 =3D {
 	KUNIT_CASE(iov_kunit_benchmark_bvec),
 	KUNIT_CASE(iov_kunit_benchmark_bvec_split),
 	KUNIT_CASE(iov_kunit_benchmark_xarray),
+	KUNIT_CASE(iov_kunit_benchmark_bvec_outofline),
+	KUNIT_CASE(iov_kunit_benchmark_xarray_outofline),
 	{}
 };
 =


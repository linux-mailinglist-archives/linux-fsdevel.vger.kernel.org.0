Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC457997AC
	for <lists+linux-fsdevel@lfdr.de>; Sat,  9 Sep 2023 13:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344607AbjIILaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 9 Sep 2023 07:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233881AbjIILaM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 9 Sep 2023 07:30:12 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2BD1E46;
        Sat,  9 Sep 2023 04:30:07 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 054DC68B05; Sat,  9 Sep 2023 13:30:01 +0200 (CEST)
Date:   Sat, 9 Sep 2023 13:30:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     David Howells <dhowells@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <brauner@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jeff Layton <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iov_iter: Kunit tests for copying to/from an
 iterator
Message-ID: <20230909113000.GB12045@lst.de>
References: <20230908160322.1714302-1-dhowells@redhat.com> <20230908160322.1714302-3-dhowells@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908160322.1714302-3-dhowells@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> +/* I/O iterator tests.  This can only test kernel-backed iterator types.

kernel comments start with a:

/*

and nothing else on the line.  (for brevity I'm not going to repeat
the comment for the rest of this series)

> +static const struct kvec_test_range kvec_test_ranges[] = {
> +	{ 0x00002, 0x00002 },
> +	{ 0x00027, 0x03000 },
> +	{ 0x05193, 0x18794 },
> +	{ 0x20000, 0x20000 },
> +	{ 0x20000, 0x24000 },
> +	{ 0x24000, 0x27001 },
> +	{ 0x29000, 0xffffb },
> +	{ 0xffffd, 0xffffe },

How were these values picked?  Should there be a comment explaining them?

> +	buffer = vmap(pages, npages, VM_MAP | VM_MAP_PUT_PAGES, PAGE_KERNEL);
> +        KUNIT_ASSERT_NOT_ERR_OR_NULL(test, buffer);

The KUNIT_ASSERT_NOT_ERR_OR_NULL seems misindented.

> + */
> +static void __init iov_kunit_copy_to_bvec(struct kunit *test)
> +{
> +	const struct bvec_test_range *pr;
> +	struct iov_iter iter;
> +	struct bio_vec bvec[8];
> +	struct page **spages, **bpages;
> +	u8 *scratch, *buffer;
> +	size_t bufsize, npages, size, copied;
> +	int i, b, patt;
> +
> +	bufsize = 0x100000;
> +	npages = bufsize / PAGE_SIZE;
> +
> +	scratch = iov_kunit_create_buffer(test, &spages, npages);
> +	for (i = 0; i < bufsize; i++)
> +		scratch[i] = pattern(i);
> +
> +	buffer = iov_kunit_create_buffer(test, &bpages, npages);
> +	memset(buffer, 0, bufsize);
> +
> +	iov_kunit_load_bvec(test, &iter, READ, bvec, ARRAY_SIZE(bvec),
> +			    bpages, npages, bufsize, bvec_test_ranges);
> +	size = iter.count;
> +
> +	copied = copy_to_iter(scratch, size, &iter);
> +
> +	KUNIT_EXPECT_EQ(test, copied, size);
> +	KUNIT_EXPECT_EQ(test, iter.count, 0);
> +	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
> +
> +	/* Build the expected image in the scratch buffer. */
> +	b = 0;
> +	patt = 0;
> +	memset(scratch, 0, bufsize);
> +	for (pr = bvec_test_ranges; pr->from >= 0; pr++, b++) {
> +		u8 *p = scratch + pr->page * PAGE_SIZE;
> +
> +		for (i = pr->from; i < pr->to; i++)
> +			p[i] = pattern(patt++);
> +	}
> +
> +	/* Compare the images */
> +	for (i = 0; i < bufsize; i++) {
> +		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
> +		if (buffer[i] != scratch[i])
> +			return;
> +	}
> +
> +	KUNIT_SUCCEED();
> +}
> +
> +/*
> + * Test copying from a ITER_BVEC-type iterator.
> + */
> +static void __init iov_kunit_copy_from_bvec(struct kunit *test)
> +{
> +	const struct bvec_test_range *pr;
> +	struct iov_iter iter;
> +	struct bio_vec bvec[8];
> +	struct page **spages, **bpages;
> +	u8 *scratch, *buffer;
> +	size_t bufsize, npages, size, copied;
> +	int i, j;
> +
> +	bufsize = 0x100000;
> +	npages = bufsize / PAGE_SIZE;
> +
> +	buffer = iov_kunit_create_buffer(test, &bpages, npages);
> +	for (i = 0; i < bufsize; i++)
> +		buffer[i] = pattern(i);
> +
> +	scratch = iov_kunit_create_buffer(test, &spages, npages);
> +	memset(scratch, 0, bufsize);
> +
> +	iov_kunit_load_bvec(test, &iter, WRITE, bvec, ARRAY_SIZE(bvec),
> +			    bpages, npages, bufsize, bvec_test_ranges);
> +	size = iter.count;
> +
> +	copied = copy_from_iter(scratch, size, &iter);
> +
> +	KUNIT_EXPECT_EQ(test, copied, size);
> +	KUNIT_EXPECT_EQ(test, iter.count, 0);
> +	KUNIT_EXPECT_EQ(test, iter.nr_segs, 0);
> +
> +	/* Build the expected image in the main buffer. */
> +	i = 0;
> +	memset(buffer, 0, bufsize);
> +	for (pr = bvec_test_ranges; pr->from >= 0; pr++) {
> +		size_t patt = pr->page * PAGE_SIZE;
> +
> +		for (j = pr->from; j < pr->to; j++) {
> +			buffer[i++] = pattern(patt + j);
> +			if (i >= bufsize)
> +				goto stop;
> +		}
> +	}
> +stop:
> +
> +	/* Compare the images */
> +	for (i = 0; i < bufsize; i++) {
> +		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
> +		if (scratch[i] != buffer[i])
> +			return;
> +	}
> +
> +	KUNIT_SUCCEED();
> +}
> +
> +static void iov_kunit_destroy_xarray(void *data)
> +{
> +	struct xarray *xarray = data;
> +
> +	xa_destroy(xarray);
> +	kfree(xarray);
> +}
> +
> +static void __init iov_kunit_load_xarray(struct kunit *test,
> +					 struct iov_iter *iter, int dir,
> +					 struct xarray *xarray,
> +					 struct page **pages, size_t npages)
> +{
> +	size_t size = 0;
> +	int i;
> +
> +	for (i = 0; i < npages; i++) {
> +		void *x = xa_store(xarray, i, pages[i], GFP_KERNEL);
> +
> +		KUNIT_ASSERT_FALSE(test, xa_is_err(x));
> +		size += PAGE_SIZE;
> +	}
> +	iov_iter_xarray(iter, dir, xarray, 0, size);
> +}
> +
> +static struct xarray *iov_kunit_create_xarray(struct kunit *test)
> +{
> +	struct xarray *xarray;
> +
> +	xarray = kzalloc(sizeof(struct xarray), GFP_KERNEL);
> +	xa_init(xarray);
> +	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, xarray);
> +	kunit_add_action_or_reset(test, iov_kunit_destroy_xarray, xarray);
> +	return xarray;
> +}
> +
> +/*
> + * Test copying to a ITER_XARRAY-type iterator.
> + */
> +static void __init iov_kunit_copy_to_xarray(struct kunit *test)
> +{
> +	const struct kvec_test_range *pr;
> +	struct iov_iter iter;
> +	struct xarray *xarray;
> +	struct page **spages, **bpages;
> +	u8 *scratch, *buffer;
> +	size_t bufsize, npages, size, copied;
> +	int i, patt;
> +
> +	bufsize = 0x100000;
> +	npages = bufsize / PAGE_SIZE;
> +
> +	xarray = iov_kunit_create_xarray(test);
> +
> +	scratch = iov_kunit_create_buffer(test, &spages, npages);
> +	for (i = 0; i < bufsize; i++)
> +		scratch[i] = pattern(i);
> +
> +	buffer = iov_kunit_create_buffer(test, &bpages, npages);
> +	memset(buffer, 0, bufsize);
> +
> +	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
> +
> +	i = 0;
> +	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
> +		size = pr->to - pr->from;
> +		KUNIT_ASSERT_LE(test, pr->to, bufsize);
> +
> +		iov_iter_xarray(&iter, READ, xarray, pr->from, size);
> +		copied = copy_to_iter(scratch + i, size, &iter);
> +
> +		KUNIT_EXPECT_EQ(test, copied, size);
> +		KUNIT_EXPECT_EQ(test, iter.count, 0);
> +		KUNIT_EXPECT_EQ(test, iter.iov_offset, size);
> +		i += size;
> +	}
> +
> +	/* Build the expected image in the scratch buffer. */
> +	patt = 0;
> +	memset(scratch, 0, bufsize);
> +	for (pr = kvec_test_ranges; pr->from >= 0; pr++)
> +		for (i = pr->from; i < pr->to; i++)
> +			scratch[i] = pattern(patt++);
> +
> +	/* Compare the images */
> +	for (i = 0; i < bufsize; i++) {
> +		KUNIT_EXPECT_EQ_MSG(test, buffer[i], scratch[i], "at i=%x", i);
> +		if (buffer[i] != scratch[i])
> +			return;
> +	}
> +
> +	KUNIT_SUCCEED();
> +}
> +
> +/*
> + * Test copying from a ITER_XARRAY-type iterator.
> + */
> +static void __init iov_kunit_copy_from_xarray(struct kunit *test)
> +{
> +	const struct kvec_test_range *pr;
> +	struct iov_iter iter;
> +	struct xarray *xarray;
> +	struct page **spages, **bpages;
> +	u8 *scratch, *buffer;
> +	size_t bufsize, npages, size, copied;
> +	int i, j;
> +
> +	bufsize = 0x100000;
> +	npages = bufsize / PAGE_SIZE;
> +
> +	xarray = iov_kunit_create_xarray(test);
> +
> +	buffer = iov_kunit_create_buffer(test, &bpages, npages);
> +	for (i = 0; i < bufsize; i++)
> +		buffer[i] = pattern(i);
> +
> +	scratch = iov_kunit_create_buffer(test, &spages, npages);
> +	memset(scratch, 0, bufsize);
> +
> +	iov_kunit_load_xarray(test, &iter, READ, xarray, bpages, npages);
> +
> +	i = 0;
> +	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
> +		size = pr->to - pr->from;
> +		KUNIT_ASSERT_LE(test, pr->to, bufsize);
> +
> +		iov_iter_xarray(&iter, WRITE, xarray, pr->from, size);
> +		copied = copy_from_iter(scratch + i, size, &iter);
> +
> +		KUNIT_EXPECT_EQ(test, copied, size);
> +		KUNIT_EXPECT_EQ(test, iter.count, 0);
> +		KUNIT_EXPECT_EQ(test, iter.iov_offset, size);
> +		i += size;
> +	}
> +
> +	/* Build the expected image in the main buffer. */
> +	i = 0;
> +	memset(buffer, 0, bufsize);
> +	for (pr = kvec_test_ranges; pr->from >= 0; pr++) {
> +		for (j = pr->from; j < pr->to; j++) {
> +			buffer[i++] = pattern(j);
> +			if (i >= bufsize)
> +				goto stop;
> +		}
> +	}
> +stop:
> +
> +	/* Compare the images */
> +	for (i = 0; i < bufsize; i++) {
> +		KUNIT_EXPECT_EQ_MSG(test, scratch[i], buffer[i], "at i=%x", i);
> +		if (scratch[i] != buffer[i])
> +			return;
> +	}
> +
> +	KUNIT_SUCCEED();
> +}
> +
> +static struct kunit_case __refdata iov_kunit_cases[] = {
> +	KUNIT_CASE(iov_kunit_copy_to_kvec),
> +	KUNIT_CASE(iov_kunit_copy_from_kvec),
> +	KUNIT_CASE(iov_kunit_copy_to_bvec),
> +	KUNIT_CASE(iov_kunit_copy_from_bvec),
> +	KUNIT_CASE(iov_kunit_copy_to_xarray),
> +	KUNIT_CASE(iov_kunit_copy_from_xarray),
> +	{}
> +};
> +
> +static struct kunit_suite iov_kunit_suite = {
> +	.name = "iov_iter",
> +	.test_cases = iov_kunit_cases,
> +};
> +
> +kunit_test_suites(&iov_kunit_suite);
---end quoted text---

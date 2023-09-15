Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B81B7A1FCE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 15:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbjIONZs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 Sep 2023 09:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235330AbjIONZq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 Sep 2023 09:25:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2C54E1713
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 Sep 2023 06:24:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694784298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YwX0LvGe2IzI2EOEiWJxA7uUIanGLX6c6iCFRhbWEYk=;
        b=AiNDRyDsRmzTUyZQbEi8ZHf1fALxQTajCPouAVo5o/1bIU7P3XPI9UUWYaNfRWMiXGQwTl
        FWLurlx32SQx0WSDaOVysOp7ojJoMRWXgMLKPKmogrItSaFPdNPDtWzkjZWW/un08qIYVC
        2oVL9ZvPmxbtwO0kLRuGO80jUZrIICA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-66-4Bq-zBPcP-SVdF6pYdLdww-1; Fri, 15 Sep 2023 09:24:54 -0400
X-MC-Unique: 4Bq-zBPcP-SVdF6pYdLdww-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CA13480349B;
        Fri, 15 Sep 2023 13:24:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6689610F1BE9;
        Fri, 15 Sep 2023 13:24:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5017b9fa177f4deaa5d481a5d8914ab4@AcuMS.aculab.com>
References: <5017b9fa177f4deaa5d481a5d8914ab4@AcuMS.aculab.com> <dcc6543d71524ac488ca2a56dd430118@AcuMS.aculab.com> <20230914221526.3153402-1-dhowells@redhat.com> <20230914221526.3153402-10-dhowells@redhat.com> <3370515.1694772627@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, "Christoph Hellwig" <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        "Matthew Wilcox" <willy@infradead.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "kunit-dev@googlegroups.com" <kunit-dev@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        "David Hildenbrand" <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [RFC PATCH 9/9] iov_iter: Add benchmarking kunit tests for UBUF/IOVEC
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3629597.1694784290.1@warthog.procyon.org.uk>
Date:   Fri, 15 Sep 2023 14:24:50 +0100
Message-ID: <3629598.1694784290@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> You could also just not do the copy!
> Although you need (say) asm volatile("\n",:::"memory") to
> stop it all being completely optimised away.
> That might show up a difference in the 'out_of_line' test
> where 15% on top on the data copies is massive - it may be
> that the data cache behaviour is very different for the
> two cases.

I tried using the following as the load:

	volatile unsigned long foo;

	static __always_inline
	size_t idle_user_iter(void __user *iter_from, size_t progress,
			      size_t len, void *to, void *priv2)
	{
		nop();
		nop();
		foo += (unsigned long)iter_from;
		foo += (unsigned long)len;
		foo += (unsigned long)to + progress;
		nop();
		nop();
		return 0;
	}

	static __always_inline
	size_t idle_kernel_iter(void *iter_from, size_t progress,
				size_t len, void *to, void *priv2)
	{
		nop();
		nop();
		foo += (unsigned long)iter_from;
		foo += (unsigned long)len;
		foo += (unsigned long)to + progress;
		nop();
		nop();
		return 0;
	}

	size_t iov_iter_idle(struct iov_iter *iter, size_t len, void *priv)
	{
		return iterate_and_advance(iter, len, priv,
					   idle_user_iter, idle_kernel_iter);
	}
	EXPORT_SYMBOL(iov_iter_idle);

adding various things into a volatile variable to prevent the optimiser from
discarding the calculations.

I get:

 iov_kunit_benchmark_bvec: avg 395 uS, stddev 46 uS
 iov_kunit_benchmark_bvec: avg 397 uS, stddev 38 uS
 iov_kunit_benchmark_bvec: avg 411 uS, stddev 57 uS
 iov_kunit_benchmark_bvec_outofline: avg 781 uS, stddev 5 uS
 iov_kunit_benchmark_bvec_outofline: avg 781 uS, stddev 6 uS
 iov_kunit_benchmark_bvec_outofline: avg 781 uS, stddev 7 uS
 iov_kunit_benchmark_bvec_split: avg 3599 uS, stddev 737 uS
 iov_kunit_benchmark_bvec_split: avg 3664 uS, stddev 838 uS
 iov_kunit_benchmark_bvec_split: avg 3669 uS, stddev 875 uS
 iov_kunit_benchmark_iovec: avg 472 uS, stddev 17 uS
 iov_kunit_benchmark_iovec: avg 506 uS, stddev 59 uS
 iov_kunit_benchmark_iovec: avg 525 uS, stddev 14 uS
 iov_kunit_benchmark_kvec: avg 421 uS, stddev 73 uS
 iov_kunit_benchmark_kvec: avg 428 uS, stddev 68 uS
 iov_kunit_benchmark_kvec: avg 469 uS, stddev 75 uS
 iov_kunit_benchmark_ubuf: avg 1052 uS, stddev 6 uS
 iov_kunit_benchmark_ubuf: avg 1168 uS, stddev 8 uS
 iov_kunit_benchmark_ubuf: avg 1168 uS, stddev 9 uS
 iov_kunit_benchmark_xarray: avg 680 uS, stddev 11 uS
 iov_kunit_benchmark_xarray: avg 682 uS, stddev 20 uS
 iov_kunit_benchmark_xarray: avg 686 uS, stddev 46 uS
 iov_kunit_benchmark_xarray_outofline: avg 1340 uS, stddev 34 uS
 iov_kunit_benchmark_xarray_outofline: avg 1358 uS, stddev 12 uS
 iov_kunit_benchmark_xarray_outofline: avg 1358 uS, stddev 15 uS

where I made the iovec and kvec tests split their buffers into PAGE_SIZE
segments and the ubuf test issue an iteration per PAGE_SIZE'd chunk.
Splitting kvec into just 8 results in the iteration taking <1uS.

The bvec_split test is doing a kmalloc() per 256 pages inside of the loop,
which is why that takes quite a long time.

David


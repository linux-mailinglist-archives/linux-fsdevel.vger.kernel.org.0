Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDB77A82A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Sep 2023 15:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236426AbjITNFK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Sep 2023 09:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236406AbjITNFI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:05:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D654B6
        for <linux-fsdevel@vger.kernel.org>; Wed, 20 Sep 2023 06:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695215051;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=3xEcAxdVo0QbYUsmze3l+A9lWAZy7tCqYqfeJQv6WXY=;
        b=V7wX0UoM3Fm36V1546bJVhk1V8H9co4538K9YPx3IvnaXMz+29619lpzrzcbKc+FjYzxS3
        h8mRJNo2adYqKYa+v6YGy0KZKw655/w+AoWixY6NBwLfdaBVvz+Nf7lupOZmFgc652bTBu
        ZW9yH5xJfll7nmydZRdjUhatWSvFkgM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-602-mff24TgoP1-vGnBtTIgghw-1; Wed, 20 Sep 2023 09:04:08 -0400
X-MC-Unique: mff24TgoP1-vGnBtTIgghw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A1BA03812592;
        Wed, 20 Sep 2023 13:04:07 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EB7DA10F1BE7;
        Wed, 20 Sep 2023 13:04:03 +0000 (UTC)
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
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/9] iov_iter: kunit: Cleanup, abstraction and more tests
Date:   Wed, 20 Sep 2023 14:03:51 +0100
Message-ID: <20230920130400.203330-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Jens,

Can you consider taking this through the block tree?

These patches make some changes to the kunit tests previously added for
iov_iter testing, in particular adding testing of UBUF/IOVEC iterators and
some benchmarking:

 (1) Clean up a couple of checkpatch style complaints.

 (2) Consolidate some repeated bits of code into helper functions and use
     the same struct to represent straight offset/address ranges and
     partial page lists.

 (3) Add a function to set up a userspace VM, attach the VM to the kunit
     testing thread, create an anonymous file, stuff some pages into the
     file and map the file into the VM to act as a buffer that can be used
     with UBUF/IOVEC iterators.

     I map an anonymous file with pages attached rather than using MAP_ANON
     so that I can check the pages obtained from iov_iter_extract_pages()
     without worrying about them changing due to swap, migrate, etc..

     [?] Is this the best way to do things?  Mirroring execve, it requires
     a number of extra core symbols to be exported.  Should this be done in
     the core code?

 (4) Add tests for copying into and out of UBUF and IOVEC iterators.

 (5) Add tests for extracting pages from UBUF and IOVEC iterators.

 (6) Add tests to benchmark copying 256MiB to UBUF, IOVEC, KVEC, BVEC and
     XARRAY iterators.

 (7) Add a test to benchmark copying 256MiB through dynamically allocated
     256-page bvecs to simulate bio construction.

Example benchmarks output:

	iov_kunit_benchmark_ubuf: avg 4474 uS, stddev 1340 uS
	iov_kunit_benchmark_iovec: avg 6619 uS, stddev 23 uS
	iov_kunit_benchmark_kvec: avg 2672 uS, stddev 14 uS
	iov_kunit_benchmark_bvec: avg 3189 uS, stddev 19 uS
	iov_kunit_benchmark_bvec_split: avg 3403 uS, stddev 8 uS
	iov_kunit_benchmark_xarray: avg 3709 uS, stddev 7 uS

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-kunit

David

Changes
=======
ver #2)
 - Use MAP_ANON to make the user buffer if we don't want a list of pages.
 - KUNIT_ASSERT_NOT_ERR_OR_NULL() doesn't like __user pointers as the
   condition, so cast.
 - Make the UBUF benchmark loop, doing an iterator per page so that the
   overhead from the iterator code is not negligible.
 - Make the KVEC benchmark use an iovec per page so that the iteration is
   not not negligible.
 - Switch the benchmarking to use copy_from_iter() so that only a single
   page is needed in the userspace buffer (as it can be shared R/O), not
   256MiB's worth.

Link: https://lore.kernel.org/r/20230914221526.3153402-1-dhowells@redhat.com/ # v1

David Howells (9):
  iov_iter: Fix some checkpatch complaints in kunit tests
  iov_iter: Consolidate some of the repeated code into helpers
  iov_iter: Consolidate the test vector struct in the kunit tests
  iov_iter: Consolidate bvec pattern checking
  iov_iter: Create a function to prepare userspace VM for UBUF/IOVEC
    tests
  iov_iter: Add copy kunit tests for ITER_UBUF and ITER_IOVEC
  iov_iter: Add extract kunit tests for ITER_UBUF and ITER_IOVEC
  iov_iter: Add benchmarking kunit tests
  iov_iter: Add benchmarking kunit tests for UBUF/IOVEC

 arch/loongarch/include/asm/page.h |    1 +
 arch/s390/kernel/vdso.c           |    1 +
 fs/anon_inodes.c                  |    1 +
 kernel/fork.c                     |    2 +
 lib/kunit_iov_iter.c              | 1241 ++++++++++++++++++++++++-----
 mm/mmap.c                         |    1 +
 mm/util.c                         |    3 +
 7 files changed, 1058 insertions(+), 192 deletions(-)


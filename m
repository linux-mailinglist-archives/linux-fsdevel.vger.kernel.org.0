Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89AAD7A10A5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Sep 2023 00:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjINWQa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Sep 2023 18:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjINWQ2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Sep 2023 18:16:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1465270C
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Sep 2023 15:15:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694729735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=qbzfkB6XDeg+lyjll9b1bWAHm6ZrCh25IkF3gmIpS/A=;
        b=VIlTBVmfvvJ4WD9odY7VRvXwjMnYv8B+1Xc4P4WEgxL8/7ow9CJrFozeQqOMJ2VQGGM6zs
        fx7o4MbAjP4q8JBAikNUXUUulW3LfVdf5EXXyAwbf3uTKfXCS3e5SgWBrB5I9FmigK/yLq
        xUtBgcVBH1h3YoGNnWcJ4uIgef83TOY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-593-0e1tLjckMi63woBcMf-5IA-1; Thu, 14 Sep 2023 18:15:31 -0400
X-MC-Unique: 0e1tLjckMi63woBcMf-5IA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 80B2E857A9E;
        Thu, 14 Sep 2023 22:15:30 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 76C5410F1BE7;
        Thu, 14 Sep 2023 22:15:28 +0000 (UTC)
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
        kunit-dev@googlegroups.com, linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/9] iov_iter: kunit: Cleanup, abstraction and more tests
Date:   Thu, 14 Sep 2023 23:15:17 +0100
Message-ID: <20230914221526.3153402-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al, Linus,

These patches make some changes to the kunit tests previously added for
iov_iter testing, in particular adding support for testing UBUF/IOVEC
iterators:

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

     [!] Note that this requires 256MiB of memory for UBUF and IOVEC; the
     KVEC, BVEC and XARRAY benchmarking maps a single page multiple times.
     I might be able to shrink that if I can add the same page multiple
     times to the anon file's pagecache.  I'm sure this is not recommended,
     but I might be able to get away with it for this particular
     application.

 (7) Add a test to benchmark copying 256MiB through dynamically allocated
     256-page bvecs to simulate bio construction.

Example benchmarks output:

 iov_kunit_benchmark_ubuf: avg 26899 uS, stddev 142 uS
 iov_kunit_benchmark_iovec: avg 26897 uS, stddev 74 uS
 iov_kunit_benchmark_kvec: avg 2688 uS, stddev 35 uS
 iov_kunit_benchmark_bvec: avg 3139 uS, stddev 21 uS
 iov_kunit_benchmark_bvec_split: avg 3379 uS, stddev 15 uS
 iov_kunit_benchmark_xarray: avg 3582 uS, stddev 13 uS

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-kunit

David

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

 fs/anon_inodes.c     |    1 +
 kernel/fork.c        |    2 +
 lib/kunit_iov_iter.c | 1211 +++++++++++++++++++++++++++++++++++-------
 mm/mmap.c            |    1 +
 mm/util.c            |    1 +
 5 files changed, 1024 insertions(+), 192 deletions(-)


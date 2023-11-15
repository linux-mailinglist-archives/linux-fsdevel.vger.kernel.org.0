Return-Path: <linux-fsdevel+bounces-2899-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B89D7EC79F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 16:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31A0E1F21D83
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Nov 2023 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799F73BB36;
	Wed, 15 Nov 2023 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HBXAnH0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF43BB29
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 15:50:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73F33AD
	for <linux-fsdevel@vger.kernel.org>; Wed, 15 Nov 2023 07:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700063399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+63cPdnCPLjbKCS5/t308GAcV4bDVpzj1bwgDRa790U=;
	b=HBXAnH0/QlzWXNmPHnqaCMTielLa+IMg+W+Ghw4rM7JUg90gylFV9aaUh9vfbcSAlQSK4V
	Ukb3N5J+XCz8zUhWDMQL12cM2eeNf2SRa6yMtGBFVp5OiPC6RIl//0TzFIw+zGC87Bfiwx
	LgiN/SMemNky6xdgvCAedDXI9pW34Vg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-UGIGDn_hM6CdQuAGtRNCPw-1; Wed, 15 Nov 2023 10:49:54 -0500
X-MC-Unique: UGIGDn_hM6CdQuAGtRNCPw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 86A62101A550;
	Wed, 15 Nov 2023 15:49:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.16])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3EC981121306;
	Wed, 15 Nov 2023 15:49:51 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 00/10] iov_iter: kunit: Cleanup, abstraction and more tests
Date: Wed, 15 Nov 2023 15:49:36 +0000
Message-ID: <20231115154946.3933808-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hi Christian,

Can you take this through the filesystem tree?

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

 (7) Add a test to bencmark copying 256MiB from an xarray that gets decanted
     into 256-page BVEC iterators to model batching from the pagecache.

 (8) Add a test to benchmark copying 256MiB through dynamically allocated
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
ver #3)
 - #include <linux/personality.h> to get READ_IMPLIES_EXEC.
 - Add a test to benchmark decanting an xarray into bio_vecs.

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
Link: https://lore.kernel.org/r/20230920130400.203330-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20230922113038.1135236-1-dhowells@redhat.com/ # v3

David Howells (10):
  iov_iter: Fix some checkpatch complaints in kunit tests
  iov_iter: Consolidate some of the repeated code into helpers
  iov_iter: Consolidate the test vector struct in the kunit tests
  iov_iter: Consolidate bvec pattern checking
  iov_iter: Create a function to prepare userspace VM for UBUF/IOVEC
    tests
  iov_iter: Add copy kunit tests for ITER_UBUF and ITER_IOVEC
  iov_iter: Add extract kunit tests for ITER_UBUF and ITER_IOVEC
  iov_iter: Add benchmarking kunit tests
  iov_iter: Add kunit to benchmark decanting of xarray to bvec
  iov_iter: Add benchmarking kunit tests for UBUF/IOVEC

 arch/s390/kernel/vdso.c |    1 +
 fs/anon_inodes.c        |    1 +
 kernel/fork.c           |    2 +
 lib/kunit_iov_iter.c    | 1317 +++++++++++++++++++++++++++++++++------
 mm/mmap.c               |    1 +
 mm/util.c               |    3 +
 6 files changed, 1139 insertions(+), 186 deletions(-)



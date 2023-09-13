Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AFB79EF79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Sep 2023 18:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229698AbjIMQ5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Sep 2023 12:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjIMQ5k (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:57:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E528A1BCC
        for <linux-fsdevel@vger.kernel.org>; Wed, 13 Sep 2023 09:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694624216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MI060vw7gNs2EgugqUIkUSF5LdOKbL7jut/Z+Dk2jOM=;
        b=W7nneBuQzSD9Bnmg+FN9NVG/vd01MUkzG7YH/aqWruGUPbyd3URE7PYtHtfCjejwOJw/J4
        OgWaYEV9YMjpV85lKx/oEFll6pjls+NHCHL55HTtKVLwSswG75btkYZ9JWCUEBe15I2+mS
        AmjkqPV9OKfaKVDZI9k07Ls0W3U3bw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-s9X1cZReMDKzwxKo0eGPuQ-1; Wed, 13 Sep 2023 12:56:54 -0400
X-MC-Unique: s9X1cZReMDKzwxKo0eGPuQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ACE00101B45B;
        Wed, 13 Sep 2023 16:56:53 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DFF9764687;
        Wed, 13 Sep 2023 16:56:50 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 00/13] iov_iter: Convert the iterator macros into inline funcs
Date:   Wed, 13 Sep 2023 17:56:35 +0100
Message-ID: <20230913165648.2570623-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al, Linus,

Here's my latest go at converting the iov_iter iteration macros to be
inline functions.  The first four functions are the main part of the
series:

 (1) To the recently added iov_iter kunit tests add three benchmarking
     tests that test copying 256MiB from one buffer to another using three
     different methods (single-BVEC over the whole buffer, BVEC's allocated
     dynamically for 256-page chunks and whole-buffer XARRAY).  The results
     are dumped to dmesg.  No setting up is required with null blockdevs or
     anything like that.

 (2) Renumber the type enum so that the ITER_* constants match the order in
     iterate_and_advance*().

 (3) Since (2) puts UBUF and IOVEC at 0 and 1, change user_backed_iter() to
     just use the type value and get rid of the extra flag.

 (4) Converts the iov_iter iteration macros to always-inline functions to
     make the code easier to follow.  It uses function pointers, but they
     get optimised away.  The priv2 argument likewise gets optimised away
     if unused.

The rest of the patches are some options for consideration:

 (5) Move the iov_iter iteration macros to a header file so that bespoke
     iterators can be created elsewhere.  For instance, rbd has an
     optimisation that requires it to scan to the buffer it is given to see
     if it is all zeros.  It would be nice if this could use
     iterate_and_advance() - but that's currently buried inside
     lib/iov_iter.c.

 (6) On top of (5), provide a cut-down iteration function that can only
     handle kernel-backed iterators (ie. BVEC, KVEC, XARRAY and DISCARD)
     for situations where we know that we won't see UBUF/IOVEC.

 (7-8) Make copy_to/from_iter() always catch MCE and return a short copy.
     This doesn't particularly increase the code size as the handling works
     via exception handling tables.  That said, there may be code that
     doesn't check to result of the copy that could be adversely affected.
     If we go with this, it might be worth having an 'MCE happened' flag in
     the iterator or something by which this can be checked for.

     [?] Is it better to kill the thread than returning a short copy if an
     MCE occurs?
     [?] Is it better to manually select MCE handling?

 (9) On top of (5), move the copy-and-csum code to net/ where it can be in
     proximity with the code that uses it.  This eliminates the code if
     CONFIG_NET=n and allows for the slim possibility of it being inlined.

(10) On top of (9), fold memcpy_and_csum() in to its two users.

(11) On top of (9), move csum_and_copy_from_iter_full() out of line and
     merge in csum_and_copy_from_iter() since the former is the only caller
     of the latter.

(12) Move hash_and_copy_to_iter() to net/ where it can be with its only
     caller.

(13) Add a testing misc device for testing/benchmarking ITER_UBUF and
     ITER_IOVEC devices.  It is driven by read/write/readv/writev and the
     results dumped through a tracepoint.

Further changes I could make:

 (1) Add an 'ITER_OTHER' type and an ops table pointer and have
     iterate_and_advance2(), iov_iter_advance(), iov_iter_revert(),
     etc. jump through it if it sees ITER_OTHER type.  This would allow
     types for, say, scatterlist, bio list, skbuff to be added without
     further expanding the core.

 (2) Move the ITER_XARRAY type to being an ITER_OTHER type.  This would
     shrink the core iterators quite a lot and reduce the stack usage as
     the xarray walking stuff wouldn't be there.

Anyway, the changes in compiled function size either side of patch (4) on
x86_64 look like:

	_copy_from_iter                          inc 0x360 -> 0x3d5 +0x75
	_copy_from_iter_flushcache               inc 0x34c -> 0x358 +0xc
	_copy_from_iter_nocache                  dcr 0x354 -> 0x346 -0xe
	_copy_mc_to_iter                         inc 0x396 -> 0x3cf +0x39
	_copy_to_iter                            inc 0x33b -> 0x35d +0x22
	copy_page_from_iter_atomic.part.0        inc 0x393 -> 0x408 +0x75
	copy_page_to_iter_nofault.part.0         dcr 0x3de -> 0x3b2 -0x2c
	copyin                                   del 0x30
	copyout                                  del 0x2d
	copyout_mc                               del 0x2b
	csum_and_copy_from_iter                  inc 0x3db -> 0x3f4 +0x19
	csum_and_copy_to_iter                    dcr 0x45d -> 0x45b -0x2
	iov_iter_zero                            dcr 0x34a -> 0x342 -0x8
	memcpy_from_iter.isra.0                  del 0x1f
	memcpy_from_iter_mc                      new 0x2b

Note that there's a noticeable expansion on some of the main functions
because a number of the helpers get inlined instead of being called.

In terms of benchmarking patch (4), three runs without it:

	# iov_kunit_benchmark_bvec: avg 3175 uS
	# iov_kunit_benchmark_bvec_split: avg 3404 uS
	# iov_kunit_benchmark_xarray: avg 3611 uS
	# iov_kunit_benchmark_bvec: avg 3175 uS
	# iov_kunit_benchmark_bvec_split: avg 3403 uS
	# iov_kunit_benchmark_xarray: avg 3611 uS
	# iov_kunit_benchmark_bvec: avg 3172 uS
	# iov_kunit_benchmark_bvec_split: avg 3401 uS
	# iov_kunit_benchmark_xarray: avg 3614 uS

and three runs with it:

	# iov_kunit_benchmark_bvec: avg 3141 uS
	# iov_kunit_benchmark_bvec_split: avg 3405 uS
	# iov_kunit_benchmark_xarray: avg 3546 uS
	# iov_kunit_benchmark_bvec: avg 3140 uS
	# iov_kunit_benchmark_bvec_split: avg 3405 uS
	# iov_kunit_benchmark_xarray: avg 3546 uS
	# iov_kunit_benchmark_bvec: avg 3138 uS
	# iov_kunit_benchmark_bvec_split: avg 3401 uS
	# iov_kunit_benchmark_xarray: avg 3542 uS

It looks like patch (4) makes things a little bit faster, probably due to
the extra inlining.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-cleanup

David

Changes
=======
ver #4)
 - Fix iterate_bvec() and iterate_kvec() to update iter->bvec and
   iter->kvec after subtracting it to calculate iter->nr_segs.
 - Change iterate_xarray() to use start+progress rather than increasing
   start to reduce code size.
 - Added patches to move some iteration functions over to net/ as the files
   there can #include the iterator framework.
 - Added a patch to benchmark the iteration.

ver #3)
 - Use min_t(size_t,) not min() to avoid a warning on Hexagon.
 - Inline all the step functions.
 - Added a patch to better handle copy_mc.

ver #2)
 - Rebased on top of Willy's changes in linux-next.
 - Change the checksum argument to the iteration functions to be a general
   void* and use it to pass iter->copy_mc flag to memcpy_from_iter_mc() to
   avoid using a function pointer.
 - Arrange the end of the iterate_*() functions to look the same to give
   the optimiser the best chance.
 - Make iterate_and_advance() a wrapper around iterate_and_advance2().
 - Adjust iterate_and_advance2() to use if-else-if-else-if-else rather than
   switch(), to put ITER_BVEC before KVEC and to mark UBUF and IOVEC as
   likely().
 - Move "iter->count += progress" into iterate_and_advance2() from the
   iterate functions.
 - Mark a number of the iterator helpers with __always_inline.
 - Fix _copy_from_iter_flushcache() to use memcpy_from_iter_flushcache()
   not memcpy_from_iter().

Link: https://lore.kernel.org/r/3710261.1691764329@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/855.1692047347@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/20230816120741.534415-1-dhowells@redhat.com/ # v3

David Howells (13):
  iov_iter: Add a benchmarking kunit test
  iov_iter: Renumber ITER_* constants
  iov_iter: Derive user-backedness from the iterator type
  iov_iter: Convert iterate*() to inline funcs
  iov: Move iterator functions to a header file
  iov_iter: Add a kernel-type iterator-only iteration function
  iov_iter: Make copy_from_iter() always handle MCE
  iov_iter: Remove the copy_mc flag and associated functions
  iov_iter, net: Move csum_and_copy_to/from_iter() to net/
  iov_iter, net: Fold in csum_and_memcpy()
  iov_iter, net: Merge csum_and_copy_from_iter{,_full}() together
  iov_iter, net: Move hash_and_copy_to_iter() to net/
  iov_iter: Create a fake device to allow iov_iter testing/benchmarking

 arch/x86/include/asm/mce.h |  23 ++
 fs/coredump.c              |   1 -
 include/linux/iov_iter.h   | 296 +++++++++++++++++++++++++
 include/linux/skbuff.h     |   3 +
 include/linux/uio.h        |  45 +---
 lib/Kconfig.debug          |   8 +
 lib/Makefile               |   1 +
 lib/iov_iter.c             | 429 +++++++++++--------------------------
 lib/kunit_iov_iter.c       | 181 ++++++++++++++++
 lib/test_iov_iter.c        | 134 ++++++++++++
 lib/test_iov_iter_trace.h  |  80 +++++++
 net/core/datagram.c        |  75 ++++++-
 net/core/skbuff.c          |  40 ++++
 13 files changed, 966 insertions(+), 350 deletions(-)
 create mode 100644 include/linux/iov_iter.h
 create mode 100644 lib/test_iov_iter.c
 create mode 100644 lib/test_iov_iter_trace.h


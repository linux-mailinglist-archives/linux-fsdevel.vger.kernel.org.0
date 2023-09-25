Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DEB77AD77D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 14:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjIYMEU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 08:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231293AbjIYMEO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 08:04:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D41C6E8
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 05:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695643401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=7PrQ9j/OOfImgMYDYuu1gLWNvl1SyxgB2olvcp6W7Sw=;
        b=SfYb1nEcsviNQLNZ0zbJ0IqXLx/NVJHFI0d1MOh2stqGXsPnVYQuzyF5aV6oEo4jm12+DX
        L14R+P4zNnX6VVdAHDYzDT1ktFe2NWfGpVE/Jzbs5KghIiG+sbW5H5bzH8cPbR9cmeAULB
        AViAb5TVDFsZK0mgPxpvJQqONkLA7e4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-a1aRLz8mMN6Eall4iPcICw-1; Mon, 25 Sep 2023 08:03:17 -0400
X-MC-Unique: a1aRLz8mMN6Eall4iPcICw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1505F29AB3F7;
        Mon, 25 Sep 2023 12:03:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.216])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 448BD40C2064;
        Mon, 25 Sep 2023 12:03:13 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 00/12] iov_iter: Convert the iterator macros into inline funcs
Date:   Mon, 25 Sep 2023 13:02:57 +0100
Message-ID: <20230925120309.1731676-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
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

Hi Jens, Christian,

Could you take these patches into the block tree or the fs tree?  The
patches convert the iov_iter iteration macros to be inline functions.

 (1) Remove last_offset from iov_iter as it was only used by ITER_PIPE.

 (2) Add a __user tag on copy_mc_to_user()'s dst argument on x86 to match
     that on powerpc and get rid of a sparse warning.

 (3) Convert iter->user_backed to user_backed_iter() in the sound PCM
     driver.

 (4) Convert iter->user_backed to user_backed_iter() in a couple of
     infiniband drivers.

 (5) Renumber the type enum so that the ITER_* constants match the order in
     iterate_and_advance*().

 (6) Since the preceding patch puts UBUF and IOVEC at 0 and 1, change
     user_backed_iter() to just use the type value and get rid of the extra
     flag.

 (7) Convert the iov_iter iteration macros to always-inline functions to
     make the code easier to follow.  It uses function pointers, but they
     get optimised away.  The priv2 argument likewise gets optimised away
     if unused.

     The functions are placed into a header file so that bespoke iterators
     can be created elsewhere.  For instance, rbd has an optimisation that
     requires it to scan to the buffer it is given to see if it is all
     zeros.  It would be nice if this could use iterate_and_advance() - but
     that's currently buried inside lib/iov_iter.c.

     Whilst we could provide a generic iteration function that takes a pair
     of function pointers instead, it does add around 16% overhead in the
     framework, presumably from the combination of function pointers and
     various mitigations.

     Further, if it is known that just a particular iterator-type is in
     play, just that iteration function can be used.

 (8) Move the check for ->copy_mc to _copy_from_iter() and
     copy_page_from_iter_atomic() rather than in memcpy_from_iter_mc()
     where it gets repeated for every segment.  Instead, we check once and
     invoke a side function that can use iterate_bvec() rather than
     iterate_and_advance() and supply a different step function.

 (9) Move the copy-and-csum code to net/ where it can be in proximity with
     the code that uses it.  This eliminates the code if CONFIG_NET=n and
     allows for the slim possibility of it being inlined.

(10) Fold memcpy_and_csum() in to its two users.

(11) Move csum_and_copy_from_iter_full() out of line and merge in
     csum_and_copy_from_iter() since the former is the only caller of the
     latter.

(12) Move hash_and_copy_to_iter() to net/ where it can be with its only
     caller.

Anyway, the changes in compiled function size either side of patches
(5)+(6) on x86_64 look like:

	__copy_from_iter_mc                      new 0xe8
	_copy_from_iter                          inc 0x360 -> 0x3a7 +0x47
	_copy_from_iter_flushcache               inc 0x34c -> 0x38e +0x42
	_copy_from_iter_nocache                  inc 0x354 -> 0x378 +0x24
	_copy_mc_to_iter                         inc 0x396 -> 0x3f1 +0x5b
	_copy_to_iter                            inc 0x33b -> 0x385 +0x4a
	copy_page_from_iter_atomic.part.0        inc 0x393 -> 0x3e0 +0x4d
	copy_page_to_iter_nofault.part.0         inc 0x3de -> 0x3eb +0xd
	copyin                                   del 0x30
	copyout                                  del 0x2d
	copyout_mc                               del 0x2b
	csum_and_copy_from_iter                  inc 0x3db -> 0x41d +0x42
	csum_and_copy_to_iter                    inc 0x45d -> 0x48d +0x30
	iov_iter_zero                            inc 0x34a -> 0x36a +0x20
	memcpy_from_iter.isra.0                  del 0x1f

Note that there's a noticeable expansion on some of the main functions
because a number of the helpers get inlined instead of being called.

In terms of benchmarking patch (5)+(6), three runs without them:

	iov_kunit_benchmark_ubuf: avg 3955 uS, stddev 169 uS
	iov_kunit_benchmark_ubuf: avg 4122 uS, stddev 1292 uS
	iov_kunit_benchmark_ubuf: avg 4451 uS, stddev 1362 uS
	iov_kunit_benchmark_iovec: avg 6607 uS, stddev 22 uS
	iov_kunit_benchmark_iovec: avg 6608 uS, stddev 19 uS
	iov_kunit_benchmark_iovec: avg 6609 uS, stddev 24 uS
	iov_kunit_benchmark_bvec: avg 3166 uS, stddev 11 uS
	iov_kunit_benchmark_bvec: avg 3167 uS, stddev 13 uS
	iov_kunit_benchmark_bvec: avg 3170 uS, stddev 16 uS
	iov_kunit_benchmark_bvec_split: avg 3394 uS, stddev 12 uS
	iov_kunit_benchmark_bvec_split: avg 3394 uS, stddev 20 uS
	iov_kunit_benchmark_bvec_split: avg 3395 uS, stddev 19 uS
	iov_kunit_benchmark_kvec: avg 2672 uS, stddev 12 uS
	iov_kunit_benchmark_kvec: avg 2672 uS, stddev 12 uS
	iov_kunit_benchmark_kvec: avg 2672 uS, stddev 9 uS
	iov_kunit_benchmark_xarray: avg 3719 uS, stddev 9 uS
	iov_kunit_benchmark_xarray: avg 3719 uS, stddev 9 uS
	iov_kunit_benchmark_xarray: avg 3721 uS, stddev 24 uS

and three runs with them:

	iov_kunit_benchmark_ubuf: avg 4110 uS, stddev 1254 uS
	iov_kunit_benchmark_ubuf: avg 4141 uS, stddev 1411 uS
	iov_kunit_benchmark_ubuf: avg 4572 uS, stddev 1889 uS
	iov_kunit_benchmark_iovec: avg 6582 uS, stddev 27 uS
	iov_kunit_benchmark_iovec: avg 6585 uS, stddev 25 uS
	iov_kunit_benchmark_iovec: avg 6586 uS, stddev 48 uS
	iov_kunit_benchmark_bvec: avg 3175 uS, stddev 13 uS
	iov_kunit_benchmark_bvec: avg 3177 uS, stddev 12 uS
	iov_kunit_benchmark_bvec: avg 3178 uS, stddev 12 uS
	iov_kunit_benchmark_bvec_split: avg 3380 uS, stddev 20 uS
	iov_kunit_benchmark_bvec_split: avg 3384 uS, stddev 15 uS
	iov_kunit_benchmark_bvec_split: avg 3386 uS, stddev 25 uS
	iov_kunit_benchmark_kvec: avg 2671 uS, stddev 11 uS
	iov_kunit_benchmark_kvec: avg 2672 uS, stddev 12 uS
	iov_kunit_benchmark_kvec: avg 2677 uS, stddev 20 uS
	iov_kunit_benchmark_xarray: avg 3599 uS, stddev 20 uS
	iov_kunit_benchmark_xarray: avg 3603 uS, stddev 8 uS
	iov_kunit_benchmark_xarray: avg 3610 uS, stddev 16 uS

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-cleanup

David

Changes
=======
ver #7)
 - Defer the patch to add a kernel-backed iter-only to my ceph branch.
 - Add missing sign-offs and cc's to commit descriptions.

ver #6)
 - Rebase on v6.6-rc2 rather than on my iov-kunit branch.
 - Add a patch to remove last_offset from iov_iter.
 - Add a patch to tag copy_mc_to_user() with __user on x86.
 - Document the priv2 arg of iterate_and_advance_kernel().

ver #5)
 - Moved kunit test patches out to a separate set.
 - Moved "iter->count - progress" into individual iteration subfunctions.
 - Fix iterate_iovec() and to update iter->__iovec after subtracting it to
   calculate iter->nr_segs.
 - Merged the function inlining patch and the move-to-header patch.
 - Rearranged the patch order slightly to put the patches to move
   networking stuff to net/ last.
 - Went back to a simpler patch to special-case ->copy_mc in
   _copy_from_iter() and copy_page_from_iter_atomic() before we get to call
   iterate_and_advance() so as to reduce the number of checks for this.

ver #4)
 - Fix iterate_bvec() and iterate_kvec() to update iter->bvec and
   iter->kvec after subtracting it to calculate iter->nr_segs.
 - Change iterate_xarray() to use start+progress rather than increasing
   start to reduce code size.
 - Added patches to move some iteration functions over to net/ as the files
   there can #include the iterator framework.
 - Added a patch to benchmark the iteration.
 - Tried an experimental patch to make copy_from_iter() and similar always
   catch MCE.

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
Link: https://lore.kernel.org/r/20230913165648.2570623-1-dhowells@redhat.com/ # v4
Link: https://lore.kernel.org/r/20230920222231.686275-1-dhowells@redhat.com/ # v5
Link: https://lore.kernel.org/r/20230922120227.1173720-1-dhowells@redhat.com/ # v6

David Howells (12):
  iov_iter: Remove last_offset from iov_iter as it was for ITER_PIPE
  iov_iter, x86: Be consistent about the __user tag on copy_mc_to_user()
  sound: Fix snd_pcm_readv()/writev() to use iov access functions
  infiniband: Use user_backed_iter() to see if iterator is UBUF/IOVEC
  iov_iter: Renumber ITER_* constants
  iov_iter: Derive user-backedness from the iterator type
  iov_iter: Convert iterate*() to inline funcs
  iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()
  iov_iter, net: Move csum_and_copy_to/from_iter() to net/
  iov_iter, net: Fold in csum_and_memcpy()
  iov_iter, net: Merge csum_and_copy_from_iter{,_full}() together
  iov_iter, net: Move hash_and_copy_to_iter() to net/

 arch/x86/include/asm/uaccess.h           |   2 +-
 arch/x86/lib/copy_mc.c                   |   8 +-
 drivers/infiniband/hw/hfi1/file_ops.c    |   2 +-
 drivers/infiniband/hw/qib/qib_file_ops.c |   2 +-
 include/linux/iov_iter.h                 | 274 ++++++++++++++
 include/linux/skbuff.h                   |   3 +
 include/linux/uio.h                      |  34 +-
 lib/iov_iter.c                           | 441 +++++++----------------
 net/core/datagram.c                      |  75 +++-
 net/core/skbuff.c                        |  40 ++
 sound/core/pcm_native.c                  |   4 +-
 11 files changed, 544 insertions(+), 341 deletions(-)
 create mode 100644 include/linux/iov_iter.h


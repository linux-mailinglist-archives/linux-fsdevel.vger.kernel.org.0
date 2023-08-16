Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFA8877E11F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 14:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244964AbjHPMJD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Aug 2023 08:09:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244955AbjHPMIl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Aug 2023 08:08:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAF42133
        for <linux-fsdevel@vger.kernel.org>; Wed, 16 Aug 2023 05:07:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692187676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RLf6S0T96oznBLM7lxtJRSYVbgCb11fuIkm3JcQCYVo=;
        b=i71/vVpxmHKgdSwgnLDKefTSP0N/gCUNarQyY9nJ063kyQ7Gg/zMEnoW9rtpnJYES9NgNZ
        2dCIbdo1xKugfE6akm0mnDAsffVKFzNQTpQxfVlbrdXfPWdBSY8sgcZwFRGRPS7aYB6tNY
        5kzPBVnqkrnXpC8j+98stJqrzm3Gpqc=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-682-q3V6zIy1Mhy66h5iqLFzhw-1; Wed, 16 Aug 2023 08:07:52 -0400
X-MC-Unique: q3V6zIy1Mhy66h5iqLFzhw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3704B280D21A;
        Wed, 16 Aug 2023 12:07:52 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 496D3492C14;
        Wed, 16 Aug 2023 12:07:49 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@list.de>,
        Christian Brauner <christian@brauner.io>,
        David Laight <David.Laight@ACULAB.COM>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] iov_iter: Convert the iterator macros into inline funcs
Date:   Wed, 16 Aug 2023 13:07:39 +0100
Message-ID: <20230816120741.534415-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Al, Linus,

Here are a couple of patches to try and clean up the iov_iter iteration
stuff.

The first patch converts the iov_iter iteration macros to always-inline
functions to make the code easier to follow.  It uses function pointers,
but they should get optimised away.  The priv2 argument should likewise get
optimised away if unused.

The second patch makes _copy_from_iter() and copy_page_from_iter_atomic()
handle the ->copy_mc flag earlier and not in the step function.  This flag
is only set by the coredump code and only with a BVEC iterator, so we can
have special out-of-line handling for this that uses iterate_bvec() rather
than iterate_and_advance() - thereby avoiding repeated checks on it in a
multi-element iterator.

Further changes I could make:

 (1) Add an 'ITER_OTHER' type and an ops table pointer and have
     iterate_and_advance2(), iov_iter_advance(), iov_iter_revert(),
     etc. jump through it if it sees ITER_OTHER type.  This would allow
     types for, say, scatterlist, bio list, skbuff to be added without
     further expanding the core.

 (2) Move the ITER_XARRAY type to being an ITER_OTHER type.  This would
     shrink the core iterators quite a lot and reduce the stack usage as
     the xarray walking stuff wouldn't be there.

 (3) Move the iterate_*() functions into a header file so that bespoke
     iterators can be created elsewhere.  For instance, rbd has an
     optimisation that requires it to scan to the buffer it is given to see
     if it is all zeros.  It would be nice if this could use
     iterate_and_advance() - but that's buried inside lib/iov_iter.c.

Anyway, the overall changes in compiled function size for these patches on
x86_64 look like:

	__copy_from_iter_mc                      new 0xd6
	__export_symbol_iov_iter_init            inc 0x3 -> 0x8 +0x5
	_copy_from_iter                          inc 0x36e -> 0x380 +0x12
	_copy_from_iter_flushcache               inc 0x359 -> 0x364 +0xb
	_copy_from_iter_nocache                  dcr 0x36a -> 0x33e -0x2c
	_copy_mc_to_iter                         inc 0x3a7 -> 0x3bc +0x15
	_copy_to_iter                            dcr 0x358 -> 0x34a -0xe
	copy_page_from_iter_atomic.part.0        inc 0x3cf -> 0x3d4 +0x5
	copy_page_to_iter_nofault.part.0         dcr 0x3f1 -> 0x3a9 -0x48
	copyin                                   del 0x30
	copyout                                  del 0x2d
	copyout_mc                               del 0x2b
	csum_and_copy_from_iter                  dcr 0x3e8 -> 0x3e5 -0x3
	csum_and_copy_to_iter                    dcr 0x46a -> 0x446 -0x24
	iov_iter_zero                            dcr 0x34f -> 0x338 -0x17
	memcpy_from_iter.isra.0                  del 0x1f

with __copy_from_iter_mc() being the out-of-line handling for ->copy_mc.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-cleanup

David

Changes
=======
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

David Howells (2):
  iov_iter: Convert iterate*() to inline funcs
  iov_iter: Don't deal with iter->copy_mc in memcpy_from_iter_mc()

 lib/iov_iter.c | 627 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 386 insertions(+), 241 deletions(-)


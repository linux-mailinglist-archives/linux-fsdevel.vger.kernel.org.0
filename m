Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA29F614C18
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Nov 2022 14:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230078AbiKANwQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Nov 2022 09:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230003AbiKANwP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Nov 2022 09:52:15 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 768815F6D;
        Tue,  1 Nov 2022 06:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=G33VyQ6sOfQGS04g9QhDbkRC3o9MZ8PM6yea6yNSRRA=; b=2lokBh1C81D9XohJYqekPo1vRQ
        o6rFXfME/tQ3E2gTFRR+qhJtT/u6v/mm3nkxODcbwloUwJ+WUaPWtp980HGvaLU89tZwINoDl9qU6
        XnEGfKDrjpNg0Pb5Jv1FJ5WR3cRq4Yd/SVwqSflh/wf42c5E1n1ernTx8JYuv389a0tDXBBjMSzqC
        Bzfb4ksbvC+9Tm5Uex2YOOX7f4p/w2DCSe/YMdVHTq9Os38VCv949ELI+Az07K4OsPd8aVlUbas6w
        HyLylsmnk4TgNZCpDY3wMm0E68T959p3fSLPhLXKrFXKPaCHaMrHLegMqrUCNONSsMzHEHLDG+7Ye
        3uyoPv5A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oprgH-005Lk8-Mt; Tue, 01 Nov 2022 13:51:53 +0000
Date:   Tue, 1 Nov 2022 06:51:53 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@infradead.org>,
        David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlayton@redhat.com
Subject: Re: How to convert I/O iterators to iterators, sglists and RDMA lists
Message-ID: <Y2EkeULBA3zsiarf@infradead.org>
References: <Y01VjOE2RrLVA2T6@infradead.org>
 <1762414.1665761217@warthog.procyon.org.uk>
 <1415915.1666274636@warthog.procyon.org.uk>
 <Y1an1NFcowiSS9ms@infradead.org>
 <Y1btOP0tyPtcYajo@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1btOP0tyPtcYajo@ZenIV>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 08:53:28PM +0100, Al Viro wrote:
> 1) iter-to-scatterlist use is much wider than RDMA.  Other places like that
> include e.g. vhost_scsi_map_to_sgl(), p9_get_mapped_pages(),
> rds_message_zcopy_from_user(), tls_setup_from_iter()...

RDS is RDMA.  vhost_scsi_map_to_sgl and p9_get_mapped_pages do some
odd virtio thing.  But point taken, it is spread further than it should
be at the moment.  It is however a rather bad data structure that really
should not spead much further.

> 2) there's a limit to how far we can propagate an arbitrary iov_iter -
> ITER_IOVEC/ITER_UBUF ones are absolutely tied to mm_struct of the
> originating process.  We can't use them for anything async - not
> without the horrors a-la use_mm().

But why would you pass them on?  It is much better to just convert
them to a bio_vec and pass that on.  We could still feed that to n
iter later, and in fact there are a bunch of good reasons to do so.
But in pretty much all those cases you really do not want to keep
the whole iov_iter state.

> 	We can do separate sendmsg() for kvec and bvec parts,
> but that doesn't come for free either.  *AND* bvec part is very
> likely not the original iterator we got those pages from.

sendmsg model seems to be very much built around that model with
MSG_MORE.  But even with a 'converter' how do you plan to build
such a mixed iter anyay?

> My problem with all that stuff is that we ought to sort out the
> lifetime and pin_user issues around the iov_iter.  What I really
> want to avoid is "no worries, we'd extracted stuff into ITER_BVEC, it's
> stable and can be passed around in arbitrary way" kind of primitive.
> Because *that* has no chance to work.

Yes.  I think the first thing we need in this whole area is to sort
the pinning out.  After that we can talk about all kinds of convenience
helpers.

> As far as I can see, we have the following constraints:
> 
> 	* page references put into ITER_BVEC (and ITER_XARRAY) must not
> go away while the iov_iter is being used.  That's on the creator of
> iov_iter.

*nod*

> 	* pages found in iterator might be used past the lifetime of
> iterator.  We need the underlying pages to survive until the last
> use.  "Grab a page reference" is *NOT* a solution in general case.
> 	* pages found in data-destination iterator may have their
> contents modified, both during the iterator lifetime and asynchronously.

This is where the trouble start.  If you want to be able to feed
kmalloced data into throgh ITER_KVEC (or ITER_BVEC for the matter),
you can't just grab any kind of hold to it.  The only way to do that
is by telling the caller you're done with it.  I.e. how aio/io_ring/etc
use ki_complete - the callee owns the data until it declares it is done
by calling ->ki_complete.  But no 'borrowing' of refeferences as the
only sane way to do that would be page refcounts, but those do not
work for everything.

> If it has a chance to be a user-mapped page, we must either
> 	a) have it locked by caller and have no modifications after
> it gets unlocked or
> 	b) have it pinned (sensu pin_user_pages()) by the caller and
> have no modifications until the unpin_user_page().

Yes.  And I think we need a good counter part to iov_iter_pin_pages
that undoes any required pinning, so that users of iov_iter_pin_pages
and iov_iter_unpin_pages can use these helpers without even thinking
about the rules.  That requires passing some amount of state to the
unpin side.  It could just be an unsigned long with flags probably,
or we keep the iov_iter alive and look at that.

> Another issue with iov_iter_get_pages...() is that compound page turns
> into a bunch of references to individual subpages; io-uring folks have
> noticed the problem, but their solution is... inelegant.  I wonder if
> we would be better off with a variant of the primitive that would give
> out compound pages; it would need different calling conventions,
> obviously (current ones assume that all pages except the first and
> the last one have PAGE_SIZE worth of data in them).

The new name for compound pages is folios, and yes the whole get/pin
user pages machinery needs to switch to that.

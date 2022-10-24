Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9921C60BDDC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Oct 2022 00:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiJXWvS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 24 Oct 2022 18:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiJXWvA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:51:00 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B0F231F00D;
        Mon, 24 Oct 2022 14:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gfB8tVU+LuMTrh+dIxvKpaRgS9+mcOLabQElZ+4YZuA=; b=EiQuqgLQV+7+7zXEfXvtROS+4l
        2Yo8LkBUEGHw/Nx/yXX24JV4myFVVWDEKNFJKD1EABhMdu9wY4gzKf5NeMgt+t00sWnUAkEbb48Lp
        vUHdvmNBnUKYrYUBUksce1Ahga4TnCEQa1ekvnRz/QWujntk6DleTWy0JILlAfUEPn9mcvidZAeTK
        6/bVcCS65cNo0vNH+U6/MUha/LhtXGJjzeYkvEI0CsC2ztYwhQigqhPsetS8wl0S+qmj4KHnJipi7
        Vcdh52L7H4sqjm+qdagO8/8El7I2NEWID34XPdYHS75dtk6ukXPnbHfCziT+BQCpRIkLDGxXLJ82F
        /h7zB9nA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1on3Vo-00DZ91-2k;
        Mon, 24 Oct 2022 19:53:28 +0000
Date:   Mon, 24 Oct 2022 20:53:28 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     David Howells <dhowells@redhat.com>, willy@infradead.org,
        dchinner@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlayton@redhat.com
Subject: Re: How to convert I/O iterators to iterators, sglists and RDMA lists
Message-ID: <Y1btOP0tyPtcYajo@ZenIV>
References: <Y01VjOE2RrLVA2T6@infradead.org>
 <1762414.1665761217@warthog.procyon.org.uk>
 <1415915.1666274636@warthog.procyon.org.uk>
 <Y1an1NFcowiSS9ms@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1an1NFcowiSS9ms@infradead.org>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 24, 2022 at 07:57:24AM -0700, Christoph Hellwig wrote:

> So I think the iterator to iterator is a really bad idea and we should
> not have it at all.  It just works around the issue about not being
> able to easily keeping state after an iter based get_user_pages, but
> that is beeing addressed at the moment.  The iter to ib_sge/scatterlist
> are very much RDMA specific at the moment, so I guess that might be a
> good place to keep them.  In fact I suspect the scatterlist conversion
> should not be a public API at all, but hidden in rw.c and only be used
> internally for the DMA mapping.

1) iter-to-scatterlist use is much wider than RDMA.  Other places like that
include e.g. vhost_scsi_map_to_sgl(), p9_get_mapped_pages(),
rds_message_zcopy_from_user(), tls_setup_from_iter()...

2) there's a limit to how far we can propagate an arbitrary iov_iter -
ITER_IOVEC/ITER_UBUF ones are absolutely tied to mm_struct of the
originating process.  We can't use them for anything async - not
without the horrors a-la use_mm().

3) sendmsg() and recvmsg() are not suited for the situations where
we have a bunch of pages + some kmalloc'ed object.  Consider e.g.
NFS write; what goes on the wire is a combination of fixed-sized
request put together by NFS client code with pages containing the
data to be sent.  Ideally we'd like to send the entire bunch at
once; AFAICS there are only 3 ways to do that -
	* virt_to_page() for the fixed-sized part, build ITER_BVEC
iterator in ->msg_iter containing that page + the rest of submitted
pages, pass to ->sendmsg().
	* kmap() each data page, build ITER_KVEC iterator, pass to
->sendmsg().  Forget about any kind of zero-copy.  And that's
kmap(), not kmap_local_page().
	* try to implement heterogeneous iov_iter, with mix of (at
least) kvec and bvec parts.  Fucking nightmare, IMO, and anything
similar to iov_iter_get_pages() on those will have an insane
semantics.
	We can do separate sendmsg() for kvec and bvec parts,
but that doesn't come for free either.  *AND* bvec part is very
likely not the original iterator we got those pages from.

Unless I'm misunderstanding dhowells, that's not too dissimilar to
the reasons behind his proposed primitive...

My problem with all that stuff is that we ought to sort out the
lifetime and pin_user issues around the iov_iter.  What I really
want to avoid is "no worries, we'd extracted stuff into ITER_BVEC, it's
stable and can be passed around in arbitrary way" kind of primitive.
Because *that* has no chance to work.

As far as I can see, we have the following constraints:

	* page references put into ITER_BVEC (and ITER_XARRAY) must not
go away while the iov_iter is being used.  That's on the creator of
iov_iter.

	* pages found in iterator might be used past the lifetime of
iterator.  We need the underlying pages to survive until the last
use.  "Grab a page reference" is *NOT* a solution in general case.

	* pages found in data-destination iterator may have their
contents modified, both during the iterator lifetime and asynchronously.
If it has a chance to be a user-mapped page, we must either
	a) have it locked by caller and have no modifications after
it gets unlocked or
	b) have it pinned (sensu pin_user_pages()) by the caller and
have no modifications until the unpin_user_page().

	* data objects located in those pages might have the
lifetime *NOT* controlled by page refcount.  In particular, if we
grab a page reference to something kmalloc'ed, holding onto that
reference is not enough to make the access to data safe in any sense
other than "it won't oops on you".  kfree() won't care about the
elevated page refcount and kmalloc() after that kfree() might reuse
the same memory.  That's the main reason why iov_iter_get_pages()
on ITER_KVEC is a non-starter - too dangerous.  We can find the
underlying pages, but we shouldn't grab references to those;
the caller must make sure that object will not be freed until
after the async access ends (by arranging a suitable completion
callback of some sort, etc.)

	* iov_iter_get_pages...() is the only place where we find
the underlying pages.  All other primitives are synchronous -
they need pages to be alive and in a suitable state for access
at the moment they are called, but that's it.

	* page references obtained from iov_iter_get_pages...() can
end up in various places.  No, it's not just bio - not even close
to that.  Any place where we might retain those references for
async work MUST have a way to tell whether the reference is counting
and whether we should do unpin_user_page when we are done.  This
really needs to be audited.  We need to understand where those
page references might end up and how can the caller tell when
async access is finished.
	Note that one of those places is skb fragment list; MSG_ZEROCOPY
sendmsg() can and will stick page references in there.  "managed" shite
tries to deal with that.  I'm not fond of the way it's done, to put it mildly.
It _might_ cope with everything io-uring throws at it at the moment,
but the whole skb_zcopy_downgrade_managed() thing is asking for
trouble.  Again, randomly deciding to go grab a reference to
a page we got from fuck knows where is a bad, bad idea.

	BTW, for some taste of the fun involved in that audit,
try to track the call chains leading to osd_req_op_extent_osd_data_bvec_pos()
and see what pages might end up stuffed into ceph_osd_data by it; later
(possibly much later) those will be stuffed into ITER_BVEC msg->msg_iter...
You'll come to hate drivers/block/rbd.c long before you are done with
that ;-/


	AFAICS, we need the following:

1) audit all places where we stuff something into ITER_BVEC/ITER_XARRAY.
I've some of that done (last cycle, so it might have been invalidated),
but some really scary ones remain (ceph and nfs transport, mostly).

2) audit all places where iov_iter_get_pages...() gets called, in order
to find out where page references go and when are they dropped by the
current mainline.  Note that there's a non-trivial interplay with
ITER_BVEC audit - those pages can be used to populate an ITER_BVEC iterator
*and* ITER_BVEC iterators can end up being passed to iov_iter_get_pages...().
NOTE: in some cases we have logics for coalescing adjacent subranges of
the same page; that can get interesting if we might end up mixing references
of different sorts there (some pinning, some not).  AFAICS that should
never happen for bio, but I'm not certain about e.g. nfs pagelists.

My preference for iov_iter_get_pages...() replacement would be to have
it do
	pin_user_pages() if it's a data-destination user-backed iterator
	get_user_pages() if it's a data-source user-backed iterator
	just return the fucking struct page * if it's not user-backed.
Caller of iov_iter_get_pages...() replacement should be aware of the
kind of iterator it's dealing with, on the level of "is it user-backed"
and "is it data-destination".  It needs that to decide what to do with
the page references when we are done with them.  Blind grabbing refcount
on pages from ITER_BVEC is a bad idea.

Another issue with iov_iter_get_pages...() is that compound page turns
into a bunch of references to individual subpages; io-uring folks have
noticed the problem, but their solution is... inelegant.  I wonder if
we would be better off with a variant of the primitive that would give
out compound pages; it would need different calling conventions,
obviously (current ones assume that all pages except the first and
the last one have PAGE_SIZE worth of data in them).

Some questions from partial ITER_BVEC/ITER_XARRAY audit I'd done last
cycle:

Can we assume that all pages involved ->issue_read() are supposed to be
locked by the caller?  netfs question, so that's over to dhowells...

What protects pages involved in ITER_XARRAY iterator created by
afs_read_dir()?  Note that we are not guaranteed inode_lock() on
the directory in question...

What is guaranteed for the pages involved in ceph transport?  I have
not managed to get through the call graph for that stuff - too deep,
varied and nasty; besides, there's some work from jlayton in the
area, so...

io_import_fixed() sets ITER_BVEC over pinned pages; see io_pin_pages() for
the place where that's done.  A scary question is what prevents an early
unpin of those...

vring: fuck knows.  We have physical addresses stored and we work with
pfn_to_page() results.  Insertion is up to users of those primitives and
so's the exclusion of use vs. removals.  Hell knows what they store there
and what kind of exclusion (if any) are they using.  It is *not* uniform.
Note that if we can get a userland page there, we have to deal with more
than just the primitive that calls copy_to_iter() - there's one right
next to it doing kmap_atomic() + modify + unmap, with no reference to
any iov_iter.  And it has exact same needs as copy_to_iter()
in that respect...  I don't know the vdpa stuff anywhere near well enough,
unfortunately.

FWIW, I've ported #work.iov_iter on top of 6.1-rc1; let's use that
as base point for any further work in those directions.

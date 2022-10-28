Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B794661194F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Oct 2022 19:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbiJ1Rc5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Oct 2022 13:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbiJ1Rcz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Oct 2022 13:32:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08117229E75
        for <linux-fsdevel@vger.kernel.org>; Fri, 28 Oct 2022 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666978321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ikRTQo6sOithFryPWHHzIw99WN08I3Pmt2+5koS/TIs=;
        b=b6nrOsFcyW/hqT0iCJl3lCUdGgMjS1TdMo6ZEfFtLPGApQb1I7qoaAbQu8Osb+gUMivz1u
        FlX2xjntyhffOXeQIDOn/NN0ku3ejiatZsFkjlr1xbWaksbV3aNLpaw6IyD25KQx+Uv4eq
        BB6eKMdV2nE+r/WwZUxlSAmrJPPFGa0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-380-fgfErVm0OSaSsgKAahsI8g-1; Fri, 28 Oct 2022 13:31:57 -0400
X-MC-Unique: fgfErVm0OSaSsgKAahsI8g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 73E3785A583;
        Fri, 28 Oct 2022 17:31:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF74F492B06;
        Fri, 28 Oct 2022 17:31:54 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Y1btOP0tyPtcYajo@ZenIV>
References: <Y1btOP0tyPtcYajo@ZenIV> <Y01VjOE2RrLVA2T6@infradead.org> <1762414.1665761217@warthog.procyon.org.uk> <1415915.1666274636@warthog.procyon.org.uk> <Y1an1NFcowiSS9ms@infradead.org>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     dhowells@redhat.com, Christoph Hellwig <hch@infradead.org>,
        willy@infradead.org, dchinner@redhat.com,
        Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, torvalds@linux-foundation.org,
        linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jlayton@redhat.com
Subject: Re: How to convert I/O iterators to iterators, sglists and RDMA lists
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <67141.1666978314.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Fri, 28 Oct 2022 18:31:54 +0100
Message-ID: <67142.1666978314@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> wrote:

> 	* try to implement heterogeneous iov_iter, with mix of (at
> least) kvec and bvec parts.  Fucking nightmare, IMO, and anything
> similar to iov_iter_get_pages() on those will have an insane
> semantics.

An "iterator of iterators" might be the easiest way to do that, where the
iterator has an array of other iterators of diverse types and advances thr=
ough
them.  Sounds a bit mad, though.

> 	We can do separate sendmsg() for kvec and bvec parts,
> but that doesn't come for free either.  *AND* bvec part is very
> likely not the original iterator we got those pages from.

Cifs, for example, does that.  A cifs data packet consists of some kvec-ty=
pe
things surrounding a data object, currently a list of pages, passed one at=
 a
time to sendmsg/recvmsg.  I'm trying to change the list of pages thing to =
use
iterators right down to the socket, but I then end up with {kvec,xarray,kv=
ec}
type things in the most common case.

> Unless I'm misunderstanding dhowells, that's not too dissimilar to
> the reasons behind his proposed primitive...

Yes.

> My problem with all that stuff is that we ought to sort out the
> lifetime and pin_user issues around the iov_iter.  What I really
> want to avoid is "no worries, we'd extracted stuff into ITER_BVEC, it's
> stable and can be passed around in arbitrary way" kind of primitive.
> Because *that* has no chance to work.

What I'm intending to do in netfslib is just use an ITER_BVEC as a list of
{page,off,len} tuples.  The netfs_io_request struct is used to manage the
lifetime of the pages.

Having dicussed this with you and Willy, I can make it pin/unpin the pages=
 in
an IOBUF/UBUF if appropriate to the I/O environment rather than ref get/pu=
t -
but it means doing something other than iov_iter_get_pages2().  I could ad=
d an
iov_iter_pin_pages2() or pass FOLL_* flags into __iov_iter_get_pages_alloc=
()
and wrappers, say.

> 	* page references put into ITER_BVEC (and ITER_XARRAY) must not
> go away while the iov_iter is being used.  That's on the creator of
> iov_iter.

Yep.

> 	* pages found in iterator might be used past the lifetime of
> iterator.  We need the underlying pages to survive until the last
> use.  "Grab a page reference" is *NOT* a solution in general case.

Yep, but I need to understand where I need to use pinning rather than ref'=
ing.

> 	* pages found in data-destination iterator may have their
> contents modified, both during the iterator lifetime and asynchronously.
> If it has a chance to be a user-mapped page, we must either
> 	a) have it locked by caller and have no modifications after
> it gets unlocked or
> 	b) have it pinned (sensu pin_user_pages()) by the caller and
> have no modifications until the unpin_user_page().

I can do the pinning, sure, if I have the API to do that.

I guess I'd need to trap page_mkwrite() to prevent modifications - though =
both
cifs and nfs seem to currently allow modifications of pinned pages to take
place during I/O under certain conditions.

> 	* page references obtained from iov_iter_get_pages...() can
> end up in various places.  No, it's not just bio - not even close
> to that.  Any place where we might retain those references for
> async work MUST have a way to tell whether the reference is counting
> and whether we should do unpin_user_page when we are done.  This
> really needs to be audited.  We need to understand where those
> page references might end up and how can the caller tell when
> async access is finished.
> 	Note that one of those places is skb fragment list; MSG_ZEROCOPY
> sendmsg() can and will stick page references in there. ...

Good point.  I was considering adding zerocopy for afs/rxrpc - but I proba=
bly
need to think more on that.

> 	AFAICS, we need the following:
> =

> 1) audit all places where we stuff something into ITER_BVEC/ITER_XARRAY.
> I've some of that done (last cycle, so it might have been invalidated),
> but some really scary ones remain (ceph and nfs transport, mostly).

We're trying to get the ceph bits up into netfslib - at least then it'll b=
e
common between 9p, afs, ceph and cifs.

> 2) audit all places where iov_iter_get_pages...() gets called, in order
> to find out where page references go and when are they dropped by the
> current mainline.  Note that there's a non-trivial interplay with
> ITER_BVEC audit - those pages can be used to populate an ITER_BVEC itera=
tor
> *and* ITER_BVEC iterators can end up being passed to iov_iter_get_pages.=
..().
> NOTE: in some cases we have logics for coalescing adjacent subranges of
> the same page; that can get interesting if we might end up mixing refere=
nces
> of different sorts there (some pinning, some not).  AFAICS that should
> never happen for bio, but I'm not certain about e.g. nfs pagelists.
> =

> My preference for iov_iter_get_pages...() replacement would be to have
> it do
> 	pin_user_pages() if it's a data-destination user-backed iterator
> 	get_user_pages() if it's a data-source user-backed iterator

Okay - sounds like what I was expecting.  I need to fix my cifs patches to=
 do
this correctly.

> 	just return the fucking struct page * if it's not user-backed.
> Caller of iov_iter_get_pages...() replacement should be aware of the
> kind of iterator it's dealing with, on the level of "is it user-backed"
> and "is it data-destination".  It needs that to decide what to do with
> the page references when we are done with them.  Blind grabbing refcount
> on pages from ITER_BVEC is a bad idea.

Is it worth making iov_iter_get/pin_user_pages() only work with ITER_IOVEC=
 and
ITER_UBUF and disallow the rest?

> Another issue with iov_iter_get_pages...() is that compound page turns
> into a bunch of references to individual subpages; io-uring folks have
> noticed the problem, but their solution is... inelegant.  I wonder if
> we would be better off with a variant of the primitive that would give
> out compound pages; it would need different calling conventions,
> obviously (current ones assume that all pages except the first and
> the last one have PAGE_SIZE worth of data in them).

One of the problems there is that the kmap functions only handles individu=
al
pages.  Willy has a patch that allows you to vmap a whole folio on a highm=
em
machine (just a bit of maths on a non-highmem machine), but that might nee=
d to
do memory allocation...

> Some questions from partial ITER_BVEC/ITER_XARRAY audit I'd done last
> cycle:
> =

> Can we assume that all pages involved ->issue_read() are supposed to be
> locked by the caller?  netfs question, so that's over to dhowells...

If the pages come from the pagecache, then yes, they're locked; if they're=
 in
a private bounce buffer created by netfslib, then no, they're not.  Howeve=
r,
the network filesystem tells netfslib when it's done or partially done and
leaves the unlocking, unref'ing, unpinning or whatever to netfslib.  netfs=
lib
has somewhere to store the appropriate state.

> What protects pages involved in ITER_XARRAY iterator created by
> afs_read_dir()?  Note that we are not guaranteed inode_lock() on
> the directory in question...

Yeah - that needs fixing.  The size of the data can change, but I don't up=
date
the iterator.  There is an rwsem preventing the data from being reread,
though, whilst we're scanning it.

> What is guaranteed for the pages involved in ceph transport?  I have
> not managed to get through the call graph for that stuff - too deep,
> varied and nasty; besides, there's some work from jlayton in the
> area, so...

We're trying to make it such that we can pass the iterator that netfslib
generates down to libceph.

David


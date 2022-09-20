Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AA365BDBF6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Sep 2022 07:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229954AbiITFCh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Sep 2022 01:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiITFCg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Sep 2022 01:02:36 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBFE4DB56;
        Mon, 19 Sep 2022 22:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WWsG0+LZrxnW59UzoCcj+3EXfyXw/f0UtVdLjoOyJp0=; b=N01ZNB1Gu32KMSKgzDSCu4Ud8o
        +XmIyt4V8lgiODAZV1NUvj9VFuqEU5Qmvx4LqEc1oMW4EFiTE5eQfNhft+V/58kf/1ZW9l7dugGyZ
        khNKOMyOXozX42pUVfsD7smUHVaFIPOWt7bjJ4FdWysgRL/2guWzAWfMWcnD/JUFsEd5nA5ZiXZFH
        d5aU2wk5XRgE4wF0zoDLJUu5Nq1KG9u5OHjv/zFAi4IN4s6Q+bFwCC33E5e/GgHYUVPip34wKQxPx
        dlXe9OVYjL/Kwb2eohMk6a3TC2jm2WN4/J7SvMgG+tr5G6FjS7G/i3swQTQvHyxWAw71guMkwaocw
        fSZl0Zzg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.96 #2 (Red Hat Linux))
        id 1oaVOd-001Vio-0H;
        Tue, 20 Sep 2022 05:02:11 +0000
Date:   Tue, 20 Sep 2022 06:02:11 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] iov_iter: new iov_iter_pin_pages*() routines
Message-ID: <YylJU+BKw5R8u7dw@ZenIV>
References: <YxbtF1O8+kXhTNaj@infradead.org>
 <103fe662-3dc8-35cb-1a68-dda8af95c518@nvidia.com>
 <Yxb7YQWgjHkZet4u@infradead.org>
 <20220906102106.q23ovgyjyrsnbhkp@quack3>
 <YxhaJktqtHw3QTSG@infradead.org>
 <YyFPtTtxYozCuXvu@ZenIV>
 <20220914145233.cyeljaku4egeu4x2@quack3>
 <YyIEgD8ksSZTsUdJ@ZenIV>
 <20220915081625.6a72nza6yq4l5etp@quack3>
 <YyPXqfyf37CUbOf0@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YyPXqfyf37CUbOf0@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 16, 2022 at 02:55:53AM +0100, Al Viro wrote:
> 	* READ vs. WRITE turned out to be an awful way to specify iov_iter
> data direction.  Local iov_iter branch so far:
> 	get rid of unlikely() on page_copy_sane() calls
> 	csum_and_copy_to_iter(): handle ITER_DISCARD
> 	[s390] copy_oldmem_kernel() - WRITE is "data source", not destination
> 	[fsi] WRITE is "data source", not destination...
> 	[infiniband] READ is "data destination", not source...
> 	[s390] zcore: WRITE is "data source", not destination...
> 	[target] fix iov_iter_bvec() "direction" argument
> 	[vhost] fix 'direction' argument of iov_iter_{init,bvec}()
> 	[xen] fix "direction" argument of iov_iter_kvec()
> 	[trace] READ means "data destination", not source...
> 	iov_iter: saner checks for attempt to copy to/from iterator
> 	use less confusing names for iov_iter direction initializers
> those 8 commits in the middle consist of fixes, some of them with more than
> one call site affected.  Folks keep going "oh, we are going to copy data
> into that iterator, must be WRITE".  Wrong - WRITE means "as for write(2)",
> i.e. the data _source_, not data destination.  And the same kind of bugs
> goes in the opposite direction, of course.
> 	I think something like ITER_DEST vs. ITER_SOURCE would be less
> confusing.
> 
> 	* anything that goes with ITER_SOURCE doesn't need pin.
> 	* ITER_IOVEC/ITER_UBUF need pin for get_pages and for nothing else.
> Need to grab reference on get_pages, obviously.
> 	* even more obviously, ITER_DISCARD is irrelevant here.
> 	* ITER_PIPE only modifies anonymous pages that had been allocated
> by iov_iter primitives and hadn't been observed by anything outside until
> we are done with said ITER_PIPE.
> 	* quite a few instances are similar to e.g. REQ_OP_READ handling in
> /dev/loop - we work with ITER_BVEC there and we do modify the page contents,
> but the damn thing would better be given to us locked and stay locked until
> all involved modifications (be it real IO/decoding/whatever) is complete.
> That ought to be safe, unless I'm missing something.
> 
> That doesn't cover everything; still going through the list...

More:

nvme target: nvme read requests end up with somebody allocating and filling
sglist, followed by reading from file into it (using ITER_BVEC).  Then the
pages are sent out, presumably.  I would be very surprised if it turned out
to be anything other than anon pages allocated by the driver, but I'd like
to see that confirmed by nvme folks.  Probably doesn't need pinning.

->read_folio() instances - page locked by caller, not unlocked until we are done.

->readahead() instances - pages are in the segment of page cache that had been
populated and locked by the caller; some are ITER_BVEC (with page(s) extracted
by readahead_page()), some - ITER_XARRAY.
other similar places (some of ->write_begin() instances, after having grabbed
a locked page, etc.)

->issue_read() instances - the call graph is scary (in particular, recursion
prevention there is non-obvious), but unless netfs folks say otherwise, I'd
assume that all pages involved are supposed to be locked by the caller.
swap reads (ending up at __swap_read_unplug()) - pages locked by callers.

in some cases (cifs) pages are privately allocated and not visible to anyone
else.

io_import_fixed() sets ITER_BVEC over pinned pages; see io_pin_pages() for
the place where that's done.

In cifs_send_async_read() we take the pages that will eventually go into
ITER_BVEC iterator from iov_iter_get_pages() - that one wants pinning if
the type of ctx->iter would demand so.  The same goes for setup_aio_ctx_iter() -
iov_iter_get_pages() is used to make an ITER_BVEC counterpart of the
iov_iter passed to ->read_iter(), with the same considerations re pinning.
The same goes for ceph __iter_get_bvecs().

Haven't done yet:

drivers/target/target_core_file.c:292:  iov_iter_bvec(&iter, is_write, aio_cmd->bvecs, sgl_nents, len);
drivers/vhost/vringh.c:1198:            iov_iter_bvec(&iter, ITER_DEST, iov, ret, translated);
fs/afs/dir.c:308:       iov_iter_xarray(&req->def_iter, ITER_DEST, &dvnode->netfs.inode.i_mapping->i_pages,
net/ceph/messenger_v1.c:52:     iov_iter_bvec(&msg.msg_iter, ITER_DEST, &bvec, 1, length);
net/ceph/messenger_v2.c:236:    iov_iter_bvec(&con->v2.in_iter, ITER_DEST, &con->v2.in_bvec, 1, bv->bv_len);
net/sunrpc/svcsock.c:263:       iov_iter_bvec(&msg.msg_iter, ITER_DEST, bvec, i, buflen);
net/sunrpc/xprtsock.c:376:      iov_iter_bvec(&msg->msg_iter, ITER_DEST, bvec, nr, count);

The picture so far looks like we mostly need to take care of pinning when
we obtain the references from iov_iter_get_pages().  What's more, it looks
like ITER_BVEC/ITER_XARRAY/ITER_PIPE we really don't need to pin anything on
get_pages/pin_pages - they are already protected (or, in case of ITER_PIPE,
allocated by iov_iter itself and not reachable by anybody outside).
Might or might not be true for the remaining 7 call sites...

NOTE: all of the above assumes that callers with pre-locked pages are
either synchronous or do not unlock until the completion callbacks.
It does appear to be true; if it is true, I really wonder if we need
to even grab references in iov_iter_pin_pages() for anything other
than ITER_IOVEC/ITER_UBUF.  The right primitive might be
	if user-backed
		pin pages
	else
		just copy the pointers; any lifetime-related issues are
		up to the caller.
	advance iterator in either case


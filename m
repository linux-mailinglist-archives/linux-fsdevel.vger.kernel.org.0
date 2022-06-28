Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C08155CF22
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jun 2022 15:06:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344426AbiF1MZS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jun 2022 08:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244736AbiF1MZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:25:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9CC22B2D
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 05:25:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B17A5B81DFC
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Jun 2022 12:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90FFCC3411D;
        Tue, 28 Jun 2022 12:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656419112;
        bh=Vcg7RrBc6DTmnscaJcX4dti2M41VVbtXM+knlLvKULA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=mRg0h/AH/DeI1KvZy0RFFJPzF0CXsi+GS/bQayKseezVWrb620ojXuUoY2xGJlxIc
         ocxftLTxzdv89ev8+M1LigyKSbEKzlvN6v7USIXm1Clssz5kBbqU3JREVeM41agsul
         Bowll6PtdXh+J609x5lDKb7Q5LhPsnSpi6tgyuv30MlBaLQoUpoqOAmqFLz9Fakj8X
         PDwJ8tOaNN/8RR/pGUl1jVk7WolMf2aRURfBkHYQAJLtRYVbA8ItbGCLP2IG+EH+TV
         cKafkU9lhl07c9LgHycU8BmY3Iss0L/LER+wDKK/hks+QgACsDO0NiSzWlMKydVh6I
         87NePWbF6ROBA==
Message-ID: <3077f1e1943ac906225f5e6ba4b6fbd17291423e.camel@kernel.org>
Subject: Re: [RFC][CFT][PATCHSET] iov_iter stuff
From:   Jeff Layton <jlayton@kernel.org>
To:     Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Brauner <brauner@kernel.org>
Date:   Tue, 28 Jun 2022 08:25:10 -0400
In-Reply-To: <YrKWRCOOWXPHRCKg@ZenIV>
References: <YrKWRCOOWXPHRCKg@ZenIV>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2022-06-22 at 05:10 +0100, Al Viro wrote:
> 	There's a bunch of pending iov_iter-related work; most of that had
> been posted, but only one part got anything resembling a review.  Current=
ly
> it seems to be working, but it obviously needs review and testing.
>=20
> 	It's split into several subseries; the entire series can be observed
> as v5.19-rc2..#work.iov_iter_get_pages.  Description follows; individual
> patches will be posted^Wmailbombed in followups.
>=20
> 	This stuff is not in -next yet; I'd like to put it there, so if you
> see any problems - please yell.
>=20
> 	One thing not currently in there, but to be added very soon is
> iov_iter_find_pages{,_alloc}() - analogue of iov_iter_get_pages(), except=
 that
> it only grabs page references for userland-backed flavours.  The callers,
> of course, are responsible for keeping the underlying object(s) alive for=
 as
> long as they are using the results.  Quite a few of iov_iter_get_pages()
> callers would be fine with that.  Moreover, unlike iov_iter_get_pages() t=
his
> could be allowed for ITER_KVEC, potentially eliminating several places wh=
ere
> we special-case the treatment of ITER_KVEC.
>=20
> 	Another pending thing is integration with cifs and ceph series (dhowells
> and jlayton resp.) and probably io_uring as well.
>=20
> -------------------------------------------------------------------------=
---
>=20
> 	Part 1, #work.9p: [rc1-based]
>=20
> 1/44: 9p: handling Rerror without copy_from_iter_full()
> 	Self-contained fix, should be easy to backport.  What happens
> there is that arrival of Rerror in response to zerocopy read or readdir
> ends up with error string in the place where the actual data would've gon=
e
> in case of success.  It needs to be extracted, and copy_from_iter_full()
> is only for data-source iterators, not for e.g. ITER_PIPE.  And ITER_PIPE
> can be used with those...
>=20
> -------------------------------------------------------------------------=
---
>=20
> 	Part 2, #work.iov_iter: [rc1-based]
>=20
> Dealing with the overhead in new_sync_read()/new_sync_write(), mostly.
> Several things there - one is that calculation of iocb flags can be
> made cheaper, another is that single-segment iovec is sufficiently
> common to be worth turning into a new iov_iter flavour (ITER_UBUF).
> With all that, the total size of iov_iter.c goes down, mostly due to
> removal of magic in iovec copy_page_to_iter()/copy_page_from_iter().
> Generic variant works for those nowadays...
>=20
> This had been posted two weeks ago, got a reasonable amount of comments.
>=20
> 2/44: No need of likely/unlikely on calls of check_copy_size()
> 	not just in uio.h; the thing is inlined and it has unlikely on
> all paths leading to return false
>=20
> 3/44:  teach iomap_dio_rw() to suppress dsync
> 	new flag for iomap_dio_rw(), telling it to suppress generic_write_sync()
>=20
> 4/44: btrfs: use IOMAP_DIO_NOSYNC
> 	use the above instead of currently used kludges.
>=20
> 5/44: struct file: use anonymous union member for rcuhead and llist
> 	"f_u" might have been an amusing name, but... we expect anon unions to
> work.
>=20
> 6/44: iocb: delay evaluation of IS_SYNC(...) until we want to check IOCB_=
DSYNC
> 	makes iocb_flags() much cheaper, and it's easier to keep track of
> the places where it can change.
>=20
> 7/44: keep iocb_flags() result cached in struct file
> 	that, along with the previous commit, reduces the overhead of
> new_sync_{read,write}().  struct file doesn't grow - we can keep that
> thing in the same anon union where rcuhead and llist live; that field
> gets used only before ->f_count reaches zero while the other two are
> used only after ->f_count has reached zero.
>=20
> 8/44: copy_page_{to,from}_iter(): switch iovec variants to generic
> 	kmap_local_page() allows that.  And it kills quite a bit of
> code.
>=20
> 9/44: new iov_iter flavour - ITER_UBUF
> 	iovec analogue, with single segment.  That case is fairly common and it
> can be handled with less overhead than full-blown iovec.
>=20
> 10/44: switch new_sync_{read,write}() to ITER_UBUF
> 	... and this is why it is so common.  Further reduction of overhead
> for new_sync_{read,write}().
>=20
> 11/44: iov_iter_bvec_advance(): don't bother with bvec_iter
> 	AFAICS, variant similar to what we do for iovec/kvec generates better
> code.  Needs profiling, obviously.
>=20
> -------------------------------------------------------------------------=
---
>=20
> 	Part 3, #fixes [-rc2-based]
>=20
> 12/44: fix short copy handling in copy_mc_pipe_to_iter()
> 	Minimal version of fix; it's replaced with prettier one in the next
> series, but replacement is not a backport fodder.
>=20
> -------------------------------------------------------------------------=
---
>=20
> 	Part 4, #work.ITER_PIPE [on top of merge of previous branches]
>=20
> ITER_PIPE handling had never been pretty, but by now it has become
> really obfuscated and hard to read.  Untangle it a bit.  Posted last
> weekend, some brainos fixed since then.
>=20
> 13/44: splice: stop abusing iov_iter_advance() to flush a pipe
> 	A really odd (ab)use of iov_iter_advance() - in case of error
> generic_file_splice_read() wants to free all pipe buffers ->read_iter()
> has produced.  Yes, forcibly resetting ->head and ->iov_offset to
> original values and calling iov_iter_advance(i, 0) will trigger
> pipe_advance(), which will trigger pipe_truncate(), which will free
> buffers.  Or we could just go ahead and free the same buffers;
> pipe_discard_from() does exactly that, no iov_iter stuff needs to
> be involved.
>=20
> 14/44: ITER_PIPE: helper for getting pipe buffer by index
> 	In a lot of places we want to find pipe_buffer by index;
> expression is convoluted and hard to read.  Provide an inline helper
> for that, convert trivial open-coded cases.  Eventually *all*
> open-coded instances in iov_iter.c will be gone.
>=20
> 15/44: ITER_PIPE: helpers for adding pipe buffers
>         There are only two kinds of pipe_buffer in the area used by ITER_=
PIPE.
> * anonymous - copy_to_iter() et.al. end up creating those and copying dat=
a
>   there.  They have zero ->offset, and their ->ops points to
>   default_pipe_page_ops.
> * zero-copy ones - those come from copy_page_to_iter(), and page comes fr=
om
>   caller.  ->offset is also caller-supplied - it might be non-zero.
>   ->ops points to page_cache_pipe_buf_ops.
>         Move creation and insertion of those into helpers -
> push_anon(pipe, size) and push_page(pipe, page, offset, size) resp., sepa=
rating
> them from the "could we avoid creating a new buffer by merging with the c=
urrent
> head?" logics.
>=20
> 16/44: ITER_PIPE: allocate buffers as we go in copy-to-pipe primitives
>         New helper: append_pipe().  Extends the last buffer if possible,
> allocates a new one otherwise.  Returns page and offset in it on success,
> NULL on failure.  iov_iter is advanced past the data we've got.
>         Use that instead of push_pipe() in copy-to-pipe primitives;
> they get simpler that way.  Handling of short copy (in "mc" one)
> is done simply by iov_iter_revert() - iov_iter is in consistent
> state after that one, so we can use that.
>=20
> 17/44: ITER_PIPE: fold push_pipe() into __pipe_get_pages()
>         Expand the only remaining call of push_pipe() (in
> __pipe_get_pages()), combine it with the page-collecting loop there.
> We don't need to bother with i->count checks or calculation of offset
> in the first page - the caller already has done that.
>         Note that the only reason it's not a loop doing append_pipe()
> is that append_pipe() is advancing, while iov_iter_get_pages() is not.
> As soon as it switches to saner semantics, this thing will switch
> to using append_pipe().
>=20
> 18/44: ITER_PIPE: lose iter_head argument of __pipe_get_pages()
> 	Redundant.
>=20
> 19/44: ITER_PIPE: clean pipe_advance() up
>         Don't bother with pipe_truncate(); adjust the buffer
> length just as we decide it'll be the last one, then use
> pipe_discard_from() to release buffers past that one.
>=20
> 20/44: ITER_PIPE: clean iov_iter_revert()
>         Fold pipe_truncate() in there, clean the things up.
>=20
> 21/44: ITER_PIPE: cache the type of last buffer
>         We often need to find whether the last buffer is anon or not, and
> currently it's rather clumsy:
>         check if ->iov_offset is non-zero (i.e. that pipe is not empty)
>         if so, get the corresponding pipe_buffer and check its ->ops
>         if it's &default_pipe_buf_ops, we have an anon buffer.
> Let's replace the use of ->iov_offset (which is nowhere near similar to
> its role for other flavours) with signed field (->last_offset), with
> the following rules:
>         empty, no buffers occupied:             0
>         anon, with bytes up to N-1 filled:      N
>         zero-copy, with bytes up to N-1 filled: -N
> That way abs(i->last_offset) is equal to what used to be in i->iov_offset
> and empty vs. anon vs. zero-copy can be distinguished by the sign of
> i->last_offset.
>         Checks for "should we extend the last buffer or should we start
> a new one?" become easier to follow that way.
>         Note that most of the operations can only be done in a sane
> state - i.e. when the pipe has nothing past the current position of
> iterator.  About the only thing that could be done outside of that
> state is iov_iter_advance(), which transitions to the sane state by
> truncating the pipe.  There are only two cases where we leave the
> sane state:
>         1) iov_iter_get_pages()/iov_iter_get_pages_alloc().  Will be
> dealt with later, when we make get_pages advancing - the callers are
> actually happier that way.
>         2) iov_iter copied, then something is put into the copy.  Since
> they share the underlying pipe, the original gets behind.  When we
> decide that we are done with the copy (original is not usable until then)
> we advance the original.  direct_io used to be done that way; nowadays
> it operates on the original and we do iov_iter_revert() to discard
> the excessive data.  At the moment there's nothing in the kernel that
> could do that to ITER_PIPE iterators, so this reason for insane state
> is theoretical right now.
>=20
> 22/44: ITER_PIPE: fold data_start() and pipe_space_for_user() together
>         All their callers are next to each other; all of them want
> the total amount of pages and, possibly, the offset in the partial
> final buffer.
>         Combine into a new helper (pipe_npages()), fix the
> bogosity in pipe_space_for_user(), while we are at it.
>=20
> -------------------------------------------------------------------------=
---
>=20
> 	Part 5, #work.unify_iov_iter_get_pages [on top of previous]
>=20
> iov_iter_get_pages() and iov_iter_get_pages_alloc() have a lot of code
> duplication and are bloody hard to read.  With some massage duplication
> can be eliminated, along with some of the cruft accumulated there.
>=20
> 	Flavour-independent arguments validation and, for ..._alloc(),
> cleanup handling on failure:
> 23/44: iov_iter_get_pages{,_alloc}(): cap the maxsize with MAX_RW_COUNT
> 24/44: iov_iter_get_pages_alloc(): lift freeing pages array on failure ex=
its into wrapper
> 25/44: iov_iter_get_pages(): sanity-check arguments
>=20
> 	Mechanically merge parallel ..._get_pages() and ..._get_pages_alloc().
> 26/44: unify pipe_get_pages() and pipe_get_pages_alloc()
> 27/44: unify xarray_get_pages() and xarray_get_pages_alloc()
> 28/44: unify the rest of iov_iter_get_pages()/iov_iter_get_pages_alloc() =
guts
>=20
> 	Decrufting for XARRAY:
> 29/44: ITER_XARRAY: don't open-code DIV_ROUND_UP()
>=20
> 	Decrufting for UBUF/IOVEC/BVEC: that bunch suffers from really convolute=
d
> helpers; untangling those takes a bit of care, so I'd carved that up into=
 fairly
> small chunks.  Could be collapsed together, but...
> 30/44: iov_iter: lift dealing with maxpages out of first_{iovec,bvec}_seg=
ment()
> 31/44: iov_iter: first_{iovec,bvec}_segment() - simplify a bit
> 32/44: iov_iter: massage calling conventions for first_{iovec,bvec}_segme=
nt()
> 33/44: found_iovec_segment(): just return address
>=20
> 	Decrufting for PIPE:
> 34/44: fold __pipe_get_pages() into pipe_get_pages()
>=20
> 	Now we can finally get a helper encapsulating the array allocations
> right way:
> 35/44: iov_iter: saner helper for page array allocation
>=20
> -------------------------------------------------------------------------=
---
>=20
> 	Part 6, #work.iov_iter_get_pages-advance [on top of previous]
> Convert iov_iter_get_pages{,_alloc}() to iterator-advancing semantics. =
=20
>=20
> 	Most of the callers follow successful ...get_pages... with advance
> by the amount it had reported.  For some it's unconditional, for some it
> might end up being less in some cases.  All of them would be fine with
> advancing variants of those primitives - those that might want to advance
> by less than reported could easily use revert by the difference of those
> amounts.
> 	Rather than doing a flagday change (they are exported and signatures
> remain unchanged), replacement variants are added (iov_iter_get_pages2()
> and iov_iter_get_pages_alloc2(), initially as wrappers).  By the end of
> the series everything is converted to those and the old ones are removed.
>=20
> 	Makes for simpler rules for ITER_PIPE, among other things, and
> advancing semantics is consistent with all data-copying primitives.
> Series is pretty obvious - introduce variants with new semantics, switch
> users one by one, fold the old variants into new ones.
>=20
> 36/44: iov_iter: advancing variants of iov_iter_get_pages{,_alloc}()
> 37/44: block: convert to advancing variants of iov_iter_get_pages{,_alloc=
}()
> 38/44: iter_to_pipe(): switch to advancing variant of iov_iter_get_pages(=
)
> 39/44: af_alg_make_sg(): switch to advancing variant of iov_iter_get_page=
s()
> 40/44: 9p: convert to advancing variant of iov_iter_get_pages_alloc()
> 41/44: ceph: switch the last caller of iov_iter_get_pages_alloc()
> 42/44: get rid of non-advancing variants
>=20
> -------------------------------------------------------------------------=
---
>=20
> 	Part 7, #wort.iov_iter_get_pages [on top of previous]
> Trivial followups, with more to be added here...
>=20
> 43/44: pipe_get_pages(): switch to append_pipe()
> 44/44: expand those iov_iter_advance()...
>=20
> Overall diffstat:
>=20
>  arch/powerpc/include/asm/uaccess.h |   2 +-
>  arch/s390/include/asm/uaccess.h    |   4 +-
>  block/bio.c                        |  15 +-
>  block/blk-map.c                    |   7 +-
>  block/fops.c                       |   8 +-
>  crypto/af_alg.c                    |   3 +-
>  crypto/algif_hash.c                |   5 +-
>  drivers/nvme/target/io-cmd-file.c  |   2 +-
>  drivers/vhost/scsi.c               |   4 +-
>  fs/aio.c                           |   2 +-
>  fs/btrfs/file.c                    |  19 +-
>  fs/btrfs/inode.c                   |   3 +-
>  fs/ceph/addr.c                     |   2 +-
>  fs/ceph/file.c                     |   5 +-
>  fs/cifs/file.c                     |   8 +-
>  fs/cifs/misc.c                     |   3 +-
>  fs/direct-io.c                     |   7 +-
>  fs/fcntl.c                         |   1 +
>  fs/file_table.c                    |  17 +-
>  fs/fuse/dev.c                      |   7 +-
>  fs/fuse/file.c                     |   7 +-
>  fs/gfs2/file.c                     |   2 +-
>  fs/io_uring.c                      |   2 +-
>  fs/iomap/direct-io.c               |  21 +-
>  fs/nfs/direct.c                    |   8 +-
>  fs/open.c                          |   1 +
>  fs/read_write.c                    |   6 +-
>  fs/splice.c                        |  54 +-
>  fs/zonefs/super.c                  |   2 +-
>  include/linux/fs.h                 |  21 +-
>  include/linux/iomap.h              |   6 +
>  include/linux/pipe_fs_i.h          |  29 +-
>  include/linux/uaccess.h            |   4 +-
>  include/linux/uio.h                |  50 +-
>  lib/iov_iter.c                     | 993 ++++++++++++++-----------------=
------
>  mm/shmem.c                         |   2 +-
>  net/9p/client.c                    | 125 +----
>  net/9p/protocol.c                  |   3 +-
>  net/9p/trans_virtio.c              |  37 +-
>  net/core/datagram.c                |   3 +-
>  net/core/skmsg.c                   |   3 +-
>  net/rds/message.c                  |   3 +-
>  net/tls/tls_sw.c                   |   4 +-
>  43 files changed, 599 insertions(+), 911 deletions(-)

I ported the CEPH_MSG_DATA_ITER patches on top of this, and ran ceph
through xfstests and it seemed to do just fine. You can add:

Tested-by: Jeff Layton <jlayton@kernel.org>

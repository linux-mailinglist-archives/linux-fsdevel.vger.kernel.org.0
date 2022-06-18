Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ACE5502EC
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Jun 2022 07:35:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiFRF1W (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Jun 2022 01:27:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiFRF1V (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Jun 2022 01:27:21 -0400
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [IPv6:2a03:a000:7:0:5054:ff:fe1c:15ff])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803055F26A
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 22:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=linux.org.uk; s=zeniv-20220401; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8gBaV1edNA7YG5QUggA3TCIurGfFM3z34o7F46CSeaM=; b=FkeaQ0Tl0txN7J6THOQpS9Rk9U
        n+W2KHMxUkspBsEQSb/8Ds/ikE5KB/u9G9jfFRBYI472I0LuJE88lHTLQrKQOw6nZkZdLCWkyXfdM
        Z6Pm3ZhGLTUC5K62ZdSg46QLc9QUVJ20kNF2Zstpsgtw+g6Mxc2DvKDv1QqId9LEHioIf4O5Itf6W
        OA13ybGyvKirHI+btfzM6sRvKuloEvHDz3P8lenpgvwNkewVFSrl4PykP7BCPyk0/Vvo5CBvbzOmt
        b5dlVG5XKRC5aSuy5EyohjQ7NFGzVXpRcH3wop/z139fYZzvX3zzC0PPLqUrMXEOINLbVjJAqZgOB
        hq7Q98sA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.95 #2 (Red Hat Linux))
        id 1o2QzM-001VC5-TS;
        Sat, 18 Jun 2022 05:27:17 +0000
Date:   Sat, 18 Jun 2022 06:27:16 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC][PATCHES] iov_iter stuff
Message-ID: <Yq1iNHboD+9fz60M@ZenIV>
References: <Yp7PTZ2nckKDTkKu@zeniv-ca.linux.org.uk>
 <8fb435a4-269d-9675-9a44-d37605c84314@kernel.dk>
 <Yq0EoTzFE+dSAYY1@ZenIV>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yq0EoTzFE+dSAYY1@ZenIV>
Sender: Al Viro <viro@ftp.linux.org.uk>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jun 17, 2022 at 11:48:01PM +0100, Al Viro wrote:
> On Fri, Jun 17, 2022 at 04:30:49PM -0600, Jens Axboe wrote:
> 
> > Al, looks good to me from inspection, and I ported stuffed this on top
> > of -git and my 5.20 branch, and did my send/recv/recvmsg io_uring change
> > on top and see a noticeable reduction there too for some benchmarking.
> > Feel free to add:
> > 
> > Reviewed-by: Jens Axboe <axboe@kernel.dk>
> > 
> > to the series.
> > 
> > Side note - of my initial series I played with, I still have this one
> > leftover that I do utilize for io_uring:
> > 
> > https://git.kernel.dk/cgit/linux-block/commit/?h=for-5.20/io_uring-iter&id=a59f5c21a6eeb9506163c20aff4846dbec159f47
> > 
> > Doesn't make sense standalone, but I have it as a prep patch.
> > 
> > Can I consider your work.iov_iter stable at this point, or are you still
> > planning rebasing?
> 
> Umm...  Rebasing this part - probably no; there's a fun followup to it, though,
> I'm finishing the carve up & reorder at the moment.  Will post for review
> tonight...

	This stuff sits on top of #work.iov_iter (as posted a week ago) +
#fixes (one commit, handling of failures halfway through copy_mc_to_iter()
into ITER_PIPE, posted several days ago, backportable minimal fix) +
#work.9p (handling of RERROR on zerocopy 9P read/readdir, posted about
a week ago).  The branch is #work.iov_iter_get_pages; individual patches
in followups.

	NOTE: the older branches are unchanged, but this series on top of
them had been repeatedly carved up, reordered, etc. - there had been a lot
of recent massage, so at this point it should be treated as absolutely
untested.  It can shit over memory and/or chew your filesystems; DON'T
TRY IT OUTSIDE OF A SCRATCH KVM IMAGE.  Said that, review and (cautious)
testing would be very welcome.

	Part 1: ITER_PIPE cleanups

ITER_PIPE handling had never been pretty, but by now it has become
really obfuscated and hard to read.  Untangle it a bit.

1) splice: stop abusing iov_iter_advance() to flush a pipe
	A really odd (ab)use of iov_iter_advance() - in case of error
generic_file_splice_read() wants to free all pipe buffers ->read_iter()
has produced.  Yes, forcibly resetting ->head and ->iov_offset to
original values and calling iov_iter_advance(i, 0), will trigger
pipe_advance(), which will trigger pipe_truncate(), which will free
buffers.  Or we could just go ahead and free the same buffers;
pipe_discard_from() does exactly that, no iov_iter stuff needs to
be involved.

2) ITER_PIPE: helper for getting pipe buffer by index
	In a lot of places we want to find pipe_buffer by index;
expression is convoluted and hard to read.  Provide an inline helper
for that, convert trivial open-coded cases.  Eventually *all*
open-coded instances in iov_iter.c will get converted.

3) ITER_PIPE: helpers for adding pipe buffers
	There are only two kinds of pipe_buffer in the area used by ITER_PIPE.
* anonymous - copy_to_iter() et.al. end up creating those and copying data
  there.  They have zero ->offset, and their ->ops points to
  default_pipe_page_ops.
* zero-copy ones - those come from copy_page_to_iter(), and page comes from
  caller.  ->offset is also caller-supplied - it might be non-zero.
  ->ops points to page_cache_pipe_buf_ops.
	Move creation and insertion of those into helpers -
push_anon(pipe, size) and push_page(pipe, page, offset, size) resp., separating
them from the "could we avoid creating a new buffer by merging with the current
head?" logics.

4) ITER_PIPE: allocate buffers as we go in copy-to-pipe primitives
	New helper: append_pipe().  Extends the last buffer if possible,
allocates a new one otherwise.  Returns page and offset in it on success,
NULL on failure.  iov_iter is advanced past the data we've got.
	Use that instead of push_pipe() in copy-to-pipe primitives;
they get simpler that way.  Handling of short copy (in "mc" one)
is done simply by iov_iter_revert() - iov_iter is in consistent
state after that one, so we can use that.

5) ITER_PIPE: fold push_pipe() into __pipe_get_pages()
	Expand the only remaining call of push_pipe() (in
__pipe_get_pages()), combine it with the page-collecting loop there.
We don't need to bother with i->count checks or calculation of offset
in the first page - the caller already has done that.
	Note that the only reason it's not a loop doing append_pipe()
is that append_pipe() is advancing, while iov_iter_get_pages() is not.
As soon as it switches to saner semantics, this thing will switch
to using append_pipe().

6) ITER_PIPE: lose iter_head argument of __pipe_get_pages()
	Always equal to pipe->head - 1.

7) ITER_PIPE: clean pipe_advance() up
	Don't bother with pipe_truncate(); adjust the buffer
length just as we decide it'll be the last one, then use
pipe_discard_from() to release buffers past that one.

8) ITER_PIPE: clean iov_iter_revert()
	Fold pipe_truncate() in there, clean the things up.

9) ITER_PIPE: cache the type of last buffer
	We often need to find whether the last buffer is anon or not, and
currently it's rather clumsy:
	check if ->iov_offset is non-zero (i.e. that pipe is not empty)
	if so, get the corresponding pipe_buffer and check its ->ops
	if it's &default_pipe_buf_ops, we have an anon buffer.
Let's replace the use of ->iov_offset (which is nowhere near similar to
its role for other flavours) with signed field (->last_offset), with
the following rules:
	empty, no buffers occupied:		0
	anon, with bytes up to N-1 filled:	N
	zero-copy, with bytes up to N-1 filled:	-N
That way abs(i->last_offset) is equal to what used to be in i->iov_offset
and empty vs. anon vs. zero-copy can be distinguished by the sign of
i->last_offset.
	Checks for "should we extend the last buffer or should we start
a new one?" become easier to follow that way.
	Note that most of the operations can only be done in a sane
state - i.e. when the pipe has nothing past the current position of
iterator.  About the only thing that could be done outside of that
state is iov_iter_advance(), which transitions to the sane state by
truncating the pipe.  There are only two cases where we leave the
sane state:
	1) iov_iter_get_pages()/iov_iter_get_pages_alloc().  Will be
dealt with later, when we make get_pages advancing - the callers are
actually happier that way.
	2) iov_iter copied, then something is put into the copy.  Since
they share the underlying pipe, the original gets behind.  When we
decide that we are done with the copy (original is not usable until then)
we advance the original.  direct_io used to be done that way; nowadays
it operates on the original and we do iov_iter_revert() to discard
the excessive data.  At the moment there's nothing in the kernel that
could do that to ITER_PIPE iterators, so this reason for insane state
is theoretical right now.

10) ITER_PIPE: fold data_start() and pipe_space_for_user() together
	All their callers are next to each other; all of them
want the total amount of pages and, possibly, the
offset in the partial final buffer.
	Combine into a new helper (pipe_npages()), fix the
bogosity in pipe_space_for_user(), while we are at it.

	Part 2: iov_iter_get_pages()/iov_iter_get_pages_alloc() unification

	There's a lot of duplication between iov_iter_get_pages() and
iov_iter_get_pages_alloc().  With some massage it can be eliminated,
along with some of the cruft accumulated there.

	Flavour-independent arguments validation and, for ..._alloc(),
cleanup handling on failure:
11) iov_iter_get_pages{,_alloc}(): cap the maxsize with LONG_MAX
12) iov_iter_get_pages_alloc(): lift freeing pages array on failure exits into wrapper
13) iov_iter_get_pages(): sanity-check arguments

	Mechanically merge parallel ..._get_pages() and ..._get_pages_alloc().
14) unify pipe_get_pages() and pipe_get_pages_alloc()
15) unify xarray_get_pages() and xarray_get_pages_alloc()
16) unify the rest of iov_iter_get_pages()/iov_iter_get_pages_alloc() guts

	Decrufting for XARRAY:
17) ITER_XARRAY: don't open-code DIV_ROUND_UP()
	Decrufting for iBUF/IOVEC/BVEC:
18) iov_iter: lift dealing with maxpages out of first_{iovec,bvec}_segment()
19) iov_iter: massage calling conventions for first_{iovec,bvec}_segment()
20) found_iovec_segment(): just return address
	Decrufting for PIPE:
21) fold __pipe_get_pages() into pipe_get_pages()

	Collapsing the bits that differ for get_pages and get_pages_alloc
cases into a common helper:
22) iov_iter: saner helper for page array allocation

	Part 3: making iov_iter_get_pages{,_alloc}() advancing

	Most of the callers follow successful ...get_pages... with advance
by the amount it had reported.  For some it's unconditional, for some it
might end up being less in some cases.  All of them would be fine with
advancing variants of those primitives - those that might want to advance
by less than reported could easily use revert by the difference of those
amounts.
	Rather than doing a flagday change (they are exported and signatures
remain unchanged), replacement variants are added (iov_iter_get_pages2()
and iov_iter_get_pages_alloc2(), initially as wrappers).  By the end of
the series everything is converted to those and the old ones are removed.

23) iov_iter: advancing variants of iov_iter_get_pages{,_alloc}()
24) block: convert to advancing variants of iov_iter_get_pages{,_alloc}()
25) iter_to_pipe(): switch to advancing variant of iov_iter_get_pages()
26) af_alg_make_sg(): switch to advancing variant of iov_iter_get_pages()
27) 9p: convert to advancing variant of iov_iter_get_pages_alloc()
28) ceph: switch the last caller of iov_iter_get_pages_alloc()
29) get rid of non-advancing variants

	Part 4: cleanups
30) pipe_get_pages(): switch to append_pipe()
31) expand those iov_iter_advance()...

Overall diffstat:

 arch/powerpc/include/asm/uaccess.h |   2 +-
 arch/s390/include/asm/uaccess.h    |   4 +-
 block/bio.c                        |  15 +-
 block/blk-map.c                    |   7 +-
 block/fops.c                       |   8 +-
 crypto/af_alg.c                    |   3 +-
 crypto/algif_hash.c                |   5 +-
 drivers/nvme/target/io-cmd-file.c  |   2 +-
 drivers/vhost/scsi.c               |   4 +-
 fs/aio.c                           |   2 +-
 fs/btrfs/file.c                    |  19 +-
 fs/btrfs/inode.c                   |   3 +-
 fs/ceph/addr.c                     |   2 +-
 fs/ceph/file.c                     |   5 +-
 fs/cifs/file.c                     |   8 +-
 fs/cifs/misc.c                     |   3 +-
 fs/direct-io.c                     |   7 +-
 fs/fcntl.c                         |   1 +
 fs/file_table.c                    |  17 +-
 fs/fuse/dev.c                      |   7 +-
 fs/fuse/file.c                     |   7 +-
 fs/gfs2/file.c                     |   2 +-
 fs/io_uring.c                      |   2 +-
 fs/iomap/direct-io.c               |  21 +-
 fs/nfs/direct.c                    |   8 +-
 fs/open.c                          |   1 +
 fs/read_write.c                    |   6 +-
 fs/splice.c                        |  54 +-
 fs/zonefs/super.c                  |   2 +-
 include/linux/fs.h                 |  21 +-
 include/linux/iomap.h              |   6 +
 include/linux/pipe_fs_i.h          |  29 +-
 include/linux/uaccess.h            |   4 +-
 include/linux/uio.h                |  50 +-
 lib/iov_iter.c                     | 978 ++++++++++++++-----------------------
 mm/shmem.c                         |   2 +-
 net/9p/client.c                    | 125 +----
 net/9p/protocol.c                  |   3 +-
 net/9p/trans_virtio.c              |  37 +-
 net/core/datagram.c                |   3 +-
 net/core/skmsg.c                   |   3 +-
 net/rds/message.c                  |   3 +-
 net/tls/tls_sw.c                   |   4 +-
 43 files changed, 589 insertions(+), 906 deletions(-)

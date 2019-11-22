Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAF941071FE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 13:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727209AbfKVMLa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 07:11:30 -0500
Received: from mx2.suse.de ([195.135.220.15]:34912 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727146AbfKVMLa (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 07:11:30 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 7176BB41B;
        Fri, 22 Nov 2019 12:11:28 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EA25C1E4B15; Fri, 22 Nov 2019 13:11:27 +0100 (CET)
Date:   Fri, 22 Nov 2019 13:11:27 +0100
From:   Jan Kara <jack@suse.cz>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/2] iomap: Do not create fake iter in
 iomap_dio_bio_actor()
Message-ID: <20191122121127.GD26721@quack2.suse.cz>
References: <20191121161144.30802-1-jack@suse.cz>
 <20191121161538.18445-2-jack@suse.cz>
 <20191122000228.GP6211@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122000228.GP6211@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu 21-11-19 16:02:28, Darrick J. Wong wrote:
> On Thu, Nov 21, 2019 at 05:15:35PM +0100, Jan Kara wrote:
> > iomap_dio_bio_actor() copies iter to a local variable and then limits it
> > to a file extent we have mapped. When IO is submitted,
> > iomap_dio_bio_actor() advances the original iter while the copied iter
> > is advanced inside bio_iov_iter_get_pages(). This logic is non-obvious
> > especially because both iters still point to same shared structures
> > (such as pipe info) so if iov_iter_advance() changes anything in the
> > shared structure, this scheme breaks. Let's just truncate and reexpand
> > the original iter as needed instead of playing games with copying iters
> > and keeping them in sync.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/iomap/direct-io.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
> > index 30189652c560..01a4264bce37 100644
> > --- a/fs/iomap/direct-io.c
> > +++ b/fs/iomap/direct-io.c
> > @@ -201,12 +201,12 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  	unsigned int blkbits = blksize_bits(bdev_logical_block_size(iomap->bdev));
> >  	unsigned int fs_block_size = i_blocksize(inode), pad;
> >  	unsigned int align = iov_iter_alignment(dio->submit.iter);
> > -	struct iov_iter iter;
> >  	struct bio *bio;
> >  	bool need_zeroout = false;
> >  	bool use_fua = false;
> >  	int nr_pages, ret = 0;
> >  	size_t copied = 0;
> > +	size_t orig_count = iov_iter_count(dio->submit.iter);
> >  
> >  	if ((pos | length | align) & ((1 << blkbits) - 1))
> >  		return -EINVAL;
> > @@ -235,16 +235,14 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  			use_fua = true;
> >  	}
> >  
> > -	/*
> > -	 * Operate on a partial iter trimmed to the extent we were called for.
> > -	 * We'll update the iter in the dio once we're done with this extent.
> > -	 */
> > -	iter = *dio->submit.iter;
> > -	iov_iter_truncate(&iter, length);
> > +	/* Operate on a partial iter trimmed to the extent we were called for */
> > +	iov_iter_truncate(dio->submit.iter, length);
> 
> Ok... so here we shorten the dio iterator to fit the mapping we got...
> 
> >  
> > -	nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
> > -	if (nr_pages <= 0)
> > +	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> > +	if (nr_pages <= 0) {
> > +		iov_iter_reexpand(dio->submit.iter, orig_count);
> >  		return nr_pages;
> 
> ...and if there aren't any pages, we revert the truncation and bail...
> 
> > +	}
> >  
> >  	if (need_zeroout) {
> >  		/* zero out from the start of the block to the write offset */
> > @@ -257,6 +255,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		size_t n;
> >  		if (dio->error) {
> >  			iov_iter_revert(dio->submit.iter, copied);
> > +			iov_iter_reexpand(dio->submit.iter, orig_count);
> 
> ...if the bio failed, we walk the dio iterator backward the entire
> amount that it had advanced, undo the length truncation and bail...
> 
> >  			return 0;
> >  		}
> >  
> > @@ -268,7 +267,7 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		bio->bi_private = dio;
> >  		bio->bi_end_io = iomap_dio_bio_end_io;
> >  
> > -		ret = bio_iov_iter_get_pages(bio, &iter);
> > +		ret = bio_iov_iter_get_pages(bio, dio->submit.iter);
> 
> ...here's where we walk the dio iter forward as part of attaching pages
> to the bio...
> 
> >  		if (unlikely(ret)) {
> >  			/*
> >  			 * We have to stop part way through an IO. We must fall
> > @@ -294,13 +293,11 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  				bio_set_pages_dirty(bio);
> >  		}
> >  
> > -		iov_iter_advance(dio->submit.iter, n);
> > -
> >  		dio->size += n;
> >  		pos += n;
> >  		copied += n;
> >  
> > -		nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
> > +		nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> >  		iomap_dio_submit_bio(dio, iomap, bio);
> >  	} while (nr_pages);
> >  
> > @@ -318,6 +315,8 @@ iomap_dio_bio_actor(struct inode *inode, loff_t pos, loff_t length,
> >  		if (pad)
> >  			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
> >  	}
> > +	/* Undo iter limitation to current extent */
> > +	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
> 
> ...and here we undo the length truncation, same as all the other exit
> points.  Assuming my understanding of the bookkeeping is correct,

Yes, it is correct (or at least the same as my understanding :).

> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> 
> (Would still like to see a proper regression test for fstests though...)

So this patch does not fix any bug as such, it is just a cleanup. After
more digging in the iter code and what iov_iter_advance() does to pipe
iters I've convinced myself that the original code copying the iter is
actually correct. But to me it seems a lot safer to do the truncate /
reexpand of the original iter rather then rely on very fine details of the
implementation of individual iters (and then debug the breakage if one iter
type changes these details).

WRT regression test for the first patch, I'll work on that.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

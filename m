Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7C321089DD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 09:18:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725906AbfKYISm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 03:18:42 -0500
Received: from mx2.suse.de ([195.135.220.15]:41294 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725793AbfKYISl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 03:18:41 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E2157B23D;
        Mon, 25 Nov 2019 08:18:39 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 373921E0A57; Mon, 25 Nov 2019 09:18:39 +0100 (CET)
Date:   Mon, 25 Nov 2019 09:18:39 +0100
From:   Jan Kara <jack@suse.cz>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-fsdevel@vger.kernel.org,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 2/2] iomap: Do not create fake iter in
 iomap_dio_bio_actor()
Message-ID: <20191125081839.GA1797@quack2.suse.cz>
References: <20191121161144.30802-1-jack@suse.cz>
 <20191121161538.18445-2-jack@suse.cz>
 <20191122132658.GB12183@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122132658.GB12183@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 22-11-19 05:26:58, Christoph Hellwig wrote:
> > -	/*
> > -	 * Operate on a partial iter trimmed to the extent we were called for.
> > -	 * We'll update the iter in the dio once we're done with this extent.
> > -	 */
> > -	iter = *dio->submit.iter;
> > -	iov_iter_truncate(&iter, length);
> > +	/* Operate on a partial iter trimmed to the extent we were called for */
> > +	iov_iter_truncate(dio->submit.iter, length);
> 
> I think the comment could be kept a little more verbose given that the
> scheme isn't exactly obvious.  Also I'd move the initialization of
> orig_count here to keep it all together.  E.g.
> 
> 	/*
> 	 * Save the original count and trim the iter to just the extent we
> 	 * are operating on right now.  The iter will be re-expanded once
> 	 * we are done.
> 	 */
> 	orig_count = iov_iter_count(dio->submit.iter);
> 	iov_iter_truncate(dio->submit.iter, length);
> 
> >  
> > -	nr_pages = iov_iter_npages(&iter, BIO_MAX_PAGES);
> > -	if (nr_pages <= 0)
> > +	nr_pages = iov_iter_npages(dio->submit.iter, BIO_MAX_PAGES);
> > +	if (nr_pages <= 0) {
> > +		iov_iter_reexpand(dio->submit.iter, orig_count);
> >  		return nr_pages;
> > +	}
> 
> Can we stick to a single iov_iter_reexpand call?  E.g. turn this into
> 
> 	if (nr_pages <= 0) {
> 		ret = nr_pages;
> 		goto out;
> 	}
> 
> and then have the out label at the very end call iov_iter_reexpand.
> 
> >  			iomap_dio_zero(dio, iomap, pos, fs_block_size - pad);
> >  	}
> > +	/* Undo iter limitation to current extent */
> > +	iov_iter_reexpand(dio->submit.iter, orig_count - copied);
> >  	return copied ? copied : ret;
> 
> In iomap-for-next this is:
> 
> 	if (copied)
> 		return copied;
> 	return ret;
> 
> so please rebase to iomap-for-next for the next spin.

OK, I can see Darrick has already picked up the first patch so I'll just
respin this second one with the updates you've asked for. Thanks for
review!

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 17E94D8A2B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Oct 2019 09:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391292AbfJPHsm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 16 Oct 2019 03:48:42 -0400
Received: from verein.lst.de ([213.95.11.211]:59511 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726872AbfJPHsl (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 16 Oct 2019 03:48:41 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3189868B20; Wed, 16 Oct 2019 09:48:37 +0200 (CEST)
Date:   Wed, 16 Oct 2019 09:48:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/12] iomap: lift the xfs writeback code to iomap
Message-ID: <20191016074836.GB23696@lst.de>
References: <20191015154345.13052-1-hch@lst.de> <20191015154345.13052-10-hch@lst.de> <20191015220721.GC16973@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191015220721.GC16973@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 16, 2019 at 09:07:21AM +1100, Dave Chinner wrote:
> > +	trace_iomap_releasepage(page->mapping->host, page, 0, 0);
> > +
> >  	/*
> >  	 * mm accommodates an old ext3 case where clean pages might not have had
> >  	 * the dirty bit cleared. Thus, it can send actual dirty pages to
> > @@ -483,6 +488,8 @@ EXPORT_SYMBOL_GPL(iomap_releasepage);
> >  void
> >  iomap_invalidatepage(struct page *page, unsigned int offset, unsigned int len)
> >  {
> > +	trace_iomap_invalidatepage(page->mapping->host, page, offset, len);
> > +
> 
> These tracepoints should be split out into a separate patch like
> the readpage(s) tracepoints. Maybe just lift all the non-writeback
> ones in a single patch...

I guess that makes sense.  Initially I didn't want to duplicate the
trace definition as it is shared with the writeback tracepoints,
but in the overall scheme of things that doesn't really matter.

> > +iomap_finish_page_writeback(struct inode *inode, struct bio_vec *bvec,
> > +		int error)
> > +{
> > +	struct iomap_page *iop = to_iomap_page(bvec->bv_page);
> > +
> > +	if (error) {
> > +		SetPageError(bvec->bv_page);
> > +		mapping_set_error(inode->i_mapping, -EIO);
> > +	}
> > +
> > +	WARN_ON_ONCE(i_blocksize(inode) < PAGE_SIZE && !iop);
> > +	WARN_ON_ONCE(iop && atomic_read(&iop->write_count) <= 0);
> > +
> > +	if (!iop || atomic_dec_and_test(&iop->write_count))
> > +		end_page_writeback(bvec->bv_page);
> > +}
> 
> Can we just pass the struct page into this function?

I'd rather not change calling conventions in code just moved over for
no good reason.  That being said I agree with passing a page, so I'll
just throw in a follow on patch like I did for iomap_ioend_compare
cleanup.

> 
> .....
> 
> > +/*
> > + * Submit the bio for an ioend. We are passed an ioend with a bio attached to
> > + * it, and we submit that bio. The ioend may be used for multiple bio
> > + * submissions, so we only want to allocate an append transaction for the ioend
> > + * once.  In the case of multiple bio submission, each bio will take an IO
> 
> This needs to be changed to describe what wpc->ops->submit_ioend()
> is used for rather than what XFS might use this hook for.

True.  The real documentation now is in the header near the ops defintion,
but I'll update this one to make more sense as well.

> > +static int
> > +iomap_submit_ioend(struct iomap_writepage_ctx *wpc, struct iomap_ioend *ioend,
> > +		int error)
> > +{
> > +	ioend->io_bio->bi_private = ioend;
> > +	ioend->io_bio->bi_end_io = iomap_writepage_end_bio;
> > +
> > +	if (wpc->ops->submit_ioend)
> > +		error = wpc->ops->submit_ioend(ioend, error);
> 
> I'm not sure that "submit_ioend" is the best name for this method,
> as it is a pre-bio-submission hook, not an actual IO submission
> method. "prepare_ioend_for_submit" is more descriptive, but probably
> too long. wpc->ops->prepare_submit(ioend, error) reads pretty well,
> though...

Not a huge fan of that name either, but Brian complained.  Let's hold
a popular vote for a name and see if we have a winner.

As for the grammar comments - all this is copied over as-is.  I'll add
another patch to fix that up.


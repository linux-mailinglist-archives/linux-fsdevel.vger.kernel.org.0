Return-Path: <linux-fsdevel+bounces-37180-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F0A19EEAB8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 16:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAE33166EEC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2024 15:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18867217F28;
	Thu, 12 Dec 2024 15:12:27 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F74721171A;
	Thu, 12 Dec 2024 15:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734016346; cv=none; b=OcQMPi0dslPsf2qpOyBtB3ZbjmT8d6ZwuwDeZuga1QtKL4zFaiTYNLqzsRUWaAFByhQyIIsJBlscMXoZLb06LYI5qjcArsJmMWpzwvYw9BEYe5RzvXtu3rMsO3HkOyzLrn1ibY3ALFsZp64tFz95wmmHLfI+1Swm6IZkLGPN70w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734016346; c=relaxed/simple;
	bh=F1l/Appo45L4GxTayGWCuu+y2jPlO4BKBhy0/EheVdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1zBPqxmiqpnWt3zPlAk5Y1uLPkO3khtyvdn88oPkeQfElZNOxQC03RWMN9H/5jiI2ruJYyqwPpxV1h3aU3mKU/iL3j83vdJk+/wa+67fdhU0/0DwWCGno5k2vD7hXFMfSLW5BELuupIhzMItz5L1DANjWxh+euZvsq6JBpULHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A945368D34; Thu, 12 Dec 2024 16:12:19 +0100 (CET)
Date: Thu, 12 Dec 2024 16:12:19 +0100
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Carlos Maiolino <cem@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 5/8] iomap: optionally use ioends for direct I/O
Message-ID: <20241212151219.GC6840@lst.de>
References: <20241211085420.1380396-1-hch@lst.de> <20241211085420.1380396-6-hch@lst.de> <Z1rlQA6N8tCfRlLi@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z1rlQA6N8tCfRlLi@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 12, 2024 at 08:29:36AM -0500, Brian Foster wrote:
> > +	bool should_dirty = (dio->flags & IOMAP_DIO_DIRTY);
> > +	struct kiocb *iocb = dio->iocb;
> > +	u32 vec_count = ioend->io_bio.bi_vcnt;
> > +
> > +	if (ioend->io_error)
> > +		iomap_dio_set_error(dio, ioend->io_error);
> > +
> > +	if (atomic_dec_and_test(&dio->ref)) {
> > +		struct inode *inode = file_inode(iocb->ki_filp);
> > +
> > +		if (dio->wait_for_completion) {
> > +			struct task_struct *waiter = dio->submit.waiter;
> > +
> > +			WRITE_ONCE(dio->submit.waiter, NULL);
> > +			blk_wake_io_task(waiter);
> > +		} else if (!inode->i_mapping->nrpages) {
> > +			WRITE_ONCE(iocb->private, NULL);
> > +
> > +			/*
> > +			 * We must never invalidate pages from this thread to
> > +			 * avoid deadlocks with buffered I/O completions.
> > +			 * Tough luck if you hit the tiny race with someone
> > +			 * dirtying the range now.
> > +			 */
> > +			dio->flags |= IOMAP_DIO_NO_INVALIDATE;
> > +			iomap_dio_complete_work(&dio->aio.work);
> > +		} else {
> > +			INIT_WORK(&dio->aio.work, iomap_dio_complete_work);
> > +			queue_work(inode->i_sb->s_dio_done_wq, &dio->aio.work);
> > +		}
> > +	}
> > +
> > +	if (should_dirty) {
> > +		bio_check_pages_dirty(&ioend->io_bio);
> > +	} else {
> > +		bio_release_pages(&ioend->io_bio, false);
> > +		bio_put(&ioend->io_bio);
> > +	}
> > +
> 
> Not that it matters all that much, but I'm a little curious about the
> reasoning for using vec_count here. AFAICS this correlates to per-folio
> writeback completions for buffered I/O, but that doesn't seem to apply
> to direct I/O. Is there a reason to have the caller throttle based on
> vec_counts, or are we just pulling some non-zero value for consistency
> sake?

So direct I/O also iterates over all folios for the bio, to unpin,
and in case of reads dirty all of them.

I wanted to plug something useful into cond_resched condition in the
caller.  Now number of bvecs isn't the number of folios as we can
physically merge outside the folio context, but I think this is about
as goot as it gets without changing the block code to return the
number of folios processed from __bio_release_pages and
bio_check_pages_dirty.



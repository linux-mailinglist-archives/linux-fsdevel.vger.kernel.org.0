Return-Path: <linux-fsdevel+bounces-19495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1918C5F96
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 06:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08B92832AC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2024 04:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFE73A1AC;
	Wed, 15 May 2024 04:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="i/Z9ShYI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A5A39ACD;
	Wed, 15 May 2024 04:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715745873; cv=none; b=Xi3Etl19t6natLdVyc+5O5VlLR2nCXqL8TGxoih1o7qyvX3RAEEZDNQeegLiS/Gf6cLAcznFBx3iN9OYm+MhXpfDMYl7WAZf7SiZUDD6WSge5GW+JHMM/4W4Pqt9AboU86b2OaMi/QMO1EpTy9NK7gWZSCDSCFWDz40uaHwwj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715745873; c=relaxed/simple;
	bh=lvxzHySygClVo8NxsP+1iA7pW6aQgmZ/x3hUJ+XhGP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uPrpUf21rkAnvhEqtxV439NvgvXGJNJ60O9omsIpnIgcGF+F8QdhwI0Mv1kUrFl1Yz3lr9KLGdesMvC9CRapXWDxvXYC/m4GxDXzmbxJqqPwEpVTxOZM5aURrE+ZU3NASBymaSzW3KrXDo3BrILrjQB+8cFNeS+PoJ59SIeg2P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=i/Z9ShYI; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dM/9pOuJniex+bZsh3M6i6DcaU/wvknCDaVpt9pIARk=; b=i/Z9ShYIvy4cDyjQ2302bBjXoY
	ri/wt2PmECEHMe1QxB2u509R79rqBLXj1BjZmjN7nHkqSga0uM96kOHQBmD9uI8Y2JtlydQFlvqKq
	E954mFHbN30s4nLIIfCPRB1WWXp0lL0LXmYQ22r5SKsb8PziwAo/0e8ZDIMT+NPqlbZ6Uazg8drJB
	f1OSD9GZCiNEH1ZbDIJxlLG56fKaIDf7ChvESBsWu02uf3ZNAsIVqN1QwJGkxHPluBE5CTWtydNyd
	9XGvT8Yw+H9P+nPU2Ijyc6CAAbDsShZlroX9/M3E/e9tk9HYNd+JEvmVwqKpHoff5CG5lx2Qea2LA
	dJ0K5XCg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s75sE-00000009tym-11dv;
	Wed, 15 May 2024 04:04:14 +0000
Date: Wed, 15 May 2024 05:04:14 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Keith Busch <kbusch@kernel.org>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>, hch@lst.de,
	mcgrof@kernel.org, akpm@linux-foundation.org, brauner@kernel.org,
	chandan.babu@oracle.com, david@fromorbit.com, djwong@kernel.org,
	gost.dev@samsung.com, hare@suse.de, john.g.garry@oracle.com,
	linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-xfs@vger.kernel.org, p.raghav@samsung.com,
	ritesh.list@gmail.com, ziy@nvidia.com
Subject: Re: [RFC] iomap: use huge zero folio in iomap_dio_zero
Message-ID: <ZkQ0Pj26H81HxQ_4@casper.infradead.org>
References: <20240503095353.3798063-8-mcgrof@kernel.org>
 <20240507145811.52987-1-kernel@pankajraghav.com>
 <ZkQG7bdFStBLFv3g@casper.infradead.org>
 <ZkQfId5IdKFRigy2@kbusch-mbp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZkQfId5IdKFRigy2@kbusch-mbp>

On Tue, May 14, 2024 at 08:34:09PM -0600, Keith Busch wrote:
> On Wed, May 15, 2024 at 01:50:53AM +0100, Matthew Wilcox wrote:
> > On Tue, May 07, 2024 at 04:58:12PM +0200, Pankaj Raghav (Samsung) wrote:
> > > Instead of looping with ZERO_PAGE, use a huge zero folio to zero pad the
> > > block. Fallback to ZERO_PAGE if mm_get_huge_zero_folio() fails.
> > 
> > So the block people say we're doing this all wrong.  We should be
> > issuing a REQ_OP_WRITE_ZEROES bio, and the block layer will take care of
> > using the ZERO_PAGE if the hardware doesn't natively support
> > WRITE_ZEROES or a DISCARD that zeroes or ...
> 
> Wait a second, I think you've gone too far if you're setting the bio op
> to REQ_OP_WRITE_ZEROES. The block layer handles the difference only
> through the blkdev_issue_zeroout() helper. If you actually submit a bio
> with that op to a block device that doesn't support it, you'll just get
> a BLK_STS_NOTSUPP error from submit_bio_noacct().

Ohh.  This is a bit awkward, because this is the iomap direct IO path.
I don't see an obvious way to get the semantics we want with the current
blkdev_issue_zeroout().  For reference, here's the current function:

static void iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
                loff_t pos, unsigned len)
{
        struct inode *inode = file_inode(dio->iocb->ki_filp);
        struct page *page = ZERO_PAGE(0);
        struct bio *bio;

        bio = iomap_dio_alloc_bio(iter, dio, 1, REQ_OP_WRITE | REQ_SYNC | REQ_IDLE);
        fscrypt_set_bio_crypt_ctx(bio, inode, pos >> inode->i_blkbits,
                                  GFP_KERNEL);
        bio->bi_iter.bi_sector = iomap_sector(&iter->iomap, pos);
        bio->bi_private = dio;
        bio->bi_end_io = iomap_dio_bio_end_io;

        __bio_add_page(bio, page, len, 0);
        iomap_dio_submit_bio(iter, dio, bio, pos);
}

and then:

static void iomap_dio_submit_bio(const struct iomap_iter *iter,
                struct iomap_dio *dio, struct bio *bio, loff_t pos)
{
        struct kiocb *iocb = dio->iocb;

        atomic_inc(&dio->ref);

        /* Sync dio can't be polled reliably */
        if ((iocb->ki_flags & IOCB_HIPRI) && !is_sync_kiocb(iocb)) {
                bio_set_polled(bio, iocb);
                WRITE_ONCE(iocb->private, bio);
        }

        if (dio->dops && dio->dops->submit_io)
                dio->dops->submit_io(iter, bio, pos);
        else
                submit_bio(bio);
}

so unless submit_bio() can handle the fallback to "create a new bio
full of zeroes and resubmit it to the device" if the original fails,
we're a little mismatched.  I'm not really familiar with either part of
this code, so I don't have much in the way of bright ideas.  Perhaps
we go back to the "allocate a large folio at filesystem mount" plan.


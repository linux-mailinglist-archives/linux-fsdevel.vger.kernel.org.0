Return-Path: <linux-fsdevel+bounces-53300-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCBC1AED40F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 07:47:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C3DC173432
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 05:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8A21C84DD;
	Mon, 30 Jun 2025 05:47:11 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7964A23;
	Mon, 30 Jun 2025 05:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751262431; cv=none; b=DI26BqlX3B3BNzrFExIMvquCwigs+wEgsb8ULVA9kHu7lfHN7s5tjCdHSH4WWZB34IJbuOozNmA9eGkZiZjGT3UmPDh08GhkbVXA1g1bxRuRlapE/a/MsT7n3SiA0pnJ+eVP7tmIhS0BWr3zekfsNw2FOsI+PtYMpwfd8biew3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751262431; c=relaxed/simple;
	bh=/SL0iq4l3TZFas29WAYUOA1z9JLbjzzThbe4Zec6Gik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E728dJguCosHXx9QM/b0/6uPJtQ2fIVDT279EADP0g3jC/uLBW5DTpOyJ0ScaWLGX3klFOJLWXju8k2N/IJRTCpwmbWlW45vu+MqqkGGYxkKbfyne/i8xns+IzLGPk/mOlS0/Tlikfi31IgTA+A3yX4398fIjRSHf0D7ApFyqpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 367AA68AA6; Mon, 30 Jun 2025 07:47:06 +0200 (CEST)
Date: Mon, 30 Jun 2025 07:47:05 +0200
From: Christoph Hellwig <hch@lst.de>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Joanne Koong <joannelkoong@gmail.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 11/12] iomap: add read_folio_range() handler for
 buffered writes
Message-ID: <20250630054705.GF28532@lst.de>
References: <20250627070328.975394-1-hch@lst.de> <20250627070328.975394-12-hch@lst.de> <aF7ujFij4GmYuYPu@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF7ujFij4GmYuYPu@bfoster>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jun 27, 2025 at 03:18:36PM -0400, Brian Foster wrote:
> > +static int iomap_read_folio_range(const struct iomap_iter *iter,
> > +		struct folio *folio, loff_t pos, size_t len)
> >  {
> > +	const struct iomap *srcmap = iomap_iter_srcmap(iter);
> >  	struct bio_vec bvec;
> >  	struct bio bio;
> >  
> > -	bio_init(&bio, iomap->bdev, &bvec, 1, REQ_OP_READ);
> > -	bio.bi_iter.bi_sector = iomap_sector(iomap, block_start);
> > -	bio_add_folio_nofail(&bio, folio, plen, poff);
> > +	bio_init(&bio, srcmap->bdev, &bvec, 1, REQ_OP_READ);
> > +	bio.bi_iter.bi_sector = iomap_sector(srcmap, pos);
> > +	bio_add_folio_nofail(&bio, folio, len, offset_in_folio(folio, pos));
> >  	return submit_bio_wait(&bio);
> >  }
> 
> Hmm, so this kind of makes my brain hurt... pos here is now the old
> block_start and len is the old plen. We used to pass poff to the
> add_folio_nofail() call, and now that is dropped and instead we use
> offset_in_folio(..., pos). The old poff is an output of the previous
> iomap_adjust_read_range() call, which is initially set to
> offset_in_folio(folio, *pos), of which *pos is block_start and is bumped
> in that function in the same places that poff is. Therefore old poff and
> new offset_in_folio(folio, pos) are logically equivalent. Am I following
> that correctly?

You are, but given that you had to ask mean this should probably
be better documented ant/or be split into a separate patch.



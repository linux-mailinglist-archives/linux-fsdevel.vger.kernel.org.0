Return-Path: <linux-fsdevel+bounces-51999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B5B7ADE2A9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 06:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B64F3B715E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 04:41:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588AE1F09BF;
	Wed, 18 Jun 2025 04:41:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8A51E0DFE;
	Wed, 18 Jun 2025 04:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750221690; cv=none; b=ry0VTyhKxT7qFpSEleBkLSTE3NI97oCCXufV1/lQ29ZKqhtS7CLoiS/z6+YL8m6DtqwRsVLnpWsRRFmO5tjYC7gnAEwzLNBaUh3f4IC8U3ycygpEkkMVVCB5OBainE3k424XdzPackueowI2GARZOlfCWFYDRJtWVgt4d2V2UeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750221690; c=relaxed/simple;
	bh=Y3lR4TOo5dIJI9u6JNwOoY1dx4D6SehoizOnUOcA0jE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BNYHlCNCBlx0gbvedEiRSbwyFYNd3IBRxwryW1kwuYnS+nEkJT4MdQb2oTvexZv2O33Arru0SUY7Dxv6hX3lyP1glewt0mdvEy+Q6u1yjvkF3/v3SEzBmH0Uv5V6hLoWEcVB72/7nZSqLl4AWKjvFsNgmMX5ZwoyDwKvI1yzPG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ED48068D0E; Wed, 18 Jun 2025 06:41:23 +0200 (CEST)
Date: Wed, 18 Jun 2025 06:41:23 +0200
From: Christoph Hellwig <hch@lst.de>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev
Subject: Re: [PATCH 04/11] iomap: hide ioends from the generic writeback
 code
Message-ID: <20250618044123.GC28041@lst.de>
References: <20250617105514.3393938-1-hch@lst.de> <20250617105514.3393938-5-hch@lst.de> <CAJnrk1bgWwmE8XeYe4gRrYCZFwTsn5JT3Aw7B+morrOLiZowFg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJnrk1bgWwmE8XeYe4gRrYCZFwTsn5JT3Aw7B+morrOLiZowFg@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jun 17, 2025 at 12:22:46PM -0700, Joanne Koong wrote:
> On Tue, Jun 17, 2025 at 3:55 AM Christoph Hellwig <hch@lst.de> wrote:
> >
> > Replace the ioend pointer in iomap_writeback_ctx with a void *wb_ctx
> > one to facilitate non-block, non-ioend writeback for use.  Rename
> > the submit_ioend method to writeback_submit and make it mandatory so
> 
> I'm confused as to whether this is mandatory or not - afaict from the
> code, it's only needed if wpc->wb_ctx is also set. It seems like it's
> ok if a filesystem doesn't define ops->writeback_submit so long as
> they don't also set wpc->wb_ctx, but if they do set
> ops->writeback_submit but don't set wpc->wb_ctx then they shouldn't
> expect ->writeback_submit() to be called.

In a way yes.  But I don't really understand how a file system could
work without either, unless the folio size and the block size are always
equal.

> It seems like there's a
> tight interdependency between the two, it might be worth mentioning
> that in the documentation to make that more clear. Or alternatively,
> just always calling wpc->ops->writeback_submit() in iomap_writepages()
> and having the caller check that wpc->wb_ctx is valid.

Do you mean the callee here?  Otherwise I'm a bit confused about this
sentence.

> > -  - ``submit_ioend``: Allows the file systems to hook into writeback bio
> > -    submission.
> > -    This might include pre-write space accounting updates, or installing
> > -    a custom ``->bi_end_io`` function for internal purposes, such as
> > -    deferring the ioend completion to a workqueue to run metadata update
> > -    transactions from process context before submitting the bio.
> > -    This function is optional.
> > +  - ``writeback_submit``: Submit the previous built writeback context.
> 
> It might be helpful here to add "This function must be supplied by the
> filesystem", especially since the paragraph above has that line for
> writeback_range()

Ok.

> >  struct iomap_writeback_ops {
> >         /*
> > -        * Required, performs writeback on the passed in range
> > +        * Performs writeback on the passed in range
> 
> Is the reasoning behind removing "Required" that it's understood that
> the default is it's required, so there's no need to explicitly state
> that?

Yes.


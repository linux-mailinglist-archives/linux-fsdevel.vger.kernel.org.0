Return-Path: <linux-fsdevel+bounces-43864-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 595AAA5EC6E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:07:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75CC189F5B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 07:06:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A196320370D;
	Thu, 13 Mar 2025 07:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h31/7jwD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4A21202F8D;
	Thu, 13 Mar 2025 07:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741849328; cv=none; b=QOzZ7ZmMWNrLY/iC1xWZvlcZjlasVUu0XxXNz7bdKaG8M4eSzs7+TGwHfEUKv4PY26iNSqPSDVGX4psDe/cla5PWgToqbYJU1rgnhpczBBC8Era7bnGFuDx8tuUrrq4Nr8AW1Dd7SQlNuNj7FHncjNsmSe8K6BbHGdDqjws2yaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741849328; c=relaxed/simple;
	bh=pmnOP+7/wr9JaZCm5QZagcLeQf2SXXlcy3Dd7Vplf+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WdS21CDeevv01A2+UQp0e0BUnmRUkXk9ottBPoQznHN8WLIpxubu2J7z6NZ/aUFhPKATFwzMYH+T+ppf/kFtXC1eaW2ufEhVBkC3oUbwAaxTUq++MVJckpYVdOXKa7Xl9ndJlP9J9TifIthyJzRFL6YUymO1MDcpSLJxDvprffw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h31/7jwD; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jupZVR11ysyCxPWL263xWTkoaFPFC23sweA5ERG94k4=; b=h31/7jwDFulifOwmdDEtq/waRS
	G8ThmrIYhIwub1y22EshrbIEjrhTjnIjM3d/D6NrSxqskH1YKuuBcOzz59KOvBLmmDZvHThpESVwR
	DSEMyc5PnQD07NraiN4bR5pyQMyyEUNyQ6ADh+jzEKbGEFACkq4tPm7fjiw7nmc7Rzhk9+FDArqVh
	+LDPpHv7sjzkJpMIcJGPaF7CPW1D4KYeHywCJEdNTattlLO0+5jPUtddvHr0na2yvxUwJccdLZuNl
	JLZSdDamWBSFRhGdx4DprMKmp8kpkO/AD/IkT4T43ius9EJkaw4tK1w3mvSI9jEoE2CSPxT+zvezo
	ShpcMwhw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tscZx-0000000AHqe-10YA;
	Thu, 13 Mar 2025 07:02:05 +0000
Date: Thu, 13 Mar 2025 00:02:05 -0700
From: Christoph Hellwig <hch@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: Dave Chinner <david@fromorbit.com>,
	Christoph Hellwig <hch@infradead.org>, brauner@kernel.org,
	djwong@kernel.org, cem@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	ojaswin@linux.ibm.com, ritesh.list@gmail.com,
	martin.petersen@oracle.com
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
Message-ID: <Z9KC7UHOutY61C5K@infradead.org>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org>
 <Z9If-X3Iach3o_l3@dread.disaster.area>
 <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Mar 13, 2025 at 06:28:03AM +0000, John Garry wrote:
> > > I'd rather have a
> > > 
> > >      blk_opf_t extra_flags;
> > > 
> > > in the caller that gets REQ_FUA and REQ_ATOMIC assigned as needed,
> > > and then just clear
> > Yep, that is cleaner..
> 
> This suggestion is not clear to me.
> 
> Is it that iomap_dio_bio_iter() [the only caller of iomap_dio_bio_opflags()]
> sets REQ_FUA and REQ_ATOMIC in extra_flags, and then we extra_flags |
> bio_opf?

Yes.

> Note that iomap_dio_bio_opflags() does still use use_fua for clearing
> IOMAP_DIO_WRITE_THROUGH.

You can check for REQ_FUA in extra_flags (or the entire op).

> And to me it seems nicer to set all the REQ_ flags in one place.

Passing multiple bool arguments just loses way too much context.  But
if you really want everything in one place you could probably build
the entire blk_opf_t in iomap_dio_bio_iter, and avoid having to
recalculate it for every bio.



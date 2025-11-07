Return-Path: <linux-fsdevel+bounces-67441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C8948C403D0
	for <lists+linux-fsdevel@lfdr.de>; Fri, 07 Nov 2025 15:01:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 065B84F7FC9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Nov 2025 13:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A46CF31A813;
	Fri,  7 Nov 2025 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="LzPjAEFP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07BE9433BC;
	Fri,  7 Nov 2025 13:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762523866; cv=none; b=VCe1HbSZJ7P64q8DB/Mz27qs7MxrqezlTlqsUTDk1rQtm3pDZ77RqXxefEsM3wnYdZ6homRsmFB0Zt9obtBuVxtNoYBdhGgzUC1LQyerpJIJee2Ak2A+CxLC5rXnp9xMhqiiQjdYK4lUb8OJG3ECR+ql1yNK4CMLs8bv05AcgzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762523866; c=relaxed/simple;
	bh=a6wn1s+JcgbMF86nuPJ38UW/k9+5ocGH9m3O6K6TWDo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gr1PdIxo7Xx6ZRxFaTpTZ03Oih5RD8W5MyB1kDnr+wGPxuK2Ahoj7FuNrTmP5vVpQQqJj8EynUEUAUPtiE6acM06ma+BzRpqJspRoDlYUjt//yX7xfrJQ+44tXymK3pe/EQOjZuWA9wC4HWV6LsnAHhHA8q1wdNUqFWuofqHMz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=LzPjAEFP; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=odC97piI4VFDCJpFeVI4GGijMGtAOHX0I0tIPHlExlM=; b=LzPjAEFPIswH0McWUQJOORXTwi
	ndJDea1mCvy01YhIauu9YwUBAEqAMwAK27OOM+X9TBjBudz5yflz/gZ0W4Tchk+wxidboegLEufNS
	/N3UuVu71Wh1tMlJDtrLKmqUXwHdn0L/y+eKMrJ/W82kYfeZQtUM1HIXNbIyY/lwMH33aV33nlnJC
	TGqScSLFQcdHImFiWs1Sra29fYP5fiwoifngnJlMMKJAD9bFpchRj1UAEZiY13vG2VysQD13VMTcs
	drqNj93q3WoxQ5WUD3/ZT3erHZXrNwWsFsFfQJSaMKpIh8gL6L6vMfvisEtewq6JUEBaZFrp4Nxlv
	i6b+LGBg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vHMyF-0000000HRbs-1wrx;
	Fri, 07 Nov 2025 13:57:43 +0000
Date: Fri, 7 Nov 2025 05:57:43 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: "Darrick J. Wong" <djwong@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH 2/6] iomap, xfs: lift zero range hole mapping flush into
 xfs
Message-ID: <aQ3612r1qKFeM9Ur@infradead.org>
References: <20251016190303.53881-1-bfoster@redhat.com>
 <20251016190303.53881-3-bfoster@redhat.com>
 <20251105003114.GY196370@frogsfrogsfrogs>
 <aQtuPFHtzm8-zeqS@bfoster>
 <20251105222350.GO196362@frogsfrogsfrogs>
 <aQzEQtynNsJLdLcD@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQzEQtynNsJLdLcD@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Thu, Nov 06, 2025 at 10:52:34AM -0500, Brian Foster wrote:
> > An unaligned pagecache write to an uncached region uses the read mapping
> > to pull data into the pagecache.  For writeback, we'd use the write
> > mapping if it's non-null, or else the read mapping.
> > 
> 
> Or perhaps let the read/write mappings overlap? It's not clear to me if
> that's better or worse. ;P

It is much better for the case where they actually are different.

> > This might not move the needle much wrt to fixing your problem, but at
> > least it eliminates the weirdness around "@iomap is for reads except
> > when you're doing a write but you have to do a read *and* @srcmap isn't
> > a hole".
> > 
> 
> Yeah.. it might be reaching a pedantic level, but to me having a couple
> mappings that say "you can read from this range, write to that range,
> and they might be the same" is more clear than the srcmap/dstmap/maybe
> both logic we have today.

It is a lot better.



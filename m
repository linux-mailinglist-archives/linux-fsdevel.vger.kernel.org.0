Return-Path: <linux-fsdevel+bounces-42436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D08A42687
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 16:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B5D3319C423D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 15:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89CA62561B5;
	Mon, 24 Feb 2025 15:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XgmiQpUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4A362561A0;
	Mon, 24 Feb 2025 15:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411215; cv=none; b=oaCK20p3rvnPOX/aPeElD3A/HV69YecGXiIoWVVbXCfNxSoyoCHjnUqdBg+4OxdeLONIOka/k6wscO9OZgzC6EBMa5pEensZMOMEnFiL71A5ZTdQxfvVLs/574oyT1ZcYq47JHHUXZiQ2EfQ9rZKTlvvnCNB3A4/kDl5x50DML8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411215; c=relaxed/simple;
	bh=dN+YAJEN00mhIkCuzbWGSXa0wqDJ074BJrDkjMGHkmc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KImHzlKl4U21KmZSCzX7pXEutl770wFrPMmVjjCQycPBIQ5coGmiDqGsubkyEiEK/Dl6RSPq76gQNTdo5+4XKDqK/hFv9ScNG27DPnhtoo8WmtkosSg5jfEVweJQjNXE4HME3sZ7QclESNR4tEbFN7O2tZqDs+sU5aYJp0ZXTLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XgmiQpUP; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2kZuikH82YSc7S3HfNANRsQo2YtDaV4SIY3/Jou1Rhs=; b=XgmiQpUPZkdrwGIkETA+Q6X97t
	mycvbbUMQMPAW6+yiqImO/SZLBqZHD33x2o/vxQafs/yKs2yNqB4XnKneI3cX4e9Bg/S+dhc2q53G
	PE5SwsGWZmTDUhL5Y1IffM6UwRRLIpcJ7xRxDYGw/n+L9yOYTX1L395fg2SqqvlqjogKGcO6SV28Z
	fMQrFmz27C5HoTPchxfMJ3pfrrwIa77t7E2NCHjn1QEcnJ2i4MPmGloIEJWOTQ4Mn5a0Hh9tqzp0R
	5Cl1ngj3ZzgxDKHfbE5n9UyBMU1+qCDGDU3g1EkQ2LKlamb1OK+4QslmPGEERJztBFJL8ACj1pBuJ
	fIn0HkaA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmaSX-00000007diT-2H0i;
	Mon, 24 Feb 2025 15:33:29 +0000
Date: Mon, 24 Feb 2025 15:33:29 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: "Raphael S. Carvalho" <raphaelsc@scylladb.com>,
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
	djwong@kernel.org, Dave Chinner <david@fromorbit.com>
Subject: Re: [PATCH v2] mm: Fix error handling in __filemap_get_folio() with
 FGP_NOWAIT
Message-ID: <Z7yRSe-nkfMz4TS2@casper.infradead.org>
References: <20250224081328.18090-1-raphaelsc@scylladb.com>
 <20250224141744.GA1088@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224141744.GA1088@lst.de>

On Mon, Feb 24, 2025 at 03:17:44PM +0100, Christoph Hellwig wrote:
> On Mon, Feb 24, 2025 at 05:13:28AM -0300, Raphael S. Carvalho wrote:
> > +		if (err) {
> > +			/* Prevents -ENOMEM from escaping to user space with FGP_NOWAIT */
> > +			if ((fgp_flags & FGP_NOWAIT) && err == -ENOMEM)
> > +				err = -EAGAIN;
> >  			return ERR_PTR(err);
> 
> I don't think the comment is all that useful.  It's also overly long.
> 
> I'd suggest this instead:
> 
> 			/*
> 			 * When NOWAIT I/O fails to allocate folios this could
> 			 * be due to a nonblocking memory allocation and not
> 			 * because the system actually is out of memory.
> 			 * Return -EAGAIN so that there caller retries in a
> 			 * blocking fashion instead of propagating -ENOMEM
> 			 * to the application.
> 			 */

I don't think it needs a comment at all, but the memory allocation
might be for something other than folios, so your suggested comment
is misleading.


Return-Path: <linux-fsdevel+bounces-53215-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C826EAEC1D4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 23:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBA3644282
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jun 2025 21:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C116525FA2D;
	Fri, 27 Jun 2025 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V2yC73wF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7827621ADAE;
	Fri, 27 Jun 2025 21:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751059152; cv=none; b=DCT/1RSGvTK7Lcc03Nq8m8vtG0kEKHShrdZ1LOudWt5EouvAczrwctXhQWMJS86+IaOLyzl84b68il1Mdq5NCK/+uE9q2MK4uxkIaYHpeN316WNTGFsNoraoJD3EijU1a0uMu9pGUDWePVBN7iiugFot44qU/boaiWp2ce7PvO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751059152; c=relaxed/simple;
	bh=CSDmqDjEEPtE67ns1OANFYqHt5N2irhJTWhyp+Bnppk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O96Ibk8skI8NIrZS765idLk4mM/6G97EL9EO67QhxakK27AknhYzIxAgD4vl4pWaBp+6yzaxAxp2y+wYdM+7uS3GAKA/1AVB1R3+P+bp21t99qUZKiXufKO7+DW9vuBOLtuX/Y+Rumnch511Upck5YUbulw1PdZViFoXShoM56o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V2yC73wF; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TK6YsxLqexPCwLZ//8Bes1uH4QD/vwQuoEwg7UlOgrc=; b=V2yC73wF9tfyUWoyl4YZZwayUa
	3S/LisvhLTv+iP6YAqO7t7bEI10d7/yNV7xh/4K2f/jfmUTzE1lS9gDN3V9ji+gx1pNHD/lEyozou
	MmT3K/BClKIqeCXdsFOYY5hMYiuVORKPNT3Pq09vuI6kHHo2QEbdfgdBxLCXM2ofp2Ofvua5flAyJ
	1REKmhqmyf+NWavmLa25R+9V3AHXJe44DuSdO3PiZJ9mCCkLLSKRTPtyVIdax9ZkQ3YIfKD6VrUQk
	Bc/3y3ScyurVqPMe5X4uW6Ai2QbOFrGSvxPoWOkUGcAN2preRlEz5wc55PWAR3IgMByNyEZHdDItD
	W703Mxhw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uVGTQ-0000000F0iH-2ZlW;
	Fri, 27 Jun 2025 21:19:04 +0000
Date: Fri, 27 Jun 2025 22:19:04 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@infradead.org>,
	Yafang Shao <laoar.shao@gmail.com>,
	Jeff Layton <jlayton@kernel.org>, djwong@kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, yc1082463@gmail.com
Subject: Re: [PATCH] xfs: report a writeback error on a read() call
Message-ID: <aF8KyEQIhA-7GfAq@casper.infradead.org>
References: <aFuezjrRG4L5dumV@infradead.org>
 <88e4b40b61f0860c28409bd50e3ae5f1d9c0410b.camel@kernel.org>
 <aFvbr6H3WUyix2fR@infradead.org>
 <6ac46aa32eee969d9d8bc55be035247e3fdc0ac8.camel@kernel.org>
 <aFvkAIg4pAeCO3PN@infradead.org>
 <11735cf2e1893c14435c91264d58fae48be2973d.camel@kernel.org>
 <CALOAHbDtFh5P_P0aTzaKRcwGfQmkrhgmk09BQ1tu9ZdXvKi8vQ@mail.gmail.com>
 <aFzFR6zD7X1_9bWj@dread.disaster.area>
 <aF0gEWcA6bX1eNzU@infradead.org>
 <aF3IPcneKbUe9IdH@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aF3IPcneKbUe9IdH@dread.disaster.area>

On Fri, Jun 27, 2025 at 08:22:53AM +1000, Dave Chinner wrote:
> On Thu, Jun 26, 2025 at 03:25:21AM -0700, Christoph Hellwig wrote:
> > On Thu, Jun 26, 2025 at 01:57:59PM +1000, Dave Chinner wrote:
> > > writeback errors. Because scientists and data analysts that wrote
> > > programs to chew through large amounts of data didn't care about
> > > persistence of their data mid-processing. They just wanted what they
> > > wrote to be there the next time the processing pipeline read it.
> > 
> > That's only going to work if your RAM is as large as your permanent
> > storage :)
> 
> No, the old behaviour worked just fine with data sets larger than
> RAM. When there is a random writeback error in a big data stream,
> only those pages remained dirty and so never get tossed out of RAM. Hence
> when a re-read of that file range occurred, the data was already in
> RAM and the read succeeded, regardless of the fact that writeback
> has been failing.
> 
> IOWs the behavioural problems that the user is reporting are present
> because we got rid of the historic XFS writeback error handling
> (leave the dirty pages in RAM and retry again later) and replaced it
> with the historic Linux behaviour (toss the data out and mark the
> mapping with an error).
> 
> The result of this change is exactly what the OP is having problems
> with - reread of a range that had a writeback failure returns zeroes
> or garbage, not the original data. If we kept the original XFS
> behaviour, the user applications would handle these flakey writeback
> failures just fine...
> 
> Put simply: we used to have more robust writeback failure handling
> than we do now. That could (and probably should) be considered a
> regression....

When you say "used to" and "the old behaviour", when are you referring
to, exactly?  When I came to XFS/iomap, the behaviour on writeback errors
was to clear the Uptodate flag on writeback, which definitely did throw
away the written data and forced a re-read from storage.


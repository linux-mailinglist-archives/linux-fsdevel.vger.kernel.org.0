Return-Path: <linux-fsdevel+bounces-9033-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2A583D2BE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 03:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 076371C21B2B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jan 2024 02:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E3E8F5C;
	Fri, 26 Jan 2024 02:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hRYb7sB8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE998F5F
	for <linux-fsdevel@vger.kernel.org>; Fri, 26 Jan 2024 02:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706237680; cv=none; b=ZdmNboFa33kGsfQ3oe2r6WI7YecQ32ynx0jJz4lmcRHdp7NHG0YfiMFMBW2OQ+qFoTrn26UyWQ6YxDiZh4CDNzjS2/oxrnFBZrlaE67rC2+SJyxc1CUNrL/P+fE/rLVIESn7skLPozarDq57UUz4G4E0waaQfoDMc/fsGGCH5sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706237680; c=relaxed/simple;
	bh=j7SO/HzA5kbkVbZwBxQoq7ZAZ0THzdqZx4nC6poPNy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=de3tDweoHTbzQiP3oRWmMOYOssGeDK+arrMZhn03QtYdPWHloL+pNpxcZldRLAEzGG1H1CBJVPjs3UahQ1oZizPEH1ALWJFfTuxGvbV1NuzFIrlj2DnvPFLC99PKGcqExP4EEmfYkRiSU5+nwoxdvh722QMd8TA8JCJXO/2DH7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hRYb7sB8; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NcQJaqqUEBbdxlQ6gaEGkf4qRylijhDf93KTiec0eWc=; b=hRYb7sB8B30+ghVQiruCZezq5q
	SZcVbEGWXn6TBebVMXOPmp2EMi9wzRowj2xia2GdlMGEXBs7i1BHikYtJfoTZA9DHCfu8mB7BfxSt
	/a7nQomnxSw5htoOqWZ1Daed5tUrh9Q0h1cUt4zTB/Xd8Nbl3pyJpCmT+my/Ms9xrBww1gwPYGXTA
	MPI0y2QGtFZEaHF/yw3QJwKvqKf28pPjQEDjz2BDmUBHEQaHPG/CJtAYgoyJCZuCn0ZisEci4cJtN
	lCe3f5zaSfRsetaHe2IpLkZ2n0qSYHYHl3A62EjT+noyb/cXdY56/jDSmFX5YlQZ1P/GSzmlKuR85
	deUCntZw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTCMK-0000000CFbb-0VWm;
	Fri, 26 Jan 2024 02:54:24 +0000
Date: Fri, 26 Jan 2024 02:54:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	"Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>,
	"sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] exfat: fix file not locking when writing zeros in
 exfat_file_mmap()
Message-ID: <ZbMe4CbbONCzfP7p@casper.infradead.org>
References: <PUZPR04MB63168A32AB45E8924B52CBC2817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbCeWQnoc8XooIxP@casper.infradead.org>
 <PUZPR04MB63168DC7A1A665B4EB37C996817B2@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <ZbGCsAsLcgreH6+a@dread.disaster.area>
 <CAKYAXd-MDm-9AiTsdL744cZomrFzNRvk1Sk8wrZXsZvpx8KOzA@mail.gmail.com>
 <ZbMJWI6Bg4lTy1aZ@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbMJWI6Bg4lTy1aZ@dread.disaster.area>

On Fri, Jan 26, 2024 at 12:22:32PM +1100, Dave Chinner wrote:
> On Thu, Jan 25, 2024 at 07:19:45PM +0900, Namjae Jeon wrote:
> > We need to consider the case that mmap against files with different
> > valid size and size created from Windows. So it needed to zero out in mmap.
> 
> That's a different case - that's a "read from a hole" case, not a
> "extending truncate" case. i.e. the range from 'valid size' to EOF
> is a range where no data has been written and so contains zeros.
> It is equivalent to either a hole in the file (no backing store) or
> an unwritten range (backing store instantiated but marked as
> containing no valid data).
> 
> When we consider this range as "reading from a hole/unwritten
> range", it should become obvious the correct way to handle this case
> is the same as every other filesystem that supports holes and/or
> unwritten extents: the page cache page gets zeroed in the
> readahead/readpage paths when it maps to a hole/unwritten range in
> the file.
> 
> There's no special locking needed if it is done this way, and
> there's no need for special hooks anywhere to zero data beyond valid
> size because it is already guaranteed to be zeroed in memory if the
> range is cached in the page cache.....

but the problem is that Microsoft half-arsed their support for holes.
See my other mail in this thread.

truncate the file up to 4TB
write a byte at offset 3TB

... now we have to stream 3TB of zeroes through the page cache so that
we can write the byte at 3TB.


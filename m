Return-Path: <linux-fsdevel+bounces-29423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF551979973
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Sep 2024 00:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D7DF91C22491
	for <lists+linux-fsdevel@lfdr.de>; Sun, 15 Sep 2024 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95CAD8120C;
	Sun, 15 Sep 2024 22:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="mTN2DGVJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F5C5B216
	for <linux-fsdevel@vger.kernel.org>; Sun, 15 Sep 2024 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726440654; cv=none; b=fCaje8CndAr4rvWb4rCIuz73wRmyzrByeHsqMFgVFos/x32zJrVwLUyUe7gM3MOENh6ggDoPJeLHs75gpZ2fUFewpRkYe6q25c9FqymQ/4BUY1DpCotGJiOXceYgsRd/haeY9RVkco6Nce1eovxVDsVU6YnwPuDnPbYK/taCleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726440654; c=relaxed/simple;
	bh=btHeVEjTKwInmIgK64nHoWbwJeGZPRJGhJws92hZ7lg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fld7vpatBugkYffmWoDNsiNHk++/IRh87yqFRlrzCCIgxcqvYHrkvByJDNnvMdaBgeBTCjAZOwz+raDbzWCE4vKfjh3XQP6fSM1e/kSLh6q9PsRBr0w+XD+aWI60rVHpox4EXiU95r7oVwRncuSXPnKIAGpyoXLUos32FkxKw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=mTN2DGVJ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rlqemsvp9se8kfd4HUJk3oHn3RtA9a/H3ENlioZ19vo=; b=mTN2DGVJpTdCyb2sfbLjkHAblU
	qzuWKbxeg5hiDJ5JYf6m2JeqNLA9VyxnvfiyPcB4DbURi/W3qtnvVF1gMTxpSCDVSVFsYqslwz7Ky
	EXV9o3RuntHPafXvYWx2aKLnGnM5dwUvpKxLDZKgY2m8zWrd9t1Fql2E94lCTeNh9guAsi1UWmgBv
	pSETHOC5ZXhWNus0y8z1IBxptiyBU8wuYAP0OJjXlq7TCKC6nbaS5D4VEHOfi6sjNIRiQgVcCfGdL
	ZKnjGwb7nnLm3aBhJWbrtmtQVGkYok2d3Bq8+hAuKwWCFAC9v6vWBXERmkL3zKSgFSbeQh1iNQwQW
	Bjh0R18w==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1spy4s-00000001GZf-2PwL;
	Sun, 15 Sep 2024 22:50:46 +0000
Date: Sun, 15 Sep 2024 23:50:46 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jan Kara <jack@suse.cz>, Yafang Shao <laoar.shao@gmail.com>,
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk,
	brauner@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC] vfs: Introduce a new open flag to imply dentry
 deletion on file removal
Message-ID: <Zudkxn7KnWVqkGIm@casper.infradead.org>
References: <20240912091548.98132-1-laoar.shao@gmail.com>
 <20240912105340.k2qsq7ao2e7f4fci@quack3>
 <f7bp3ggliqbb7adyysonxgvo6zn76mo4unroagfcuu3bfghynu@7wkgqkfb5c43>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7bp3ggliqbb7adyysonxgvo6zn76mo4unroagfcuu3bfghynu@7wkgqkfb5c43>

On Thu, Sep 12, 2024 at 01:36:45PM +0200, Mateusz Guzik wrote:
> I have to note what to do with a dentry after unlink is merely a subset
> of the general problem of what to do about negative entries.  I had a
> look at it $elsewhere some years back and as one might suspect userspace
> likes to do counterproductive shit. For example it is going to stat a
> non-existent path 2-3 times and then open(..., O_CREAT) on it.
> 
> I don't have numbers handy and someone(tm) will need to re-evaluate, but
> crux of the findings was as follows:
> - there is a small subset of negative entries which keep getting tons of
>   hits
> - a sizeable count literally does not get any hits after being created
>   (aka wastes memory)
> - some negative entries get 2-3 hits and get converted into a positive
>   entry afterwards (see that stat shitter)
> - some flip flop with deletion/creation
> 
> So whatever magic mechanism, if it wants to mostly not get in the way in
> terms of performance, will have to account for the above.
> 
> I ended up with a kludge where negative entries hang out on some number
> of LRU lists and get promoted to a hot list if they manage to get some
> number of hits. The hot list is merely a FIFO and entries there no
> longer count any hits. Removal from the cold LRU also demotes an entry
> from the hot list.

This all reminds me of that paper you pointed me at.

https://arxiv.org/pdf/1512.00727

Summary for the impatient: Use 10% of the memory for a "not yet proven
to be useful" entries, and use multiple Bloom filters to decide which
ones are sufficiently useful to be added to the "more permanent" cache.

I don't think it solves every problem our current dcache implementation
has, but I'm 90% sure it'll be a huge improvement.


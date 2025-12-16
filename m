Return-Path: <linux-fsdevel+bounces-71383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BD4ECC0C1B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 04:53:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D62753002E97
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Dec 2025 03:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AE8A30FF1E;
	Tue, 16 Dec 2025 03:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JB+5ejqX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74CEF309EF5;
	Tue, 16 Dec 2025 03:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765857210; cv=none; b=aoNPaA68W80vI9dKFarztxdJxDT03hlK97YkGGGhKpRsWIw66lNXnlKqKLk6KPbfr13bRwd+OnlZQ9YFMWk0VuO011veJGW+tl8q4xZUq+NLBQfiBHYx7NMxCwP9ncj0/Fpw9uwJaS71ATHtlEPH7pCR0iSvHe0MKv1CNl26Xv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765857210; c=relaxed/simple;
	bh=oVAsmVEtvlg48+EshYwMW+S0HH5CvoLh3AmIQ1t2mTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rwLKJPddmw6TQi+yeJ3gFBVC5QYTvglUV272qQsjjVZJLrHMaHOUXzLDSFfkckAHbsk/qyODfxRIPQlX7yNV/laCY04MZsieOTVPHfx/yZvpDQn4TRaZnfOVuABiIC9dXnG0bY0NQNf8Crs+vHRomXY+fz2mOLMhLxsvZ6p/5Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JB+5ejqX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=64NwuPvbdpCK0JttfTKet//HJpHaJvO+yNGslTME2Zk=; b=JB+5ejqXSSsBBruNtD6JEmqINs
	urZTRcjrObJDhcfY2uYv9C3omLGiQsTACPBJ/NWJ5aTok9fOy9vboRY5mkQJjrIhBmywBKRID+OdA
	a/+8M2WyYWsIa+5yY9MMo9RKm/4SQtTUHLUwVn8WLd7b9by4d7+669qPl8LyRAyRvHDyiENT61L6S
	BMt1HV0+Y5crydJdX2vXu/IRLCC5W05ChrMgWQfFhBPOSzl65pJlh8dPRL/vBVT4tRJUr0LoM6rGb
	G9oRBwO5yZHIwC9Zryswo+NRT7MUSX7QB5j/xTs0RwteHxrJKNnAXQ0nhm+Eq46X1dXh/VzUybdFw
	dNsfrskg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVM7h-00000002mHM-3hBf;
	Tue, 16 Dec 2025 03:53:17 +0000
Date: Tue, 16 Dec 2025 03:53:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/readahead: read min folio constraints under
 invalidate lock
Message-ID: <aUDXrYgwZAMYkXVu@casper.infradead.org>
References: <20251215141936.1045907-1-wangjinchao600@gmail.com>
 <aUAZn1ituYtbCEdd@casper.infradead.org>
 <aUC32PJZWFayGO-X@ndev>
 <aUDG_vVdM03PyVYs@casper.infradead.org>
 <aUDOCPDa-FURkeob@ndev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUDOCPDa-FURkeob@ndev>

On Tue, Dec 16, 2025 at 11:12:21AM +0800, Jinchao Wang wrote:
> On Tue, Dec 16, 2025 at 02:42:06AM +0000, Matthew Wilcox wrote:
> > On Tue, Dec 16, 2025 at 09:37:51AM +0800, Jinchao Wang wrote:
> > > On Mon, Dec 15, 2025 at 02:22:23PM +0000, Matthew Wilcox wrote:
> > > > On Mon, Dec 15, 2025 at 10:19:00PM +0800, Jinchao Wang wrote:
> > > > > page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
> > > > > constraints before taking the invalidate lock, allowing concurrent changes to
> > > > > violate page cache invariants.
> > > > > 
> > > > > Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
> > > > > allocations respect the mapping constraints.
> > > > 
> > > > Why are the mapping folio size constraints being changed?  They're
> > > > supposed to be set at inode instantiation and then never changed.
> > > 
> > > They can change after instantiation for block devices. In the syzbot repro:
> > >   blkdev_ioctl() -> blkdev_bszset() -> set_blocksize() ->
> > >   mapping_set_folio_min_order()
> > 
> > Oh, this is just syzbot doing stupid things.  We should probably make
> > blkdev_bszset() fail if somebody else has an fd open.
> 
> Thanks, that makes sense.
> Tightening blkdev_bszset() would avoid the race entirely.
> This change is meant as a defensive fix to prevent BUGs.

Yes, but the point is that there's a lot of code which relies on
the AS_FOLIO bits not changing in the middle.  Syzbot found one of them,
but there are others.


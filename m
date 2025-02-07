Return-Path: <linux-fsdevel+bounces-41268-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6897A2D07E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 23:30:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E691A1888CDF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 22:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 263B21C7003;
	Fri,  7 Feb 2025 22:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TliR2Ibm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967DD19CD13;
	Fri,  7 Feb 2025 22:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738967401; cv=none; b=Vrx+pU4LeQkhhbWVXbvwO+ntPArfNcpi0DOqDqJnuQjvi7wok4huVClRqOTL8FquGxsekb2cy36O04RQCkd3E6bXg4gAJqGVri/Xs4B5BQzvlH75CDdn9yRksocsM9ePiNCdpjQ9xcuDQORmSKTWbDEV+8117nzLRBNSIgsweVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738967401; c=relaxed/simple;
	bh=VORfoixWND1EdNRfn9r90WVhSJ0cjr21spkOTDrOjII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bUYDlFJSAGwk41bH285zD34unYKIbs26r9nWSKqjAKEUebMiraZk3Ou+XWOowhKvpCqTn62JbDGSxGFQJfwpCFrdbuunNqXtuSzpk1uJhyJ7PJX1itfpo+SO5qYBVLxdAxhM0eVa0yDIOUcimW7raZZbJJarYIBU3aZgjBpbA/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TliR2Ibm; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=iwyiGppbNocaIaOIGmwIgHsJ5j+0ZIA7Ss/btyu1daA=; b=TliR2IbmHPe+my3kZwyOEfgQyf
	GC+ekNottY+PZcaFE99Lmx93J+PvUdFIUlwbYT+kn7nUg5+H4QFzKYBz4btuUvtMeacr/sT60HT2g
	fncT0uFdZYFf0r+5GFQnCayQ8jyURcbo6znfGVljWO/bzdVKUN4BUS59ueuBwpSh94k8ZyK9sTRIa
	A7/KrfD6rXOWD1uY0F/arTQWorjSo0xzzmfnO/akia3FnZzoGvR7lyBgxM5XpxtBXTiD9Bs+TmQdv
	lWEX75AddXRjoAh2AJZd3Oq4W+2tfWMLQnJIg0g2bxDbrqnZ603zIbNMcYmOuQ70RWK5b6/denmxs
	bd6InkoA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tgWrE-00000008m1X-29MR;
	Fri, 07 Feb 2025 22:29:56 +0000
Date: Fri, 7 Feb 2025 22:29:56 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Josef Bacik <josef@toxicpanda.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Christian Heusel <christian@heusel.eu>,
	Miklos Szeredi <mszeredi@redhat.com>, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Joanne Koong <joannelkoong@gmail.com>,
	linux-mm <linux-mm@kvack.org>,
	Mantas =?utf-8?Q?Mikul=C4=97nas?= <grawity@gmail.com>
Subject: Re: [REGRESSION][BISECTED] Crash with Bad page state for
 FUSE/Flatpak related applications since v6.13
Message-ID: <Z6aJZO2MzOgI4wG8@casper.infradead.org>
References: <2f681f48-00f5-4e09-8431-2b3dbfaa881e@heusel.eu>
 <CAJfpegtaTET+R7Tc1MozTQWmYfgsRp6Bzc=HKonO=Uq1h6Nzgw@mail.gmail.com>
 <9cd88643-daa8-4379-be0a-bd31de277658@suse.cz>
 <20250207172917.GA2072771@perftesting>
 <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f7333f2-1ba9-4df4-bc54-44fd768b3d5b@suse.cz>

On Fri, Feb 07, 2025 at 07:39:02PM +0100, Vlastimil Babka wrote:
> On 2/7/25 18:29, Josef Bacik wrote:
> > On Fri, Feb 07, 2025 at 05:49:34PM +0100, Vlastimil Babka wrote:
> >> On 2/7/25 10:34, Miklos Szeredi wrote:
> >> > [Adding Joanne, Willy and linux-mm].
> >> > 
> >> > 
> >> > On Thu, 6 Feb 2025 at 11:54, Christian Heusel <christian@heusel.eu> wrote:
> >> >>
> >> >> Hello everyone,
> >> >>
> >> >> we have recently received [a report][0] on the Arch Linux Gitlab about
> >> >> multiple users having system crashes when using Flatpak programs and
> >> >> related FUSE errors in their dmesg logs.
> >> >>
> >> >> We have subsequently bisected the issue within the mainline kernel tree
> >> >> to the following commit:
> >> >>
> >> >>     3eab9d7bc2f4 ("fuse: convert readahead to use folios")
> >> 
> >> I see that commit removes folio_put() from fuse_readpages_end(). Also it now
> >> uses readahead_folio() in fuse_readahead() which does folio_put(). So that's
> >> suspicious to me. It might be storing pointers to pages to ap->pages without
> >> pinning them with a refcount.

you don't need to pin them with a refcount.  the folio is locked, so the
page cache has a refcount until you unlock it (possibly by calling
folio_end_read()).



Return-Path: <linux-fsdevel+bounces-13114-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B20F86B6B4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD4B1C2591D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4913A5B1E7;
	Wed, 28 Feb 2024 18:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ILNN4HEV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A886679B83
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 18:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709143493; cv=none; b=YzeOvaEfD/atyZwtiXVjZ4nAc5br4PzICc7wdGnHKm/iUN/EQzS5oMV79IBi/BtiNtMF9l4yqVNsKj0sbxTbsi6Gc7HlInY1eDGa7nXtwXnFPiWwjxswhl1likffOhfeJDfp8xxQAQeJ8jTDiWsUdZ5EXTay3WBKP60yFhnvDW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709143493; c=relaxed/simple;
	bh=oabw/X8XF+Boj1BSGHds7dPKmBzdgs7nfuXKfJWHtC8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DeRKGUEuk6S4q+Wa99m7Csq3LDN3DpRpL5F/05USuCNYvfI4WjHkJaLiG91HT9eSJOqyPGamEmLPeIwFbIf5ERXOIG7icTSUUD02Qy6JEV4dBZi/51VXeaNb7hqnTVy15RwQwT1hkcWcrqDB2IHm8A1dCUtg2+Ok+ZtxiG4olqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ILNN4HEV; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zpae6JWvwsxyRNz19RcMzmZiYrN3iievkxJaXRzgsOg=; b=ILNN4HEV828WiuM3dN1kuV4dI0
	kIRyCwC/0SkSsrKmFYvbC1UWtWOhKi0tUdQME7u/gBECAIxrVcjqUIGs9S7JY0oSwX/UFeKK4QO77
	SiZ3K6I2pHs3ANrOjQRt+Os3aq1MXIjNvmHyQPhEWAvHORK3byuZdgSfh3SGOuOKjczelEA+wVTkC
	WEzmCXSZghRoIUG5YoIrmN7xSkxEGxv8qVOvzLbtFdQvaCkYoP6wpyZyK7VSYDVUwIYYdhDmDGNaK
	UfbCxSheZjWCL2YiSbKMcCl9IeDyx+/Psqd45GA81f3Tp7kb6sWVU9HxhV0eyTYyQ5GQMI7mjemiM
	AvZxoxDg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfOIO-00000005q7d-0iCL;
	Wed, 28 Feb 2024 18:04:44 +0000
Date: Wed, 28 Feb 2024 18:04:44 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zd91vNnJCwJqV7pV@casper.infradead.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
 <4rde5abojkj6neokif4j6z4bgkqwztowfiiklpvxramiuhvzjb@ts5af6w4bl4t>
 <Zd6h1C5z_my3jhgU@casper.infradead.org>
 <Zd61CH2jLe0Orrjr@casper.infradead.org>
 <72fsezoex3soqbjsuabjzyzhlbeouy2uu75h5hcia3stwfv7q4@batxjbhkcnnc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <72fsezoex3soqbjsuabjzyzhlbeouy2uu75h5hcia3stwfv7q4@batxjbhkcnnc>

On Wed, Feb 28, 2024 at 12:34:41PM -0500, Kent Overstreet wrote:
> But even better would be if we could get lockdep to support folio locks,
> then we could define a lockdep comparison function. Of course, there's
> no place to stick a lockdep map, but I think technically lockdep could
> do everything it needs to do without state in the lock itself, if only
> that code didn't make my eyes bleed whenever I have to dig into it...

I don't think lockdep can support folio locks.  They're taken in process
context and (for ->read_folio) released in interrupt context.  Also we
can return to userspace while holding folio locks (I believe ...)

DEPT claims to be able to handle them, but I haven't looked in detail.


Return-Path: <linux-fsdevel+bounces-17403-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF2068AD027
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 17:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 638641F22A11
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Apr 2024 15:04:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913F1152507;
	Mon, 22 Apr 2024 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="o7QGfXhh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F296152523;
	Mon, 22 Apr 2024 15:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713798249; cv=none; b=gkqNUGPjBV+DKpwrn5H7rsnOdzU9cFuNDQT8J37iX84h7TTDWPGFJx8JwDtvCjdeLYcgr/om1PqmDNdK0/xFKkZQPIu2o/oLOgNaEX9cK31LWLLTQJkXFJxoVzQCCjBysIsH0SbAMA6xWcbn6jxd7CNZvQ78uDLlLgPfcUlOftY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713798249; c=relaxed/simple;
	bh=VZp1ze4DEOu4wpjMf4hEXpSipiJP0UAh6yOnK1vmw4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fiy8aJF29qygWG0N2ZB16dEPApEbqNhQcoSOOzB/mQfS4/zjnIUBZbOFC/z8ML1TPENa45uj7hJfR2SlbpzKasIG5UX/fcon/dbBbv/u5fFWQ0qjKFuYRxKxf3aMYRsoLsrfHE4PaWZDMzJR0UvtgcEl6LHdEAoNSB3y2DAxEfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=o7QGfXhh; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9wOxkCOVRUK81zz0hYioTjDzHLgukrv7N/ab7G/DRNA=; b=o7QGfXhheNbrl27ixrfNEePXFu
	4EC2dL/ybNPCi8XDCdOuhFFL0X9/z3IYjbr+zsZK5siFquEowAhkX6PMaZCtL5DhkbNXpMtiJyC7B
	scW9a4mVAaSDGxZXHh+U3DpyXXhFuUZ82vPnPl71Q2eIylZmpzJKjGm58lHVYt1LzesNH4H7qgROa
	JQmZC6JyjbGTZ7FVcqdanxUsEyo/EFUtFe3PFlgw+L+n4kdHWoUdDU3UcoY/sKUGaet3ButT4lFOr
	Hc1atYWmqG+TVDNf0nyOfSRo827jxVKj+8DDeKCps++KJa56x0zmR2wpBc8Wy9l0/ogfdbIh/xMHN
	tCfZ7WSQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ryvD2-0000000ERS1-3CAX;
	Mon, 22 Apr 2024 15:03:56 +0000
Date: Mon, 22 Apr 2024 16:03:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: John Garry <john.g.garry@oracle.com>
Cc: axboe@kernel.dk, brauner@kernel.org, djwong@kernel.org,
	viro@zeniv.linux.org.uk, jack@suse.cz, akpm@linux-foundation.org,
	dchinner@redhat.com, tytso@mit.edu, hch@lst.de,
	martin.petersen@oracle.com, nilay@linux.ibm.com,
	ritesh.list@gmail.com, mcgrof@kernel.org,
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, ojaswin@linux.ibm.com, p.raghav@samsung.com,
	jbongio@google.com, okiselev@amazon.com
Subject: Re: [PATCH RFC 5/7] fs: iomap: buffered atomic write support
Message-ID: <ZiZ8XGZz46D3PRKr@casper.infradead.org>
References: <20240422143923.3927601-1-john.g.garry@oracle.com>
 <20240422143923.3927601-6-john.g.garry@oracle.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240422143923.3927601-6-john.g.garry@oracle.com>

On Mon, Apr 22, 2024 at 02:39:21PM +0000, John Garry wrote:
> Add special handling of PG_atomic flag to iomap buffered write path.
> 
> To flag an iomap iter for an atomic write, set IOMAP_ATOMIC.
> 
> For a folio associated with a write which has IOMAP_ATOMIC set, set
> PG_atomic.
> 
> Otherwise, when IOMAP_ATOMIC is unset, clear PG_atomic.
> 
> This means that for an "atomic" folio which has not been written back, it
> loses it "atomicity". So if userspace issues a write with RWF_ATOMIC set
> and another write with RWF_ATOMIC unset and which fully or partially
> overwrites that same region as the first write, that folio is not written
> back atomically. For such a scenario to occur, it would be considered a
> userspace usage error.
> 
> To ensure that a buffered atomic write is written back atomically when
> the write syscall returns, RWF_SYNC or similar needs to be used (in
> conjunction with RWF_ATOMIC).
> 
> As a safety check, when getting a folio for an atomic write in
> iomap_get_folio(), ensure that the length matches the inode mapping folio
> order-limit.
> 
> Only a single BIO should ever be submitted for an atomic write. So modify
> iomap_add_to_ioend() to ensure that we don't try to write back an atomic
> folio as part of a larger mixed-atomicity BIO.
> 
> In iomap_alloc_ioend(), handle an atomic write by setting REQ_ATOMIC for
> the allocated BIO.
> 
> When a folio is written back, again clear PG_atomic, as it is no longer
> required. I assume it will not be needlessly written back a second time...

I'm not taking a position on the mechanism yet; need to think about it
some more.  But there's a hole here I also don't have a solution to,
so we can all start thinking about it.

In iomap_write_iter(), we call copy_folio_from_iter_atomic().  Through no
fault of the application, if the range crosses a page boundary, we might
partially copy the bytes from the first page, then take a page fault on
the second page, hence doing a short write into the folio.  And there's
nothing preventing writeback from writing back a partially copied folio.

Now, if it's not dirty, then it can't be written back.  So if we're
doing an atomic write, we could clear the dirty bit after calling
iomap_write_begin() (given the usage scenarios we've discussed, it should
always be clear ...)

We need to prevent the "fall back to a short copy" logic in
iomap_write_iter() as well.  But then we also need to make sure we don't
get stuck in a loop, so maybe go three times around, and if it's still
not readable as a chunk, -EFAULT?


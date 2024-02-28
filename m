Return-Path: <linux-fsdevel+bounces-13040-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA17F86A6FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 04:00:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 597571F2C141
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 03:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E071F615;
	Wed, 28 Feb 2024 03:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Uxc0gWyK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC92F1EA7D
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 03:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709089249; cv=none; b=F4K+Vwi7IEUWxm+TQL0fOJwMN9xD49skmU/rjbsQ+xrMRgbrlcDwks0AmGibDglkegHuHd7ltrp8zTcn3a73pXjFS8fgsnZ0t4MFADu2LpJvRSPTTNonich8h4W+ma/Vh//swVsUXXdnH7Fa7PNXWlTcZtKjhzW5wPtFlSlBLMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709089249; c=relaxed/simple;
	bh=iYSW7x9eU+6LN4ojBfIaxISfX3Ki6gPCQffd8s0Whqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NZ7w8g0zIPIlm71MovTXhQj1jDybFSrfywOmwSKF2UoVZqjQaE+6AuW9s8lmY8ySjQq8zmVenaf4mYhH70m4MLbhxCKA05b6Uy/ar9UMH6xxy+hhKz6e7of26IfiRIVtcJ2FU6hEsuARNh7y+1EOvcMqkcT+xASE2dcc6CJL5ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Uxc0gWyK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sAWt2GDzRXYw3zCQQYr+dyiN5wr3k4AQFEzQZcbFBO4=; b=Uxc0gWyKj982/7Ouy90KNI7MSk
	SxGW0s6iaSAsAO8XYD/nrKK9dNCFuDsADnfRCrXEI02aHkXgzX+irQOBLpr13+ZiLzTkSW15e7iK3
	h5EqcJA/cu+5g+6ha/AX6mKOurIBGCd3xShgFeN74zcEX8X1E2Zzl5faAiZ8N1+fGWSJJ0+soWtqV
	QgV/y6jA6IyDZQbR3hxq73Ej7z0qOWQRZKPGK3bUG2EMtbFY6+e2VIjfcBSqbqiVWb1aOFUS5t0GR
	WxrL8hQ1OQeHW31YzsXilZ7vNApPMec+fsftkmRWB0KJ/FGHhA18q0BUqHm9IxwxvjJdmNKaIksxK
	IQjmDAHA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfABQ-000000045RB-0ZNr;
	Wed, 28 Feb 2024 03:00:36 +0000
Date: Wed, 28 Feb 2024 03:00:36 +0000
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
Message-ID: <Zd6h1C5z_my3jhgU@casper.infradead.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
 <4rde5abojkj6neokif4j6z4bgkqwztowfiiklpvxramiuhvzjb@ts5af6w4bl4t>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4rde5abojkj6neokif4j6z4bgkqwztowfiiklpvxramiuhvzjb@ts5af6w4bl4t>

On Tue, Feb 27, 2024 at 09:22:26PM -0500, Kent Overstreet wrote:
> Which does raise the question of if we've ever attempted to define a
> lock ordering on folios. I suspect not, since folio lock doesn't even
> seem to have lockdep support.

We even wrote it down!

                /*
                 * To avoid deadlocks between range_cyclic writeback and callers
                 * that hold pages in PageWriteback to aggregate I/O until
                 * the writeback iteration finishes, we do not loop back to the
                 * start of the file.  Doing so causes a page lock/page
                 * writeback access order inversion - we should only ever lock
                 * multiple pages in ascending page->index order, and looping
                 * back to the start of the file violates that rule and causes
                 * deadlocks.
                 */

(I'll take the AR to put this somewhere better like in the folio_lock()
kernel-doc)


Return-Path: <linux-fsdevel+bounces-13112-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23DB686B621
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 555671C242A5
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 17:35:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505ED15B0FF;
	Wed, 28 Feb 2024 17:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Xsv9APsW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBB12DD9B
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 17:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709141691; cv=none; b=AZ7ks+0ozQjYZ7E3MHR7R4Y6SunJLFD0fa855z31pk6Mqn2Dj0vnVM7vqSGteH9IdDfAIwFigAs7fJ6o7iTl8X6+Ti0Hz50cpViFcWv0w2HDnXMBbGJOj0Fs51oO3/KqD6rpXarewp7EEkKrwX+LxFuymz4+eyTvaRwkJEy5t2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709141691; c=relaxed/simple;
	bh=/y2+Ocs/CJLnqSRQ1X3pkrJpE6vwmHXfmyq54ja6x/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IWEvcJbd/HUnGLdWgfRuvZxhr5FI8IqRqUwpaj67/e5yuXiGFTVehCpGk5d/8k+/BWA01b2UcDMOATesDM7pcN2mT1AFc/CyDJOXhO2sgvbPBgdueq4GlPO/ioGnIP1FlTz47cbfDD1Wu2j62r+ng4+6Wo5f+lHQRt3zkOQRsn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Xsv9APsW; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 12:34:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709141686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+VifRWwyg3xehvBuDElHHRvJUjq5o45Rw/PLy+arOnY=;
	b=Xsv9APsWCSfWJDO4O5xvhuSfrLNc9l9CaZfiaDYepMthbWLm5DHwI/BbnTz7ZBAasJ94Ic
	1dYvQAUL5fkU+2++Q1kRckkSiL/hpZQKuHdOpFegNlZ6vAvX1KNlx8Hvw7z9aCE2+0aXg3
	gidQV3MIchIu/ac2GjY4LXOD1/rqdqQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Dave Chinner <david@fromorbit.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, 
	Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <72fsezoex3soqbjsuabjzyzhlbeouy2uu75h5hcia3stwfv7q4@batxjbhkcnnc>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
 <4rde5abojkj6neokif4j6z4bgkqwztowfiiklpvxramiuhvzjb@ts5af6w4bl4t>
 <Zd6h1C5z_my3jhgU@casper.infradead.org>
 <Zd61CH2jLe0Orrjr@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zd61CH2jLe0Orrjr@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 28, 2024 at 04:22:32AM +0000, Matthew Wilcox wrote:
> On Wed, Feb 28, 2024 at 03:00:36AM +0000, Matthew Wilcox wrote:
> > On Tue, Feb 27, 2024 at 09:22:26PM -0500, Kent Overstreet wrote:
> > > Which does raise the question of if we've ever attempted to define a
> > > lock ordering on folios. I suspect not, since folio lock doesn't even
> > > seem to have lockdep support.
> > 
> > We even wrote it down!
> > 
> >                 /*
> >                  * To avoid deadlocks between range_cyclic writeback and callers
> >                  * that hold pages in PageWriteback to aggregate I/O until
> >                  * the writeback iteration finishes, we do not loop back to the
> >                  * start of the file.  Doing so causes a page lock/page
> >                  * writeback access order inversion - we should only ever lock
> >                  * multiple pages in ascending page->index order, and looping
> >                  * back to the start of the file violates that rule and causes
> >                  * deadlocks.
> >                  */
> > 
> > (I'll take the AR to put this somewhere better like in the folio_lock()
> > kernel-doc)
> 
> Um.  I already did.
> 
>  * Context: May sleep.  If you need to acquire the locks of two or
>  * more folios, they must be in order of ascending index, if they are
>  * in the same address_space.  If they are in different address_spaces,
>  * acquire the lock of the folio which belongs to the address_space which
>  * has the lowest address in memory first.
> 
> Where should I have put this information that you would have found it,
> if not in the kernel-doc for folio_lock()?

I should have seen that :)

But even better would be if we could get lockdep to support folio locks,
then we could define a lockdep comparison function. Of course, there's
no place to stick a lockdep map, but I think technically lockdep could
do everything it needs to do without state in the lock itself, if only
that code didn't make my eyes bleed whenever I have to dig into it...


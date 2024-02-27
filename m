Return-Path: <linux-fsdevel+bounces-12985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682C9869CAE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 99C0C1C22925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B29221A0D;
	Tue, 27 Feb 2024 16:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YEPm4BBz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF76B8836
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 16:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052443; cv=none; b=JqCSZMX+4CG8KjHK+tDkVrbvSd+l572Eg0P6nJZYLRcHJ0jZXYyb9sWvaABHw25mhhBiIORjDdAl0QSTcZW2mkyfCcNpAS/2pIyCrsurZUATEP0iWY6NugQSinQLbsE7wopWgWSuUeVKJCKmBouaO69zKv4WI0LWQ6HbzUr5gHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052443; c=relaxed/simple;
	bh=OyD/UMKZwBrsu9d0MyXysWv50AV+T4xANhh2hADFwx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8LjLQWuj41IQPHGU5Y6nClsTXMbn6B3km09KQO/ACmXGT+oHQy2CENkzSH88TdwNoeZ0BuPCqg8pLYt8CpRhS73GWzPKlUNDSlAX3jkczQsgk2Y+3R/Wxg98LZTlpx3J/vN0ta3vi+hwVb+DARE4xA1o6m+BVY8METdZ2J7KAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YEPm4BBz; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 11:47:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709052440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LGhnV7TgQ2b5lk4l9Kz2D+muZJoRnjVX9G5PhG3JMSE=;
	b=YEPm4BBzrniApWndG3FrH+yE26+DUgNtFLHty5oyUQCFSz7G5YjQ7GeJOq1hswinm/NNWY
	AXWDRy2BVBMvddTRP9JKO9H87jDavuFUkXCEEj3N2YAqSGmhKiLjNbSvCwMHI2+GiIpFq9
	l1YKP17CN3Ngo6eCVqFoiqzt2JjT47U=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <hnmf36wwh3yahmcyqlbgnhidcsgmfg4jnat2n6m2dxz655cxt7@gm7qddu2cshm>
References: <Zduto30LUEqIHg4h@casper.infradead.org>
 <CAHk-=wibYaWYqs5A30a7ywJdsW5LDT1LYysjcCmzjzkK=uh+tQ@mail.gmail.com>
 <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
 <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>
 <CAHk-=wjRXSvwq70=G3gDPoaxd3R0PDOnYj7fxOhZ=esiNjFvrA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjRXSvwq70=G3gDPoaxd3R0PDOnYj7fxOhZ=esiNjFvrA@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 08:34:39AM -0800, Linus Torvalds wrote:
> On Mon, 26 Feb 2024 at 23:22, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Only rough testing, but  this is looking like around a 25% performance
> > increase doing 4k random reads on a 1G file with fio, 8 jobs, on my
> > Ryzen 5950x - 16.7M -> 21.4M iops, very roughly. fio's a pig and we're
> > only spending half our cpu time in the kernel, so the buffered read path
> > is actually getting 40% or 50% faster.
> >
> > So I'd say that's substantial.
> 
> No,  you're doing something wrong. The new fastread logic only
> triggers for reads <= 128 bytes, so you must have done some other
> major change (like built a kernel without the mitigations, and
> compared it to one with mitigations - that would easily be 25%
> depending on hardware).

Like I replied to willy - the "4k" was a typo from force of habit, I was
doing 64 byte random reads.


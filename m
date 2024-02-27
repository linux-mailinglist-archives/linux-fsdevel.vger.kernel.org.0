Return-Path: <linux-fsdevel+bounces-12902-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B6B868500
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 01:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84A5AB212A8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 00:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DDFE1847;
	Tue, 27 Feb 2024 00:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jwUiiVI7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9450A81F
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 00:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708993804; cv=none; b=NTRVWxpPeC7jekqYmpwN++IrPGn0Ew24ZRRRIorMALdXBCjThIYFAMM7Oj/IkG4fMmpO3Ny/X8qnbvN6PMD0lKx4i5SlFTD3A1iXOSLL9q5vaAMTyIc+UlHn7wEAWN7k9fWYrfllGcYLA+3BXdOfkLz+B7qETe4Y+WOdB6IFeIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708993804; c=relaxed/simple;
	bh=s0P1626ZVcvwNhAm22+dweGvnxzZrIQtqLyaE+C8ycE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qjDygIqqm0A2wRZY6Dpa4Cr1oyzGCc6VLa+z8TZt5nWO49dE/Ei3eJl9Gjfd9Z76xwVZpQY49FIZWPMzMVh2CILgXz+y9/SnJ0nODbbuOlmgUTYTwapginhXfAVFCgwtF79AQ1AM8IYafhSlRkrON0CT4PCqg21PN0v595Tos4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jwUiiVI7; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 26 Feb 2024 19:29:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708993799;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cMAF2+RO/i9jccfOlie00oTKoBCg2uxgQRQWz3UieL4=;
	b=jwUiiVI77v0gv4YJyGN19qrocyA+5zTk9pNVydUoUKl6g5+fomjOXrGbFP0V5qZ6oazBzr
	vNb5iZlepSDvVzC7vpLaa1J6eK57dM9pP2n/E3CXIxREHZ3pmR8Ne+Jv2xNwv7VtY+Y6J5
	K9VEiXlqi7bT3jXvblEeiuhfyzwEGcs=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Matthew Wilcox <willy@infradead.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Al Viro <viro@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>, 
	Daniel Gomez <da.gomez@samsung.com>, Pankaj Raghav <p.raghav@samsung.com>, 
	Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <oraht3mt3iu7u6q22pvb3du3xjpgei5cncbu4a22mz5scamsq5@fooyqelkfy6u>
References: <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <Zdz9p_Kn0puI1KEL@casper.infradead.org>
 <znixgiqxzoksfwwzggmzsu6hwpqfszigjh5k6hx273qil7dx5t@5dxcovjdaypk>
 <upnvhnqaitifuwwbxcpa4zgf2hribfrtqzxtcrv5djbyjs2ond@axetql2wrwnt>
 <fb4d944e-fde7-423b-a376-25db0b317398@paulmck-laptop>
 <5c6ueuv5vlyir76yssuwmfmfuof3ukxz6h5hkyzfvsm2wkncrl@7wvkfpmvy2gp>
 <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efb40e53-dae5-44c8-9e15-3cbf3a0cf537@paulmck-laptop>
X-Migadu-Flow: FLOW_OUT

On Mon, Feb 26, 2024 at 04:05:37PM -0800, Paul E. McKenney wrote:
> On Mon, Feb 26, 2024 at 06:29:43PM -0500, Kent Overstreet wrote:
> > Well, we won't want it getting hammered on continuously - we should be
> > able to tune reclaim so that doesn't happen.
> > 
> > I think getting numbers on the amount of memory stranded waiting for RCU
> > is probably first order of business - minor tweak to kfree_rcu() et all
> > for that; there's APIs they can query to maintain that counter.
> 
> We can easily tell you the number of blocks of memory waiting to be freed.
> But RCU does not know their size.  Yes, we could ferret this on each
> call to kmem_free_rcu(), but that might not be great for performance.
> We could traverse the lists at runtime, but such traversal must be done
> with interrupts disabled, which is also not great.
> 
> > then, we can add a heuristic threshhold somewhere, something like 
> > 
> > if (rcu_stranded * multiplier > reclaimable_memory)
> > 	kick_rcu()
> 
> If it is a heuristic anyway, it sounds best to base the heuristic on
> the number of objects rather than their aggregate size.

I don't think that'll really work given that object size can very from <
100 bytes all the way up to 2MB hugepages. The shrinker API works that
way and I positively hate it; it's really helpful for introspection and
debugability later to give good human understandable units to this
stuff.

And __ksize() is pretty cheap, and I think there might be room in struct
slab to stick the object size there instead of getting it from the slab
cache - and folio_size() is cheaper still.


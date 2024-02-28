Return-Path: <linux-fsdevel+bounces-13128-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62F486B827
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 20:30:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 614BE28AB78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D5F74423;
	Wed, 28 Feb 2024 19:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sfKDi1Jw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C06D74403
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 19:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709148599; cv=none; b=k5jrtOnJiqfPdn+ArI1nN/q1LQSpTJqGCDQBybDkFPgqBb5PMJPXwQqmfNyvPCwkqjj8lIdcInxX1cti/KXeC1UnHKiLejclJ/WCeAnUiBDAuNmL3iI1MIawQH9+W4LqpqpEqUZdksPv7Bz+tQl/GnCddstOfhYZQBaQNSoRjA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709148599; c=relaxed/simple;
	bh=gIUMzqVfl7lOg4t7Mw9LXkzrFAMgZcevb5FuiDPsHMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UV3ayyZKWVKLKNeH0MvPgs6+4M+YuZSTNvIzXdU/HO1VuPHV41gh19zSyC3LfL9SleQ3pl3EF3Hc2qU3oLkEz6tLjTq3pQJycGCpk/G3xHf5M5k8o4cZ7bKSA1nFIzS2OJjUu/4zrPAEDncfv3Lx73vmPZobVi2WH3/u3oI8kvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sfKDi1Jw; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 14:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709148595;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3bEiqF8nKNDfPOHcfJQT88nOjb9dvia7MJkVhkJVj+I=;
	b=sfKDi1JwoWb11G1OH2fvye9orutfpFajmw3ximt3T/JXfuCnp6fai/xBsJaKAS4TdxUHMF
	8o242ulyHfrbBbbKBEo30TO5GuInCXxUduZvWiLxM2d750Yb0YH30PQ6ee2qc8k9qATMKx
	bDMd7pq7x7ONpXJJnCb/MlGSUg5BLzE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dave Chinner <david@fromorbit.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>, 
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Matthew Wilcox <willy@infradead.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <amsqvy3aq5mzyk7esf5mzzgdjl32gosq5fgphjv5qzp6r25dke@sadcguvzo26m>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
 <4uiwkuqkx3lt7cbqlqchhxjq4pxxb3kdt6foblkkhxxpohlolb@iqhjdbz2oy22>
 <CAHk-=wiMf=W68wKXXnONVc9U+W7mfuhuHMHcowoZwh0b6SXPNg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiMf=W68wKXXnONVc9U+W7mfuhuHMHcowoZwh0b6SXPNg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Wed, Feb 28, 2024 at 11:09:53AM -0800, Linus Torvalds wrote:
> On Wed, 28 Feb 2024 at 10:18, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > I think we can keep that guarantee.
> >
> > The tricky case was -EFAULT from copy_from_user_nofault(), where we have
> > to bail out, drop locks, re-fault in the user buffer - and redo the rest
> > of the write, this time holding the inode lock.
> >
> > We can't guarantee that partial writes don't happen, but what we can do
> > is restart the write from the beginning, so the partial write gets
> > overwritten with a full atomic write.
> 
> I think that's a solution that is actually much worse than the thing
> it is trying to solve.
> 
> Now a concurrent reader can actually see the data change twice or
> more. Either because there's another writer that came in in between,
> or because of threaded modifications to the source buffer in the first
> writer.

Yeah, that's a wrinkle.

But that requires a three way race to observe; a race between a reader
and multiple writers, and the reader doing multiple reads.

The more concerning sitution to me would be if breaking write atomicity
means that we end up with data in the file that doesn't correspond to an
total ordering of writes; e.g. part of write a, then write b, then the
rest of write a overlaying part of write b.

Maybe that can't happen as long as writes are always happening in
ascending folio order?


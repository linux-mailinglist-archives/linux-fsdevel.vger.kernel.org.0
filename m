Return-Path: <linux-fsdevel+bounces-12992-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B035869D5C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 18:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C8F91C22FB6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Feb 2024 17:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA90487BF;
	Tue, 27 Feb 2024 17:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Sr8k9iRd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94286481BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 27 Feb 2024 17:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054414; cv=none; b=haYSs3O6F5DjGp7qxpQ7TsBJ50CjlZLiQFRPffZHb9jVN5XpkowHEH+Dkxm1AZFDNmYeGVZrPfCEwKzBaV0Tq13Iug31BQsGrtY8ikMPLCVcshXpOS1sREfWA2LryupWd7V49tphXnkWwdD9ynqHU0KbLIDJi2bSifae51bFpOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054414; c=relaxed/simple;
	bh=shSRsUrM1e+4Tl8NZT0m9A4HFFrbju3zRUUPX6BDqLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YiogQlYfAeIHGTB57Xf+O8peVA+pnJNkJ/Wvn5Brk13XsBwHsdOhMrHS4yWbKOQy87+RCms5F2wrTDv8F+Kc2SV8yD/gasneFK4AlyRRSFrfthKZAxSgM6qgwKa/B+QOuiZwwEPhFLxzjYBgRh6vv+J1jyThUFITS9kj6yfmliI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Sr8k9iRd; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 12:20:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709054410;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=M47XJuoQtfybzUrIAXoBTW9aD5NlE3aY+d3Xw/1LzFI=;
	b=Sr8k9iRdStKLQBVhBlbR3osCe/PMJjMNaN1XTFv4XebzsegUutl1uvkD17cRRQicU+BfzI
	UlmfKcJrKEL6mRVtlNkzuebdhB0MUesGRJ0vT4VhGgbx3crklNwOyXuOVZquyCcHbZ91kF
	H41aRsnaQKGjdNWA9328d/C4gm6rkuw=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Al Viro <viro@kernel.org>, Matthew Wilcox <willy@infradead.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org, 
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>, 
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>, Dave Chinner <david@fromorbit.com>, 
	Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <ti5zair3y4v66udgaqsvswl26t3wygdlwnfpyliuwgtdvpnjl2@f2f22qositjr>
References: <bk45mgxpdbm5gfa6wl37nhecttnb5bxh6wo3slixsray77azu5@pi3bblfn3c5u>
 <CAHk-=wjnW96+oP0zhEd1zjPNqOHvrddKkwp0+CuS5HpZavfmMQ@mail.gmail.com>
 <Zdv8dujdOg0dD53k@duke.home>
 <CAHk-=wiEVcqTU1oQPSjaJvxj5NReg3GzkBO8zpL1tXFG1UVyvg@mail.gmail.com>
 <CAHk-=wjOogaW0yLoUqQ0WfQ=etPA4cOFLy56VYCnHVU_DOMLrg@mail.gmail.com>
 <CAHk-=whFzKO+Vx2f8h72m7ysiEP2Thubp3EaZPa7kuoJb0k=ig@mail.gmail.com>
 <yfzkhghkh36ww5nzmkdrdpcjy6w5v6us55ccmnh2phjla25mmz@xomuheona22l>
 <CAHk-=wjRXSvwq70=G3gDPoaxd3R0PDOnYj7fxOhZ=esiNjFvrA@mail.gmail.com>
 <hnmf36wwh3yahmcyqlbgnhidcsgmfg4jnat2n6m2dxz655cxt7@gm7qddu2cshm>
 <CAHk-=wii2MLd3kE1jqoH1BcwBBiFURqzhAXCACgr+FBjT6kM6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wii2MLd3kE1jqoH1BcwBBiFURqzhAXCACgr+FBjT6kM6w@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 09:07:01AM -0800, Linus Torvalds wrote:
> On Tue, 27 Feb 2024 at 08:47, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > Like I replied to willy - the "4k" was a typo from force of habit, I was
> > doing 64 byte random reads.
> 
> Ok, can you send the exact fio command? I'll do some testing here too.
> 
>                   Linus

fio					\
	--group_reporting		\
	--gtod_reduce=1			\
	--norandommap			\
	--runtime=60s			\
	--exitall_on_error=1		\
	--filename=/root/foo		\
	--name=read			\
	--rw=randread			\
	--loops=100			\
	--numjobs=8			\
	--filesize=1G			\
	--bs=64b			\
	--io_size=10G


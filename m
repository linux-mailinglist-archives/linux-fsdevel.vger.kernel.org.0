Return-Path: <linux-fsdevel+bounces-13117-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7EF86B707
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 19:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 271D6288827
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 18:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3AA140878;
	Wed, 28 Feb 2024 18:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rxo53puZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E4040876
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 18:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709144326; cv=none; b=Q7Ae57jTUhipcSAswLj5ufQzSNdk18/60JlAexvkISP1GwcY/hW8E0paMyMbr+GNe4de3BK6j/syc0yAVh/zw2aYh5mzv6EKMhLFA0NL65R6WzuK16Ov3uz9UJqOPeo31awZLCpLC6ZEqg4uT5sz/jEPHYRZa8893XVZle5g2RI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709144326; c=relaxed/simple;
	bh=4n8EKbX7KmQhWyy8WhFBFXVY7vs/DHR6kjq383jPQXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u7+cAwMyfPddrteu7uy9xRikePNmiYaDk5za68zCwVDmLJA51hz9jRCrSWBlxbcxKYZvblfe/jvLpC0hObrrovYnma34LQDbr1rtRYPbNx+gglC3WOeSdO0MgW3z1YUPeZDfYXIf91G+wqzZVET45MrtLt3VcCr7tJwMBti7JzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rxo53puZ; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 28 Feb 2024 13:18:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709144322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ktW7gDP8RS4aqQ9o96vvdlURM8LIbWuOijf5JKN4lW0=;
	b=rxo53puZnE4Zv6zsYZHpzPwr7G8EXFsUNAN3O4uoPqcdgQdBxr9YCUZPdRQdwp2H7xfOX2
	PM/BvpSrMiuLF8C/pEssDHAlNDDGkDGzSHkbdf5eL8VZmwJyWT46w8lZTS123xjuhnyrZ+
	vfpEIr68DwKqor5TBV95Ducc5CHOhag=
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
Message-ID: <4uiwkuqkx3lt7cbqlqchhxjq4pxxb3kdt6foblkkhxxpohlolb@iqhjdbz2oy22>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <xhymmlbragegxvgykhaddrkkhc7qn7soapca22ogbjlegjri35@ffqmquunkvxw>
 <Zd5ecZbF5NACZpGs@dread.disaster.area>
 <d2zbdldh5l6flfwzcwo6pnhjpoihfiaafl7lqeqmxdbpgoj77y@fjpx3tcc4oev>
 <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjXu68Fs4gikqME1FkbcxBcGQxStXyBevZGOy+NX9BMJg@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 27, 2024 at 02:46:11PM -0800, Linus Torvalds wrote:
> On Tue, 27 Feb 2024 at 14:21, Kent Overstreet <kent.overstreet@linux.dev> wrote:
> >
> > ext4 code doesn't do that. it takes the inode lock in exclusive mode,
> > just like everyone else.
> 
> Not for dio, it doesn't.
> 
> > > The real question is how much of userspace will that break, because
> > > of implicit assumptions that the kernel has always serialised
> > > buffered writes?
> >
> > What would break?
> 
> Well, at least in theory you could have concurrent overlapping writes
> of folio crossing records, and currently you do get the guarantee that
> one or the other record is written, but relying just on page locking
> would mean that you might get a mix of them at page boundaries.

I think we can keep that guarantee.

The tricky case was -EFAULT from copy_from_user_nofault(), where we have
to bail out, drop locks, re-fault in the user buffer - and redo the rest
of the write, this time holding the inode lock.

We can't guarantee that partial writes don't happen, but what we can do
is restart the write from the beginning, so the partial write gets
overwritten with a full atomic write.

This way after writes complete we'll never have weird torn writes left
around.


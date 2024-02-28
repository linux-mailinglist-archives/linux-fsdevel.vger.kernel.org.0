Return-Path: <linux-fsdevel+bounces-13039-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E20D786A67D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 03:22:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9942AB28968
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Feb 2024 02:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFE71CFAB;
	Wed, 28 Feb 2024 02:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PlBS1kJt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 440C41CD38
	for <linux-fsdevel@vger.kernel.org>; Wed, 28 Feb 2024 02:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709086959; cv=none; b=vEjgjXymAKlzhg10pHzrd5hEceQbPRCSznsMe8BJnti3v02OSG9H3dUFCqZRyOjqSovh6pRUXZJXY5j7NmxVqsGzVXjejh1cmtzreC9aLHbz+yZS/STWRMXzQV2qnBGzNtDpAOrhx31Rho2QawTjvruPJGS8zUaL+Dqx66alRCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709086959; c=relaxed/simple;
	bh=QYVQlyZA3B6RXaIGgTZ4vOdtY46J3dbYiyNtFqjB6Ug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o/kQkyAMTJQl1N2m42lolq2+pdTxbXy5Xu+qA1u5djz2mGM5DFVwTVOIQNxgpyZ96yRUqYhSU/TxDowJIBdQVNLmfHabulIDmZA0I7H0wXeK0ezuqasS9/cXOnwEpXFHvEM40N8FHcXwV9d7kijOs8QmFWKQlDj6DAaEFMYl/iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PlBS1kJt; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 27 Feb 2024 21:22:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709086955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zyMrThEX3Qym6hlhk1CyI/mGesH2kSc0piNuyuaKQm4=;
	b=PlBS1kJtKoMBzhPTxbPVH2CwmLu8cFcKgcyvki9wh+m8Ta7WyiGE940YNB3X96RK+SLLEx
	tWFI+Nz1+fdk7MrwfdIXS03pVBPD5t52ni6Xh5qoDmGvjbb1sSNf1p0jYEQP3Iq6zT6DBR
	SqGZ4qgnhIrYnPQ/10zZ07jiWoJdBeY=
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
Message-ID: <4rde5abojkj6neokif4j6z4bgkqwztowfiiklpvxramiuhvzjb@ts5af6w4bl4t>
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
> 
> I'm not sure that such a model would make any sense, but if you
> *intend* to break if somebody doesn't do write-to-write exclusion,
> that's certainly possible.
> 
> The fact that we haven't given the atomicity guarantees wrt reads does
> imply that nobody can do this kinds of crazy thing, but it's an
> implication, not a guarantee.
> 
> I really don't think such an odd load is sensible (except for the
> special case of O_APPEND records, which definitely is sensible), and
> it is certainly solvable.
> 
> For example, a purely "local lock" model would be to just lock all
> pages in order as you write them, and not unlock the previous page
> until you've locked the next one.

The code I'm testing locks _all_ the folios we're writing to
simultaneously, and if they can't all be pinned and locked just falls
back to the inode lock.

Which does raise the question of if we've ever attempted to define a
lock ordering on folios. I suspect not, since folio lock doesn't even
seem to have lockdep support.


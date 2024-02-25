Return-Path: <linux-fsdevel+bounces-12730-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE573862D18
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 22:14:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7AC78B21075
	for <lists+linux-fsdevel@lfdr.de>; Sun, 25 Feb 2024 21:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE26D1B948;
	Sun, 25 Feb 2024 21:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QnYCxpBA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F62A2F58
	for <linux-fsdevel@vger.kernel.org>; Sun, 25 Feb 2024 21:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708895669; cv=none; b=rXnZsqLSFLf8Gqn0oOBEXXAw0HAVm9SRfuWuoznREn8SBeMDKQPWaeYrCz9gpCFjlkiw1G2M1iGUJQLIm3SXU+FTisGab5RFmZerQ+4n08rz+9xYUg3QwrdoeOa9Gd2GIKBf3IPjNKfqdebAjKpNHzTeg/qPubpZj7+b4qEoi0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708895669; c=relaxed/simple;
	bh=jcoN0cUWI8Dffh8Z3PWz0RY9LG0Yopmc1g8aTgBLGF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovlyHlAmTlGF4kJhgVNePQ/h2NhBQRM+WquACnpNazGGQ3eypv4wKD2dc/h7c3gQ+0oHR7LlSyMUhAy2dUMc8c4pdtaGiJvOT1t8Xse+3ZogtGwSGR8HIY0iWnKIk74O9U+z3tw8zwuDS3f9/S2uZdesD31DOhJGnKMAeubmCDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QnYCxpBA; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ui+j32p0OsExvTVY7IOMabABeK0Z1XaZ00tAkljc7sU=; b=QnYCxpBAkxK6xyG6pl4lTIwa97
	jR/Iii/Dn3qQMkm7evrTbP9o7/ZJ1E2vLV2Vzc4/9qyo9/E89icovdHiZQqatGGD3UEpSuiQc42z4
	Q31ZA2w8PHC268KBmNe/cfLfxBsQz+pNgPtEiT038bvPU+Lbvc88wY1VQfM7fyhJ64dAnm257p4Yp
	XOBtnGC6Y2J4Ej22S+C1YDDWWhgSFPeEGOlfXwmXp8OGO1YtE+fx46SUtIE9g2QwnFTE+T6qLqa/A
	fzqpO9m2/kB0Xgl52mo64VGV+K7od7cQaon7W6AuuWDQHtKe4lm+GgHcZz905wa6lLwdhdikHpq6h
	4GqzztAg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1reLp5-0000000F9tu-3CrF;
	Sun, 25 Feb 2024 21:14:11 +0000
Date: Sun, 25 Feb 2024 21:14:11 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Luis Chamberlain <mcgrof@kernel.org>,
	lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
	linux-mm <linux-mm@kvack.org>, Daniel Gomez <da.gomez@samsung.com>,
	Pankaj Raghav <p.raghav@samsung.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
	Chris Mason <clm@fb.com>, Johannes Weiner <hannes@cmpxchg.org>
Subject: Re: [LSF/MM/BPF TOPIC] Measuring limits and enhancing buffered IO
Message-ID: <Zduto30LUEqIHg4h@casper.infradead.org>
References: <Zdkxfspq3urnrM6I@bombadil.infradead.org>
 <Zdlsr88A6AAlJpcc@casper.infradead.org>
 <CAHk-=wjUkYLv23KtF=EyCrQcmf9NGwE8Yo1cuxdaLF8gqx5zWw@mail.gmail.com>
 <o4a6577t2z5xytjwmixqkl33h23vfnjypwbx7jaaldtldpvjf5@dzbzkhrzyobb>
 <Zds8T9O4AYAmdS9d@casper.infradead.org>
 <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgVPHPPjZPoV8E_q59L7i8zFjHo_5hHo_+qECYuy7FF6g@mail.gmail.com>

On Sun, Feb 25, 2024 at 09:03:32AM -0800, Linus Torvalds wrote:
> I think you've been staring at profiles too much. In instruction-level
> profiles, the atomic ops stand out a lot. But that's at least partly
> artificial - they are a serialization point on x86, so things get
> accounted to them. So they tend to be the collection point for
> everything around them in an OoO CPU.
> 
> Yes, atomics are bad. But double buffering is worse, and only looks
> good if you have some artificial benchmark that does some single-byte
> hot-cache read in a loop.

Not artificial; this was a real customer with a real workload.  I don't
know how much about it I can discuss publically, but my memory of it was a
system writing a log with 64 byte entries, millions of entries per second.
Occasionally the system would have to go back and look at an entry in the
last few seconds worth of data (so it would still be in the page cache).

This customer was quite savvy, so they actually implemented and tested
the lookup-copy-lookup-again algorithm in their custom kernel, and saw
a speedup from it.



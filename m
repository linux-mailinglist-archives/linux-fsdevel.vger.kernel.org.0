Return-Path: <linux-fsdevel+bounces-71699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F135CCE0A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 01:17:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A41C03031309
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 00:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48BB1D7E41;
	Fri, 19 Dec 2025 00:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MUBmcdQs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5C8C176FB1;
	Fri, 19 Dec 2025 00:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766103420; cv=none; b=NHL368V6gITzzVKDcGjj88nFBy8kJqCF8rBFXDJee4tzDaffXfv8qF5whezg2ll7/uMZ0YL1COOVZxh2N8sBt62Ce1ASYl17L3LUxWd4uWDBC6LaYwWHruGYrcmv1eaDIC6ZyYizmOGxW6ub7ADd8YorUspO7fsLqqWj2wYz7hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766103420; c=relaxed/simple;
	bh=ozrB6x0Qzu1clcmEJSMm33NIapJTB4QFTrUwc+Lj9+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pK5N6ZnLEu2Tqr/nyyHAbRYnWptJ5DKRtOTPrNaJF2/DyJqwIt9nVysOoSGV/eT+0tvJ1Kehnn6tjW1M/c2REdywDr6ixtpldRutvbOV7guaznns432UN+1PG6betp1eaXiPp5XvzkqBcUb4uUaw00DEVGLE3wl8knj6HMY/mQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MUBmcdQs; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 16:16:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766103405;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iaNwM6o2Q3buZTg4AtEVmQYeydc3nbq7x/hRmv9CsW8=;
	b=MUBmcdQsLHkz91tl1c96JusBFth6vDgdq2NU48+HTzjQEodmrBXYqr7M4W88k4qgSL6u8l
	MkyPlC0HK6iVCumF+HMob8y2+CRjeVH0+uCXabMNbMM8w515bNixYVpr85tjP3Zen4caVv
	Z1odTtd+sShuwGvwlRkpdTLQjJ9I+As=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Shaurya Rane <ssrane_b23@ee.vjti.ac.in>, 
	"Darrick J . Wong" <djwong@kernel.org>, Christoph Hellwig <hch@infradead.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Meta kernel team <kernel-team@meta.com>, bpf@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	syzbot+09b7d050e4806540153d@syzkaller.appspotmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH bpf v2] lib/buildid: use __kernel_read() for sleepable
 context
Message-ID: <3lf3ed3xn2oaenvlqjmypuewtm6gakzbecc7kgqsadggyvdtkr@uyw4boj6igqu>
References: <20251218205505.2415840-1-shakeel.butt@linux.dev>
 <aUSUe9jHnYJ577Gh@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUSUe9jHnYJ577Gh@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Dec 18, 2025 at 11:55:39PM +0000, Matthew Wilcox wrote:
> On Thu, Dec 18, 2025 at 12:55:05PM -0800, Shakeel Butt wrote:
> > +	do {
> > +		ret = __kernel_read(r->file, buf, sz, &pos);
> > +		if (ret <= 0) {
> > +			r->err = ret ?: -EIO;
> > +			return NULL;
> > +		}
> > +		buf += ret;
> > +		sz -= ret;
> > +	} while (sz > 0);
> 
> Why are you doing a loop around __kernel_read()?  eg kernel_read() does
> not do a read around __kernel_read().  The callers of kernel_read()
> don't do a loop either.  So what makes you think it needs to have a loop
> around it?

I am assuming that __kernel_read() can return less data than the
requested. Is that assumption incorrect?


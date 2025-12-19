Return-Path: <linux-fsdevel+bounces-71714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 42890CCE9B3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 06:59:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E7E13030590
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Dec 2025 05:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A0E2D73BD;
	Fri, 19 Dec 2025 05:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="B+b/j72d"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844B2417D1
	for <linux-fsdevel@vger.kernel.org>; Fri, 19 Dec 2025 05:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766123951; cv=none; b=gIAYe76XupnE/6LM17LKmzArk8+eddPi0fYiL8XqBHShXgYntEUJNfVqbMzOU1nUSMS/ObprX7uOpyUjTJLTKt+r2zfRn4HwaUjZVRv7iLtocNP9oEHBrdPpTd+z3JxxpLRA2pBzapaSvl4mfQtHUOUv0HSxj17q+1XwJtQ/wJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766123951; c=relaxed/simple;
	bh=8Cr7r2B+N7v+IV9LMPV9E8fN1z4ddEFMzjQN7tozqms=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgPUiXPY8unn8Klj6y/juJ46hxpzVE3kHyw/PpJn+pVnnAiz2eYk8vBx4zMFpe5WGplOycXw8X69zsl+orDX3epszYXgVKoole0JVZG48lkanCfBjF91x8kQvA7OM69XbJBbeYiRueNsXgXrwoxzySAJtK1XhFPsGazemFRmqGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=B+b/j72d; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 18 Dec 2025 21:58:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766123934;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4HqcONQ2/Kfp88WL6kDtebaHTkyU0GryyZiYjvEXXW8=;
	b=B+b/j72dwvAoxDdB7jiAaEQfq7UbTcs4Qs+juxF9UnufHwCuRuSPxYgWsdOInVY1ZA+Qgt
	Q3/MPKjEz3nmM9S0Z53adtGmaYLaczFL/AdToDqPU3TW47fSnyyQ5VNtMhMVH43zdwPkJz
	i/v6F2YtnsQ66oXbUiQiChCOBXKxueo=
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
Message-ID: <64muytpsnwmjcnc5szbz4gfnh2owgorsfdl5zmomtykptfry4s@tuajoyqmulqc>
References: <20251218205505.2415840-1-shakeel.butt@linux.dev>
 <aUSUe9jHnYJ577Gh@casper.infradead.org>
 <3lf3ed3xn2oaenvlqjmypuewtm6gakzbecc7kgqsadggyvdtkr@uyw4boj6igqu>
 <aUTPl35UPcjc66l3@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUTPl35UPcjc66l3@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Fri, Dec 19, 2025 at 04:07:51AM +0000, Matthew Wilcox wrote:
> On Thu, Dec 18, 2025 at 04:16:40PM -0800, Shakeel Butt wrote:
> > On Thu, Dec 18, 2025 at 11:55:39PM +0000, Matthew Wilcox wrote:
> > > On Thu, Dec 18, 2025 at 12:55:05PM -0800, Shakeel Butt wrote:
> > > > +	do {
> > > > +		ret = __kernel_read(r->file, buf, sz, &pos);
> > > > +		if (ret <= 0) {
> > > > +			r->err = ret ?: -EIO;
> > > > +			return NULL;
> > > > +		}
> > > > +		buf += ret;
> > > > +		sz -= ret;
> > > > +	} while (sz > 0);
> > > 
> > > Why are you doing a loop around __kernel_read()?  eg kernel_read() does
> > > not do a read around __kernel_read().  The callers of kernel_read()
> > > don't do a loop either.  So what makes you think it needs to have a loop
> > > around it?
> > 
> > I am assuming that __kernel_read() can return less data than the
> > requested. Is that assumption incorrect?
> 
> I think it can, but I don't think a second call will get any more data.
> For example, it could hit EOF.  What led you to think that calling it in
> a loop was the right approach?

I am kind of following the convention of a userspace application doing
read() syscall i.e. repeatedly call read() until you hit an error or EOF
in which case 0 will be returned or you successfully read the amount of
data you want. I am handling negative error and 0 and for 0, I am
returning -EIO as that would be unexpected end of an ELF file.

Anyways the question is if __kernel_read() returns less amount of data
than requested, should we return error instead of retrying? I looked
couple of callers of __kernel_read() & kernel_read(). Some are erroring
out if received data is less than requested (e.g. big_key_read()) and
some are calling in the loop (e.g. kernel_read_file()).


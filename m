Return-Path: <linux-fsdevel+bounces-71835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C01ACD6FF2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 20:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87560301E5BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Dec 2025 19:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213BC33B6D1;
	Mon, 22 Dec 2025 19:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Wk98+9ck"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC2EF2FBE1F
	for <linux-fsdevel@vger.kernel.org>; Mon, 22 Dec 2025 19:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766432487; cv=none; b=Lokj5rFnO2o9pkioEEh5hhDFDu3mk8EjYig3nPq1DqzlmQoaIWs0/2eeztIpY1KZ3ziOEw2/+kiUrPHuYgxCnKFzP/rLHXF+avZIB2wETMfm1/vBJQt3mUaLZTFjS55An8vG1RGvpZ+UPLjwnnMTKARBvsIy4Ne/Lf7pBjipEbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766432487; c=relaxed/simple;
	bh=lxB95KkAqNYSOdDKJbZuu4ofz3iyWK92aFO1vbQmLrw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KiRR6pnwB5gVOKEFLZi5uVWhuopR0WkuFAd8Qk08M3WXuRPoQxvycrWitjZpw7OJN+hmB1IbngZxlbd3Ud0SFr67J7uA56h8hLQUk9tFnMDxoiX/pXi61IYt3LNfOlR4W1AcIbYAYaxkT3Z5CVd61G10jcY6lmXpEYGyXmEDK78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Wk98+9ck; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 22 Dec 2025 11:41:07 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766432473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HBdPhxcvOkIIGXIYWQYM6O/Y0FlYFzryvwDPx4PZFuM=;
	b=Wk98+9ckbp5jyANGKAKbT97FXJKGd1XTR154MtCpLTT5tdBRnTwFEHi72KBwuBF/gg/K6o
	8oPGDBxmzSvgpcYhPo/byoaIT1aGfHmwGCJKn7z+quPKKTRLAGyJGagm64wAgjZpLYHJPq
	FPN0Ye9v5CYBeXvgSB9WQTadw8/ZOzM=
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
Message-ID: <7gyxkpozyno7hl2jz5k2v2k5yo6gpvr3i5whqrgqlc5eahxvjz@p7p2a2aezsbt>
References: <20251218205505.2415840-1-shakeel.butt@linux.dev>
 <aUSUe9jHnYJ577Gh@casper.infradead.org>
 <3lf3ed3xn2oaenvlqjmypuewtm6gakzbecc7kgqsadggyvdtkr@uyw4boj6igqu>
 <aUTPl35UPcjc66l3@casper.infradead.org>
 <64muytpsnwmjcnc5szbz4gfnh2owgorsfdl5zmomtykptfry4s@tuajoyqmulqc>
 <aUjXxSAD2-c4Ivy1@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUjXxSAD2-c4Ivy1@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Dec 22, 2025 at 05:31:50AM +0000, Matthew Wilcox wrote:
> On Thu, Dec 18, 2025 at 09:58:43PM -0800, Shakeel Butt wrote:
> > On Fri, Dec 19, 2025 at 04:07:51AM +0000, Matthew Wilcox wrote:
> > > > I am assuming that __kernel_read() can return less data than the
> > > > requested. Is that assumption incorrect?
> > > 
> > > I think it can, but I don't think a second call will get any more data.
> > > For example, it could hit EOF.  What led you to think that calling it in
> > > a loop was the right approach?
> > 
> > I am kind of following the convention of a userspace application doing
> > read() syscall i.e. repeatedly call read() until you hit an error or EOF
> > in which case 0 will be returned or you successfully read the amount of
> > data you want. I am handling negative error and 0 and for 0, I am
> > returning -EIO as that would be unexpected end of an ELF file.
> 
> Oh, you sweet summer child.  I hope Father Christmas leaves you an
> extra special present in your stocking this week!
> 
> While it would be lovely to believe that userspace does that kind of loop,
> it just doesn't.  That's why mounting NFS filesystems with the "intr"
> option (before I made it a no-op) was dangerous -- userspace just isn't
> prepared for short reads.  I mean, we're lucky if userspace even checks
> for errors, let alone does this kind of advanced "oh, we got fewer bytes
> than we wanted, keep trying" scheme.
> 
> A filesystem's ->read_iter() implementation can stop short of reading
> all bytes requested if:
> 
>  - We hit EIO.  No amount of asking will return more bytes, the data's
>    just not there any more.
>  - We hit EOF.  There's no more data to read.
>  - We're unable to access the buffer.  That's only possible for user
>    buffers, not kernel buffers.
>  - We receive a fatal signal.  I suppose there is the tiniest chance
>    that the I/O completes while we're processing the "we returned early"
>    loop, but in practice, the user has asked that we die now, and even
>    trying again is rude.  Just die as quickly as we can.
> 
> I can't think of any other cases.  It's just not allowed to return
> short reads to userspace (other than EIO/EOF), and that drives all
> the behaviour.

Thanks for the explanation. Is calling kernel_read() again after it
returned less amount of data unsafe or unnecessary?

> 
> > Anyways the question is if __kernel_read() returns less amount of data
> > than requested, should we return error instead of retrying? I looked
> > couple of callers of __kernel_read() & kernel_read(). Some are erroring
> > out if received data is less than requested (e.g. big_key_read()) and
> > some are calling in the loop (e.g. kernel_read_file()).
> 
> kernel_read_file() is wrong.  Thanks for reporting it; I'll send a patch.

There are couple more like do_read() and do_verify() in
drivers/usb/gadget/function/f_mass_storage.c. There might be more but I
have not looked into every caller.


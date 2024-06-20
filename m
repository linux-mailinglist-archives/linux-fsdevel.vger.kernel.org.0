Return-Path: <linux-fsdevel+bounces-21985-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1484F9109EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 17:35:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C420728403D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 15:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F651B0100;
	Thu, 20 Jun 2024 15:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IZop2Neu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 551021AED4D
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 15:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897721; cv=none; b=mKucy1phculf+Qn4sBXsJ4YR1BULHSsrGjxK2VDzW6qGb0HIfThyB+3l4ofxrdcmi/vVdSxJkfQgbe1N24hVtPL4qkpgdga4UscjVhqTR3V/FWc7voj6I97aTJPuv7InBM91u5R+6DKT9lgmYLk5OcCUV/wUjZ+TGsIC/U9VYuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897721; c=relaxed/simple;
	bh=aKr/khYMgPofHmZ3nzZibgJNgRuw/HbEgUEo0u0yw1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcTG7X4OdxLrQ+fRQbbjqeQJXv/9x3wqQhgcoGO6g4/AUHBFcJRlvuXzHkwL4Wf1cnjICnjJxKP8Z3hVykZJPwv4FyOQPKSoqjRn98z7cBrnXaJagWIOrMC5d1HNYq5YBpTBSG7XWs5uV1ZfsFcFyMNE7qxJODYn2HsTfjB3TAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IZop2Neu; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: willy@infradead.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1718897714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y56GDm+cXkOTTXOBpxGVSCiDKUdkhFZ/N1N+WvHE7IU=;
	b=IZop2NeuaHH4c5U30zcPDkSRwM6JsbNjk0Juii1ohEggo2FTEqCTVx1jbVOvgf6RzSRs7n
	Y3PrdXUn3vtRuECXUBjH38aupsjkCn6Dpd27OcrxLhY+M1h9AofobQBxUt2YpGkj7lqrPP
	KitNRqWXBf1huvME95/2bjtKpKrKvc8=
X-Envelope-To: lihongbo22@huawei.com
X-Envelope-To: linux-bcachefs@vger.kernel.org
X-Envelope-To: linux-fsdevel@vger.kernel.org
X-Envelope-To: linux-block@vger.kernel.org
X-Envelope-To: axboe@kernel.dk
X-Envelope-To: hch@lst.de
Date: Thu, 20 Jun 2024 11:35:10 -0400
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Matthew Wilcox <willy@infradead.org>
Cc: Hongbo Li <lihongbo22@huawei.com>, linux-bcachefs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, axboe@kernel.dk, hch@lst.de
Subject: Re: bvec_iter.bi_sector -> loff_t? (was: Re: [PATCH] bcachefs: allow
 direct io fallback to buffer io for) unaligned length or offset
Message-ID: <gziks4sy42fyjskpbzwzrax6n7fkxvml36pvapofboo4nhy2mb@oi6j4z5afobp>
References: <20240620132157.888559-1-lihongbo22@huawei.com>
 <bbf7lnl2d5sxdzqbv3jcn6gxmtnsnscakqmfdf6vj4fcs3nasx@zvjsxfwkavgm>
 <ZnQ0gdpcplp_-aw7@casper.infradead.org>
 <pfxno4kzdgk6imw7vt2wvpluybohbf6brka6tlx34lu2zbbuaz@khifgy2v2z5n>
 <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZnRBkr_7Ah8Hj-i-@casper.infradead.org>
X-Migadu-Flow: FLOW_OUT

On Thu, Jun 20, 2024 at 03:49:54PM +0100, Matthew Wilcox wrote:
> On Thu, Jun 20, 2024 at 10:16:02AM -0400, Kent Overstreet wrote:
> > That's really just descriptive, not prescriptive.
> > 
> > The intent of O_DIRECT is "bypass the page cache", the alignment
> > restrictions are just a side effect of that. Applications just care
> > about is having predictable performance characteristics.
> 
> But any application that has been written to use O_DIRECT already has the
> alignment & size guarantees in place.  What this patch is attempting to do
> is make it "more friendly" to use, and I'm not sure that's a great idea.
> Not without buy-in from a large cross-section of filesystem people.

The thing is, we're currently conflating "don't use the page cache" and
"don't bounce", and we really shouldn't be.

Sometimes performance is your main criteria and you do want the error if
you misaligned the IO, but not always. The the main reason being that
mixing buffered and O_DIRECT is _really_ expensive, and you will quite
often have codepaths that don't care about performance, but do need to
use O_DIRECT so they don't interfere with your paths that do care about
performance.

So they're forced to deal with bouncing and alignment restrictions at
the applicatoin level, even though they really don't want to be, and we
(at least bcachefs) already have the code to do that bouncing when
required - there's really no reason for them to be hand rolling that,
and if writes are involved then it gets really nontrivial.

This is one of the reasons I'll likely be implementing sub-blocksize
writes through the low level write path in bcachefs. O_DIRECT gives you
things that buffered IO doesn't - it's much cheaper, and simpler to
guarantee write ordering of O_DIRECT writes (c.f. untorn writes,
O_DIRECT is much easier than buffered there as well, and it's even
easier in a COW filesystem) - and it's going to be worthwhile to be able
to provide that behaviour without the alignment restrictions that
currently come with O_DIRECT.

To sum all that up: "don't bounce" should really another rwf flag we can
pass to preadv2/pwritev2 - RWF_NOBOUNCE.

And for bcachefs I would implement bouncing-when-required even without
that flag being available, simply because that's current behaviour (due
to checksums being extent granularity). That flag really only makes
sense for bcachefs once we get opt-in block granular checksums (which is
coming, as well).


Return-Path: <linux-fsdevel+bounces-29666-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B5B97BF7E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 19:13:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14A521F2227B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 17:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3571C9DEC;
	Wed, 18 Sep 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EqP2DSYW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1071B1505;
	Wed, 18 Sep 2024 17:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726679589; cv=none; b=Xhirm3gq2NKnKCLd9Gjc+6VVR5nbmO1eDAYPvbD/sy62ft+zMM0EJtZFnQqM0Tpm+oHK84daaH5aHxO6jWtpgXz3C7YdH8sak4qoW2U7oaV8gSTb7zX9vJkAL9R5krtW6QR2urbrTjbSg7XUpgc6haRdroqVd5co3rZ2tc8byLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726679589; c=relaxed/simple;
	bh=Ta2j/hqRz3RzDvnQuXxooZ+3akVk5YzTi4y14r2jshM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3Wpt2wGWIUDBQNIAWmVRLaQ7cIa/YoySo3ttxQQvrSAXUQQZniyHHHfU/L7Ho+GSbDgadHd5lS+molfd3t2ZC+vAgpRSAwbXFJ0sxwhKnnPsjXf7g0sxncwBKPRJUd5nAEdQl611xtlB9E5+3jBTvsp+Y5/I0yLTsSmM838TAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EqP2DSYW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+NxubRC8s/p94iaKYGIJ7mmF/q9E02cnviGlZvwUxeo=; b=EqP2DSYWNYqpMGwTLOV0R4PctG
	MlOp1T34c76BjT6rkvYxwvZXirWtpLsZlT8I6HJ0vBWWjX2aBjHtz6/Vd5tn4yt4tA+oE+bD5kobs
	eFfPH3suRCi856xD9ijv+VPuvCLK7YWFCMoQHz49yWJBivmJ0NgTsovEDNC/zKpKNyPtTUffC7aL6
	oWG8aG/xh5j9U2vRJJAt/ODAuBHpruWMns2k7qel/ltIkcg7eOwf6oF8+XjvHomQ7+FrC67ClYKvo
	yH1UuQ2I6CPBc/M5DSLxUKYCzOB9E3tOi+3tD4Z1yyi+kOUdLBtKgJb94A8E5yvkvhss9x484kfQZ
	V5PFrC8Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqyEa-00000005scz-3Hkh;
	Wed, 18 Sep 2024 17:12:56 +0000
Date: Wed, 18 Sep 2024 18:12:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Chris Mason <clm@meta.com>, Jens Axboe <axboe@kernel.dk>,
	Dave Chinner <david@fromorbit.com>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZusKGCXhponXOh_l@casper.infradead.org>
References: <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>
 <Zurfz7CNeyxGrfRr@casper.infradead.org>
 <CAHk-=whNqXvQywo305oixS-xkofRicUD-D+Nh-mLZ6cc-N3P5w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNqXvQywo305oixS-xkofRicUD-D+Nh-mLZ6cc-N3P5w@mail.gmail.com>

On Wed, Sep 18, 2024 at 04:39:56PM +0200, Linus Torvalds wrote:
> The fact that this bug was fixed basically entirely by mistake does
> say "this is much too subtle".

Yup.

> Of course, the fact that an xas_reset() not only resets the walk, but
> also clears any pending errors (because it's all the same "xa_node"
> thing), doesn't make things more obvious. Because right now you
> *could* treat errors as "cumulative", but if a xas_split_alloc() does
> an xas_reset() on success, that means that it's actually a big
> conceptual change and you can't do the "cumulative" thing any more.

So ... the way xas was intended to work is that the first thing we did
that set an error meant that everything after it was a no-op.  You
can see that in functions like xas_start() which do:

        if (xas_error(xas))
                return NULL;

obviously something like xas_unlock() isn't a noop because you still
want to unlock even if you had an error.

The xas_split_alloc() was done in too much of a hurry.  I had thought
that I wouldn't need it, and then found out that it was a prerequisite
for something I needed to do, and so I wasn't in the right frame of mind
when I wrote it.

It's actually a giant pain and I wanted to redo it even before this, as
well as clear up some pieces from xas_nomem() / __xas_nomem().  The
restriction on "we can only split to one additional level" is awful,
and has caused some contortions elsewhere.

> End result: it would probably make sense to change "xas_split_alloc()"
> to explicitly *not* have that "check xas_error() afterwards as if it
> could be cumulative", and instead make it very clearly have no history
> and change the semantics to

What it really should do is just return if it's already in an error state.
That makes it consistent with the rest of the API, and we don't have to
worry about it losing an already-found error.

But also all the other infelicities with it need to be fixed.


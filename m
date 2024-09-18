Return-Path: <linux-fsdevel+bounces-29654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD0D97BDC8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 16:12:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2655DB20FF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 14:12:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D526318B47B;
	Wed, 18 Sep 2024 14:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HNeVUv6i"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F106F9CB;
	Wed, 18 Sep 2024 14:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726668759; cv=none; b=hb3wxdFPXXwKgjefU7oansjuMsYOPaCntp4iSvQNJE25R9duYpH42HHDDMtxEqARrhy1EXjz0Xzqf3mjy2UfRYJ44wORPWIlOPuNm1/NzBjA4Lsk7rXT+iuSi8zG/PKeMxhjvDQ5W76ekYSxgzJ1xHpr10mdJnaHXY9jQqyD/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726668759; c=relaxed/simple;
	bh=6NlMDn6G8FUuzCdG6WBURoTQNIUtKbtdI6OB1EeRH+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NHOzfZts4/L2f7mKTj7FSkDIMDyzATx3dpOeMMSzsG+YaNJrKyLt6EJ7zLyYkaSydAvodUAOeH6uFB6zgbN0+wXe2Tb+WcbYmhDF+BkIdkC6UTcRWUq7C/Ug4cK2hy9cOcVAXyPoI7M5x/JOfXZFImfq4/gMlmGUD0vqi3jq2IU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HNeVUv6i; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ni/akaMESxhEbLiyAWV6aj2aPhfND/QItwuWAkzArog=; b=HNeVUv6iwFCo/iQBMWywvV3X+F
	3k8CBU7k+sHoZOahkAZyNNbUcNMseYbno1kbdALrlcNhSr/fCjzk3TsjYfdRIPDxo27yzb0MQkU8/
	wp6Owt6JTPKWq/29Bq043kYpK2LYzWP5Fnhkjo6IDmh5F8mxnzc8Rx/7oFcblMJyoThQbntw9OzFm
	vOaHlGQ3WX3a2FFku+S2m8JTnFl72JNv1dYquzJE/weqFVE3iymBho4wx0cCrugR+pTvMrY0km8m6
	85Jdk2A4+J/L+RznjV0ud0aPOudzZfKoiLAA9BzrHCZuV/CggzefYbZaEETK2RWCWygnhfDfVJlmO
	sYLL9rOQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1sqvQ0-00000005cxD-0wKA;
	Wed, 18 Sep 2024 14:12:32 +0000
Date: Wed, 18 Sep 2024 15:12:31 +0100
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
Message-ID: <Zurfz7CNeyxGrfRr@casper.infradead.org>
References: <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
 <ZurXAco1BKqf8I2E@casper.infradead.org>
 <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wjix8S7_049hd=+9NjiYr90TnT0LLt-HiYvwf6XMPQq6Q@mail.gmail.com>

On Wed, Sep 18, 2024 at 03:51:39PM +0200, Linus Torvalds wrote:
> On Wed, 18 Sept 2024 at 15:35, Matthew Wilcox <willy@infradead.org> wrote:
> >
> > Oh god, that's it.
> >
> > there should have been an xas_reset() after calling xas_split_alloc().
> 
> I think it is worse than that.
> 
> Even *without* an xas_split_alloc(), I think the old code was wrong,
> because it drops the xas lock without doing the xas_reset.

That's actually OK.  The first time around the loop, we haven't walked the
tree, so we start from the top as you'd expect.  The only other reason to
go around the loop again is that memory allocation failed for a node, and
in that case we call xas_nomem() and that (effectively) calls xas_reset().

So in terms of the expected API for xa_state users, it would be consistent
for xas_split_alloc() to call xas_reset().

You might argue that this API is too subtle, but it was intended to
be easy to use.  The problem was that xas_split_alloc() got added much
later and I forgot to maintain the invariant that makes it work as well
as be easy to use.


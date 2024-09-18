Return-Path: <linux-fsdevel+bounces-29641-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BD997BD1A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 15:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70F0B1C214B2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Sep 2024 13:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E35B18A939;
	Wed, 18 Sep 2024 13:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="eiUTHz3H"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 121941891AC;
	Wed, 18 Sep 2024 13:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726666511; cv=none; b=iUMHlOayEgwEdctbBo26d/eNS5TsPd+GJ6cNmdFdel8T0bbZpMtlIQvIHIZep1vU74bJJtt0Uw9eheA3UpXWCdQzTXo9oHEB9ZfQNbAVvtxVmTS7pT9dmfSAIBlhG4fieEtId73s/+K7slBo1+ckFPVQFtT1Xp5+sU45pufBt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726666511; c=relaxed/simple;
	bh=MdQjs6K0gmHwGgi6AUht9cox8zFl1PZT0Z4w7KwG71A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRTYVkGdiG/ZUt8mrtSf0YzP2+w+ZulRPhw9cDBTavkKKp/9FeKtl0C0ZOcxE/DUqjmCzMYcCYHnI0IS6ReP7DSMZ9wASWL/Mbyt/5of4Ke/nRK/0loov5DBOktcTZXci2v4Ei4NFoW4F9EwMfGf9Qtbc4zREDofo209VaQUmFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=eiUTHz3H; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ctRJF9uHUjt117HVJblBA7Yck7PY6Nvpd0RsIq4J+Mk=; b=eiUTHz3HhgXvW8Wyk9peiYyKdd
	3zGGUtvVY5myV3gIz6y0vli6yjNWQUN5uysRnuNsNh5lKSvU5+uBD57H3iEx8zkWow545P1411ZLv
	0DImM9weqgmnyjikDi62MG3TQflVd8sXuAoWFd60jNlWHKpN7S813yB1t3Nqmrqc6fleDDoFtaGMO
	TCmkUIKHjuhb9/kw4+FJDEHc+Sv6ZS6wUt++38naA1gK1LyyJb18tNQXxY+wzACakL3+GlS5039JT
	SBLNmcdLzYQZALEDtnJDl1JMh4b1/ttZogVVU9lPewq2p6A6d4+omV3rVwNroQPJFXXi9y0BifYii
	j2Cj+qCg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1squpd-00000005Yqo-2bc7;
	Wed, 18 Sep 2024 13:34:57 +0000
Date: Wed, 18 Sep 2024 14:34:57 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chris Mason <clm@meta.com>
Cc: Jens Axboe <axboe@kernel.dk>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Dave Chinner <david@fromorbit.com>,
	Christian Theune <ct@flyingcircus.io>, linux-mm@kvack.org,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Daniel Dao <dqminh@cloudflare.com>, regressions@lists.linux.dev,
	regressions@leemhuis.info
Subject: Re: Known and unfixed active data loss bug in MM + XFS with large
 folios since Dec 2021 (any kernel from 6.1 upwards)
Message-ID: <ZurXAco1BKqf8I2E@casper.infradead.org>
References: <0fc8c3e7-e5d2-40db-8661-8c7199f84e43@kernel.dk>
 <CAHk-=wh5LRp6Tb2oLKv1LrJWuXKOvxcucMfRMmYcT-npbo0=_A@mail.gmail.com>
 <Zud1EhTnoWIRFPa/@dread.disaster.area>
 <CAHk-=wgY-PVaVRBHem2qGnzpAQJheDOWKpqsteQxbRop6ey+fQ@mail.gmail.com>
 <74cceb67-2e71-455f-a4d4-6c5185ef775b@meta.com>
 <ZulMlPFKiiRe3iFd@casper.infradead.org>
 <52d45d22-e108-400e-a63f-f50ef1a0ae1a@meta.com>
 <ZumDPU7RDg5wV0Re@casper.infradead.org>
 <5bee194c-9cd3-47e7-919b-9f352441f855@kernel.dk>
 <459beb1c-defd-4836-952c-589203b7005c@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <459beb1c-defd-4836-952c-589203b7005c@meta.com>

On Wed, Sep 18, 2024 at 11:28:52AM +0200, Chris Mason wrote:
> I think the bug was in __filemap_add_folio()'s usage of xarray_split_alloc()
> and the tree changing before taking the lock.  It's just a guess, but that
> was always my biggest suspect.

Oh god, that's it.

there should have been an xas_reset() after calling xas_split_alloc().

and 6758c1128ceb calls xas_reset() after calling xas_split_alloc().

i wonder if xas_split_alloc() should call xas_reset() to prevent this
from ever being a problem again?


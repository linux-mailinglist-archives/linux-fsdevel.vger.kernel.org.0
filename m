Return-Path: <linux-fsdevel+bounces-23809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D403E933A3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 11:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8211F22920
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 09:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEBC17B4EE;
	Wed, 17 Jul 2024 09:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="Q5k8IyCu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C627717A5A0;
	Wed, 17 Jul 2024 09:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721209597; cv=none; b=ArROpbnTkWi9dzxdUn6KcKcBxM9nF1ECKOYt7U9rU1harVsy1zCoeHYeUV4QnY70u1YaMHJlyPBU+d7OfMcUk5Pz6BRQn0jpbl8ObjoNQp0kZ+H0llQGsCHLfqvWZg/j/DzLxi4ru2Pge3Y4A0Sir0CryViyUMcaeV04Ln3BK8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721209597; c=relaxed/simple;
	bh=OcFDHJ6YxtOxAvXzxzjxRNphouy5UY/lzAXnlejmOUw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkKRfv84QGG9DuYNIB+vFa6qp667p7PygZoD4rN/6KWWeLKOgHRo/O7r5Xr7nmbz4pr1fukOdC1x7WdhEtapShmyHSMLIUrFZPYTHyw2EU68jHje1JcWc/WWgtfxmFiE3QOW1zO3BRiwytgUv6JKMt1oyiXxNnqo9LUcZILlBxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=Q5k8IyCu; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4WPB0Q4Trbz9snJ;
	Wed, 17 Jul 2024 11:46:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1721209590;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=chHks11OcswoqogGm1l7KNdqudLDcdLYsX/xiCrSWrw=;
	b=Q5k8IyCuR1G8bBqV6YVgMWW5NCt0dFK7ByXnl/M77lenZEsR7iG0g5nr8oLutDOp8ixZuX
	yAzc6URez2rAKZ+sdmvx6yuVsc00jjrabunRbg4YMJjHr4ssLsE2Zxc7WZ3X/1izyB3moB
	o5tvEyBA7gFp6ePlijMsRG74Sou+2m3F+b6zipL6lE1+dQshARM0xC27dPJ6aWG7DYRBYX
	Bl+xO4Ync9C3n8xvRweoYRM6fO+AeLHIocUS04ieCec1pKwwyqliqTfHA7Hib/sqU3M/7t
	2HxkEE99OIXrlBQ+Yr5nlbXYKMnNMN0i32+gxARhumo6yJ2PHCAONcv7OUT3jw==
Date: Wed, 17 Jul 2024 09:46:21 +0000
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: david@fromorbit.com, chandan.babu@oracle.com, djwong@kernel.org,
	brauner@kernel.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, yang@os.amperecomputing.com,
	linux-mm@kvack.org, john.g.garry@oracle.com,
	linux-fsdevel@vger.kernel.org, hare@suse.de, p.raghav@samsung.com,
	mcgrof@kernel.org, gost.dev@samsung.com, cl@os.amperecomputing.com,
	linux-xfs@vger.kernel.org, ryan.roberts@arm.com, hch@lst.de,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH v10 01/10] fs: Allow fine-grained control of folio sizes
Message-ID: <20240717094621.fdobfk7coyirg5e5@quentin>
References: <20240715094457.452836-1-kernel@pankajraghav.com>
 <20240715094457.452836-2-kernel@pankajraghav.com>
 <ZpaRElX0HyikQ1ER@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpaRElX0HyikQ1ER@casper.infradead.org>
X-Rspamd-Queue-Id: 4WPB0Q4Trbz9snJ

On Tue, Jul 16, 2024 at 04:26:10PM +0100, Matthew Wilcox wrote:
> On Mon, Jul 15, 2024 at 11:44:48AM +0200, Pankaj Raghav (Samsung) wrote:
> > +/*
> > + * mapping_max_folio_size_supported() - Check the max folio size supported
> > + *
> > + * The filesystem should call this function at mount time if there is a
> > + * requirement on the folio mapping size in the page cache.
> > + */
> > +static inline size_t mapping_max_folio_size_supported(void)
> > +{
> > +	if (IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +		return 1U << (PAGE_SHIFT + MAX_PAGECACHE_ORDER);
> > +	return PAGE_SIZE;
> > +}
> 
> There's no need for this to be part of this patch.  I've removed stuff
> from this patch before that's not needed, please stop adding unnecessary
> functions.  This would logically be part of patch 10.

That makes sense. I will move it to the last patch.

> 
> > +static inline void mapping_set_folio_order_range(struct address_space *mapping,
> > +						 unsigned int min,
> > +						 unsigned int max)
> > +{
> > +	if (!IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE))
> > +		return;
> > +
> > +	if (min > MAX_PAGECACHE_ORDER) {
> > +		VM_WARN_ONCE(1,
> > +	"min order > MAX_PAGECACHE_ORDER. Setting min_order to MAX_PAGECACHE_ORDER");
> > +		min = MAX_PAGECACHE_ORDER;
> > +	}
> 
> This is really too much.  It's something that will never happen.  Just
> delete the message.
> 
> > +	if (max > MAX_PAGECACHE_ORDER) {
> > +		VM_WARN_ONCE(1,
> > +	"max order > MAX_PAGECACHE_ORDER. Setting max_order to MAX_PAGECACHE_ORDER");
> > +		max = MAX_PAGECACHE_ORDER;
> 
> Absolutely not.  If the filesystem declares it can support a block size
> of 4TB, then good for it.  We just silently clamp it.

Hmm, but you raised the point about clamping in the previous patches[1]
after Ryan pointed out that we should not silently clamp the order.

```
> It seems strange to silently clamp these? Presumably for the bs>ps usecase,
> whatever values are passed in are a hard requirement? So wouldn't want them to
> be silently reduced. (Especially given the recent change to reduce the size of
> MAX_PAGECACHE_ORDER to less then PMD size in some cases).

Hm, yes.  We should probably make this return an errno.  Including
returning an errno for !IS_ENABLED() and min > 0.
```

It was not clear from the conversation in the previous patches that we
decided to just clamp the order (like it was done before).

So let's just stick with how it was done before where we clamp the
values if min and max > MAX_PAGECACHE_ORDER?

[1] https://lore.kernel.org/linux-fsdevel/Zoa9rQbEUam467-q@casper.infradead.org/


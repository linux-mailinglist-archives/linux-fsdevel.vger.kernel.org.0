Return-Path: <linux-fsdevel+bounces-15343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A0FE88C3F6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 14:45:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 221EB1F3816B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 13:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D66F84D31;
	Tue, 26 Mar 2024 13:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b="CNJVI1FR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C82C86625;
	Tue, 26 Mar 2024 13:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711460520; cv=none; b=T/10yF08M5+sy8cn41M8p0Yg9VF36xmZ2PLooplZHzKRdRVt0YoYOCHpl4H9ysLGqmtwui+BpLj3grxkk8Eqy/SUFpeB7pJo67Zzx8q8YuoZWMKu/sJeKrvu+MlydDk/9J3jEV04bfVqtS5DWJTpqPOVDz5v2P7NfRxWxD1CtSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711460520; c=relaxed/simple;
	bh=EbeIxQZAx+QKyEupTV/ELB885czWCJXv1k2kXD26okk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTpizPhp+xx4eU9EQO8zj+9OpQhmYyFFXIvKDrNMKi7p1BLBE5aRb1aE6kYzISkhmuok7ll2HiJP6Pq5CvjUKK/GzesanG9B2sRE0OdeOPXsRuW9PCwAuKBpwA7gkOvSL0d9U6bxGsFP7BxTwURxnCSFz2dOSXWu1jxcEj/O0pY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com; spf=pass smtp.mailfrom=pankajraghav.com; dkim=pass (2048-bit key) header.d=pankajraghav.com header.i=@pankajraghav.com header.b=CNJVI1FR; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pankajraghav.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pankajraghav.com
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4V3rZ94mGwz9sVy;
	Tue, 26 Mar 2024 14:41:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pankajraghav.com;
	s=MBO0001; t=1711460513;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=mkLVdxNBsIuMF+BkrOfqIhXREY5OUiqOSXmyiAReOck=;
	b=CNJVI1FROQGHF4ufS62L/Zp20lMd2A0dHsT6RA1hi03L8KSj0jsbBPjPhF14tboZdw3y2e
	QQPfe650Uz4vUzE8fL/DiQE5j8nbuNrF1o/a9vQE1Nxghm7X0nJq40hS/t2DguaK+5Hv32
	XPlZoxo1OLN8b9gPkVeJ9EW6PyZrmxepC3FfUVJISPnWB1M6aBSsvSHnJexcV4256oWFCg
	PfTp6NMk6rPcGhq9eTzJIg8uZZh9txPOv6wIfDJhZmQmjqQ2uz/bR2K6+WURPz4Rm0mHoS
	KwLJS5VCWKVqomvwSrNGXwu8t5pB8Z38aDQncFyX+mU0ubf/O1gHE78ZYZv4Jg==
Date: Tue, 26 Mar 2024 14:41:49 +0100
From: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
To: Hannes Reinecke <hare@suse.de>
Cc: Matthew Wilcox <willy@infradead.org>, linux-xfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, gost.dev@samsung.com, chandan.babu@oracle.com, mcgrof@kernel.org, 
	djwong@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	david@fromorbit.com, akpm@linux-foundation.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v3 04/11] readahead: rework loop in
 page_cache_ra_unbounded()
Message-ID: <ppd5woer5dglazfladgrfepzjgpqr4oh7jkcnrk4ydwy6itntr@3djaoueadcm5>
References: <20240313170253.2324812-1-kernel@pankajraghav.com>
 <20240313170253.2324812-5-kernel@pankajraghav.com>
 <ZgHFPZ9tNLLjKZpz@casper.infradead.org>
 <7217df4e-470b-46ab-a4fc-1d4681256885@suse.de>
 <5e5523b1-0766-43b2-abb1-f18ea63906d6@pankajraghav.com>
 <3aa8bdf1-24f6-4e1f-a5c4-8dc2d11ca292@suse.de>
 <1a4a6ad3-6b88-47ea-a6c4-144a1485f614@pankajraghav.com>
 <2b1a2ded-d26f-4c9e-bd48-2384b5a7c2c9@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b1a2ded-d26f-4c9e-bd48-2384b5a7c2c9@suse.de>
X-Rspamd-Queue-Id: 4V3rZ94mGwz9sVy

On Tue, Mar 26, 2024 at 11:55:06AM +0100, Hannes Reinecke wrote:
> > > Bah. That really is overly complicated. When we attempt a conversion that conversion should be
> > > stand-alone, not rely on some other patch modifications later on.
> > > We definitely need to work on that to make it easier to review, even
> > > without having to read the mail thread.
> > > 
> > 
> > I don't know understand what you mean by overly complicated. This conversion is standalone and it is
> > wrong to use folio_nr_pages after we `put` the folio. This patch just reworks the loop and in the
> > next patch I add min order support to readahead.
> > 
> > This patch doesn't depend on the next patch.
> > 
> 
> Let me rephrase: what does 'ractl->_index' signify?
> From my understanding it should be the index of the
> first folio/page in ractl, right?
> 
> If so I find it hard to understand how we _could_ increase it by one; _index
> should _always_ in units of the minimal pagemap size.

I still have not introduced the minimal pagemap size concept here. That
comes in the next patch. This patch only reworks the loop and should not
have any functional changes. So the minimal pagemap size unit here is 1.

And to your next question how could we increase it only by one here:

// We come here if we didn't find any folio at index + i
...
folio = filemap_alloc_folio(gfp_mask, 0); // order 0 => 1 page
if (!folio)
	break;
if (filemap_add_folio(mapping, folio, index + i,
			gfp_mask) < 0) {
	folio_put(folio);
	read_pages(ractl);
	ractl->_index++;
	...

If we failed to add a folio of order 0 at (index + i), we put the folio
and start a read_pages() on whatever pages we added so far (ractl->index to
ractl->index + ractl->nr_pages).

read_pages() updates the ractl->index to ractl->index + ractl->nr_pages.
ractl->index after read_pages() should point to (index + i). As we had
issue adding a folio of order 0, we skip that index by incrementing the
ractl->index by 1.

Does this clarify? In your original patch, you used folio_nr_pages()
here. As I said before, we already know the size of the folio we tried
to add was 1, so we could just increment by 1, and we should not use the
folio to deduce the size after folio_put() as it is use after free.

> And if we don't have it here (as you suggested in the mailthread)
> I'd rather move this patch _after_ the minimal pagesize is introduced
> to ensure that _index is always incremented by the right amount.
> 

I intended to have it as two atomic changes where there is
non-functional change that helps with the functional change that comes
later. If it is confusing, I could also combine this with the next
patch?

Or, I could have it as the first patch before I start adding the concept
of folio_min_order. Then it makes it clear that it is intended to be a
non-function change?
--
Pankaj


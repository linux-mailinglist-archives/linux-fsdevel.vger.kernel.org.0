Return-Path: <linux-fsdevel+bounces-14920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1034A8817BA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 20:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6FA11B22627
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Mar 2024 19:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F5785631;
	Wed, 20 Mar 2024 19:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="PlTQoTIG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484E78527E
	for <linux-fsdevel@vger.kernel.org>; Wed, 20 Mar 2024 19:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710962083; cv=none; b=iP6WqKjnCBqTDPtLq3Bkn/xI32Xb71Htz4O5u+KERUG1EY+IlHI34rObDROnvTd9SWgiqoQs8isVlpbjdBk1iQnv+pchJuphNbttliy5yBCRoPJ0xHAK3XeyU++aC2khBATZqiApg2Ti1FdWDQe6f+bMxxpBGCuC7AbdMwaFRVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710962083; c=relaxed/simple;
	bh=QgUId3BnyBUUtUmW79Yu0Sps7oOPxY+/OKtSS/9tiic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ckb02xrB8g7HvgCr0ZPDgaMyev0y3y3/xg37jzbOIKpP7RSXnxDy22wCzaADfbwpwnwCXm9euXHpBmUU3117QAO/eY2QJCxi3mIXqx7N2w3sDpKY7bw+ff+41SSWqFmiYJP+9+Ndhy0zHJWhh6zPOFE5YXweDUsCy9mjNPGur04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=PlTQoTIG; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pgJOHL6eKLRoRRqaIiPicRmx3T3NmG07fCD4Avz/des=; b=PlTQoTIGrWd6EWOWpdwcOYiEgB
	VGV2aoDF0qGjUja+owJJnEVjwBuQRrcYOfa6Rcb07U6ZDhAj64hK5y2oMvQQsHEhothBL11YF+UFX
	O+s0LX/dZhGWs1lr48W6ZAdqkTYVcwz5YNqC+jxK8fffkD/3RQqNrBChbWZIQDfY5frf+isSCQCZQ
	rTPdkUjpM48pnL85Ge8h/3b4GLDoPHRUABR3R4IJcdh+U7xpaBjA8paFf++PqGxFeJmxFjXni1edN
	pYKm5nsVKZ405d1AEw0Nq6lQKgMkDJqYN0OTyq9URZqciOOPTXIeRlNHm1xQ3DRyVN1OfeMo9r32S
	Zd7kgPGg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rn1OV-00000004wlD-3e8J;
	Wed, 20 Mar 2024 19:14:36 +0000
Date: Wed, 20 Mar 2024 19:14:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Vlastimil Babka <vbabka@suse.cz>,
	Dan Carpenter <dan.carpenter@linaro.org>, NeilBrown <neilb@suse.de>,
	Dave Chinner <david@fromorbit.com>,
	Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <Zfs1m3VGvGh4OhX_@casper.infradead.org>
References: <ZeFtrzN34cLhjjHK@dread.disaster.area>
 <pv2chxwnrufut6wecm47q2z7222tzdl3gi6s5wgvmk3b2gq3n5@d23qr5odwyxl>
 <170933687972.24797.18406852925615624495@noble.neil.brown.name>
 <xbjw7mn57qik3ica2k6o7ykt7twryod6rt3uvu73w6xahrrrql@iaplvz7t5tgv>
 <170950594802.24797.17587526251920021411@noble.neil.brown.name>
 <a7862cf1-1ed2-4c2c-8a27-f9d950ff4da5@suse.cz>
 <aaea1147-f015-423b-8a42-21fc18930c8f@moroto.mountain>
 <73533d54-2b92-4794-818e-753aaea887f9@suse.cz>
 <ZfsxKOA5vfa9yo76@casper.infradead.org>
 <fqaedupymxnx23fo4k34obzahzubbjxgoka7uta2j7zyh2hg63@h2aupn6atmdh>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fqaedupymxnx23fo4k34obzahzubbjxgoka7uta2j7zyh2hg63@h2aupn6atmdh>

On Wed, Mar 20, 2024 at 03:07:38PM -0400, Kent Overstreet wrote:
> On Wed, Mar 20, 2024 at 06:55:36PM +0000, Matthew Wilcox wrote:
> > GFP_NOFAIL should still fail for allocations larger than KMALLOC_MAX_SIZE.
> > Or should we interpret that as "die now"?  Or "go into an unkillable
> > sleep"?  If the caller really has taken the opportunity to remove their
> > error handling path, returning NULL will lead to a crash and a lot of
> > beard stroking trying to understand why a GFP_NOFAIL allocation has
> > returned NULL.  May as well BUG_ON(size > KMALLOC_MAX_SIZE) and give
> > the developer a clear indication of what they did wrong.
> 
> Why do we even need KMALLOC_MAX_SIZE...?
> 
> Given that kmalloc internally switches to the page allocator when
> needed, I would think that that's something we can do away with.

... maybe check what I said before replying?

/*
 * SLUB directly allocates requests fitting in to an order-1 page
 * (PAGE_SIZE*2).  Larger requests are passed to the page allocator.
 */
#define KMALLOC_SHIFT_MAX       (MAX_PAGE_ORDER + PAGE_SHIFT)

You caan't allocate larger than that without going to CMA or some other
custom allocator.

So.  The caller has requested NOFAIL, and requested a size larger than
we can allocate.  Do we panic, go into an uninterruptible sleep, or
return NULL?


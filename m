Return-Path: <linux-fsdevel+bounces-24618-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 254D39415EA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 17:54:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4DB1283DEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2024 15:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429DC19E80F;
	Tue, 30 Jul 2024 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SSpK+W1k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAA129A2;
	Tue, 30 Jul 2024 15:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354863; cv=none; b=c3N/5yYIvJzcKBrol0ms/Ah5jCx4HqsJVjXKOOIP4oc54MbwnBz+9h7tWg6VmlnBQOb6gNpHXKoCSJji/l1h0g+uYlOV6uA8Xl+pN3rpafsbU7Z0IJu+1P/lO0AUnG+tdJLIv8JOtOczC4rMU9bjxcHpsudne27DflTAlevMCt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354863; c=relaxed/simple;
	bh=unEtCF3an6EuUhcVoxrAjGuLanbPeD/vRQNW+01TYfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F97/Rkwr28x0C8eqrHLGdVPKU4ZmQtcSmqfRcHhvniW1LegXOrjYD9TXSrzz4sTBemx4rDBVG+vS0i3ETmvaMsl79gpHQV2LDDdt7Zr8/XXGUMRYdEje6w9nDd9C7sdHUyDsW9JjDNcoT5vZy5sEPQj46MiGOM2zG/StSvgNm4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SSpK+W1k; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=6MXNumiKKmCQgh40ekmql/XajsTgk+xubikZMvobTSk=; b=SSpK+W1kp26+xjQWTTmaM5ZjCe
	2XK+V9aC4beetwb6xvFEEtZM0tauZM5ADdlXygFQZYfY1sOVipzzth/ZEc5rMgn9g2gdx7K2PX4ZD
	02XPutJJJFy3ehJQehM8oID2qMExXoI2bAN3xv/oazWG5i/jIAwnJjIfn9mFm7hzZcEk0xrLb9cnj
	9RbYHYeYjw/GXs6q6v5Oansql87rCbU2OeqCa/Wj/6cu9tdFyhqgCseznNhe8ybtmWftvIyttUVF7
	guJoQ5U6hGUmnfBws2Rw7OTuzPSr2N8gcX3iJQYJBWZXk2XQdstPHKE3oHPWK4dPb4D0gjKgHhkC9
	HadHxXCw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sYpB5-0000000ErhA-2ZyA;
	Tue, 30 Jul 2024 15:54:19 +0000
Date: Tue, 30 Jul 2024 16:54:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	linux-fsdevel@vger.kernel.org,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: Forcing vmscan to drop more (related) pages?
Message-ID: <ZqkMq9Id43s-V_Sf@casper.infradead.org>
References: <7e68a0b2-0bee-4562-a29f-4dd7d8713cd9@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e68a0b2-0bee-4562-a29f-4dd7d8713cd9@gmx.com>

On Tue, Jul 30, 2024 at 03:35:31PM +0930, Qu Wenruo wrote:
> Hi,
> 
> With recent btrfs attempt to utilize larger folios (for its metadata), I
> am hitting a case like this:
> 
> - Btrfs allocated an order 2 folio for metadata X
> 
> - Btrfs tries to add the order 2 folio at filepos X
>   Then filemap_add_folio() returns -EEXIST for filepos X.
> 
> - Btrfs tries to grab the existing metadata
>   Then filemap_lock_folio() returns -ENOENT for filepos X.
> 
> The above case can have two causes:
> 
> a) The folio at filepos X is released between add and lock
>    This is pretty rare, but still possible
> 
> b) Some folios exist at range [X+4K, X+16K)
>    In my observation, this is way more common than case a).
> 
> Case b) can be caused by the following situation:
> 
> - There is an extent buffer at filepos X
>   And it is consisted of 4 order 0 folios.
> 
> - vmscan wants to free folio at filepos X
>   It calls into the btrfs callback, btree_release_folio().
>   And btrfs did all the checks, release the metadata.
> 
>   Now all the 4 folios at file pos [X, X+16K) have their private
>   flags cleared.
> 
> - vmscan freed folio at filepos X
>   However the remaining 3 folios X+4K, X+8K, X+12K are still attached
>   to the filemap, and in theory we should free all 4 folios in one go.
> 
>   And later cause the conflicts with the larger folio we want to insert.
> 
> I'm wondering if there is anyway to make sure we can release all
> involved folios in one go?
> I guess it will need a new callback, and return a list of folios to be
> released?

I feel like we're missing a few pieces of this puzzle:

 - Why did btrfs decide to create four order-0 folios in the first
   place?
 - Why isn't there an EEXIST fallback from order-2 to order-1 to order-0
   folios?

But there's no need for a new API.  You can remove folios from the page
cache whenever you like.  See delete_from_page_cache_batch() as an
example.


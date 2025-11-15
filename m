Return-Path: <linux-fsdevel+bounces-68559-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 03868C60015
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 06:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8EDD235775A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 05:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C6486359;
	Sat, 15 Nov 2025 05:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Aec3IxiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C4B17D2
	for <linux-fsdevel@vger.kernel.org>; Sat, 15 Nov 2025 05:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763183284; cv=none; b=MulBlIlYna9jFQe4B+V0+rptAXVNl/Ld+arBiB2BkykGWNnvilEr5P/XJvCUqpW7UDdA2e03WkIUccftA/4sFh8cPzthWhASBdo85eRNwwRJLNwE45xrhw5fj2chl9/CGJzm6fIOUmegSefqmVYA3+yv0vHrGl3byOpLHsg4g3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763183284; c=relaxed/simple;
	bh=d/Vn5WVMBPfGDLR6GqBlFrHlL5U3hUj3ElSZZMRUQNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkU/xNo+XaKZ60K89UShvjNeRAi5UXdqZND5PgTxNj6o/+HYWNbEF+LwbIeLXNBOqXsYv69LvYi8R1P/EC9haeWJ0kyOdLb3gXI6pcoTVzUY8hxYc9MCRQivZvwroNnySaQnP9fZWI9X7eX7h+GmkPwjCBbFoiKPP+85FgLyWJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Aec3IxiE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=99bQhguiuvazJLFnjKQ96ejx9/UPWFkM7J+BT7DI66A=; b=Aec3IxiEL5092Gm6TG0Pk9XJ55
	glHK9plEA75MzUf8Zz6BcJ+T0Mo1EwBxc/o7F2fmQnpI60Zv8fbMqg9InpFwqoK1/4pyRoHTeed1I
	8eee0tqD8pGMS0L6C+r8JjsTOh5AGFpy/JX0lMCcrt0GEJFwFld7rpqESA9UFgfxLTvC2TH6onFXF
	qs75PU/i3yohNvWalhAieys0pTsDh0jIq5enKAr1n+wCakJlEE4KLW9S3MMKX6sbKfACfUIA5yYRQ
	lyoQDeD+8HnTjCoTF1RPznuPVZzAhK2M3pjgcNeHJlFVyG/CWxOQ8zn/fjQiVt/dMnSedsHLUZBwV
	78bvpMrg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vK8Vl-0000000APIW-0vnk;
	Sat, 15 Nov 2025 05:07:45 +0000
Date: Sat, 15 Nov 2025 05:07:45 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: "David Hildenbrand (Red Hat)" <david@kernel.org>,
	akpm@linux-foundation.org, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, mhocko@suse.com, ziy@nvidia.com,
	baolin.wang@linux.alibaba.com, npache@redhat.com,
	ryan.roberts@arm.com, dev.jain@arm.com, baohua@kernel.org,
	lance.yang@linux.dev, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH] mm/huge_memory: consolidate order-related checks into
 folio_split_supported()
Message-ID: <aRgKoQT2ZYH_x2wa@casper.infradead.org>
References: <20251114075703.10434-1-richard.weiyang@gmail.com>
 <827fd8d8-c327-4867-9693-ec06cded55a9@kernel.org>
 <20251114150310.eua55tcgxl4mgdnp@master>
 <64b43302-e8cc-4259-9fa1-e27721c0d193@kernel.org>
 <20251115025109.yerb7gbty4h7h63s@master>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251115025109.yerb7gbty4h7h63s@master>

On Sat, Nov 15, 2025 at 02:51:09AM +0000, Wei Yang wrote:
> I am not 100% for sure. While if we trust it returns 0 if folio doesn't
> support large folio, I am afraid we can trust it returns correct value it
> supports. Or that would be the issue to related file system.
> 
> To be honest, I am lack of the capability to investigate all file system to
> make sure this value is properly setup.

Maybe you should just give up on this instead of asking so many
questions, misunderstanding the answers, and sending more patches full
of mistakes?


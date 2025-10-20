Return-Path: <linux-fsdevel+bounces-64714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2723CBF1F5D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 16:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A41024F79CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Oct 2025 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A151238166;
	Mon, 20 Oct 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gp41J2Nl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3166230274;
	Mon, 20 Oct 2025 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760972352; cv=none; b=Q8nEbOAnFcdPMLrgw1M4vvNnRGJF1e8cy4BIOVwClwMyA92oIn2ZBCOI3p1kJ2xm2W4ULwMbonSWf8CR3xdBot+vnFmqb1uohuQ14BI4ErDe8quOPtu+P7sDBq18jAwTsUTjH0y2CRBrvRrfpw/iX6T5fvXdEOJ+E3+BbvABLiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760972352; c=relaxed/simple;
	bh=iUXQuriDyZRT8WBoI7eXj7hrTtTGVdywTUS4oyOBBN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pD9NZqY3erRaSrmdkYPZ4jPYAvqQthOg6Bgml8c75dibEPrs+UkpWoIJSa2Ij8ceUeJ+lb+zfuDXKBs5k7ItNZic9JPqOfP5IG0lZ3OXVyTcOI8dcvhIN0qec6iaShQe68p/mos9e5JQGV6qR3azS36DC5BlhRUTKqZWmD5LXfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gp41J2Nl; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=docrPGLeWwfEDBF/7JprhY10nMkkvgXOdF2vgxv0F28=; b=gp41J2Nl+5HhU+fdHp9Yi14Y10
	O+WveHEJqqkdtliUeqgcfJlNF9GA6kcB4bP6KiSqF0eVVTz0r9MKVqzJ5nDn8Vu5EhNP8NBvynYIh
	YJuqpPuI6Nm94OsbkraF6eQMRMrK2+7gXazXperZn+Tu1ZauOlrYnuf5mpUZxviHFKueyb8bUpjeQ
	s1J+EUNuWGPcRi3g30hlygtR2hrsetRCJOGV/2B1PbxadPiIYqcs3p3YjLSmIhpvE4vjATnh5ErcT
	ijmIPZNipvE6DO/3hM3czpQpRmdinq2h1pcKGcx/2zvaMZD0SHd3z8kIS70GvoHQ7Nbk/h3gPDhqT
	ljKHEkIA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vArLn-0000000AW7d-3SBA;
	Mon, 20 Oct 2025 14:59:07 +0000
Date: Mon, 20 Oct 2025 15:59:07 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Christoph Hellwig <hch@infradead.org>, Qu Wenruo <wqu@suse.com>,
	linux-btrfs@vger.kernel.org, djwong@kernel.org,
	linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	martin.petersen@oracle.com, jack@suse.com
Subject: Re: O_DIRECT vs BLK_FEAT_STABLE_WRITES, was Re: [PATCH] btrfs: never
 trust the bio from direct IO
Message-ID: <aPZOO3dFv61blHBz@casper.infradead.org>
References: <1ee861df6fbd8bf45ab42154f429a31819294352.1760951886.git.wqu@suse.com>
 <aPYIS5rDfXhNNDHP@infradead.org>
 <56o3re2wspflt32t6mrfg66dec4hneuixheroax2lmo2ilcgay@zehhm5yaupav>
 <aPYgm3ey4eiFB4_o@infradead.org>
 <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mciqzktudhier5d2wvjmh4odwqdszvbtcixbthiuuwrufrw3cj@5s2ffnffu4gc>

On Mon, Oct 20, 2025 at 03:59:33PM +0200, Jan Kara wrote:
> The idea was to bounce buffer the page we are writing back in case we spot
> a long-term pin we cannot just wait for - hence bouncing should be rare.
> But in this more general setting it is challenging to not bounce buffer for
> every IO (in which case you'd be basically at performance of RWF_DONTCACHE
> IO or perhaps worse so why bother?). Essentially if you hand out the real
> page underlying the buffer for the IO, all other attemps to do IO to that
> page have to block - bouncing is no longer an option because even with
> bouncing the second IO we could still corrupt data of the first IO once we
> copy to the final buffer. And if we'd block waiting for the first IO to
> complete, userspace could construct deadlock cycles - like racing IO to
> pages A, B with IO to pages B, A. So far I'm not sure about a sane way out
> of this...

There isn't one.  We might have DMA-mapped this page earlier, and so a
device could write to it at any time.  Even if we remove PTE write
permissions ...


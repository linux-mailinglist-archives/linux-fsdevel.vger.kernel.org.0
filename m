Return-Path: <linux-fsdevel+bounces-25874-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C06629513C9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 07:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53C122838E4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2024 05:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBE6655E58;
	Wed, 14 Aug 2024 05:21:17 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8173F3D552;
	Wed, 14 Aug 2024 05:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723612877; cv=none; b=osTboWyNsjjZMZ9XqbCCAQcU/EYwaTRyC0bM3t79lNulCKjM8evBlWoQ9dWsANjcqn+tG+Vn6l0H0KBvlP8HlZ/lkXuLrQKBRzEDccawmyocWrohcyeKHiEh0lcac2ParPnRVbluMuLFnUCWiYeXEHRXzjTZLf75p1vNRI/NOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723612877; c=relaxed/simple;
	bh=hiFgZ4lgI34I18iPdNIEumOyHlNswzdbFci1RGY0yik=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5obmzL0B5h+534x8Fz+w4Nwg6In4UCfVvk3Lj4uPRSSLLyH23fE06B+XDtJn5MOZ0kMrCCHmL3tW9EFz5zZoGRiH/KKvaKnGXluU/MGmUwcwkchP/L3FvjCeZKgwRlkCuy3GD+JOe4uAv2OmERkllQ6DpAi7dlC5XNGgRi3kCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 60A6B227A88; Wed, 14 Aug 2024 07:21:11 +0200 (CEST)
Date: Wed, 14 Aug 2024 07:21:11 +0200
From: Christoph Hellwig <hch@lst.de>
To: Dave Chinner <david@fromorbit.com>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/3] xfs: convert perag lookup to xarray
Message-ID: <20240814052111.GA30979@lst.de>
References: <20240812063143.3806677-1-hch@lst.de> <20240812063143.3806677-3-hch@lst.de> <Zrw5q0qTi9m8AT6+@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zrw5q0qTi9m8AT6+@dread.disaster.area>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 14, 2024 at 02:59:23PM +1000, Dave Chinner wrote:
> Can we split the implementation change and the API change into two
> separate patches, please?

I don't think that is entirely possible, but things can be split
a bit more.  I've actually done some of that including more API
changes in the meantime, so this might only need small adjustments
anyway.

> So what's the overall plan for avoiding this sort of mess
> everywhere? Can we re-implement the existing iterators more
> efficiently with xarray iterators, or does xarray-based iteration
> require going back to the old way of open coding all iterations?

We can reimplement them, but they won't be more efficient.  That
being said using the xas iterator for places that don't need to
unlock works really nicely, and I've added a little syntactic sugar
to make this even nicer as in:

	rcu_read_lock();
	for_each_perag_marked(mp, pag, XFS_PERAG_RECLAIM_MARK) {
		/* do stuff */
	}
	rcu_read_unlock();

which is about as good as it gets in terms of efficiency and readability.

For the ones that need to sleep I'm now doing:

	struct xfs_perag        *pag = NULL;

	while ((pag = xfs_iwalk_next_ag(mp, pag, XFS_PERAG_BLOCKGC_MARK))) {
		/* do stuff */
	}

which is also nice, and except for the _MARK stuff due to the sparse
__bitwise annotations can be one in a prep patch.



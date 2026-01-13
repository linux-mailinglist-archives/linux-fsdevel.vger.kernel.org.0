Return-Path: <linux-fsdevel+bounces-73485-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3145D1AC34
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 18:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D55223039311
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6265D393DEB;
	Tue, 13 Jan 2026 17:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NeFATdgw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA629393DD1;
	Tue, 13 Jan 2026 17:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327032; cv=none; b=Ru9Vim06W15GJIT0PR0rFZ0AFp/14n1IYgqGgma4A4Ys2gaJb9PGQGYqXwAqJonI0EFrZ2vgekPltPHiwpGZJcQwXBUMaLBf2UTclYYCElQ+l+cpoFQXRsGJTMgmWpobXHYplL1IqHNV0COBKYaahKK3PXval/+eB/oqNGZYFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327032; c=relaxed/simple;
	bh=IGnZgSdYSt1Q7evESWar7dLgX5qvztCovEEfuDlcu4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KodeM+23Q9Ekr4ZSqH9aNCVMlxoMZBAz+7kM8VtjDbtzGr9nIuE9RLjxJ+aqB4+kJVE02WnD9MMzlr23m3tye73xtBVHQh4lQITTg7sBbrfpy5LaKuovz5anV1qTPiVBCONerosKcHgRwDva4ejxMy07B4ZUXu33S1/MeAFmfzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NeFATdgw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A46BC116C6;
	Tue, 13 Jan 2026 17:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768327032;
	bh=IGnZgSdYSt1Q7evESWar7dLgX5qvztCovEEfuDlcu4Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NeFATdgwTqh0WPcr3evLyjJ0TlyMSe7sYo+AcQuwLu5NRszH/n5lFM+H9AFyuQpBV
	 +UTKxRsp5nYs54kN7eGGnACwfDoU/KFxlHCgmcxcgdqKHX0JGDsfIzbzhFy8wv/HV9
	 ySuHbQEa2jPQFYz8EaxEejM6WwgJ3hTIFl3GF9oJZDnb5BFBua8sa2VbVcXgz8NJfT
	 sbKi0BoWeerXG+JVCStKmpE3WpQsR3K3CSna2gKX2QBG69RAvLmuDyki0agIsQisy/
	 n/byWVIsxWlEM0I9R7425z0o/QUexeIUP/WW1Xf7UiT7Ee0U3Sf5AMHNV3hcvDVvpr
	 H6JxpkvImyPAw==
Date: Tue, 13 Jan 2026 09:57:11 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrey Albershteyn <aalbersh@redhat.com>, fsverity@lists.linux.dev,
	linux-xfs@vger.kernel.org, ebiggers@kernel.org,
	linux-fsdevel@vger.kernel.org, aalbersh@kernel.org,
	david@fromorbit.com
Subject: Re: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <20260113175711.GW15551@frogsfrogsfrogs>
References: <cover.1768229271.patch-series@thinky>
 <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5>
 <20260112221853.GI15551@frogsfrogsfrogs>
 <20260113081220.GB30809@lst.de>
 <xjz5a35ypk3am6fbhkfdeeeilu54lhbcymginjv6srjve4qfjn@uucfin46ylhj>
 <20260113162202.GA5287@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113162202.GA5287@lst.de>

On Tue, Jan 13, 2026 at 05:22:02PM +0100, Christoph Hellwig wrote:
> On Tue, Jan 13, 2026 at 11:50:07AM +0100, Andrey Albershteyn wrote:
> > 
> > Hmm not sure how you see this, the verity pages need to get written
> > somehow and as they are beyond EOF they will be zeroed out here.
> > 
> > Regarding your comment in the thread to use direct IO, fsverity
> > wants to use page cache as cache for verified pages (already
> > verified page will have "verified" flag set, freshly read won't).
> 
> Ok, I guess we need to stick to the pagecache based path then.
> The upside is less differences from the existing file systems.

<nod> IIRC fsverity also doesn't allow directio, so it seems more
consistent to me that newly created fsverity artifacts are written
through the pagecache IO paths.

--D


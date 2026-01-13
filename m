Return-Path: <linux-fsdevel+bounces-73469-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D8323D1A3A3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 17:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50CF630C4DEC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 16:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C142ECE9E;
	Tue, 13 Jan 2026 16:22:07 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472FC2E974D;
	Tue, 13 Jan 2026 16:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768321327; cv=none; b=LmgpQ2mvhcs0+WOd5Ys5MKXPLUHQUFGTK/GIi0gR3uTVbcJM0Cz/jhnQDZCYrn6NvC08AAqdHtGgaOTdY6B68FlbA2zfx+c55ZHhz/nB0jqDkhFuj6Ze5zAnZ7r49R0XHL6G+f3SLCC5jjeh9ghp3NQ8YwuyDNqx4antyPjBf4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768321327; c=relaxed/simple;
	bh=wthBqmrQmaUEJnsiczcnnaEjm9eYruj7qmaIOeScPzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J6ER+xOWod3FheS7BEnZ3uRrrcMk2IQ/nGAyCOIpyXlYRxhiZvw3bmW1AoOy/iCwcggsi4pNnFFe/JzusH7o4F6tP+HNxHr/TvhLOUk04QmrdyhVnKwzXP3iMtFYOPamTird8E80Ovx+RTbbQjjYeL7ys5gzQq+eIrc+0xIzEaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E5E93227AA8; Tue, 13 Jan 2026 17:22:02 +0100 (CET)
Date: Tue, 13 Jan 2026 17:22:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>, "Darrick J. Wong" <djwong@kernel.org>,
	fsverity@lists.linux.dev, linux-xfs@vger.kernel.org,
	ebiggers@kernel.org, linux-fsdevel@vger.kernel.org,
	aalbersh@kernel.org, david@fromorbit.com
Subject: Re: [PATCH v2 3/22] iomap: introduce IOMAP_F_BEYOND_EOF
Message-ID: <20260113162202.GA5287@lst.de>
References: <cover.1768229271.patch-series@thinky> <d5fc72ldfwyzbgiypzlhn5diiqyijxaicpa3w6obx4iismuko3@kttpcgqjy6i5> <20260112221853.GI15551@frogsfrogsfrogs> <20260113081220.GB30809@lst.de> <xjz5a35ypk3am6fbhkfdeeeilu54lhbcymginjv6srjve4qfjn@uucfin46ylhj>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xjz5a35ypk3am6fbhkfdeeeilu54lhbcymginjv6srjve4qfjn@uucfin46ylhj>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Jan 13, 2026 at 11:50:07AM +0100, Andrey Albershteyn wrote:
> 
> Hmm not sure how you see this, the verity pages need to get written
> somehow and as they are beyond EOF they will be zeroed out here.
> 
> Regarding your comment in the thread to use direct IO, fsverity
> wants to use page cache as cache for verified pages (already
> verified page will have "verified" flag set, freshly read won't).

Ok, I guess we need to stick to the pagecache based path then.
The upside is less differences from the existing file systems.



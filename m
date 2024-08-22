Return-Path: <linux-fsdevel+bounces-26659-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 092CE95AC39
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 05:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC2DC280E6A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Aug 2024 03:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D1A036AFE;
	Thu, 22 Aug 2024 03:45:54 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619111A277;
	Thu, 22 Aug 2024 03:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724298354; cv=none; b=HnQeA9zEy337/JueWUISZsd6FycgZ4fPicuhtaidiKXMnnVysIDGDwkYZJ5R67BLwLjZxLOnIQ/xNPI1MpylYiZECHGB153D9aEvb9KUt7cPKX+MDsNT3nZVOAdWeSYAdkUMMZV4BUvnyljrBa2uVNq4kqDyY/LbPzkBiMbRHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724298354; c=relaxed/simple;
	bh=mIa9JYfzAipUBzgVYDV97c9fmgtfHXkkKjtZyodpapM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iy908eHdN2dOB1A8aTtWpwuZqMIU8YHuTSSqSWH6z5YMbj0gBTA2My0YB5U3/BdaRA/H6x8kIp/p/etJ5UR28Gdqfe+2Lm2Wn8M20OK/x8PrE/JjR9kcmc7BO+KgXlljfSMMaHeUccQ/exABUqFlEdcj2XPiB8AGBHswVKEoeFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 671CB227A8E; Thu, 22 Aug 2024 05:45:48 +0200 (CEST)
Date: Thu, 22 Aug 2024 05:45:48 +0200
From: Christoph Hellwig <hch@lst.de>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/5] xfs: convert perag lookup to xarray
Message-ID: <20240822034548.GD32681@lst.de>
References: <20240821063901.650776-1-hch@lst.de> <20240821063901.650776-5-hch@lst.de> <20240821162810.GF865349@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240821162810.GF865349@frogsfrogsfrogs>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Aug 21, 2024 at 09:28:10AM -0700, Darrick J. Wong wrote:
> On Wed, Aug 21, 2024 at 08:38:31AM +0200, Christoph Hellwig wrote:
> > Convert the perag lookup from the legacy radix tree to the xarray,
> > which allows for much nicer iteration and bulk lookup semantics.
> 
> Looks like a pretty straightforward covnersion.  Is there a good
> justification for converting the ici radix tree too?  Or is it too
> sparse to be worth doing?

radix trees and xarrays have pretty similar behavior related to
sparseness or waste of interior nodes due to it.  So unless we find a
better data structure for it, it would be worthwhile.

But the ici radix tree does pretty funny things in terms of also
protecting other fields with the lock synchronizing it, so the conversion
is fairly complicated and I don't feel like doing it right now, at least
no without evaluating if for example a rthashtable might actually be
the better data structure here.  The downside of the rthashtable is
that it doens't support tags/masks and isn't great for iteration, so it
might very much not be very suitable.



Return-Path: <linux-fsdevel+bounces-16688-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 582278A16CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 16:10:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECC561F21AD5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Apr 2024 14:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24C814E2EA;
	Thu, 11 Apr 2024 14:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oDiANBVq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591CB149C7F;
	Thu, 11 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712844631; cv=none; b=Dmd0OdRGFuin9SW3/ZOKDAIVMp4EeyTpTTW81+zpNg0yq2ivzFhTQP3lnQE0tW2sqm5i0GQZpEGYGcWF6hTQ787RecSHfr1wH0Dqw86KzhJj/MpdEIXSg8vC0XvU2k9dVQxQQjgleqMA36ofJhq6bdwDlOaYi3JRi1iP4B7RAFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712844631; c=relaxed/simple;
	bh=G4lNb0v3ZtHlkx0vH6AwvDqD6tsugHAe7upynelVvts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uR3F16TSWTQY56A12UFFUaknQzG5ZSJt3aOCkyOy6QXchUtZDQXz1Y1YugKdUAZ0d0QnW4eUZCsW2iTiKsFvtxANF3501PGq6anzlb+WsLFuhPeiRX5tBX0dFmPzGDoFGesw2Js2T8/XQkMNPAGb92KvUD9iNBQ5OOqUntjgT1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=oDiANBVq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=erzRazoUFf0ozboYbu3QcZz8RyM7ffSzd+JFbM6Ge+Q=; b=oDiANBVqfwpUInZAI+qxzHiKs5
	/Fl/0EBc8p6ZnhZkIiPrXZZ3NQ+4hVXY+UfC+oKQwgIH5215GgNWwbgLWqQIzUp2sNOQk1x8zSeje
	BllT0miOuQz2XJa8UB0X/HC9IbPZCPR/NqQxjUeQQeIQ4jxAdwu5rK3k5swzrDN7XWoD/LnNzlCoK
	EWR7cLFWf/Zvz3FJPiXisxDqWcR+/+ltNj1XufULs+9d7Bo896HMc9SZnHHIJZ/i+MXU02q31llB/
	YlaCfOegPFTe5lCal2aE/znH6zb2wffKGdgbyQvb2kGnpgkQLhvA9QFjbxFFKnFKZYtFP7j6KCeNL
	FOprjeqw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruv8B-0000000767L-2DcS;
	Thu, 11 Apr 2024 14:10:23 +0000
Date: Thu, 11 Apr 2024 15:10:23 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, david@fromorbit.com, dan.j.williams@intel.com,
	jhubbard@nvidia.com, rcampbell@nvidia.com, jgg@nvidia.com,
	linux-fsdevel@vger.kernel.org, jack@suse.cz, djwong@kernel.org,
	hch@lst.de, david@redhat.com, ruansy.fnst@fujitsu.com,
	nvdimm@lists.linux.dev, linux-xfs@vger.kernel.org,
	linux-ext4@vger.kernel.org, jglisse@redhat.com
Subject: Re: [RFC 07/10] mm: Allow compound zone device pages
Message-ID: <ZhfvT6SXfCR60NAG@casper.infradead.org>
References: <cover.fe275e9819458a4bbb9451b888cafb88af8867d4.1712796818.git-series.apopple@nvidia.com>
 <9c21d7ed27117f6a2c2ef86fe9d2d88e4c8c8ad4.1712796818.git-series.apopple@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c21d7ed27117f6a2c2ef86fe9d2d88e4c8c8ad4.1712796818.git-series.apopple@nvidia.com>

On Thu, Apr 11, 2024 at 10:57:28AM +1000, Alistair Popple wrote:
> Supporting compound zone device pages requires compound_head() to
> distinguish between head and tail pages whilst still preserving the
> special struct page fields that are specific to zone device pages.
> 
> A tail page is distinguished by having bit zero being set in
> page->compound_head, with the remaining bits pointing to the head
> page. For zone device pages page->compound_head is shared with
> page->pgmap.
> 
> The page->pgmap field is common to all pages within a memory section.
> Therefore pgmap is the same for both head and tail pages and we can
> use the same scheme to distinguish tail pages. To obtain the pgmap for
> a tail page a new accessor is introduced to fetch it from
> compound_head.

Would it make sense at this point to move pgmap and zone_device_data
from struct page to struct folio?  That will make any forgotten
places fail to compile instead of getting a bogus value.


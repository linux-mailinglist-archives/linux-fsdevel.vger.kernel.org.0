Return-Path: <linux-fsdevel+bounces-34474-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42BAE9C5C44
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 16:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06EC62830BE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2024 15:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33A1D202659;
	Tue, 12 Nov 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HjnTyT0/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F85B2022FD;
	Tue, 12 Nov 2024 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426539; cv=none; b=ZO0084gDjbMsf1reURp31Jb1OF/dwL/NA3yEMNgwHNOlrxAjvgHRg83AR1MsnNekvAVffHSomYCVyEoYebSiCSVKSU6emPr4GTkRhk6ehGYfJ49HKtFA/AvVIQKEBnUN2OtNLJYI/iwgcOiskxpVITZ9FXw5J+JPJWlcaRu8jTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426539; c=relaxed/simple;
	bh=L0z0F1JNTV4p+QkiVH7/LmBw402G6qG18jLotqdAtSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X4ctB6L6kbSY+HvZTQ2mhKCuYhhHKFnkYGjZ06s8p6RA+eLZyUmOS+zGuzK5IQIEhqdqROiKBD3tovHFXvlGvxUtaC4wp1F7szYgJNsYzjMy17pmEGxaOE2SjuCDsCiMqi+dQwUh7l28u6JzNRmcotyGU1Bkbg+NNy78T+W26C4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HjnTyT0/; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=aTK0cEepUZLimABo8nAccUNxBY1Jvh+KAU/SAPsoyn8=; b=HjnTyT0/IV9s5rkgOlqxXQ0fZE
	lJb2Nl5Ce1w9kI3ysQsAqA8pyltZzpggSahQ/CDYno1CO/HhL0pZNvoZDFNP9PzDIz2Pp2fBEniKv
	lVSARYlCXWOxWwSxWhQpLbBp3fIjLv6rAGK6FnR/tw9wcHhQiD4iSeCraSiXAJ/iVLihhGoUQu0sy
	P8ML6Vkpq+JZmBGy9VrjzmSTKXT32YYiHgnFqQWuPJb5mMld8ZCFsy2DMDOCWNyLydWBQBHKQkx4t
	c1VYK1pdyfex4/wsKjYh2SdJSkPVjgzbEjVy69ibxJz2zmlWlLgKUNoAXS0eQ9pLNa1crQfepGkIH
	cKtejkQg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAt8O-0000000Ea84-0B0X;
	Tue, 12 Nov 2024 15:48:52 +0000
Date: Tue, 12 Nov 2024 15:48:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RESEND V2 0/5] Fixes and cleanups to xarray
Message-ID: <ZzN446h5pdMsYfRa@casper.infradead.org>
References: <20241111215359.246937-1-shikemeng@huaweicloud.com>
 <20241111132816.3dcbb113241353e9a544adab@linux-foundation.org>
 <8667a8e9-8052-4a32-817a-2c4ef97ddfbe@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8667a8e9-8052-4a32-817a-2c4ef97ddfbe@huaweicloud.com>

On Tue, Nov 12, 2024 at 03:05:51PM +0800, Kemeng Shi wrote:
> Patch 1 fixes the issue that xas_find_marked() will return a sibling entry
> to users when there is a race to replace old entry with small range with
> a new entry with bigger range. The kernel will crash if users use returned
> sibling entry as a valid entry.
> For example, find_get_entry() will crash if it gets a sibling entry from
> xas_find_marked() when trying to search a writeback folios.

You _think_ this can happen, or you've observed a crash where it _has_
happened?  I don't think it can happen due to the various locks we
have.  I'm not opposed to including this patch, but I don't think it
can happen today.

> Patch 3 fixes the issue that xas_pause() may skip some entry unepxectedly
> after xas_load()(may be called in xas_for_each for first entry) loads a
> large entry with index point at mid of the entry. So we may miss to writeback
> some dirty page and lost user data.

How do we lose user data?  The inode will still contain dirty pages.
We might skip some pages we should not have skipped, but they'll be
caught by a subsequent pass, no?


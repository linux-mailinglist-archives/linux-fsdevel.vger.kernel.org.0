Return-Path: <linux-fsdevel+bounces-22521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C22FD91859D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 17:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EF63B28FD2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Jun 2024 15:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE3AF18A932;
	Wed, 26 Jun 2024 15:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lJN7YtHE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF2A6BB26;
	Wed, 26 Jun 2024 15:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719414978; cv=none; b=CLK8y2sJIqBXGeLvQ1mngx9xR3f5cyaoO65lb7TQM526kkp0022Effx8DObdvHSq9mSnTSMNfUN6V11/oHdTBLVfexJBhfl5iOWdYzbzN8yPVVhwY5Jv9gCM66h1MS8skX24kQ22Q1TjuQ0XojD66EnpyBq3t/Fn8C3B0mh01mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719414978; c=relaxed/simple;
	bh=EwQMoBprrvluUbNzkLTyFZpWfn561qwV0HjoO8qZynY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHK/kPIIK+8yzjt0lOOEErtnv1kF0OQTS0UaI5VrV4fh5z1QVzR0bfyesKfYrDEUmiOyviCfUMCE1oio0g0YrGHZooJfsJnsNkHvXPa4nOZjjEbxdaYTYc6Xr0X/0c8r9aPQOAPVnjekHuRbpGYl8evEBXeluTZEWw5QUXqOc/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=lJN7YtHE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5EdOTGvxwbvxyfWt8EtSyA/AQ5B1tWpg+LU4ga2BqOQ=; b=lJN7YtHE9IfSxh4tNAjP1Db3rU
	0SRI9Hi3XvVCHa5v3PYaptaqaFQzSofr/frIbKOEXyxJXAlPxlJ0M0o89TMRLNnH6Xm8yT/umbKu1
	CWYW9kKnVJn8SvlSZm1Kigf/lQ7kg0oRzmCGzj0ZQPXJpwvw29cNpBiRHsEmSRr9Kbo26/LwYc2GS
	YSq08gWhsaswRfsGENO5xEXZCdzLD5pam0GG2wK7Zi2Qk/cj6HKNlbI9/GQrXrVaMSegRNErKphXg
	V9pO5eYx0J4O05dDw+DGGo8nsVCRdGfUAqM1XqhEOj6UoBa+hu+wrQ3JV0NaYZ9mkdezryUVZyKKz
	A7m3uSqw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sMUNK-0000000CTXw-1wR1;
	Wed, 26 Jun 2024 15:15:58 +0000
Date: Wed, 26 Jun 2024 16:15:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Zi Yan <ziy@nvidia.com>, ran xiaokai <ranxiaokai627@163.com>,
	akpm@linux-foundation.org, vbabka@suse.cz,
	svetly.todorov@memverge.com, ran.xiaokai@zte.com.cn,
	baohua@kernel.org, peterx@redhat.com, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] kpageflags: fix wrong KPF_THP on non-pmd-mappable
 compound pages
Message-ID: <Znwwrnk77J0xfNxu@casper.infradead.org>
References: <20240626024924.1155558-1-ranxiaokai627@163.com>
 <20240626024924.1155558-3-ranxiaokai627@163.com>
 <D29M7U8SPSYJ.39VMTRSKXW140@nvidia.com>
 <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1907a8c0-9860-4ca0-be59-bec0e772332b@arm.com>

On Wed, Jun 26, 2024 at 12:07:04PM +0100, Ryan Roberts wrote:
> On 26/06/2024 04:06, Zi Yan wrote:
> > On Tue Jun 25, 2024 at 10:49 PM EDT, ran xiaokai wrote:
> >> From: Ran Xiaokai <ran.xiaokai@zte.com.cn>
> >>
> >> KPF_COMPOUND_HEAD and KPF_COMPOUND_TAIL are set on "common" compound
> >> pages, which means of any order, but KPF_THP should only be set
> >> when the folio is a 2M pmd mappable THP. 
> 
> Why should KPF_THP only be set on 2M THP? What problem does it cause as it is
> currently configured?
> 
> I would argue that mTHP is still THP so should still have the flag. And since
> these smaller mTHP sizes are disabled by default, only mTHP-aware user space
> will be enabling them, so I'll naively state that it should not cause compat
> issues as is.
> 
> Also, the script at tools/mm/thpmaps relies on KPF_THP being set for all mTHP
> sizes to function correctly. So that would need to be reworked if making this
> change.

I told you you'd run into trouble calling them "mTHP" ...


Return-Path: <linux-fsdevel+bounces-9944-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C03BD846563
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 02:25:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0802C1C24711
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Feb 2024 01:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A856C8DD;
	Fri,  2 Feb 2024 01:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DiNtg3h9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8B33C2CE;
	Fri,  2 Feb 2024 01:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706837092; cv=none; b=G/i9ZVgEBmT0LTOEmaC4HIAjhPhkOhE5IZwP2jKLoLdicTWpPzaqcWEQ/7HuiB5ufFSrQw5Nz0oOXnjyaPkRB8A8kws8+1uO5YQeKqD2aB58atLYgqk2TZME0UqNe21wOyCYDZVT9n/hnbOTQhu5lvT8f6DbWLOpxj1HyHXwumk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706837092; c=relaxed/simple;
	bh=vGXj/mbBHExZ0hyGaeZlChtEqUkXjfoLMRZCEAZOoIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eDkMRUy6IW/CiKNT4wOPES+CdeNRmq9n/PVkyCluyAaG4Kpp6sUfG3XImNKzzOdiPhzDZBvph8v0P/hYaE6iCBEPler/faY0NELwHh0nBCoVF0drM4iA0n9FVdgRnSzH80ym6QMHIfyBHcqI+cEgq+3PwK0KZrOlEKpXxtBBMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DiNtg3h9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=deTcPudQb1LLYDVYJumshzY+T34o+9j3YfiZCpY3Leg=; b=DiNtg3h9mNpuI6tOVecjeqd9z1
	HYp1EqOP362+2uhN1l080ShEjx1f3xO2fa+xUkANqbMKY3uXPiuZvFIEobsVsf0I688u6RF0EGU/g
	fi64gMCgkNNObs1fl1iPr2wPGYX1M4R4LaSP9hctzURq+ARzTxm9Sy4ZbpcoFyILZ/J8Dz8RYhhsb
	8vXcpah+h3icso4g5vQ/17kTDpgMagYM9ZmFTAF5YbiNBotxDGgj7Y9VV3SNdIPWTZDdOgkdkXUyQ
	2VbhG5n4avx4tcxfaPJmMLcGoi23kj56iKSwZrPvUqCmfzE3VLdjpyI8UTO/1+AYkQpES4N6LtrJh
	4rwgEpSA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rViIN-0000000HKmL-4244;
	Fri, 02 Feb 2024 01:24:44 +0000
Date: Fri, 2 Feb 2024 01:24:43 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Douglas Anderson <dianders@chromium.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>,
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
Message-ID: <ZbxEWyl5Zh_3VwLb@casper.infradead.org>
References: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240201171159.1.Id9ad163b60d21c9e56c2d686b0cc9083a8ba7924@changeid>

On Thu, Feb 01, 2024 at 05:12:03PM -0800, Douglas Anderson wrote:
> While browsing through ChromeOS crash reports, I found one with an
> allocation failure that looked like this:
> 
>   chrome: page allocation failure: order:7,
>           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
> 	  nodemask=(null),cpuset=urgent,mems_allowed=0

That does seem bad ...

> @@ -16,14 +17,14 @@ static int __regset_get(struct task_struct *target,
>  	if (size > regset->n * regset->size)
>  		size = regset->n * regset->size;
>  	if (!p) {
> -		to_free = p = kzalloc(size, GFP_KERNEL);
> +		to_free = p = vmalloc(size);

It's my impression that sometimes this size might be relatively small?
Perhaps we should make this kvmalloc so that we can satisfy it from the
slab allocator if it is small?

Also, I assume that we don't rely on this memory being physically
contiguous; we don't, for example, do I/O on it?


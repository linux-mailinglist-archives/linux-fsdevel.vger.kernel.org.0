Return-Path: <linux-fsdevel+bounces-34332-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68EA79C4863
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 22:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E6FE1F215CD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Nov 2024 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED70E1BBBEE;
	Mon, 11 Nov 2024 21:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h8UQZ32v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E1158D94;
	Mon, 11 Nov 2024 21:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731361524; cv=none; b=dwyH6TddBklv+0uJwqVhNGtPYae8GMFZbPp0xo/QLhuzVGOO2v/bbH7o06X+keLVc1yDdneKz3CLItEb+N6qhesEU6kd3QgTfM2ps7R3fmw5pMq1J+7fqrjLY/n3MZi/EMl5zKb9I1SKOo9BET3IpVxjXMJ3o+Po+IphUNm+ATk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731361524; c=relaxed/simple;
	bh=IN0mx5tkOzE2sbUIYfvz1s2JAP5OxHYBZmDL0U+hK6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S/EYkfxRncWhUmiA7GusHw4WlQXIoGr+6ODDX8vGDX8fDJMIqTklkv9tKxSF4VYcWKyqcncyBM5QyUhu1fuaRKvoL2L6luN13XAcsJSJN3zcLOF8zDyeNGNz+jHSDnzUwNxU/ubx06ABaPN2l3mDYYeyT97KBWwsfYnYAZKIB7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h8UQZ32v; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=H4IhL7ef8M4jRxy6elb/fmBEsr0BSJTl3Q71YuLJznY=; b=h8UQZ32vbMeS7FkUglbJdLI4Y2
	Ygd9D+kMjw8Lw2xJbmR2j6DDxqbZBYBICrkgehWJQ3wDpXXe63ZiWJmqzRUhhfOpSObZ9fNhwtl7N
	QCQyqOFK4JQ0BZdeQ7glmUPxf3/5aapZbOh3dW4ILaclj+4gZLCvxLS8y7v1FG9aHUyupHdhIQiug
	AKMFBlar2kqC5VugKp5XIYJs5O07TQK1S0SeUbi66e+xI5WbAwltCOKR27VOjJ6eHX5Uk0m+a5Ggr
	x8SEv9t7+amA73+cW60w0jnSqCH0FnoCwPEqVg2xqdvfhtdjF7ViTdPAIxcd60y+QPQt5GdqOVgyz
	Bh3jSeSg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tAcDm-0000000DMsl-2rn6;
	Mon, 11 Nov 2024 21:45:18 +0000
Date: Mon, 11 Nov 2024 21:45:18 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Kemeng Shi <shikemeng@huaweicloud.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH RESEND V2 0/5] Fixes and cleanups to xarray
Message-ID: <ZzJ67sFmZ7btTDfB@casper.infradead.org>
References: <20241111215359.246937-1-shikemeng@huaweicloud.com>
 <20241111132816.3dcbb113241353e9a544adab@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111132816.3dcbb113241353e9a544adab@linux-foundation.org>

On Mon, Nov 11, 2024 at 01:28:16PM -0800, Andrew Morton wrote:
> On Tue, 12 Nov 2024 05:53:54 +0800 Kemeng Shi <shikemeng@huaweicloud.com> wrote:
> 
> > This series contains some random fixes and cleanups to xarray. Patch 1-3
> > are fixes and patch 4-5 are cleanups. More details can be found in
> > respective patches. 
> 
> As we're at -rc7 I'm looking to stash low-priority things away for
> consideration after 6.13-r1.
> 
> But I don't know if all of these are low-priority things.  Because you
> didn't tell me!

I don't think any of them fix any bugs that any code currently in the
kernel would stumble across.


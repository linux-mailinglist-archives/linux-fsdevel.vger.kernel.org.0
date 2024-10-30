Return-Path: <linux-fsdevel+bounces-33263-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 306D49B6996
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 17:51:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61B991C2121E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Oct 2024 16:51:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C85215027;
	Wed, 30 Oct 2024 16:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gFJd6M1e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805902144A4
	for <linux-fsdevel@vger.kernel.org>; Wed, 30 Oct 2024 16:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730307107; cv=none; b=EjjPgjh9ADDra9FNaDhuWDjiCylTyucqI9JQX8LZVD8F+rV0/TwSxDacDtO+hUe8ng2BK/FjuZPrHTS387gid7HN9AhbtK5fQXgNFwxE27yZygx7Bn3cdt8PPV210oDmk0ZZs2nKzNG+yUo0a1svQ2Ni3+m3JTvS6z9W59gtFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730307107; c=relaxed/simple;
	bh=JTiA6/qRW3WLF0eimxo3MWdx9PL9qzDer99J7YPuqv4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTQVOrb8GT7N5DMgQi0W+OFk2tK7tpk4MwjHpS77WT7dzWhbUbJkp9YRL8WvSq4JYmbMPRiWq81J1DojwbMtZBRPfM+NehvN4pU6IwmzcYMezTaTLZfSaUPDAWpnDeEw34OGptUEqSkQnQZFUpD+190JkgZsfpLjuvokH0tfeWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gFJd6M1e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=wf66xn5EFnuv8MBovFwBF0ybuprE3tuh7LZz4KQ0uWo=; b=gFJd6M1e8yrIx7xNTMhuzlAuNi
	UA+U5lXEGacTVF7RaAcHQ0m0bzKb78j1O1JyvD0vAaCa2dr/5Q/XqxgwhOF4R4SIA3rZUsE+k0gM4
	j+K3P0oNYO1L5HoJ+uNyJ1f1j8b6Pd1aksX8P3s7Brup1J8uZa8AyBDrLDsHY9pr1Xnr2l/wDRr/A
	rd6G3c/TAQOw+qP/Wvruxx/LXDnXeYEvEgKbz0lnIShI14RP5Ye/E+lFtmaXfVFYfYcBGX2BbQ/M1
	e3my/lU1K0gXzOPwq9ey2wvKKxQBkjzd6UUDr6RpSaYCZ8fsrcZYyh5gRB4Z0rUb1ftziqZuklFA1
	X+kNDucA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t6Bv3-0000000Di1t-08aV;
	Wed, 30 Oct 2024 16:51:41 +0000
Date: Wed, 30 Oct 2024 16:51:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org, Nicolin Chen <nicolinc@nvidia.com>
Subject: Re: xa_cmpxchg and XA_ZERO_ENTRY?
Message-ID: <ZyJkHHUSyVgO419i@casper.infradead.org>
References: <20241030131513.GF6956@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030131513.GF6956@nvidia.com>

On Wed, Oct 30, 2024 at 10:15:13AM -0300, Jason Gunthorpe wrote:
> Hi Matthew,
> 
> Nicolin pointed this out and I was wondering what is the right thing.
> 
> For instance this:
> 
> 	xa_init(&xa);
> 	ret = xa_reserve(&xa, 1, GFP_KERNEL);
> 	printk("xa_reserve() = %d\n", ret);
> 	old = xa_cmpxchg(&xa, 1, NULL, &xa, GFP_KERNEL);

You're really not supposed to be doing xa_cmpxchg() here.  Just use
xa_store().  That's the intended way to use these APIs.

> The general purpose of code like the above is to just validate that
> the xa has not been corrupted, that the index we are storing to has
> been reserved. Maybe we can't sleep or something.

Thr intent is to provide you with an array abstraction.  You don't
cmpxchg() pointers into an array, do you?  Almost everybody just does
array[i] = p.


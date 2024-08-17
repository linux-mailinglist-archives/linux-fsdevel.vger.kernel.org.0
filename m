Return-Path: <linux-fsdevel+bounces-26170-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBE2955568
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 06:42:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABC76B21E67
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2024 04:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468347F484;
	Sat, 17 Aug 2024 04:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="S9V9q2nU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0079A256E;
	Sat, 17 Aug 2024 04:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723869731; cv=none; b=ZvZPXzNjt17lGYGhlnerrnENp3rfBqc4f/Q4M23ma7wQQx1Q8zXjlsbafFI8BlJzqVPHccdF/78S9YUo6jCDK8ZFhfRROTbTqOg9M2Vq4Le7NDz3o/tXUcXY/nkd0CQldf3TWwFn46MhhFG3f1NyxCpgIjXAU48xZ1BT97EDdKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723869731; c=relaxed/simple;
	bh=vFY64edm1BcHX4YDEVinBTrm6FObW+fvril+0YEgHwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ih4l61kfd9IjRArb0CIqR7o5s3YwjFsFCI6l745GXWg9gpePS9nhTvYY6d7o66C+261YGel0RUlMU7GNXcWfY6BHqEKcVKkljsFnjCz0/pzTCp2mVsHR0Ku71lYNDfLXHUGTsD41K37WSmrF1eD+t19kVrCxrtPWTamZvGNrV2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=S9V9q2nU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=Oup3qYHSQVP+ZG1pvOCTbfEMPHIcQZK875pNVT/ruio=; b=S9V9q2nU6Bqg/NEVbnPBODW8Hm
	V96OyRndG/EcmH9r4sU19QIZNYk6i4VvCw1vaxOo+npkDNijrEnVpfUcu5+x1LKMhdRuoFA3Dyhpz
	xDTvBsiQsstySWnbNxHf0afy0tEYeMhv57ne+cOXLX5oua/Z/xHqgAp6l3taQuubOC7ta/lyHVfSJ
	7bA0dz6tF7ry7KzlHFYK7KCJctxq9VjuDfk2egB1DQi2ctTG0FmOG+dXo7b43G9uUg5OzLOoZxrSX
	gfelP6muIM3Lgr+/1WUMaIJt5oo+U1VHJDLnl/RVCZ+EdDZ0oQ6P7DQaDiY3NaupPyEPCW7NifPlj
	09EVlwuQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sfBGO-00000004RE9-0t3w;
	Sat, 17 Aug 2024 04:42:04 +0000
Date: Sat, 17 Aug 2024 05:42:03 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	jack@suse.cz, yi.zhang@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH v2 3/6] iomap: advance the ifs allocation if we have more
 than one blocks per folio
Message-ID: <ZsAqG-Q527PYWYrz@casper.infradead.org>
References: <20240812121159.3775074-1-yi.zhang@huaweicloud.com>
 <20240812121159.3775074-4-yi.zhang@huaweicloud.com>
 <ZrxBfKi_DpThYo94@infradead.org>
 <58d9c752-1b40-0af8-370c-cf03144c54c0@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58d9c752-1b40-0af8-370c-cf03144c54c0@huaweicloud.com>

On Sat, Aug 17, 2024 at 12:27:49PM +0800, Zhang Yi wrote:
> On 2024/8/14 13:32, Christoph Hellwig wrote:
> > On Mon, Aug 12, 2024 at 08:11:56PM +0800, Zhang Yi wrote:
> >> From: Zhang Yi <yi.zhang@huawei.com>
> >>
> >> Now we allocate ifs if i_blocks_per_folio is larger than one when
> >> writing back dirty folios in iomap_writepage_map(), so we don't attach
> >> an ifs after buffer write to an entire folio until it starts writing
> >> back, if we partial truncate that folio, iomap_invalidate_folio() can't
> >> clear counterpart block's dirty bit as expected. Fix this by advance the
> >> ifs allocation to __iomap_write_begin().
> > 
> > Wouldn't it make more sense to only allocate the ifѕ in
> > iomap_invalidate_folio when it actually is needed?
> > 
> 
> I forget to mention that truncate_inode_partial_folio() call
> folio_invalidate()->iomap_invalidate_folio() only when the folio has
> private, if the folio doesn't has ifs, the iomap_invalidate_folio()
> would nerver be called, hence allocate the ifs in
> iomap_invalidate_folio() is useless.
> 
> In my opinion, one solution is change to always call folio_invalidate()
> in truncate_inode_partial_folio(), all callbacks should handle the no
> private case. Another solution is add a magic (a fake ifs) to
> folio->private and then convert it to a real one in
> iomap_invalidate_folio(), any thoughts?

Why do we need iomap_invalidate_folio() to be called if there is no ifs?
Even today, all it does is call ifs_free() if we're freeing the entire
folio (which is done by truncate_cleanup_folio() and not by
truncate_inode_partial_folio().



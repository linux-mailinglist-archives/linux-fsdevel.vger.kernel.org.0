Return-Path: <linux-fsdevel+bounces-45149-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15E9BA7374D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 17:49:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 625CA189E460
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Mar 2025 16:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EFD218ADC;
	Thu, 27 Mar 2025 16:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tl0onh6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937B71A8F63;
	Thu, 27 Mar 2025 16:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743094060; cv=none; b=nh72MGgTZZ2Nr8HX67D/Ep7xbd6R2QCqPS//kFFK4uK3poAOgst3s4pex13rUudjkrFEy2gpqR7zNmO/rHYXM8EaT7Tx6bPLupyS9lsUWvO1r4Zzmioapuw/xwiJJeD0sX9S5Bz7T/eAXfGkzqCHZtEtvS+ErJdgMvdX/yLzL3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743094060; c=relaxed/simple;
	bh=JgH14iG3andhgqHRrs+bg7PX2q2s0jAbmlcscqauP6s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=klZPoaCti30yTBEEg7ULHjc3/BNRodO4M+2dtsnaEgbpAWVMYtmsSQ3iSU10arpl9Vzl146Dm/QhZ4ZyYQq5OPVz0Wp0Lb3SMj/1xlGYdV2Sfze28r8Ds0kipF7jFqcjY6PNaLCGbcac6LYrdM+6hOZjFJcJWkBixECiiC7yKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tl0onh6W; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dvAV0wly65GafapBd+R2SMsxMncVYb5i6gjsWKQaKNI=; b=tl0onh6Wl2wgEDZXShnhE3BNrz
	scEiHm6RfUyjZahK/94CnHkyZkT79gOz96BBsXwB/jTjPZBiRdKjST+/1IJYnmhi4jSmouWG0ASn0
	mTe1SpkqYzonGwJC6M7tYlSffd1DeFo8iCt7woF3QVtd9EZnutBMA6abbhVmREoaJFUYjptSflq34
	crw+wWoec3SWgTIIiXLOpHmag1fqJFe0/wUystIXf6qrDQJR3+vXCRUy1M8PVPSqT9OwIDezjy5NJ
	Ujnm0RN2YmgMHwC4zecpCDdy8Vs50lFou3artHEBik61A5C7phV5QWklx6TDEvXApPEFtKy47aDVT
	uSkE/yXw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1txqOG-0000000DRYG-0hdg;
	Thu, 27 Mar 2025 16:47:36 +0000
Date: Thu, 27 Mar 2025 16:47:35 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alistair Popple <apopple@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/6] Allow file-backed or shared device private pages
Message-ID: <Z-WBJ1vKL894M62J@casper.infradead.org>
References: <cover.24b48fced909fe1414e83b58aa468d4393dd06de.1742099301.git-series.apopple@nvidia.com>
 <Z9e7Vye7OHSbEEx_@infradead.org>
 <Z-NjI8DO6bvWphO3@casper.infradead.org>
 <jcrkl6my4u3tyjmaoibor4lwe2diox4moo4ap52eu4v3yxhnn3@mmahcrjxeiba>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jcrkl6my4u3tyjmaoibor4lwe2diox4moo4ap52eu4v3yxhnn3@mmahcrjxeiba>

On Thu, Mar 27, 2025 at 07:49:47AM -0700, Alistair Popple wrote:
> On Wed, Mar 26, 2025 at 02:14:59AM +0000, Matthew Wilcox wrote:
> > So, there's no need to put DEVICE_PRIVATE pages in the page cache.
> > Instead the GPU will take a copy of the page(s).  We agreed that there
> > will have to be some indication (probably a folio flag?) that the GPU has
> > or may have a copy of (some of) the folio so that it can be invalidated
> > if the page is removed due to truncation / eviction.
> >
> > Alistair, let me know if that's not what you think we agreed to ;-)
> 
> That all looks about right. I think the flag/indication is a good idea and is
> probably the best solution, but I will need to write the code to truely convince
> myself of that :-)

It might end up making more sense to make it a per-VMA flag or a
per-inode flag, but that's probably something you're in a better
position to determine than I am.


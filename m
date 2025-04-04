Return-Path: <linux-fsdevel+bounces-45764-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C52C6A7BE12
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 15:40:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1D11771DC
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Apr 2025 13:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D66EBE;
	Fri,  4 Apr 2025 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Dwd9ER4f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706A112DD95
	for <linux-fsdevel@vger.kernel.org>; Fri,  4 Apr 2025 13:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743774028; cv=none; b=eje9BYH0xKGrAgnwsKYkET1zEN/Rl+Ket6dT76osP+EARoJid0vADt6BmR6TTRnuI5OKbiCrpC0v/dIAaF7Pqd5/o0AuWwtGEHlcbtbRcuyz26YcSI7N0KyGNzChnIRouzjpTf+LJIchiBwE7Jz8eSerjdgpBTN1JE0nlWdAweo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743774028; c=relaxed/simple;
	bh=CTOkpnJ/2EEs+lEKivtZ1LCiWnQrUtuvUMW66Cls6AU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QBQYcUyNH0/gPPnX6egzxiusvxJu6Re9U+8LFL2/630pptoWX2m/pMUURMAoetV1dURtEWBh8CHYGUMjELN1xeMtGouE/kR0k80ZPzGfCku+BB3VRkPl3xIumSv2davXrrFEnKBXUB7gws2CKVI5wDxnh49ImdZDrx8ieOEdFIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Dwd9ER4f; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pImUKw3M0PMcHdkWuYJ7D8sB/fzB+idx0s4djWcXKZQ=; b=Dwd9ER4f9M//fOrC7g8V+L/B+J
	wh7pwfrTC+243uBCbeTuappR+0W/kdLGj4rQvO3Iq2eL00rYyvCzQ4hra5f0vDgWoc/ezq2TJDHtQ
	ts5X0W3naA/uWGIvQA5dI6M7HlMJfS+cwtSV8k4GJhP1DzS1D1ekIss18q2w/i5OjepMZXcyvQ1Gq
	SNZucgzw+6AcKP23JEOQGgmxpPXHjBJOdnXbp8mocTBIlzsUzrakuoK0l5ghv2xfioCG7/mIiKD1M
	is3sFX1TIj63rFoHvSew0p8JWNvt32zBLfmy+NvPRi5iSqIi1HbZExLb9aoeuaf7rujMHNefCyY/5
	WZonuwjw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0hHP-0000000FZyo-3NRd;
	Fri, 04 Apr 2025 13:40:19 +0000
Date: Fri, 4 Apr 2025 14:40:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: linux-fsdevel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
	linux-mm@kvack.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 6/9] i915: Use writeback_iter()
Message-ID: <Z-_hQwNeiOnNYJVp@casper.infradead.org>
References: <20250402150005.2309458-1-willy@infradead.org>
 <20250402150005.2309458-7-willy@infradead.org>
 <Z--XtaM7Z3zbjzAu@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z--XtaM7Z3zbjzAu@infradead.org>

On Fri, Apr 04, 2025 at 01:26:29AM -0700, Christoph Hellwig wrote:
> On Wed, Apr 02, 2025 at 04:00:00PM +0100, Matthew Wilcox (Oracle) wrote:
> > Convert from an inefficient loop to the standard writeback iterator.
> 
> Not for this patch but a follow on:  we really need to improve the
> abstraction for using shmem for driver a bit.  Drivers implementing
> their own writeback_iter based loop is a bad idea.   Instead the
> code here in __shmem_writeback and the similar version in ttm need to
> be consolidated into a nicely abstracted highlevel API in shmem.c.
> 
> Similarly for the mess these drivers cause by calling into the
> write_begin and write_end aops.

Yes, I agree, we need an API for "I want to use some pagable memory"
that's almost certainly built on shmem but doesn't expose nearly as much
of the innards of shmem as this does.  I've been vaguely thinking about
what that might look like ever since Darrick came up with xfile for xfs
online scrub.  The GPUs have similar requirements, so that's three users.

I don't have anything concrete to talk about yet.


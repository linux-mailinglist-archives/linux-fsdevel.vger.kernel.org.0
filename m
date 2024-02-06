Return-Path: <linux-fsdevel+bounces-10535-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F4584C0C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Feb 2024 00:19:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D28B92868D5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Feb 2024 23:19:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E4661CAB3;
	Tue,  6 Feb 2024 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="V3imUbc9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9CA1CD32;
	Tue,  6 Feb 2024 23:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707261549; cv=none; b=Xeu2uCD/BmgX9ZNFcd1AEN4n7KMyAS4aHuPjgUA8VyJnMkOppXHSYYzBNDLOJsXuIgb2v+Pv11fhgb65FX/dgAIMWkk7D8zxncc/aueZGHCTSpc2QIS9iBR2WxXjXvi+xkWl+oi5XLj0at27Cr1VfjHV0bCdW7B2UHqkQ6eG3vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707261549; c=relaxed/simple;
	bh=gvlx9I94wOd50YscJj/a7/Sa/udNt8J7rgpAq6RBAUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z4U9x/hXzs9S1RaCUCnpl4Da4tgaBKj5pbRBnT6VDTV0lWclV00JHblzggb/NOUBiaDyr7sPif8kzUsfBysVXVQVQDZKqxSuAk3Xoyp9y8WB9zeSvtB7u1P8ttjBWY5uhS6Ld8WqoMSLNvEvF1leuxDqRun6vBugO5kYTkPZYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=V3imUbc9; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YnBJkpuBoqzeKQSfi3Ju9Ni6rq1pZ0BC60FbPS8wc5o=; b=V3imUbc9ptSdR1OGzam6nKjdiJ
	OyV0r349xrtsKkfi/bvCvYLawM9Z/6Tx5up5+foBSS3yzqYPK8fSFBIEVrsfby9mNjJZGEqGXVGIy
	kD+MjK2IZZgy43TNQctzke2PKOOtlRpvtMGzUhPJc04eL0ox+As4GViiykEPpqjGecHMJontQh+ks
	IsQBTOFn6k55+4eX4BC/MxdzlH7LTfOE+4N0c9Do1nVPZwf8K089r1Tp4HuigdH4mpOCelgnX1k3B
	P9txNFiiqSCl9j7HkX6+9fLq7up/8JhqGRNPxQY17uD06kE4EJEmG7jfKER3htGK7PoEJ8TW92KzI
	57xCNMrw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rXUiJ-0000000DXtL-1MP3;
	Tue, 06 Feb 2024 23:18:51 +0000
Date: Tue, 6 Feb 2024 23:18:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>, CIFS <linux-cifs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	"R. Diez" <rdiez-2006@rd10.de>
Subject: Re: [PATCH] fix netfs/folios regression
Message-ID: <ZcK-W54WoNQswKfg@casper.infradead.org>
References: <CAH2r5msJQGww+MAJLpA9qNw_jDt9ymiHO+bcpTkGMJpJdVc=gA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msJQGww+MAJLpA9qNw_jDt9ymiHO+bcpTkGMJpJdVc=gA@mail.gmail.com>

On Tue, Feb 06, 2024 at 05:14:42PM -0600, Steve French wrote:
> The code in question is a little hard to follow, and may eventually
> get rewritten by later folio/netfs patches from David Howells but the
> problem is in
> cifs_write_back_from_locked_folio() and cifs_writepages_region() where
> after the write (of maximum write size) completes, the next write
> skips to the beginning of the next page (leaving the tail end of the
> previous page unwritten).  This is not an issue with typical servers
> and typical wsize values because those will almost always be a
> multiple of 4096, but in the bug report the server in question was old
> and had sent a value for maximum write size that was not a multiple of
> 4096.
> 
> This can be a temporary fix, that can be removed as netfs/folios
> implementation improves here - but in the short term the easiest way
> to fix this seems to be to round the negotiated maximum_write_size
> down if not a multiple of 4096, to be a multiple of 4096 (this can be
> removed in the future when the folios code is found which caused
> this), and also warn the user if they pick a wsize that is not
> recommended, not a multiple of 4096.

Seems like a sensible stopgap, but probably the patch should use
PAGE_SIZE rather than plain 4096 (what about
Alpha/Sparc/powerpc-64k/arm64-{16,64}k?)

Also, what if the server says its max-write-size is 2048 bytes?
Also, does the code work well if the max-write-size is, say, 20480
bytes?  (ie an odd multiple of PAGE_SIZE is fine; it doesn't need to be
a power-of-two?)



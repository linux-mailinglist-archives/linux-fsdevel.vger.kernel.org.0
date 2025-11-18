Return-Path: <linux-fsdevel+bounces-69012-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D854DC6B6E0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 20:27:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0791A4E592A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 19:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD90F21FF25;
	Tue, 18 Nov 2025 19:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qwcNFOvW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9957B29B79B
	for <linux-fsdevel@vger.kernel.org>; Tue, 18 Nov 2025 19:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763493998; cv=none; b=GwNgeM1dOqYOMcx5KkB816osp7q2B9/Dc6ChDuA4gNg7hpsiN2VU80QfIw6CwacBagWdx6bdSSYaU5Z6NuAk2jBHFcHfRdoHifnRBOhOZJ3JWF0gwn5pihNBNo+pdMQPFYzKfNuCNOuXO2Me8bPIJC/B66uwkno+2KKfJM3VuvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763493998; c=relaxed/simple;
	bh=8Zh018+JfWGGN7WmmFyW5I27OPtvOIrO1IotG4AR8Kc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0+8LvWuBKOKQl6WWpgOXngOOMCO6YEvrFodwysEGTVw1tQZ3H3u+RzS2aK/NtkYmxVE3W2dAQfR0IDE+mVD+RcWbF/eAP8xXLbl/QFRFd9mQaCw2kXruZgZBaK2GkJGso/9h/MLwyBKF59dlpgDadHK6xG6SxLYBsU8KVqZer4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=qwcNFOvW; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=X9xVnHIu33sybaiX5x6xV0FFb6i6VuMcytBKwAWeLXE=; b=qwcNFOvWZP14uQc4ADKS9kYAnL
	grovn7lHqrelDiWAh08OIzBrxpPTLXYMH+uvDkjbAqzMoQjQlKXTIUwClJXSBhbU3y3uy3fyURa2p
	cjZ8Ybp1yQsZC5LNGn6P2IuYeTNQTGJUegI1KU3aoKh7qpC+1bBK4ZONLwjNGH6P/1DMxKI4ujzXW
	msEJ51053kincWsIeXDYi3qe1ahpVkKqWPvQ+Q4CgT0oCEC9EjZVHF9ls+VlSuRvfucugKjoPMNII
	tVPVSh8ph3cooSzlck2T+w3Di7lAldtepzxEQtFs0u0HE/jbkekDVCMt3ZyEQJneEDIEK8o+6x7RQ
	GJxe9Egg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLRLT-0000000Fx8v-0QoZ;
	Tue, 18 Nov 2025 19:26:31 +0000
Date: Tue, 18 Nov 2025 19:26:30 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] iomap: fix iomap_read_end() for already uptodate folios
Message-ID: <aRzIZu5e-OaspAWU@casper.infradead.org>
References: <20251118004421.3500340-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118004421.3500340-1-joannelkoong@gmail.com>

On Mon, Nov 17, 2025 at 04:44:21PM -0800, Joanne Koong wrote:
> There are some cases where when iomap_read_end() is called, the folio
> may already have been marked uptodate. For example, if the iomap block
> needed zeroing, then the folio may have been marked uptodate after the
> zeroing.
> 
> iomap_read_end() should unlock the folio instead of calling
> folio_end_read(), which is how these cases were handled prior to commit
> f8eaf79406fe ("iomap: simplify ->read_folio_range() error handling for
> reads"). Calling folio_end_read() on an uptodate folio leads to buggy
> behavior where marking an already uptodate folio as uptodate will XOR it
> to be marked nonuptodate.
> 
> Fixes: f8eaf79406fe ("iomap: simplify ->read_folio_range() error handling for reads")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> Reported-by: Matthew Wilcox <willy@infradead.org>

Tested-by: Matthew Wilcox (Oracle) <willy@infradead.org>

At least, it gets past generic/008.  I'll let the xfstests run continue;
no news is good news.


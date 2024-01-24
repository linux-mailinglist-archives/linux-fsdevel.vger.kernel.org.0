Return-Path: <linux-fsdevel+bounces-8676-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89F7583A14D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 06:23:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6877D1C27556
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jan 2024 05:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E20DF4C;
	Wed, 24 Jan 2024 05:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="tdn27Bst"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F50C155;
	Wed, 24 Jan 2024 05:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073787; cv=none; b=ocErnDGEbvSvtBrrOI2gXLwSyLss6fGkfm8R5RX5XAWF2wfdK4rnMqJ+fBQvrvpIHRfWNeosPERfJRlhTMYMg2HV+CA/SnedUJInj2q2f6gZyl70l8x7mESniyKWdmt8L67+dEg+ig0YlVFEq/WqjnO0uJEDMIjvGil2lYwHnm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073787; c=relaxed/simple;
	bh=jQx0lSae/Lj+SkjPymWnR7sZBxhmpWM8gpeFP3015gA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thfHSsZGyy4lPTRDHCO8WpLlEZXvNzzifJRJXfRs6LgUmVqYdMQpv/Arjreql7VxyFg/UVBaGncpN6+WbTXzhPDnosXm9ga5zKKaqdtJXM/LbM4isMY0TjUGuRwSvCKRdrjoHlMG8C1StGqZyorhHgNNH52le1AjSLonpC2uKSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=tdn27Bst; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IC2rQKZKRuILecS4UlS6kLIjnzL5Ko59oG9QGmKf5cg=; b=tdn27Bst41HCFnlxO1Qsj9ewDy
	rTyOar2y1KrRky9/SewScRkND2Hkr0cEY0gQrW/9Tg9JWJXlWqI13YTwDBtHsxCll9MsYOmyH7GlU
	FLPuYkNEEzhZpXLyexpcKlsXSk33CYrFVjiEQYjdAitc6ZqJHhIbGZTB/1ERGFI2eZnC3Lapqr16I
	Zoe+1iEX1ssHJYqbWDrtsdleLliiNzv841t/cGgPleDzf+ZZq8GK6V/I8UdLYhthawUFwLdwJsA5u
	yYgF9YcT4BBZKPNR0opi1sJGGejDzByp+PfbwEb+lr3OXjU8fSKyCS+1dlydgJzZh6dG+dvFnKkLu
	gi9JSJfg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rSVj5-00000005V4O-1eSt;
	Wed, 24 Jan 2024 05:23:03 +0000
Date: Wed, 24 Jan 2024 05:23:03 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Wedson Almeida Filho <wedsonaf@gmail.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Wedson Almeida Filho <walmeida@microsoft.com>
Subject: Re: [RFC PATCH 19/19] tarfs: introduce tar fs
Message-ID: <ZbCetzTxkq8o7O52@casper.infradead.org>
References: <20231018122518.128049-1-wedsonaf@gmail.com>
 <20231018122518.128049-20-wedsonaf@gmail.com>
 <ZbCap4F41vKC1PcE@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbCap4F41vKC1PcE@casper.infradead.org>

On Wed, Jan 24, 2024 at 05:05:43AM +0000, Matthew Wilcox wrote:
> On Wed, Oct 18, 2023 at 09:25:18AM -0300, Wedson Almeida Filho wrote:
> > +config TARFS_FS
> > +	tristate "TAR file system support"
> > +	depends on RUST && BLOCK
> > +	select BUFFER_HEAD
> 
> I didn't spot anywhere in this that actually uses buffer_heads.  Why
> did you add this select?

Oh, never mind.  I found bread().

I'm not thrilled that you're adding buffer_head wrappers.  We're trying
to move away from buffer_heads.  Any chance you could use the page cache
directly to read your superblock?


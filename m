Return-Path: <linux-fsdevel+bounces-20046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0AA8CD180
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 13:48:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0241B227E2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 May 2024 11:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417B913C3D3;
	Thu, 23 May 2024 11:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="j/5fWtXe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38E7513BC38
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 May 2024 11:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716464893; cv=none; b=U/F7hvbH+xxZ8kfa4rl9k4VxAoLw+rMusUiuoOT19rXWnXZbyimk3EZseSFBC8Yyf2WMcrrI96c/6PkRtk6XpbjKtUg1htBN6h8hkYxBm52UOA91xBS+3z3PzqOcXd3R5xL/yBf3aqx1khF9TsFAkUqUefyejHGf7arAgO4Fsio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716464893; c=relaxed/simple;
	bh=qycRuNwGHeEsmARlQ/6iYpQYLTsLlI94i7aTFwLO3Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NU9iu+N5ktdg984urnKrji+ZEh6d/pYlR8b24Ea2rWS/tZEXAQKVcRZhSkZkJmMFpzu/IHdVxU8jcXm7I5txrzMqxYSfiGeMxbmAw9OcfvapkGl0kepexBUfubCmlCOM0zk20wT8GM7PE7UQxHwf/CEv0pm1THPk42JGfCqjDQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=j/5fWtXe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=TScsiFfScnqdo2erlTSn8uZZ0NMykOHc6USF599vDtA=; b=j/5fWtXegqjj7cmNj+t7fyxSjs
	S/h3LMFn+1sAQ6WnwOeB00EpOYs3G8i1HkENSPpVmKd6OeNTO/hrdVVo/KnThcb6ZFhCdRSyJB561
	F2KqrhvJxZjM/Vd1oj+IFNB8YbH4iQZ1QBFStAMH8Sod+gmUxbIK57hEvAlICgu+kT89ljNqXBMi7
	hRp18DXUSDeVrMJeC7qROGVBjlYWZC40UDOweMQDVFCQiV1dBdMUg0bE7XBCjyGMUofFAw+PBfAPY
	G7vOmIqLjwbW6BjuQ/XW++HMXYYbaLiWzSGnS0G34LXUN4eZ7OvmiVVvfwx9jR6wNPlusxllTX0kO
	1s768F2Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sA6vZ-00000001iaQ-3EEE;
	Thu, 23 May 2024 11:48:09 +0000
Date: Thu, 23 May 2024 12:48:09 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Cc: Johannes Thumshirn <jth@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: move super block reading from page to folio
Message-ID: <Zk8s-ZnFQuKTjY2R@casper.infradead.org>
References: <20240514152208.26935-1-jth@kernel.org>
 <Zk6e30EMxz_8LbW6@casper.infradead.org>
 <7839c762-3e2e-4124-a42f-6c15f3d8fea4@wdc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7839c762-3e2e-4124-a42f-6c15f3d8fea4@wdc.com>

On Thu, May 23, 2024 at 09:54:00AM +0000, Johannes Thumshirn wrote:
> On 23.05.24 03:42, Matthew Wilcox wrote:
> > I think the right way to handle this is to call read_mapping_folio().
> > That will allocate a folio in the page cache for you (obeying the
> > minimum folio size).  Then you can examine the contents.  It should
> > actually remove code from zonefs.  Don't forget to call folio_put()
> > when you're done with it (either at unmount or at the end of mount if
> > you copy what you need elsewhere).
> 
> Hmm but read mapping folio needs an inode for the address_space. Or does 
> the block device inode work here?

Sorry, yes, should have been explicit.  Read it using the bdev's
address_space.


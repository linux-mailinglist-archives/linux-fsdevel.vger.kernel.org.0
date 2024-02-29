Return-Path: <linux-fsdevel+bounces-13155-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D681386BFDD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 05:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139F11C208BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Feb 2024 04:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C67FF383A0;
	Thu, 29 Feb 2024 04:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ejXvpRYL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93CB381DD
	for <linux-fsdevel@vger.kernel.org>; Thu, 29 Feb 2024 04:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709180706; cv=none; b=S+WOgvfMsyxD8k+EQdksd3DG/bzqMtQ1TCZRY4yfAG3nHMutGDQ/KZU97tm64pmWld2D/jnUbMHdFTIhKlkfF8/JlXxUUB2K41kaQ+32Tkn8SUerTPHtmPki6kRRBf7sQ6DkL8BCgRvp5hZkqza/gNskyznSWJvRzaGX9FYZ9jA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709180706; c=relaxed/simple;
	bh=dqh/Zj/Bwafufyk239grQSxN6qohG/Y01zJSmvFu/PI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nToupBrrePTJhQ4EvLDU7Vl135ejxasCvK2hI2nPdFsesMvHyBgG1v+PozbrzQWL5n3Q3rr7B626Vd+rYJnj5FG6BuxWDcwsMH3+AqV+/dxsUwseSCJfT8nPEL7E+gZ5VOhAl0641XR58xI64ulkogpB2B/fFGpfIwgRXzXr1YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ejXvpRYL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XdMVEny4sr6JhGo7rcXmYe6O/S0A3nl7l5flUazKF3g=; b=ejXvpRYL6ap88aPfnaxRDIW9pT
	7mH4GqMSa9FsPodAs7LU18/Auk8EE6rI9GKAMwPHvQUfzzq+UMRRu+/EM2i2A/JYsOeX6trcXyELm
	QuA8+9uhotaBNU7cmAG/vq2HXRUDtc/tck2Z+HxaA4+ufQTXpyQ4nuRA6yvhUOTY1txpM8DM1ODeW
	tZN6anWKoOA4YGx+nxqhzrFIg6J3T8heJj2MWzYeylMS35kWohXkV1513fI2snAmVnkgdyERJeOHq
	UzANkyM5siAOsWk9XVDScZsRVi50oNa/hsyBtWtHFmFDQAnDHYNyF10tuRgc6ieQ7i7BBih8+m3eI
	yqx7MkPw==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rfXyW-000000075HY-3ENI;
	Thu, 29 Feb 2024 04:24:52 +0000
Date: Thu, 29 Feb 2024 04:24:52 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Amir Goldstein <amir73il@gmail.com>, paulmck@kernel.org,
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] Reclamation interactions with RCU
Message-ID: <ZeAHFL3dOFrxA586@casper.infradead.org>
References: <c6321dd1-ec0e-4fed-87cc-50d297d2be30@paulmck-laptop>
 <CAOQ4uxhiOizDDDJZ+hth4KDvUAYSyM6FRr_uqErAvzQ-=2VydQ@mail.gmail.com>
 <Zd-LljY351NCrrCP@casper.infradead.org>
 <sd7cximu7qzguhtstpc4xhgwwvfjg3zttwhy7oz7gzrgrmov6t@gjy2wplad6vy>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <sd7cximu7qzguhtstpc4xhgwwvfjg3zttwhy7oz7gzrgrmov6t@gjy2wplad6vy>

On Wed, Feb 28, 2024 at 11:17:33PM -0500, Kent Overstreet wrote:
> On Wed, Feb 28, 2024 at 07:37:58PM +0000, Matthew Wilcox wrote:
> > Perhaps broaden this slightly.  On the THP Cabal call we just had a
> > conversation about the requirements on filesystems in the writeback
> > path.  We currently tell filesystem authors that the entire writeback
> > path must avoid allocating memory in order to prevent deadlock (or use
> > GFP_MEMALLOC).  Is this appropriate?  It's a lot of work to assure that
> > writing pagecache back will not allocate memory in, eg, the network stack,
> > the device driver, and any other layers the write must traverse.
> 
> Why would you not simply mark the writeback path with
> memalloc_nofs_save()?

It's not about preventing recursion, it's about guaranteeing forward
progres.  If you can't allocate a bio, you can't clean memory.


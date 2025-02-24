Return-Path: <linux-fsdevel+bounces-42493-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F35A3A42D86
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 21:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 592447A63D3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 24 Feb 2025 20:18:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EDC20AF64;
	Mon, 24 Feb 2025 20:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SKOMu40R"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49AD12571BA;
	Mon, 24 Feb 2025 20:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740428362; cv=none; b=uEE4YnQhWe/tN5r/2SG2OoutAfzfeLkmHCOLZOVb8INarnwpl/MmEQmjK2rwdV3kGoW/NTWu6GVQG64rdsBcK2thdgegC24GNE6tcxLfVxYMqh22CLzuKkkBem5Ksb0vKKUeeUTshC62KLrVV2fNkBlZAn2X76SNQ9fJHd307uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740428362; c=relaxed/simple;
	bh=aAt/J81SDJ2rgJ8jFskO6YLvnUwFzGp7cb3fHr0+46U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rtiOOxqbJQbc2qXEe/Yo64G4noS0ojfEjXjr1N5/ynFM0aMg4YPAOtuUS46a5dbX50d/aDfMRB2boX81YD78YFrPbvUurnjDBhAdIH/9DrKC3yokNVR+L6HpKDip/v6olQZ1L4BX1AArduAKuB0h777F7f3wByvoTu2j1d20Yu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SKOMu40R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/9trubYIlFPSCx7jCHi0mDRSjfKmMjsgJyileh2XZUI=; b=SKOMu40RhrnYyZ1N+9erb5P3Tq
	FTM8jC2WfFZ0Us8MtQdciE2X6bn+vZ6DYgtV8djOaizF5as3Nyh/aagtariVNDNLcivZdoCXIw3qG
	C+HHCdr+RoiuOUuxcfDKmek90hWBEich1Xt3C/xsLTMuGxNEJwusDRiz7XyEpSP+5pFTqSf1ZH10l
	5YR885bJHfg0caJqp+fwb/E8piyQyiRKktddQcmsKlR+2jmFPq60ZXfUvwxC3BYs8JF/0YP6ZvdfY
	Iq1Ln6J1XxjFLaZ3paK5if3XNRZHTyNWGO0YbUZ3Pr+7ZgXKam6WDDssKDQS1o78QWKRJczJdIFXH
	UIxe705Q==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tmev6-00000008TWH-45FQ;
	Mon, 24 Feb 2025 20:19:17 +0000
Date: Mon, 24 Feb 2025 20:19:16 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v3 10/9] fs: Remove page_mkwrite_check_truncate()
Message-ID: <Z7zURN93vqUfZj1T@casper.infradead.org>
References: <20250217185119.430193-1-willy@infradead.org>
 <20250221204421.3590340-1-willy@infradead.org>
 <Z7jl9cIZ2gka0QP6@casper.infradead.org>
 <5c1ed8a12c92c143e234a59739af3663e9898ec1.camel@ibm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5c1ed8a12c92c143e234a59739af3663e9898ec1.camel@ibm.com>

On Mon, Feb 24, 2025 at 08:11:20PM +0000, Viacheslav Dubeyko wrote:
> On Fri, 2025-02-21 at 20:45 +0000, Matthew Wilcox wrote:
> > On Fri, Feb 21, 2025 at 08:44:19PM +0000, Matthew Wilcox (Oracle) wrote:
> > > All callers of this function have now been converted to use
> > > folio_mkwrite_check_truncate().
> > 
> > Ceph was the last user of this function, and as part of the effort to
> > remove all uses of page->index during the next merge window, I'd like it
> > if this patch can go along with the ceph patches.
> 
> Is it patch series? I can see only this email. And [PATCH v3 10/9] looks
> strange.
> Is it 10th patch from series of 9th? :) I would like to follow the complete
> change. :)

It's a late addition to the 9-patch series I sent a few days earlier.
It's unusual, but not unprecedented.

I set the Reply-to properly, so mutt threads it together with the other
messages in the thread.  Lore too:
https://lore.kernel.org/linux-fsdevel/5c1ed8a12c92c143e234a59739af3663e9898ec1.camel@ibm.com/

Does IBM still make you use Lotus Notes?  ;-)


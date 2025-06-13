Return-Path: <linux-fsdevel+bounces-51613-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 405BDAD95CC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 21:51:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D844189EBF1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jun 2025 19:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D484244677;
	Fri, 13 Jun 2025 19:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="SVRsiFsy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFD31993B9;
	Fri, 13 Jun 2025 19:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749844271; cv=none; b=DEFXxK0+sSokuxSypahY7zpuY1hXtRe4483yTC4E3vxuoIUHkOXPjtfoyvm6rV6mEbDdTnHH1BZHt2LguEsjZtobyVz1JsT9eS+cQDsQMrvQ92X5FC1KlAMEuxdWm9ljvy7wGd5iHnaC9kjlzFN7pI82pdWf1negVHPTegL9ir8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749844271; c=relaxed/simple;
	bh=ySUhENbCn6/8LQPsYQ6zFHYKuMVfyA+Sh17OlvPtq+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P5bYG9jVeX9nnz/HwlQUH1iyVPW9+qKJ0iszRZ85xQ0MUPfEab60AxNhRPMQStB9MoVeTSmHIVPAfjcp/6dQmEKJR7Z5u839yUNGF3q9lmPx/fOAzr7ACxXlGMOYc57VpYHNpHN3svBGGqvtZns/PHvMeyDlNjEgjcvqw6nrrTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=SVRsiFsy; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=jXPVzY9vkuIS0lyvuKdeAbmogAFV4IaKWtXKsWkuT4Q=; b=SVRsiFsya3SZD1fO5Irkdnj79I
	aJG4/hs4mUuZ8qoS+YZ+3yEBnonuWJKsU9YM6P3o08porihvHoZ8lnCeFq9/VuVuKdVB2XXfPzKEe
	PLregmJ1fZV/U914jiXBsfMtd6OczTx5Tp7JvuDTAKYinL3EJ8HnbDWOE3uKYJF3kOQ6dfc9A/LJf
	ltjfT12//9LBaXnsYJUCAPgQYmFbfpUsIXBYv2TIm0iwcD+TKS6qlnVaRGCHBRJ2LoKaHgsSvp8ua
	NPHrVZ0g+btvRSVvLMcXfxcYd/vNCNcOZddv1L4S9PFAdjS+RR4MRYH3mXRBkO7goVEEBkWReaPew
	w+kzNNhg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uQAQc-0000000DK8x-23OI;
	Fri, 13 Jun 2025 19:51:06 +0000
Date: Fri, 13 Jun 2025 20:51:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	Ira Weiny <ira.weiny@intel.com>, linux-block@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Remove zero_user()
Message-ID: <aEyBKksbj0DebCOw@casper.infradead.org>
References: <20250612143443.2848197-1-willy@infradead.org>
 <20250613052432.GA8802@lst.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613052432.GA8802@lst.de>

On Fri, Jun 13, 2025 at 07:24:32AM +0200, Christoph Hellwig wrote:
> On Thu, Jun 12, 2025 at 03:34:36PM +0100, Matthew Wilcox (Oracle) wrote:
> > The zero_user() API is almost unused these days.  Finish the job of
> > removing it.
> 
> Both the block layer users really should use bvec based helpers.
> I was planning to get to that this merge window.  Can we queue up
> just the other two removals for and remove zero_user after -rc1
> to reduce conflicts?

If I'd known you were doing that, I wouldn't've bothered.  However,
Andrew's taken the patches now, so I'm inclined to leave them in.
No matter which tree it gets merged through, this is a relatively easy
conflict to resolve (ie just take your version).  I have some more
patches which build on the removal of zero_user() so it'd be nice to
not hold them up.


Return-Path: <linux-fsdevel+bounces-15369-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5058E88D18E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 23:51:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AFE2328724
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Mar 2024 22:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71B113DDC3;
	Tue, 26 Mar 2024 22:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="C+6j3WRo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 559C273189;
	Tue, 26 Mar 2024 22:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711493456; cv=none; b=RDcr9+sIf8KthCGhGYFf94NJvjeIj0HEuSOj/467z7Z8UGVu5ZKYAdulXrLYoiyjkcUMgIUp+YEmnXrYRmZGDBX9RhRxpD6dKows7P8ho2Hba0SeVG0fEEh9h4/BahI8Ca41vAmvPL/8cvPv/veSJdF/BOP77z+8glagipjJMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711493456; c=relaxed/simple;
	bh=2NpW39e1yc+jqyCmqsSEeRIUVXVG2Imo9WLoAIyvRs8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l6wb+GUnunjfuPQNXefuQEGSfozbk39c8ALTiYl8bISe2NPyOahtmLlRBRyuvGUjCU+wXOXobbjEL22j2d7U7d78Rs2RbfEmdsiC5Xd/TpwteffqKE1SQjXReVlxkrsp+zdNOUyTYviHL02WSACkxkPNb2A27YGqEZALmZHcgEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=C+6j3WRo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1BmDLCjcFU+KK+3miiP8pR8s3wJrwUpZyPZ3mSRVfH8=; b=C+6j3WRotzsiFGicvbn5F7y7/r
	Pn1CSBfv83JhvbhVpJ2yQQJH38fVLklm1Mx3yhOjNVNYYBoJUh/32kdOIoxMIXdRlOGoWNBx4C0oP
	eOWFJW3sm70s0Bmnp3Zvp1nacEl97t8akUM+nJAQQX0jGDzzksa6xRYSwPq8rA2DuJCzxSm51uoFr
	jqMeEmaEnTp+kPvdC+4Sc/uk6lCGvOB2AGOVFSkiv6367PYZI6JaRbKgPDKez0mIRMFgb38D6kvjF
	CFabzsBTz3CtvM0zPSC7VvOw6ep0Lljng5lmT7SnHhuHqrwz+uwsoEMzA/8865GDpCxw2OoWVhc/I
	66l7tF8g==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpFd5-00000002STT-0Ja0;
	Tue, 26 Mar 2024 22:50:51 +0000
Date: Tue, 26 Mar 2024 22:50:50 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Soma Nakata <soma.nakata01@gmail.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/filemap: set folio->mapping to NULL before xas_store()
Message-ID: <ZgNRSvcohDoLj3G2@casper.infradead.org>
References: <20240322210455.3738-1-soma.nakata01@gmail.com>
 <20240326140533.a0d0041371e21540dd934722@linux-foundation.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326140533.a0d0041371e21540dd934722@linux-foundation.org>

On Tue, Mar 26, 2024 at 02:05:33PM -0700, Andrew Morton wrote:
> On Sat, 23 Mar 2024 06:04:54 +0900 Soma Nakata <soma.nakata01@gmail.com> wrote:
> > Functions such as __filemap_get_folio() check the truncation of
> > folios based on the mapping field. Therefore setting this field to NULL
> > earlier prevents unnecessary operations on already removed folios.
> > 
> > ...
> >
> > --- a/mm/filemap.c
> > +++ b/mm/filemap.c
> > @@ -139,11 +139,12 @@ static void page_cache_delete(struct address_space *mapping,
> >  
> >  	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
> >  
> > +	folio->mapping = NULL;
> > +	/* Leave page->index set: truncation lookup relies upon it */
> > +
> >  	xas_store(&xas, shadow);
> >  	xas_init_marks(&xas);
> >  
> > -	folio->mapping = NULL;
> > -	/* Leave page->index set: truncation lookup relies upon it */
> >  	mapping->nrpages -= nr;
> >  }
> 
> Seems at least harmless, but I wonder if it can really make any
> difference.  Don't readers of folio->mapping lock the folio first?

I can't think of anywhere that doesn't ... most of the places that check
folio->mapping have "goto unlock" as the very next line.  I don't think
this patch accomplishes anything.


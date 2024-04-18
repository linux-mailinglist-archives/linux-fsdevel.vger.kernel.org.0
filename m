Return-Path: <linux-fsdevel+bounces-17247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC1788A99C2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 14:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA2C81C211FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Apr 2024 12:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFA9B15F3FD;
	Thu, 18 Apr 2024 12:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kHHApuO7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F7C15E5C9
	for <linux-fsdevel@vger.kernel.org>; Thu, 18 Apr 2024 12:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713443364; cv=none; b=TSVwuZtzv7RlzZVSyNBlDl5rPODTuKZGTEQeZ9lsLmqKYexdTrf8GAf3QSP7Ijs2c8HgljSqgibN1uf8Nmq4vJXJzaIJhtcIefgIsCqs93jAY51I0pWN91HLQqT33lfDxMJ8paOYlatEHV03fR21IQHTA3VSxldOFRjkmCG+Riw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713443364; c=relaxed/simple;
	bh=KtRFewgfbge/O558mcHuWvIsoIw0nhMBGD5T/VKTF70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nBlg6/1aBE/qT+YSgRJCMrN9b94vF8cNZJiCxN3qL52BC8jfuGL69fXdOw3eizPdjJem07HSS9hB/7aeSjHicEq+JAbWSQXovSDjkOxNXNrvIvAquTRWMaFnr2EUqYKtDSXzIJgewqmSFHbOZzHECFAE1lCSErZigZYny5pxyOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kHHApuO7; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=/wFIhnjJhJDz2XaJlVXjkua+BdTLzA1cQyS4dEsMshk=; b=kHHApuO7eEPGP+ZSfWk4ZdGnRy
	oNYsk4QjMqpjOOa+STkSsI02RhxmhcrfRcxO/hJHCg0Icu6qVSO7tuEwbA0GvxFWG/MaE5K9IEK8/
	jwS7WTG3/UsF3f6llO04Q9frIOFP+gtMH5b/NYJRl+RTqaXjhAJIcZ6+WkGoTl/K4SyryJO8fTGzu
	ZFSB2zZMtshcb+qeFPP1cVWVRqtEUGeA3KoGmVB4lzj9urEOLgeuQMy5Fbe/uc5sC5jgjLQPOdY5s
	iZiZqXvvbrv7fztmJDWdQzYe0+hSvtubA5RdjI4FU9UKGMElintIxwD/TxsY/h4snyCUVc1mBl6Xq
	qy2/bTyQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rxQtE-00000005JZm-0VOz;
	Thu, 18 Apr 2024 12:29:20 +0000
Date: Thu, 18 Apr 2024 13:29:20 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Jan Kara <jack@suse.cz>
Cc: Jan Kara <jack@suse.com>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 4/7] udf: Convert udf_adinicb_readpage() to
 udf_adinicb_read_folio()
Message-ID: <ZiESIMaRHQyaFfFa@casper.infradead.org>
References: <20240417150416.752929-1-willy@infradead.org>
 <20240417150416.752929-5-willy@infradead.org>
 <20240418105000.inlrq2z666vworuu@quack3>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240418105000.inlrq2z666vworuu@quack3>

On Thu, Apr 18, 2024 at 12:50:00PM +0200, Jan Kara wrote:
> > -	kaddr = kmap_local_page(page);
> > -	memcpy(kaddr, iinfo->i_data + iinfo->i_lenEAttr, isize);
> > -	memset(kaddr + isize, 0, PAGE_SIZE - isize);
> > -	flush_dcache_page(page);
> 
> So where did the flush_dcache_page() call go? AFAIU we should be calling
> flush_dcache_folio(folio) here, shouldn't we?
> 
> > -	SetPageUptodate(page);
> > -	kunmap_local(kaddr);
> > +	folio_fill_tail(folio, 0, iinfo->i_data + iinfo->i_lenEAttr, isize);
> > +	folio_mark_uptodate(folio);
> >  }

It's inside folio_zero_tail(), called from folio_fill_tail().


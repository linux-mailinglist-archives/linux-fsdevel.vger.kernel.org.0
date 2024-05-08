Return-Path: <linux-fsdevel+bounces-19102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 440098C00D2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 17:20:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDA6A1F272DD
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59306127E34;
	Wed,  8 May 2024 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gbh4kqLN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D67F126F0A;
	Wed,  8 May 2024 15:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715181626; cv=none; b=i8Xaiou2Hoy76/fWdEuJmQNo1pdmnDj2zVnyDdhWxv7XmJPWseRzMui9m7eeLSc4lsyID+B6exdZMAUS78urrj+W3iRTQs76p1o7J+eqoiksTycyw3p/bT1QZpNZTt4ZVgMM7Ii7c7cIfgsa9Xn/qTR+t/8M7onkRtGlLVesvz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715181626; c=relaxed/simple;
	bh=RfnuiEkMHZizlL+1XOx2zPuV0PNycPXg1cxvzumtMVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jFcDg9yaiAaVRSnes0CI6LobiEFGO8322tMn5BFe3D4KwEIegl+stfhUv+MaycRvrPrERxZJsW7pCqNp3MOPfqI+dJnQ/MUUtjewLLUtAd5H3QK+5JlXNjNhasq786SjYvWan+J6kQNiKQ46Fl5Nd4G/RFgQzWKh8E7ZH6ACyl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gbh4kqLN; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=e3hS5Fl8mwjnXrAA74G4mvzbNmBfp9o+MHe2MBuH9EA=; b=gbh4kqLN6hHkqAnXPraqwObX/q
	XH0dpEaHVbIbVyoDUCpU6ZwUJRm9Z5K2MB4FAAi+S++GX9iwBiyRh7KnJD0UNuAd5/mW7T/rAEHFW
	WIeOdC9ViDfjlbkGituNCsA2qJ4gn3088+BoDuldAcamu6xCxTPViUmJoruKKEF7XQhztRZAr17Tl
	Q4iHUIZEMg8cH8Hwwb5cdPMhqi0q+Zn09iyPmXIN1uH1ExdCVmo3GDFY6oYeH+zgnDzliR/pUxUvp
	ROT0Z1Nyn20TGHYTTyGdGapJOgGZySGG4cFnq780gD3HJoUm3QIW0tdjS9u6rwGp+hPuC5xryI9c+
	um2O+FEg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4j5f-0000000Fueq-43ch;
	Wed, 08 May 2024 15:20:20 +0000
Date: Wed, 8 May 2024 16:20:19 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>, linux-ext4@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/5] Convert ext4's mballoc to use folios
Message-ID: <ZjuYM5ElTeBrXW4D@casper.infradead.org>
References: <20240416172900.244637-1-willy@infradead.org>
 <171512302195.3602678.13595191031798220265.b4-ty@mit.edu>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <171512302195.3602678.13595191031798220265.b4-ty@mit.edu>

On Tue, May 07, 2024 at 07:03:53PM -0400, Theodore Ts'o wrote:
> 
> On Tue, 16 Apr 2024 18:28:53 +0100, Matthew Wilcox (Oracle) wrote:
> > These pages are stored in the page cache, so they're really folios.
> > Convert the whole file from pages to folios.
> > 
> > Matthew Wilcox (Oracle) (5):
> >   ext4: Convert bd_bitmap_page to bd_bitmap_folio
> >   ext4: Convert bd_buddy_page to bd_buddy_folio
> >   ext4: Convert ext4_mb_init_cache() to take a folio
> >   ext4: Convert ac_bitmap_page to ac_bitmap_folio
> >   ext4: Convert ac_buddy_page to ac_buddy_folio
> > 
> > [...]
> 
> Applied, thanks!

Thanks!  Can you also add 20240420025029.2166544-11-willy@infradead.org


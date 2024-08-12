Return-Path: <linux-fsdevel+bounces-25627-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049EA94E592
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 05:30:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3630B1C21583
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Aug 2024 03:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07D4E1494AD;
	Mon, 12 Aug 2024 03:30:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="M3bNv+nU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A2A2C9D
	for <linux-fsdevel@vger.kernel.org>; Mon, 12 Aug 2024 03:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723433419; cv=none; b=OAYhWctdFFN8fe4ke/F4R9YZnsCqLk0zypAsBowYeYYLdWWnCEnFP8gWf4X+m8Fg9d1Q+uPtdqY5zdClGDBkmYq57VXvX8KZlNYOmkDjRhYJFv06YlfX5ehCjOiVZ9fPW5LH/gtq5xdwofxg90myaac0QRKQdu8RlnhkUTusNqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723433419; c=relaxed/simple;
	bh=xegZHqyNG59oPO/iZJeS4NKbS2bBkohxkX3AtijpoKw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rCb5DQDWh5m3iflNvY8F7MWpoQAy3RoCUnfVJTPV1QsFkhWYrFMLL82PLxoAAEWSorSMm7QXbreL3woz4nHIgrEwWk2Q3p6iKFc3xgEcvlq607RAngPQx6Lx/zoNdO8Eam0UKDirac32uOt8bnKgvsNwDa2WsMOWEMFfNxALdXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=M3bNv+nU; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hQQcr/jtHQIQjAtkt0QJrMeHgBrXzjKw0avBtw+4dHA=; b=M3bNv+nU9IA/6oN0y0fMYA64Rc
	819vh/aHbJwvSQAC3Coecv9IYKe60gmSO1f+k6KYk0JGTqdJ4GgbhPsF/ctkI9dLAtKcJJxfk3OPZ
	awN7RpZQVDaft1nE/Npzi4ptDWRRUS1db2HQnxtIGZJNqxEyMrZF6ketWXL9CL45H6jpnS80TeilP
	bw40gk58pQ4A/MAK7zHbKaCgd7IGzLEU2LOy3evzprxarjAtNq7KRUXpKlFGdnYD3rfeaIxwr4oeK
	e0wOB2hQq+4FmuiJpC3SCxaktexTGJ8VR6IVn8en/J+0Q8a8LsZIVt42V0tQrto02065HXi1KEPLJ
	D56Mt34Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdLl0-0000000EUar-1se1;
	Mon, 12 Aug 2024 03:30:06 +0000
Date: Mon, 12 Aug 2024 04:30:06 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Greg Ungerer <gregungerer@westnet.com.au>
Cc: Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 12/16] romfs: Convert romfs_read_folio() to use a folio
Message-ID: <ZrmBvo6c1N7YnJ6y@casper.infradead.org>
References: <20240530202110.2653630-1-willy@infradead.org>
 <20240530202110.2653630-13-willy@infradead.org>
 <597dd1bb-43ee-4531-8869-c46b38df56bd@westnet.com.au>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <597dd1bb-43ee-4531-8869-c46b38df56bd@westnet.com.au>

On Mon, Aug 12, 2024 at 11:46:34AM +1000, Greg Ungerer wrote:
> > @@ -125,20 +121,14 @@ static int romfs_read_folio(struct file *file, struct folio *folio)
> >   		ret = romfs_dev_read(inode->i_sb, pos, buf, fillsize);
> >   		if (ret < 0) {
> > -			SetPageError(page);
> >   			fillsize = 0;
> >   			ret = -EIO;
> >   		}
> >   	}
> > -	if (fillsize < PAGE_SIZE)
> > -		memset(buf + fillsize, 0, PAGE_SIZE - fillsize);
> > -	if (ret == 0)
> > -		SetPageUptodate(page);
> > -
> > -	flush_dcache_page(page);
> > -	kunmap(page);
> > -	unlock_page(page);
> > +	buf = folio_zero_tail(folio, fillsize, buf);

I think this should have been:

	buf = folio_zero_tail(folio, fillsize, buf + fillsize);

Can you give that a try?


Return-Path: <linux-fsdevel+bounces-15250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D19088B1F5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 21:49:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53AB6B29B5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Mar 2024 19:51:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFDB1F95E;
	Mon, 25 Mar 2024 19:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QCZOzQHf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D191B1BDD5;
	Mon, 25 Mar 2024 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396256; cv=none; b=ejesSFg8+wkcdksGikR/8stoTyu9SQRxQyyjXywyGYsSSFvVQ5R5mNrgKKBR0dLKKT461Iy3bhaZb41grhre41PmbEfgodUewCVMgyra4CZkkVnh4q/mFQpJLY/aCCe5U6AHW/S+vH9Y3zyxYhHgS1lzWMC8wnO/tNpswBfgzHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396256; c=relaxed/simple;
	bh=iKEO/xHVQKEIQC9/JG8R79bO8RfQOLSdfjZGGmqdSAg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bnkEkPni6r5CEN/OnHTcGnwYb2HvXmJucYAAPe3cEtu7ZUyLSGzkCKYt9oNqXWu8ZnmnkMrs6dFy2BK0dPrJnteIJyJR/zWZ6O8qDDPIoqbMJ3zKyhyhJHjHtCXr32rzx86D5rX0FBNTaNDSkX6GnTbLuTbFndHP18M/QutyQUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QCZOzQHf; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Ba3ZQVoyv35CFpCd52xhNCuIr1OdeaIrpW35R7rzWJs=; b=QCZOzQHf2X0CYDknK1bY5HgaG/
	H6lXEdEM6BopZrOfi7w51aSU8qo/IAuEe+928IY1r4NKWnf4L15+2155zMGDbynqvMFvErfrfJ9Ad
	Z1BnZnIXsRmkzIBLIFoyhDyk8JsWMIGGDcCa1pkNDJUcl+kaW2AW3hi7rGY0pLicORirqfVALPg8b
	D1GlEjN2r+V43yuis6oNEkLFLt4cxToPCDqFg7LEKsusCgkRGGHqUGyUgfVdx0dQALJRRXrEan3Jl
	eeyG8AsDtNmcadHl155TrXxwFtRFFCS/lnp/ubYOhqAsMUeHwiS8bnV0qxeLy7m3jxzAbNfY/6NTK
	qp9udYDA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1roqLJ-0000000HChy-3lo4;
	Mon, 25 Mar 2024 19:50:49 +0000
Date: Mon, 25 Mar 2024 19:50:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Kefeng Wang <wangkefeng.wang@huawei.com>, linux-aio@kvack.org,
	linux-fsdevel@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Benjamin LaHaise <bcrl@kvack.org>, Jan Kara <jack@suse.cz>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] fs: aio: more folio conversion
Message-ID: <ZgHVmbIj80R7GZq6@casper.infradead.org>
References: <20240321131640.948634-1-wangkefeng.wang@huawei.com>
 <20240322-rangfolge-teilnahm-9815a419610d@brauner>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322-rangfolge-teilnahm-9815a419610d@brauner>

On Fri, Mar 22, 2024 at 03:12:42PM +0100, Christian Brauner wrote:
> On Thu, 21 Mar 2024 21:16:37 +0800, Kefeng Wang wrote:
> > Convert to use folio throughout aio.
> > 
> > v2:
> > - fix folio check returned from __filemap_get_folio()
> > - use folio_end_read() suggested by Matthew
> > 
> > Kefeng Wang (3):
> >   fs: aio: use a folio in aio_setup_ring()
> >   fs: aio: use a folio in aio_free_ring()
> >   fs: aio: convert to ring_folios and internal_folios
> > 
> > [...]
> 
> @Willy, can I get your RVB, please?

For the series:
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


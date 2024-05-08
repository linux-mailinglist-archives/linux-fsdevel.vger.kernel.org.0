Return-Path: <linux-fsdevel+bounces-19084-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 476838BFC38
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 13:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C91E3B219F1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 11:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ABE82863;
	Wed,  8 May 2024 11:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="prTjolwE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748FC81AD0;
	Wed,  8 May 2024 11:36:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715168210; cv=none; b=E1i/Ro5FfsMGbMCNe6kfgl3KutPfJwd3i2lIES1ZH7G25x2QBVUHjP3o+epJ3OHEtVrTphtkSZ9I8/ohhQw0ITbVP1zLzgw7srhGUPawKoLDLp9VjyWI45NJKaQv7z2Ezb3gl6NTAK137UN1B6FenECiBcF9s1peFcUwFEelzns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715168210; c=relaxed/simple;
	bh=ionXjYKJhrS71F37Lkbw0fk4ODB48gbbt+9RI7m9ppw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kdOsZO0s1kb/gVl9Sm/R++/HICD3AfrXnspbnpfdcZDztfWZH31aYG7OlhNKIpQQiLEvMke6ZCXs17qu2f0/uwBpq1/45oFff2Qw1wl9Zl/lkTkL+R5k9JQcllx0v1tCMj94K0qnDgG2L3sTfRv5IeKngJJ8az6ZRphmU+YInqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=prTjolwE; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8rBSqqk3Dus3WYu5NpDl6sctlp3PQWFzSKoFRqkHQlo=; b=prTjolwEd1YkvaTflW9dmNx2HO
	AG2tcaR6q+4iFyte+YucYkOlnUglinvPRfBljqY0fNtFz01mNoVPUbj9gtk5LzZAvKH/9JTj5uHYA
	w5faiFjWiGstG8W7eN9Yhxv7rpQwD4Lrfxk3HZfYNwoLf/g5xeiGIEiExKRQzGmOa2ODgQf6FvPnJ
	yWVNvY6pSWwsCDtMsmMeiwqhON68ROokIeRkz+uWMKgpfy+y970j1+I1uDYEfoLB4naHlT8c0cOx4
	3IZrYCbf76VvU8QVBje3IXfGjZT4w9JjxisZWpBaHyhyXiYeKzo9yDIcxVvXwf2jziTizRfdlBdFb
	qHrBzCXg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4fbE-0000000FGOB-1v4V;
	Wed, 08 May 2024 11:36:40 +0000
Date: Wed, 8 May 2024 04:36:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v5 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <ZjtjyM60ebrJfAmM@infradead.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-8-mcgrof@kernel.org>
 <ZjpQHA1zcLhUZa_D@casper.infradead.org>
 <ZjpSZ2KjpUHPs_1Z@infradead.org>
 <ZjpSzi-HiZkx_Kdq@casper.infradead.org>
 <ZjpTHdtPJr1wLZBL@infradead.org>
 <Zjr-lf2tJAmwLzzu@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zjr-lf2tJAmwLzzu@casper.infradead.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, May 08, 2024 at 05:24:53AM +0100, Matthew Wilcox wrote:
> On Tue, May 07, 2024 at 09:13:17AM -0700, Christoph Hellwig wrote:
> > On Tue, May 07, 2024 at 05:11:58PM +0100, Matthew Wilcox wrote:
> > > > 	__bio_add_page(bio, page, len, 0);
> > > 
> > > no?  len can be > PAGE_SIZE.
> > 
> > Yes. So what?
> 
> the zero_page is only PAGE_SIZE bytes long.  so you'd be writing
> from the page that's after the zero page, whatever contents that has.

Except that the whole point of the exercise is to use the huge folio
so that we don't run past the end of the zero page.  Yes, if we use
ZERO_PAGE we need to chunk things up and use bio_add_page instead
bio_page, check the return value and potentially deal with multiple
bios.  I'd rather avoid that, though.



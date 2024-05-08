Return-Path: <linux-fsdevel+bounces-18989-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A2A8BF53D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 06:25:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1411C23E0F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2024 04:25:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21985171B0;
	Wed,  8 May 2024 04:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="s+ACq4eo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9795514F68;
	Wed,  8 May 2024 04:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715142304; cv=none; b=F8BNwEX+v0Z1gZm79423s87wbT8HdfvwBfhr65hxJfAp5+vqPhQMHPM0tk788WTOGzW6OvYpi/puNlbY5gZnU3ojx/gWzS+xxejMKJDRP555MyNoB1KFKIUW1Oe/VttrAuofHMK/vxHz3ZQFla1UuAHt9gSLY/8Hpgjww3wXpk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715142304; c=relaxed/simple;
	bh=c5gTcs72ohynmb6Dnqtw2TG/Hf2n58urvUrAE5Te+94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l3yad4Qgukn/1fYq7znFO3qBUGhbC5pCvnzIvzB4QaFDsQRLuWthlOHLxn90Kz+0CCOvUFVTiaURTVae1aBrJymRvblgRhmqt0b36UZGkzfKN7LpcxnenJJKd1+7dSC7zqI0lPt2DnN8Y7Zi1RVZKX7Q59TBbued1z5g+sY4fFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=s+ACq4eo; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=84ZtBvQ/khWSnQbEsf+haKoET0najOuq14tZKuu3Imk=; b=s+ACq4eozDPnv+dJg0ug0zNJiJ
	pUo4dOo4SkdW1sY/xWDWEwgbzQFZUVHYBt27fZx8vQTbZPfxwPoR1uBJfGL7d7nkWZR2TYtDWI8wn
	xJOhrWog/be2TjPlnaz8LPrQiNB56alp4WywKxz1gQc5pEF8d/h3c+GbUATcI+zVPjMCRtdHOL+mp
	Qz5uGBSbFkmkxrIQVBy7kLsCXLicfFEeidgwehur+2CvLXqPhF+gakpGCXOk/vEoEsbAenOobpNXi
	0QG7kA95+LsR81+mAlNxbSxbMcmsRIZolR0lN4u2cZdZEksmwQ49nqymVT6bKO31ONbHcd5GwRpoc
	ysZpz2eA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4YrN-0000000Eq2c-340Y;
	Wed, 08 May 2024 04:24:53 +0000
Date: Wed, 8 May 2024 05:24:53 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: Luis Chamberlain <mcgrof@kernel.org>, akpm@linux-foundation.org,
	djwong@kernel.org, brauner@kernel.org, david@fromorbit.com,
	chandan.babu@oracle.com, hare@suse.de, ritesh.list@gmail.com,
	john.g.garry@oracle.com, ziy@nvidia.com,
	linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	gost.dev@samsung.com, p.raghav@samsung.com, kernel@pankajraghav.com
Subject: Re: [PATCH v5 07/11] iomap: fix iomap_dio_zero() for fs bs > system
 page size
Message-ID: <Zjr-lf2tJAmwLzzu@casper.infradead.org>
References: <20240503095353.3798063-1-mcgrof@kernel.org>
 <20240503095353.3798063-8-mcgrof@kernel.org>
 <ZjpQHA1zcLhUZa_D@casper.infradead.org>
 <ZjpSZ2KjpUHPs_1Z@infradead.org>
 <ZjpSzi-HiZkx_Kdq@casper.infradead.org>
 <ZjpTHdtPJr1wLZBL@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZjpTHdtPJr1wLZBL@infradead.org>

On Tue, May 07, 2024 at 09:13:17AM -0700, Christoph Hellwig wrote:
> On Tue, May 07, 2024 at 05:11:58PM +0100, Matthew Wilcox wrote:
> > > 	__bio_add_page(bio, page, len, 0);
> > 
> > no?  len can be > PAGE_SIZE.
> 
> Yes. So what?

the zero_page is only PAGE_SIZE bytes long.  so you'd be writing
from the page that's after the zero page, whatever contents that has.


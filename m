Return-Path: <linux-fsdevel+bounces-20652-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B3D58D6698
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 18:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E9828BE37
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2024 16:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5452A15AAD6;
	Fri, 31 May 2024 16:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GopVdiNK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72913770E6;
	Fri, 31 May 2024 16:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172245; cv=none; b=tl0iqpcBd1Y3o1h4e3Fd8Gj1YaOnhV+dt3vgxdswZK4MZPjirFCxPpiFcPEWrghWPdY/wrgH3XtAcHuLHGvNqfmnnpELZxifRg8VaZdDH+9g0+qMbpN/vq2khDqAt+Fx+X0l0nLYzA5D5LxUh8nqbg25ko6zdkTYsmVFrMwgeus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172245; c=relaxed/simple;
	bh=YVD1oIXHVOcPzieLWrdyrn3cD5ewuei9De6O31ofDno=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UpbZxhnQvXaYGBF0j5BfupgcVqvxCYDasW3gZjf1MNCBQQEPDOtbyDeJrNxrV/A5DED2cVT7fd2nuW6xX63yYI9kh0ny54BETnO326sa7EX7ukjIlfOZ/la7+tsvZtRrnnrNVPm7gP5zjc9q5tDNL4tYXcUXUDBK3K3Kyi4K810=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=GopVdiNK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Mv5unSw6t2fD+qm6IWvUBTNAQOSiqb0xRVGCGHo3pdw=; b=GopVdiNKficeAEV8Bu/eQwWwtn
	ft6au4aF5ihr38s9snX7EzpHJh5xA4kTFp4ZGq7pjw6FXKWme4CysLiiAp87jWJXcd1v+vk/+rFey
	wojNNK3Bbtxs9cezDDtBJsKWirRyp88gA0RnQnSxddzovPzs84kvlUay5pipfDKzp5fRCGNMjeOdx
	3ShLpxaJy0ILWfH0X1A2pKUcyXxn1UGj9QZx2Nfz7zx0FPD1/+JDVEfJ+E3hDllugWWEwhywl70rs
	EOvDXRjDw4BNOsCHoCU7vt5l+OPQqJBQQO65vO5YvToDsPi7yYqbqIK08NZbKzb4pFfFZEJJOBRIj
	opaN2ReQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sD4wV-0000000AoC1-1Cg3;
	Fri, 31 May 2024 16:17:23 +0000
Date: Fri, 31 May 2024 09:17:23 -0700
From: Christoph Hellwig <hch@infradead.org>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Christoph Hellwig <hch@infradead.org>,
	Zhang Yi <yi.zhang@huaweicloud.com>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	brauner@kernel.org, david@fromorbit.com, chandanbabu@kernel.org,
	jack@suse.cz, willy@infradead.org, yi.zhang@huawei.com,
	chengzhihao1@huawei.com, yukuai3@huawei.com
Subject: Re: [RFC PATCH v4 5/8] xfs: refactor the truncating order
Message-ID: <Zln4E5usaHTw68uO@infradead.org>
References: <20240529095206.2568162-1-yi.zhang@huaweicloud.com>
 <20240529095206.2568162-6-yi.zhang@huaweicloud.com>
 <ZlnRODP_b8bhXOEE@infradead.org>
 <20240531152732.GM52987@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531152732.GM52987@frogsfrogsfrogs>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, May 31, 2024 at 08:27:32AM -0700, Darrick J. Wong wrote:
> On Fri, May 31, 2024 at 06:31:36AM -0700, Christoph Hellwig wrote:
> > > +	write_back = newsize > ip->i_disk_size && oldsize != ip->i_disk_size;
> > 
> > Maybe need_writeback would be a better name for the variable?  Also no
> > need to initialize it to false at declaration time if it is
> > unconditionally set here.
> 
> This variable captures whether or not we need to write dirty file tail
> data because we're extending the ondisk EOF, right?

Yes.

> I don't really like long names like any good 1980s C programmer, but
> maybe we should name this something like "extending_ondisk_eof"?

Sure.


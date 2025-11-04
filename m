Return-Path: <linux-fsdevel+bounces-66920-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BB3F0C30A51
	for <lists+linux-fsdevel@lfdr.de>; Tue, 04 Nov 2025 12:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED4064F3A1D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Nov 2025 11:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 504A72E1757;
	Tue,  4 Nov 2025 11:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="OiLujuAb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688E71D63F5;
	Tue,  4 Nov 2025 11:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762254115; cv=none; b=YIdWn1mVyiz10v+Tc7gvQlfhQFn7iKbFKcqasY40IM3NZ5VOT7SUvkcw3AyTBkNe8+4pQl3bPd7Rr++g/nqw91+WilJf+IIx/OU2opJ5oLe0PFm4GmR5O0u7R4DJgDcOQDemWee/+84rk5yfZ0BXhIAN+nIfeAwOvmaOsGDBqbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762254115; c=relaxed/simple;
	bh=AxiqV+31Qh6Zrth5O9nnkkUtVMjzHNNBzB4VEqO9Y8A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NUEmGwnj901X7ErtaHkPagNHhKH2VyW234HeCAcC2tbRBB1FEOaQK3hBLE+RAvA+dCfMawIXa2+PhuwmWr1okIkDWAdAnkXdpHm5mfzpECTy3IBQHLXmfnr4M2u5GM3pAUqjDwYDfLPAmZHKEs0aEzYlLEGJ5SWdjsDHTCOjbwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=OiLujuAb; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=DB76K9u7wzUf8r66w6ClValkRN23vjpUQxhmZRQlL3c=; b=OiLujuAbWycW2hSTkcxGXBeBuF
	buljSVku171/ptr7JST3pzC4mKDU5gOukUDrJwH+DKKtTOUVa56EsT97b3sP5KLGcJgO4Bxl+3oM5
	gBWYbJvCVDXlk3WNB8a2YvrQIufVPu+rTuq24AKSsj7evJvtmLMGYh1C9AMvNPkg6Mune5+/zjJOS
	fT8IXAr9pl7zxC6YqSxugnA8l0bcCVwFNfnn7dk5foPSNNO7Jx+VqZV3K9K4WPB/6hotu1GBMjM4A
	+cN5Xa//jKH3BnkkJWoK6TqllVCWub9wAxZ1oDMWsTa0ZS1iiYcoXuC5g4erc4vlkFcF7gPW7zFre
	qqNSBDXA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEnO-0000000BgG0-49mE;
	Tue, 04 Nov 2025 11:01:51 +0000
Date: Tue, 4 Nov 2025 03:01:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Yongpeng Yang <yangyongpeng.storage@gmail.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>, Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
	stable@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: Re: [PATCH v5 2/5] exfat: check return value of sb_min_blocksize in
 exfat_read_boot_sector
Message-ID: <aQndHokFr0ouIEAq@infradead.org>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
 <20251103164722.151563-3-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103164722.151563-3-yangyongpeng.storage@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Nov 04, 2025 at 12:47:20AM +0800, Yongpeng Yang wrote:
> From: Yongpeng Yang <yangyongpeng@xiaomi.com>
> 
> sb_min_blocksize() may return 0. Check its return value to avoid
> accessing the filesystem super block when sb->s_blocksize is 0.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



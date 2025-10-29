Return-Path: <linux-fsdevel+bounces-66199-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC9FC1940F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 09:59:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D3C646328C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5594314A99;
	Wed, 29 Oct 2025 08:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EmNuX50m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4F431BC96
	for <linux-fsdevel@vger.kernel.org>; Wed, 29 Oct 2025 08:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761727117; cv=none; b=M6jpZko4V7WBzB2Ktr+BZwIrbOjPHZ8KgEOoQV+h2ndnvqcPYRFmHF01+I8GCAB2PE4QzZ1+/vZLwnElCvEkDGqLvmsSOLnop2NGWxAEEBo/PMY1AZZWK1jWWs1MJDXOrHPu2rLPpGmJR4hgRzdn9vUuyikzdhLD84YVJEez0BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761727117; c=relaxed/simple;
	bh=jHPG79cIDQermeWXk/s2cLoLNk52B2qBOCVNl8677w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lDH+olEQsmauj3I7I8aroMteRmK8lxBVMRMWM6HGgYsYMlUGODzJtztv/AFbsoCCxmFKMKzR66jPE5IbN8ZSh9UOnRG3Vy1RoNBSnjMGv3txAvSfuGCJOZUQMjl6xIIaFxkmWTCzdXtQURwfZRwvlaNzr8kJwN7HFd5SLJghmH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EmNuX50m; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hCBTh/EI0EiKLF+ah3/EfOIkVq5xEqJkXgS154QDQPs=; b=EmNuX50mMm2Hux4eQW1RK1tb61
	8rJTX2n8h9AwnHPjmo5df3e1DKvMSepMqDWJxac3rbAoayHy1iqeZrZAsg6F3V5HvsQc59ThecqOG
	Z+sQLybmnEMuqXnp1By2CqCOSL5nmN52VnPNkmfFXjII2aqra5acozO9z5TXwxc/ddMTy2gj1Ltej
	6AgEnCJ4ppNN4lUJnb2dPrPrFrHMpi8jOlNZJ4flhk2y/ZF2R5Db3OB9W6GqRk53QLlAt3LQQX3oC
	0JSFMtDVczwq69sAGCoXvC8MN8UGbKEciwW+oUauAxKjn5PEH8YGSC75jra2tSN86jOPQIuZv9ZKY
	JDxdEuEQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vE1hS-00000000Kz5-1nFC;
	Wed, 29 Oct 2025 08:38:34 +0000
Date: Wed, 29 Oct 2025 01:38:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, bfoster@redhat.com, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iomap: fix race when reading in all bytes of a
 folio
Message-ID: <aQHSig7TWRQyRDi7@infradead.org>
References: <20251028181133.1285219-1-joannelkoong@gmail.com>
 <20251028181133.1285219-3-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028181133.1285219-3-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 28, 2025 at 11:11:33AM -0700, Joanne Koong wrote:
> +		 * add a +1 bias. We'll subtract the bias and any uptodate/zeroed
> +		 * ranges that did not require IO in iomap_read_end() after we're

Two overly long lines here.

Otherwise this looks good.


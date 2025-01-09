Return-Path: <linux-fsdevel+bounces-38703-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4CA06E0C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 07:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27169167488
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2025 06:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E412147E6;
	Thu,  9 Jan 2025 06:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TrClJ0xN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04FED12EBEA;
	Thu,  9 Jan 2025 06:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736403030; cv=none; b=YaW+yGw/+3xoE2Q6NFFfu0xF3tzPwIP8gYDsm/Lskja7qGW/mtWoHjqI/COfz9TR4QamDIDp/mM6VRWX6OOa+YBOCQChZyAMsUJdCVgtWCB7w0TJJl1/vsQrPihPuDtv3fyeFWOxLuKjCZgEEAarxFoEajuH9N6B0gjwgLRvWiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736403030; c=relaxed/simple;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oIRtMu6uZTArkwDuZyHWx5YLJRnoNEQHnA8EwoenMp3Z84y07elufLjL+A2phHplGBFSJO5MHqPjWCA7TOmGNaavktQkGO2t0voB9N89h3jHVZqAI2e2gT4Dzd1RfabbEnlZrHM0g3iDvLpT6kNqXSpNv44W/t9zwT02MHCr/pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=TrClJ0xN; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=M7NmYC/Iylm9myghHwqILim55SAUt9QrM+UZYk0eJlw=; b=TrClJ0xN4jQcLTLJRUkHnE+S9X
	F5idi9+XHxlgwJeitVoniZxpIeomROoDwqyfSOwcej9BVZjdSLVvoDLGp/ozREXHU5QME2bUeWzrc
	5G5GqZutZXbbK6N/AG+3JKhu65OmahG3JUBiYnhnPEgAX7zva8iqw3nK+lPcmazULLDDn3fiiO5yL
	PY/4R1F9xHZros/CdZfVKNjtkPEYXRD8nXDy03AkRMy4sBlOgvOTDCbtmsABpz3TjC9SvuPrgnSHy
	RXfqzZs6e+n/oSX/nXU/FdG91s2rP8dyN9kt9mle8i716X4GLJEkjiIlEgNYNICTkoqauUlGp6/yU
	jOlvAmmw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tVlkQ-0000000AtjC-35CA;
	Thu, 09 Jan 2025 06:10:26 +0000
Date: Wed, 8 Jan 2025 22:10:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Marco Nelissen <marco.nelissen@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomap: avoid avoid truncating 64-bit offset to 32 bits
Message-ID: <Z39oUr-55x1De_wC@infradead.org>
References: <20250109041253.2494374-1-marco.nelissen@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250109041253.2494374-1-marco.nelissen@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



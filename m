Return-Path: <linux-fsdevel+bounces-57235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D01CB1FA74
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 16:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F125173970
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Aug 2025 14:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9027F268688;
	Sun, 10 Aug 2025 14:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="smDhgsk6"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF0B2E3702;
	Sun, 10 Aug 2025 14:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754836663; cv=none; b=XNS7Skg7imG22rhVTSrQSdJQXYiAt/Faa0iJrgJVNUu0YNNBKOy/uHqE9Ru0kmfaHRrx2WzCJNAyKTD8N2TkeFfltxYkoCQK9KlOccx3at7Gfk2ENYGpg+hkxJ9gKsy1SGyR7fQ6l6GKazhBg5LLPiYAHvP+lBrn53QrSE11T4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754836663; c=relaxed/simple;
	bh=IxAxzw5kkdQJ03Mopc1VqfjQUYdRD1B5ji6NLutB1tg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibovmz74TGWcKErobP5/FNzE6CRuZ1xiQpK66IlPNc9BcJAUs7tPAZbz/hSV4HUwVDSL69eFtnZbzuVKbm4JNlo0xoaA00G+HNF+wTACvdfD81hoyMEY+g864IpOQxQqoGF2y4ifIiAx9LAGwacO56b9YA4e96Qwqx1aoAyigQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=smDhgsk6; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=rC0/MyEJFfsNrbJCBEWzCqib5fE9JZLKVZpwjQH0ewA=; b=smDhgsk6XIvrYy+XhWieKJKQcZ
	ncECLq7Cy24P5MVUJeUYT4eN1n0OddH56m+G7QwnZbrOoh//XTCHWZTGDUB8NLpvk7Ih6fGNGyXAD
	WCXMbzVANzPelgMlCv2yk7w2BMFiY0Xf1EPk7WfjboByvaRNy8I2Z9BwICNseYVr69JkAfLK9BbO9
	pOie0cx77MyAnnnFicHSoli+RRQVNqC8BdG4iLnxmKZLnORoWTBP+UpIP4Ng4EpkGG8gRCRzxbamc
	o1AVx0GjvjkojxXbSKcMWOr9CaJdcFd/i5p2yaNc8xefKRTzHwDTB+7dFERfSuGvdkpL5qD2T+FOD
	cPtTqpfg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ul7B2-00000005hbi-1PqT;
	Sun, 10 Aug 2025 14:37:36 +0000
Date: Sun, 10 Aug 2025 07:37:36 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, snitzer@kernel.org, axboe@kernel.dk,
	dw@davidwei.uk, brauner@kernel.org, Keith Busch <kbusch@kernel.org>,
	Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCHv2 1/7] block: check for valid bio while splitting
Message-ID: <aJiusAtZ-CsnPTOR@infradead.org>
References: <20250805141123.332298-1-kbusch@meta.com>
 <20250805141123.332298-2-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250805141123.332298-2-kbusch@meta.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Aug 05, 2025 at 07:11:17AM -0700, Keith Busch wrote:
> @@ -341,6 +344,8 @@ int bio_split_rw_at(struct bio *bio, const struct queue_limits *lim,
>  	 * we do not use the full hardware limits.
>  	 */
>  	bytes = ALIGN_DOWN(bytes, bio_split_alignment(bio, lim));
> +	if (!bytes)
> +		return -EINVAL;

How is this related to the other hunk and the patch description?



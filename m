Return-Path: <linux-fsdevel+bounces-34083-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C6E9C24DF
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:27:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98EAB1C23AE1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258051A9B23;
	Fri,  8 Nov 2024 18:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="EQ7/+UNe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C363233D60;
	Fri,  8 Nov 2024 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731090464; cv=none; b=dZwSjX3LYmPrTA894+bKaa2OKk7ZUQRo8tkBFHNZuQ9NdFfCgaks7SEO4lnMk8fRk6Epymcf4TR58WeCGEbSHoCAYzR8vF+AXyyW2P5FHUmfk3FH8+/VhljtgchWdqMyEBH9hZgbuFu84Fonxr+fXQPaf55rDvEoUQKGcIIX0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731090464; c=relaxed/simple;
	bh=bUhGmI9SfduIgN2KlU0AH4qTq7pRBt3ryVYrNq4XkG8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ulkqeCvXcouIHgrs5kGyJ1JC03/Hev/t0ClJN2VWupOmNr3XFvMjhzxsV9K5OHLxtJ+IUWamZ31CE96h4+a4MB9pykghphNaLHOjrhxXO239+u1HLy42d6IZr+rAcUsP5HLY9vi5PaHL0lOmgEjVQlyXqWeGOiABbxXlikEvrs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=EQ7/+UNe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2xgpGRfeBe/msEpE/hTM/bajJlO34Tgh30XVl58duvY=; b=EQ7/+UNeYSZQBN6JsV+zLjCImE
	g5pJ6sTv48gJyrds5UYUYrcik48MZzLA+y6O2umHFBFggjFoygMfn1GnsiS6MTjggSb5JmtjOtUIX
	9EyYzZpLudsqaWHIisE4vNip8iFypOILmcrkbwpSebo3EPGlWszJLZrhXpIHioBVRsEVTEEUY6ESd
	i416bWXJ6Rzy3wo4zD4o4jatuZcvRXbKiwRs3bkVr7OSrHyk+0CUIwhStx0aNFP0kDUda3Yc0hKDY
	EhC/STCqpFqtHmS6VGGjEjTPEt7PWniKlWFDEnbWxc4lNhnlKdrm8W6latQ9cqhvGTSy9r2SUsjCW
	lIjOsgiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t9Ths-00000009AsD-296q;
	Fri, 08 Nov 2024 18:27:40 +0000
Date: Fri, 8 Nov 2024 18:27:40 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/13] fs: add FOP_UNCACHED flag
Message-ID: <Zy5YHDj-8DaSP8n2@casper.infradead.org>
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-8-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108174505.1214230-8-axboe@kernel.dk>

On Fri, Nov 08, 2024 at 10:43:30AM -0700, Jens Axboe wrote:
> +	if (flags & RWF_UNCACHED) {

You introduce RWF_UNCACHED in the next patch, so this one's a bisection
hazard.


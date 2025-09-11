Return-Path: <linux-fsdevel+bounces-60921-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC42B52FC3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9CDC47B713C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58142314B8A;
	Thu, 11 Sep 2025 11:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="vqt3zhlI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5683126BC;
	Thu, 11 Sep 2025 11:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757588984; cv=none; b=KOEI2jKDl5gXP3d2jjdquc2ql/yD4m1dqBqkqy6x/scHI6nNmJ9/ORWHqZlNLqKaWWY9EkxQwNh1CNF9FEm2FO7XAfEaPbk8WNUea3iyyzGzZpXUsjA+bx5hZuVTYDNKyTISL+z+qfiF4yiLtuuXsBJ/l4XWSugHt6xc1KEOFtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757588984; c=relaxed/simple;
	bh=CbR1U2p/LIcKsMwbaZ8/M5VOCaBF1AL07cvVJLekFQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PAhWZ2OYeIlV9Kz/oKkrNjkY0ITnGmYQlOPSTf+X/lECv7E4xhB9kCfEZq6HgkAXWerWRkhnk6av76mjHDXMdqNMbIJeIv0iVxyebV5ZN1l1D9047QC3Jmfvcfb5UK5NIvGMCcC+GgFYg98At33OeV/Un1dM8QAKXxmohK5m7Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=vqt3zhlI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Nb4ftzdnK6yZarqnCOCsO1qe2SK8ysSR8ln75BmbPV0=; b=vqt3zhlInsfUTNkYtKC3Yf1tKj
	ROskrRHn7ZrOqjp+eNBaeHB2a+F5ecgVSdxH/ad2jSlzQYIUl25jCSfWRrVCLCuXzMLlr4KXbvNDS
	B6dG/hRnFpUnFBKdbZNMXKvuiY3zEwjvxGNvisj9wbU0Jmgy8q9QfJx/CDDkOlhSUFijMwqlBGFqi
	eTuBbEj1lMg0K1aX4Z+auRQXzG/HBQkE2ctp2MPZNTYOeGmhpDyu2+B15d1PlqQcNxxkClS/KKU+u
	/i7ZIXeBJRtK3tgu/n6zbSifnsz5JBhrcjbGNct9NGE5pEG/3YOm/Rx2MToPEZ9DQVdMLzuZmc8NI
	OU01YSEg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfB9-00000002YeF-1yZ7;
	Thu, 11 Sep 2025 11:09:27 +0000
Date: Thu, 11 Sep 2025 04:09:27 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 01/16] iomap: move async bio read logic into helper
 function
Message-ID: <aMKt52YxKi1Wrw4y@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-2-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-2-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

> +static void iomap_read_folio_range_bio_async(const struct iomap_iter *iter,
> +		struct iomap_readpage_ctx *ctx, loff_t pos, size_t plen)

The _async here feels very misplaced, because pretty much everyting in
the area except for the odd write_begin helper is async, and the postfix
does not match the method name.

Also as a general discussion for naming, having common prefixed for sets
of related helpers is nice.  Maybe use iomap_bio_* for all the bio
helpers were're adding here?  We can then fix the direct I/O code to
match that later.

>  {
> +	struct folio *folio = ctx->cur_folio;
>  	const struct iomap *iomap = &iter->iomap;
> -	loff_t pos = iter->pos;

Looking at the caller, it seems we should not need the pos argument if
we adjust pos just after calculating count at the beginning of the loop.
I think that would be a much better interface.



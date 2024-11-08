Return-Path: <linux-fsdevel+bounces-34085-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3DF79C250B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 19:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 102061C2326E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 18:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C7C1A9B4C;
	Fri,  8 Nov 2024 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BUFkmd7u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979BC233D96;
	Fri,  8 Nov 2024 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731091614; cv=none; b=GpxZxq2i/QOPtB1lK/xRYJqS68w70OZdfGc6ercXQfhyALUkVsu7s8tT5MHmxTaQlqrQrZB02o8+FCUdSLx/7vSymTslS5MxHbE4inlrxwgsgvJUZr7OULX3KBTjUlYmJoFOkojPMh1QFca576NWCVVnPRfIMr2hU2WXqbW8tDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731091614; c=relaxed/simple;
	bh=+V0YXH4f45sBcRsRpKWiQwWMsEk4EaYNam8Lu3b3Ovc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IaLDvAzEeXmnuvT7vQb66s/JBcprc/3dnmoQzKlcFmgbT+bMc6E3de7VNLvT6Lal6cSk/2t1pEYfvHHFbA/VY7k1EtoGZDbOzjPQRYmB3nT2VwZVBzuPhz2T+GWU3eaRLFgPNcVz1OuGtYPIVSDkc2YLQbZ8QIiW4gcX4X9FPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BUFkmd7u; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=5PxtQy4+9CaX5UcMUWUwd0ZmKQR4r1a+EWCdYpyGruM=; b=BUFkmd7ux9lTNXQFCRiwXQN4S8
	GU/GcvgkKqQzPXEnLiY4ziB6utj2JFxJAvFZRikrt4ECfX2C88vA5tULvQCfxNhvYRaprMgFjZAwy
	dtmin/sK6L9vitiSITimF3jIwEeBJqM4XPJy1+5oshRTmGXrTtklMutXbQncsWt4c22dawYh0whfs
	v4KT3uiFs67h7+CNbp4TNARHWzeiVQFZurXvL05qRu7gI48rqYtZb2PyQO+anLZB5BoUbvWKsJZoB
	FF8AQRHzvlsVAPEycm98fX9mTqJHxyAY5rwIOzeVKsdXfzhyIp1dA005y/Lru4sCxXABAcgwmmuSK
	8daaCsVg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1t9U0P-00000009BoK-2DOQ;
	Fri, 08 Nov 2024 18:46:49 +0000
Date: Fri, 8 Nov 2024 18:46:49 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/13] iomap: make buffered writes work with RWF_UNCACHED
Message-ID: <Zy5cmQyCE8AgjPbQ@casper.infradead.org>
References: <20241108174505.1214230-1-axboe@kernel.dk>
 <20241108174505.1214230-12-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108174505.1214230-12-axboe@kernel.dk>

On Fri, Nov 08, 2024 at 10:43:34AM -0700, Jens Axboe wrote:
> +++ b/fs/iomap/buffered-io.c
> @@ -959,6 +959,8 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
>  		}
>  		if (iter->iomap.flags & IOMAP_F_STALE)
>  			break;
> +		if (iter->flags & IOMAP_UNCACHED)
> +			folio_set_uncached(folio);

This seems like it'd convert an existing page cache folio into being
uncached?  Is this just leftover from a previous version or is that a
design decision you made?



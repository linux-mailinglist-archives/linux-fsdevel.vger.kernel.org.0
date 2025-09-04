Return-Path: <linux-fsdevel+bounces-60247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 43D8BB43218
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 08:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0542E482CE0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Sep 2025 06:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 535FB248F5A;
	Thu,  4 Sep 2025 06:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AYynjH0D"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BEAE1A23A9;
	Thu,  4 Sep 2025 06:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756966470; cv=none; b=QpNAGdq8T3N2/bsu3qf96jlu4ogHlgYI+heao3/TQeNmTy/GX6AYrFOjdYNtVk/Ugo0dh/Olf7JcCfTZJDUejNkGyWArXoUpn+l3Gc/tyk/9Qdr+yzWebWzNJps3lTvuquebXPHSM5FbgG+zRHggpiO6Ek4ORhw8IamejtJeZBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756966470; c=relaxed/simple;
	bh=i6rZ7cXTaNiVrTIZHqTzTu6iTS1fwk2lryuXe5Natw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AF1v83TKQ4AbbXUTeC2O3ppFmbjEWmDxF8Xl5BSwt2mk1pHDc/Ic0PeoBesPcukp8ALDJOijFMO87sIQl+fhWvBafeZOZEuHzzTT4ArhXl4fIwGv7X10JRVRiQ3JKC07TSFXy6tQeAh2riZ8Jqy+nEXshaV8nvkuPVIYbVaPIq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AYynjH0D; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2zDIMm+dYe86mDH+YOnHfzwNTZWlGaeFfCgzurTxJ/Y=; b=AYynjH0DFR3yOTDVeFOwiltFvn
	BbV6LAZyzU9j9TXaTDSAR3Q8Py98Q42iQBuj9ws++E7DPLPKEIpKdRPjiYXcAwf2K1NH2Ptt3tAWs
	yZJQOwChTUCnGB2FGhFF33T10WpJvxGTfakjphWiv2FHJpn7OrSQxg3gnXp1jSHxkSu6q/FOTQvVq
	ijrRLkLPBz1j2j9S5GXs5KxMUHq5SXqViJRQvBjdCCn2zChcH+66WzqlWJKOaOpeWRGkBS71RWVqU
	8TWHh1FctnjKmDwttFbyyyL+9i/e41GF5KWsbuWvj/8N4k71VW4CfPKTbcTyuZRjk7ydP8XOA3FVm
	UckcxVlw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu3Er-00000009SCu-0rZo;
	Thu, 04 Sep 2025 06:14:29 +0000
Date: Wed, 3 Sep 2025 23:14:29 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com, linux-xfs@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v1 07/16] iomap: iterate through entire folio in
 iomap_readpage_iter()
Message-ID: <aLkuRRwdRkqYXAW5@infradead.org>
References: <20250829235627.4053234-1-joannelkoong@gmail.com>
 <20250829235627.4053234-8-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829235627.4053234-8-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Aug 29, 2025 at 04:56:18PM -0700, Joanne Koong wrote:
> Iterate through the entire folio in iomap_readpage_iter() in one go
> instead of in pieces.

Pieces I think here referes to the ranges returned by
iomap_adjust_read_range?  I.e. "iterate over all non-update ranges
in a single call to iomap_readpage_iter instead of leaving the
partial folio iteration to the caller"?

> This will be needed for supporting user-provided
> async read folio callbacks (not yet added).

Can you explain why it needs that in a bit more detail here?

> +		/*
> +		 * We should never in practice hit this case since
> +		 * the iter length matches the readahead length.
> +		 */
> +		WARN_ON(!ctx->cur_folio);
> +		ctx->folio_unlocked = false;

That should be a WARN_ON_ONCE.  And probably return an error?



Return-Path: <linux-fsdevel+bounces-68059-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4750C525D4
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 14:02:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF48D3BDF78
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Nov 2025 12:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 435A432BF20;
	Wed, 12 Nov 2025 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nqcgdMv0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDFB274FF5;
	Wed, 12 Nov 2025 12:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762952035; cv=none; b=LZopOrEOl3Mjcw/m7r25mhFEjzbR+DMXJO+TdPPv7a8eTanWHeOh8mZgMC9Ysxq9OQAsnMztDz6jCE0+c3sl5elOaGgnjgoIXjX4N5kwS0byllIajKntxTblS4VIKRcY32d8M2ZwSrtrGn9u8po2dcTPBdLGQAFtGXSL65TtgXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762952035; c=relaxed/simple;
	bh=z8S/99uZskvY300XNWmpm8V4inQtKLtvvDWMbV1GgMg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2uirJy6CoUzh16OntagfIatI6bvAtNq8c9/lGEsY4tge+ZCiiReucOqSH4sUo6QtWqWLvRaGUr6RqU18Yl9dJebQ5eGoxYdogZ0sKw/LZwilLrbcG+Kp1tCdtm47uTRpu2Y/7svnGmr4RzLH+EwRAm27SbSyQFOLof7SU9Ikbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nqcgdMv0; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=T662K4QHEyU3kT05O5jxYs9Et2+lOD9+Rx0jTzI/Mmo=; b=nqcgdMv0WGGF5JfsxULCwyeTzV
	gJdSBWl5tNlG4Or1d20Ouqydt1cgo+vSI3HJZUiwQ0SNNVEf5xKQ8pHqbFlzr5LE0b1R6RndwMZ9Z
	ySswK1pRwFm6K/mjc1cGHQDyuUoMS1W6sgVt/6jNK+y1RuM8d0YgScGOfsJsV3SKF17wLUlQvGFgx
	8MzCYu6G67Z7c1fyxnw6DxdPmfWeQkGirF13QuUbwBA88azQ3996l9YGZBFBHlSIs7QZSc7sJS9NB
	sg9ACpNu6+E2MocoNlyBiblo4VOiHItaz3AtII1av1E6RmEfHyA3i701Q6xSpRTILuSEOgWLGCgg9
	bZ9VfE8A==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJAMA-00000008nxp-3eqP;
	Wed, 12 Nov 2025 12:53:50 +0000
Date: Wed, 12 Nov 2025 04:53:50 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Brian Foster <bfoster@redhat.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org
Subject: Re: [PATCH] iomap: replace folio_batch allocation with stack
 allocation
Message-ID: <aRSDXpcrs7fZ_ggO@infradead.org>
References: <20251111175047.321869-1-bfoster@redhat.com>
 <aRRHzBlw6pc3cQjr@infradead.org>
 <aRR_FdE96gzkskqP@bfoster>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRR_FdE96gzkskqP@bfoster>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Wed, Nov 12, 2025 at 07:35:33AM -0500, Brian Foster wrote:
> Hmm.. well I never really loved the flag return (or the end return), but
> I wanted to make the iomap helper more consistent with the underlying
> filemap helper because I think that reduces unnecessary complexity.

Probably.  But the weird filemap (in general, not just the helper)
calling convention of using page indices and non-inclusive ends doesn't
really help with making it useful for higher level code.

> I
> suppose we could also make the flags an out param and either return void
> or just pass through the filemap helper return (i.e. folio count)...

That would seem more logical to me.  Besides not really liking the new
convention overly much (but that's a minor nitpick) my main issue was
that this was hidden in a functional change without any explanation.



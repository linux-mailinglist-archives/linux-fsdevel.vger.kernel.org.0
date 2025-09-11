Return-Path: <linux-fsdevel+bounces-60930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECB8B52FED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 13:18:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE560A03AED
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Sep 2025 11:18:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC92A3168EB;
	Thu, 11 Sep 2025 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2+nGcFOB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A310124678D;
	Thu, 11 Sep 2025 11:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757589456; cv=none; b=PaPrwyHux8UJBmV6x7+pH53AbkJidstxSF4Kdx4QkYyOOmxmGgBO9BME8RcmAJtuxrfR2aLhyruBVH9ljWVUmioig81VGc+F+/Uwh0ZKObkVkAprsS06nRhsvbSap9mSwdntgAYt0kjX7IMYtwtYtMguugQDL1YOu4cbA69Jr+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757589456; c=relaxed/simple;
	bh=vfGXVaqu0swOCJmHrVJLpbxno+o7l0HQyhR2WxAtREc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fa2oL2MbGnYCahE8BdR8FbDNaTj34kr2wom76ly56RLFlg8JT53WE1BeD/pgfSs1cuq6IMOP8AVI3A6HVCnek+gzXmz0rgGF5ozORvRIBjhGGpS48fwYSUt9J9+Y7gmyI+My+szPNxoi4FKvdfmJPFR4DfN93h1n13wCVxFSgY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2+nGcFOB; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=zX47EPqydYHCnkHlLyH3JGNBE1Vs50KadH8YraGMMCo=; b=2+nGcFOB3epkrdhzWi+zsxLEXj
	qebY1KT7iD0tt0MCgQXYA3ZydhbfNobmyanr20RHm0Gla1BYiAVAR7nZlk+OswA7r5uyJBKGSwOT5
	kj3GfTQADn3hktoAcarvJaF2GsEtxaXA4YfqOqU5r+Kdu4vCPeZustQ8Y9As5n72xu554AdA5z9BR
	ZUej/ginO0n/BhvXewmHaJCbiJ4liDXKSLfiLtGwOtk8fSY/GsTOL0sD7dhSAvidktKanV2khQbsu
	SQvXFr8gWeqac1vSvwBjRZRXWptnWOqUdP9mPvapE2fswoa9uK50VOIBSp5hTAIsZLp+dpoppphZu
	H/iKgqxg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uwfIz-00000002cR9-3hYI;
	Thu, 11 Sep 2025 11:17:33 +0000
Date: Thu, 11 Sep 2025 04:17:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, miklos@szeredi.hu, hch@infradead.org,
	djwong@kernel.org, hsiangkao@linux.alibaba.com,
	linux-block@vger.kernel.org, gfs2@lists.linux.dev,
	linux-fsdevel@vger.kernel.org, kernel-team@meta.com,
	linux-xfs@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 10/16] iomap: make iomap_read_folio_ctx->folio_owned
 internal
Message-ID: <aMKvzUOAzZRBDior@infradead.org>
References: <20250908185122.3199171-1-joannelkoong@gmail.com>
 <20250908185122.3199171-11-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908185122.3199171-11-joannelkoong@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Sep 08, 2025 at 11:51:16AM -0700, Joanne Koong wrote:
> struct iomap_read_folio_ctx will be made a public interface when
> read/readahead takes in caller-provided callbacks.
> 
> To make the interface simpler for end users, keep track of the folio
> ownership state internally instead of exposing it in struct
> iomap_read_folio_ctx.

This looks fine, but can we merge this with the patch renaming the
flag, please?  Otherwise the previous rename is just pointless churn.



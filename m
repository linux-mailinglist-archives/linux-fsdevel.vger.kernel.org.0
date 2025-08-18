Return-Path: <linux-fsdevel+bounces-58184-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78B6BB2ABEA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 16:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5621B64908
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Aug 2025 14:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924022264B0;
	Mon, 18 Aug 2025 14:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hmXyoWp3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC6B35A28B;
	Mon, 18 Aug 2025 14:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755528697; cv=none; b=AZ5EhCu6ucSL4VhZ42wuzBaBrbwGkksrymsNMCGXn7saiPrqqWf2GLmNimHi8bWf6aRVxJ0jFuAxWR6C1CxLVWYKf6amJQs7uONAqJKMs6PcKYwLTlh4qstnUdGbbqxzlGYmrU87PafwiL5IrHskQkWak4xzOiBOpAGC6kT7NBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755528697; c=relaxed/simple;
	bh=J9W82V7pDbRRWVA2gCXDtrrxh1x5Srvd2owkcxdzPTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TqOE8Tbi9d6l6YlQ68AMm1mAZ7/ASi7a53lgMb/djglYW42QkE2cz1B5ng030qSIlsuFF8D4INvj4BTncIAdASDwpgqixsBrl8eR5NfxenNZCXlimKcyZNbLuWjRxOEJE4K7I2CVcucoUIMmFN38Rh03bJNELz74QU8Z0o4j/S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hmXyoWp3; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=f1rsR35vE7A3GkLJX1oiWmc9qgVicp22B+KD/R67PSw=; b=hmXyoWp3uint+CRKl+FaM2SirR
	ioOKLK4/uagWSNSE1V7LQ0vj2/XbiVdQvrOOXc1mDsCeJGBgS0jBf3cLkoQqpoz/ll12jV1178aob
	ah1tQaNUczGVHkv5ueeVGiDIGxUK7ZMYQYOzGUpZgaQJiS2mkmcLF0xQQghDcTy/WljNLDePdwo0f
	/i4DxamKsca3SvY12xrVQzJvaVw9VgpWUDKZPsoV3QqIOPX8H4hiye+kE2oZbD65/ApH3QMFWLtMP
	xSkl62X/ZslgX/5CgGPcTLhTCTPgBeOUICRWF0d+EjSubspp8umLtnTdQylYCQLfibSX3FQfzk1z3
	5pa71xQg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uo1Cv-00000007P2t-1xkr;
	Mon, 18 Aug 2025 14:51:33 +0000
Date: Mon, 18 Aug 2025 15:51:33 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Trond Myklebust <trondmy@kernel.org>
Cc: Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>
Subject: Re: [PATCH v3 1/2] filemap: Add a helper for filesystems
 implementing dropbehind
Message-ID: <aKM99bjgILBwRQus@casper.infradead.org>
References: <cover.1755527537.git.trond.myklebust@hammerspace.com>
 <ba478422e240f18eb9331e16c1d67d309b5a72cd.1755527537.git.trond.myklebust@hammerspace.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba478422e240f18eb9331e16c1d67d309b5a72cd.1755527537.git.trond.myklebust@hammerspace.com>

On Mon, Aug 18, 2025 at 07:39:49AM -0700, Trond Myklebust wrote:
> +void folio_end_dropbehind(struct folio *folio)
> +{
> +	filemap_end_dropbehind_write(folio);
> +}
> +EXPORT_SYMBOL(folio_end_dropbehind);

Why not just export filemap_end_dropbehind_write()?


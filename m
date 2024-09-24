Return-Path: <linux-fsdevel+bounces-29999-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 072E4984BE2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 22:00:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA0272819EE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Sep 2024 20:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40C0512D773;
	Tue, 24 Sep 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="nyhNgCwR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CF5537F8;
	Tue, 24 Sep 2024 20:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727208038; cv=none; b=fAHY8UPLYXiU/j70OPiL4i2PqKonqgl5Tybh+NKEjDpsiutZLOJH42FIb8gDaJhHKOh+Ue5frbZemRt52ZErf5cynTzSZYD6TZa9jXHEg2YwTf9nU7c5fVPE+iZtC+9Xq6kCHPKsM/jSTD+pZs/s0RycjCrLNGTHz9SVb4SqJEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727208038; c=relaxed/simple;
	bh=r3jCueu3tNkyyYeljUq/cBhanxoO+tWfQPoQ5TEuNk0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bl4gcfoeTNohuLCby+vG/ZC4r19fLWx8gmZaF01XfVIb7peEccYzVZe9IZe45OWxAUbS8XerOK9VGcByuFvtutwM5YU8ibdHcpbo/gSF9IXX76LMjlcfHsdEk+EoMJ3oyuCnvbECiiMmIfX0IsBT+Ig/ZVJoqoLR20VJeaObo7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=nyhNgCwR; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=snNgfTx7s33zjptHv6qzP7dNvGpeRub9UFTlzhAZfLY=; b=nyhNgCwRkNYRKIUh48RFKKy5G3
	lTbRKYsgdJeBD7UNIc1wkAHEA5cNTt5vN98e+RfVGdT8PdmBkcpdAApmAuJkwYGLsWHslDJqCMBYR
	P2V8H8B0/05ccqienpR1WTqZxIv9/fa0gNemXQP23131nW4o/14bLkNkdloVl4FrnicrFf1FycZ3G
	AKBmkARRn6IISPWYPx9z9+J1hD3O5BwbbU7M01P3kK/pYxJ1rfp9VJcRP/62ifnfitMP+4rbFXa89
	f/apHV9eJo1ke7psHXsYewYcQPyXyd8GlFmvIVNPAULb5kXGauyY0zzqBo7PbO1hSFokIoxIlzna8
	V32FSZ+g==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1stBhz-00000002LGX-0Pr9;
	Tue, 24 Sep 2024 20:00:27 +0000
Date: Tue, 24 Sep 2024 21:00:26 +0100
From: Matthew Wilcox <willy@infradead.org>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	mcgrof@kernel.org, gost.dev@samsung.com, akpm@linux-foundation.org,
	Christian Brauner <brauner@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH 0/2] add block size > page size support to ramfs
Message-ID: <ZvMaWrXkgZ9ZHKfS@casper.infradead.org>
References: <20240924192351.74728-1-kernel@pankajraghav.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924192351.74728-1-kernel@pankajraghav.com>

On Tue, Sep 24, 2024 at 09:23:49PM +0200, Pankaj Raghav (Samsung) wrote:
> Add block size > page size to ramfs as we support minimum folio order
> allocation in the page cache. The changes are very minimal, and this is
> also a nice way to stress test just the page cache changes for minimum
> folio order.

I don't really see the point of upstreaming this.  I'm sure it was
useful for your testing.  And splitting the patch in two makes no sense
to me; the combined patch is not large.

> Pankaj Raghav (2):
>   ramfs: add blocksize mount option
>   ramfs: enable block size > page size
> 
>  fs/ramfs/inode.c | 27 +++++++++++++++++++++++++--
>  1 file changed, 25 insertions(+), 2 deletions(-)


Return-Path: <linux-fsdevel+bounces-45636-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72CF8A7A2F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 14:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C735B1895308
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Apr 2025 12:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B82A24E017;
	Thu,  3 Apr 2025 12:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="K6kQ3y70"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 140D724C67F;
	Thu,  3 Apr 2025 12:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743683756; cv=none; b=FoyNTDYMGsTwwM1Eeg+/DKAztHaVVrPBVtD2/2pwLZaCW75gH2gRaQkLa5a8jiefZSWHijZbK0kYxZ5IVySR/rikNo4ybCOoNIHt78F1Apzf8+bOp8r5l5CXq2MOIYvFDR3OuhoJKF2syyZE29qhBpxlVvwog3oeRhlUEmNhA60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743683756; c=relaxed/simple;
	bh=29h6ynhQoLV2ryb2vuSFSRs6a8cTN7EUJfWzhJwhs8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e2THAoTjOB9mQ/FqkuSfp8RFyYPq98XuUDyicEkPIqfSQQa+d9WCkewwIESKC/ZH/gLivj3wwrlNUXI9pRd2G1sM/TGDBHhgqwUPGVSm7cIPuj+AosKPfuPkvYVuQEF9HmRxYtfkwM/H2OOQRYzsVK50Aro4u+kpJ62Fp8Rn0cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=K6kQ3y70; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XDDalKK9puNdBAK9PyYynmv0MinuUp52rgxCW3hxBWc=; b=K6kQ3y70lA/NdDae9MJcVXv6Yu
	NLre97MUDStqPnJkk2EoG4BdybojZBDjdtjyFeobvfr1Fu7DgAu/01uZU4c/ax9MHpk3RfJIHQAof
	hEdndTL22bk92VKiovyMBBDanZVylU0nSM6H2riE36ki3wofTnw7fo7CsI8j5RJxqNaVr3IaFK3w8
	zj3F7mmfAInrZfb+GUEIq1beASnQqzUT4kVWkG90klr0prNFXE6d4P8oFfpzvtk3AjauH77rU2iVO
	Xie3ifj30OL72dg6JSz6PNN2SrB5NTYOvFrOQBrehq+3E+nxdPgKdbB1i2aeKVrXoqdj98cUhkDeX
	4S3xwYcQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0JnQ-0000000CksR-3LrO;
	Thu, 03 Apr 2025 12:35:49 +0000
Date: Thu, 3 Apr 2025 13:35:48 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Qu Wenruo <quwenruo.btrfs@gmx.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	linux-btrfs <linux-btrfs@vger.kernel.org>,
	vivek.kasireddy@intel.com,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: Large folios and filemap_get_folios_contig()
Message-ID: <Z-6ApNtjw9yvAGc4@casper.infradead.org>
References: <b714e4de-2583-4035-b829-72cfb5eb6fc6@gmx.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b714e4de-2583-4035-b829-72cfb5eb6fc6@gmx.com>

On Thu, Apr 03, 2025 at 08:06:53PM +1030, Qu Wenruo wrote:
> Recently I hit a bug when developing the large folios support for btrfs.
> 
> That we call filemap_get_folios_contig(), then lock each returned folio.
> (We also have a case where we unlock each returned folio)
> 
> However since a large folio can be returned several times in the batch,
> this obviously makes a deadlock, as btrfs is trying to lock the same
> folio more than once.

Sorry, what?  A large folio should only be returned once.  xas_next()
moves to the next folio.  How is it possible that
filemap_get_folios_contig() returns the same folio more than once?

> Then I looked into the caller of filemap_get_folios_contig() inside
> mm/gup, and it indeed does the correct skip.

... that code looks wrong to me.



Return-Path: <linux-fsdevel+bounces-36918-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0059EAFC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 12:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2048F163506
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2024 11:21:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5DD19DF9A;
	Tue, 10 Dec 2024 11:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="zcjUZusi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9FE1E515;
	Tue, 10 Dec 2024 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733829689; cv=none; b=HXIILIrklzlLo8z51Og+orpcF5kiNLCS7ge53d34LzJ5aBrHsxHO188n+8LEiIdYTwXR3xYnMcN+cXIKb0j0h1szVJWP4TcmfO1iVc1VsGELfNuR3qRVhH8+jIC32xOS64l1y8QYKuFKDyJLz32aeORnT2vtd+HBAY3QBBHRR+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733829689; c=relaxed/simple;
	bh=iTR+8wisRZyyIigRcOgC3g++yHHinM68/qr66b85d8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L5o2g+dd0Kq7xaVJD/2lKibHemBkfWewrvN9KSxJYepPS+b/EsOWcD07iW6Dt5H5PRM0ZZmIwvpSI/Nq9UgCS86eZEUATYt+gr7iEGnIGqYpMEd4yY8BDQGsojBzylcCTBZ9ROTEZxWQLVWQoldRE47w+UAi2DEyGDsrpvD8P68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=zcjUZusi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NT/3a3rEZgq3xUYsqnnRVuevWBBPFET2HIdWrD8NKYc=; b=zcjUZusi19WyAixdgpsul6WCTi
	A8CECH8hTCtlczdv4N3164EW1/F945LrspENuMONS9V9CaiW9GxtYe1wR3mLr0qj859wfI03wFK17
	pysYfdGtaEZ1rgTiIk0lhbHyp4JMjjnxohpZPIYGFuBj9XniGualL4kcOozgiIG+JLW+MEUJPbW3/
	NoC34YcRQpCRhFb2Hx30s2DDKr4g2OrpwyBb4UyygwZTgaJvcJvulc4GHxi+rhQe3IiD149UQ0uQc
	g0fCdZoCXf1CF0Ex/TrMbGKuMMXn86vY3x+fIgRI44X5QLuf9ck4T9tYaz/eu6r2dGgkbRv8SxdDM
	TdyPxIPg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tKyIx-0000000BIcC-02SU;
	Tue, 10 Dec 2024 11:21:27 +0000
Date: Tue, 10 Dec 2024 03:21:26 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, willy@infradead.org,
	kirill@shutemov.name, bfoster@redhat.com
Subject: Re: [PATCH 06/12] mm/truncate: add folio_unmap_invalidate() helper
Message-ID: <Z1gkNiD2wJbAdOfr@infradead.org>
References: <20241203153232.92224-2-axboe@kernel.dk>
 <20241203153232.92224-8-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203153232.92224-8-axboe@kernel.dk>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Dec 03, 2024 at 08:31:42AM -0700, Jens Axboe wrote:
> Add a folio_unmap_invalidate() helper, which unmaps and invalidates a
> given folio. The caller must already have locked the folio. Use this
> new helper in invalidate_inode_pages2_range(), rather than duplicate
> the code there.

This new helper ends up the only caller of invalidate_complete_folio2,
so you might as well merge the two instead of having yet another
invalidate/unmap helper, which are getting impossible to track of.

Also it is only used in mm/, so add the prototype to mm/internal.h
insead of the public pagemap.h.  And a little comment what the function
does would be pretty useful as well.

> In preparation for using this elsewhere as well, have it take a gfp_t
> mask rather than assume GFP_KERNEL is the right choice. This bubbles
> back to invalidate_complete_folio2() as well.

Looking at the callers the gfp_t looks a bit odd to me, as it is
either GFP_KERNEL or 0 which is a valid but rather unusuable gfp_t
value, but I guess this comes form filemap_release_folio which
works similarly.



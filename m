Return-Path: <linux-fsdevel+bounces-20889-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CECB8FA91C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 06:20:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418EB1F266AC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jun 2024 04:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69FA3139CFA;
	Tue,  4 Jun 2024 04:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="N0wGy2DK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7EB48C1D
	for <linux-fsdevel@vger.kernel.org>; Tue,  4 Jun 2024 04:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717474812; cv=none; b=f2hqv7I/mTRETeqkDri+ByaeDKEEdxHxRFP9S5MGdtaoQcBvPvflWatZ6WpP88/m2AB4EgX2cBQhgIptfehIhBZ6N8MZA/7/UXR6KJD37dPDZb9if6o/pHKFIoJBHPe0yBhx4NubDW7laHWklLa7C7lQDXfQL3i16et8Y8Ah4lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717474812; c=relaxed/simple;
	bh=1A95ruA1cMYPQ92PilD6oxvXSdGNqvEZ8FdBHWKRNOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1PitKj4q5t9E156c64NYw3jeOFgKzDUJDhNrHVGk3JExffXYW9dHI2W762ErUa5UtWxJwXzBPmlZBdtyvpeQmlumAMtukPdDlxvZmpeDUu874VSTGf/7wDlHYCN98DSuVAT4pySWe84W3ddXYQDCmZesFUsy0FcGorKOOmr+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=N0wGy2DK; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sT+cO72nxMMP/SxstIKj9+I1NsF3VgrkB0TAyIWSGKw=; b=N0wGy2DKjjGjlS+bVpn8ihFQUX
	BdVsOOMCwuF0fYw0GasnMa+Da7Bv+JPbb0+NQwx1P13gFAf1tGCEea3fpfROiDiYw3yuSANP6avau
	FaQ3sVRXZrKSL9aY+pWLfIRvVDQDBddiP0ROVnbUVy23N36cwoPMh/KAi7lFpi2RfT7EuNgDtJf99
	E2q7j5p8+brL/e8R/Jy0EmPBfKoedmxMV1DLQRqz/m+YaysD9sQeFOznNnW7teuJG389Orco0UKnh
	IASWFPCI3qbuCu+Gj+DWESzaXQ3U7XqUdHTtJl4t2Ec1X6SPskGZ5yPE7OSvn5+YUptZ60c7jG6BG
	AGHEQ1eA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sELec-000000019Y3-2MUO;
	Tue, 04 Jun 2024 04:20:10 +0000
Date: Mon, 3 Jun 2024 21:20:10 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Bernd Schubert <bschubert@ddn.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	Christoph Hellwig <hch@infradead.org>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Amir Goldstein <amir73il@gmail.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bernd.schubert@fastmail.fm" <bernd.schubert@fastmail.fm>,
	Andrew Morton <akpm@linux-foundation.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH RFC v2 06/19] Add a vmalloc_node_user function
Message-ID: <Zl6V-qsxKTOBS860@infradead.org>
References: <20240529-fuse-uring-for-6-9-rfc2-out-v1-0-d149476b1d65@ddn.com>
 <20240529-fuse-uring-for-6-9-rfc2-out-v1-6-d149476b1d65@ddn.com>
 <ZlnW8UFrGmY-kgoV@infradead.org>
 <sxnfn6u4szyly7yu54pyhtg44qe3hlwjgok4xw3a5mr3r2vrwb@3lecpeavc2os>
 <984577b6-e23d-4eec-a5da-214c5b3572ba@ddn.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <984577b6-e23d-4eec-a5da-214c5b3572ba@ddn.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Mon, Jun 03, 2024 at 07:24:03PM +0000, Bernd Schubert wrote:
> void *vmalloc_node(unsigned long size, int node)
> {
>         return __vmalloc_node(size, 1, GFP_KERNEL, node,
>                         __builtin_return_address(0));
> }
> 
> 
> 
> 
> If we wanted to avoid another export, shouldn't we better rename
> vmalloc_user to vmalloc_node_user, add the node argument and change
> all callers?
> 
> Anyway, I will send the current patch separately to linux-mm and will ask
> if it can get merged before the fuse patches.

Well, the GFP flags exist to avoid needing a gazillion of variants of
everything build around the page allocator.  For vmalloc we can't, as
Kent rightly said, support GFP_NOFS and GFP_NOIO and need to use the
scopes instead, and we should warn about that (which __vmalloc doesn't
and could use some fixes for).



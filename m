Return-Path: <linux-fsdevel+bounces-65106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EE247BFC861
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 16:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 874E03514FF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Oct 2025 14:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B115934C15C;
	Wed, 22 Oct 2025 14:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="jODtkpJk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3FDD34C155
	for <linux-fsdevel@vger.kernel.org>; Wed, 22 Oct 2025 14:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143013; cv=none; b=XTmGJf14kBYWl3cjptvS0qTPFSlCGUS8/QZTkpg5VEx7riMqkpTamXJYX3XT1A++nkghhRHBPR6BeHY4c01YPzAf9eiUT6kfaUQPNtEeLudTnKp3Vi5MKDgDHR9C/OT1IKZTRFyNLp2mGyMwTyhIXcW7Obs1GBo2VgqDwVVuuEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143013; c=relaxed/simple;
	bh=BXbtN2v+8Pnm026y/5JZIdZbNLt1pmFAnwtqv3iUwp8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o3Fy7YxnvQku8SUXM5shzo4lhTL0DGD7WiCIJW1jcFW1h1lH8bi8NtSATeNXqoW9+31NX4mI4QKiV6GDDFfaxij2brEbt+GnbtW8QUlClfeQilFjtDfEUeSzRdRc8PuKU5Z2xL82MEABsPP1qgT5YN40nfCAe1M6pJ9oA33P6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=jODtkpJk; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=8hEdEufKYDlpmRclgwdd1f0mWWuBZqislf9kgj2GKYM=; b=jODtkpJkkWgioRSQsFrDCrEmXF
	ag0RXtocfkrzgRIZizkNDfQ9dco/iRIcm0ZIfTmNAtQBKbLKwSgOHqFK0Rrj70flsQmfLawIVEKMi
	GKF/ZKwhyVIf7dRV4SEol0V8X80L9hQ79yjUyKMvTzf1dXJBDZrT5v70IuBLjVWzoJunT1lOHCp1i
	gqMibQMl46mvkWg7WZ4aQc73I9p/OdC3DbaX6JkjjHJPzD5Kfpj0UFuX74XclOB9r9HVUuudkegUq
	5f7hJliVsGVV3abCVspk0+UbdxxLiXcn+yToJdnS5GiC+9cbw8UZCZDPE/0XDsIpURBOyQxLQfuJc
	s6ox3pUA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZkI-00000007lOE-1nE5;
	Wed, 22 Oct 2025 14:23:23 +0000
Date: Wed, 22 Oct 2025 15:23:22 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Joanne Koong <joannelkoong@gmail.com>
Cc: brauner@kernel.org, djwong@kernel.org, hch@infradead.org,
	bfoster@redhat.com, linux-fsdevel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH v2 3/8] iomap: optimize pending async writeback accounting
Message-ID: <aPjo2om1maIKdCEE@casper.infradead.org>
References: <20251021164353.3854086-1-joannelkoong@gmail.com>
 <20251021164353.3854086-4-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021164353.3854086-4-joannelkoong@gmail.com>

On Tue, Oct 21, 2025 at 09:43:47AM -0700, Joanne Koong wrote:
>  static int iomap_writeback_range(struct iomap_writepage_ctx *wpc,
>  		struct folio *folio, u64 pos, u32 rlen, u64 end_pos,
> -		bool *wb_pending)
> +		unsigned *bytes_pending)

This makes me nervous.  You're essentially saying "we'll never support
a folio larger than 2GiB" and I disagree.  I think for it to become a
practical reality to cache files in 4GiB or larger chunks, we'll need
to see about five more doublings in I/O bandwidth.  Looking at the
progression of PCIe recently that's only about 15 years out.

I'd recommend using size_t here to match folio_size().



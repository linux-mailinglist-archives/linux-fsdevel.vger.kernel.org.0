Return-Path: <linux-fsdevel+bounces-51233-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D28AD4C25
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 08:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFE218986D9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Jun 2025 06:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B2522D9EA;
	Wed, 11 Jun 2025 06:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xUZVpeuq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B42F1D89FD;
	Wed, 11 Jun 2025 06:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749625055; cv=none; b=pL8+fGa0W9WsIQvDf9AWOgaA8aKiXlBrglx5xK6PXRrj5cFIHn6/8TtykQ9AlKYNalunX3NMTGt2EqQQLtPp/jSDj1ghiAxlvbhkUAPg1p/lJzwGN79eU5GaNgGyVbUrN/4KYEM/IIcE+B/DmmJRj/E0sYd54gQ0zzTo+Wb8DTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749625055; c=relaxed/simple;
	bh=iTvPrdxsLTgq9OW4OYumyHmWPPRUmKZHcH1+dMoShWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuheRhH+RFA57Y1Vp1yVm65WLdH1wa6Bq2YNZ9/pVuYWVCz6xBSh7UuJm9cemMAFsob9cajN/Q1HNlqcE2PaXO1yOHFu77BkcJSdiygiNNAGTigflRmj8YTe7nQfB89BilwPhlfznx3il01x/q6Ye8FmWlLkBXPENBhRsvgwzZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=xUZVpeuq; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sMFeeB2Dbw5/O7ZYak8/g+wqndrxD4CXLJoYtiEdRTM=; b=xUZVpeuq12ugfHxzsCL8l9NrYN
	yosVwPldiPGTgKZaxocUBhVZy3lK6m5XKRl5ZU+Smn11j25kR8Ld1a4wdOhEVIUD2M2LkfbZDERf8
	uaRzzUrHBVy9jXWdqaewtK7sK4NdhxFqbrj7MFrfXXyPGbtgEQMpWYpA2UEjf7KjYu3pBw+L24BtI
	3Y5VM95PaHKJ3CW5tUhOLolSXcvzN98uqxnoLi5PBJdhNleDpNmeqSBKYoGgpW/ewXzvNX2bIHEVN
	1La/UiDMHCI8n75PhECR9nr1NDxnq8cLxmr8IdDfCnuuoW+ZHK9j62Kwmg6sjruURS1DkXLxE+XUq
	M07fDDvA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPFOv-000000093Ez-2nbu;
	Wed, 11 Jun 2025 06:57:33 +0000
Date: Tue, 10 Jun 2025 23:57:33 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Mike Snitzer <snitzer@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	linux-nfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 1/6] NFSD: add the ability to enable use of RWF_DONTCACHE
 for all IO
Message-ID: <aEko3e_kpY-fA35R@infradead.org>
References: <20250610205737.63343-1-snitzer@kernel.org>
 <20250610205737.63343-2-snitzer@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250610205737.63343-2-snitzer@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 10, 2025 at 04:57:32PM -0400, Mike Snitzer wrote:
> Add 'enable-dontcache' to NFSD's debugfs interface so that: Any data
> read or written by NFSD will either not be cached (thanks to O_DIRECT)
> or will be removed from the page cache upon completion (DONTCACHE).
> 
> enable-dontcache is 0 by default.  It may be enabled with:
>   echo 1 > /sys/kernel/debug/nfsd/enable-dontcache

Having this as a global debug-only interface feels a bit odd.



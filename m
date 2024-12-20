Return-Path: <linux-fsdevel+bounces-37965-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EAC9F9614
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 17:11:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 272A1160AAD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Dec 2024 16:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5D1219A79;
	Fri, 20 Dec 2024 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="erPLS0xt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF7238DEC;
	Fri, 20 Dec 2024 16:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734711093; cv=none; b=f8QixIXf0Px/g1GtZaUE9DVbLDeiVcigE2XUOGhGM9vhR4SQBzQCbFNci0WPfgPLZBvTDJd16xWtx6L26hkGgFt4OIZXBXtu1AMvHkVCMczDCIuw9SqUbnNBT8YvDYW1l15L4V+Uq3QZNOmmEvLHh5DQWiUS05UjBohjov5r820=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734711093; c=relaxed/simple;
	bh=1JLZ7JaQvjjooYMwgBAFnFazmzE/zzom0QgAi+sydBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KMCIqnE9kLI201fapQBGJVaIKpihuhFLP80IVPYqgXIvH/a/ZbbFf86XgGm6Ubgv5VZumi+DPybK/uFrp+pklX/URpGFbRA6PsYS7wZyMRNNJ3kTASc5E1jxQi2Cbs7FDNSuF81bXxjUkYD8nhJ4eemLynPeEO60xa5bw0gG3kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=erPLS0xt; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lSGrWsOJh45MwgvU55jd3M5ZYV1+3TkJv5oS9CUuezA=; b=erPLS0xtIojor1kliIEBkRSayV
	qgxGZovAszKaBoOn/Ew5bbTyXCxZvsSMbQlyqtLyq44+dxAW7ULIO2szxauWLDX1AMuHqrBeR41Fb
	mbLSqA4pH3aQJ5i0GpTb/e2jayTvbHX0g85znP27VK1lvBsPIKnwUl3NGQSWa4ToWxwoqgKGASiL+
	ah6tny7DLXUSQfSY6Etrcn4dVLao/L1oKOcrZHqp9uimls7rHWEKQlyKx2PuKuqVJ/dDaMhBsCcYi
	LM+q4NR8EV8HJlGF2G40sAOshzUYLmyenWcTv09DmvFAtJoB+XWDeGbwbny3Xkd8Egpsslr6f/RFU
	TdbaqDyw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tOfb5-00000001Y1s-3riU;
	Fri, 20 Dec 2024 16:11:27 +0000
Date: Fri, 20 Dec 2024 16:11:27 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, hannes@cmpxchg.org,
	clm@meta.com, linux-kernel@vger.kernel.org, kirill@shutemov.name,
	bfoster@redhat.com,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 01/12] mm/filemap: change filemap_create_folio() to take
 a struct kiocb
Message-ID: <Z2WXL31t_MAsYy8x@casper.infradead.org>
References: <20241220154831.1086649-1-axboe@kernel.dk>
 <20241220154831.1086649-2-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220154831.1086649-2-axboe@kernel.dk>

On Fri, Dec 20, 2024 at 08:47:39AM -0700, Jens Axboe wrote:
> Rather than pass in both the file and position directly from the kiocb,
> just take a struct kiocb instead. With the kiocb being passed in, skip
> passing in the address_space separately as well. While doing so, move the
> ki_flags checking into filemap_create_folio() as well. In preparation for
> actually needing the kiocb in the function.
> 
> No functional changes in this patch.
> 
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Signed-off-by: Jens Axboe <axboe@kernel.dk>

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>


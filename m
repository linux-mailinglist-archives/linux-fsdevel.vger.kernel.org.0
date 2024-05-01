Return-Path: <linux-fsdevel+bounces-18436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 918BB8B8E1D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 18:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA7E282A3E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 16:23:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8EA130A7B;
	Wed,  1 May 2024 16:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="bPDmPEsS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA4C12FF87
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 May 2024 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714580457; cv=none; b=VyoEgiF/ZzRQ7aSpyhTVTOn0Fc9bZG/dgfThzP9g8Mu1kkexf+FfkTU9FiW4D9eFKxI/UWwwy1c+O6IUgV7IV6lbNQaJB4vOYJeMS/c59Kd38oBGuqSmVQNEa26gTgTtMg7iPYqopE6lp1mTIdbNu7HodoZCXjuHIbIHcDtUt/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714580457; c=relaxed/simple;
	bh=M4NLCGkO57Q69B10NWAv2gh1jOAr2vdH3+VdUkGVs5Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GMmKuBjwXz0FHLue7RMi4YPFMn62jTQ2dF4hSS+KrHcuFtxT0fGYS250aZrWIsuiDSodjNhQoqOWd1TUzvG/3yXWWIJk5Ty8uYVl4b3E+SwgeI1yyzezxZrBbLjDq1xR76eqQ4R5rpQpuZqVQ4l2EEg5AgXa0RmVo2hkiKCqDKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=bPDmPEsS; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=Tjgf77IIk2561iTG74wh4geQMCuRRrs/zUp24uYddO8=; b=bPDmPEsS432TVrjl7ahve/ztF3
	fft9mZ5PVWO3PHU/a0bd23amDzVt3URh841Y07YZVGbMycRAYV+a9OF4dO3oCeMuRN2G+bOJLRp4v
	FUeiz3aF72WJdcg5AtFPMfllZnEt/1BpVMnhdh8vFj2eOWWXc3NoH8Dnza/lsnx+8zqfAb2m3kmNP
	O9rscKt1hUPSbOW3E6EbxuKT+OlTM/TEQIuPczRr5PEaXyDuF/r6ylVImBuaIwXbnWjKuGSn52Yla
	ywlI83lJFmCIIw+YxAifTIpVaOv5x+my6g45uRE+QFm4wwgTrIvq67i2j2jorZ6o539JsxH700EGE
	LuQ3vjJw==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s2ChR-0000000A7ac-2BM5;
	Wed, 01 May 2024 16:20:53 +0000
Date: Wed, 1 May 2024 09:20:52 -0700
From: Luis Chamberlain <mcgrof@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
	linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] XArray: Set the marks correctly when splitting an entry
Message-ID: <ZjJr5K5pmQSOzHuO@bombadil.infradead.org>
References: <20240501153120.4094530-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240501153120.4094530-1-willy@infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>

On Wed, May 01, 2024 at 04:31:18PM +0100, Matthew Wilcox (Oracle) wrote:
> If we created a new node to replace an entry which had search marks set,
> we were setting the search mark on every entry in that node.  That works
> fine when we're splitting to order 0, but when splitting to a larger
> order, we must not set the search marks on the sibling entries.
> 
> Reported-by: Luis Chamberlain <mcgrof@kernel.org>
> Link: https://lore.kernel.org/r/ZjFGCOYk3FK_zVy3@bombadil.infradead.org
> Fixes: c010d47f107f ("mm: thp: split huge page to any lower order pages")
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Thanks!

Tested-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis


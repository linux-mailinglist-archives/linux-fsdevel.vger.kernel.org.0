Return-Path: <linux-fsdevel+bounces-16766-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2A108A2442
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 05:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26B11B217C5
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Apr 2024 03:18:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260D114F7F;
	Fri, 12 Apr 2024 03:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gKsvZNoQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496D1DDC9
	for <linux-fsdevel@vger.kernel.org>; Fri, 12 Apr 2024 03:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712891885; cv=none; b=eyf7XvD2vP6kNvZEc0QtvsVa+etGqKuJQ6lIXOuXivs2bpiJtCejMhCauc0w6aDtveEyKyLshILSHqIbRUWiTm3w09gdD9n3NGwVjept+BmYO8OAcFNQkKHrwdpj2xHoIFPcv/hxmbFb3U63IEQ/enq6p3jXqHK+tDMNYlyzplA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712891885; c=relaxed/simple;
	bh=qv8vepORRhsQL31OJY79SsMKEB5JJ0vIIouuC+t3cmo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fP1FXTzh7q9prgDPtM4QmUlMnBHFWF6P36cZ60bqeLpoJIVaO/21te6qX6IJRqDfjeBTBbEK3oiuu83yaEeaxlEREE1WJs9mlw++GO+6KhQy/VJ6J+8H+Y4q1iFOFxTc5jHydBaG94o2kyuc0oEYqnTCiHt+nw3mCIoOYksxZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gKsvZNoQ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=NGHNEfNwPq0wTlQXXsUCHhOb4IS9TlCKr2ChArmFvL0=; b=gKsvZNoQ/xGKsyiRcJe5LvBEc5
	W3PqUJhIfX5ik4VpsNSukXOfqkr3mxbuhICmSTEunKWsT9yoDV1tOzFhLeI7QNe3qvTeIbbin2yk0
	GKWeRVmCtMDmSMYHwTDvCsFuvMJetVI53WPE2poe16vBjXALu3y/RZ7UE189+WG1jERBaVXNr6yo2
	WUCjhspvvre5O8rr8kLM1W9dCPbR4eWXUgKwv+IgsH9s5JlUOvFUTqDKt+myAHIizoIot4TdVXSWt
	fgpVtixX6GJqvaK9TISTNadcacxhxuog0erM/d0s4fNypJxpNrC0BBWaprUC7z8amepkcJ0gq80vw
	Wq75sRtg==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rv7QM-00000008I4m-3oLV;
	Fri, 12 Apr 2024 03:17:58 +0000
Date: Fri, 12 Apr 2024 04:17:58 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Kefeng Wang <wangkefeng.wang@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 2/2] mm: filemap: batch mm counter updating in
 filemap_map_pages()
Message-ID: <Zhin5gNVk8NHjxPP@casper.infradead.org>
References: <20240412025704.53245-1-wangkefeng.wang@huawei.com>
 <20240412025704.53245-3-wangkefeng.wang@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240412025704.53245-3-wangkefeng.wang@huawei.com>

On Fri, Apr 12, 2024 at 10:57:04AM +0800, Kefeng Wang wrote:
>  	} while ((folio = next_uptodate_folio(&xas, mapping, end_pgoff)) != NULL);
> +
> +	add_mm_counter(vma->vm_mm, mm_counter_file(folio), rss);

Can't folio be NULL here?


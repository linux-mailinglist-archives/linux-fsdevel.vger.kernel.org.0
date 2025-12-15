Return-Path: <linux-fsdevel+bounces-71346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B941FCBE478
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 15:28:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73930305AC70
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Dec 2025 14:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B11C346E58;
	Mon, 15 Dec 2025 14:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ij+j2+CX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B06013D3B3;
	Mon, 15 Dec 2025 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808548; cv=none; b=PudcgiwMkmLtT3u0XewOmbKOTanr/FdJTZIFe5+jzGNovjxtZWAIcph3ca3Tm/AXq/KUklndpf/CPceFHndtGuaeMCW7DUCUb5fUBNiq4nypyVEbF6XJO25ictlguF6eyYCwu2+Zr/j/fd+JkvYqPLGJ31wDeqZe6kQ7Mt+bK3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808548; c=relaxed/simple;
	bh=pW6jSedOkMn6mkazAaHdY9HukmfUZ+ZGOSKM8VAuQqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=doZZgGMAcV27siEO2NrkWZ4B7YGUSyqfOT4AwyhHdwRByjfDsucbdIbDVihsJMhbS6xcZSnJJb0hdza/bZkDdwXncq4mWqs7ck9+v7DaRtEO9QCMqol/j8F+iuHh1j1ySFen8wict+bg0OaHfisgpFwwS7h4SRgNG3eauZRmQaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ij+j2+CX; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1JOCBskt1hE4p1n7Rzhx9tz8mseOjMeyQqwwc4c8jDg=; b=ij+j2+CXlr1c+DXVR9pSCkJk09
	V3GJwrBK4pYYUPbnk0uEm0nSd4IvyUF8cLyfxNhQY5ZizJxNxRUXU5DyewzqCdbAeDx6cpAvzBPnV
	HghkM3vySMVL5SEwDYsbuTnF7C7RcNGXSVC3QL+OClSpkyRFxJJJJ+cJdESPTxfEcYjMnTwh6Vnjg
	V2tKXk/zcwTOxVd9uvM5ohyIGiu6EGC460Z0PFF+C9ZZuwTQIyARgNF2MG/TUaPOMFQH0Qv5diNi4
	qYTqvMEz5+3qMfRLo9cr2EDWTg62yU2O1xJ3cBbXW4Vh+Ft0ow7hUyv/qLjpNr6fd1cSnEMwia/PJ
	IllGppmA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vV9Sx-000000020VP-2z91;
	Mon, 15 Dec 2025 14:22:23 +0000
Date: Mon, 15 Dec 2025 14:22:23 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Luis Chamberlain <mcgrof@kernel.org>, linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	syzbot+4d3cc33ef7a77041efa6@syzkaller.appspotmail.com,
	syzbot+fdba5cca73fee92c69d6@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/readahead: read min folio constraints under
 invalidate lock
Message-ID: <aUAZn1ituYtbCEdd@casper.infradead.org>
References: <20251215141936.1045907-1-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251215141936.1045907-1-wangjinchao600@gmail.com>

On Mon, Dec 15, 2025 at 10:19:00PM +0800, Jinchao Wang wrote:
> page_cache_ra_order() and page_cache_ra_unbounded() read mapping minimum folio
> constraints before taking the invalidate lock, allowing concurrent changes to
> violate page cache invariants.
> 
> Move the lookups under filemap_invalidate_lock_shared() to ensure readahead
> allocations respect the mapping constraints.

Why are the mapping folio size constraints being changed?  They're
supposed to be set at inode instantiation and then never changed.


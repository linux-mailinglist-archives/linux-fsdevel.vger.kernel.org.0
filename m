Return-Path: <linux-fsdevel+bounces-7244-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 413E78233E8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 18:54:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4F05B21829
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jan 2024 17:54:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA9A1C680;
	Wed,  3 Jan 2024 17:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="L1kvXiEP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0C31C2A3;
	Wed,  3 Jan 2024 17:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=g3Q6A/OSBTzpvsA+ZueyJpCCrUPX6Gs2jbB2LOMyGZU=; b=L1kvXiEP+N+GxELX905cIpeDO/
	Fum/7I+llgkoF6au7+5q5lD7WYxqCxjWc3lxB10+2+oQTvnGvGRGQBspPKliCu3alSezpqXATdGrF
	YNWzJy1nz0yv7YC9tj9b7XKQvQ1YLphocwT/hY57otg/RVTsIBJj/yPZjBX6Kw5C2Z/V02yuxH3J/
	HK2qNkSLlarydo7UesLCYKwkF4LkpIC/IeklCIgKUcoPzmQ2Ij4UI+78N9tgDkZ7m+wmbZOdzrR8e
	wcN7B/uKTt6BZEUjw/gUYYjw/e0T9HYFGVjZbirAHs8MdhZctVx+ozf7UOu67ciQg5sjpIBfoDnYb
	nJ7p6cvg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rL5RH-00DG5A-Jb; Wed, 03 Jan 2024 17:53:59 +0000
Date: Wed, 3 Jan 2024 17:53:59 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hillf Danton <hdanton@sina.com>
Cc: Genes Lists <lists@sapience.com>, linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 6.6.8 stable: crash in folio_mark_dirty
Message-ID: <ZZWfN6ymZ50MjzuQ@casper.infradead.org>
References: <8bb29431064fc1f70a42edef75a8788dd4a0eecc.camel@sapience.com>
 <20231231012846.2355-1-hdanton@sina.com>
 <20240101015504.2446-1-hdanton@sina.com>
 <20240101113316.2595-1-hdanton@sina.com>
 <20240103104907.2657-1-hdanton@sina.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103104907.2657-1-hdanton@sina.com>

On Wed, Jan 03, 2024 at 06:49:07PM +0800, Hillf Danton wrote:
> On Mon, 1 Jan 2024 14:11:02 +0000 Matthew Wilcox
> > 
> > From an mm point of view, what is implicit is that truncate calls
> > unmap_mapping_folio -> unmap_mapping_range_tree ->
> > unmap_mapping_range_vma -> zap_page_range_single -> unmap_single_vma ->
> > unmap_page_range -> zap_p4d_range -> zap_pud_range -> zap_pmd_range ->
> > zap_pte_range -> pte_offset_map_lock()
> > 
> > So a truncate will take the page lock, then spin on the pte lock
> > until the racing munmap() has finished (ok, this was an exit(), not
> > a munmap(), but exit() does an implicit munmap()).
> > 
> But ptl fails to explain the warning reported, while the sequence in
> __block_commit_write()
> 
> 	mark_buffer_dirty();
> 	folio_mark_uptodate();
> 
> hints the warning is bogus.

The folio is locked when filesystems call __block_commit_write().

Nothing explains the reported warning, IMO.  Other than data corruption,
and I'm not sure that we've found the last data corrupter.


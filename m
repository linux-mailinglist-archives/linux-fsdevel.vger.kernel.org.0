Return-Path: <linux-fsdevel+bounces-7432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D443824B12
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 23:42:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D617C1F232B3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Jan 2024 22:42:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030932D021;
	Thu,  4 Jan 2024 22:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="TQZk5Zen"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286642CCAD;
	Thu,  4 Jan 2024 22:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KaEe4j2YqFtbEdXkete4TcSZkc6Zq8WOCZ/Wk+4hPjQ=; b=TQZk5Zen9UZsk8HJmdS/ge2mcZ
	DKG7C5jljUoCnAxOSxOfi/Dh0EGTGv8yKsIOxzJhI2pobAFPdujqXLrWH5oFQMfUWS+a0ZFsk65bk
	v5gE8gsUgLoh6F7PCghJzCh9LKCazVcQ1RlRf58TaFlMMdv/WN6NEteTaMokBM9Q3tKiKwIfyKj2M
	ylOg2P3mS5Ie0SLGptFNgzASbbXJUq0kOzLxSx2bEuTQU5xzIxbIT6Tv0GzgY94rGTnK5ouNWOA+Y
	xPVdPFBrVYEb70TAMm0o5EAy9psdfwwJclgeJ7GoS2iZMzO4Yj8BgWmz+cCzH9rNlOVrBis+6YMt2
	lLv4m3zA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1rLWPP-00GCek-RS; Thu, 04 Jan 2024 22:41:51 +0000
Date: Thu, 4 Jan 2024 22:41:51 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/5] buffer: Add kernel-doc for block_dirty_folio()
Message-ID: <ZZc0L9ANGS3z3n7c@casper.infradead.org>
References: <20240104163652.3705753-1-willy@infradead.org>
 <20240104163652.3705753-3-willy@infradead.org>
 <133cd73f-3080-4362-bc3e-ef4cc8880a20@infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <133cd73f-3080-4362-bc3e-ef4cc8880a20@infradead.org>

On Thu, Jan 04, 2024 at 01:06:10PM -0800, Randy Dunlap wrote:
> > +/**
> > + * block_dirty_folio - Mark a folio as dirty.
> > + * @mapping: The address space containing this folio.
> > + * @folio: The folio to mark dirty.
> > + *
> > + * Filesystems which use buffer_heads can use this function as their
> > + * ->dirty_folio implementation.  Some filesystems need to do a little
> > + * work before calling this function.  Filesystems which do not use
> > + * buffer_heads should call filemap_dirty_folio() instead.
> > + *
> > + * If the folio has buffers, the uptodate buffers are set dirty, to
> > + * preserve dirty-state coherency between the folio and the buffers.
> > + * It the folio does not have buffers then when they are later attached
> > + * they will all be set dirty.
> > + *
> > + * The buffers are dirtied before the folio is dirtied.  There's a small
> > + * race window in which writeback may see the folio cleanness but not the
> > + * buffer dirtiness.  That's fine.  If this code were to set the folio
> > + * dirty before the buffers, writeback could clear the folio dirty flag,
> > + * see a bunch of clean buffers and we'd end up with dirty buffers/clean
> > + * folio on the dirty folio list.
> > + *
> > + * We use private_lock to lock against try_to_free_buffers() while
> > + * using the folio's buffer list.  This also prevents clean buffers
> > + * being added to the folio after it was set dirty.
> > + *
> > + * Context: May only be called from process context.  Does not sleep.
> > + * Caller must ensure that @folio cannot be truncated during this call,
> > + * typically by holding the folio lock or having a page in the folio
> > + * mapped and holding the page table lock.
> 
>  * Return: tbd

+ *
+ * Return: True if the folio was dirtied; false if it was already dirtied.



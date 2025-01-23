Return-Path: <linux-fsdevel+bounces-40003-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E8BA1AAC6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 20:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817251883F90
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2025 19:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AB41ADC7E;
	Thu, 23 Jan 2025 19:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Blf7xPzL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B641741D2
	for <linux-fsdevel@vger.kernel.org>; Thu, 23 Jan 2025 19:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737662130; cv=none; b=WfpCPgsOb5AMVRZs+OatSQQYz7i7353+dTIbJeHn1Mn6a05QCj6wCrNc8EtshmWg8bFIFagP/7Tq+08GBEURcBwMW+2A3iedaxoJuzpFJ00B1b4g/m2LUmW8W7sBwhr04cm5Gj9Tb4trnkyBDU6/GlAFcxSPLJ+mIrH38LLPQBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737662130; c=relaxed/simple;
	bh=XfLnqkOhk/blZ9l9dTFnzaul4Nnj9YzBrG/cC7H9UmU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=g2oa2C+3WgpVoEAXAuhbkCHvopzq4lvEwfbdKYehEjkfmVgPAtHEl24YohOJCW6wmR6y+gmNph999KzBn545Jl63rx5Xcvdm0FtcO0wDf6p2S41CM9IIzktMLDYocz2SK+euUJDJU5PXaynKy4olo52RMTRIrlP30YlYKEFSfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Blf7xPzL; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
	Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=rKB6RsfhGqQLabdpnPnmcU9ZAb1rSKHiE7x1R8JvBmA=; b=Blf7xPzLk/ba6lmow/Qur0o0xz
	/3GcsKgysVLGp3B+xpvQbs22tBYZff47n4KsnTynYZp7WfKnQU9QGqugMXStp/LPtyeYKrVIdmMMN
	1tJNViPiNZbDALBdpRgPbUgvAOmMIFjkRw/pa+QZjg5OC5632tWhZ7j2tR9534nCCo+yYJtat+esr
	oimtqTy9dtmTDvWzSE8ayjQeb/P/Kxg9nn+SLJBKqvgcL8uFZEdX0qt8EqL8Wk5CRng12DjHaXv6J
	DKXaq6DZrCNYfpSFGAZgRtGo5gDrNL3sZpfOceGLDupL8RUagey05On3OtC7xD+PF2jVUfoib4I58
	SWEcPNXw==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tb3IS-0000000ARS0-3cvk;
	Thu, 23 Jan 2025 19:55:24 +0000
Date: Thu, 23 Jan 2025 19:55:24 +0000
From: Matthew Wilcox <willy@infradead.org>
To: linux-mm@kvack.org
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>, linux-fsdevel@vger.kernel.org
Subject: page_ref tracepoints
Message-ID: <Z5KerEzWmu61hFDU@casper.infradead.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The page reference count tracepoints currently look like this:

                __entry->pfn = page_to_pfn(page);
                __entry->flags = page->flags;
                __entry->count = page_ref_count(page);
                __entry->mapcount = atomic_read(&page->_mapcount);
                __entry->mapping = page->mapping;
                __entry->mt = get_pageblock_migratetype(page);
        TP_printk("pfn=0x%lx flags=%s count=%d mapcount=%d mapping=%p mt=%d val=%d",


Soon, pages will not have a ->mapping, nor a ->mapcount [1].  But they will
still have a refcount, at least for now.  put_page() will move out of
line and look something like this:

void put_page(struct page *page)
{
        unsigned long memdesc = page->memdesc;
        if (memdesc_is_folio(memdesc))
                return folio_put(memdesc_folio(memdesc));
        BUG_ON(memdesc_is_slab(memdesc));
        ... handle other memdesc types here ...
	if (memdesc_is_compound_head(memdesc))
		page = memdesc_head_page(memdesc);

        if (put_page_testzero(page))
                __put_page(page);
}

What I'm thinking is:

 - Define a set of folio_ref_* tracepoints which dump exactly the same info
   as page_ref does today
 - Remove mapping & mapcount from page_ref_* functions.

Other ideas?  I don't use these tracepoints myself; they generate far
too much data to be useful to me.

[1] In case you missed it,
https://lore.kernel.org/linux-mm/Z37pxbkHPbLYnDKn@casper.infradead.org/


Return-Path: <linux-fsdevel+bounces-16443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 208A089DBCB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 16:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B2641C22138
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Apr 2024 14:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358F12FB0D;
	Tue,  9 Apr 2024 14:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="fAtD7d7A"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7F12F5A4
	for <linux-fsdevel@vger.kernel.org>; Tue,  9 Apr 2024 14:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671786; cv=none; b=iWE5AWb1OjHexkD7TU4uTIKPgO1Jp7I9Lu09mzq6nCtNw21XCOo+kFXrMqC4ad7osZ9nx3vnyWlrRmTr4TAFJoQMf+tSjTusx1jZ4HhhrbjLqkzRIIR7/TgkSuwFlJOU3JgHr9O3JpO5K76f7vuw8laf3y0obog17Rm2D6gHgpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671786; c=relaxed/simple;
	bh=Z1vOiknQsnKoJ0SDnGPiKFr9f7qAHnptNOp/MBMpztQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H9XscY4+tCcE5ueDK+lmu8VASqNFav8FYZTrymM1l9uluLimlzZO9pWZ0Kx8SV/giJejbnaAwp9S4/lTEHN9uoTkYZHCFfWl5zc6fbinTEH01WPVVjl03sbKJ51FN25Fm003vJtc9oLG6HHUFxBi9PUJEMJoa+eGDIvBkVyXBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=fAtD7d7A; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=BQQLUB5sQos6pI24WXbQ1RLhAkO7yA5AUlgdiU+dzI0=; b=fAtD7d7A2nmyW+6JMbURfPumMq
	B8/RiGuVdYHCfVhKOf6VX5ASD4UcTDylZ3VAohXsTpzG++LZCWAhP0fCKcGG7a3M66DOFikWVu7tO
	3cMPQ6jEJ5d3J2BvQtVvELEqhZljeGTEbHGFvBjlTa0SmSHv19CkIHoMtFYsLMuNrG0dfqkKYkUe7
	eQJXZcZ2QH+i1fML8g+dwmiz013iUComIrmHg2Dks65SND2BBl/TwX2bys5Bl/y4LYIw9aWVOYBrv
	hZ5lUb8C2aonU54onFtj5872cInTYwDsGUNMXtVY9BLg7REksMx/WFUHttRgU6F5GYkzZBC9SWqh7
	6o3NBX4Q==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruCAO-00000002GWl-19sG;
	Tue, 09 Apr 2024 14:09:40 +0000
Date: Tue, 9 Apr 2024 15:09:40 +0100
From: Matthew Wilcox <willy@infradead.org>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH] mm: Convert pagecache_isize_extended to use a folio
Message-ID: <ZhVMJF6fICFVO6Lc@casper.infradead.org>
References: <20240405180038.2618624-1-willy@infradead.org>
 <eb153cdb-6228-435a-916a-77f4166d4cd2@redhat.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb153cdb-6228-435a-916a-77f4166d4cd2@redhat.com>

On Tue, Apr 09, 2024 at 03:39:35PM +0200, David Hildenbrand wrote:
> On 05.04.24 20:00, Matthew Wilcox (Oracle) wrote:
> > + * Handle extension of inode size either caused by extending truncate or
> > + * by write starting after current i_size.  We mark the page straddling
> > + * current i_size RO so that page_mkwrite() is called on the first
> > + * write access to the page.  The filesystem will update its per-block
> > + * information before user writes to the page via mmap after the i_size
> > + * has been changed.
> 
> Did you intend not to s/page/folio/ ?

I did!  I think here we're talking about page faults, and we can control
the RO property on a per-PTE (ie per-page) basis.  Do you think it'd be
clearer if we talked about folios here?  We're in a bit of an interesting
spot because filesystems generally don't have folios which overhang the
end of the file by more than a page.  It can happen if truncate fails
to split a folio.

> Reviewed-by: David Hildenbrand <david@redhat.com>

Thanks!


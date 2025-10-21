Return-Path: <linux-fsdevel+bounces-64808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFD1ABF4AFC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 08:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8943C423655
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Oct 2025 06:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C040825C6EE;
	Tue, 21 Oct 2025 06:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ShKdqzOl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0D2F872;
	Tue, 21 Oct 2025 06:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761027175; cv=none; b=qpCq+oqFpOjvCe2ctebngCdh5QiePsmuTciD29xy1CK2gDeu5YLZ9ORbzDVluG/Hv4F7VyJ7yD8GViv2DPbKtkDf2N+hSDQDURt4MTM8q1TBZqIBeCrcMVhwbn2fu+S6hK1eLkKVdR3sDkc52gvnKNrA9MIZrIx45I4awn6HQ0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761027175; c=relaxed/simple;
	bh=+QmnY748EjRGKjWLnl5sIMZrRRpbF0hAi5qW5DwTCqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KzDyKaNCWha+ZUJV+skjbCr/7BBCg7PhWrHxIVSz7NmBuorEY+DbzaM3r2cKqdYYwY7hDWuNJq67VI+OpvPHKM4gTSGzJ52Wj1Leb1xDrbyiqnHlJpNa6nZQzHhSbZBfDCjeB6n2m4GNbTbLl2Xz4yiXD1J1OQ+Qv0PWmoIBz/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=ShKdqzOl; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=32WXsKzxggeOILJADAf0lJ/XcojNDUkG87T7LB0uMmU=; b=ShKdqzOlsJZJ5PGyNK+WPgm08w
	YG05J6HLCcDbwjPvnI2QKbkgv/jKp9ozm4cWjoblrSDJhZ0TR5nkyWesExrjXvzpM5nGgaQuqd7V1
	rvdQqa2snXe2hDLHng9fXY1sngvgapiVGUyprKX0IWXegzyi4+aXuZzyermYeCXnmCFdpp6bV3QWw
	jmh71KufOM6iT9U0CiMBHCGz2dLUYPXWZXk/5EZwARAimiB+s6wR5K0TATS6/PXzPHCVaGsqYJ1xL
	pgs4ZgTZum8hJdzxZYaGmGzcbeZaXKkXgzvEnVgYuB/0TWX9ayxP052nFyV78namlJzodSv305bya
	CnN0oLeg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vB5bs-0000000FuQQ-39F3;
	Tue, 21 Oct 2025 06:12:40 +0000
Date: Mon, 20 Oct 2025 23:12:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Dave Chinner <david@fromorbit.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
	Matthew Wilcox <willy@infradead.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
	Harry Yoo <harry.yoo@oracle.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	"Darrick J. Wong" <djwong@kernel.org>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [RFC, PATCH 0/2] Large folios vs. SIGBUS semantics
Message-ID: <aPckWHAGfH2i3ssV@infradead.org>
References: <20251020163054.1063646-1-kirill@shutemov.name>
 <aPbFgnW1ewPzpBGz@dread.disaster.area>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aPbFgnW1ewPzpBGz@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Oct 21, 2025 at 10:28:02AM +1100, Dave Chinner wrote:
> Fundamentally, we really don't care about the mapping/tlb
> performance of the PTE fragments at EOF. Anyone using files large
> enough to notice the TLB overhead improvements from mapping large
> folios is not going to notice that the EOF mapping has a slightly
> higher TLB miss overhead than everywhere else in the file.
> 
> Please jsut fix the regression.

Yeah.  I'm not even sure why we're having this discussion.  The
behavior is mandated, we have test cases for it and there is
literally no practical upside in changing the behavior from what
we've done forever and what is mandated in Posix.



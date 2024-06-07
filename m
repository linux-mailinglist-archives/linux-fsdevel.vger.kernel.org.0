Return-Path: <linux-fsdevel+bounces-21269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC77900AE9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 19:02:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B9D2B220C1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Jun 2024 17:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAE819AA40;
	Fri,  7 Jun 2024 17:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="CXEE3Q2z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72305190687;
	Fri,  7 Jun 2024 17:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717779733; cv=none; b=r5uWpRb4mlJc415iGIaG4hNeGr5TOlH0Vpr9pE3WB/AjVLoZetQjCUfMJXVa5oYP7Dbs+KSMBhYUtdf1zARZY4kkxITKDtT38CGb7w+W3+J5E2MjEZUintPNN+MhxGw1muN0bEV7d2eH2lYGMVKjX/Av8AGlijgSRPTmu3jr2h4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717779733; c=relaxed/simple;
	bh=quBBbYGeceOQJUlGHVUTHvQoaAdeTEZZ3DjSYwTtiEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pw9Yz08CSYtEKF0ANeoresSpEFd1v6vfEDfPH2tQVzzbqeqRnGWaj+ud+7id1VKe5kNvy+vi+FDgYpBd3i+2/mmNAx/i8kAp2LRUYja1buyUUzndtjPSnYevV4pGXaZdPFnKOYy4JaaLnrLHOUnmQYkdksyzUFdWc1aOd50OiuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=CXEE3Q2z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+Y+uz+t7CBd5q+ju0YXmF1lWX1OcZxpsLTsUly2lYtQ=; b=CXEE3Q2zfrYvMDNLN5EMRpwIMW
	iVfV2dKW3HVxXGKAzJ4TxHof/Pj4V76QQmcHc4tBPZyWkLZuwLE06HWRSRXzGqH5xYdeaIx1l6oCH
	XGsrvzpLyPutIV5vIEQSxLf4A0QJtmDTZ5LnwWyRmAwpb/3yEcZAklvltriXPEtjYfQetseyuv3JT
	mVwVR+jV5wEZM6m/GQxWcbOzfwrfBcjIEUNVWMY8o7gTbts7tKaJT9fKDAMPCM3a/maSUKKUKZ8vz
	uYYl3Fr5FBSvkeXuU2vVyc93vMF5KabF0N79vQmtdIo0MRfpBpiRBqqdklv1pdaPK9dvmWbE5r45x
	pDjCUUVQ==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sFcyS-00000006PkX-3vg9;
	Fri, 07 Jun 2024 17:01:56 +0000
Date: Fri, 7 Jun 2024 18:01:56 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>,
	david@fromorbit.com, djwong@kernel.org, chandan.babu@oracle.com,
	brauner@kernel.org, akpm@linux-foundation.org, mcgrof@kernel.org,
	linux-mm@kvack.org, hare@suse.de, linux-kernel@vger.kernel.org,
	yang@os.amperecomputing.com, linux-xfs@vger.kernel.org,
	p.raghav@samsung.com, linux-fsdevel@vger.kernel.org, hch@lst.de,
	gost.dev@samsung.com, cl@os.amperecomputing.com,
	john.g.garry@oracle.com
Subject: Re: [PATCH v7 05/11] mm: split a folio in minimum folio order chunks
Message-ID: <ZmM9BBzU4ySqvxjV@casper.infradead.org>
References: <20240607145902.1137853-1-kernel@pankajraghav.com>
 <20240607145902.1137853-6-kernel@pankajraghav.com>
 <75CCE180-EC90-4BDC-B5D8-0ED1B710BE49@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <75CCE180-EC90-4BDC-B5D8-0ED1B710BE49@nvidia.com>

On Fri, Jun 07, 2024 at 12:58:33PM -0400, Zi Yan wrote:
> > +int split_folio_to_list(struct folio *folio, struct list_head *list)
> > +{
> > +	unsigned int min_order = 0;
> > +
> > +	if (!folio_test_anon(folio)) {
> > +		if (!folio->mapping) {
> > +			count_vm_event(THP_SPLIT_PAGE_FAILED);
> 
> You should only increase this counter when the input folio is a THP, namely
> folio_test_pmd_mappable(folio) is true. For other large folios, we will
> need a separate counter. Something like MTHP_STAT_FILE_SPLIT_FAILED.
> See enum mthp_stat_item in include/linux/huge_mm.h.

Also, why should this count as a split failure?  If we see a NULL
mapping, the folio has been truncated and so no longer needs to be
split.  I understand we currently count it as a failure, but I
don't think we should.




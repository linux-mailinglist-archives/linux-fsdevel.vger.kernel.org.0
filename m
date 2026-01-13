Return-Path: <linux-fsdevel+bounces-73372-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 191F2D1698C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 05:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42C4D3015955
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Jan 2026 04:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6DF034F48F;
	Tue, 13 Jan 2026 04:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BNCFRz4e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34E12F39DD;
	Tue, 13 Jan 2026 04:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768277391; cv=none; b=PzWuircG29u2+U3LT+xxY69F+EtceHsIf7L7rZgOzZD0HdgrQkfgpUHOvGAZ8AhHCwNKknrC9KFZnXXK2kRefYoieu85meQKIWalamLfdFLc1zmZHawVBL5kQ6XOYjunj8PAWT/2KjoXPVt5ep2vAcLxo068hb9eRdp6Hs5i9Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768277391; c=relaxed/simple;
	bh=N0X9/sHsBwg9h1LNqOoNIP9nFu35oohAUENJLRSsPkA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fvm7rfEwhD3osCt7hwz1eQD5F19x3vPz/bGoltV9wyiU2h8bLERljswTh0QbqQpqaNJn7UibcG6EhAub3AS2d+VCHbUl5RfxKQ0XgrTSznoppaPAJERda42mtiOmu9Gxs3Ipg+9ah3SttyErKdFrBpZseby/Erok0vqU8cpaEug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BNCFRz4e; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FPDQONHKCDgnwEfmCCHE8B+Ej5UJEZq2JA2LN4UYypE=; b=BNCFRz4eLPfjfJ2qSh7zUCS74o
	bFnDkG7iJVpZ2s9CBjxdIUij2tzii6zrVYCbKLHO+VGwUu/CUClk23pdIocqw/M6Rq7mZpMLsWzX7
	bIKm4Nl8uqKm/AhDeG0DsGp7NTnjLZljLE4ger/3aHHhciCon0dtnvLTZ8J4UyVgfvzgBmRxnhmL7
	gs+Zox18mKEyIDYgY0/cqB9p7y+TShFjBurWNOfdoloBeQRZ3Xv18CpKV2aH85tpswuBtINJicd2b
	UbXVDTMDgo38U4yotEd1u4Gyr2opDj1G5KzLqL/rBqdpus4oATKhc75EHYuF2b4wd6Jiwl58fewAr
	G96bLBtg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfViX-00000004Chu-3eJI;
	Tue, 13 Jan 2026 04:09:17 +0000
Date: Tue, 13 Jan 2026 04:09:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ye Liu <ye.liu@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Ye Liu <liuye@kylinos.cn>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] mm: remove redundant page parameter from do_set_pmd()
Message-ID: <aWXFbZJl7Z-9INVp@casper.infradead.org>
References: <20260113014130.922385-1-ye.liu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113014130.922385-1-ye.liu@linux.dev>

On Tue, Jan 13, 2026 at 09:41:29AM +0800, Ye Liu wrote:
> The page parameter passed to do_set_pmd() was always overwritten with
> &folio->page immediately upon function entry (line 5369 in memory.c),
> making the parameter completely redundant. This confused callers who
> computed different page values only to have them ignored.

No.  It's an accident of the implementation that we currently only
support folios up to the size of PMDs.  That is not the long-term plan.
We always want to specify exactly which pages of the folio to map.



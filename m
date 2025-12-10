Return-Path: <linux-fsdevel+bounces-71037-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 83AE8CB1E84
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 05:28:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F030D30A7A24
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Dec 2025 04:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A152930EF86;
	Wed, 10 Dec 2025 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="YoEtHsGu"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D65F17A30A;
	Wed, 10 Dec 2025 04:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765340861; cv=none; b=ZyIbUK94CykYJ5LKooI33GTDJJ9dHgMDUfn75A2bmV4+k36AJUTRh0eFZkxGkEW83lMMlK8u/2rALT8bJKvi2i3MkwOeQ3KYzskl8yA/8x5001S/gczHXTNor11QA2OD8QkQGDrj9s31JJXytVAIJwmQ9qGroLkdsvfKlnhyC+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765340861; c=relaxed/simple;
	bh=WTv0v70vaWxCnm9avv/0y5HO3iK9XjOP1DDjXjwugZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q8YPvegUQ5kd23U8c76MpF5WYGIO3h9+xvTrBLZFKn7wzu+yBlSQSyHBSM6WVZtODTM/nDhwfpRTJt+D6VE9FapFu3XcCpmeq8eDwIL+zd3egExm5nHJFkbK4mXaTl0nlozuUtQxUHT6KUAsH8GTj7vKdXr4px3WtarwH18ojf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=YoEtHsGu; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XQZTyVY5EI22OfoG+6/Jw+yO17GgHGjfzONX+f4GGdA=; b=YoEtHsGuQbLbUOQDdHALmnfwAY
	tNqObB8kUEP4Gy80sUh6a6H3/Nr0AbajRKuSYoR78lcNgmUVQq6R5pU3F43oxeaOzBqymfrpbwlsl
	cewMwuciIcEhRpC7dPshg6Y32cTaC78zq8lGz4gNi0bnkaca2Iaq1beqJzJinqtKiyBt7shpUUL+t
	D2u3r6TCbz3yxZH6CnusT0Z9Ocaniazn+dSz0vWuJRlHTH7mSLqVpLOFOc26sI0wx5RWxlBz8ekyx
	5Eyyjcz8lV7qjG9j0yy4um3BWtHJEIocISpWzduMS6rBVQ8xyNV9Psb7wKqB91GwfGalaY84SbD60
	vpvfQdFA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTBnJ-0000000CJG5-1xCy;
	Wed, 10 Dec 2025 04:27:17 +0000
Date: Wed, 10 Dec 2025 04:27:17 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Zi Yan <ziy@nvidia.com>
Cc: Pankaj Raghav <p.raghav@samsung.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Michal Hocko <mhocko@suse.com>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nico Pache <npache@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, kernel@pankajraghav.com, tytso@mit.edu
Subject: Re: [RFC v2 0/3] Decoupling large folios dependency on THP
Message-ID: <aTj2pZqwx5xJVavb@casper.infradead.org>
References: <20251206030858.1418814-1-p.raghav@samsung.com>
 <64291696-C808-49D0-9F89-6B3B97F58717@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <64291696-C808-49D0-9F89-6B3B97F58717@nvidia.com>

On Tue, Dec 09, 2025 at 11:03:23AM -0500, Zi Yan wrote:
> I wonder if core-mm should move mTHP code out of CONFIG_TRANSPARENT_HUGEPAGE
> and mTHP might just work. Hmm, folio split might need to be moved out of
> mm/huge_memory.c in that case. khugepaged should work for mTHP without
> CONFIG_TRANSPARENT_HUGEPAGE as well. OK, for anon folios, the changes might
> be more involved.

I think this is the key question to be discussed at LPC.  How much of
the current THP code should we say "OK, this is large folio support
and everybody needs it" and how much is "This is PMD (or mTHP) support;
this architecture doesn't have it, we don't need to compile it in".



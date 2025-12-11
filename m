Return-Path: <linux-fsdevel+bounces-71088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A12A1CB4FEF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 08:38:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56534300D16E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Dec 2025 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD872D374F;
	Thu, 11 Dec 2025 07:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RXb7Y72Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AE7326981E;
	Thu, 11 Dec 2025 07:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765438696; cv=none; b=MRFbFxsrIwU6HNgD/rPyGjyYhnScirE/nkxHXB3f8zqvk5VHHZxMYy91ZOY5RSWmgn4HPlWVkbjpqI0ml2x48RC+YBvUfAnCd8qCK0NMOCgo+AFMUEqBx8iZ4UgiDFJQZaJ/zLpE+pYg9vytvGsI6ku/mqoYTtNcc7Pfba5fyTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765438696; c=relaxed/simple;
	bh=rTqOpg7n9JAE/DziGqxqB0zYUu70EqKn/5a8DdMwhuw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGN5e2sOIr3LdMTmT+jC3eLULBRoKxyE53I/iyYDg+lqn802suV9x1FTd+gN8Ab8JBUC2EDeKKi8FQMRqZUSLSH/tDn+GU0dLYMwJT9+icXm3Mx2oGecCUkplzXGPemgr5Gc6wKsb9GmDnKx04x5EyVREHkzXRB/QQsgAMlX+Ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RXb7Y72Z; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=LvL+wWM9xb9eGh0ewmBu/qTlopS6rqYvC3V8y4f6Lis=; b=RXb7Y72ZDLDYLNGzvUQCElZAeD
	BL66pjYC7rbK0+X6ld6Xm7Hz94GG/G0qAauo8mZLNeI+zAmxu0fJEwJL99vnwasCVj5N5tj3KLh1t
	KhmtPmtNh9raTTYvuZrRa9MfmLABrsVANz0JeRpO1kZ+RbTVWI6EucsQk9cHL3n7DJJ+elSNVErlX
	DZvbx3t2+JeBopt+WZXzlLqNyERmxqLJ6u2rU3ZaEhQ10Wa4EXHTUArwL+HDPmP/sxLD0U7zcwnV/
	LwdBXGmOhTWf/qEGpq8xoU3IcKTF+jxv10EAHQeCoQ9xAg7gDy0X89VseKqgTBQ7pI9yUOFpb22i4
	AYWUwNDQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTbFN-0000000DwGk-1G4j;
	Thu, 11 Dec 2025 07:37:57 +0000
Date: Thu, 11 Dec 2025 07:37:57 +0000
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
Message-ID: <aTp01WOPU0dYT7yx@casper.infradead.org>
References: <20251206030858.1418814-1-p.raghav@samsung.com>
 <64291696-C808-49D0-9F89-6B3B97F58717@nvidia.com>
 <aTj2pZqwx5xJVavb@casper.infradead.org>
 <D498FB7E-1C57-47A6-BAF4-EA1BAAE75526@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D498FB7E-1C57-47A6-BAF4-EA1BAAE75526@nvidia.com>

On Wed, Dec 10, 2025 at 11:37:51AM -0500, Zi Yan wrote:
> On 9 Dec 2025, at 23:27, Matthew Wilcox wrote:
> 
> > On Tue, Dec 09, 2025 at 11:03:23AM -0500, Zi Yan wrote:
> >> I wonder if core-mm should move mTHP code out of CONFIG_TRANSPARENT_HUGEPAGE
> >> and mTHP might just work. Hmm, folio split might need to be moved out of
> >> mm/huge_memory.c in that case. khugepaged should work for mTHP without
> >> CONFIG_TRANSPARENT_HUGEPAGE as well. OK, for anon folios, the changes might
> >> be more involved.
> >
> > I think this is the key question to be discussed at LPC.  How much of
> 
> I am not going, so would like to get a summary afterwards. :)

You can join the fun at meet.lpc.events, or there's apparently a youtube
stream.

> > the current THP code should we say "OK, this is large folio support
> > and everybody needs it" and how much is "This is PMD (or mTHP) support;
> > this architecture doesn't have it, we don't need to compile it in".
> 
> I agree with most of it, except mTHP part. mTHP should be part of large
> folio, since I see mTHP is anon equivalent to file backed large folio.
> Both are a >0 order folio mapped by PTEs (ignoring to-be-implemented
> multi-PMD mapped large folios for now).

Maybe we disagree about what words mean ;-)  When I said "mTHP" what
I meant was "support for TLB entries which cover more than one page".
I have no objection to supporting large folio allocation for anon memory
because I think that's beneficial even if there's no hardware support
for TLB entries that cover intermediate sizes between PMD and PTE.


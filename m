Return-Path: <linux-fsdevel+bounces-66800-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C9BBC2C724
	for <lists+linux-fsdevel@lfdr.de>; Mon, 03 Nov 2025 15:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1F3F3A9311
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Nov 2025 14:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E9AE27F4F5;
	Mon,  3 Nov 2025 14:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="hu75PmCK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAB6A27FB3E;
	Mon,  3 Nov 2025 14:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762180573; cv=none; b=eUuEtInJOGaRsNWO9hI7AKo2ZX6RFajQlLnK/NQtmJQ4SLidtBp0FJpxgC0E1eVehG59gGTyeHk+YhbgiLJVRspmtZm9N8qDwoScZY/w/Ivv1JfOwZZYtYbTcNkMoNm+AmQktvtKdYIX4fWgSsro9pc3Uz/MbdlwaXlRGJ8oAkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762180573; c=relaxed/simple;
	bh=PJL40H1rrSr1RByqR89AZ2E1q5oDA4QRqub55GfiluA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LTY8VyeacoTHzBLEx2dK8JMAWnGpOKH2Js5d2mrz1A6k6oQJ/T3LqPmcY72u439qAtlkhd0YHek+U1PefB2ypVgBkQ6DlIc+rRhQzu9fnRCa3eoKn4FAtss6TJHDZckVnnDwWjbHUrr0ZM2RqDy1jrZhYTfzeE1KnUN6+0gyAys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=hu75PmCK; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=bDJLzxzXeix51zzhX2vSU/9HiMumVsIUdwFwVA82G6A=; b=hu75PmCKzdeDR7snJfmgqiYskr
	4Y+walnvU1NsJgfJ12yFjqNQQ6z64Kt7zgMxH2HfwjtCBNQwrXHwQWgvMap+GK4otMLw4mg5AfVet
	qwHSUePwD1bMztaS6NBdgCU88ut4785Q4wVifQnfCXPkYVmGyySH/cIadqVIgWN0ePB4ws89Xg6Di
	BpDuY77NKwLBZJWM5L5uda8UtdQ5gy3vlhqkTvyAj3OntGYhMcRLfnvoxFr553Uw8MEWfSumy8GL5
	/7HDjsGlInDkOQeKkZ3JzXQddczmYxPncAru6jv/Jy8t2KDjxb5jc1EPJzu1Zge+u6IsLqIAmuKlp
	V58oCqwQ==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFvf3-00000008v4J-1HNK;
	Mon, 03 Nov 2025 14:35:57 +0000
Date: Mon, 3 Nov 2025 14:35:57 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
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
	"Darrick J. Wong" <djwong@kernel.org>,
	Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-ID: <aQi9zaPxwLBTneF4@casper.infradead.org>
References: <20251027115636.82382-1-kirill@shutemov.name>
 <20251027115636.82382-2-kirill@shutemov.name>
 <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org>
 <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
 <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>
 <aQWT_6cXWAcjZYON@casper.infradead.org>
 <xadc6rbs7fkk2mb5b4reobqwue2kveo736r3wpa5zwted4daua@rgasjiwwot3g>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xadc6rbs7fkk2mb5b4reobqwue2kveo736r3wpa5zwted4daua@rgasjiwwot3g>

On Mon, Nov 03, 2025 at 10:59:00AM +0000, Kiryl Shutsemau wrote:
> On Sat, Nov 01, 2025 at 05:00:47AM +0000, Matthew Wilcox wrote:
> > On Wed, Oct 29, 2025 at 02:45:52AM -0700, Hugh Dickins wrote:
> > > But you're giving yourself too hard a time of backporting with your
> > > 5.10 Fixee 01c70267053d for 1/2: the only filesystem which set the
> > > flag then was tmpfs, which you're now excepting.  The flag got
> > > renamed later (in 5.16) and then in 5.17 at last there was another
> > > filesystem to set it.  So, this 1/2 would be
> > > 
> > > Fixes: 6795801366da ("xfs: Support large folios")
> > 
> > I haven't been able to keep up with this patchset -- sorry.
> > 
> > But this problem didn't exist until bs>PS support was added because we
> > would never add a folio to the page cache which extended beyond i_size
> > before.  We'd shrink the folio order allocated in do_page_cache_ra()
> > (actually, we still do, but page_cache_ra_unbounded() rounds it up
> > again).  So it doesn't fix that commit at all, but something far more
> > recent.
> 
> What about truncate path? We could allocate within i_size at first, then
> truncate, if truncation failed to split the folio the mapping stays
> beyond i_size.

Is it worth backporting all this way to solve this niche case?


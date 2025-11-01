Return-Path: <linux-fsdevel+bounces-66653-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4137C27815
	for <lists+linux-fsdevel@lfdr.de>; Sat, 01 Nov 2025 06:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46BBC189CDC1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  1 Nov 2025 05:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39565286891;
	Sat,  1 Nov 2025 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="m8cBoJTe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D37921ADCB;
	Sat,  1 Nov 2025 05:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761973274; cv=none; b=LhAx4OyC2ZpaskM9Q8CNKc90Dmsyhy5WOmoN85LvT5W696QHr6fYq+6kOry0Q+e8Z+SrFyXgu9/oh/WqXKU5SrcKJd39C+HxQEo6kRnLd5gTqpzsu/GtNn+g2EHlDBe0Aa3yoR0uZZjJO2J238qsPr+K0HGajw7AmFlTkw0yFyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761973274; c=relaxed/simple;
	bh=MSmFonQhLiVrYFtlSYTNKc2d0hY0+PZpclkFF5lut+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XmxCwhm8sqBPyD7ezKDbSx/izBjH1BmfIu7NtBx+n2J24V9H/dqAxKp1bBNGWejIstvffGOU+jdFLz2gwYYK9YT3J2y2dkns8vyHw/CCtN5LQatzgiS2AxwnQlwPNnHDju823UkeV6EmVxMnEFoMblYJ+D0tl/h7+8d7JIlMLU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=m8cBoJTe; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=nUfYsQtKHPf6wGb5urLnNs0QXXFwsJ1uqZTAIsOnWO8=; b=m8cBoJTe+4lqxnFOY3CicYWrN9
	vVSfzrov1mXQcm/ejH+7snvW0fku6j+TSEDgJwiDbvk/BnnBQSZsiKKBCmg37krQiQeR+s0VwfA5K
	Hgb2urZ/RwlHXrFPYj+wGmHk0aTco+RQek0qer0J512Q9VkTZxrn56/xiC92KtH6U1NMvNNuLGc/8
	oUfXrHCVC2jjaTuwC47G3NDf7Tly13LH93JapnK3sbtB6XFfe0Gp0GQvvXHN+08/6IPxhXBB7b7+H
	FTjNGlQdcG5NuSfTy3cYcsYhNyZRXe+Ir078vlZrvPRsl1FGaknm4HGKCrGkIO0KaxG8AyLzTpgGE
	UQVLjJpA==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vF3jL-00000001FAo-1qO9;
	Sat, 01 Nov 2025 05:00:47 +0000
Date: Sat, 1 Nov 2025 05:00:47 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>,
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
Message-ID: <aQWT_6cXWAcjZYON@casper.infradead.org>
References: <20251027115636.82382-1-kirill@shutemov.name>
 <20251027115636.82382-2-kirill@shutemov.name>
 <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org>
 <hw5hjbmt65aefgfz5cqsodpduvlkc6fmlbmwemvoknuehhgml2@orbho2mz52sv>
 <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9e2750bf-7945-cc71-b9b3-632f03d89a55@google.com>

On Wed, Oct 29, 2025 at 02:45:52AM -0700, Hugh Dickins wrote:
> But you're giving yourself too hard a time of backporting with your
> 5.10 Fixee 01c70267053d for 1/2: the only filesystem which set the
> flag then was tmpfs, which you're now excepting.  The flag got
> renamed later (in 5.16) and then in 5.17 at last there was another
> filesystem to set it.  So, this 1/2 would be
> 
> Fixes: 6795801366da ("xfs: Support large folios")

I haven't been able to keep up with this patchset -- sorry.

But this problem didn't exist until bs>PS support was added because we
would never add a folio to the page cache which extended beyond i_size
before.  We'd shrink the folio order allocated in do_page_cache_ra()
(actually, we still do, but page_cache_ra_unbounded() rounds it up
again).  So it doesn't fix that commit at all, but something far more
recent.


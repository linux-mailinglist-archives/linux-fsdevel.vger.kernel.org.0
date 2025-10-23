Return-Path: <linux-fsdevel+bounces-65391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A67FCC03903
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 23:36:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DBC5189F759
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 21:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C536627E7EC;
	Thu, 23 Oct 2025 21:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D5dLSV7c"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B43EEB3;
	Thu, 23 Oct 2025 21:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761255386; cv=none; b=jkg9cOK7oEN4Me3fzx/meABuoFRoTxUU8ZupFJuCsUjjNInqKpvVT1LzPQJTRTN+pHwnA2B99goyc8pNfzLD626lID6kdJcfZnVP+oy4nkyhjhUyeurxbA/tRcSoW7OXBwCAkJvXyOc1M1Lat7qlcPC+BiQcKzNZMmvsQqlhvIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761255386; c=relaxed/simple;
	bh=PeQvjl8tTHsyJLNIyC0D1J39XRcadQROmtv7uZK7IMo=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=GZSY0qaiFucal/+pL9eSb2n/grV1qeKQZ2Hs6pRDay+Sg5qM1b33sEYSiyHVdtgEu2wCkii02b9pc5qqiuMBsjsefXoNslLNwwc23POXNb47jWF0eR0hoPv3WtqJaCQVWDtrq7jfDpAAx5Lqc9Ro6skQW09ouOE6okRLHg7VztI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D5dLSV7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECC59C4CEE7;
	Thu, 23 Oct 2025 21:36:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761255385;
	bh=PeQvjl8tTHsyJLNIyC0D1J39XRcadQROmtv7uZK7IMo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D5dLSV7cClMTLlP1vvO/xSsofDIiz6K30iXsothe1O5uqNMocMhnArlWU6WugZ4F0
	 3+FNIq71QSLCs4QBTqUENXpZukkHfHAH0AfcMkDFKPnu26S55DMAgZ2SklkCX8+WQN
	 i7Jhbbi2Hu3iBHnpF4AsyZl96QUiJpmL4TBeKlLA=
Date: Thu, 23 Oct 2025 14:36:24 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: David Hildenbrand <david@redhat.com>
Cc: Kiryl Shutsemau <kirill@shutemov.name>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>, Alexander Viro
 <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport
 <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal Hocko
 <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, Harry Yoo
 <harry.yoo@oracle.com>, Johannes Weiner <hannes@cmpxchg.org>, Shakeel Butt
 <shakeel.butt@linux.dev>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Darrick J. Wong" <djwong@kernel.org>, Dave Chinner <david@fromorbit.com>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-Id: <20251023143624.1732f958020254baff0a4bee@linux-foundation.org>
In-Reply-To: <3ad31422-81c7-47f2-ae3e-e6bc1df402ee@redhat.com>
References: <20251023093251.54146-1-kirill@shutemov.name>
	<20251023093251.54146-2-kirill@shutemov.name>
	<20251023134929.b72ab75a8c132a17ae68a582@linux-foundation.org>
	<3ad31422-81c7-47f2-ae3e-e6bc1df402ee@redhat.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 22:54:49 +0200 David Hildenbrand <david@redhat.com> wrote:

> >> Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> > 
> > Sep 28 2025
> > 
> >> Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> > 
> > Sep 28 2025
> > 
> >> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
> > 
> > Jul 26 2016
> > 
> > eek, what's this one doing here?  Are we asking -stable maintainers
> > to backport this patch into nine years worth of kernels?
> > 
> > I'll remove this Fixes: line for now...
> 
> Ehm, why?

Because the Sep 28 2025 Fixes: totally fooled me and because this
doesn't apply to 6.17, let alone to 6.ancient.

> It sure is a fix for that. We can indicate to which stable 
> versions we want to have ti backported.
> 
> And yes, it might be all stable kernels.

No probs, thanks for clarifying.  I'll restore the

	Fixes: 800d8c63b2e9 ("shmem: add huge pages support")
	Cc; <stable@vger.kernel.org>

and shall let others sort out the backporting issues.


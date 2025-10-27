Return-Path: <linux-fsdevel+bounces-65808-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 36443C11B81
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 23:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AF2153525A2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Oct 2025 22:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A96A2F12B4;
	Mon, 27 Oct 2025 22:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="cnSO/D1L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584CC286D55;
	Mon, 27 Oct 2025 22:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761604405; cv=none; b=raTU0tXs/y8zxPyBZsLN94uoXb27af0KWDbSOldSQS7R5T0qwbcRPALTIZmYESNQbB+ngleme4FOjcatbFo3SMrIx5LjymRnIE2QtMzU35puBgjdu7l3xcVnf9CNu/1hKTSCY5JUiTZL8B9+GsMJRWbGlATVU9ZIdaoPjYbCxeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761604405; c=relaxed/simple;
	bh=fLsY2IaNWnElQm8sDAaq+THCaLKaSE7zFkFyiMd/pwA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=hlnTNaC2iFR/7lOZOc1PN0ETHNVSgeHWbB8EzPabCLJaNd7Uq1dQZ04Oz9WMnNgZqNY+rMQ5RsdvwAWd5zD7//1TK97SYPCOPkejRThsoMVW/dtWthVHo6trqccIHZroPQEbA0sPt4cg9q+o8is8ZAsUsWL3b7uuV2oGQPAt6eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=cnSO/D1L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2ADC4CEF1;
	Mon, 27 Oct 2025 22:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761604404;
	bh=fLsY2IaNWnElQm8sDAaq+THCaLKaSE7zFkFyiMd/pwA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cnSO/D1LcebBp6Cvsxk9vKxyPgcagZU6mdww6XBNtxYkyCiMfAsT5j4lcUVeAnhfC
	 OWW6vW1QACOUuuIwVrW1DkbWyM+MZBf87+OD0yON0oWFpumPZCD6Q4isbVVnibzLEe
	 Yud1wYYJ6PuguEptiBR7VdwBj/F23lsh6Mj+2D2w=
Date: Mon, 27 Oct 2025 15:33:23 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>,
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
Subject: Re: [PATCHv3 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-Id: <20251027153323.5eb2d97a791112f730e74a21@linux-foundation.org>
In-Reply-To: <20251027115636.82382-2-kirill@shutemov.name>
References: <20251027115636.82382-1-kirill@shutemov.name>
	<20251027115636.82382-2-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Oct 2025 11:56:35 +0000 Kiryl Shutsemau <kirill@shutemov.name> wrote:

> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Accesses within VMA, but beyond i_size rounded up to PAGE_SIZE are
> supposed to generate SIGBUS.
> 
> Recent changes attempted to fault in full folio where possible. They did
> not respect i_size, which led to populating PTEs beyond i_size and
> breaking SIGBUS semantics.
> 
> Darrick reported generic/749 breakage because of this.
> 
> However, the problem existed before the recent changes. With huge=always
> tmpfs, any write to a file leads to PMD-size allocation. Following the
> fault-in of the folio will install PMD mapping regardless of i_size.
> 
> Fix filemap_map_pages() and finish_fault() to not install:
>   - PTEs beyond i_size;
>   - PMD mappings across i_size;
> 
> Make an exception for shmem/tmpfs that for long time intentionally
> mapped with PMDs across i_size.
> 
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
> Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")
> Fixes: 01c70267053d ("fs: add a filesystem flag for THPs")

Multiple Fixes: are confusing.

We have two 6.18-rcX targets and one from 2020.  Are we asking people
to backport this all the way back to 2020?  If so I'd suggest the
removal of the more recent Fixes: targets.

Also, is [2/2] to be backported?  The changelog makes it sound that way,
but no Fixes: was identified?


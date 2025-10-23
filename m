Return-Path: <linux-fsdevel+bounces-65387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B143DC036D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 22:49:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 90F2435A61C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 20:49:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A52626D4EF;
	Thu, 23 Oct 2025 20:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="N2obuoXM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC33826158C;
	Thu, 23 Oct 2025 20:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761252571; cv=none; b=UI8KrFeoNUxGC3H7+xxdZFZsCHx/8L70QHJkv1TwQB3MbBBDqKuzuA3UQ/WbIZe2dxkvUe3Gad3uIG80A8At+TXi9OVb4HiAXp22FfE0AI+apXF3YYKIE6wkppMGqcHvznGRDg3LGjrXqyGC24+d2WyL0sxtlfdk7C7aSyge50I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761252571; c=relaxed/simple;
	bh=Zw7HUoU/mxy6anYY+mNGF83QxOEilwzO+J/cvE9hvo4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c/QCYd8LuZOJ5G1kCZj0pSZFJknwvZJIqNQqVfVTof4mbtQqVTGHxf/bKjo0bVq7fGwjFVtFQ6jeh+DceDIdJkWhCvC0tSTXgmKSAti54fZIgZUSqnolaGvSLWWJRnlXIUkybdn0U4zlmQpciutivIapzocIOf6xl/QKooJzMQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=N2obuoXM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B691EC4CEE7;
	Thu, 23 Oct 2025 20:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1761252570;
	bh=Zw7HUoU/mxy6anYY+mNGF83QxOEilwzO+J/cvE9hvo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=N2obuoXM9Upw3c9OeUsYyJNs0Wk4sPv787zfdDZnSst/fqNqtgiC914hOUgO0a7Dh
	 wRl85JFjBtECY82WuxEi0OSdiiYllkoB7AWvjI2QpVrHGLkVAgPK9prcwDiXMbOGNX
	 YUMV0PUqlvq4DsU0o0g1qnlfIDYydyka3fnn11xg=
Date: Thu, 23 Oct 2025 13:49:29 -0700
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
Subject: Re: [PATCHv2 1/2] mm/memory: Do not populate page table entries
 beyond i_size
Message-Id: <20251023134929.b72ab75a8c132a17ae68a582@linux-foundation.org>
In-Reply-To: <20251023093251.54146-2-kirill@shutemov.name>
References: <20251023093251.54146-1-kirill@shutemov.name>
	<20251023093251.54146-2-kirill@shutemov.name>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Oct 2025 10:32:50 +0100 Kiryl Shutsemau <kirill@shutemov.name> wrote:

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
> Signed-off-by: Kiryl Shutsemau <kas@kernel.org>
> Fixes: 19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")

Sep 28 2025

> Fixes: 357b92761d94 ("mm/filemap: map entire large folio faultaround")

Sep 28 2025

> Fixes: 800d8c63b2e9 ("shmem: add huge pages support")

Jul 26 2016

eek, what's this one doing here?  Are we asking -stable maintainers
to backport this patch into nine years worth of kernels?

I'll remove this Fixes: line for now...




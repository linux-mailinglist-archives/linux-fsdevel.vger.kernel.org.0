Return-Path: <linux-fsdevel+bounces-66322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D6F6C1BAE3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 16:33:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C37BF567AF1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 15:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39FF92F5A32;
	Wed, 29 Oct 2025 15:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGlaV1NL"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9485C2EC0B5;
	Wed, 29 Oct 2025 15:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761751189; cv=none; b=bdExmnuSqgJE3LDhjJuSBt3U/AtIE2NYTxirveunrS8Gp3zhJ4sSWjLDAfIoHaxe8YoYBUbIyiuYu4BHwP0hFBjgh1N3tdckiO6t3Ld+rmbZ8ycDuSeiJZfHekcXWUkiKBChBFfPw8bOB7NBz9XmvKgbEvalsYiktygn7zGlJ6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761751189; c=relaxed/simple;
	bh=qbQeMVbo3l/1GuPlXKkSxZu63+LRj3CaWonnsm1omOI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sh+B06jMwwe2ciduXW85azqVDxJX1WFwypan9zkJXMgzkuKZnYcBPuxmoESe+bbFO589JDa9fOximm0tcwr6T0n7PUS4Sw+YSwkrZ7QGdlBLbMLk0Q5NQid5DanR/KOgYBXjanZ26iTelk/finVFe2p1bmBro1JJcdpdGdWk3fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGlaV1NL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27021C4CEF7;
	Wed, 29 Oct 2025 15:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761751188;
	bh=qbQeMVbo3l/1GuPlXKkSxZu63+LRj3CaWonnsm1omOI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WGlaV1NLoi8Trlg7yWiQ4wTETMtoEv8SYUn51u6cYoJZDz1zsKrhloR22pgobKrtL
	 gZme/C19Cq/w9BkaBXGaAhYFqPphMZEox3vaLKF/hKQGrj4C7ktY+hd8iTjBNJWQ8U
	 ak4QYOswrIHVC7pytc+ndXaQFAEwMC1IZhPkQb4MlD6/yerKL8saSrBcz2K6QIBpG2
	 yd6Qxr0fqSIldgKyCk7PlcKquqckQ1AqLRnJDekHy8IDrnxAAcfXnqzaBg2yyt5KYa
	 nw6r6bx6jLEVJYKq8PfrrYB31z6oaeIvZv3nHtF/Y+oQXsGMMwgyqBtBJSCMTSF85x
	 CXeoVFZdWVrdA==
Date: Wed, 29 Oct 2025 08:19:47 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
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
	Dave Chinner <david@fromorbit.com>, linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 2/2] mm/truncate: Unmap large folio on split failure
Message-ID: <20251029151947.GM6174@frogsfrogsfrogs>
References: <20251023093251.54146-1-kirill@shutemov.name>
 <20251023093251.54146-3-kirill@shutemov.name>
 <9c7ae4c5-cc63-f11f-c5b0-5d539df153e1@google.com>
 <qte6322kbhn3xydiukyitgn73lbepaqlhqq43mdwhyycgdeuho@5b6wty5mcclt>
 <eaa8023f-f3e1-239d-a020-52f50df873e7@google.com>
 <xsjoxeleyacvqxmxmrw6dxzvo7ilfo7uuvlyli5kohfy4ay6uh@hsrz5jtkgpzp>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xsjoxeleyacvqxmxmrw6dxzvo7ilfo7uuvlyli5kohfy4ay6uh@hsrz5jtkgpzp>

On Wed, Oct 29, 2025 at 10:21:53AM +0000, Kiryl Shutsemau wrote:
> On Wed, Oct 29, 2025 at 02:12:48AM -0700, Hugh Dickins wrote:
> > On Mon, 27 Oct 2025, Kiryl Shutsemau wrote:
> > > On Mon, Oct 27, 2025 at 03:10:29AM -0700, Hugh Dickins wrote:
> > ...
> > > 
> > > > Aside from shmem/tmpfs, it does seem to me that this patch is
> > > > doing more work than it needs to (but how many lines of source
> > > > do we want to add to avoid doing work in the failed split case?):
> > > > 
> > > > The intent is to enable SIGBUS beyond EOF: but the changes are
> > > > being applied unnecessarily to hole-punch in addition to truncation.
> > > 
> > > I am not sure much it should apply to hole-punch. Filesystem folks talk
> > > about writing to a folio beyond round_up(i_size, PAGE_SIZE) being
> > > problematic for correctness. I have no clue if the same applies to
> > > writing to hole-punched parts of the folio.
> > > 
> > > Dave, any comments?
> > > 
> > > Hm. But if it is problematic it has be caught on fault. We don't do
> > > this. It will be silently mapped.
> > 
> > There are strict rules about what happens beyond i_size, hence this
> > patch.  But hole-punch has no persistent "i_size" to define it, and
> > silently remapping in a fresh zeroed page is the correct behaviour.
> 
> I missed that we seems to be issuing vm_ops->page_mkwrite() on remaping
> the page, so it is not completely silent for filesystem and can do its
> thing to re-allocate metadata (or whatever) after hole-punch.
> 
> So, I see unmap on punch-hole being justified.

Most hole punching implementations in filesystems will take i_rwsem and
mmap_invalidate lock, flush the range to disk and unmap the pagecache
for all the fsblocks around that range, and only then update the file
space mappings.  If the unmap fails because a PMD couldn't be split,
then we'll just return that error to userspace and they can decide what
to do when fallocate() fails.

--D

> -- 
>   Kiryl Shutsemau / Kirill A. Shutemov
> 


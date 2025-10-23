Return-Path: <linux-fsdevel+bounces-65375-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CB7C02C99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 19:47:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 435E83A6209
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Oct 2025 17:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E29430B519;
	Thu, 23 Oct 2025 17:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eHWuff3v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41DF35B150;
	Thu, 23 Oct 2025 17:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761241641; cv=none; b=n0plE7XVbTNuTucDrrlt3xqSZTlyDY3u5oVkKy2i5+HcSWEUL2LrHpGkMUBJAeC1tjNqWmuiQNCAzj3nKqQ+IbrSpj/CkIvPCwzEf6wRczjYBXBa/JKWyUxX2Ne0jzp6UF/Su/5G+XtiVLStLBExkBWv7H/+zu24IPB8ZG5z4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761241641; c=relaxed/simple;
	bh=0UjbUuHWI+/B9+mpMQaomI/3XkufAKikbowYNANqJzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qluhRPu1sGStgHhMQhrf9YHSpDaO1MORHnoONyG3RHdCxUQNMFNe+29q63FjPNRvQ8nPxPc8wDlYVHzjCpIKT78oWwePbN9vtMOS0LUr6vGa2vNzRBT9zTmUO6kLDVzM/XfuQlUeyCcNM0BNu0r0cp2OOYatx7X9AeengO12HCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eHWuff3v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260DBC4CEE7;
	Thu, 23 Oct 2025 17:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761241641;
	bh=0UjbUuHWI+/B9+mpMQaomI/3XkufAKikbowYNANqJzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eHWuff3vgCcM4s6HPc99FPHy/+VJy1z4r2xR9Bz/6yK7LYtewBpfK0r1kmkUrEPpQ
	 kLNX0iPYF1s7aoir8pqg+Ux9hDMrQQXTKiyKQ945TJt8LTqiLQGaK/TteqSLHEeaSp
	 z9nSJbdes+XLFleJbsQCLNZOf++fsbdCSQHP4aUQc0BWH/R/B8nb37Q8hA/3h9Y6Hr
	 Vky829rcJ/zd6/sDXcrr+bEIT/MFpbYVvE7AfQ7kSioZD4jUgjMXcLfS7/aLXfo1lY
	 TTZkOfm1HEahMlEAlRFYn6ozp2xsNS+nZvr9nnOY/EvMFPAodYVryDCs/reS3B0IUy
	 YVCyXAFalfYBg==
Date: Thu, 23 Oct 2025 10:47:20 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Kiryl Shutsemau <kirill@shutemov.name>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Hugh Dickins <hughd@google.com>,
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
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCHv2 0/2] Fix SIGBUS semantics with large folios
Message-ID: <20251023174720.GI6174@frogsfrogsfrogs>
References: <20251023093251.54146-1-kirill@shutemov.name>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023093251.54146-1-kirill@shutemov.name>

On Thu, Oct 23, 2025 at 10:32:49AM +0100, Kiryl Shutsemau wrote:
> From: Kiryl Shutsemau <kas@kernel.org>
> 
> Accessing memory within a VMA, but beyond i_size rounded up to the next
> page size, is supposed to generate SIGBUS.
> 
> Darrick reported[1] an xfstests regression in v6.18-rc1. generic/749
> failed due to missing SIGBUS. This was caused by my recent changes that
> try to fault in the whole folio where possible:
> 
>         19773df031bc ("mm/fault: try to map the entire file folio in finish_fault()")
>         357b92761d94 ("mm/filemap: map entire large folio faultaround")
> 
> These changes did not consider i_size when setting up PTEs, leading to
> xfstest breakage.
> 
> However, the problem has been present in the kernel for a long time -
> since huge tmpfs was introduced in 2016. The kernel happily maps
> PMD-sized folios as PMD without checking i_size. And huge=always tmpfs
> allocates PMD-size folios on any writes.
> 
> I considered this corner case when I implemented a large tmpfs, and my
> conclusion was that no one in their right mind should rely on receiving
> a SIGBUS signal when accessing beyond i_size. I cannot imagine how it
> could be useful for the workload.
> 
> But apparently filesystem folks care a lot about preserving strict
> SIGBUS semantics.
> 
> Generic/749 was introduced last year with reference to POSIX, but no
> real workloads were mentioned. It also acknowledged the tmpfs deviation
> from the test case.
> 
> POSIX indeed says[3]:
> 
>         References within the address range starting at pa and
>         continuing for len bytes to whole pages following the end of an
>         object shall result in delivery of a SIGBUS signal.
> 
> The patchset fixes the regression introduced by recent changes as well
> as more subtle SIGBUS breakage due to split failure on truncation.
> 

This fixes generic/749 for me, thanks!
Tested-by: "Darrick J. Wong" <djwong@kernel.org>

--D

> v2:
>  - Fix try_to_unmap() flags;
>  - Add warning if try_to_unmap() fails to unmap the folio;
>  - Adjust comments and commit messages;
>  - Whitespace fixes;
> v1:
>  - Drop RFC;
>  - Add Signed-off-bys;
> 
> [1] https://lore.kernel.org/all/20251014175214.GW6188@frogsfrogsfrogs
> [2]
> https://git.kernel.org/pub/scm/fs/xfs/xfstests-dev.git/commit/tests/generic/749?h=for-next&id=e4a6b119e5
> 229599eac96235fb7e683b8a8bdc53
> [3] https://pubs.opengroup.org/onlinepubs/9799919799/
> Kiryl Shutsemau (2):
>   mm/memory: Do not populate page table entries beyond i_size
>   mm/truncate: Unmap large folio on split failure
> 
>  mm/filemap.c  | 18 ++++++++++--------
>  mm/memory.c   | 13 +++++++++++--
>  mm/truncate.c | 31 +++++++++++++++++++++++++------
>  3 files changed, 46 insertions(+), 16 deletions(-)
> 
> -- 
> 2.50.1
> 
> 


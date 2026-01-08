Return-Path: <linux-fsdevel+bounces-72843-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7B2D0410F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 08 Jan 2026 16:55:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 17B0E31382E0
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Jan 2026 15:36:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4F33A0E89;
	Thu,  8 Jan 2026 14:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WGgf1BP0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE76C346AE6;
	Thu,  8 Jan 2026 14:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767881371; cv=none; b=V0isWI85HsBHLrC0RD5PoIaLTAhjSDstKJ5BcptSmZDtQabXyhFGgQY1BuFWg26QUyuERHMz3QNpD997CSLksHmINrKBo26OkX+C1EOVl3iOtEFpLtjmGf+ipUy2bBcwOfhlIUu+eGRtGWD5anqboWI+goiRPL4uQk/m+JRadh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767881371; c=relaxed/simple;
	bh=P3c0F5fCAtLj4moe7T+UZCkUl7HlEdvHhP0YnwgjgXw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bVgq6ZY2NYD1/BN+sg/1AHqlMq7e8RpoBWGexYbiGfRNS3c/z+Prrr98r2yoMpYP+10DdcjZKSjxlSxGNb40UEjkASlm6fMqIl5PT+28b+iGkhvo5bZTYVO3fpQ3YANGUuGphI5PkD2Obc70/wQpQcAvatHIPMTP+2PLdOxfrSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=WGgf1BP0; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=HojQq9q24AfBmZaxHNzm//OheDCcNKb2U02PaP3VG38=; b=WGgf1BP0kF4qcijKfc8vvVP3KC
	njFwdcyy/JN/17iRysUAEpbBQjgGtBsRnh3A3QoIOVu6tfdKfDsv8WZumYBh3GOUrUaZG8de67oYb
	mHhWAaD9IkuUOeYkE9Ze4MrkwfsTu3rlUwTIF7Jdy10xVE52IAPVGdGL/09heNvDK3KSFCVNOCj3l
	BotpXMjqnZbo1CGOYGlPqTvJeip/rUKuRlsHQ5cFilwiPPJDhgOe69xx7k/E7c0MQQj/ZmbWWefBd
	MuQkhDuZpKNRr9+0MIo5xVzH13Slb7UxOc7KwHSEoHpM6/cErYDjlnPXrtXxFL2BF8fbjQEdjzGQa
	xY6jfdTw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vdqhU-0000000F25b-090v;
	Thu, 08 Jan 2026 14:09:20 +0000
Date: Thu, 8 Jan 2026 14:09:19 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Jinchao Wang <wangjinchao600@gmail.com>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	David Hildenbrand <david@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	syzbot+2d9c96466c978346b55f@syzkaller.appspotmail.com,
	Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH 2/2] Fix an AB-BA deadlock in hugetlbfs_punch_hole()
 involving page migration.
Message-ID: <aV-6j97kTobFdYwE@casper.infradead.org>
References: <20260108123957.1123502-1-wangjinchao600@gmail.com>
 <20260108123957.1123502-2-wangjinchao600@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108123957.1123502-2-wangjinchao600@gmail.com>

On Thu, Jan 08, 2026 at 08:39:25PM +0800, Jinchao Wang wrote:
> The deadlock occurs due to the following lock ordering:
> 
> Task A (punch_hole):             Task B (migration):
> --------------------             -------------------
> 1. i_mmap_lock_write(mapping)    1. folio_lock(folio)
> 2. folio_lock(folio)             2. i_mmap_lock_read(mapping)
>    (blocks waiting for B)           (blocks waiting for A)
> 
> Task A is blocked in the punch-hole path:
>   hugetlbfs_fallocate
>     hugetlbfs_punch_hole
>       hugetlbfs_zero_partial_page
>         filemap_lock_hugetlb_folio
>           filemap_lock_folio
>             __filemap_get_folio
>               folio_lock
> 
> Task B is blocked in the migration path:
>   migrate_pages
>     migrate_hugetlbs
>       unmap_and_move_huge_page
>         remove_migration_ptes
>           __rmap_walk_file
>             i_mmap_lock_read
> 
> To break this circular dependency, use filemap_lock_folio_nowait() in
> the punch-hole path. If the folio is already locked, Task A drops the
> i_mmap_rwsem and retries. This allows Task B to finish its rmap walk
> and release the folio lock.

It looks like you didn't read the lock ordering at the top of mm/rmap.c
carefully enough:

 * hugetlbfs PageHuge() take locks in this order:
 *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
 *     vma_lock (hugetlb specific lock for pmd_sharing)
 *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
 *         folio_lock

So page migration is the one taking locks in the wrong order, not
holepunch.  Maybe something like this instead?


diff --git a/mm/migrate.c b/mm/migrate.c
index 5169f9717f60..4688b9e38cd2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1458,6 +1458,7 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 	int page_was_mapped = 0;
 	struct anon_vma *anon_vma = NULL;
 	struct address_space *mapping = NULL;
+	enum ttu_flags ttu = 0;
 
 	if (folio_ref_count(src) == 1) {
 		/* page was freed from under us. So we are done. */
@@ -1498,8 +1499,6 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 		goto put_anon;
 
 	if (folio_mapped(src)) {
-		enum ttu_flags ttu = 0;
-
 		if (!folio_test_anon(src)) {
 			/*
 			 * In shared mappings, try_to_unmap could potentially
@@ -1516,16 +1515,17 @@ static int unmap_and_move_huge_page(new_folio_t get_new_folio,
 
 		try_to_migrate(src, ttu);
 		page_was_mapped = 1;
-
-		if (ttu & TTU_RMAP_LOCKED)
-			i_mmap_unlock_write(mapping);
 	}
 
 	if (!folio_mapped(src))
 		rc = move_to_new_folio(dst, src, mode);
 
 	if (page_was_mapped)
-		remove_migration_ptes(src, !rc ? dst : src, 0);
+		remove_migration_ptes(src, !rc ? dst : src,
+				ttu ? RMP_LOCKED : 0);
+
+	if (ttu & TTU_RMAP_LOCKED)
+		i_mmap_unlock_write(mapping);
 
 unlock_put_anon:
 	folio_unlock(dst);


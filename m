Return-Path: <linux-fsdevel+bounces-38775-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 529B2A08521
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 03:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 725953A91A1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2025 02:05:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C6D1AB6C8;
	Fri, 10 Jan 2025 02:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UiXrmZMB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3694A1487CD
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Jan 2025 02:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736474727; cv=none; b=Ye3m+tVZ30XutN7nYODXn2me2ikdkgnZLm6bm1LjQ5+YaMxz5Hwqu3tRt5zue5E8K4Umj1gGeoKcgITAPp/r9If87W4M6sr0/pvMJBf0s1dDa305UPkuZdc3b9YSGJOFLbpMyr5d7LQ7VGj7hFFAW9RxVErHNJ6oGZ5E8ITX5ok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736474727; c=relaxed/simple;
	bh=2iZTIfvJhV51p2PfCh+tNRBJBhr9l1sk4HJZREW0w+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2HvuuIoWp0fc+LBr0+adJanAGKVZnRntM3N2UhTS6OnArvm1OdwL67XLMIzaMhGtMG+0OVIgrdpz2PaUooBUZE7giAbXuKzrRMhpSznzobQQ4joSSD56JjOpNYT14EbWAGfFPvTGcPPgkhRxy3gz5AIa9COnU0GslD8wioAeNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UiXrmZMB; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p9dhKvU9XCcYAmCU+SD8UILTB05m8hEzwI2hZ3bSo1U=; b=UiXrmZMB0SQHwVblwnqDo4KBTB
	96yXwqc4O3KFHxiBES5AAY8Jx3QJP5QwwlfNlw7hYiJq2JeNwoJ0PsioLun9a5ccEyW4qZi/9ucuv
	8mXo6kFeddJ45EmV4sm5uo87YQBy+uk1tPIJlKyQlVOiSCZPzzscC5Dj32ysPDGoY6GA+6ChBb7xC
	tKQg/TIzyDfv2q50emU8OjH7rANn60LbIsprzApKJ9HNSqUgCMh6BqOSRHf/oZjz+N/fz39NFqQ3J
	NZuIbolUNXX0G1LBEzf4TnQDSwT52xTP6ugMz3btam5uCZ8DB7L114flZruQsv5k+/z4wO6udSTT3
	MpbA4Lbg==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tW4On-0000000ARVW-0CXk;
	Fri, 10 Jan 2025 02:05:21 +0000
Date: Fri, 10 Jan 2025 02:05:20 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Phillip Lougher <phillip@squashfs.org.uk>,
	linux-fsdevel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 5/5] squashfs: Convert squashfs_fill_page() to take a
 folio
Message-ID: <Z4CAYCSJaF2dmJwj@casper.infradead.org>
References: <20241220224634.723899-1-willy@infradead.org>
 <20241220224634.723899-5-willy@infradead.org>
 <c37bc614-2656-44c4-9aed-c30fe6438677@squashfs.org.uk>
 <5cf5a52c-e5f4-4486-8421-c7fe913c43c4@arm.com>
 <c842632d-3924-4228-b92d-9255aae9939b@arm.com>
 <269c495b-e0f4-4c0c-aaf4-0e49823276d1@arm.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <269c495b-e0f4-4c0c-aaf4-0e49823276d1@arm.com>

On Thu, Jan 09, 2025 at 05:34:43PM +0000, Ryan Roberts wrote:
> I started getting a different oops after I fixed this issue. It turns out that
> __filemap_get_folio() returns ERR_PTR() on error whereas
> grab_cache_page_nowait() (used previously) returns NULL. So the continue
> condition needs to change. This fixes both for me:

Hey Ryan, can you try this amalgam of three patches?
If it works out, I'll send the two which aren't yet in akpm's tree to
him.

diff --git a/fs/squashfs/file.c b/fs/squashfs/file.c
index da25d6fa45ce..5ca2baa16dc2 100644
--- a/fs/squashfs/file.c
+++ b/fs/squashfs/file.c
@@ -400,7 +400,7 @@ void squashfs_copy_cache(struct folio *folio,
 			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
 		struct folio *push_folio;
 		size_t avail = buffer ? min(bytes, PAGE_SIZE) : 0;
-		bool uptodate = true;
+		bool updated = false;
 
 		TRACE("bytes %zu, i %d, available_bytes %zu\n", bytes, i, avail);
 
@@ -409,15 +409,15 @@ void squashfs_copy_cache(struct folio *folio,
 					FGP_LOCK|FGP_CREAT|FGP_NOFS|FGP_NOWAIT,
 					mapping_gfp_mask(mapping));
 
-		if (!push_folio)
+		if (IS_ERR(push_folio))
 			continue;
 
 		if (folio_test_uptodate(push_folio))
 			goto skip_folio;
 
-		uptodate = squashfs_fill_page(push_folio, buffer, offset, avail);
+		updated = squashfs_fill_page(push_folio, buffer, offset, avail);
 skip_folio:
-		folio_end_read(push_folio, uptodate);
+		folio_end_read(push_folio, updated);
 		if (i != folio->index)
 			folio_put(push_folio);
 	}
diff --git a/mm/filemap.c b/mm/filemap.c
index 12ba297bb85e..3b1eefa9aab8 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1505,7 +1505,7 @@ void folio_end_read(struct folio *folio, bool success)
 	/* Must be in bottom byte for x86 to work */
 	BUILD_BUG_ON(PG_uptodate > 7);
 	VM_BUG_ON_FOLIO(!folio_test_locked(folio), folio);
-	VM_BUG_ON_FOLIO(folio_test_uptodate(folio), folio);
+	VM_BUG_ON_FOLIO(success && folio_test_uptodate(folio), folio);
 
 	if (likely(success))
 		mask |= 1 << PG_uptodate;


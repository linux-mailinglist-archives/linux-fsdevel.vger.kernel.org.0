Return-Path: <linux-fsdevel+bounces-78678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aMGBIqksoWk/qwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78678-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 06:33:29 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF921B2E25
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 06:33:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73AA6312DDF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Feb 2026 05:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B513B3D9035;
	Fri, 27 Feb 2026 05:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QoQW8FIZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F4E3D9033;
	Fri, 27 Feb 2026 05:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772170321; cv=none; b=bhm8MwX08Rvu4JR4qrU3ADqfQ+7i9f+DCamT+ETUar7cfQwNYhniWW8guSriiZ+BVrjz8ehmHbYRCM7xrLhOyIxFWGBIl4zI0zEQIx2KWtTkRNb3zdcP8qdLeq4VHPF+JCyYC+84JRc31TZ/i7iH6FynsPB0n29bWFO+h5G4I84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772170321; c=relaxed/simple;
	bh=JJJ/bYbNkDac/ehT2CwP9hIwHMml0HxDYqNBjEG8e60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PJbdzBwqPP+tGWZJlz+/+lpd6d+Wm0CLF8CI75E0u/LyQQBMBQSBsfJ9PICUb01zd40BK3/qymXzkx7+yyFyS987DbjVP0bvCTPeE4F69HhWW4if1OVD73BTm8jC4Cbv8fZtHfkrSNONjE1CSQI/MzWZb7H2vz0kaqQzjVrVafg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QoQW8FIZ; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=FdI6HWq7bYS4a7NgUV29xJjFEF3QDoxmr5mq72kvj4s=; b=QoQW8FIZjigY7J+JkTU/Wl3Na5
	nL5dUjUVCoo21EvVW+az6uYqbCgt35JTky8ZJdW6Y/Ul1n7OlfpPsgc4S8nd2EO5Z9VtzILUjGGlV
	un+w6LmB6CgEeNLUSoWMVgMdB7SD5k78M184KJdDYJqtNrPsx0Ra6fK3EM8UHG0K2xWPHp4lH3Kxe
	fHK7Icq8qlLldjY6GvHZ7oWTwFEWCJmWotARFy6rsGEwXQRXqYi5phWN1Zcq886gJFhRfgkx96Wio
	5HMt2/pzCGhXOz5SYMD6Ywk/fQfakIpYTrunRcNnSHocvyQUQo69ESCIQov85L36TubL1qODJUGRT
	L5fhs3Rg==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvqRu-0000000443b-2Uxl;
	Fri, 27 Feb 2026 05:31:38 +0000
Date: Fri, 27 Feb 2026 05:31:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Pankaj Raghav <p.raghav@samsung.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Mike Rapoport <rppt@kernel.org>,
	David Hildenbrand <david@redhat.com>,
	Ryan Roberts <ryan.roberts@arm.com>, Michal Hocko <mhocko@suse.com>,
	Lance Yang <lance.yang@linux.dev>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nico Pache <npache@redhat.com>, Zi Yan <ziy@nvidia.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	"Liam R . Howlett" <Liam.Howlett@oracle.com>,
	Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-block@vger.kernel.org,
	linux-fsdevel@vger.kernel.org, mcgrof@kernel.org,
	gost.dev@samsung.com, kernel@pankajraghav.com, tytso@mit.edu
Subject: Re: [RFC v2 0/3] Decoupling large folios dependency on THP
Message-ID: <aaEsOu0hgCUznzl3@casper.infradead.org>
References: <20251206030858.1418814-1-p.raghav@samsung.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251206030858.1418814-1-p.raghav@samsung.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infradead.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infradead.org:s=casper.20170209];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-78678-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	DKIM_TRACE(0.00)[infradead.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willy@infradead.org,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,infradead.org:dkim]
X-Rspamd-Queue-Id: DCF921B2E25
X-Rspamd-Action: no action

On Sat, Dec 06, 2025 at 04:08:55AM +0100, Pankaj Raghav wrote:
> There are multiple solutions to solve this problem and this is one of
> them with minimal changes. I plan on discussing possible other solutions
> at the talk.

Here's an argument.  The one remaining caller of add_to_page_cache_lru()
is ramfs_nommu_expand_for_mapping().  Attached is a patch which
eliminates it ... but it doesn't compile because folio_split() is
undefined on nommu.

So either we need to reimplement all the good stuff that folio_split()
does for us, or we need to make folio_split() available on nommu.

 fs/ramfs/file-nommu.c |   53 ++++++++++++++++----------------------------------
 1 file changed, 17 insertions(+), 36 deletions(-)

diff --git a/fs/ramfs/file-nommu.c b/fs/ramfs/file-nommu.c
index 0f8e838ece07..dd789e161720 100644
--- a/fs/ramfs/file-nommu.c
+++ b/fs/ramfs/file-nommu.c
@@ -61,8 +61,8 @@ const struct inode_operations ramfs_file_inode_operations = {
  */
 int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
 {
-	unsigned long npages, xpages, loop;
-	struct page *pages;
+	unsigned long npages;
+	struct folio *folio;
 	unsigned order;
 	void *data;
 	int ret;
@@ -79,49 +79,30 @@ int ramfs_nommu_expand_for_mapping(struct inode *inode, size_t newsize)
 
 	i_size_write(inode, newsize);
 
-	/* allocate enough contiguous pages to be able to satisfy the
-	 * request */
-	pages = alloc_pages(gfp, order);
-	if (!pages)
+	folio = folio_alloc(gfp, order);
+	if (!folio)
 		return -ENOMEM;
 
-	/* split the high-order page into an array of single pages */
-	xpages = 1UL << order;
-	npages = (newsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
-
-	split_page(pages, order);
-
-	/* trim off any pages we don't actually require */
-	for (loop = npages; loop < xpages; loop++)
-		__free_page(pages + loop);
+	ret = filemap_add_folio(inode->i_mapping, folio, 0, gfp);
+	if (ret < 0)
+		goto out;
 
 	/* clear the memory we allocated */
+	npages = (newsize + PAGE_SIZE - 1) >> PAGE_SHIFT;
 	newsize = PAGE_SIZE * npages;
-	data = page_address(pages);
+	data = folio_address(folio);
 	memset(data, 0, newsize);
 
-	/* attach all the pages to the inode's address space */
-	for (loop = 0; loop < npages; loop++) {
-		struct page *page = pages + loop;
-
-		ret = add_to_page_cache_lru(page, inode->i_mapping, loop,
-					gfp);
-		if (ret < 0)
-			goto add_error;
-
-		/* prevent the page from being discarded on memory pressure */
-		SetPageDirty(page);
-		SetPageUptodate(page);
-
-		unlock_page(page);
-		put_page(page);
-	}
+	folio_mark_dirty(folio);
+	folio_mark_uptodate(folio);
 
-	return 0;
+	/* trim off any pages we don't actually require */
+	if (!is_power_of_2(npages))
+		folio_split(folio, 0, folio_page(folio, npages), NULL);
+	folio_unlock(folio);
 
-add_error:
-	while (loop < npages)
-		__free_page(pages + loop++);
+out:
+	folio_put(folio);
 	return ret;
 }
 


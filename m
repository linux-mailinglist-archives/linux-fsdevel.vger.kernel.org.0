Return-Path: <linux-fsdevel+bounces-9908-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D13E845E8B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 18:32:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DC231C26AEC
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Feb 2024 17:32:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A362B5C03B;
	Thu,  1 Feb 2024 17:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VvO8I6mm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZaP7WiUy";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="VvO8I6mm";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZaP7WiUy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC6E5C031;
	Thu,  1 Feb 2024 17:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808699; cv=none; b=V7bcB2YEZM31OvmE+nRYNjXb3Qb9aSCeDgafR/UVQZnessTn1InrQletF0/RDg+J5zov6ffnWQqFDfUinFC0xElyHERRHc5GRkuF7qZFDahx8/WtvvHVWNPNpNAZNWijpUA322EMertKsqn9SAOZnkt+F7u6Ri4t5VqMQL9KJ50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808699; c=relaxed/simple;
	bh=8fVq3yO81bkkDyBVIBkkMHHvGegw7N9KBc5LqZYSFaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aDOBAO1MSUzrugRpN3vGD+SeZ2h3igkaPBUb1zTVkIw+mzY9euDbnLM/SJKKzAGtujZjcJXnTpVbulEprtDeM3+pkcPLsyI+Jc5xujaebE9AUJO17H1Jv1ux/sthIXhiKJs9QJimmlijgViC0pjRyBMPvndyhq127uIL91hhXlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VvO8I6mm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZaP7WiUy; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=VvO8I6mm; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZaP7WiUy; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 15BAD22160;
	Thu,  1 Feb 2024 17:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706808695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QguttrHsVS3cPDTJkD8X09WbYsu7VbANTr0/nI94OQ=;
	b=VvO8I6mmAOH7rhZ1dN8pb9yH4HALUaqhv3B/k/v5z9HUybtkYXWlzsXsGfywnD3gcfeGUt
	MDVL7hsXlIobifKvMSY5PhRKxoqOPGK5JMUjjd76l+maPZ/n/tcz2hr665j36roJaVnl8G
	rFacZutRx/yKygZ08rItPtmLzA9c9so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706808695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QguttrHsVS3cPDTJkD8X09WbYsu7VbANTr0/nI94OQ=;
	b=ZaP7WiUy71dC+3jRYMulb8jJrGL/znH4nUTHKv2/scF1GeGbO7ZqgcmiDZcsXHL5Zvbuvp
	sHFdyratx2A8CeCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706808695; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QguttrHsVS3cPDTJkD8X09WbYsu7VbANTr0/nI94OQ=;
	b=VvO8I6mmAOH7rhZ1dN8pb9yH4HALUaqhv3B/k/v5z9HUybtkYXWlzsXsGfywnD3gcfeGUt
	MDVL7hsXlIobifKvMSY5PhRKxoqOPGK5JMUjjd76l+maPZ/n/tcz2hr665j36roJaVnl8G
	rFacZutRx/yKygZ08rItPtmLzA9c9so=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706808695;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3QguttrHsVS3cPDTJkD8X09WbYsu7VbANTr0/nI94OQ=;
	b=ZaP7WiUy71dC+3jRYMulb8jJrGL/znH4nUTHKv2/scF1GeGbO7ZqgcmiDZcsXHL5Zvbuvp
	sHFdyratx2A8CeCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 06199139AB;
	Thu,  1 Feb 2024 17:31:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hMNzAXfVu2WPJgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 01 Feb 2024 17:31:35 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9D42EA0809; Thu,  1 Feb 2024 18:31:30 +0100 (CET)
Date: Thu, 1 Feb 2024 18:31:30 +0100
From: Jan Kara <jack@suse.cz>
To: Liu Shixin <liushixin2@huawei.com>
Cc: Jan Kara <jack@suse.cz>, Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] mm/readahead: limit sync readahead while too many
 active refault
Message-ID: <20240201173130.frpaqpy7iyzias5j@quack3>
References: <20240201100835.1626685-1-liushixin2@huawei.com>
 <20240201100835.1626685-3-liushixin2@huawei.com>
 <20240201093749.ll7uzgt7ixy7kkhw@quack3>
 <c768cab9-4ccb-9618-24a8-b51d3f141340@huawei.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3ct7qtyk6r2k3prh"
Content-Disposition: inline
In-Reply-To: <c768cab9-4ccb-9618-24a8-b51d3f141340@huawei.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	 HAS_ATTACHMENT(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[9];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+,1:+,2:+,3:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO


--3ct7qtyk6r2k3prh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu 01-02-24 18:41:30, Liu Shixin wrote:
> On 2024/2/1 17:37, Jan Kara wrote:
> > On Thu 01-02-24 18:08:35, Liu Shixin wrote:
> >> When the pagefault is not for write and the refault distance is close,
> >> the page will be activated directly. If there are too many such pages in
> >> a file, that means the pages may be reclaimed immediately.
> >> In such situation, there is no positive effect to read-ahead since it will
> >> only waste IO. So collect the number of such pages and when the number is
> >> too large, stop bothering with read-ahead for a while until it decreased
> >> automatically.
> >>
> >> Define 'too large' as 10000 experientially, which can solves the problem
> >> and does not affect by the occasional active refault.
> >>
> >> Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> > So I'm not convinced this new logic is needed. We already have
> > ra->mmap_miss which gets incremented when a page fault has to read the page
> > (and decremented when a page fault found the page already in cache). This
> > should already work to detect trashing as well, shouldn't it? If it does
> > not, why?
> >
> > 								Honza
> ra->mmap_miss doesn't help, it increased only one in do_sync_mmap_readahead()
> and then decreased one for every page in filemap_map_pages(). So in this scenario,
> it can't exceed MMAP_LOTSAMISS.

I see, OK. But that's a (longstanding) bug in how mmap_miss is handled. Can
you please test whether attached patches fix the trashing for you? At least
now I can see mmap_miss properly increments when we are hitting uncached
pages...  Thanks!

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

--3ct7qtyk6r2k3prh
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-mm-readahead-Improve-page-readaround-miss-detection.patch"

From f7879373941b7a90b0d30967ec798c000a5ef7b1 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 1 Feb 2024 14:56:33 +0100
Subject: [PATCH 1/2] mm/readahead: Improve page readaround miss detection

filemap_map_pages() decreases ra->mmap_miss for every page it maps. This
however overestimates number of real cache hits because we have no idea
whether the application will use the pages we map or not. This is
problematic in particular in memory constrained situations where we
think we have great readahead success rate although in fact we are just
trashing page cache & disk. Change filemap_map_pages() to count only
success of mapping the page we are faulting in. This should be actually
enough to keep mmap_miss close to 0 for workloads doing sequential reads
because filemap_map_pages() does not map page with readahead flag and
thus these are going to contribute to decreasing the mmap_miss counter.

Reported-by: Liu Shixin <liushixin2@huawei.com>
Fixes: f1820361f83d ("mm: implement ->map_pages for page cache")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/filemap.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 750e779c23db..0b843f99407c 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3436,8 +3436,7 @@ static struct folio *next_uptodate_folio(struct xa_state *xas,
  */
 static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 			struct folio *folio, unsigned long start,
-			unsigned long addr, unsigned int nr_pages,
-			unsigned int *mmap_miss)
+			unsigned long addr, unsigned int nr_pages)
 {
 	vm_fault_t ret = 0;
 	struct page *page = folio_page(folio, start);
@@ -3448,8 +3447,6 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 		if (PageHWPoison(page + count))
 			goto skip;
 
-		(*mmap_miss)++;
-
 		/*
 		 * NOTE: If there're PTE markers, we'll leave them to be
 		 * handled in the specific fault path, and it'll prohibit the
@@ -3488,8 +3485,7 @@ static vm_fault_t filemap_map_folio_range(struct vm_fault *vmf,
 }
 
 static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
-		struct folio *folio, unsigned long addr,
-		unsigned int *mmap_miss)
+		struct folio *folio, unsigned long addr)
 {
 	vm_fault_t ret = 0;
 	struct page *page = &folio->page;
@@ -3497,8 +3493,6 @@ static vm_fault_t filemap_map_order0_folio(struct vm_fault *vmf,
 	if (PageHWPoison(page))
 		return ret;
 
-	(*mmap_miss)++;
-
 	/*
 	 * NOTE: If there're PTE markers, we'll leave them to be
 	 * handled in the specific fault path, and it'll prohibit
@@ -3527,7 +3521,7 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 	XA_STATE(xas, &mapping->i_pages, start_pgoff);
 	struct folio *folio;
 	vm_fault_t ret = 0;
-	unsigned int nr_pages = 0, mmap_miss = 0, mmap_miss_saved;
+	unsigned int nr_pages = 0;
 
 	rcu_read_lock();
 	folio = next_uptodate_folio(&xas, mapping, end_pgoff);
@@ -3556,12 +3550,11 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 		nr_pages = min(end, end_pgoff) - xas.xa_index + 1;
 
 		if (!folio_test_large(folio))
-			ret |= filemap_map_order0_folio(vmf,
-					folio, addr, &mmap_miss);
+			ret |= filemap_map_order0_folio(vmf, folio, addr);
 		else
 			ret |= filemap_map_folio_range(vmf, folio,
 					xas.xa_index - folio->index, addr,
-					nr_pages, &mmap_miss);
+					nr_pages);
 
 		folio_unlock(folio);
 		folio_put(folio);
@@ -3570,11 +3563,23 @@ vm_fault_t filemap_map_pages(struct vm_fault *vmf,
 out:
 	rcu_read_unlock();
 
-	mmap_miss_saved = READ_ONCE(file->f_ra.mmap_miss);
-	if (mmap_miss >= mmap_miss_saved)
-		WRITE_ONCE(file->f_ra.mmap_miss, 0);
-	else
-		WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss_saved - mmap_miss);
+	/* VM_FAULT_NOPAGE means we succeeded in mapping desired page */
+	if (ret == VM_FAULT_NOPAGE) {
+		unsigned int mmap_miss = READ_ONCE(file->f_ra.mmap_miss);
+
+		/*
+		 * We've found the page we needed in the page cache, decrease
+		 * mmap_miss. Note that we don't decrease mmap_miss for every
+		 * page we've mapped because we don't know whether the process
+		 * will actually use them. We will thus underestimate number of
+		 * page cache hits but the least the page marked with readahead
+		 * flag will not be mapped by filemap_map_pages() and this will
+		 * contribute to decreasing mmap_miss to make up for occasional
+		 * fault miss.
+		 */
+		if (mmap_miss)
+			WRITE_ONCE(file->f_ra.mmap_miss, mmap_miss - 1);
+	}
 
 	return ret;
 }
-- 
2.35.3


--3ct7qtyk6r2k3prh
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-mm-readahead-Fix-readahead-miss-detection-with-FAULT.patch"

From b1620b02a1ba81f5c6848eca4fd148e9520eafc6 Mon Sep 17 00:00:00 2001
From: Jan Kara <jack@suse.cz>
Date: Thu, 1 Feb 2024 17:28:23 +0100
Subject: [PATCH 2/2] mm/readahead: Fix readahead miss detection with
 FAULT_FLAG_RETRY_NOWAIT

When the page fault happens with FAULT_FLAG_RETRY_NOWAIT (which is
common) we will bail out of the page fault after issuing reads and retry
the fault. That will then find the created pages in filemap_map_pages()
and hence will be treated as cache hit canceling out the cache miss in
do_sync_mmap_readahead(). Increment mmap_miss by two in
do_sync_mmap_readahead() in case FAULT_FLAG_RETRY_NOWAIT is set to
account for the following expected hit. If the page gets evicted even
before we manage to retry the fault, we are under so heavy memory
pressure that increasing mmap_miss by two is fine.

Reported-by: Liu Shixin <liushixin2@huawei.com>
Fixes: d065bd810b6d ("mm: retry page fault when blocking on disk transfer")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/filemap.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/filemap.c b/mm/filemap.c
index 0b843f99407c..2dda5dc04517 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -3132,8 +3132,14 @@ static struct file *do_sync_mmap_readahead(struct vm_fault *vmf)
 
 	/* Avoid banging the cache line if not needed */
 	mmap_miss = READ_ONCE(ra->mmap_miss);
+	/*
+	 * Increment mmap_miss by 2 if we are going to bail out of fault after
+	 * issuing IO as we will then go back and map the cached page which is
+	 * accounted as a cache hit.
+	 */
+	mmap_miss += 1 + !!(vmf->flags & FAULT_FLAG_RETRY_NOWAIT);
 	if (mmap_miss < MMAP_LOTSAMISS * 10)
-		WRITE_ONCE(ra->mmap_miss, ++mmap_miss);
+		WRITE_ONCE(ra->mmap_miss, mmap_miss);
 
 	/*
 	 * Do we miss much more than hit in this file? If so,
-- 
2.35.3


--3ct7qtyk6r2k3prh--


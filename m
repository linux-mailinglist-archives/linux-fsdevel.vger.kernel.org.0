Return-Path: <linux-fsdevel+bounces-22312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B66CD916520
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35D411F21C73
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25BE514AD38;
	Tue, 25 Jun 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6XL5W2b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdQLeaCI";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="g6XL5W2b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="vdQLeaCI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67B3C14A4C7
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310754; cv=none; b=bjjcl+Y/aVQTn5gGwL7nY/bQy2jx5Ww7rrVdruH7rPygvVf2Nen2EBJiLC2GVqhcErDOxebOPjQ5w1ujs3CzuV9F916gtI4/DPKYHRrnpdTAEdxMy5dKvHlmfVFruyQgpqF9RYvdJXTXfqHJuU8kctF1KTk78D4VxGKEGEzQ+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310754; c=relaxed/simple;
	bh=kzZAggEGB8nxww3IMybdnW/wrXAOWD0Xm8Cb8kJ8pv4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P0neKwCvxbBGPmi0RhScoL9Xin3LqbVUHy0f0ydKxUdCepM6Ko5aHvK3wZpHugMTbi2Q/fEVy32a/ypE1P0ZqsNyrvwtS5DQZpri4HGBlc18n1cYSTnq0XKWCGV58KqJCOPXPRGLz8hYpR7iGUUq5mXTYYlWKmEAPTtZu6Bsvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6XL5W2b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdQLeaCI; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=g6XL5W2b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=vdQLeaCI; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD8471F851;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QN4nEN9WKE2t9Mr+WNlqEXF1yaaR/IE18O8y0vBXQ8=;
	b=g6XL5W2bx1lBimk/YVoIuBtM965nhwDCu2xk9Onv41jmFcbHqn9KuvihvDSSaLuHEowOJ2
	/UN5aJGYMF4LA2+46i33DojSXDUa6jeXRssH/ht/bvel2vGoHwJD0U5xKGqdCY+Flcwreh
	S7zRmJNxULCDmjwdOhB7PKc68UFbZlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QN4nEN9WKE2t9Mr+WNlqEXF1yaaR/IE18O8y0vBXQ8=;
	b=vdQLeaCImos+Rr80rKGiS+1VVpK2XFb71QhEaeaFB/E7YvP4OYXu0EjLI7e+0o5rsVUNQh
	s0hkst8/4/1bojBA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QN4nEN9WKE2t9Mr+WNlqEXF1yaaR/IE18O8y0vBXQ8=;
	b=g6XL5W2bx1lBimk/YVoIuBtM965nhwDCu2xk9Onv41jmFcbHqn9KuvihvDSSaLuHEowOJ2
	/UN5aJGYMF4LA2+46i33DojSXDUa6jeXRssH/ht/bvel2vGoHwJD0U5xKGqdCY+Flcwreh
	S7zRmJNxULCDmjwdOhB7PKc68UFbZlQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QN4nEN9WKE2t9Mr+WNlqEXF1yaaR/IE18O8y0vBXQ8=;
	b=vdQLeaCImos+Rr80rKGiS+1VVpK2XFb71QhEaeaFB/E7YvP4OYXu0EjLI7e+0o5rsVUNQh
	s0hkst8/4/1bojBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8BCAA13AD9;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zTIcIp6ZemaDWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0AA73A0958; Tue, 25 Jun 2024 12:19:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 08/10] readahead: Disentangle async and sync readahead
Date: Tue, 25 Jun 2024 12:18:58 +0200
Message-Id: <20240625101909.12234-8-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7472; i=jack@suse.cz; h=from:subject; bh=kzZAggEGB8nxww3IMybdnW/wrXAOWD0Xm8Cb8kJ8pv4=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmSvtCyAHd7WRo5r/OLGFdaWl9D2kCzIBgqLdiE FKlKbk2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZkgAKCRCcnaoHP2RA2eLXB/ 0dO6bkv2zDY47lCTrKzJepiIL+qGydhiLaAQjXHcOGbE4kM8EnU8XQLHG5D+SfUNxo/nBCcqGAnyHC Jyi3YPBdfzpZuxcK7Yp8LckjSCPEe++CiPP5kJ8RSkAy1sf7srpMB7bezdySY1DTPVcuAKPW3UZzek gHUq0IyvUhMercFXtAd1A8VQdDi8z43l06WseCBgtK7Pw/kMFHFPHGdgedUfgsCwYaP7uzkAw/yBs2 cURzHIg5Q7/6xzNEAPoH6t7/E/3VAdnQZrJwaI9/VJzcby2Ujo6GCNyAslXUyeAZXyqlyXXdzUgVtI UT04cbN4zUManqKe7GMOhZQ5vimZDQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]

Both async and sync readahead are handled by ondemand_readahead()
function. However there isn't actually much in common. Just move async
related parts into page_cache_ra_async() and sync related parts to
page_cache_ra_sync(). No functional changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 162 +++++++++++++++++++++++--------------------------
 1 file changed, 77 insertions(+), 85 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index d92a5e8d89c4..a44daa12ebd2 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -540,18 +540,11 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	do_page_cache_ra(ractl, ra->size - (index - start), ra->async_size);
 }
 
-/*
- * A minimal readahead algorithm for trivial sequential/random reads.
- */
-static void ondemand_readahead(struct readahead_control *ractl,
-		struct folio *folio, unsigned long req_size)
+static unsigned long ractl_max_pages(struct readahead_control *ractl,
+		unsigned long req_size)
 {
 	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
-	struct file_ra_state *ra = ractl->ra;
-	unsigned long max_pages = ra->ra_pages;
-	pgoff_t index = readahead_index(ractl);
-	pgoff_t expected, prev_index;
-	unsigned int order = folio ? folio_order(folio) : 0;
+	unsigned long max_pages = ractl->ra->ra_pages;
 
 	/*
 	 * If the request exceeds the readahead window, allow the read to
@@ -559,55 +552,42 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 */
 	if (req_size > max_pages && bdi->io_pages > max_pages)
 		max_pages = min(req_size, bdi->io_pages);
+	return max_pages;
+}
 
-	/*
-	 * start of file
-	 */
-	if (!index)
-		goto initial_readahead;
-
-	/*
-	 * It's the expected callback index, assume sequential access.
-	 * Ramp up sizes, and push forward the readahead window.
-	 */
-	expected = round_down(ra->start + ra->size - ra->async_size,
-			1UL << order);
-	if (folio && index == expected) {
-		ra->start += ra->size;
-		ra->size = get_next_ra_size(ra, max_pages);
-		ra->async_size = ra->size;
-		goto readit;
-	}
+void page_cache_sync_ra(struct readahead_control *ractl,
+		unsigned long req_count)
+{
+	pgoff_t index = readahead_index(ractl);
+	bool do_forced_ra = ractl->file && (ractl->file->f_mode & FMODE_RANDOM);
+	struct file_ra_state *ra = ractl->ra;
+	unsigned long max_pages;
+	pgoff_t prev_index;
 
 	/*
-	 * Hit a marked folio without valid readahead state.
-	 * E.g. interleaved reads.
-	 * Query the pagecache for async_size, which normally equals to
-	 * readahead size. Ramp it up and use it as the new readahead size.
+	 * Even if readahead is disabled, issue this request as readahead
+	 * as we'll need it to satisfy the requested range. The forced
+	 * readahead will do the right thing and limit the read to just the
+	 * requested range, which we'll set to 1 page for this case.
 	 */
-	if (folio) {
-		pgoff_t start;
-
-		rcu_read_lock();
-		start = page_cache_next_miss(ractl->mapping, index + 1,
-				max_pages);
-		rcu_read_unlock();
-
-		if (!start || start - index > max_pages)
+	if (!ra->ra_pages || blk_cgroup_congested()) {
+		if (!ractl->file)
 			return;
+		req_count = 1;
+		do_forced_ra = true;
+	}
 
-		ra->start = start;
-		ra->size = start - index;	/* old async_size */
-		ra->size += req_size;
-		ra->size = get_next_ra_size(ra, max_pages);
-		ra->async_size = ra->size;
-		goto readit;
+	/* be dumb */
+	if (do_forced_ra) {
+		force_page_cache_ra(ractl, req_count);
+		return;
 	}
 
+	max_pages = ractl_max_pages(ractl, req_count);
 	/*
-	 * oversize read
+	 * start of file or oversized read
 	 */
-	if (req_size > max_pages)
+	if (!index || req_count > max_pages)
 		goto initial_readahead;
 
 	/*
@@ -623,7 +603,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * Query the page cache and look for the traces(cached history pages)
 	 * that a sequential stream would leave behind.
 	 */
-	if (try_context_readahead(ractl->mapping, ra, index, req_size,
+	if (try_context_readahead(ractl->mapping, ra, index, req_count,
 			max_pages))
 		goto readit;
 
@@ -631,53 +611,31 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 * standalone, small random read
 	 * Read as is, and do not pollute the readahead state.
 	 */
-	do_page_cache_ra(ractl, req_size, 0);
+	do_page_cache_ra(ractl, req_count, 0);
 	return;
 
 initial_readahead:
 	ra->start = index;
-	ra->size = get_init_ra_size(req_size, max_pages);
-	ra->async_size = ra->size > req_size ? ra->size - req_size :
-					       ra->size >> 1;
-
+	ra->size = get_init_ra_size(req_count, max_pages);
+	ra->async_size = ra->size > req_count ? ra->size - req_count :
+						ra->size >> 1;
 readit:
 	ractl->_index = ra->start;
-	page_cache_ra_order(ractl, ra, order);
-}
-
-void page_cache_sync_ra(struct readahead_control *ractl,
-		unsigned long req_count)
-{
-	bool do_forced_ra = ractl->file && (ractl->file->f_mode & FMODE_RANDOM);
-
-	/*
-	 * Even if readahead is disabled, issue this request as readahead
-	 * as we'll need it to satisfy the requested range. The forced
-	 * readahead will do the right thing and limit the read to just the
-	 * requested range, which we'll set to 1 page for this case.
-	 */
-	if (!ractl->ra->ra_pages || blk_cgroup_congested()) {
-		if (!ractl->file)
-			return;
-		req_count = 1;
-		do_forced_ra = true;
-	}
-
-	/* be dumb */
-	if (do_forced_ra) {
-		force_page_cache_ra(ractl, req_count);
-		return;
-	}
-
-	ondemand_readahead(ractl, NULL, req_count);
+	page_cache_ra_order(ractl, ra, 0);
 }
 EXPORT_SYMBOL_GPL(page_cache_sync_ra);
 
 void page_cache_async_ra(struct readahead_control *ractl,
 		struct folio *folio, unsigned long req_count)
 {
+	unsigned long max_pages;
+	struct file_ra_state *ra = ractl->ra;
+	pgoff_t index = readahead_index(ractl);
+	pgoff_t expected, start;
+	unsigned int order = folio_order(folio);
+
 	/* no readahead */
-	if (!ractl->ra->ra_pages)
+	if (!ra->ra_pages)
 		return;
 
 	/*
@@ -691,7 +649,41 @@ void page_cache_async_ra(struct readahead_control *ractl,
 	if (blk_cgroup_congested())
 		return;
 
-	ondemand_readahead(ractl, folio, req_count);
+	max_pages = ractl_max_pages(ractl, req_count);
+	/*
+	 * It's the expected callback index, assume sequential access.
+	 * Ramp up sizes, and push forward the readahead window.
+	 */
+	expected = round_down(ra->start + ra->size - ra->async_size,
+			1UL << order);
+	if (index == expected) {
+		ra->start += ra->size;
+		ra->size = get_next_ra_size(ra, max_pages);
+		ra->async_size = ra->size;
+		goto readit;
+	}
+
+	/*
+	 * Hit a marked folio without valid readahead state.
+	 * E.g. interleaved reads.
+	 * Query the pagecache for async_size, which normally equals to
+	 * readahead size. Ramp it up and use it as the new readahead size.
+	 */
+	rcu_read_lock();
+	start = page_cache_next_miss(ractl->mapping, index + 1, max_pages);
+	rcu_read_unlock();
+
+	if (!start || start - index > max_pages)
+		return;
+
+	ra->start = start;
+	ra->size = start - index;	/* old async_size */
+	ra->size += req_count;
+	ra->size = get_next_ra_size(ra, max_pages);
+	ra->async_size = ra->size;
+readit:
+	ractl->_index = ra->start;
+	page_cache_ra_order(ractl, ra, order);
 }
 EXPORT_SYMBOL_GPL(page_cache_async_ra);
 
-- 
2.35.3



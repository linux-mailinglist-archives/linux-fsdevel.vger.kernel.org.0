Return-Path: <linux-fsdevel+bounces-22311-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E02C0916521
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 974F3281CF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C2E14B064;
	Tue, 25 Jun 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JmDEVsny";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xWktmHdd";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JmDEVsny";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xWktmHdd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5A014A4C0
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310754; cv=none; b=L3Q06CxOYzt9JiQbc4/w/ms3jfab6vXDjUqcbYT1nxij5MGJj9kmKnsWp6Gwv5uuSnDnFgOe4PjzoVcXXEPUv/y20RPve2PmB8e7Pxtr+iyl0F6De4T2/c+ueZs8y0BcJS9Kk9Wy4mQkrBa6mogWnC4Xsgql9HAH8K0R4fu73tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310754; c=relaxed/simple;
	bh=1E7MXXKYPrw3MTlpAhRlnbE6/sd+3vrz3Oi0fWfrESc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lgm6L0lEBs6kOIbUK2zEQPgDlAfEnQxKNc5XCnH05m6vcCGp+PEJBczLgt590pz6m7if0qerjWNJqL2/nrILMTEmUeY2vFrDMBEg3zMIFmWoG0OD/F/yZEdNWMKpQoLl1hnOX1X/BQ3Js8u0O6gkuGe9tNljVo9qSaBwd77s3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JmDEVsny; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xWktmHdd; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=JmDEVsny; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xWktmHdd; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 9AA5A1F850;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1HXAqj4fgZF3IBo1CB4bn3i39dMk3y6JrzdfxQccxs=;
	b=JmDEVsnyYknVUA8/3NzWzbdFr1DvMcLwFTk51FWNZUb+5+ubt7ec2MOHPKj+l4uwoR09GG
	ucPE+ngfD5BDg/AaAyXUUgW2mBsj3Hb6cXwSozaSbXn7VgA0fmvFw+pEVLsZxRo7ZRs1on
	ltAagy5F+Tf/B8+HZP7UkqoyARUySV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1HXAqj4fgZF3IBo1CB4bn3i39dMk3y6JrzdfxQccxs=;
	b=xWktmHddUmOllDfb/XAwt8UC0TSzeT0lKN1u4Ub0oLuIeaLdYkC0YpAuszw7LfrBFiqCkq
	YUAW1W26baZgL0AA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JmDEVsny;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=xWktmHdd
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1HXAqj4fgZF3IBo1CB4bn3i39dMk3y6JrzdfxQccxs=;
	b=JmDEVsnyYknVUA8/3NzWzbdFr1DvMcLwFTk51FWNZUb+5+ubt7ec2MOHPKj+l4uwoR09GG
	ucPE+ngfD5BDg/AaAyXUUgW2mBsj3Hb6cXwSozaSbXn7VgA0fmvFw+pEVLsZxRo7ZRs1on
	ltAagy5F+Tf/B8+HZP7UkqoyARUySV0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t1HXAqj4fgZF3IBo1CB4bn3i39dMk3y6JrzdfxQccxs=;
	b=xWktmHddUmOllDfb/XAwt8UC0TSzeT0lKN1u4Ub0oLuIeaLdYkC0YpAuszw7LfrBFiqCkq
	YUAW1W26baZgL0AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E90213ADB;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2mbNIp6ZemaEWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 11A80A0959; Tue, 25 Jun 2024 12:19:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 09/10] readahead: Fold try_context_readahead() into its single caller
Date: Tue, 25 Jun 2024 12:18:59 +0200
Message-Id: <20240625101909.12234-9-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3529; i=jack@suse.cz; h=from:subject; bh=1E7MXXKYPrw3MTlpAhRlnbE6/sd+3vrz3Oi0fWfrESc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmTxfL2AnX6xjFCTZIXemzzgVjcZY/mbaACqC9D b7l4ukeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZkwAKCRCcnaoHP2RA2ULTCA C42Af5j1m3W6QOH/yr7+kHSYKnjj2QgCuJyEAbWwVKxOCcN0N+Olqw/+ZO6BVqISD2Q/SX/2YDQjtg whoRGFB4y2QbNjVofmkB2/cq7eSQ2oapnZf/6pVaZtb7teQuRHR0ID43l53sDCZlzl6YzWvaeEFozi rgrtmGjwY+Ve5HoBGdP6QpWfFuxepgabt5TPSFL2xz3rK5f8hE4VC5kASIC/0OoyjpXzNC0G3lOvcX xcJmK34oh6y2TjAKbnqw+8K/cliMtIvzPshjtC5jKg7HD31j4Y6bpC//o6MZIJdmGOdAK3++or2InK tQsfNhcns6P6G7J+UrQMQRGBFVFtFE
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9AA5A1F850
X-Spam-Score: -3.01
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

try_context_readahead() has a single caller page_cache_sync_ra(). Fold
the function there to make ra state modifications more obvious. No
functional changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 84 +++++++++++++-------------------------------------
 1 file changed, 22 insertions(+), 62 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index a44daa12ebd2..12c0d2215329 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -410,58 +410,6 @@ static unsigned long get_next_ra_size(struct file_ra_state *ra,
  * it approaches max_readhead.
  */
 
-/*
- * Count contiguously cached pages from @index-1 to @index-@max,
- * this count is a conservative estimation of
- * 	- length of the sequential read sequence, or
- * 	- thrashing threshold in memory tight systems
- */
-static pgoff_t count_history_pages(struct address_space *mapping,
-				   pgoff_t index, unsigned long max)
-{
-	pgoff_t head;
-
-	rcu_read_lock();
-	head = page_cache_prev_miss(mapping, index - 1, max);
-	rcu_read_unlock();
-
-	return index - 1 - head;
-}
-
-/*
- * page cache context based readahead
- */
-static int try_context_readahead(struct address_space *mapping,
-				 struct file_ra_state *ra,
-				 pgoff_t index,
-				 unsigned long req_size,
-				 unsigned long max)
-{
-	pgoff_t size;
-
-	size = count_history_pages(mapping, index, max);
-
-	/*
-	 * not enough history pages:
-	 * it could be a random read
-	 */
-	if (size <= req_size)
-		return 0;
-
-	/*
-	 * starts from beginning of file:
-	 * it is a strong indication of long-run stream (or whole-file-read)
-	 */
-	if (size >= index)
-		size *= 2;
-
-	ra->start = index;
-	ra->size = min(size + req_size, max);
-	ra->async_size = 1;
-
-	return 1;
-}
-
 static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
 		pgoff_t mark, unsigned int order, gfp_t gfp)
 {
@@ -561,8 +509,8 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	pgoff_t index = readahead_index(ractl);
 	bool do_forced_ra = ractl->file && (ractl->file->f_mode & FMODE_RANDOM);
 	struct file_ra_state *ra = ractl->ra;
-	unsigned long max_pages;
-	pgoff_t prev_index;
+	unsigned long max_pages, contig_count;
+	pgoff_t prev_index, miss;
 
 	/*
 	 * Even if readahead is disabled, issue this request as readahead
@@ -603,16 +551,28 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	 * Query the page cache and look for the traces(cached history pages)
 	 * that a sequential stream would leave behind.
 	 */
-	if (try_context_readahead(ractl->mapping, ra, index, req_count,
-			max_pages))
-		goto readit;
-
+	rcu_read_lock();
+	miss = page_cache_prev_miss(ractl->mapping, index - 1, max_pages);
+	rcu_read_unlock();
+	contig_count = index - miss - 1;
 	/*
-	 * standalone, small random read
-	 * Read as is, and do not pollute the readahead state.
+	 * Standalone, small random read. Read as is, and do not pollute the
+	 * readahead state.
 	 */
-	do_page_cache_ra(ractl, req_count, 0);
-	return;
+	if (contig_count <= req_count) {
+		do_page_cache_ra(ractl, req_count, 0);
+		return;
+	}
+	/*
+	 * File cached from the beginning:
+	 * it is a strong indication of long-run stream (or whole-file-read)
+	 */
+	if (miss == ULONG_MAX)
+		contig_count *= 2;
+	ra->start = index;
+	ra->size = min(contig_count + req_count, max_pages);
+	ra->async_size = 1;
+	goto readit;
 
 initial_readahead:
 	ra->start = index;
-- 
2.35.3



Return-Path: <linux-fsdevel+bounces-22316-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3B02916525
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985CE2823B0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5583714B961;
	Tue, 25 Jun 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GDIuGNll";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDTO+LRc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GDIuGNll";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="VDTO+LRc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC4714B07C
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310756; cv=none; b=RlBwhm0hi5/qmJI1+sA7p59yhRkoEC8TLFsNKSxcF0YgDrFLQ+LoYiF0wX68HUdlnwlsTk5gqOflSIaMljmsNooXb+qVwG9tly+hGbj8cOCwe4xLW7DxVVATfijlHVfOddAFhcBjZ8aoVsu24Mpv70kEbE0jbL7hufseP+csfeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310756; c=relaxed/simple;
	bh=Bu7YUmZoT9vACQSaTZDW2SetomtAJn73UDFWVLSHt8E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QPz0M0yiGN32tiX4frMvlOSm4/pH571o2sNP8SNxMlC+YrPiYCfzMWqIZxwW2aFelmq0SJkQ/FAMUIxBKTndj/OxKPVb04wjnNJkEdcHG9rxNKiHMh9/Lh0/gwP2i/LqjtLYPQUJtQOdfqwTPpnN4VOD2lRdhP3R9WNl+9RC8Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GDIuGNll; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDTO+LRc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GDIuGNll; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=VDTO+LRc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9A0FB21A79;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyxwvvsZ7JcW5Bl3ExPGCArwxKk1bgXwcn4XRHBgVco=;
	b=GDIuGNll6Qe2PeuRVsfKphDYbItj3AF5g43txEQCUQJAggZ6VXUKHHY9bZ+gjMr0yY+GbI
	84qjRTOGYMW7tJYx9O8On/Hr4C6H5HGwZNYJh8AeeCGpo6BSXa6XpwI3TC56DJ9C30Yhau
	7dz3o12FaNDLe8XcftJwZ+VT9nQNvb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyxwvvsZ7JcW5Bl3ExPGCArwxKk1bgXwcn4XRHBgVco=;
	b=VDTO+LRc94g0SdBAa/BekynpkCYovk3M7Lh9FdpVcOjuso/mEHBO7mhbuyV1D8UlapQz14
	poFwR1XOAms4beAQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GDIuGNll;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=VDTO+LRc
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyxwvvsZ7JcW5Bl3ExPGCArwxKk1bgXwcn4XRHBgVco=;
	b=GDIuGNll6Qe2PeuRVsfKphDYbItj3AF5g43txEQCUQJAggZ6VXUKHHY9bZ+gjMr0yY+GbI
	84qjRTOGYMW7tJYx9O8On/Hr4C6H5HGwZNYJh8AeeCGpo6BSXa6XpwI3TC56DJ9C30Yhau
	7dz3o12FaNDLe8XcftJwZ+VT9nQNvb0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vyxwvvsZ7JcW5Bl3ExPGCArwxKk1bgXwcn4XRHBgVco=;
	b=VDTO+LRc94g0SdBAa/BekynpkCYovk3M7Lh9FdpVcOjuso/mEHBO7mhbuyV1D8UlapQz14
	poFwR1XOAms4beAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8E8CE13ADA;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 1ZjMIp6ZemaFWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 19B82A095B; Tue, 25 Jun 2024 12:19:10 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 10/10] readahead: Simplify gotos in page_cache_sync_ra()
Date: Tue, 25 Jun 2024 12:19:00 +0200
Message-Id: <20240625101909.12234-10-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1867; i=jack@suse.cz; h=from:subject; bh=Bu7YUmZoT9vACQSaTZDW2SetomtAJn73UDFWVLSHt8E=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmUjRLlwaM3NNckyBBmL/c1D6Ha48fvdYE17Sg7 YsrS5YCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZlAAKCRCcnaoHP2RA2djbCA DfC3XEexGDrUgHi3trjPNNDxHxAd2Pva0wrWmypURWj66YlO7SJWQpMNasQ2bKT9dqrU14g+aQdOtM ywVLaQ89uqqhzMyYqN2QD7GWOJhPsAnmjiDF0HoGOb4kjYN1xw8cDvsXeRHBrvTZk33sducrLHSQ3d uPmmSNSQt7JMFIerXvN0yyWyTJIIJmkdgio0e/Y5bR0C+ftUFk5bI7hZaBu74XjehHu6ZkCCzLv1Fn xfdbJ6zFIi1KAjYcd82rXzJdRbit6boVBpqlf8W4tMlaG2m9qhkM8nWwC3QvkSEODq4U6f2nwlkQm2 Lhs8n/XI7CFY64o2ljZ6XcCcF7PvIo
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.89 / 50.00];
	BAYES_HAM(-2.88)[99.49%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 9A0FB21A79
X-Spam-Flag: NO
X-Spam-Score: -2.89
X-Spam-Level: 

Unify all conditions for initial readahead to simplify goto logic in
page_cache_sync_ra(). No functional changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 12c0d2215329..d68d5ce657a7 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -532,20 +532,19 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	}
 
 	max_pages = ractl_max_pages(ractl, req_count);
+	prev_index = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
 	/*
-	 * start of file or oversized read
-	 */
-	if (!index || req_count > max_pages)
-		goto initial_readahead;
-
-	/*
-	 * sequential cache miss
+	 * A start of file, oversized read, or sequential cache miss:
 	 * trivial case: (index - prev_index) == 1
 	 * unaligned reads: (index - prev_index) == 0
 	 */
-	prev_index = (unsigned long long)ra->prev_pos >> PAGE_SHIFT;
-	if (index - prev_index <= 1UL)
-		goto initial_readahead;
+	if (!index || req_count > max_pages || index - prev_index <= 1UL) {
+		ra->start = index;
+		ra->size = get_init_ra_size(req_count, max_pages);
+		ra->async_size = ra->size > req_count ? ra->size - req_count :
+							ra->size >> 1;
+		goto readit;
+	}
 
 	/*
 	 * Query the page cache and look for the traces(cached history pages)
@@ -572,13 +571,6 @@ void page_cache_sync_ra(struct readahead_control *ractl,
 	ra->start = index;
 	ra->size = min(contig_count + req_count, max_pages);
 	ra->async_size = 1;
-	goto readit;
-
-initial_readahead:
-	ra->start = index;
-	ra->size = get_init_ra_size(req_count, max_pages);
-	ra->async_size = ra->size > req_count ? ra->size - req_count :
-						ra->size >> 1;
 readit:
 	ractl->_index = ra->start;
 	page_cache_ra_order(ractl, ra, 0);
-- 
2.35.3



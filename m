Return-Path: <linux-fsdevel+bounces-73108-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 08159D0CE50
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 04:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACB7A301B5A8
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Jan 2026 03:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745ED26561E;
	Sat, 10 Jan 2026 03:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="MaRoKkOl";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="krBU9/Yc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6971725A645
	for <linux-fsdevel@vger.kernel.org>; Sat, 10 Jan 2026 03:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768017425; cv=none; b=ZMRFfcmCiETH+8gs+t6aTBishq5NN20StkO5n3UCwA6zmnkgwncU+LIAwqcsWXjA8yZrLdwY69TmfUyA1XBmKFupwbGqtVcr/LPY5yE15Cg0vU+iJc9Ej2VVZ9Xzv5BKtc6KNXgOdYhGhvrtxnRGGRk3xrfpRg8hFILYkOxHgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768017425; c=relaxed/simple;
	bh=zrLkyxR4WKZTXoCpqFRBNNn9Mo3kbp46VbldVjSL5wI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ViAgp4g6dd04KUd1+edMHZ6I1WxDj1PB5QSZ99zE/RNlKfDSBdE9F+0ykDjzm6TVbEnISHRJwSuviGCRr3yISEEP9lSiLgL4Alk4rbbSC52wfyf/58V2DpXTAHVmzJTy/1h1bLokESIJSbeM85OF9GlwiB9X5xT+XwRHcB+vV4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=MaRoKkOl; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=krBU9/Yc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E43CF5BD4F;
	Sat, 10 Jan 2026 03:56:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768017407; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wbutnzV9eZIALfLzM0C1Q8Sqw2lOekYO9LFPItKA0g=;
	b=MaRoKkOlRpkozbBPWLyRJ58D5/51rfTsbZt/sCizdLV9dWxyQdb/bYiyAIrP2BIL15BjJc
	uTdRS2aOINCDuy8PZiO2NE2PVxJacq7aiYZ/aIGXVYFeIVsYoccMl4PUGbGO6tYkb9D3AL
	/WJoH3ixK1yd8d9ATkIIWSDNOV8KJi0=
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="krBU9/Yc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1768017406; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3wbutnzV9eZIALfLzM0C1Q8Sqw2lOekYO9LFPItKA0g=;
	b=krBU9/YcDtm7j9qKxigqapchgqEM+OhyRZ3gsd1HeuVxQgIPVeZZiRVsjiiSAXPxzzKrMO
	//ZLVpBOn9Sw4wQYfMNlna9s7l+C17Dcj2yv4dxeOqYVVasQ6bgyu1Jp1yXvtGEj4kURd3
	E7XpWGI+ibwGiFjPkb6VhPonPEfuO30=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6E2323EA63;
	Sat, 10 Jan 2026 03:56:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IM9eDP3NYWlqLgAAD6G6ig
	(envelope-from <wqu@suse.com>); Sat, 10 Jan 2026 03:56:45 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/3] mm/filemap: remove read_cache_page_gfp()
Date: Sat, 10 Jan 2026 14:26:21 +1030
Message-ID: <a5ffadf18dca846d6f8086b29366288e794a24b6.1768017091.git.wqu@suse.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1768017091.git.wqu@suse.com>
References: <cover.1768017091.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -3.01
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-0.997];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_TWO(0.00)[2];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Level: 
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: E43CF5BD4F
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO

The last user of this function is btrfs, which has migrated to use
bdev_rw_virt().

So there is no need to keep that function.

Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 include/linux/pagemap.h |  2 --
 mm/filemap.c            | 23 -----------------------
 2 files changed, 25 deletions(-)

diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 31a848485ad9..2efbf6c55a96 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1002,8 +1002,6 @@ struct folio *mapping_read_folio_gfp(struct address_space *, pgoff_t index,
 		gfp_t flags);
 struct page *read_cache_page(struct address_space *, pgoff_t index,
 		filler_t *filler, struct file *file);
-extern struct page * read_cache_page_gfp(struct address_space *mapping,
-				pgoff_t index, gfp_t gfp_mask);
 
 static inline struct page *read_mapping_page(struct address_space *mapping,
 				pgoff_t index, struct file *file)
diff --git a/mm/filemap.c b/mm/filemap.c
index ebd75684cb0a..cd167aa45934 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4173,29 +4173,6 @@ struct page *read_cache_page(struct address_space *mapping,
 }
 EXPORT_SYMBOL(read_cache_page);
 
-/**
- * read_cache_page_gfp - read into page cache, using specified page allocation flags.
- * @mapping:	the page's address_space
- * @index:	the page index
- * @gfp:	the page allocator flags to use if allocating
- *
- * This is the same as "read_mapping_page(mapping, index, NULL)", but with
- * any new page allocations done using the specified allocation flags.
- *
- * If the page does not get brought uptodate, return -EIO.
- *
- * The function expects mapping->invalidate_lock to be already held.
- *
- * Return: up to date page on success, ERR_PTR() on failure.
- */
-struct page *read_cache_page_gfp(struct address_space *mapping,
-				pgoff_t index,
-				gfp_t gfp)
-{
-	return do_read_cache_page(mapping, index, NULL, NULL, gfp);
-}
-EXPORT_SYMBOL(read_cache_page_gfp);
-
 /*
  * Warn about a page cache invalidation failure during a direct I/O write.
  */
-- 
2.52.0



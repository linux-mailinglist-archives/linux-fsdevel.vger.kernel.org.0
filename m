Return-Path: <linux-fsdevel+bounces-22306-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB2291651B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12176281BDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3384D14A60D;
	Tue, 25 Jun 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rE8i5kNl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oE0xVS7g";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="rE8i5kNl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oE0xVS7g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D5414A08B
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310753; cv=none; b=WtyxPbWTrOlD9ecSViEj9U3J/Wjz99u2V7WIruT6XyfIdCMFx6HxCgYiE+bfRkEnMwaUmsZAIUZuDk+J7kdQEDek8o2P7CYzX4p903MUxXp2clI3+qKWlyBmH+YRByZTXK47exHros7rg1qLGJDtQBjqBjr+EnKOMyL6BGQ3MNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310753; c=relaxed/simple;
	bh=YMGuebUrm0qSfydyCid1z7UHFeUsV68V8mO59Irwxfg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cbO6PlqjSbf5jTdxv9PzwT6t/6q57LZuK7xHAAxOBguKb8mAGd/KEIfyXyrOcKA/UQEXfHqAHvDbpQBRZoy9tbt7rasPSSJNibRQHOlCLVLCUf/zAsFRU2JWQq5xyPIgjMU2be7OR0fYpzVg8c/PxV/OxV/YsCtyPCzlNtkKPcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rE8i5kNl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oE0xVS7g; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=rE8i5kNl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oE0xVS7g; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4939121A77;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etKpcm5t3yeZbDdRLHHmNy7tT/UIvSIL59H6KxFIGCA=;
	b=rE8i5kNlaX0AgnQkr/e+qACaK70IxSWR442e2gE7u2USV9HVMwpFh/GJUHTmURYCZpPp7c
	5gcp6/4uKvF5q6CNkR/SjnYYU0+xssoRyh6N49PPqZv0xUHHiE1+DZtOHfFaCj2zgcevno
	ko1oz7YvBO+lLK5Ut/ijE2Xyom1qj/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etKpcm5t3yeZbDdRLHHmNy7tT/UIvSIL59H6KxFIGCA=;
	b=oE0xVS7g8vkRXj4Bmf1lNIAQlt/gr3xGyg9YNceAg++iiya3vp1WPyoIWMJJhhBGJ1ukCy
	mcaWT/tJFiHYrIDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etKpcm5t3yeZbDdRLHHmNy7tT/UIvSIL59H6KxFIGCA=;
	b=rE8i5kNlaX0AgnQkr/e+qACaK70IxSWR442e2gE7u2USV9HVMwpFh/GJUHTmURYCZpPp7c
	5gcp6/4uKvF5q6CNkR/SjnYYU0+xssoRyh6N49PPqZv0xUHHiE1+DZtOHfFaCj2zgcevno
	ko1oz7YvBO+lLK5Ut/ijE2Xyom1qj/U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=etKpcm5t3yeZbDdRLHHmNy7tT/UIvSIL59H6KxFIGCA=;
	b=oE0xVS7g8vkRXj4Bmf1lNIAQlt/gr3xGyg9YNceAg++iiya3vp1WPyoIWMJJhhBGJ1ukCy
	mcaWT/tJFiHYrIDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AEF613ADA;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 0xxcDp6ZemZ0WQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id DE333A0936; Tue, 25 Jun 2024 12:19:09 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 04/10] readahead: Drop pointless index from force_page_cache_ra()
Date: Tue, 25 Jun 2024 12:18:54 +0200
Message-Id: <20240625101909.12234-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1537; i=jack@suse.cz; h=from:subject; bh=YMGuebUrm0qSfydyCid1z7UHFeUsV68V8mO59Irwxfg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmOHQLH0PwzfW3mfxx2sEkVan7MxcaVI6ZACKFq jkqSlruJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZjgAKCRCcnaoHP2RA2eu4CA CqnwjdpuUvU0E8r6CCpeAHE+DzeV3rp7p0Z+WXReeccWJEVLIo9C6uoySJqZF6pzldz5Juuw+5Tq4d P4523q7ldw/oDZxNNKuSqei5MQeQHUHJqG86GHmZVOIb+WxSdlOaX0w4JwBZFI6weS+YMwQQ86Z+St ogUO3/Ev5niwgbxwUhqwA5OH5GtfBJw9su26AyzXPnUvuNyzVWajW6veMErhPUdp/RN4nuJC0sBGgR 5V49G5x3Z+LSQLkiRHS+Vmx/31fb4viCOg4+0zmfEIntH05yNwwPwQpn9HPdy+8KJ8xJFpJY1P+8/y nw+9is3leFpihkQHFjSyHEmm+7xmNo
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00];
	BAYES_HAM(-2.80)[99.12%];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -2.60
X-Spam-Level: 

Current index to readahead is tracked in readahead_control and properly
updated by page_cache_ra_unbounded() (read_pages() in fact). So there's
no need to track the index separately in force_page_cache_ra().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 1c58e0463be1..455edafebb07 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -313,7 +313,7 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	struct address_space *mapping = ractl->mapping;
 	struct file_ra_state *ra = ractl->ra;
 	struct backing_dev_info *bdi = inode_to_bdi(mapping->host);
-	unsigned long max_pages, index;
+	unsigned long max_pages;
 
 	if (unlikely(!mapping->a_ops->read_folio && !mapping->a_ops->readahead))
 		return;
@@ -322,7 +322,6 @@ void force_page_cache_ra(struct readahead_control *ractl,
 	 * If the request exceeds the readahead window, allow the read to
 	 * be up to the optimal hardware IO size
 	 */
-	index = readahead_index(ractl);
 	max_pages = max_t(unsigned long, bdi->io_pages, ra->ra_pages);
 	nr_to_read = min_t(unsigned long, nr_to_read, max_pages);
 	while (nr_to_read) {
@@ -330,10 +329,8 @@ void force_page_cache_ra(struct readahead_control *ractl,
 
 		if (this_chunk > nr_to_read)
 			this_chunk = nr_to_read;
-		ractl->_index = index;
 		do_page_cache_ra(ractl, this_chunk, 0);
 
-		index += this_chunk;
 		nr_to_read -= this_chunk;
 	}
 }
-- 
2.35.3



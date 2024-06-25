Return-Path: <linux-fsdevel+bounces-22310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF88C91651E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93FE2282171
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8385514A4D0;
	Tue, 25 Jun 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GWFhszbJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mBATL9t0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="GWFhszbJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mBATL9t0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B01114A0BF
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310754; cv=none; b=FVEGfMkReoVfGgdnhJfORRAbIqOJ83YXK0RDJn4GXz8pGJu85XA6MBN7N/9eub+SBzta/mVJv7eN9HtTmGgIwzYa6HSKSKBCy3AwkrgE0i+ZznjFTGfUoPT5DycpoQh7BU5sDKmf/YpDFjTWw0a+5ebzuIVUp3/Ur03LIl8opTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310754; c=relaxed/simple;
	bh=uNQmjIDmbRqrgOgCnQp9TWHkJn+vXefHwUGc9G4atKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DbA/Wh++XXB0pO5ulr+Ip2IiXp5ld72h8xHJEuO9mlx2KKD/h47iyv/epG74lMph9zLj9//WWveHV8Enfpyw4y9gHUCMa0NXTn9L2qg08VVLzrqZjbCSbKsMtAiRKJfOqFaM/xnI9MzTTe1ffRcBH5kVvMnQzWglQJWfZKu8Cn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GWFhszbJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mBATL9t0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=GWFhszbJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=mBATL9t0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97CBD1F84F;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XehjZz8U5jmUp0KBCATwed+k3plztjsxZR6NK0NE8js=;
	b=GWFhszbJE7ATIih77tzjMT/oHF5iOzCCWki1h+d2WN7Z5nHgdpByImeREWmVCUhBYu6YqV
	3l0MniMu2E2lA8iM6tQenHrCmSdMuIXbADrmzFDtd/HJfAqrBMLzpcrvnB7O+hT2EVa2Gy
	CFWfzW+KttaXZPkyrfFm2i09XF845Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XehjZz8U5jmUp0KBCATwed+k3plztjsxZR6NK0NE8js=;
	b=mBATL9t0EsnLa8nZMeqNI+5nPYPaDCLOzd1YBjwgIReTH8881d+1BTu5g3kuP1PAHPRVQS
	RTOatnacmb9vgXDQ==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=GWFhszbJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mBATL9t0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XehjZz8U5jmUp0KBCATwed+k3plztjsxZR6NK0NE8js=;
	b=GWFhszbJE7ATIih77tzjMT/oHF5iOzCCWki1h+d2WN7Z5nHgdpByImeREWmVCUhBYu6YqV
	3l0MniMu2E2lA8iM6tQenHrCmSdMuIXbADrmzFDtd/HJfAqrBMLzpcrvnB7O+hT2EVa2Gy
	CFWfzW+KttaXZPkyrfFm2i09XF845Go=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XehjZz8U5jmUp0KBCATwed+k3plztjsxZR6NK0NE8js=;
	b=mBATL9t0EsnLa8nZMeqNI+5nPYPaDCLOzd1YBjwgIReTH8881d+1BTu5g3kuP1PAHPRVQS
	RTOatnacmb9vgXDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8260513A9A;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PR/XH56ZemZ+WQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 02190A0957; Tue, 25 Jun 2024 12:19:09 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 07/10] readahead: Drop dead code in ondemand_readahead()
Date: Tue, 25 Jun 2024 12:18:57 +0200
Message-Id: <20240625101909.12234-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2287; i=jack@suse.cz; h=from:subject; bh=uNQmjIDmbRqrgOgCnQp9TWHkJn+vXefHwUGc9G4atKs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmRD/ONRVBSq6jWi4Q/RKRyrz0CpCU34YA1tRUH XgUO4hyJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZkQAKCRCcnaoHP2RA2V5YCA CN7YjL+MmOOxmPo3WZp3x2ysmGA0VqwFNClS05kep1YLzxJZU1vur+K//frnsYZSNUsL5HwowaPz7E M8GLbyorUMoMLhl2uzW9Lt2yvwNeYJFI0A9Qm5omNEEicRYpodPu9BvNmubrJbxLFzg0SbjRdbQB7I jNP24eTOwdpa355UmJdxUbvypVjim8cgWvU/sGvePm7BbGgLmjGIuhFjB4D4pkOykjCdUaS4y64mvE u95uO41TEJdNTNpLrdFpz4uDB3qmC1iLOmgCvOqRH28W9o5el+AUeWT8s/wT6qn6vIPb3QrnxqQjrL M9534nEPUBagU+LyKPB/KkUOHeYZzx
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:email,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 97CBD1F84F
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

ondemand_readahead() scales up the readahead window if the current read
would hit the readahead mark placed by itself. However the condition
is mostly dead code because:
a) In case of async readahead we always increase ra->start so ra->start
   == index is never true.
b) In case of sync readahead we either go through
   try_context_readahead() in which case ra->async_size == 1 < ra->size
   or we go through initial_readahead where ra->async_size == ra->size
   iff ra->size == max_pages.

So the only practical effect is reducing async_size for large initial
reads. Make the code more obvious.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 9ea5125a0dce..d92a5e8d89c4 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -549,7 +549,6 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	struct backing_dev_info *bdi = inode_to_bdi(ractl->mapping->host);
 	struct file_ra_state *ra = ractl->ra;
 	unsigned long max_pages = ra->ra_pages;
-	unsigned long add_pages;
 	pgoff_t index = readahead_index(ractl);
 	pgoff_t expected, prev_index;
 	unsigned int order = folio ? folio_order(folio) : 0;
@@ -638,26 +637,10 @@ static void ondemand_readahead(struct readahead_control *ractl,
 initial_readahead:
 	ra->start = index;
 	ra->size = get_init_ra_size(req_size, max_pages);
-	ra->async_size = ra->size > req_size ? ra->size - req_size : ra->size;
+	ra->async_size = ra->size > req_size ? ra->size - req_size :
+					       ra->size >> 1;
 
 readit:
-	/*
-	 * Will this read hit the readahead marker made by itself?
-	 * If so, trigger the readahead marker hit now, and merge
-	 * the resulted next readahead window into the current one.
-	 * Take care of maximum IO pages as above.
-	 */
-	if (index == ra->start && ra->size == ra->async_size) {
-		add_pages = get_next_ra_size(ra, max_pages);
-		if (ra->size + add_pages <= max_pages) {
-			ra->async_size = add_pages;
-			ra->size += add_pages;
-		} else {
-			ra->size = max_pages;
-			ra->async_size = max_pages >> 1;
-		}
-	}
-
 	ractl->_index = ra->start;
 	page_cache_ra_order(ractl, ra, order);
 }
-- 
2.35.3



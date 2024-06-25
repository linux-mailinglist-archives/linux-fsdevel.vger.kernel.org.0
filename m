Return-Path: <linux-fsdevel+bounces-22314-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC55916523
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E55AB23298
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAC314A4DA;
	Tue, 25 Jun 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikWfKa8b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IeaEZuPh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ikWfKa8b";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IeaEZuPh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F256314A09F
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310755; cv=none; b=N5jcWGPmNJ9KghNwPlkuwGTeivCsJlCSk05QK2iYee4EhWFmr6HsHh1JaGImtctnzNiKMrV+zsptE5RqlUAY03i34wcUUmMoreLlRgjBP2CJ0eQOcukb99xejDVpDfeKmt/4wXjzOFJxdc7QqWn0im+EH7rsL1CogtkQ6GzBxRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310755; c=relaxed/simple;
	bh=2BByd5Qz40KJgLPQa4CRJHADLoyluDt7OXYy5Vc5KU8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Am1vyP5HteqlQduVpFUo+1c3KNxlebQAjbNwxAsaJ3SKE0mYs7mTYxRn+33acwXkUytzytmsPUC3EXHfURbrSv3AaqPoOtkeO6A++MfV2RkME5775jNc9B/C4CD5D0z1I34ZsBPn4ajoTFl5s3TD/AGoMKwCCFfGFqSfXECYDGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikWfKa8b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IeaEZuPh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ikWfKa8b; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IeaEZuPh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3311F21972;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PGCsNEAZb8feT1eGXK7ybre2/GF8QGIQq2PzvMqbP8=;
	b=ikWfKa8bne81WF9vVAJtHa0QPnc1LIizuvh4aPfFB1lSYHk1eS3SB1KHwnakTzv1X6jp1C
	S2ICBHjmdOtSSEnxQQp35KJPd3l2UgR/UggflD6wt2JWCAuvUXXPCguRd3MRAxealFQxRe
	RS0u8q0h0dJQrVXJEIwScpfdqBj/W5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PGCsNEAZb8feT1eGXK7ybre2/GF8QGIQq2PzvMqbP8=;
	b=IeaEZuPhSoqvbgTLHtMmztzmcS3MeIP9a99DQKV3gqPWf4qQhqR2jx3FMgWcrpu5l0va4w
	ncOskFr87u1gLuCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ikWfKa8b;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IeaEZuPh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PGCsNEAZb8feT1eGXK7ybre2/GF8QGIQq2PzvMqbP8=;
	b=ikWfKa8bne81WF9vVAJtHa0QPnc1LIizuvh4aPfFB1lSYHk1eS3SB1KHwnakTzv1X6jp1C
	S2ICBHjmdOtSSEnxQQp35KJPd3l2UgR/UggflD6wt2JWCAuvUXXPCguRd3MRAxealFQxRe
	RS0u8q0h0dJQrVXJEIwScpfdqBj/W5Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1PGCsNEAZb8feT1eGXK7ybre2/GF8QGIQq2PzvMqbP8=;
	b=IeaEZuPhSoqvbgTLHtMmztzmcS3MeIP9a99DQKV3gqPWf4qQhqR2jx3FMgWcrpu5l0va4w
	ncOskFr87u1gLuCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25F0213A9A;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id hE5/CZ6ZemZpWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C5A64A087B; Tue, 25 Jun 2024 12:19:09 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 01/10] readahead: Make sure sync readahead reads needed page
Date: Tue, 25 Jun 2024 12:18:51 +0200
Message-Id: <20240625101909.12234-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3131; i=jack@suse.cz; h=from:subject; bh=2BByd5Qz40KJgLPQa4CRJHADLoyluDt7OXYy5Vc5KU8=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmMsFecTDSrJB7mzuQeFHsMRnTlyeSDIRIpwYXj JqeNh6CJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZjAAKCRCcnaoHP2RA2fsnCA ChMH7hiJSHQTZszWhes0ZPL8tX8rXTRFqaWRv2zKdXrp/hdP1LP+k/C0c5FgLJWPBkB4t7ZsUBEOTi hdoHqmPCCc5PFg8glpeNB1rjxr9Ax0HIh5ds1oYLunJaAliyqGz4ChBZzRMPIksKDOnLcUiWdXUbOK rLDS8t4ulwXAyV24MxlhhkWN6I/L9lH/TN5MdcBMVcTwpXKz6pfUCbRQToHmOQhRw1UBWe8mxov+Mr jyIgX5xWV7/KuX/HyL/BtRkpVBEcc5rd/8uTi267fSnRLSyd/A208PjJpoTYhn5mDGjyaWKazOn/Rk Tw25TYpOrregPCejiqhHkWyp2+9+Md
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3311F21972
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org

page_cache_sync_ra() is called when a folio we want to read is not in
the page cache. It is expected that it creates the folio (and perhaps
the following folios as well) and submits reads for them unless some
error happens. However if index == ra->start + ra->size,
ondemand_readahead() will treat the call as another async readahead hit.
Thus ra->start will be advanced and we create pages and queue reads from
ra->start + ra->size further. Consequentially the page at 'index' is not
created and filemap_get_pages() has to always go through
filemap_create_folio() path.

This behavior has particularly unfortunate consequences
when we have two IO threads sequentially reading from a shared file (as
is the case when NFS serves sequential reads). In that case what can
happen is:

suppose ra->size == ra->async_size == 128, ra->start = 512

T1					T2
reads 128 pages at index 512
  - hits async readahead mark
    filemap_readahead()
      ondemand_readahead()
        if (index == expected ...)
	  ra->start = 512 + 128 = 640
          ra->size = 128
	  ra->async_size = 128
	page_cache_ra_order()
	  blocks in ra_alloc_folio()
					reads 128 pages at index 640
					  - no page found
					  page_cache_sync_readahead()
					    ondemand_readahead()
					      if (index == expected ...)
						ra->start = 640 + 128 = 768
						ra->size = 128
						ra->async_size = 128
					    page_cache_ra_order()
					      submits reads from 768
					  - still no page found at index 640
					    filemap_create_folio()
					  - goes on to index 641
					  page_cache_sync_readahead()
					    ondemand_readahead()
					      - founds ra is confused,
					        trims is to small size
  	  finds pages were already inserted

And as a result read performance suffers.

Fix the problem by triggering async readahead case in
ondemand_readahead() only if we are calling the function because we hit
the readahead marker. In any other case we need to read the folio at
'index' and thus we cannot really use the current ra state.

Note that the above situation could be viewed as a special case of
file->f_ra state corruption. In fact two thread reading using the shared
file can also seemingly corrupt file->f_ra in interesting ways due to
concurrent access. I never saw that in practice and the fix is going to
be much more complex so for now at least fix this practical problem
while we ponder about the theoretically correct solution.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index c1b23989d9ca..af0fbd302a38 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -580,7 +580,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
 	 */
 	expected = round_down(ra->start + ra->size - ra->async_size,
 			1UL << order);
-	if (index == expected || index == (ra->start + ra->size)) {
+	if (folio && index == expected) {
 		ra->start += ra->size;
 		ra->size = get_next_ra_size(ra, max_pages);
 		ra->async_size = ra->size;
-- 
2.35.3



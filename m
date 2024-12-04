Return-Path: <linux-fsdevel+bounces-36497-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 871AB9E4304
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 19:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42F0281873
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 18:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545632391A5;
	Wed,  4 Dec 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tLgNrw2S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJF4o5Wr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tLgNrw2S";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="AJF4o5Wr"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC596239185
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335832; cv=none; b=ovv0I25/IIgxCZerScVX/fv3+tlzTD6xPCLljh0hUPwTYvYIeWCq2lmHOteMmvpw3oWdX0N7HsL7bS5gqPmNQQqSqDtrPil5WnZph+mxy09rFoZMUaKGv82lrby3N8Y3bcZ9a+RNDSPPPDs6UNSvShp/Jo+6qzwrqu3sN3wVu2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335832; c=relaxed/simple;
	bh=A4tsTegl357UhkwXDmfPLpj1g2fDGSUagcySv02HY9k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n/lZu+E4NmkyU2/WdGuEJrnyyk6nST6H0j+ANuhN2fCC0ArJpvTQm8lz3dAzDyXcr7Onulw3/cxt4Bbl7csKfaP6jEiifNbC90Ef4e0oASxGY9KyTM6KUV3CPjFY3YP4nQTF28FdjwvKfPMlOTVcjZXzVA8tsGi+09TPkqNjOuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tLgNrw2S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJF4o5Wr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tLgNrw2S; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=AJF4o5Wr; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 280101F391;
	Wed,  4 Dec 2024 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733335829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRRVp8GDv5ciFU8Vi3NK539eFxAC9ZKJdJnKCRgH7L8=;
	b=tLgNrw2SSinViQkbbJRU+fhzUy6L+N8bkRvx9sxjHg8WLiumifZKfiTexcaRAUTOv0wa0w
	3Y82DQ9MALJYn0FQ2KdiRp6xqwDLXLiONu1eSiADkCD38w84ZMC+rkWg6Q+HDrEHM8uieO
	Gja0WfdIGNwDkgJ/GOgVFNRLebD+q9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733335829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRRVp8GDv5ciFU8Vi3NK539eFxAC9ZKJdJnKCRgH7L8=;
	b=AJF4o5WryyXhlaKQNsx1NmW9touxveeG+Yh4OrVREWMDrbRGJ7ZvPALcKaB67tcsRBLMqr
	0CRHuYF+bT6grGBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=tLgNrw2S;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=AJF4o5Wr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733335829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRRVp8GDv5ciFU8Vi3NK539eFxAC9ZKJdJnKCRgH7L8=;
	b=tLgNrw2SSinViQkbbJRU+fhzUy6L+N8bkRvx9sxjHg8WLiumifZKfiTexcaRAUTOv0wa0w
	3Y82DQ9MALJYn0FQ2KdiRp6xqwDLXLiONu1eSiADkCD38w84ZMC+rkWg6Q+HDrEHM8uieO
	Gja0WfdIGNwDkgJ/GOgVFNRLebD+q9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733335829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YRRVp8GDv5ciFU8Vi3NK539eFxAC9ZKJdJnKCRgH7L8=;
	b=AJF4o5WryyXhlaKQNsx1NmW9touxveeG+Yh4OrVREWMDrbRGJ7ZvPALcKaB67tcsRBLMqr
	0CRHuYF+bT6grGBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1507E13A41;
	Wed,  4 Dec 2024 18:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id L4jbBBWbUGcfJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 18:10:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9B992A089B; Wed,  4 Dec 2024 19:10:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] readahead: Don't shorted readahead window in read_pages()
Date: Wed,  4 Dec 2024 19:10:15 +0100
Message-Id: <20241204181016.15273-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241204181016.15273-1-jack@suse.cz>
References: <20241204181016.15273-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1372; i=jack@suse.cz; h=from:subject; bh=A4tsTegl357UhkwXDmfPLpj1g2fDGSUagcySv02HY9k=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnUJsGMzu51Nl5sO9cmnme2WMMG2Vp67WUyVvFoI6H PEQeuvuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ1CbBgAKCRCcnaoHP2RA2VbNB/ 9e6QWAakdEIqj7QtPm5A6RZs+LXzV1dLegNIC+NW7PamHW+WaiXxQ3DnnvfWndYND4lSLtLVaYNeZz ViLXV9/vlwd9Iff2j+IZjf81DBfh7o7/r6BewIYlgtIjWhRY/JAPo7wxA0+fORtN9l+hE8OgmMqPFE 6RMyMbPL5pog0Ig3LTotHkm/UfS7qjjdHn9FzEmtLqOCg8SNF+7ZpEWviVwiXLIXOJtRxsQEZiqbYN 8iCY/p144rKTwteAmADMPbQHaEkWwrjdAm0J4Q6ZhUARVqj+CPC4H1pcom+lr31JX9zO/u1ZTOoPjg Jt0hQ3QbrNaMvwTpBXkIaUCjxPSrpB
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 280101F391
X-Spam-Score: -3.01
X-Rspamd-Action: no action
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
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

When ->readahead callback doesn't read all requested pages, read_pages()
shortens the readahead window (ra->size). However we don't know why
pages were not read and what appropriate window size is. So don't try to
secondguess the filesystem. If it needs different readahead window, it
should set it manually similary as during expansion the filesystem can
use readahead_expand().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index ea650b8b02fb..78d7f4db9966 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -158,20 +158,10 @@ static void read_pages(struct readahead_control *rac)
 
 	if (aops->readahead) {
 		aops->readahead(rac);
-		/*
-		 * Clean up the remaining folios.  The sizes in ->ra
-		 * may be used to size the next readahead, so make sure
-		 * they accurately reflect what happened.
-		 */
+		/* Clean up the remaining folios. */
 		while ((folio = readahead_folio(rac)) != NULL) {
-			unsigned long nr = folio_nr_pages(folio);
-
 			folio_get(folio);
-			rac->ra->size -= nr;
-			if (rac->ra->async_size >= nr) {
-				rac->ra->async_size -= nr;
-				filemap_remove_folio(folio);
-			}
+			filemap_remove_folio(folio);
 			folio_unlock(folio);
 			folio_put(folio);
 		}
-- 
2.35.3



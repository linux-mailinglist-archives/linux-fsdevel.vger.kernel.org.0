Return-Path: <linux-fsdevel+bounces-36496-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EA9B9E4303
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 19:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39D11166EDB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Dec 2024 18:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25EB32391A1;
	Wed,  4 Dec 2024 18:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XBrWVSAC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bpxBZKaS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XBrWVSAC";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="bpxBZKaS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5CD239188
	for <linux-fsdevel@vger.kernel.org>; Wed,  4 Dec 2024 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733335832; cv=none; b=L6Lco+B1goLDxlcIjWPXhoLJIz9b0/cZC+zpV3tlaqEPqEJPCBn1dxwiukcneWnDYesHAcfRmMGueRfWq4C63Obdv2HpbUVP0KvmpYB//85bnkbsBhx9PACVCvGle7GnTRfj5sdRVywxLft1rx95DOfpOV8XxZqmUCr9sveVbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733335832; c=relaxed/simple;
	bh=sfDjWR9l2q0I6e9RtVsVOtQ/QIvJpETYv/xLjFoCRTA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Mtz7rjTv50LlsEwC4Jkny9AEb9lyWX6NQLUCoLx3VUxkCKNWQLo6+vdPbruTDfFeq8QD7a3tPu/L9PZLwz1/zdHrq2dqDj0BjJW4rBupdUB4gjc5p4ud74Icb/kw50oBeSdwww0V3VWnj35y4LVr0b337dzJ5iAKakkQgUoe5jc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XBrWVSAC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bpxBZKaS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XBrWVSAC; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=bpxBZKaS; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 1B71A1F38E;
	Wed,  4 Dec 2024 18:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733335829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLbh/B5ZrBYqXSiuvC61pHk/xApVQ10fXBkwkHhdWqA=;
	b=XBrWVSACVFrKgx1ofqQI6yh93jwJcXtFJDta42EJOJevhVfSeb0B/SzTS4+tQvUliHsoRF
	BP4pflN0eFlxhdQyoACD5FTIQzeOTXSfLy+VcmK2/d9th/iHGlIZcboHd8k/YrtXkAXIWt
	YVY4G3K2GcJNav7jtJ96eVR7nhqMM6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733335829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLbh/B5ZrBYqXSiuvC61pHk/xApVQ10fXBkwkHhdWqA=;
	b=bpxBZKaS5MO4tvC1Ek2DxE6w/snx/QXgCZHmCCJ8SPFPPIg6cTGHs+V6kHXY8KfurHNNFm
	92cZ4lLc3H7neECg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1733335829; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLbh/B5ZrBYqXSiuvC61pHk/xApVQ10fXBkwkHhdWqA=;
	b=XBrWVSACVFrKgx1ofqQI6yh93jwJcXtFJDta42EJOJevhVfSeb0B/SzTS4+tQvUliHsoRF
	BP4pflN0eFlxhdQyoACD5FTIQzeOTXSfLy+VcmK2/d9th/iHGlIZcboHd8k/YrtXkAXIWt
	YVY4G3K2GcJNav7jtJ96eVR7nhqMM6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1733335829;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pLbh/B5ZrBYqXSiuvC61pHk/xApVQ10fXBkwkHhdWqA=;
	b=bpxBZKaS5MO4tvC1Ek2DxE6w/snx/QXgCZHmCCJ8SPFPPIg6cTGHs+V6kHXY8KfurHNNFm
	92cZ4lLc3H7neECg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0B09713647;
	Wed,  4 Dec 2024 18:10:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id c0GsAhWbUGccJAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 04 Dec 2024 18:10:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A37B3A0918; Wed,  4 Dec 2024 19:10:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: <linux-mm@kvack.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] readahead: properly shorten readahead when falling back to do_page_cache_ra()
Date: Wed,  4 Dec 2024 19:10:16 +0100
Message-Id: <20241204181016.15273-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241204181016.15273-1-jack@suse.cz>
References: <20241204181016.15273-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2079; i=jack@suse.cz; h=from:subject; bh=sfDjWR9l2q0I6e9RtVsVOtQ/QIvJpETYv/xLjFoCRTA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBnUJsHX0VYtNJp25g9VSejTibuHWKcLphPJJDG+Lge 5Qgi77aJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZ1CbBwAKCRCcnaoHP2RA2d0KB/ 9F0Jsz5AdXt/pdHYspx0h2y6MWRluBhnTRKPDu6DFXFceCRqCaEJ4b0r0GyuNFyzmhk/Rb6JtuEevw +eOOoAxMKRhIjsOWlal8W9b70g0Gbi7kQzNY9Bc2IBDUXJfJzKaidSXHoo21fdxQ1o/x0JbjKg7ESL ZiWn2zpPFRhLeL8pCWLR99O1ofTs8+MeiGzXql2g4UFNqdWxZ/v89U1Y2JJ/RCppzTUET8T8+sW8vc 6TBryHEkZg7HWWSNJSmpZZghGhrInkjP1So1qQqWSDrkxH8SI4JBPgqk/vuBYnEnNzM5Rhw2sRuUzJ uBzH+Q1CGG6TPriOgSdB1f7WEmvnLq
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid]
X-Spam-Score: -2.80
X-Spam-Flag: NO

When we succeed in creating some folios in page_cache_ra_order() but
then need to fallback to single page folios, we don't shorten the amount
to read passed to do_page_cache_ra() by the amount we've already read.
This then results in reading more and also in placing another readahead
mark in the middle of the readahead window which confuses readahead
code.  Fix the problem by properly reducing number of pages to read.
Unlike previous attempt at this fix (commit 7c877586da31) which had to
be reverted, we are now careful to check there is indeed something to
read so that we don't submit negative-sized readahead.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 78d7f4db9966..006954c76652 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -448,7 +448,8 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		struct file_ra_state *ra, unsigned int new_order)
 {
 	struct address_space *mapping = ractl->mapping;
-	pgoff_t index = readahead_index(ractl);
+	pgoff_t start = readahead_index(ractl);
+	pgoff_t index = start;
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
@@ -506,12 +507,18 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	/*
 	 * If there were already pages in the page cache, then we may have
 	 * left some gaps.  Let the regular readahead code take care of this
-	 * situation.
+	 * situation below.
 	 */
 	if (!err)
 		return;
 fallback:
-	do_page_cache_ra(ractl, ra->size, ra->async_size);
+	/*
+	 * ->readahead() may have updated readahead window size so we have to
+	 * check there's still something to read.
+	 */
+	if (ra->size > index - start)
+		do_page_cache_ra(ractl, ra->size - (index - start),
+				 ra->async_size);
 }
 
 static unsigned long ractl_max_pages(struct readahead_control *ractl,
-- 
2.35.3



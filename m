Return-Path: <linux-fsdevel+bounces-22315-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC3A916524
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DBA2B2312B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC6D14A09F;
	Tue, 25 Jun 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kBPyOTV0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xWW1KRCc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="kBPyOTV0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="xWW1KRCc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5999214A0BD
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310756; cv=none; b=FBUl3l48n6jtTz65qCdbcW9Iarju955IaewMOuSGPimUZ0ZbEWfnQV1K7XrssrmexgQj0Fre4fI3BeWJRWH0VMuEYMHXqRGr4qyXOa14el8GHxGqv7NXNKQZ6vf2NDgTzapDli9PnJQWR+Bg4aGm3USuuJ5zukQ1klDiw8Fc4+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310756; c=relaxed/simple;
	bh=W6XufS+irzkVLcuC4WuSgVtbQbyLhmOcwBflH4kmDVk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gZkavu36gdOZufImcc+aOP32QBAAfddgtVW+OP3dJ3Q7/ueAHt/0ZtaF0S8wE2ySCl3kFCkxkoAYOBPnpTpkrmJcxtp9Nnk6nBezKlIHyiavBRVabVc+kKgelJe7EOLLH4/JEdykWPh8+r33udnVeDFZ8TULn2GTdG3N4kd8QiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kBPyOTV0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xWW1KRCc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=kBPyOTV0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=xWW1KRCc; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8E9991F84E;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSIf4jCjJDnMr8/f5CejiRw0oOxYjiOk2rPRf6qMsis=;
	b=kBPyOTV0CaOTXexoQ24sDAzDcrWGNQdGLdJUFDQX+LJyNiAjP52drz2g82eWlgUYeES32o
	yQM4/zfJ/ur3MNIK5pkc7HP7k775BA0oM1+DpbKqYL8hseJS8ArcT1O5j38k/zeuq4pfPT
	CFLzwK8gqJORSTSdbhODJ5HbTtnirT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSIf4jCjJDnMr8/f5CejiRw0oOxYjiOk2rPRf6qMsis=;
	b=xWW1KRCcPkzu29v7MB4OlDHn0/EQ27Zx2Yz1h01K2QfCfyRJSNbHCbJzeAJf6br/EKk1ik
	C2rEenkRSlbrJ+Ag==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSIf4jCjJDnMr8/f5CejiRw0oOxYjiOk2rPRf6qMsis=;
	b=kBPyOTV0CaOTXexoQ24sDAzDcrWGNQdGLdJUFDQX+LJyNiAjP52drz2g82eWlgUYeES32o
	yQM4/zfJ/ur3MNIK5pkc7HP7k775BA0oM1+DpbKqYL8hseJS8ArcT1O5j38k/zeuq4pfPT
	CFLzwK8gqJORSTSdbhODJ5HbTtnirT4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MSIf4jCjJDnMr8/f5CejiRw0oOxYjiOk2rPRf6qMsis=;
	b=xWW1KRCcPkzu29v7MB4OlDHn0/EQ27Zx2Yz1h01K2QfCfyRJSNbHCbJzeAJf6br/EKk1ik
	C2rEenkRSlbrJ+Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 82EDC13AC1;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id k+H1H56ZemZ9WQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EFF2DA0938; Tue, 25 Jun 2024 12:19:09 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 06/10] readahead: Drop dead code in page_cache_ra_order()
Date: Tue, 25 Jun 2024 12:18:56 +0200
Message-Id: <20240625101909.12234-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=jack@suse.cz; h=from:subject; bh=W6XufS+irzkVLcuC4WuSgVtbQbyLhmOcwBflH4kmDVk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmQ2JTScI1xSohz7XtKQCtOoPQPG88nLecvwubO lW7qjfKJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZkAAKCRCcnaoHP2RA2Xx+CA CmfVeVtxYG6T8ol6AezzBq8gB1CHQ/WaA6+W++fNTLMPGH957HjzY4L35mmXxN4u0pCa7sTWJKJKW5 OUxXv/EftfilCXwI62XRrrtaDx6XU+Bc5TqjxWiUz1/6A5ZF5Omm1zcb3d4vlU++Wdnis/KCGZ2fvl shg+9PzVGDqz4h5o1e+/ktFQkxvQjhHXt48C9Roj4eLTatk4dKVkTLvDEzygNPJwjbiWHsYykkaxnf OzGCYGO7qW7ESPBX1LpZEZgAKQ9eHMUfgxutNs4eU5ZLFMPXENWNN/6iFf8nbuQE5a755DD30M9Gcm CGVwrh2HvtZqZDCsNeTcG4juey+zPS
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.44 / 50.00];
	BAYES_HAM(-2.64)[98.40%];
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
X-Spam-Score: -2.44
X-Spam-Level: 

page_cache_ra_order() scales folio order down so that is fully fits
within readahead window. Thus the code handling the case where we
walked past the readahead window is a dead code. Remove it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 455edafebb07..9ea5125a0dce 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -525,11 +525,6 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		index += 1UL << order;
 	}
 
-	if (index > limit) {
-		ra->size += index - limit - 1;
-		ra->async_size += index - limit - 1;
-	}
-
 	read_pages(ractl);
 	filemap_invalidate_unlock_shared(mapping);
 	memalloc_nofs_restore(nofs);
-- 
2.35.3



Return-Path: <linux-fsdevel+bounces-35912-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA2049D99FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 15:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6C9B21A60
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Nov 2024 14:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8F4A17C7B1;
	Tue, 26 Nov 2024 14:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H4JFcMT9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FB96duuY";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="H4JFcMT9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="FB96duuY"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE8B28F5;
	Tue, 26 Nov 2024 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732632743; cv=none; b=hdvsnAQ/glbyZiM5fS++sh6LIbDnuuiZ6BvleoLNX3WfvRwoARWGvpHFWuDOWGSU5Z35jvpgoKqa+QB31mBX+P44n88MCdb/EYWdi6G4GM9OIz8MpHHaW6AJ+NFWMvw4QYDy5V5RrXXVoh2t44w/kZ6nlSOe+fOog8uauvL7hIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732632743; c=relaxed/simple;
	bh=YH7VUsPQRd833zgqYiGJxBpCkv7rPn0lNro0jtl43rU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L31NnQzGNeRhYEPcgyJ+BzO0YsVTqQSkTvSzGB6dnGHMrFry/UTuJH4FerH0gNC5Pxf5GjZM3C3pGaCCCZmUHne0puMlRDBDw/U/qEFU9pSqhYy9v7lc/OBvaCH5LgD7QuTi7lFizEyVIn4tLFd5FjjOWRxf0Ffe5PvcccBjt/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H4JFcMT9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FB96duuY; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=H4JFcMT9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=FB96duuY; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 739EE21177;
	Tue, 26 Nov 2024 14:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732632739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PVvC0X2IdzVccD4dVujhCabIRcmUKjGJsrcO3GJg50E=;
	b=H4JFcMT9Lvpaz1hOIbFetsIDZlat5mrEdeIA7IzfX6sWxtf68jN5MEJlAHjGVtGkzxfVKQ
	GY4a7uIOuHvoeg4677ByPBzwmqaaq2qHMIiJkbxl+y8Hhv3GOWh7mbFh1/FzTDBmvGvfPr
	MGwh1Nc9PiMHiQ1i8PcM8nAg3Y54KOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732632739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PVvC0X2IdzVccD4dVujhCabIRcmUKjGJsrcO3GJg50E=;
	b=FB96duuY/dbWsiYI/wyH7Re7Ji922TvQD0jJKx+ZnObh07fuofJCi3Bhuw4qPBO1ws0r3H
	yJKdAJNI6gGpzlBQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732632739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PVvC0X2IdzVccD4dVujhCabIRcmUKjGJsrcO3GJg50E=;
	b=H4JFcMT9Lvpaz1hOIbFetsIDZlat5mrEdeIA7IzfX6sWxtf68jN5MEJlAHjGVtGkzxfVKQ
	GY4a7uIOuHvoeg4677ByPBzwmqaaq2qHMIiJkbxl+y8Hhv3GOWh7mbFh1/FzTDBmvGvfPr
	MGwh1Nc9PiMHiQ1i8PcM8nAg3Y54KOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732632739;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=PVvC0X2IdzVccD4dVujhCabIRcmUKjGJsrcO3GJg50E=;
	b=FB96duuY/dbWsiYI/wyH7Re7Ji922TvQD0jJKx+ZnObh07fuofJCi3Bhuw4qPBO1ws0r3H
	yJKdAJNI6gGpzlBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5C922139AA;
	Tue, 26 Nov 2024 14:52:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id T3WTFqPgRWfXfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 26 Nov 2024 14:52:19 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0E0DDA08CA; Tue, 26 Nov 2024 15:52:15 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	<linux-mm@kvack.org>,
	<linux-fsdevel@vger.kernel.org>,
	Anders Blomdell <anders.blomdell@gmail.com>,
	Philippe Troin <phil@fifi.org>,
	Jan Kara <jack@suse.cz>,
	stable@vger.kernel.org
Subject: [PATCH] Revert "readahead: properly shorten readahead when falling back to do_page_cache_ra()"
Date: Tue, 26 Nov 2024 15:52:08 +0100
Message-Id: <20241126145208.985-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=jack@suse.cz; h=from:subject; bh=YH7VUsPQRd833zgqYiGJxBpCkv7rPn0lNro0jtl43rU=; b=owGbwMvMwME4Z+4qdvsUh5uMp9WSGNJdH3S/ejmfOSyiVnaP7STbfZNXzlBgurfveU3at/3ZZ+RV 6s2DOhmNWRgYORhkxRRZVkde1L42z6hra6iGDMwgViaQKQxcnAIwkdYZ7P90D7HPfmdpH6s6+USk9o k1/fbbPZgiNBbr/ZPTSj2cpuAquNW/6aRQIntKwe0aLpNc5jqNHp4VAXp258282lfXm32zLVdlC2eX LBRumz17zv4v/nxcLncPcL8K09b698rwNEOtpnH34dtZUTsjLRhZF+1JOfP9lGMbX0HAXIO0f1baqo ZrQn6/SZJwnclfsSic2W1HbIpR8LqS4qT2/tnP1y5c4Lbk+Zu43wblWQ2RR92v6rqc1Juh7ZW0+/f/ zGLRqS/fVnzZ8fdqVPmtXI7iAumMx8acM+RPh0mxL+atWv+sSCrG57/ZAn195ezfz951ZOy4MC1Sv2 DJOa1u0wYpttNeJzmcKrglfdsB
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-1.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[infradead.org,kvack.org,vger.kernel.org,gmail.com,fifi.org,suse.cz];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:mid,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -1.30
X-Spam-Flag: NO

This reverts commit 7c877586da3178974a8a94577b6045a48377ff25.

Anders and Philippe have reported that recent kernels occasionally hang
when used with NFS in readahead code. The problem has been bisected to
7c877586da3 ("readahead: properly shorten readahead when falling back to
do_page_cache_ra()"). The cause of the problem is that ra->size can be
shrunk by read_pages() call and subsequently we end up calling
do_page_cache_ra() with negative (read huge positive) number of pages.
Let's revert 7c877586da3 for now until we can find a proper way how the
logic in read_pages() and page_cache_ra_order() can coexist. This can
lead to reduced readahead throughput due to readahead window confusion
but that's better than outright hangs.

Reported-by: Anders Blomdell <anders.blomdell@gmail.com>
Reported-by: Philippe Troin <phil@fifi.org>
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 mm/readahead.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/readahead.c b/mm/readahead.c
index 8f1cf599b572..ea650b8b02fb 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -458,8 +458,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 		struct file_ra_state *ra, unsigned int new_order)
 {
 	struct address_space *mapping = ractl->mapping;
-	pgoff_t start = readahead_index(ractl);
-	pgoff_t index = start;
+	pgoff_t index = readahead_index(ractl);
 	unsigned int min_order = mapping_min_folio_order(mapping);
 	pgoff_t limit = (i_size_read(mapping->host) - 1) >> PAGE_SHIFT;
 	pgoff_t mark = index + ra->size - ra->async_size;
@@ -522,7 +521,7 @@ void page_cache_ra_order(struct readahead_control *ractl,
 	if (!err)
 		return;
 fallback:
-	do_page_cache_ra(ractl, ra->size - (index - start), ra->async_size);
+	do_page_cache_ra(ractl, ra->size, ra->async_size);
 }
 
 static unsigned long ractl_max_pages(struct readahead_control *ractl,
-- 
2.35.3



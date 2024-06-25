Return-Path: <linux-fsdevel+bounces-22309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5154E91651F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 12:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63CD81C21B66
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jun 2024 10:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83C0F14A629;
	Tue, 25 Jun 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aLbP/MM9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="npRodn1v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aLbP/MM9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="npRodn1v"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B6214A0B9
	for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jun 2024 10:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719310754; cv=none; b=G5dvM0Oi9jIV+6l6r1XdO2JOMOZXie6ntQ6H0MFi/qo8PQnzqB3pBT9qjbEqG3tjBf14+C3FnHOzrAjdl7VhYEFC/92vZdlRMtUYHfoNHOcY0QpuFAQD6EXgjKvldkmsBHpMy1YPD/FlBT/O4XE8opI3Na5YW5EHOUUV89Ni9E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719310754; c=relaxed/simple;
	bh=YaPpgDx+Qmuj6I/gWcDPw0IJuohKdGqM4cxIZra6ocM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CEexVzigsCkvfPoChJxlpUeFDKc6nDDyl9fc5hTqr7/rz2fhQ/5lJeLmCK9i3QjS1V+406eKPe2WWUi2dFiktmibx/vdZoQPwu65W/BEKCk2sYZkOVX/rbUMDuQZP++5V9RIUjYxBo7vur7mNKfMDgr9Nr+LbbkU3FigsqCtOgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aLbP/MM9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=npRodn1v; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aLbP/MM9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=npRodn1v; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 9038321A78;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8Lca3al1fhzTJQxTF9PNVlpICKgh2TdoBsflcocPqU=;
	b=aLbP/MM9R/HRsbC+rOxPee0706vrfOroPL1a++4Gq0YAA+ZHFPQmMmIuEEow8axyZWO02E
	+xWtn5lDRaK4JEnd4pVYWFBgT7WYxbf91JRpi7nBXHOVIAzFU0W4jURryRY4RDU71oPHPo
	m673nOhFNLB6tKwiOyFEwknGni3ALvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8Lca3al1fhzTJQxTF9PNVlpICKgh2TdoBsflcocPqU=;
	b=npRodn1v5RJ6WpWaGog0gYIz4mqWaD2yvikAGJO5neCTaC2Xgks7xQb6+90bSZFtOwcdNq
	UCKfCQabGbgNSiDg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="aLbP/MM9";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=npRodn1v
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1719310750; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8Lca3al1fhzTJQxTF9PNVlpICKgh2TdoBsflcocPqU=;
	b=aLbP/MM9R/HRsbC+rOxPee0706vrfOroPL1a++4Gq0YAA+ZHFPQmMmIuEEow8axyZWO02E
	+xWtn5lDRaK4JEnd4pVYWFBgT7WYxbf91JRpi7nBXHOVIAzFU0W4jURryRY4RDU71oPHPo
	m673nOhFNLB6tKwiOyFEwknGni3ALvI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1719310750;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+8Lca3al1fhzTJQxTF9PNVlpICKgh2TdoBsflcocPqU=;
	b=npRodn1v5RJ6WpWaGog0gYIz4mqWaD2yvikAGJO5neCTaC2Xgks7xQb6+90bSZFtOwcdNq
	UCKfCQabGbgNSiDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 839B513AD8;
	Tue, 25 Jun 2024 10:19:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 4jUmIJ6ZemaAWQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 25 Jun 2024 10:19:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E6F44A0937; Tue, 25 Jun 2024 12:19:09 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-mm@kvack.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 05/10] readahead: Drop index argument of page_cache_async_readahead()
Date: Tue, 25 Jun 2024 12:18:55 +0200
Message-Id: <20240625101909.12234-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240625100859.15507-1-jack@suse.cz>
References: <20240625100859.15507-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2630; i=jack@suse.cz; h=from:subject; bh=YaPpgDx+Qmuj6I/gWcDPw0IJuohKdGqM4cxIZra6ocM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmepmPJlMUunnObQNV3cSQ7E5jsGTZZugbhFy9t2we 3vTzJjqJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnqZjwAKCRCcnaoHP2RA2VPxCA DjI+zbpNTOWZjm24JaNK8kwW96LsA6mIzfFDMpRH5Q7+tLMgfyh+bRIUakcieBituNu4bPjdIUpRgg e8B/R6bZ51rcc7vbqRlzQAcKB2mYYiE4VGY4BzZBT14p7QhdIcuNR1+0O/4gi4EzZ8+P/RmOQRC30u 8aR1AVLtY3fAVPv4fDROqN9gH8cu8A5wowtzrOe5wtPk+f+nCrH839vlpN16YK2Vkvk1X2MnyHLVuE bfT2JIcRhjSAuu7IgzMdqrMiC9Hm+zzZ6Ct/RzoASyDlYkCM5NYy2/6gu59wtHKdPR3WcHo/JTneTp sQ9aeDFOJT2gVEjdq1pM2wm/GD8huG
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9038321A78
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

The index argument of page_cache_async_readahead() is just folio->index
so there's no point in passing is separately. Drop it.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/btrfs/relocation.c   | 3 +--
 fs/btrfs/send.c         | 2 +-
 include/linux/pagemap.h | 7 +++----
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8b24bb5a0aa1..e7e8fce70ccc 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -2975,8 +2975,7 @@ static int relocate_one_folio(struct inode *inode, struct file_ra_state *ra,
 
 	if (folio_test_readahead(folio))
 		page_cache_async_readahead(inode->i_mapping, ra, NULL,
-					   folio, index,
-					   last_index + 1 - index);
+					   folio, last_index + 1 - index);
 
 	if (!folio_test_uptodate(folio)) {
 		btrfs_read_folio(NULL, folio);
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 3dd4a48479a9..dbf462e67ad0 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -5307,7 +5307,7 @@ static int put_file_data(struct send_ctx *sctx, u64 offset, u32 len)
 
 		if (folio_test_readahead(folio))
 			page_cache_async_readahead(mapping, &sctx->ra, NULL, folio,
-						   index, last_index + 1 - index);
+						   last_index + 1 - index);
 
 		if (!folio_test_uptodate(folio)) {
 			btrfs_read_folio(NULL, folio);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index ee633712bba0..7ad4decd4347 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -1307,8 +1307,7 @@ void page_cache_sync_readahead(struct address_space *mapping,
  * @mapping: address_space which holds the pagecache and I/O vectors
  * @ra: file_ra_state which holds the readahead state
  * @file: Used by the filesystem for authentication.
- * @folio: The folio at @index which triggered the readahead call.
- * @index: Index of first page to be read.
+ * @folio: The folio which triggered the readahead call.
  * @req_count: Total number of pages being read by the caller.
  *
  * page_cache_async_readahead() should be called when a page is used which
@@ -1319,9 +1318,9 @@ void page_cache_sync_readahead(struct address_space *mapping,
 static inline
 void page_cache_async_readahead(struct address_space *mapping,
 		struct file_ra_state *ra, struct file *file,
-		struct folio *folio, pgoff_t index, unsigned long req_count)
+		struct folio *folio, unsigned long req_count)
 {
-	DEFINE_READAHEAD(ractl, file, ra, mapping, index);
+	DEFINE_READAHEAD(ractl, file, ra, mapping, folio->index);
 	page_cache_async_ra(&ractl, folio, req_count);
 }
 
-- 
2.35.3



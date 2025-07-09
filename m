Return-Path: <linux-fsdevel+bounces-54340-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7994DAFE38D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 11:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E9B93B54C2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 09:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83C4283FC8;
	Wed,  9 Jul 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cx+zArjn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zNNEUKhS";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cx+zArjn";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="zNNEUKhS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5B2235072
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752052014; cv=none; b=Z4iwYJKT7bfzDuySkLdU6aBdeMiyRgFP4zSs4DQ/xQuEU/9e5CgRkfWwv50EBVmZN08PWWj9X64csc4Wf+f4x2r8E2iElOI8gnRrU5mCeJtVBBok+KcO9pabJaODZ0iI44RAcZniP3YQpKOPugVkp/hRhqEceNcLzAzFU9olK2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752052014; c=relaxed/simple;
	bh=Penqcx0t3pCRDs+XuohRlzFB5huLcTaPeIJ6wHI0VTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nR674lSjvtGYRRekTJhWqgr9q+BDDlKrAoC2qu+fpTnERDp5CnW54QUDyOo/9pu4JgCNQnskYU54MrGq0Lcgu/9pnXLUvGb98lyV6QEm40bKWAq6VPErCLmluJ7TU16CDO1enkHxVpLF+5cODdJLtjA3yWr9FXkiSJ0GWmlAweo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cx+zArjn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zNNEUKhS; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cx+zArjn; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=zNNEUKhS; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 64C8021180;
	Wed,  9 Jul 2025 09:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752052010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wz6QWTl2RAyxXqOfbyDOg5K9lbLzWP0Lc9JJjD8EiN8=;
	b=cx+zArjnPXf+GxPbwSHDJAYEchvo54W4pYiVirOEiiD24iasUDRSCE4XhqewsnaTihP7Rb
	w9gREanopwDfMzH4C7BlDrV46HTe02/EtR1YRTa/ycDctHakNVFPcFC9YoJ8QuCO+5ZS/p
	OKqqz0sku9wPaLhkGPda5D8FFN8GiXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752052010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wz6QWTl2RAyxXqOfbyDOg5K9lbLzWP0Lc9JJjD8EiN8=;
	b=zNNEUKhSJ0YOZuxQyTnptrxhrVZX+AxBvc1FwxHUO4BQjSlOywMnOvsBGaI40IRvCdi6fp
	3euED5rKb8rNBYDQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cx+zArjn;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=zNNEUKhS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752052010; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wz6QWTl2RAyxXqOfbyDOg5K9lbLzWP0Lc9JJjD8EiN8=;
	b=cx+zArjnPXf+GxPbwSHDJAYEchvo54W4pYiVirOEiiD24iasUDRSCE4XhqewsnaTihP7Rb
	w9gREanopwDfMzH4C7BlDrV46HTe02/EtR1YRTa/ycDctHakNVFPcFC9YoJ8QuCO+5ZS/p
	OKqqz0sku9wPaLhkGPda5D8FFN8GiXg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752052010;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=wz6QWTl2RAyxXqOfbyDOg5K9lbLzWP0Lc9JJjD8EiN8=;
	b=zNNEUKhSJ0YOZuxQyTnptrxhrVZX+AxBvc1FwxHUO4BQjSlOywMnOvsBGaI40IRvCdi6fp
	3euED5rKb8rNBYDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5988E136DC;
	Wed,  9 Jul 2025 09:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tFDWFSoxbmiDBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Jul 2025 09:06:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0003BA09D7; Wed,  9 Jul 2025 11:06:49 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@ZenIV.linux.org.uk>,
	<linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] vfs: Remove unnecessary list_for_each_entry_safe() from evict_inodes()
Date: Wed,  9 Jul 2025 11:06:36 +0200
Message-ID: <20250709090635.26319-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1139; i=jack@suse.cz; h=from:subject; bh=Penqcx0t3pCRDs+XuohRlzFB5huLcTaPeIJ6wHI0VTs=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBobjEbiNZtnRESiRB0rPPXvRAamRM0UPI/77MoDAnF gzSP1jWJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaG4xGwAKCRCcnaoHP2RA2XG+CA DrIxnVw+tvGNbOrCh6NhvlXPr38Kx8iChS7J3Q8IZIf0P1ngg9yJgCBE6ud+tncky79jbEx44hbqND uONChSuBfZChOWzQmlHWqJT+0WeY2cydZgt3C+fT4bYyvt+N4oiDUyBKIYkKa56ImqbZEk2kR65AKW WHd2dcYG1ZTsphPDaRkGdP/smePhCXitYLJxTQjpE2X/cs4Sht6YmKvjJQzy4+vFtI31wHCc8ZzlcV PsuhwARkPp5Ip0rwKLWUksYvo/gcIdB++oUEbSZ/8AcX+zNqu87Xty6i/kDdwtAaVW0gpatr76ygF0 o+5+zhvkANeIqv5ulXi3kCqclzBhiV
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 64C8021180
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

evict_inodes() uses list_for_each_entry_safe() to iterate sb->s_inodes
list. However, since we use i_lru list entry for our local temporary
list of inodes to destroy, the inode is guaranteed to stay in
sb->s_inodes list while we hold sb->s_inode_list_lock. So there is no
real need for safe iteration variant and we can use
list_for_each_entry() just fine.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/inode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Small cleanup I have sitting in my tree for ages and which I think is still
worth it.

diff --git a/fs/inode.c b/fs/inode.c
index 99318b157a9a..3e990330bb05 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -865,12 +865,12 @@ static void dispose_list(struct list_head *head)
  */
 void evict_inodes(struct super_block *sb)
 {
-	struct inode *inode, *next;
+	struct inode *inode;
 	LIST_HEAD(dispose);
 
 again:
 	spin_lock(&sb->s_inode_list_lock);
-	list_for_each_entry_safe(inode, next, &sb->s_inodes, i_sb_list) {
+	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		if (atomic_read(&inode->i_count))
 			continue;
 
-- 
2.43.0



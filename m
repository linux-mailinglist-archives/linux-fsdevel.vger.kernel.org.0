Return-Path: <linux-fsdevel+bounces-8594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F094983929C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F4991C25E47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 938D8604A3;
	Tue, 23 Jan 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHTBQTB5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B/gHf3xM";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uHTBQTB5";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="B/gHf3xM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32585FDB9;
	Tue, 23 Jan 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023530; cv=none; b=tU5x5j/umaWRxFmNNzYXHEXZFnl7aNsWA3Nkwpf/Ov+qImxo3pOV0MFeliJRAROajOTD5/o2AsgMkiDXQSaMmbjqOs8jcmsDQmYpkUiPpkvBFEAjAJpt8d1viDkbxO4QP6Cw9fw2lIBHDD2wueroEl+RVITvGO/XR4+dIHJtQ9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023530; c=relaxed/simple;
	bh=OKHJR3tq9xK6lVLxoUX8IKxN/+oDAVqLUCMYgc/ArKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tc5eLdTCV0T7sZ6BBSllAHq27bcbxOivaKVZ0g/UaF6+SBGZnxJ8AfFn6KkR8EyRktMzY8m3jco5vur6VGFQcb1UnjLAapNmT9Fo+zxNeGCYt/BGCmJO/H4oo7pB1G5wvRHrxAfpd/Pn4qrPjSthcUII9Ti6NS0X6etRc5/qEeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHTBQTB5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B/gHf3xM; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uHTBQTB5; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=B/gHf3xM; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 07FAA222C6;
	Tue, 23 Jan 2024 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDTMyxuDw7UQAQM5IltrFCoGrv7T39YC9PjoJZhmavQ=;
	b=uHTBQTB5IvI/bT2grLqLnJYCWYqK2MiacXNqP10WKvGCqh6d4nqOY219BUmIyho3qUPazg
	IJko+/HYv6jnJyF+BNbZ/lv9YZuoQ16jQzI1mJAiKrvCm/djdopG2VoNG3mUIBesOBglFF
	BTCYS9IhJOz+JwvxWtPZYp1NfkyfnLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDTMyxuDw7UQAQM5IltrFCoGrv7T39YC9PjoJZhmavQ=;
	b=B/gHf3xMGjMeS1cDgPrmZ7jg4k1MSjZJ4pVMnVfIRWi74r3e+R5pktYmMGP0IzTRcQtWol
	BWBWroM8fSIf+pBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDTMyxuDw7UQAQM5IltrFCoGrv7T39YC9PjoJZhmavQ=;
	b=uHTBQTB5IvI/bT2grLqLnJYCWYqK2MiacXNqP10WKvGCqh6d4nqOY219BUmIyho3qUPazg
	IJko+/HYv6jnJyF+BNbZ/lv9YZuoQ16jQzI1mJAiKrvCm/djdopG2VoNG3mUIBesOBglFF
	BTCYS9IhJOz+JwvxWtPZYp1NfkyfnLI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xDTMyxuDw7UQAQM5IltrFCoGrv7T39YC9PjoJZhmavQ=;
	b=B/gHf3xMGjMeS1cDgPrmZ7jg4k1MSjZJ4pVMnVfIRWi74r3e+R5pktYmMGP0IzTRcQtWol
	BWBWroM8fSIf+pBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EA80B136A4;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Srs9OWXar2WpdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0B228A080D; Tue, 23 Jan 2024 16:25:21 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 7/9] ext2: Remove GFP_NOFS use in ext2_xattr_cache_insert()
Date: Tue, 23 Jan 2024 16:25:06 +0100
Message-Id: <20240123152520.4294-7-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123152113.13352-1-jack@suse.cz>
References: <20240123152113.13352-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=942; i=jack@suse.cz; h=from:subject; bh=OKHJR3tq9xK6lVLxoUX8IKxN/+oDAVqLUCMYgc/ArKI=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pSdUhT1gSyWpXx1ZVaMPxd9OupVSwqkmvE1ju4 0Fw0/4OJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aUgAKCRCcnaoHP2RA2VrZB/ 9wD/CcbNy1nHgAOWu7C3j3t08H+po6tn/cQdM5FWD4lIQcMScXv4fNrbyO+LG+pSG5LfCuDk1BQbzG YaEfkSvq6wwO0IKt7UTUBVGI6o/rtzYx9bq/QfkOTTsSWFhGNmZlnLFt7OCMPlhojlU1dLq82l60Gd TnlnU0a2caw8C+I1TdJyagc431K4eQkoWaKUoSWCtGqf1+w9CHrSvFglyU0I9cRpErVCkrcTuavmEb 32clkI5O2EpbC22j5D3Od70ZkOq8utQ1sDDzZTKeeXXPAXcqV0kQY+7G++dfzVP3fdoVY/N20DK6Ew KELlMaGygeXZAVN1lox0y/lcArL7Jo
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: **
X-Spam-Score: 2.88
X-Spamd-Result: default: False [2.88 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-0.998];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.82)[85.02%]
X-Spam-Flag: NO

ext2_xattr_cache_insert() calls mb_cache_entry_create() with GFP_NOFS
because it is called under EXT2_I(inode)->xattr_sem. However xattr_sem
or any higher ranking lock is not acquired on fs reclaim path for ext2
at least since we don't do page writeback from direct reclaim.  Thus
GFP_NOFS is not needed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/xattr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
index e849241ebb8f..c885dcc3bd0d 100644
--- a/fs/ext2/xattr.c
+++ b/fs/ext2/xattr.c
@@ -874,7 +874,7 @@ ext2_xattr_cache_insert(struct mb_cache *cache, struct buffer_head *bh)
 	__u32 hash = le32_to_cpu(HDR(bh)->h_hash);
 	int error;
 
-	error = mb_cache_entry_create(cache, GFP_NOFS, hash, bh->b_blocknr,
+	error = mb_cache_entry_create(cache, GFP_KERNEL, hash, bh->b_blocknr,
 				      true);
 	if (error) {
 		if (error == -EBUSY) {
-- 
2.35.3



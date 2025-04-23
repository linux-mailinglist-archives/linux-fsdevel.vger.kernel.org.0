Return-Path: <linux-fsdevel+bounces-47113-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1B6A994BE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 18:21:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CD27925A34
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 16:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B10284B37;
	Wed, 23 Apr 2025 16:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="uvplcnWF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="k1kge3ll";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Zjmj2YVe";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/tLAuI2Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97C528467A
	for <linux-fsdevel@vger.kernel.org>; Wed, 23 Apr 2025 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745424414; cv=none; b=Jy2EXIGQ0VZ7O2IBIhPW9Rp2aQIodvW0ROVQLkpg3rjn1hjVKl2oJyf3gIMczLdIicOoprMhd5Gt3Is5E00MbgoSbj9cI5isOpRS8Dg6VSxz8V2vsi4AOeZ0MEfkpbl69d/JnVApMSdv4HhYTHaBHK4DCrI71nRZuoxmcWU1pHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745424414; c=relaxed/simple;
	bh=mA6O/4fkNLccwzauxnyqpB50HQR4FdJTXEDVPNNodfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l3AnMs8DHxoxsIV1gyAENimsKz0fke9q8087vkszHxPIAZcwR6QKojn+61LZ7Yp0kvzNaEhTgrs8cYcTCjRzxG5lxUPzgkRpod517xbn/VeIJtF3RUNCVzp55TmzZzYu3YYA12sUqigIFb/vlcb0gU9pgN5MOz/yyf1wzLE7AFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=uvplcnWF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=k1kge3ll; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Zjmj2YVe; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/tLAuI2Z; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id B340F21172;
	Wed, 23 Apr 2025 16:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745424411; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lkAOCHY2SVpBJoY2ys5BN6Zk9C+zaAIwFgwAHJU+5n8=;
	b=uvplcnWFKz/hb0i/QYdpzKk5l2akpRvR06UnA+niiUcopp7UD+OeEpXqf6trLFtETWBDOX
	uHaOHM/zZSYj1x6jCzs3kIkSplEN6aPBuPmyTw5S9M70fCJ57BvXRaXexnre6M8r0Dhu5e
	QqTpjEvyo174XCa4KpJ299hgMRfTl+I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745424411;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lkAOCHY2SVpBJoY2ys5BN6Zk9C+zaAIwFgwAHJU+5n8=;
	b=k1kge3llQGUEc/5JAR05FhW3JIAeHu73jt6Wt7dCxyYOrt0br5LB6zG/1tJx0uAs72yRUc
	3HCFSdltRq+SPgAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Zjmj2YVe;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="/tLAuI2Z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1745424410; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lkAOCHY2SVpBJoY2ys5BN6Zk9C+zaAIwFgwAHJU+5n8=;
	b=Zjmj2YVe3a0Ow4ypIKsmm15UnJ337bjCOAperUkFel/pGEGoGsAnwd6SczCFvFL4A9FHQh
	qB2RrkZztEu+H896Q/QTP0kNFHPmKDu81GKetcbwSTwWD2HAS/lSvdMDUbluu4mYJ6i2e5
	9ngPBYy6NCNeMOglikmRlNiyLwJfnTY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1745424410;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=lkAOCHY2SVpBJoY2ys5BN6Zk9C+zaAIwFgwAHJU+5n8=;
	b=/tLAuI2ZoPL2NQ6HgoLiIFlQFLesRuKUeBJ0M7AVnLX01XmqQ53ISx5mTuiJOw6a0Vih0x
	EiPvC1MeC4nAZbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA04013691;
	Wed, 23 Apr 2025 16:06:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VMh/KRoQCWg7DAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 23 Apr 2025 16:06:50 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 58E86A0949; Wed, 23 Apr 2025 18:06:50 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-ext4@vger.kernel.org>
Cc: <linux-fsdevel@vger.kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] ext2: Deprecate DAX
Date: Wed, 23 Apr 2025 18:06:43 +0200
Message-ID: <20250423160642.14249-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1186; i=jack@suse.cz; h=from:subject; bh=mA6O/4fkNLccwzauxnyqpB50HQR4FdJTXEDVPNNodfE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBoCRASI+dd6/FsBRGf08SwbrfVHwvOWpDjpLS4Sy1Q CXRDtfeJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaAkQEgAKCRCcnaoHP2RA2TESCA DNZ6AClecth2mOGFT0bVRQoo9amFrqNFqL3jxPViRwu5gl62Wqz4e05sOODZev/utr9/wNBn/YO4H9 ZEmhloHI6fZ14NnyESN1QWRBVpZYqji/3CJmdorCPbNWOy6i4Fw/rOR0skFC8xXa+0CgEEHwLjBkxK mM50UmlkqL5vQhzEodg9At3P1019Wmk3LNiJrMz5MglzXWSPSJ4iUrJeOcGvb3LSjZt0QYJ0pUhGYC PlrU03f5A72zhwc6TwMhmhT+fRb5N1Gm6xJWj9+39sDAaxwBTBFUWrlGIquHbOjLRMBbmzbLqgKTx8 N9D8UqVQIM5OkzrobkMm/g9NauW2pQ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B340F21172
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
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
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:mid,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

Since PMEM didn't quite lift off, DAX isn't as widely used as we
originally hoped. Thus it doesn't seem warranted to support
implementation of DAX in ext2 driver when the same filesystem can be
accessed through ext4 driver as a "simple implementation". Just
deprecate DAX support in ext2 targetting completely dropping the code at
the end of 2025.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

I plan to merge this patch through my tree.

diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 28ff47ec4be6..121e634c792a 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -601,7 +601,8 @@ static int ext2_parse_param(struct fs_context *fc, struct fs_parameter *param)
 	case Opt_dax:
 #ifdef CONFIG_FS_DAX
 		ext2_msg_fc(fc, KERN_WARNING,
-		    "DAX enabled. Warning: EXPERIMENTAL, use at your own risk");
+		    "DAX enabled. Warning: DAX support in ext2 driver is deprecated"
+		    " and will be removed at the end of 2025. Please use ext4 driver instead.");
 		ctx_set_mount_opt(ctx, EXT2_MOUNT_DAX);
 #else
 		ext2_msg_fc(fc, KERN_INFO, "dax option not supported");
-- 
2.43.0



Return-Path: <linux-fsdevel+bounces-8595-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B1D83929E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D67A028B2E3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15333604B8;
	Tue, 23 Jan 2024 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aw+gU7f2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5HIWDf39";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Aw+gU7f2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5HIWDf39"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099795FDBA;
	Tue, 23 Jan 2024 15:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023532; cv=none; b=F9CUz9XQlF0G0sYQtS3faVOPUBqy7iRH875BBur1hiLTHnQ8gaJBbya4/VHPVwE8b+mQFrTUyOl1CcrjXzkRdHEqNMxSoWwo1x2KZ6gX93b+guhNynZw5QWoJWHt6HEqCBbmBYtIHbSFCMsr1rVy16tcF47+9+4SgxCzKluoAOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023532; c=relaxed/simple;
	bh=RMRnku4DuNfv2uoJ9TsdDQxPnVMzxFjKpiFLO1B2l0o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t+R1liOyASrlSAlamsc6ihBmYEX/ldqqd2u+XI6nZXl9vRvJ3cN/oaeVeSq+mCu1hl0bZSNf6pey3u/gTSIrh1y3rtUweI+rzNoUCQLMqiR17UXntr6qf4Usp6TIoziGdZN/V7H8dOBTWxFErq6XNYL3BNDJqose6S+wNvmcwvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Aw+gU7f2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5HIWDf39; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Aw+gU7f2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5HIWDf39; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 0EBE6222D9;
	Tue, 23 Jan 2024 15:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwCAMufR7GUSs9UGpUmAZb9QF/BRRq2SmaaN3jQUOuY=;
	b=Aw+gU7f2c3fhZRvNADuKp3PYCG35dfvLDe/z1npKj3u3n+y/kUAu4n962l2LGP8AZIZXk5
	MWyD2IXHvDMC/CrYccGK5dyICZLTd+8QLencZVMAFzkzaLyl3XLKJJ9jkTlghPf2c8ss3r
	nK26ALNBmsn46pFl1erTrStnCx8XNPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwCAMufR7GUSs9UGpUmAZb9QF/BRRq2SmaaN3jQUOuY=;
	b=5HIWDf39oRhigExMDw9RVp/QM/SxxB2Ee0plOupxYA975EqgkvF0Raeog+uBpQpAmqS5eT
	HqqLiMkjUVCECxAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023526; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwCAMufR7GUSs9UGpUmAZb9QF/BRRq2SmaaN3jQUOuY=;
	b=Aw+gU7f2c3fhZRvNADuKp3PYCG35dfvLDe/z1npKj3u3n+y/kUAu4n962l2LGP8AZIZXk5
	MWyD2IXHvDMC/CrYccGK5dyICZLTd+8QLencZVMAFzkzaLyl3XLKJJ9jkTlghPf2c8ss3r
	nK26ALNBmsn46pFl1erTrStnCx8XNPI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023526;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwCAMufR7GUSs9UGpUmAZb9QF/BRRq2SmaaN3jQUOuY=;
	b=5HIWDf39oRhigExMDw9RVp/QM/SxxB2Ee0plOupxYA975EqgkvF0Raeog+uBpQpAmqS5eT
	HqqLiMkjUVCECxAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2CBD139B7;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id BQZIO2Xar2WsdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id F0A9AA0809; Tue, 23 Jan 2024 16:25:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 5/9] ext2: Drop GFP_NOFS allocation from ext2_init_block_alloc_info()
Date: Tue, 23 Jan 2024 16:25:04 +0100
Message-Id: <20240123152520.4294-5-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123152113.13352-1-jack@suse.cz>
References: <20240123152113.13352-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=813; i=jack@suse.cz; h=from:subject; bh=RMRnku4DuNfv2uoJ9TsdDQxPnVMzxFjKpiFLO1B2l0o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pQJmDbkzCzGSmAMW0KWQi6FDNaYVtnGwXb4B6E HWHxX8yJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aUAAKCRCcnaoHP2RA2ctNB/ 0egt/sEM8nIS9SVaDlUOXhuOVW3S/6O2CWuLqFq1pW/ZEnANb8XtPX19CKyaU1J/m3OW6XgxRYnnz4 hMMs47xMuRaUsiQe2f5WADAezJQHd87BGdGxbaeUUGUvi+3SNGxqhfTKveutFu0le3R/Njmv7vAr7O AX4g2aLRSTcJuBz+MtW4M6cD7o2DbDULzicHTeqkXlPlrMuF3nxr9mA9I9sRVcW/I3f979uMNMXgHs KF9fGuIXgR7aZd/jfI+9sWrFw7u9UwM0o6AQc4CS0IFndZ7MeHOt/uVX1WbLsEaAi7aOfx0f20lniw 6dF/Le68v7bBTgyhn4jWc2pyuzn6rG
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Aw+gU7f2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5HIWDf39
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-0.00)[35.87%]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 0EBE6222D9
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

The allocation happens under inode->i_rwsem and
EXT2_I(inode)->i_truncate_mutex. Neither of them is acquired during
direct fs reclaim so the allocation can be changed to GFP_KERNEL.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext2/balloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext2/balloc.c b/fs/ext2/balloc.c
index e124f3d709b2..1bfd6ab11038 100644
--- a/fs/ext2/balloc.c
+++ b/fs/ext2/balloc.c
@@ -412,7 +412,7 @@ void ext2_init_block_alloc_info(struct inode *inode)
 	struct ext2_block_alloc_info *block_i;
 	struct super_block *sb = inode->i_sb;
 
-	block_i = kmalloc(sizeof(*block_i), GFP_NOFS);
+	block_i = kmalloc(sizeof(*block_i), GFP_KERNEL);
 	if (block_i) {
 		struct ext2_reserve_window_node *rsv = &block_i->rsv_window_node;
 
-- 
2.35.3



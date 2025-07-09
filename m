Return-Path: <linux-fsdevel+bounces-54343-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CC25AFE4A7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 11:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB08618942E3
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 09:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D612877FA;
	Wed,  9 Jul 2025 09:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WOVjKUe9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cCG+trA1";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="WOVjKUe9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="cCG+trA1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60244283FD3
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 09:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752054963; cv=none; b=hQoYKB32otlLVkzei0phfHCgYaX9SMra4YCakKv+J9tAxlpD4RPbQBtYND/DiGnH5cGYlxCnIZf28BOIGppW5CBmD/R8K4bsIdPBrK+hL/OKk+4+Xro2FzCPNTpqqwymSwt76EkRaXZBtopgfrKmt4wlopkpHCfdGxKbiEf7MBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752054963; c=relaxed/simple;
	bh=ydM424NTXJWY2ugTqibzdZY9iZ80ldbA+MX6RD7A1+o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H5ic6POhB8frGdl4LFNXYbCSfE/+gpB6adFKtD/zSnve5CykZB6V6BqPHFQBUiJuF/WoN800ydIJ907fz3zaSSmEXtE0/lEUksp6PbMo9ZJk9xJrvND/xZ5HOcr3p+6za9DUSiJp5NsdH90SjSiF6MlxZ86DBAZd6UWnnKunq0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WOVjKUe9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cCG+trA1; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=WOVjKUe9; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=cCG+trA1; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 7D1E01F393;
	Wed,  9 Jul 2025 09:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752054959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i0FRFcTDntt92eW1dUX0syEVMtpKC1l0TJFyVvcPukU=;
	b=WOVjKUe9GW5Ga2/VQo49vNB+ZAlWPZrvrZbKC9SqbF+nvJ5dhwFHHOi3nEBIXB2Id85GYQ
	w8d/iL+wAX/QjlCeb/FotwAc2I/MRjCmXKZauLtl0bvZhPavhr1O7XYWk9KDAiytcX6lt7
	rn5G2fPBUfu1fhwOzMv4kiarjn6v1t0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752054959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i0FRFcTDntt92eW1dUX0syEVMtpKC1l0TJFyVvcPukU=;
	b=cCG+trA1+OXcoLcn+lESMgwvNGRcjsfVQmvz1bqM81HhVgvHJFWgz4cDI5qZLykSb9t0vO
	XQ4ij7BWMGkEfYAA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=WOVjKUe9;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=cCG+trA1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752054959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i0FRFcTDntt92eW1dUX0syEVMtpKC1l0TJFyVvcPukU=;
	b=WOVjKUe9GW5Ga2/VQo49vNB+ZAlWPZrvrZbKC9SqbF+nvJ5dhwFHHOi3nEBIXB2Id85GYQ
	w8d/iL+wAX/QjlCeb/FotwAc2I/MRjCmXKZauLtl0bvZhPavhr1O7XYWk9KDAiytcX6lt7
	rn5G2fPBUfu1fhwOzMv4kiarjn6v1t0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752054959;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=i0FRFcTDntt92eW1dUX0syEVMtpKC1l0TJFyVvcPukU=;
	b=cCG+trA1+OXcoLcn+lESMgwvNGRcjsfVQmvz1bqM81HhVgvHJFWgz4cDI5qZLykSb9t0vO
	XQ4ij7BWMGkEfYAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64FEE136DC;
	Wed,  9 Jul 2025 09:55:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LlFbGK88bmj6FQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 09 Jul 2025 09:55:59 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 159B0A09D7; Wed,  9 Jul 2025 11:55:55 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] isofs: Verify inode mode when loading from disk
Date: Wed,  9 Jul 2025 11:55:46 +0200
Message-ID: <20250709095545.31062-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1207; i=jack@suse.cz; h=from:subject; bh=ydM424NTXJWY2ugTqibzdZY9iZ80ldbA+MX6RD7A1+o=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBobjyiSVnPlJHGJNhxjw9SMxSsu6cQpIF7N5JQYeCl Tvf8Cp6JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaG48ogAKCRCcnaoHP2RA2UkRB/ 4mO/e2REok6HH7eUr9w+ubt9hUmKxtijfDIqyj8TlgIbOTL/pgp5r+qkkUussnTZ/DaSCMwahYDm31 Q9ETRP9twyUT90WOIzX7NY7OSGcbuPWBfDcTENg3vG2e02P5kP/tDJUZT0QnGVHUnGm/TuBaRd3/Wk gPZMqwP7YzWjCy89xhjB2qfUR8p9+vBdJVAM42f/gEXkMiEYqyplP8tfpYAxDvT+Uuw1lZABho1w2R jW9Ar+ozs97ysZslv7vUdd+zrSmuT5OZ9FTgdc7EQVjc4b0bVet0Q+b9uDgBbcfNoFjlhqDDmLTykb tjStplvxHEwxeu4LFyBSInschyI1ck
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TAGGED_RCPT(0.00)[895c23f6917da440ed0d];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,appspotmail.com:email];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 7D1E01F393
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Verify that the inode mode is sane when loading it from the disk to
avoid complaints from VFS about setting up invalid inodes.

Reported-by: syzbot+895c23f6917da440ed0d@syzkaller.appspotmail.com
CC: stable@vger.kernel.org
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/isofs/inode.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

I plan to merge this fix through my tree.

diff --git a/fs/isofs/inode.c b/fs/isofs/inode.c
index d5da9817df9b..33e6a620c103 100644
--- a/fs/isofs/inode.c
+++ b/fs/isofs/inode.c
@@ -1440,9 +1440,16 @@ static int isofs_read_inode(struct inode *inode, int relocated)
 		inode->i_op = &page_symlink_inode_operations;
 		inode_nohighmem(inode);
 		inode->i_data.a_ops = &isofs_symlink_aops;
-	} else
+	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
+		   S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
 		/* XXX - parse_rock_ridge_inode() had already set i_rdev. */
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
+	} else {
+		printk(KERN_DEBUG "ISOFS: Invalid file type 0%04o for inode %lu.\n",
+			inode->i_mode, inode->i_ino);
+		ret = -EIO;
+		goto fail;
+	}
 
 	ret = 0;
 out:
-- 
2.43.0



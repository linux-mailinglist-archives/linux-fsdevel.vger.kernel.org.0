Return-Path: <linux-fsdevel+bounces-54681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AF9B0225B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 19:11:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F3D4566B64
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 17:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEDE02EF9AD;
	Fri, 11 Jul 2025 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XSKK2rvP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RbmaqlKG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="XSKK2rvP";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="RbmaqlKG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A62B12ED161
	for <linux-fsdevel@vger.kernel.org>; Fri, 11 Jul 2025 17:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253855; cv=none; b=V17pZ8MXU2UkXAiSO5ql06u8CmCosIcOB/qgkikRwb3ikd52Dxt2UVc/cyPbYzfG+1Qp63fhOrko6B79EAHSAElbPUYy2t35UnHWH6Oe5JIyL39tvhwC7jnqjdaY8BpgIBqAUguG8UnoaKkOKDDBEFuQoG99rs7jILECTdqOeP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253855; c=relaxed/simple;
	bh=kwq1DAgGKLNqcHAtBMHOF5m8a8fFDloD5JvuiIMiN4M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UEUYxYEyRE87/LVNVJV9SpDup0WlzivGCO8XB07oLfW8gObjh5d6CPIQ8Ut2iJn/cy/GIxpCpgIUVd3sEEGiha+XBtCEKJGce8/q7GahMkxkSzZuyaJpjoxl1sAWCXDFGX6megKFMsNpRq3kngh+T2gaeHrbIhx9XNRit/P3QHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XSKK2rvP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RbmaqlKG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=XSKK2rvP; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=RbmaqlKG; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AB9F8211D0;
	Fri, 11 Jul 2025 17:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752253851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u/JNn4GUA9hs/uEBK5LfAS89ieaTI1qiRmw92knu5F0=;
	b=XSKK2rvPPESRCTpiyLQ95l9Jqd98MfMtR1V8ppGmAcELQIRLw646MXtT45QHF8WpM1AYm3
	09ENkGcBaVQAlvi6PmdnDWyMiNcY0CceKEDFQzQrYF1qfTbMhddh1ejeQOx8YK/RQKSdFF
	JRMy9hN4KgGVlh/Sq5tK6LAOAxsbkW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752253851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u/JNn4GUA9hs/uEBK5LfAS89ieaTI1qiRmw92knu5F0=;
	b=RbmaqlKGxAmyf16PjE7avYNRBt/4ug53PyRZeyxj+rYS9gJYRWCGMGhheNwZMTULd3yoQ4
	jBIegujWazz1B5Dg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=XSKK2rvP;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RbmaqlKG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1752253851; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u/JNn4GUA9hs/uEBK5LfAS89ieaTI1qiRmw92knu5F0=;
	b=XSKK2rvPPESRCTpiyLQ95l9Jqd98MfMtR1V8ppGmAcELQIRLw646MXtT45QHF8WpM1AYm3
	09ENkGcBaVQAlvi6PmdnDWyMiNcY0CceKEDFQzQrYF1qfTbMhddh1ejeQOx8YK/RQKSdFF
	JRMy9hN4KgGVlh/Sq5tK6LAOAxsbkW0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1752253851;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=u/JNn4GUA9hs/uEBK5LfAS89ieaTI1qiRmw92knu5F0=;
	b=RbmaqlKGxAmyf16PjE7avYNRBt/4ug53PyRZeyxj+rYS9gJYRWCGMGhheNwZMTULd3yoQ4
	jBIegujWazz1B5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1C14138A5;
	Fri, 11 Jul 2025 17:10:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id tNd7J5tFcWiGBQAAD6G6ig
	(envelope-from <jack@suse.cz>); Fri, 11 Jul 2025 17:10:51 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 50CAFA099A; Fri, 11 Jul 2025 19:10:47 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	syzbot+478f2c1a6f0f447a46bb@syzkaller.appspotmail.com
Subject: [PATCH] udf: Verify partition map count
Date: Fri, 11 Jul 2025 19:10:45 +0200
Message-ID: <20250711171044.24176-2-jack@suse.cz>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1584; i=jack@suse.cz; h=from:subject; bh=kwq1DAgGKLNqcHAtBMHOF5m8a8fFDloD5JvuiIMiN4M=; b=kA0DAAgBnJ2qBz9kQNkByyZiAGhxRZWj8abSlXW7XxPvNo/C4/38wLouRpTsgE915TbMaoBcn4kB MwQAAQgAHRYhBKtZ0SvWnjKKtVUoHJydqgc/ZEDZBQJocUWVAAoJEJydqgc/ZEDZET0IAPCyjmEN1T oFqqY3eD7Tt0wexRtmSIguOX0/j8bVjGqh65HrZEBtWj+oPvp77QJX+o8Bk6HiXADouyCAfitKoash KuJJlrWVz7/MGXxEQoRoEkF8JuDOxxENcHr2D4CbBbVYyGCtaK2vnK+NAdk2zBuFQKUf0P0vnxdmrS +ITv10Zwl73XPNsyHkbniMLM0N57wGY87lHCrVDvQZYURdl3R1ij9jqbs8QTW2K5LqZ8uiWSOQHtq6 dlHjYJrNSpPc2tS9EGpWVTqF9vB7XSWHwxs/e30QkSszV8ePyajZT3PQw4mmskQVkEBW99b5Va3wUo 31Xb+GGK3t7cgFc2yrFIw=
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
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_TRACE(0.00)[suse.cz:+];
	RCPT_COUNT_THREE(0.00)[3];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	TAGGED_RCPT(0.00)[478f2c1a6f0f447a46bb];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:mid,suse.cz:dkim,suse.cz:email,appspotmail.com:email]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: AB9F8211D0
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Verify that number of partition maps isn't insanely high which can lead
to large allocation in udf_sb_alloc_partition_maps(). All partition maps
have to fit in the LVD which is in a single block.

Reported-by: syzbot+478f2c1a6f0f447a46bb@syzkaller.appspotmail.com
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

I plan to merge this patch through my tree.

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 1c8a736b3309..b2f168b0a0d1 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1440,7 +1440,7 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 	struct genericPartitionMap *gpm;
 	uint16_t ident;
 	struct buffer_head *bh;
-	unsigned int table_len;
+	unsigned int table_len, part_map_count;
 	int ret;
 
 	bh = udf_read_tagged(sb, block, block, &ident);
@@ -1461,7 +1461,16 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 					   "logical volume");
 	if (ret)
 		goto out_bh;
-	ret = udf_sb_alloc_partition_maps(sb, le32_to_cpu(lvd->numPartitionMaps));
+
+	part_map_count = le32_to_cpu(lvd->numPartitionMaps);
+	if (part_map_count > table_len / sizeof(struct genericPartitionMap1)) {
+		udf_err(sb, "error loading logical volume descriptor: "
+			"Too many partition maps (%u > %u)\n", part_map_count,
+			table_len / (unsigned)sizeof(struct genericPartitionMap1));
+		ret = -EIO;
+		goto out_bh;
+	}
+	ret = udf_sb_alloc_partition_maps(sb, part_map_count);
 	if (ret)
 		goto out_bh;
 
-- 
2.43.0



Return-Path: <linux-fsdevel+bounces-21968-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F933910570
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 15:10:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BB901F21B41
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Jun 2024 13:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F33401B3F18;
	Thu, 20 Jun 2024 13:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LoWzxIoH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EfnwrByf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="LoWzxIoH";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="EfnwrByf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D4E1B375F
	for <linux-fsdevel@vger.kernel.org>; Thu, 20 Jun 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718888652; cv=none; b=cnC7lofKNpI70ze17vep5RvsDxDP8lGpB81UgpbP7V4K+3MILU7pnOPO0nTlA8zFnyyn0R4r8JmoxeJLxJE+OgLQeXniHa7RieAcWMMWNdJsvqtDpekEjHS2rNPpynb8X/49gOvctLAh2tUBvbXQIdW78jI77hZQuxlkfE2bcE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718888652; c=relaxed/simple;
	bh=jlcmpvcpi2ssSUUJpq7z03rRMd8pJvkxOdIz6RYgHEE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RuBvLv7cNKjzeat8469OnfVI//y9rT0Czx5Ll0j3tNTvf/FKkrQ3H2YHMRIuCTVrBtH/d1SAddbQ/bc5iAb6Mt79Hqqqrq977q1VvTa4Gl0BDVFZhg3NYMco1l5mu0axtOncKCinJCJRf4VVGlEo3DXsB9X5oz5YD/VMRxAiQ+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LoWzxIoH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EfnwrByf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=LoWzxIoH; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=EfnwrByf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8295821A80;
	Thu, 20 Jun 2024 13:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718888648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A+p9Xin0M+MHXi0zcF6AuwubNGAvM3XcWtHMrMKv1Ic=;
	b=LoWzxIoH6MA2k2MWICBjcO9Q/OFGkIHDO+LZEHDrGg86nQhs5tfV0woppblgehPngqxE+u
	bSW90HvC3Fhqser1rup4AgxMn3FlgoY3j8R0qHsanNbgdrfw/tvRmiBydWIrqxA95L4AkF
	x00cS11OEt9UjbehmN+hWcp/Aolg1V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718888648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A+p9Xin0M+MHXi0zcF6AuwubNGAvM3XcWtHMrMKv1Ic=;
	b=EfnwrByfr939Wp/QBxAuQITGupiRzwvaMd62+09DxtNedqJtF1lAB5/57B4NNvBC47gSrJ
	vZssRcg75ze+utBA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LoWzxIoH;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=EfnwrByf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718888648; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A+p9Xin0M+MHXi0zcF6AuwubNGAvM3XcWtHMrMKv1Ic=;
	b=LoWzxIoH6MA2k2MWICBjcO9Q/OFGkIHDO+LZEHDrGg86nQhs5tfV0woppblgehPngqxE+u
	bSW90HvC3Fhqser1rup4AgxMn3FlgoY3j8R0qHsanNbgdrfw/tvRmiBydWIrqxA95L4AkF
	x00cS11OEt9UjbehmN+hWcp/Aolg1V8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718888648;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=A+p9Xin0M+MHXi0zcF6AuwubNGAvM3XcWtHMrMKv1Ic=;
	b=EfnwrByfr939Wp/QBxAuQITGupiRzwvaMd62+09DxtNedqJtF1lAB5/57B4NNvBC47gSrJ
	vZssRcg75ze+utBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6F6EC1369F;
	Thu, 20 Jun 2024 13:04:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id VpbfGsgodGYwQgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 20 Jun 2024 13:04:08 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 206A1A0881; Thu, 20 Jun 2024 15:04:08 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH] udf: Avoid excessive partition lengths
Date: Thu, 20 Jun 2024 15:04:03 +0200
Message-Id: <20240620130403.14731-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1923; i=jack@suse.cz; h=from:subject; bh=jlcmpvcpi2ssSUUJpq7z03rRMd8pJvkxOdIz6RYgHEE=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmdCjCVrR8L0S9kJ253u2AFZek1NipXWI25wbbX4Bf xHsOjYCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnQowgAKCRCcnaoHP2RA2REgB/ 9/e9puTMdM5/fgAJrtoBmxwUhdnkSBTC4olgPeShSiPbnJhg6WzLq/DMLYKli1AaVIEFlm03NU4pI4 dvMjcmTIrXKLipx9LyFrZRi+N72SR14D1E1anhqt07kPYfxy9XL2xbasKnPXeqMNiBhZfLDs2qPdCK qsSzQNmm+s2+fkEl4BI/gH0CPe0MxJu/XNi5xL3mMSJSbaODPDU/9LFI5zVVJN61hbM2D10pehQ4GH HwgSFwF0/fFeH1GySltyBC6fOH194Rt3SNH3FmwPBVTmwMwIBsGh3WEEVRAoDCePEENjxpw2T83AMw huT/Rc3UXszVx7dWI8kvRSLZMiySFn
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
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWO(0.00)[2];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 8295821A80
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 

Avoid mounting filesystems where the partition would overflow the
32-bits used for block number. Also refuse to mount filesystems where
the partition length is so large we cannot safely index bits in a
block bitmap.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

I plan to merge this patch through my tree.

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 9381a66c6ce5..c7bdda3f9369 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1110,12 +1110,19 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 	struct udf_part_map *map;
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct partitionHeaderDesc *phd;
+	u32 sum;
 	int err;
 
 	map = &sbi->s_partmaps[p_index];
 
 	map->s_partition_len = le32_to_cpu(p->partitionLength); /* blocks */
 	map->s_partition_root = le32_to_cpu(p->partitionStartingLocation);
+	if (check_add_overflow(map->s_partition_root, map->s_partition_len,
+			       &sum)) {
+		udf_err(sb, "Partition %d has invalid location %u + %u\n",
+			p_index, map->s_partition_root, map->s_partition_len);
+		return -EFSCORRUPTED;
+	}
 
 	if (p->accessType == cpu_to_le32(PD_ACCESS_TYPE_READ_ONLY))
 		map->s_partition_flags |= UDF_PART_FLAG_READ_ONLY;
@@ -1171,6 +1178,14 @@ static int udf_fill_partdesc_info(struct super_block *sb,
 		bitmap->s_extPosition = le32_to_cpu(
 				phd->unallocSpaceBitmap.extPosition);
 		map->s_partition_flags |= UDF_PART_FLAG_UNALLOC_BITMAP;
+		/* Check whether math over bitmap won't overflow. */
+		if (check_add_overflow(map->s_partition_len,
+				       sizeof(struct spaceBitmapDesc) << 3,
+				       &sum)) {
+			udf_err(sb, "Partition %d it too long (%u)\n", p_index,
+				map->s_partition_len);
+			return -EFSCORRUPTED;
+		}
 		udf_debug("unallocSpaceBitmap (part %d) @ %u\n",
 			  p_index, bitmap->s_extPosition);
 	}
-- 
2.35.3



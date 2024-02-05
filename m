Return-Path: <linux-fsdevel+bounces-10334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B606849EB0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 16:48:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D284A2846DD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Feb 2024 15:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAE312D043;
	Mon,  5 Feb 2024 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aJVqbR4/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5rZxIwSj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aJVqbR4/";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5rZxIwSj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BE32AF18
	for <linux-fsdevel@vger.kernel.org>; Mon,  5 Feb 2024 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148097; cv=none; b=NAmjX+rVoo840KL8kkF6+KPfkdolQbhp/P+HIYX+6nSjruQ2tNZwlUCi+oNEybMA7WkiXA+YNshMXtuLv0fCWZrpefNQ34wUl3BXsVeHLgHFD1jRcwMAttk/3D7MRjpxFsKDw9bC2YZ/RbEkvrnOFwxV1ALpCUIbrSx4AOTpr14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148097; c=relaxed/simple;
	bh=NILpUe0L5RxDffvhAf4jZtccOO5BbJ/TcR4U6jFwhuM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BwY7aUUJgkYT282P8wPPF5Tfp27RJhygq1mYNKmue+oDXXLxbGthk08ok9zr7/P7yfcAf4t5W8wCewmZt68rQIzzFPjaqI3hy6M0gZMeLLkaQCyhDU7jhg/GNLBu2JzhqWYECwNFW8f1iKZGLqKkMpgYk6k5uhDDkYQUSvup01E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aJVqbR4/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5rZxIwSj; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aJVqbR4/; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5rZxIwSj; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 538A91F8CD;
	Mon,  5 Feb 2024 15:48:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707148093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tIlPEBbYNedFNTN9r1hjEOcNs9HPcuNKsQ8uu7scl4s=;
	b=aJVqbR4/M7eze9aN2nCSDOgp1yw0HUywj6O2qR00Gy8w1zW18V0rxP1yTPP4JESQfLUG61
	5kgUxJCVjeBN8Adeks4hojgSIot/z/iW345YKQBKUV/6B6EjxNCRqNVp3Id/wN1qFr54HG
	EUrHykgJVVgkHmcmgBQTfxpPYHyaJ78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707148093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tIlPEBbYNedFNTN9r1hjEOcNs9HPcuNKsQ8uu7scl4s=;
	b=5rZxIwSjDW9zjzvEEpcH8PZbteGR2HpXGaV5MRyCCkAuGQUImnUAPTu7Wz+XXvezlAgHE3
	YcTgMj6NIZFKBZBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707148093; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tIlPEBbYNedFNTN9r1hjEOcNs9HPcuNKsQ8uu7scl4s=;
	b=aJVqbR4/M7eze9aN2nCSDOgp1yw0HUywj6O2qR00Gy8w1zW18V0rxP1yTPP4JESQfLUG61
	5kgUxJCVjeBN8Adeks4hojgSIot/z/iW345YKQBKUV/6B6EjxNCRqNVp3Id/wN1qFr54HG
	EUrHykgJVVgkHmcmgBQTfxpPYHyaJ78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707148093;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=tIlPEBbYNedFNTN9r1hjEOcNs9HPcuNKsQ8uu7scl4s=;
	b=5rZxIwSjDW9zjzvEEpcH8PZbteGR2HpXGaV5MRyCCkAuGQUImnUAPTu7Wz+XXvezlAgHE3
	YcTgMj6NIZFKBZBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 44B84136F5;
	Mon,  5 Feb 2024 15:48:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PELCED0DwWVbBgAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 05 Feb 2024 15:48:13 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id CEDE5A0809; Mon,  5 Feb 2024 16:48:12 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: rtm@csail.mit.edu,
	Jan Kara <jack@suse.cz>
Subject: [PATCH] udf: Avoid invalid LVID used on mount
Date: Mon,  5 Feb 2024 16:48:10 +0100
Message-Id: <20240205154810.5428-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3164; i=jack@suse.cz; h=from:subject; bh=NILpUe0L5RxDffvhAf4jZtccOO5BbJ/TcR4U6jFwhuM=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlwQM5A2w6bLejW0tIKfDz4C4/NjEV12JAueB/A7rN zxxKWoaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZcEDOQAKCRCcnaoHP2RA2SJEB/ 0Qhr5ehQTf9/OGWCyBY5PoKpKEiP6zzm0ozkS7KPHtW3+wzJjANPC7Lf8UAhWHz/Kh9LCOyXWF/YBp No2Fcz35tptm4PHCCInwsyaRT7TskQd/aa//22xYPqY8koA8bPSrbwElE2c8/bfjlwkQNsB5zpcuA0 HEGY6QQ+qeDKU7P7XRhJjDk/YLQHqGjkHazPav8tdXaCQ12v7/mpNT9SewArtjDn5iSVajgAqEeA3o P8liMLSHEmABcWXZ+OYXiECub3odqxr+rr3TnnLQycabXMHK2WzSMtyyTiVnVfHgTlu/3Qnx9EKl0y Mwd8Q9x0JDgjUWicb3kX0EzE0zVxhs
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="aJVqbR4/";
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=5rZxIwSj
X-Spamd-Result: default: False [4.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[3];
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
	 RCVD_TLS_ALL(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 4.69
X-Rspamd-Queue-Id: 538A91F8CD
X-Spam-Level: ****
X-Spam-Flag: NO
X-Spamd-Bar: ++++

udf_load_logicalvolint() loads logical volume integrity descriptors.
Since there can be multiple blocks with LVIDs, we verify the contents of
only the last (prevailing) LVID found. However if we fail to load the
last LVID (either due to IO error or because it's checksum fails to
match), we never perform the verification of validity of the LVID we are
going to use. If such LVID contains invalid data, we can hit
out-of-bounds access or similar issues. Fix the problem by verifying
each LVID we are potentially going to accept.

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/super.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

I plan to merge this fix to my tree.

diff --git a/fs/udf/super.c b/fs/udf/super.c
index 928a04d9d9e0..63faf4ffa962 100644
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1539,6 +1539,20 @@ static int udf_load_logicalvol(struct super_block *sb, sector_t block,
 	return ret;
 }
 
+static bool udf_lvid_valid(struct super_block *sb,
+			   struct logicalVolIntegrityDesc *lvid)
+{
+	u32 parts, impuselen;
+
+	parts = le32_to_cpu(lvid->numOfPartitions);
+	impuselen = le32_to_cpu(lvid->lengthOfImpUse);
+	if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
+	    sizeof(struct logicalVolIntegrityDesc) + impuselen +
+	    2 * parts * sizeof(u32) > sb->s_blocksize)
+		return false;
+	return true;
+}
+
 /*
  * Find the prevailing Logical Volume Integrity Descriptor.
  */
@@ -1549,7 +1563,6 @@ static void udf_load_logicalvolint(struct super_block *sb, struct kernel_extent_
 	struct udf_sb_info *sbi = UDF_SB(sb);
 	struct logicalVolIntegrityDesc *lvid;
 	int indirections = 0;
-	u32 parts, impuselen;
 
 	while (++indirections <= UDF_MAX_LVID_NESTING) {
 		final_bh = NULL;
@@ -1571,32 +1584,27 @@ static void udf_load_logicalvolint(struct super_block *sb, struct kernel_extent_
 		if (!final_bh)
 			return;
 
-		brelse(sbi->s_lvid_bh);
-		sbi->s_lvid_bh = final_bh;
-
 		lvid = (struct logicalVolIntegrityDesc *)final_bh->b_data;
+		if (udf_lvid_valid(sb, lvid)) {
+			brelse(sbi->s_lvid_bh);
+			sbi->s_lvid_bh = final_bh;
+		} else {
+			udf_warn(sb, "Corrupted LVID (parts=%u, impuselen=%u), "
+				 "ignoring.\n",
+				 le32_to_cpu(lvid->numOfPartitions),
+				 le32_to_cpu(lvid->lengthOfImpUse));
+		}
+
 		if (lvid->nextIntegrityExt.extLength == 0)
-			goto check;
+			return;
 
 		loc = leea_to_cpu(lvid->nextIntegrityExt);
 	}
 
 	udf_warn(sb, "Too many LVID indirections (max %u), ignoring.\n",
 		UDF_MAX_LVID_NESTING);
-out_err:
 	brelse(sbi->s_lvid_bh);
 	sbi->s_lvid_bh = NULL;
-	return;
-check:
-	parts = le32_to_cpu(lvid->numOfPartitions);
-	impuselen = le32_to_cpu(lvid->lengthOfImpUse);
-	if (parts >= sb->s_blocksize || impuselen >= sb->s_blocksize ||
-	    sizeof(struct logicalVolIntegrityDesc) + impuselen +
-	    2 * parts * sizeof(u32) > sb->s_blocksize) {
-		udf_warn(sb, "Corrupted LVID (parts=%u, impuselen=%u), "
-			 "ignoring.\n", parts, impuselen);
-		goto out_err;
-	}
 }
 
 /*
-- 
2.35.3



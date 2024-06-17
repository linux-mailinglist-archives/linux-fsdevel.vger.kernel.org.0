Return-Path: <linux-fsdevel+bounces-21827-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1070390B564
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3DAA282DDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2B113C3E0;
	Mon, 17 Jun 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Q7SZjLV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Y8Vb1TDb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DB8B13A409;
	Mon, 17 Jun 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638925; cv=none; b=Sc0HApc/Yj2yO5gHErZ11JtKm8b7JF+mVBUHM2hsWnjEO9SwVcnbvQ+9SJ1EyWUNRbeNVgCsB4Dd1lPbZisW2Wut+mMsq+Sq+2sKdxOhNZIqJykfb6/ROFoHYfr8+Bx7SKaG6tnEZ7J92p3vWBhtPdV4EUuWEGgyqej0np5N99I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638925; c=relaxed/simple;
	bh=VmEnMsRb5zoPMY186ov1+GegGp8bDkrgGeHd14mjkws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nSEeg8tVJluw3gGE55Z40ytX5CMiheRNkVXTJpZoCGZaDXNsnUhkU+KYADTTt7k1tUWOZWbZNkAsX2tPaRfRTRYbY+B8ELwuDxUe5KwLeiRsvIudgzwQXV6m20u25KG6c8jxccKgkLHs9v3oZbCOeGJIZfG7lHEJNx0DBA6Kw8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Q7SZjLV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Y8Vb1TDb; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA4E7383B8;
	Mon, 17 Jun 2024 15:42:01 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718638921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4szfb1pB4BrQDCmfE8z1lzoBTq1uzIk/Uwihz/qiLI=;
	b=1Q7SZjLVKu15nDRXs3B74Jmd584tBTdPS30niA58Pzl9qXItU1OmmDQYYUUuLtEW+8ARw/
	4/o/q5X6btbO3fbHJHrhoOEyL94r9BLRZbTmc2UFd9MsS61nb+oAdnCTZrrr2anuDHMnxc
	m7LtlmFGt4/WUQJGuEe3PRivAKWuECE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718638921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I4szfb1pB4BrQDCmfE8z1lzoBTq1uzIk/Uwihz/qiLI=;
	b=Y8Vb1TDb8D1LBs8h69i+UsOvk62S6xS+jflPo3KHW7LwAScpQIqbc8dXCmAiuYUxaIR70z
	5Ij1Ikd4Ua0QI1CQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9B64813AC0;
	Mon, 17 Jun 2024 15:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id exwkJklZcGYpcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 15:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 3C586A088B; Mon, 17 Jun 2024 17:42:01 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	syzbot+5f682cd029581f9edfd1@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH 2/3] udf: Avoid using corrupted block bitmap buffer
Date: Mon, 17 Jun 2024 17:41:52 +0200
Message-Id: <20240617154201.29512-2-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617154024.22295-1-jack@suse.cz>
References: <20240617154024.22295-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1778; i=jack@suse.cz; h=from:subject; bh=VmEnMsRb5zoPMY186ov1+GegGp8bDkrgGeHd14mjkws=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmcFk/gsT55Q1HIC05YIi1G6JBlP8pIoyL6wO3s5+I v5kuulaJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnBZPwAKCRCcnaoHP2RA2drOCA Cmcpu2JCwA8hplcTt0bV40ALC0DKIL2ycbs3ojsycTu4g6p5NwitQTXJ5wEGOESxqmZuhGTn3vf6MW sTw661F2SRY+RDSxQ1xw5/kvVSIn6YvzZ0DU5hrI1F+XVJyt89q5YX68Au5Jb7psk17ITTDjNmKnvW InYxqSYmWYYCLQAqkovsmawYt/ALMh3omPHmQ2MO5TSsRo018dsEO1hHHrPwByJJLNNBTI21TMsqvP IsR7aczccezjJPAYioXmrJf2wZfHcZLHHglSZ2IViwH/MrSBOFp1DuNosMbw8anpMol96CN3fzokvG kI2J4MtWIHmrjTFRXZC8/kkimzXQKJ
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	TAGGED_RCPT(0.00)[5f682cd029581f9edfd1]
X-Rspamd-Queue-Id: AA4E7383B8
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -4.00
X-Spam-Level: 

When the filesystem block bitmap is corrupted, we detect the corruption
while loading the bitmap and fail the allocation with error. However the
next allocation from the same bitmap will notice the bitmap buffer is
already loaded and tries to allocate from the bitmap with mixed results
(depending on the exact nature of the bitmap corruption). Fix the
problem by using BH_verified bit to indicate whether the bitmap is valid
or not.

Reported-by: syzbot+5f682cd029581f9edfd1@syzkaller.appspotmail.com
CC: stable@vger.kernel.org
Fixes: 1e0d4adf17e7 ("udf: Check consistency of Space Bitmap Descriptor")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/balloc.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index ab3ffc355949..558ad046972a 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -64,8 +64,12 @@ static int read_block_bitmap(struct super_block *sb,
 	}
 
 	for (i = 0; i < count; i++)
-		if (udf_test_bit(i + off, bh->b_data))
+		if (udf_test_bit(i + off, bh->b_data)) {
+			bitmap->s_block_bitmap[bitmap_nr] =
+							ERR_PTR(-EFSCORRUPTED);
+			brelse(bh);
 			return -EFSCORRUPTED;
+		}
 	return 0;
 }
 
@@ -81,8 +85,15 @@ static int __load_block_bitmap(struct super_block *sb,
 			  block_group, nr_groups);
 	}
 
-	if (bitmap->s_block_bitmap[block_group])
+	if (bitmap->s_block_bitmap[block_group]) {
+		/*
+		 * The bitmap failed verification in the past. No point in
+		 * trying again.
+		 */
+		if (IS_ERR(bitmap->s_block_bitmap[block_group]))
+			return PTR_ERR(bitmap->s_block_bitmap[block_group]);
 		return block_group;
+	}
 
 	retval = read_block_bitmap(sb, bitmap, block_group, block_group);
 	if (retval < 0)
-- 
2.35.3



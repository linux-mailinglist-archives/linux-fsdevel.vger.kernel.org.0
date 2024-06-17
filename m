Return-Path: <linux-fsdevel+bounces-21826-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2BA790B563
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 17:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 079821C20C47
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jun 2024 15:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9279B13C3D5;
	Mon, 17 Jun 2024 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aJI8BvE3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0w42aqn4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aJI8BvE3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="0w42aqn4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EE116A33A
	for <linux-fsdevel@vger.kernel.org>; Mon, 17 Jun 2024 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718638925; cv=none; b=JphGk+NDHgnlNQDMtdiPbNhygx6kU3wWa95AML0buuZETzENssKxbLCdJyFqdwccSj7RzLY3PzU6bAiOUNCTGvu6DlblwkO7Igsd8Ih1d2HqdzLaj1yVHJsQAWQ46W9wL1YL3YYvTG+DMcD+P/bWby4St1Ivr1Vkab0RZ1zpKcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718638925; c=relaxed/simple;
	bh=Y+nNtCB7xLtYkMRjcmtchfkCbsoWb1OISgNYktgpSTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ao3R8bnX7nbtRJ9D6yedHbEN2i+CVJS4Lnvp2l5Ap5+3an4ef8uyoQZR14l46k2Avw1J9L2ZZcyTxk9eMUwJDkkPmEJiPtZfAETwj7v+gqAtM2AOFq3kSiPk7IfT1kxqQHTKiarKaolM5XPXlvR24pI1gKzudrJ74pHH3gDpc+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aJI8BvE3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0w42aqn4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aJI8BvE3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=0w42aqn4; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AED60602F0;
	Mon, 17 Jun 2024 15:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718638921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeD1YV4rpleWyejUzwtT2uBg5F5uH7warSFW/H/jmlU=;
	b=aJI8BvE3IPrbDbW9a6r4OJhhHb7yzCn2yZl7YyLgZZxAVOKgLlq54bXZSMmzWMEgQmvSDg
	26E9S29WiHIWapPmQYwr0LE/AV7oX2DO5X+OpDPN9WMSLiXm6cuwy1mFWedZ6VwPR1q3HF
	13OqdHN7lsu+SDkGCRNB+h6opbxd2GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718638921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeD1YV4rpleWyejUzwtT2uBg5F5uH7warSFW/H/jmlU=;
	b=0w42aqn4Webu256U7R0IXkUo9QY8Ef9oNewGjVHeqirB7x5qdhWziSh+EQ/1qkZ9XkHWFX
	Lo7XPRImixbHk0BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1718638921; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeD1YV4rpleWyejUzwtT2uBg5F5uH7warSFW/H/jmlU=;
	b=aJI8BvE3IPrbDbW9a6r4OJhhHb7yzCn2yZl7YyLgZZxAVOKgLlq54bXZSMmzWMEgQmvSDg
	26E9S29WiHIWapPmQYwr0LE/AV7oX2DO5X+OpDPN9WMSLiXm6cuwy1mFWedZ6VwPR1q3HF
	13OqdHN7lsu+SDkGCRNB+h6opbxd2GI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1718638921;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NeD1YV4rpleWyejUzwtT2uBg5F5uH7warSFW/H/jmlU=;
	b=0w42aqn4Webu256U7R0IXkUo9QY8Ef9oNewGjVHeqirB7x5qdhWziSh+EQ/1qkZ9XkHWFX
	Lo7XPRImixbHk0BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9D3D913AC1;
	Mon, 17 Jun 2024 15:42:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id u6VhJklZcGYrcAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 17 Jun 2024 15:42:01 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 4341CA08A4; Mon, 17 Jun 2024 17:42:01 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Jan Kara <jack@suse.cz>
Subject: [PATCH 3/3] udf: Drop load_block_bitmap() wrapper
Date: Mon, 17 Jun 2024 17:41:53 +0200
Message-Id: <20240617154201.29512-3-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240617154024.22295-1-jack@suse.cz>
References: <20240617154024.22295-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1423; i=jack@suse.cz; h=from:subject; bh=Y+nNtCB7xLtYkMRjcmtchfkCbsoWb1OISgNYktgpSTc=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBmcFlAmTWErxjlf++Q113MpkzJP6vdsvxf0JkvoJYH KyIj8HuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZnBZQAAKCRCcnaoHP2RA2Sh1B/ 4+vO5/MV7ftLR53Anl6dNqOWAh2tYwSmBsm2Kkz4fjh/xr0FYgIuS4Bwca9c+wuP+XtxiwZekPAn27 tijjXefuHBuQhus3WvtJF0zcrU0pCHbvTbVd1aMxBLVSZ81QZlIvzXvkICJFA5nNhmfp6yvqhSqAK1 kuwez2DHPc7assH/6jeBuykZpEIN5eerlCOXj2w6IjwtLDCxV/bAKnTeW+IASgYmDXJ5gfu8RgAZBh zuRSMysjtTs9BtKg7giDj3oHWvxY0eXQ5GkidDZkFnRzB2lJctYu9V06fKIcs4f4rBmW+ygk8dyZ3N NZlAYdqBaYYxRlUN2pj8rRNaR7Qhjc
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.78 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-2.99)[99.94%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.986];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email]
X-Spam-Flag: NO
X-Spam-Score: -6.78
X-Spam-Level: 

The wrapper is completely pointless as all the checks are already done
in __load_block_bitmap(). Just drop it and rename __load_block_bitmap().

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/balloc.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/fs/udf/balloc.c b/fs/udf/balloc.c
index 558ad046972a..a76490b2ca19 100644
--- a/fs/udf/balloc.c
+++ b/fs/udf/balloc.c
@@ -73,9 +73,9 @@ static int read_block_bitmap(struct super_block *sb,
 	return 0;
 }
 
-static int __load_block_bitmap(struct super_block *sb,
-			       struct udf_bitmap *bitmap,
-			       unsigned int block_group)
+static int load_block_bitmap(struct super_block *sb,
+			     struct udf_bitmap *bitmap,
+			     unsigned int block_group)
 {
 	int retval = 0;
 	int nr_groups = bitmap->s_nr_groups;
@@ -102,23 +102,6 @@ static int __load_block_bitmap(struct super_block *sb,
 	return block_group;
 }
 
-static inline int load_block_bitmap(struct super_block *sb,
-				    struct udf_bitmap *bitmap,
-				    unsigned int block_group)
-{
-	int slot;
-
-	slot = __load_block_bitmap(sb, bitmap, block_group);
-
-	if (slot < 0)
-		return slot;
-
-	if (!bitmap->s_block_bitmap[slot])
-		return -EIO;
-
-	return slot;
-}
-
 static void udf_add_free_space(struct super_block *sb, u16 partition, u32 cnt)
 {
 	struct udf_sb_info *sbi = UDF_SB(sb);
-- 
2.35.3



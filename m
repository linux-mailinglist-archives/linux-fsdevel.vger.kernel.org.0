Return-Path: <linux-fsdevel+bounces-8587-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEE46839291
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 16:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 481BEB23EF7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Jan 2024 15:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944C25FEFE;
	Tue, 23 Jan 2024 15:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lf1RTar0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukjFYIuX";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Lf1RTar0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="ukjFYIuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC4750A71;
	Tue, 23 Jan 2024 15:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706023529; cv=none; b=kKkrsCgONn8pkuptGTvDDvTQyScesExBdRZIXuErQTOg+lSp+tVDW3UtxESRQFbSNWTWPS31ksRg/pNFCtCM08oug08fi4Aj4vsfk6VXTJR/j+2sA1JrbOKuPWtpdtyyayKn+Cz23cj7LXQqM2leQIoOKWFITSXzAmgPfkS+Iqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706023529; c=relaxed/simple;
	bh=5bQr+Ha8gFH12hdvNUJslYgvohqb5ImCJsuLlAN8XXg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lpnZR2rlR02fxfjjGQAytOUhxx2QifLdmPEMGtTFxN8H1SSyKBRxvhMbV+GJw4LSfDwvSE3iOCCIqjgLhuDDlQ5Lpwud3eI6KGpzxruHo1L3F2PDgOQBufybUrdTEQCr/1VbEwONx48kWUr0Gc03tPE7En4hPuSaSheYwnoLwqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lf1RTar0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukjFYIuX; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Lf1RTar0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=ukjFYIuX; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 84AD8222AC;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu2ae060uuJ6wXoYcqiz2HGb2x/G8FHqkHENUKtU6P8=;
	b=Lf1RTar0lo+5fDJ9W+ZyyGXvUiLtctp2h9QpusKE+8Eevo5AtvqSR9LzW5qykWhlYvUrsz
	coB29xwW3AGSn5BttKslxkGUNnsy4YeWlPgj2GzMW2ZW8/j/rz3beBZyEHWenwwLx/oBLF
	xdCsx5RcCMSgK2nrd9uaGWUIWesZL9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu2ae060uuJ6wXoYcqiz2HGb2x/G8FHqkHENUKtU6P8=;
	b=ukjFYIuXSUw5K6+eqs0VsSFG68QAW9p+0ZLmfr0nsU/S84f1hB7n7D0lTTHVYFWcWteyZg
	TBtF1vJPLzSjhVDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1706023525; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu2ae060uuJ6wXoYcqiz2HGb2x/G8FHqkHENUKtU6P8=;
	b=Lf1RTar0lo+5fDJ9W+ZyyGXvUiLtctp2h9QpusKE+8Eevo5AtvqSR9LzW5qykWhlYvUrsz
	coB29xwW3AGSn5BttKslxkGUNnsy4YeWlPgj2GzMW2ZW8/j/rz3beBZyEHWenwwLx/oBLF
	xdCsx5RcCMSgK2nrd9uaGWUIWesZL9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1706023525;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eu2ae060uuJ6wXoYcqiz2HGb2x/G8FHqkHENUKtU6P8=;
	b=ukjFYIuXSUw5K6+eqs0VsSFG68QAW9p+0ZLmfr0nsU/S84f1hB7n7D0lTTHVYFWcWteyZg
	TBtF1vJPLzSjhVDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 70A05139B9;
	Tue, 23 Jan 2024 15:25:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6xANG2Xar2WcdQAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 23 Jan 2024 15:25:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D60A1A0804; Tue, 23 Jan 2024 16:25:20 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: <linux-ext4@vger.kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/9] udf: Remove GFP_NOFS from dir iteration code
Date: Tue, 23 Jan 2024 16:25:00 +0100
Message-Id: <20240123152520.4294-1-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240123152113.13352-1-jack@suse.cz>
References: <20240123152113.13352-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1181; i=jack@suse.cz; h=from:subject; bh=5bQr+Ha8gFH12hdvNUJslYgvohqb5ImCJsuLlAN8XXg=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBlr9pMvnPhSSAbDWXgDn8IPkr058JslJ+zOPfDwL0g j/lPZv2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZa/aTAAKCRCcnaoHP2RA2YDgCA DZ9mWJSopbKG9E5G8rtSGZZe8jjPfgUIhcZVwDNo2p0jkR7s/AYR4EU3cneG7Wn6wqWzLgqW1YLAOa iZUd9Odxx95Adljq7Miomd6SHBH4t5GaiTmEwnD0G7ISvkDioql7CwXfJc29QnARgMz5y0a5aiRlfq TdMtg6vD4hEy6qmMhvmPwawg+E8zF5A7tI2xHMUJSbgTjJ+RU+sGMspFeD/znXLlDdlK7AKnnKBHI6 fpaXHWjQaX7BF0JNG72G+Xe9ViExZHTNkhWpgSewUH+MKo24uj9tdL3QBTHr3ZWYgASYQSfy5l6S8S O54olkmkfEaoN3u9a/XM/q2ZrUA81G
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [4.90 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 RCPT_COUNT_THREE(0.00)[4];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 MID_CONTAINS_FROM(1.00)[];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Level: ****
X-Spam-Score: 4.90
X-Spam-Flag: NO

Directory iteration code was using GFP_NOFS allocations in two places.
However the code is called only under inode->i_rwsem which is generally
safe wrt reclaim. So we can do the allocations with GFP_KERNEL instead.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/udf/dir.c   | 2 +-
 fs/udf/namei.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/udf/dir.c b/fs/udf/dir.c
index f6533f93851b..f94f45fe2c91 100644
--- a/fs/udf/dir.c
+++ b/fs/udf/dir.c
@@ -67,7 +67,7 @@ static int udf_readdir(struct file *file, struct dir_context *ctx)
 		pos_valid = true;
 	}
 
-	fname = kmalloc(UDF_NAME_LEN, GFP_NOFS);
+	fname = kmalloc(UDF_NAME_LEN, GFP_KERNEL);
 	if (!fname) {
 		ret = -ENOMEM;
 		goto out;
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index 1bb6ed948927..1f14a0621a91 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -59,7 +59,7 @@ static int udf_fiiter_find_entry(struct inode *dir, const struct qstr *child,
 		child->name[0] == '.' && child->name[1] == '.';
 	int ret;
 
-	fname = kmalloc(UDF_NAME_LEN, GFP_NOFS);
+	fname = kmalloc(UDF_NAME_LEN, GFP_KERNEL);
 	if (!fname)
 		return -ENOMEM;
 
-- 
2.35.3



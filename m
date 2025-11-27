Return-Path: <linux-fsdevel+bounces-70062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0249EC8FB3D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE643AD4D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347BB2EB5DC;
	Thu, 27 Nov 2025 17:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wujLnMMD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oKysOTmD";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="wujLnMMD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oKysOTmD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099C2287507
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264653; cv=none; b=qYi7n6GEBTOtOZswYVtFquPmzU4ghJydUGyGP3oWIB5pHt/fnArWm7eJLo9YOcIT9bYmd6sUifrBy8d6mGg1HLCszsIU9yBGIbKPLVf9Uq2B7zKqDFjjIOvdkJx7t5a4Mz2UPps1tjYAMI1Y/bceiptdLi5B8I8pe7dS5WMyrlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264653; c=relaxed/simple;
	bh=hPYW0NIiHWXH4qWx3l6E6TNnpxL1rspHxO+oT1mNt9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DsKuIN/InmRmouAyi3SsMQrjTc+mNkWxuGSJL98fmcSlPT3/Avxcy7pVUv7jkTrOLgc9lA1zqSDWstQhGrLXarxHyUA232xzQQ5hWR0x7uwMzKZqCeokWa1CiGPgNmYVgITNbJyb8sZCg/y/LbxV/n9Xirbroi7rD7RpYG2MKik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wujLnMMD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oKysOTmD; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=wujLnMMD; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oKysOTmD; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3FA635BCD1;
	Thu, 27 Nov 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOHgufutIEIzClabAnCKsaMx30cxvhMu4zJes017tLs=;
	b=wujLnMMDGJZ0ddnU9OSW8eT3SuSo1gH9lzEKJdN4f01Y8X3HcfLI0DNfqz+sqq1V8Byy37
	bT4EO7yjV/LkoM1d2iuCtn2AavNgO5mj+HY8HLDCOr/XQ76dSlBJdDzAwZAU8FFNuqWMlI
	tNtkzBD/Q6qYhzl4UC0duG63Me5fU2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOHgufutIEIzClabAnCKsaMx30cxvhMu4zJes017tLs=;
	b=oKysOTmDwl6fWQ9H0yPpIxSmdLb76vVJ44a82dqI0mtLmRVzAfEfBxVmIg54GGylGnI9aS
	sUUF+DPQ4Mw0AjBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOHgufutIEIzClabAnCKsaMx30cxvhMu4zJes017tLs=;
	b=wujLnMMDGJZ0ddnU9OSW8eT3SuSo1gH9lzEKJdN4f01Y8X3HcfLI0DNfqz+sqq1V8Byy37
	bT4EO7yjV/LkoM1d2iuCtn2AavNgO5mj+HY8HLDCOr/XQ76dSlBJdDzAwZAU8FFNuqWMlI
	tNtkzBD/Q6qYhzl4UC0duG63Me5fU2Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hOHgufutIEIzClabAnCKsaMx30cxvhMu4zJes017tLs=;
	b=oKysOTmDwl6fWQ9H0yPpIxSmdLb76vVJ44a82dqI0mtLmRVzAfEfBxVmIg54GGylGnI9aS
	sUUF+DPQ4Mw0AjBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 838343EA70;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id XGXNH7KKKGmdPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 680DBA0CB3; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 13/13] fsnotify: Rename FSNOTIFY_MARK_FLAG_NO_IREF
Date: Thu, 27 Nov 2025 18:30:20 +0100
Message-ID: <20251127173012.23500-26-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3163; i=jack@suse.cz; h=from:subject; bh=hPYW0NIiHWXH4qWx3l6E6TNnpxL1rspHxO+oT1mNt9M=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIquybHnX66YTV9L51HCnDhuGX42wqvQW3yHP qqlQRPM1uiJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKrgAKCRCcnaoHP2RA 2bigB/9gzCez8kMd0O1Qa/FklqoucWd4FH4vESgOmz+EUMs2iCFEgqcJqXuGqKYuJvWth5rBXkv 8QsbaiY69TiVaVkmxtzM9nOzcUDaE3u1Te1i1nj8u0lYX3/mBpVIyC4vUOBAOvlL7Cuh1XYiSA+ OmZIVZQkaovQI/cMEfq0sEfOP+Ebv3Sz/KlDLzu6U/1Pa9Q6c6ZiyoL3EQbDcOa9WLbFFxt1nIt Dw0EKE4lQtrVq7/J1p7U5ciwlPy6ZtkMy0r0JSiTgJzt1+bRI/1+YN+PqduiurdNUifA28VBUoL BHR6H5W6WkdV65R2AIg4FBSTqEj68w2LRil1q8GQ1buC+wqo
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid,suse.cz:email];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -2.80
X-Spam-Flag: NO

Since notification marks no longer hold inode references the name of
flag FSNOTIFY_MARK_FLAG_NO_IREF doesn't make sense anymore. Rename it to
FSNOTIFY_MARK_FLAG_EVICTABLE.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fanotify/fanotify.h      | 2 +-
 fs/notify/fanotify/fanotify_user.c | 8 ++++----
 include/linux/fsnotify_backend.h   | 2 +-
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.h b/fs/notify/fanotify/fanotify.h
index b78308975082..1521a5bf2b9e 100644
--- a/fs/notify/fanotify/fanotify.h
+++ b/fs/notify/fanotify/fanotify.h
@@ -538,7 +538,7 @@ static inline unsigned int fanotify_mark_user_flags(struct fsnotify_mark *mark)
 
 	if (mark->flags & FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY)
 		mflags |= FAN_MARK_IGNORED_SURV_MODIFY;
-	if (mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF)
+	if (mark->flags & FSNOTIFY_MARK_FLAG_EVICTABLE)
 		mflags |= FAN_MARK_EVICTABLE;
 	if (mark->flags & FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS)
 		mflags |= FAN_MARK_IGNORE;
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 2c440ea96521..c820fe9aee20 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1213,9 +1213,9 @@ static bool fanotify_mark_update_flags(struct fsnotify_mark *fsn_mark,
 	if (ignore == FAN_MARK_IGNORE)
 		fsn_mark->flags |= FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS;
 
-	/* NO_IREF may be removed from a mark, but not added */
+	/* EVICTABLE may be removed from a mark, but not added */
 	if (!(fan_flags & FAN_MARK_EVICTABLE))
-		fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_NO_IREF;
+		fsn_mark->flags &= ~FSNOTIFY_MARK_FLAG_EVICTABLE;
 
 	/*
 	 * Setting FAN_MARK_IGNORED_SURV_MODIFY for the first time may lead to
@@ -1339,7 +1339,7 @@ static struct fsnotify_mark *fanotify_add_new_mark(struct fsnotify_group *group,
 	mark = &fan_mark->fsn_mark;
 	fsnotify_init_mark(mark, group);
 	if (fan_flags & FAN_MARK_EVICTABLE)
-		mark->flags |= FSNOTIFY_MARK_FLAG_NO_IREF;
+		mark->flags |= FSNOTIFY_MARK_FLAG_EVICTABLE;
 
 	/* Cache fsid of filesystem containing the marked object */
 	if (fsid) {
@@ -1381,7 +1381,7 @@ static int fanotify_may_update_existing_mark(struct fsnotify_mark *fsn_mark,
 	 * Non evictable mark cannot be downgraded to evictable mark.
 	 */
 	if (fan_flags & FAN_MARK_EVICTABLE &&
-	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_NO_IREF))
+	    !(fsn_mark->flags & FSNOTIFY_MARK_FLAG_EVICTABLE))
 		return -EEXIST;
 
 	/*
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index c7ca848f576c..4b7bd48dd9aa 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -628,7 +628,7 @@ struct fsnotify_mark {
 #define FSNOTIFY_MARK_FLAG_IN_ONESHOT		0x0020
 	/* fanotify mark flags */
 #define FSNOTIFY_MARK_FLAG_IGNORED_SURV_MODIFY	0x0100
-#define FSNOTIFY_MARK_FLAG_NO_IREF		0x0200
+#define FSNOTIFY_MARK_FLAG_EVICTABLE		0x0200
 #define FSNOTIFY_MARK_FLAG_HAS_IGNORE_FLAGS	0x0400
 #define FSNOTIFY_MARK_FLAG_HAS_FSID		0x0800
 #define FSNOTIFY_MARK_FLAG_WEAK_FSID		0x1000
-- 
2.51.0



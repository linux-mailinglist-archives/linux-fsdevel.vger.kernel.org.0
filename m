Return-Path: <linux-fsdevel+bounces-70055-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 347ABC8FB37
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 764BD4E7120
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998C92ED14C;
	Thu, 27 Nov 2025 17:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z+YE0Zgt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HAg7h3Vl";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Z+YE0Zgt";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HAg7h3Vl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 065CC2EDD50
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264630; cv=none; b=f16RLs2cfHs47CQWmD4stzXpgP5+rSFB8JAje2wCT0DcumLR6HRH/+chgtqclnFq1jhFcP1sQWVlyYjx3Rv7+fINxETRjvua1BMGsWd+8T+RyLQzXFTKT0LyaugH3aqPacyFuC4ldHkbaM/3Wn96Pvp1Gd14TgNbcbggBIXuqaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264630; c=relaxed/simple;
	bh=SXdzebkcTzkpS0rpffNRongTBL5kTthsWaOJQGLgJKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMjudESHn0U4pWPC+2svMeYycbCIpb5lPgM8x6HdppBwcLE+LSuPiwDiDj1IEtJtMG0sNrS0xDZp7EnigqBfyz1Fi0/4vgI/dd8LqO4mbjtgdBKtEBVe179vZiNxLmw305XfperWBPrqt9l3vEknHlZvu7aWm+WPlOdzv8H5Wyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z+YE0Zgt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HAg7h3Vl; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Z+YE0Zgt; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HAg7h3Vl; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C4CC25BCC1;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0YyYnPeMPPfE4a64UWhD2dSNip5bT/P607gEPqGkAA=;
	b=Z+YE0ZgtbdVwR9bjQmyDhsxDCIeebtZ0bghbAFpNgY9c+pQn1wsyzEAsL6y3R/iIXt0eRH
	NCm8tjFCnsm/tWxm2RE53GAPWGuPSm1hn67ILsfbArE6YZ0HAuSZZNio6UY8Lw0ht2kwJS
	pKkgbKcOuC+K4qXOPWIAcoILHunq6wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0YyYnPeMPPfE4a64UWhD2dSNip5bT/P607gEPqGkAA=;
	b=HAg7h3VlOXc2gkgSXVdTyKSPcZAuumWfS/GtXNGdysXcsqpF1YjaQkesN4Y78Xk7RKaKAR
	5v59z2D/+Wr8e2DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0YyYnPeMPPfE4a64UWhD2dSNip5bT/P607gEPqGkAA=;
	b=Z+YE0ZgtbdVwR9bjQmyDhsxDCIeebtZ0bghbAFpNgY9c+pQn1wsyzEAsL6y3R/iIXt0eRH
	NCm8tjFCnsm/tWxm2RE53GAPWGuPSm1hn67ILsfbArE6YZ0HAuSZZNio6UY8Lw0ht2kwJS
	pKkgbKcOuC+K4qXOPWIAcoILHunq6wg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B0YyYnPeMPPfE4a64UWhD2dSNip5bT/P607gEPqGkAA=;
	b=HAg7h3VlOXc2gkgSXVdTyKSPcZAuumWfS/GtXNGdysXcsqpF1YjaQkesN4Y78Xk7RKaKAR
	5v59z2D/+Wr8e2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B1C103EA63;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rQlgK7GKKGlyPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 08D0BA0C90; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 01/13] fsnotify: Make detached connectors point to the superblock
Date: Thu, 27 Nov 2025 18:30:08 +0100
Message-ID: <20251127173012.23500-14-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2158; i=jack@suse.cz; h=from:subject; bh=SXdzebkcTzkpS0rpffNRongTBL5kTthsWaOJQGLgJKk=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqktEjZt0yGvv+auFVNTDiasy31gdODYf7mo riHyYQo+SSJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKpAAKCRCcnaoHP2RA 2c+XCACtYCFnmGtnaiFbGZRpwxvj8nfQ5RPj0bREe7ubZ6AFM28dJ4Zktycecs9V9uL16BviweZ IPrBpgWi6CM1Iad4f8Aqtk9rSmW/IAf2jqeJrmkfh3m6sQQbPcchDJBoQPiTjBthOt79HnrFnoE +C4UfgNfm5U5sibTqgDt6Xmy0srW9vc+P1nnMJ+9t7n7DI6AYPQbubXhAF9RD5rjyK9V4NnDQj8 t2+PPkee+xNzdpPVeS4TC43gYPx++XB3xc97tK1jwdoSPvqKleLISdtcGsAkeP3rfHPnhaxztIW YOfQqiYJaCfjnTUEmaP4D+PQPGP6P549BphVgK638hzUjbuY
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Flag: NO
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:mid];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]

Currently detached connectors have no association with the superblock
for which they were created. This will get inconvenient when the
detached connectors will be kept in a hash for later reconnection. So
make detached connectors point to the superblock and fixup the two
places using conn->obj for detecting detached connectors instead of
conn->type.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.h | 2 ++
 fs/notify/mark.c     | 7 ++++---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fsnotify.h b/fs/notify/fsnotify.h
index 5950c7a67f41..860a07ada7fd 100644
--- a/fs/notify/fsnotify.h
+++ b/fs/notify/fsnotify.h
@@ -49,6 +49,8 @@ static inline struct super_block *fsnotify_object_sb(void *obj,
 		return ((struct vfsmount *)obj)->mnt_sb;
 	case FSNOTIFY_OBJ_TYPE_SB:
 		return (struct super_block *)obj;
+	case FSNOTIFY_OBJ_TYPE_DETACHED:
+		return (struct super_block *)obj;
 	default:
 		return NULL;
 	}
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 798340db69d7..26faa2f640b9 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -176,7 +176,7 @@ static void fsnotify_update_sb_watchers(struct super_block *sb,
 	struct fsnotify_mark *first_mark = NULL;
 	unsigned int highest_prio = 0;
 
-	if (conn->obj)
+	if (conn->type != FSNOTIFY_OBJ_TYPE_DETACHED)
 		first_mark = hlist_entry_safe(conn->list.first,
 					      struct fsnotify_mark, obj_list);
 	if (first_mark)
@@ -355,7 +355,8 @@ static void *fsnotify_detach_connector_from_object(
 	}
 
 	rcu_assign_pointer(*connp, NULL);
-	conn->obj = NULL;
+	/* We make detached connectors point to the superblock */
+	conn->obj = sb;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
 	if (sb)
 		fsnotify_update_sb_watchers(sb, conn);
@@ -413,7 +414,7 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		struct super_block *sb = fsnotify_connector_sb(conn);
 
 		/* Update watched objects after detaching mark */
-		if (sb)
+		if (conn->type != FSNOTIFY_OBJ_TYPE_DETACHED)
 			fsnotify_update_sb_watchers(sb, conn);
 		objp = __fsnotify_recalc_mask(conn);
 		type = conn->type;
-- 
2.51.0



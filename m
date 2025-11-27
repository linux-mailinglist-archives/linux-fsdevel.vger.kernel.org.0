Return-Path: <linux-fsdevel+bounces-70061-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F984C8FB50
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B17FC4E8B91
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE1DF2EB5AF;
	Thu, 27 Nov 2025 17:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="G5+ecaEF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="BCeH7jvB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="X6ywerO7";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="rgr3109u"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97E221578
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264653; cv=none; b=YKc41McwwFaxLTuyjypnxnJcjhqtpQcgf4Ue1l5rfqg9OcbBt06Tm92OaUnQkPy5l5WO3R36Y8ry1Ohjy7RNlcmCW3rWIfYuSGxdu78A14E8ZWG/CMq+pg9JmOeLc9wp5eOKFO/+DwU6BOP6NO40deilf9+rS7uEJhcHCwmkyEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264653; c=relaxed/simple;
	bh=Tu+OS0rjXNCs0GADjh0mulePznoXBJ4fWULOU2F9u8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jc3OQvy9pHRPUrkTlEqa8tFZP6vWh43XajXAWEH9EKenwqx+JH7Pq2em9cN7qL4ikUronj9eowecksJvq70nStEddZ55mkVb46v9umwuLuBdYNI+Wo72PWu1dxmyxNCa+aRs8TtxkkY/8xf71TxRPKxk6U3wIkoi6Bx8YQcnTII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=G5+ecaEF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=BCeH7jvB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=X6ywerO7; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=rgr3109u; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E3957219C0;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k29L9qFkOUIbKun/R9ykWxo21i8GJzkSAWdlj6+LSh4=;
	b=G5+ecaEFNCRHpLW7bsPcYgBEuayb44IRtVI30qgiq2Utkq4Ol3zc82K1eTgerb4dvAJwlm
	C0mBMoh6ayHRrkajlzDsZU3RY2GrQLf6V9j7NgLjFp/Ie2JUneP45zI8FwcoyMWELHihTm
	v2Fvw5TZQIbY41tUJRzP9WnHYoZG2lo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k29L9qFkOUIbKun/R9ykWxo21i8GJzkSAWdlj6+LSh4=;
	b=BCeH7jvB8hpwt13feyTs4XVUP5pVY4oi6vgLjVkFeCiKKSi0iGwSKdtTJGysUNl2r5us0V
	IoTptEUY9s7+/BDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=X6ywerO7;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=rgr3109u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k29L9qFkOUIbKun/R9ykWxo21i8GJzkSAWdlj6+LSh4=;
	b=X6ywerO7ViCla4cCLZN7FTgf540IIQQ6MmRuldc3YjiU5QhL6OaC/74yw59W6MbdWIWcK0
	sqgEZ+UcM8+L28EvTa/+y7yUt9pGYdpCpYvmaQQIiSdwwcG5SrWYgYP/WiWc5nNUaVuNO5
	/9PLOYZ7EfBw8OFw21/mfCYaCuvljQw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k29L9qFkOUIbKun/R9ykWxo21i8GJzkSAWdlj6+LSh4=;
	b=rgr3109uQ8wvY7BSavsBRTzwhJBdQhLL28vOBTWqXPxmHNswOUfjpa1gJA2hsmIM7MH3bK
	PAsrk0g0wZsrZHDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BFEE43EA67;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id sgahLrGKKGl5PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 102AEA0C98; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 02/13] fsnotify: Remove sb argument from fsnotify_update_sb_watchers()
Date: Thu, 27 Nov 2025 18:30:09 +0100
Message-ID: <20251127173012.23500-15-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2289; i=jack@suse.cz; h=from:subject; bh=Tu+OS0rjXNCs0GADjh0mulePznoXBJ4fWULOU2F9u8s=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqlFQ15sFYTahxqnrHbxHbIMWQ8Hftyarcq6 5VtBY8jLxuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKpQAKCRCcnaoHP2RA 2bPhCAC8FHgdBxzrEWEuDOleqlaaIuP8OqSq6s8uQdEzq6Qb/XNkmZhoNBtscUAbjvjJhXGQONS 2rbECCg1E92fkrp42pFZIs2Wy9ceuJ6est1jrMJClByJP+NK/RdKCU9K5J/7cl1RtMzoASqh4pM tQ2KkuKHb9T7atmbd1CkckLN51vcBjiqY5quRbLJ+ZjJ038bs7wQbaiuPeNPu3d00PCrVoZ31AU JTil35//068rQNAswGTN04LrcFesp3nc1Gw1m2GOeADWxAnKVoZuxfBVbkjahpUZAacFY2NhZSA gku016hD0GsTLA1kFWvr9bzsQOmksE9u1Ezt8yw4t2CKWIDb
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
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FREEMAIL_CC(0.00)[gmail.com,suse.cz];
	DKIM_TRACE(0.00)[suse.cz:+];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Level: 
X-Spam-Score: -3.01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E3957219C0
X-Rspamd-Action: no action
X-Spam-Flag: NO

Now that connector is always associated with the superblock, there's no
need for the argument.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/mark.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 26faa2f640b9..ecd2c3944051 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -168,9 +168,9 @@ static void fsnotify_put_inode_ref(struct inode *inode)
  * Grab or drop watched objects reference depending on whether the connector
  * is attached and has any marks attached.
  */
-static void fsnotify_update_sb_watchers(struct super_block *sb,
-					struct fsnotify_mark_connector *conn)
+static void fsnotify_update_sb_watchers(struct fsnotify_mark_connector *conn)
 {
+	struct super_block *sb = fsnotify_connector_sb(conn);
 	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
 	bool is_watched = conn->flags & FSNOTIFY_CONN_FLAG_IS_WATCHED;
 	struct fsnotify_mark *first_mark = NULL;
@@ -358,8 +358,7 @@ static void *fsnotify_detach_connector_from_object(
 	/* We make detached connectors point to the superblock */
 	conn->obj = sb;
 	conn->type = FSNOTIFY_OBJ_TYPE_DETACHED;
-	if (sb)
-		fsnotify_update_sb_watchers(sb, conn);
+	fsnotify_update_sb_watchers(conn);
 
 	return inode;
 }
@@ -411,11 +410,9 @@ void fsnotify_put_mark(struct fsnotify_mark *mark)
 		objp = fsnotify_detach_connector_from_object(conn, &type);
 		free_conn = true;
 	} else {
-		struct super_block *sb = fsnotify_connector_sb(conn);
-
 		/* Update watched objects after detaching mark */
 		if (conn->type != FSNOTIFY_OBJ_TYPE_DETACHED)
-			fsnotify_update_sb_watchers(sb, conn);
+			fsnotify_update_sb_watchers(conn);
 		objp = __fsnotify_recalc_mask(conn);
 		type = conn->type;
 	}
@@ -778,8 +775,7 @@ static int fsnotify_add_mark_list(struct fsnotify_mark *mark, void *obj,
 	/* mark should be the last entry.  last is the current last entry */
 	hlist_add_behind_rcu(&mark->obj_list, &last->obj_list);
 added:
-	if (sb)
-		fsnotify_update_sb_watchers(sb, conn);
+	fsnotify_update_sb_watchers(conn);
 	/*
 	 * Since connector is attached to object using cmpxchg() we are
 	 * guaranteed that connector initialization is fully visible by anyone
-- 
2.51.0



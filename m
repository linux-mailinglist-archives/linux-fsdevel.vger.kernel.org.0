Return-Path: <linux-fsdevel+bounces-70064-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E51C8FB49
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32D5F3AD6CC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1622ED866;
	Thu, 27 Nov 2025 17:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U36Erdkl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="55Xa4uLB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="U36Erdkl";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="55Xa4uLB"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA262E06E4
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264660; cv=none; b=mT8WWGb0X/JacXJUG1iRSbWTtnFA6t/mOLBtHZK5pkp8kCQxW4CTIJr4PJfU8wZsGgGXJQmxv6Wa0ivmNySiNZd7LlsD6r6mdsruvE/HXtLj7OY3zkCCPoVDI7fOKzAp5P2CcdEPsbhC2pQRd3hLObTrt7KagivA6VuSgVEKTGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264660; c=relaxed/simple;
	bh=s9SoelGEFqn5hogrpkdzIcPNqVuu8wmr1xpROv+e95s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMq7GLeNA/CHwO069QFVsXhKXcuAAsDyvSk7kg5BoAGld1CC7uwFgEhLhHlc19TcH5aCJ2Qlh6NH3DRKTnPShBzkCSuqYd+7bekhjygGx8ba84Md6yuVtlp+g/+jdlSqRWz4Fuf96G5Ufyu2pl/4/fZPt+AcXcLUXAYc3rqgP5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U36Erdkl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=55Xa4uLB; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=U36Erdkl; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=55Xa4uLB; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3794333693;
	Thu, 27 Nov 2025 17:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o179GjtsOHbFGA9HsyiKesSlZLrVsnTeh5tmEuTRjzs=;
	b=U36ErdklgyGR1hAHtnlH5Vz0cO1Cz5Gz1KVmiuDqsahY9UY2RROkQdQIMnUiIJAX/IHm8H
	fU8JAgDBK0QBxknhIGS3m4GQfei6H+DzuMzMapE5tSCA46s0uPZiyR1dcux3Q5L7xQCWRX
	nIml/Ep4qq+bHwaW14YCfnPhYunYJS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o179GjtsOHbFGA9HsyiKesSlZLrVsnTeh5tmEuTRjzs=;
	b=55Xa4uLBJ8wt7aqF00gtLqmlDaxNuhUBMhpVi6iXUW8Q2R/5Q5O7ctYw1Wo+oHyFwCWHj4
	kqWIVc6L/9PLeYCA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=U36Erdkl;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=55Xa4uLB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o179GjtsOHbFGA9HsyiKesSlZLrVsnTeh5tmEuTRjzs=;
	b=U36ErdklgyGR1hAHtnlH5Vz0cO1Cz5Gz1KVmiuDqsahY9UY2RROkQdQIMnUiIJAX/IHm8H
	fU8JAgDBK0QBxknhIGS3m4GQfei6H+DzuMzMapE5tSCA46s0uPZiyR1dcux3Q5L7xQCWRX
	nIml/Ep4qq+bHwaW14YCfnPhYunYJS8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o179GjtsOHbFGA9HsyiKesSlZLrVsnTeh5tmEuTRjzs=;
	b=55Xa4uLBJ8wt7aqF00gtLqmlDaxNuhUBMhpVi6iXUW8Q2R/5Q5O7ctYw1Wo+oHyFwCWHj4
	kqWIVc6L/9PLeYCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64DBD3EA63;
	Thu, 27 Nov 2025 17:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uUKaGLKKKGmJPgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 28043A0CA4; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 05/13] fsnotify: Remove fsnotify_sb_watched_objects()
Date: Thu, 27 Nov 2025 18:30:12 +0100
Message-ID: <20251127173012.23500-18-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3427; i=jack@suse.cz; h=from:subject; bh=s9SoelGEFqn5hogrpkdzIcPNqVuu8wmr1xpROv+e95s=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqnM/pyXGh6OhbWB1QxdhMkuiOa5gTZgtbDg 32cLjWTP8SJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKpwAKCRCcnaoHP2RA 2YE2CADNARrOshonPCBEwVB6h8t+7FUfYt6vs3gx4DlLsV6wwLW/aTLpu12TuRClRtg2zQMIfSz 5pv5/XlMEnIWho2zm964s63QsdZPrVsg4nKAz4Ii368AJ8HGSQ+YXhl52DpHVRujMgsfgI/aj2d ZeL8mRUpZzOMQ8tTxRCPRKcoRP6mKwZQSKeC5LnHGZNS0r8DZ8EgIgLh9Wn7mOXTBRhwcwyMle/ qLenG2j/+mNEi0BsZHeisWKlE30oIMnjBx/Racn6hUXO4WRW2p0Qc2n869ZSwdk7P0/zNkc900g k/tCu3eRuwfwjdp5lNVrKBl7vLGp0TQeqHzG4pRnnDa9kFFc
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
X-Rspamd-Queue-Id: 3794333693
X-Rspamd-Action: no action
X-Spam-Flag: NO

Remove fsnotify_sb_watched_objects() helper since it's now used only in
fsnotify_get_sb_watched_objects() and fsnotify_put_sb_watched_objects().
Also make those two functions take sbinfo as that will be more common in
the future.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/mark.c                 | 20 ++++++++++----------
 include/linux/fsnotify_backend.h |  5 -----
 2 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index 3df230e218fb..f6a197c63c1d 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -138,20 +138,20 @@ __u32 fsnotify_conn_mask(struct fsnotify_mark_connector *conn)
 	return READ_ONCE(*fsnotify_conn_mask_p(conn));
 }
 
-static void fsnotify_get_sb_watched_objects(struct super_block *sb)
+static void fsnotify_get_sb_watched_objects(struct fsnotify_sb_info *sbinfo)
 {
-	atomic_long_inc(fsnotify_sb_watched_objects(sb));
+	atomic_long_inc(&sbinfo->watched_objects[0]);
 }
 
-static void fsnotify_put_sb_watched_objects(struct super_block *sb)
+static void fsnotify_put_sb_watched_objects(struct fsnotify_sb_info *sbinfo)
 {
-	atomic_long_dec(fsnotify_sb_watched_objects(sb));
+	atomic_long_dec(&sbinfo->watched_objects[0]);
 }
 
 static void fsnotify_get_inode_ref(struct inode *inode)
 {
 	ihold(inode);
-	fsnotify_get_sb_watched_objects(inode->i_sb);
+	fsnotify_get_sb_watched_objects(fsnotify_sb_info(inode->i_sb));
 }
 
 static void fsnotify_put_inode_ref(struct inode *inode)
@@ -160,7 +160,7 @@ static void fsnotify_put_inode_ref(struct inode *inode)
 	struct super_block *sb = inode->i_sb;
 
 	iput(inode);
-	fsnotify_put_sb_watched_objects(sb);
+	fsnotify_put_sb_watched_objects(fsnotify_sb_info(sb));
 }
 
 /*
@@ -169,8 +169,8 @@ static void fsnotify_put_inode_ref(struct inode *inode)
  */
 static void fsnotify_update_sb_watchers(struct fsnotify_mark_connector *conn)
 {
-	struct super_block *sb = fsnotify_connector_sb(conn);
-	struct fsnotify_sb_info *sbinfo = fsnotify_sb_info(sb);
+	struct fsnotify_sb_info *sbinfo =
+				fsnotify_sb_info(fsnotify_connector_sb(conn));
 	bool is_watched = conn->flags & FSNOTIFY_CONN_FLAG_IS_WATCHED;
 	struct fsnotify_mark *first_mark = NULL;
 	unsigned int highest_prio = 0;
@@ -198,10 +198,10 @@ static void fsnotify_update_sb_watchers(struct fsnotify_mark_connector *conn)
 	BUILD_BUG_ON(FSNOTIFY_PRIO_NORMAL != 0);
 	if (first_mark && !is_watched) {
 		conn->flags |= FSNOTIFY_CONN_FLAG_IS_WATCHED;
-		fsnotify_get_sb_watched_objects(sb);
+		fsnotify_get_sb_watched_objects(sbinfo);
 	} else if (!first_mark && is_watched) {
 		conn->flags &= ~FSNOTIFY_CONN_FLAG_IS_WATCHED;
-		fsnotify_put_sb_watched_objects(sb);
+		fsnotify_put_sb_watched_objects(sbinfo);
 	}
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 41d913c328fa..bf6796be7561 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -586,11 +586,6 @@ static inline struct fsnotify_sb_info *fsnotify_sb_info(struct super_block *sb)
 #endif
 }
 
-static inline atomic_long_t *fsnotify_sb_watched_objects(struct super_block *sb)
-{
-	return &fsnotify_sb_info(sb)->watched_objects[0];
-}
-
 /*
  * A mark is simply an object attached to an in core inode which allows an
  * fsnotify listener to indicate they are either no longer interested in events
-- 
2.51.0



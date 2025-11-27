Return-Path: <linux-fsdevel+bounces-70056-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DA068C8FB04
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 18:30:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5F8EE34CFCA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Nov 2025 17:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3DB02EFD95;
	Thu, 27 Nov 2025 17:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="KBVbYiJ2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="drnzUMVc";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="NHYK834J";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="PiUembpK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07849283121
	for <linux-fsdevel@vger.kernel.org>; Thu, 27 Nov 2025 17:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764264631; cv=none; b=mthJJU+oc6UJ8pZAqQbwI80mAZqVTzEpgtLdk5/JrJNk9HZfd38zlx13Eugx7DdcyPBljaUaR8toQT/WroC+/GTAJwnT8Ul9JPMIxCaVWIeyBY+t0gYrlLGBrKtjk6WthI5PQHF+QfyPg2bUZ+CZc7fb/to0UiDwBPzpEQ5hphI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764264631; c=relaxed/simple;
	bh=bgIILPgVAestttUbUmypbG0KjQlba6nEdfzIYm4dppQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BcEWzK1uXyZxqEh2HwCUAQ1RRA5hpdRH5yuWADrFlJ+MwU9u3V6dQYo5SLl0zRLZGucmT3fa65K4/v4gny35+7UHld3wSWQo+N6PGcOywfDjhh3R9KwRJKF/RnvfCEo/cThoOGxpldH/uxqtDNHpCUSxyxyXB459eo/2jp7n04k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=KBVbYiJ2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=drnzUMVc; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=NHYK834J; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=PiUembpK; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E2F0821909;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lqeh9sZ248zZPlJtg0E5mkSBaN/AThyZDBq1+0n9LvQ=;
	b=KBVbYiJ2zDWpChlTd7i2b6hChqtRZFg/ZKzsdUUpRPAJQfawD1ieoHL1QrrldHGi2h5giq
	8+jtvQwMpt93Ri+JuaeUcTCO86Wk3iTTJ7dZtkrIQGDTnllk72irPeXma1T4w2Lcyyf7kd
	OHEWJAH/2Kn6dIKjNzKgYZIeAdhsniU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lqeh9sZ248zZPlJtg0E5mkSBaN/AThyZDBq1+0n9LvQ=;
	b=drnzUMVcgzQqNRrP52QP96niTLylKpbUEaQ9ZD+Lemojg3NbR6zdFCo/aXdgQZKIJCBNj9
	t9lsjJQu3/B0FZBQ==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=NHYK834J;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=PiUembpK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1764264625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lqeh9sZ248zZPlJtg0E5mkSBaN/AThyZDBq1+0n9LvQ=;
	b=NHYK834JqrhY7mfLMZXYenTyRNHJSX9WWRRktDJUlSGMarzOsjcVILlftiZ62j9ogv1D2s
	Umw3FIru3sGZFPtAXg/WOPXdGJlbk8WPNwxPbP7Lx2PO4pm6bIROBmJX5GrKHdEww32iHG
	GcPwoWoq+wB7UA9xz8ABFIwmvDhV9R0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1764264625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lqeh9sZ248zZPlJtg0E5mkSBaN/AThyZDBq1+0n9LvQ=;
	b=PiUembpKY6kbhsLcl2HJonpeqvYhpaM5rjIXLblfHeaUz03iZ0yg8JQ9rKxP7wnJH2ijzS
	iwtGpesrHS/ys7Ag==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD6733EA68;
	Thu, 27 Nov 2025 17:30:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DY4jMrGKKGl/PgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 27 Nov 2025 17:30:25 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1F479A0CA3; Thu, 27 Nov 2025 18:30:25 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 04/13] fsnotify: Track number of connectors for superblock separately
Date: Thu, 27 Nov 2025 18:30:11 +0100
Message-ID: <20251127173012.23500-17-jack@suse.cz>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251127170509.30139-1-jack@suse.cz>
References: <20251127170509.30139-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3402; i=jack@suse.cz; h=from:subject; bh=bgIILPgVAestttUbUmypbG0KjQlba6nEdfzIYm4dppQ=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBpKIqmzlkInqatD4d4BH8ewSTes1P3idYnlNBbc dyuHH9MPL2JATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCaSiKpgAKCRCcnaoHP2RA 2RzRB/9+VdQ1bvpUfLWJy845DqlOkPVzUZ9DthYlNMX2bzIIFJig93ARJJY02juP0k/9vDI4Vpj QRYgPt8e+uZoY4Y966AErMktEw4BvD7QV3RWhcAud5veHOOfoH9B5raBUwyfddWBuAzrJSOMCq9 mZIfEvGB9NktFACbpzmgBgd1d7S1zOyEL4VDB6MH0m9TpwMY2OMiF8RiE4miD2HOzxh3xi6/jt+ LRZzCX4SwKWKy1AJKcpVVhxd1ih7Ehsz5pqhrhsp+ndMu5HHSN6fUJ1HHN7Fzej4pPQrAhNEhxH ySScnGnLNNA1tUNae6hgJTlT1ei1Nen58UKskCL7abGRpbJh
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:mid,suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
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
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -3.01
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E2F0821909

Currently number of watched objects is equal to the number of existing
connectors. However in the future when connectors will no longer pin
inodes these counts can differ. Introduce a separate counter of the
number of existing connectors and use it what waiting for all marks and
connectors to be freed.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/notify/fsnotify.c             |  5 +++--
 fs/notify/mark.c                 | 13 ++++++++-----
 include/linux/fsnotify_backend.h |  2 ++
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index 46db712c83ec..f7f1d9ff3e38 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -103,8 +103,9 @@ void fsnotify_sb_delete(struct super_block *sb)
 	fsnotify_unmount_inodes(sb);
 	fsnotify_clear_marks_by_sb(sb);
 	/* Wait for outstanding object references from connectors */
-	wait_var_event(fsnotify_sb_watched_objects(sb),
-		       !atomic_long_read(fsnotify_sb_watched_objects(sb)));
+	wait_var_event(&sbinfo->connector_count,
+		       !atomic_long_read(&sbinfo->connector_count));
+	WARN_ON(fsnotify_sb_has_watchers(sb));
 	WARN_ON(fsnotify_sb_has_priority_watchers(sb, FSNOTIFY_PRIO_CONTENT));
 	WARN_ON(fsnotify_sb_has_priority_watchers(sb,
 						  FSNOTIFY_PRIO_PRE_CONTENT));
diff --git a/fs/notify/mark.c b/fs/notify/mark.c
index fd1fe8d37c36..3df230e218fb 100644
--- a/fs/notify/mark.c
+++ b/fs/notify/mark.c
@@ -145,11 +145,7 @@ static void fsnotify_get_sb_watched_objects(struct super_block *sb)
 
 static void fsnotify_put_sb_watched_objects(struct super_block *sb)
 {
-	atomic_long_t *watched_objects = fsnotify_sb_watched_objects(sb);
-
-	/* the superblock can go away after this decrement */
-	if (atomic_long_dec_and_test(watched_objects))
-		wake_up_var(watched_objects);
+	atomic_long_dec(fsnotify_sb_watched_objects(sb));
 }
 
 static void fsnotify_get_inode_ref(struct inode *inode)
@@ -390,6 +386,11 @@ static void fsnotify_drop_object(unsigned int type, void *objp)
 
 static void fsnotify_free_connector(struct fsnotify_mark_connector *conn)
 {
+	struct fsnotify_sb_info *sbinfo =
+				fsnotify_sb_info(fsnotify_connector_sb(conn));
+
+	if (atomic_long_dec_and_test(&sbinfo->connector_count))
+		wake_up_var(&sbinfo->connector_count);
 	spin_lock(&destroy_lock);
 	conn->destroy_next = connector_destroy_list;
 	connector_destroy_list = conn;
@@ -798,6 +799,8 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
 	if (!conn)
 		return -ENOMEM;
 
+	atomic_long_inc(
+		&fsnotify_sb_info(fsnotify_connector_sb(conn))->connector_count);
 	/*
 	 * cmpxchg() provides the barrier so that readers of *connp can see
 	 * only initialized structure
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 0a163c10b5e2..41d913c328fa 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -564,6 +564,8 @@ struct fsnotify_sb_info {
 	struct fsnotify_mark_connector __rcu *sb_marks;
 	/* Hash of connectors for inode marks */
 	struct rhashtable inode_conn_hash;
+	/* Number of connectors to objects in the superblock */
+	atomic_long_t connector_count;
 	/*
 	 * Number of inode/mount/sb objects that are being watched in this sb.
 	 * Note that inodes objects are currently double-accounted.
-- 
2.51.0



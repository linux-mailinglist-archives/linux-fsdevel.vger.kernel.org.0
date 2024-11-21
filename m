Return-Path: <linux-fsdevel+bounces-35423-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B639D4BB4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:25:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7FDFEB2720F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99821DD873;
	Thu, 21 Nov 2024 11:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCmHv8r3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Dtmztll";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eCmHv8r3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Dtmztll"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028911D90B6;
	Thu, 21 Nov 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188152; cv=none; b=LuXNTKA7yDSWTgfKYM3C4obcEtw5CBkrGvMoq2fDdd/7Bb0yr5xteKRHa0ThToGKhG2EfyNfT4Nq/8aJpcD8Lva0qwpFhelO3hlJuktqu8dLeSuOCxzbe5YziFgZotNOXl3/E3J8Hr/AKIbq7/RAI3IZod24OHBM15OjRSYbPBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188152; c=relaxed/simple;
	bh=WrlrfEwFTlVDKaT2qm3b94Gnb5H2higEBRNssewKc54=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OHVnA/9yg8dL+3pzgnE8H8SiqX4InlXauQhfIh4pp6lsuUkdLDgc5oprUJeP915rEyorWVz7R77UP+o2g6rwKpS+tnID2HT/Bpw2lJ/SV7Wfn3l/PEpqJxRL/aMDGqjAR+ezVEQGORwvIO8sNRIanY+2yk8NQ+SFXGq/u0Ogk2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCmHv8r3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Dtmztll; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eCmHv8r3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Dtmztll; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 912B821A04;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YU9Pc9qcIxrQz85DFItqT96oWpVuHLXL0dks/6lN+sU=;
	b=eCmHv8r36Z3hf5P7d7ctjcMAvraq6gGBU2yS0zAOh5JeVWviix/FnS7Wr9WFY2TYwCdxtM
	tUcwmXlKrD1AR5hOaEJb4bKQ+Z3TO4DSgPMc+hzfXrgCamz0K0O77qt8cby/ouX4oe1d1D
	MoG3NY+7P0nG0MyFy5XLMcNh7pMV5Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YU9Pc9qcIxrQz85DFItqT96oWpVuHLXL0dks/6lN+sU=;
	b=5DtmztllraO7cb1oMFszD2Yf5e8ahNu0/GLCd23yaNiFmUocrwGP0KoyJfFDotZGfXCcgx
	PQAYYt29CxpW8bDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1732188144; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YU9Pc9qcIxrQz85DFItqT96oWpVuHLXL0dks/6lN+sU=;
	b=eCmHv8r36Z3hf5P7d7ctjcMAvraq6gGBU2yS0zAOh5JeVWviix/FnS7Wr9WFY2TYwCdxtM
	tUcwmXlKrD1AR5hOaEJb4bKQ+Z3TO4DSgPMc+hzfXrgCamz0K0O77qt8cby/ouX4oe1d1D
	MoG3NY+7P0nG0MyFy5XLMcNh7pMV5Pg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1732188144;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YU9Pc9qcIxrQz85DFItqT96oWpVuHLXL0dks/6lN+sU=;
	b=5DtmztllraO7cb1oMFszD2Yf5e8ahNu0/GLCd23yaNiFmUocrwGP0KoyJfFDotZGfXCcgx
	PQAYYt29CxpW8bDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8059B13AC3;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7G9VH/AXP2c6fwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A9B2A0924; Thu, 21 Nov 2024 12:22:24 +0100 (CET)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Josef Bacik <josef@toxicpanda.com>,
	brauner@kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Al Viro <viro@ZenIV.linux.org.uk>,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	linux-mm@kvack.org,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 10/19] fanotify: introduce FAN_PRE_ACCESS permission event
Date: Thu, 21 Nov 2024 12:22:09 +0100
Message-Id: <20241121112218.8249-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20241121112218.8249-1-jack@suse.cz>
References: <20241121112218.8249-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-6.80 / 50.00];
	REPLY(-4.00)[];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,toxicpanda.com,kernel.org,linux-foundation.org,ZenIV.linux.org.uk,vger.kernel.org,kvack.org,suse.cz];
	R_RATELIMIT(0.00)[to_ip_from(RLdu9otajk16idfrkma9mbkf9b)];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -6.80
X-Spam-Flag: NO

From: Amir Goldstein <amir73il@gmail.com>

Similar to FAN_ACCESS_PERM permission event, but it is only allowed with
class FAN_CLASS_PRE_CONTENT and only allowed on regular files and dirs.

Unlike FAN_ACCESS_PERM, it is safe to write to the file being accessed
in the context of the event handler.

This pre-content event is meant to be used by hierarchical storage
managers that want to fill the content of files on first read access.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/b80986f8d5b860acea2c9a73c0acd93587be5fe4.1731684329.git.josef@toxicpanda.com
---
 fs/notify/fanotify/fanotify.c      |  3 ++-
 fs/notify/fanotify/fanotify_user.c | 22 +++++++++++++++++++---
 include/linux/fanotify.h           | 14 ++++++++++----
 include/uapi/linux/fanotify.h      |  2 ++
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
index c1e4ae221093..5e05410ddb9f 100644
--- a/fs/notify/fanotify/fanotify.c
+++ b/fs/notify/fanotify/fanotify.c
@@ -917,8 +917,9 @@ static int fanotify_handle_event(struct fsnotify_group *group, u32 mask,
 	BUILD_BUG_ON(FAN_OPEN_EXEC_PERM != FS_OPEN_EXEC_PERM);
 	BUILD_BUG_ON(FAN_FS_ERROR != FS_ERROR);
 	BUILD_BUG_ON(FAN_RENAME != FS_RENAME);
+	BUILD_BUG_ON(FAN_PRE_ACCESS != FS_PRE_ACCESS);
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 21);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FANOTIFY_EVENT_BITS) != 22);
 
 	mask = fanotify_group_event_mask(group, iter_info, &match_mask,
 					 mask, data, data_type, dir);
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 8d8afa09560b..b4dfc8f0d037 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1646,11 +1646,23 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 				     unsigned int flags)
 {
 	unsigned int mark_type = flags & FANOTIFY_MARK_TYPE_BITS;
+	bool is_dir = d_is_dir(path->dentry);
 	/* Strict validation of events in non-dir inode mask with v5.17+ APIs */
 	bool strict_dir_events = FAN_GROUP_FLAG(group, FAN_REPORT_TARGET_FID) ||
 				 (mask & FAN_RENAME) ||
 				 (flags & FAN_MARK_IGNORE);
 
+	/*
+	 * Filesystems need to opt-into pre-content evnets (a.k.a HSM)
+	 * and they are only supported on regular files and directories.
+	 */
+	if (mask & FANOTIFY_PRE_CONTENT_EVENTS) {
+		if (!(path->mnt->mnt_sb->s_iflags & SB_I_ALLOW_HSM))
+			return -EOPNOTSUPP;
+		if (!is_dir && !d_is_reg(path->dentry))
+			return -EINVAL;
+	}
+
 	/*
 	 * Some filesystems such as 'proc' acquire unusual locks when opening
 	 * files. For them fanotify permission events have high chances of
@@ -1683,7 +1695,7 @@ static int fanotify_events_supported(struct fsnotify_group *group,
 	 * but because we always allowed it, error only when using new APIs.
 	 */
 	if (strict_dir_events && mark_type == FAN_MARK_INODE &&
-	    !d_is_dir(path->dentry) && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
+	    !is_dir && (mask & FANOTIFY_DIRONLY_EVENT_BITS))
 		return -ENOTDIR;
 
 	return 0;
@@ -1787,11 +1799,15 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 		goto fput_and_out;
 
 	/*
-	 * Permission events require minimum priority FAN_CLASS_CONTENT.
+	 * Permission events are not allowed for FAN_CLASS_NOTIF.
+	 * Pre-content permission events are not allowed for FAN_CLASS_CONTENT.
 	 */
 	ret = -EINVAL;
 	if (mask & FANOTIFY_PERM_EVENTS &&
-	    group->priority < FSNOTIFY_PRIO_CONTENT)
+	    group->priority == FSNOTIFY_PRIO_NORMAL)
+		goto fput_and_out;
+	else if (mask & FANOTIFY_PRE_CONTENT_EVENTS &&
+		 group->priority == FSNOTIFY_PRIO_CONTENT)
 		goto fput_and_out;
 
 	if (mask & FAN_FS_ERROR &&
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 89ff45bd6f01..c747af064d2c 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -89,6 +89,16 @@
 #define FANOTIFY_DIRENT_EVENTS	(FAN_MOVE | FAN_CREATE | FAN_DELETE | \
 				 FAN_RENAME)
 
+/* Content events can be used to inspect file content */
+#define FANOTIFY_CONTENT_PERM_EVENTS (FAN_OPEN_PERM | FAN_OPEN_EXEC_PERM | \
+				      FAN_ACCESS_PERM)
+/* Pre-content events can be used to fill file content */
+#define FANOTIFY_PRE_CONTENT_EVENTS  (FAN_PRE_ACCESS)
+
+/* Events that require a permission response from user */
+#define FANOTIFY_PERM_EVENTS	(FANOTIFY_CONTENT_PERM_EVENTS | \
+				 FANOTIFY_PRE_CONTENT_EVENTS)
+
 /* Events that can be reported with event->fd */
 #define FANOTIFY_FD_EVENTS (FANOTIFY_PATH_EVENTS | FANOTIFY_PERM_EVENTS)
 
@@ -104,10 +114,6 @@
 				 FANOTIFY_INODE_EVENTS | \
 				 FANOTIFY_ERROR_EVENTS)
 
-/* Events that require a permission response from user */
-#define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
-				 FAN_OPEN_EXEC_PERM)
-
 /* Extra flags that may be reported with event or control handling of events */
 #define FANOTIFY_EVENT_FLAGS	(FAN_EVENT_ON_CHILD | FAN_ONDIR)
 
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 79072b6894f2..7596168c80eb 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -27,6 +27,8 @@
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
 /* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
+#define FAN_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
 #define FAN_RENAME		0x10000000	/* File was renamed */
-- 
2.35.3



Return-Path: <linux-fsdevel+bounces-41008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE476A2A04D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 06:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C185A3A7386
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 05:46:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD80224AE6;
	Thu,  6 Feb 2025 05:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HbocadT5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GaTpRqk0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="HbocadT5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GaTpRqk0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D149B1B59A;
	Thu,  6 Feb 2025 05:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738820787; cv=none; b=obb1TRU7689JuDtkafssLj7Y1SeX23gLwTWnYRrq1QVwaZ+C2/Pkefef/aV+Iv9AksBNeM4AIjaVxL2WLBtMiN9dBXu/AQyM6gfOyZmkH6BqT2bClpztHN3XdK9DHXeFI6lyykYMjST3RagG9HEeO81IQyzkUv+m5+OURe2ONpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738820787; c=relaxed/simple;
	bh=nJ7z+us0xIxt19NxCkCDEqwPLCjGDndPBQTINnvaDiw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gl0a6UAIbjRMBc7QJRYnHvwejOZNax+LWklzNtwTks7ovdlApaJfnJja93RZVazh83zN8+yVbBIMjXjvvQxS0ALH5wMDVT2rMKSfhjJb8ZzPKjAWOdNgyh7Wlxrvs1qYTwd80n7IacrQfeUnkZ9viXNa8IZGpP3nzODRQESQmnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HbocadT5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GaTpRqk0; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=HbocadT5; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=GaTpRqk0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F353C1F444;
	Thu,  6 Feb 2025 05:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGtxcoxKGyQ37PxwNBvOA1aDF1KBl62XRF8HS/uFC+E=;
	b=HbocadT5k2HyJJZzgv133nHwa6ZVBHvXVpFJh4Aan9fs6VAEHWF6tHLhWqcWrZW6JetDHt
	hGu9PBzSCFN1p8mnmY6n2qzWrcj5jEs8HvsbpQUtQFsbRVZy0XGz3WhCyS4tTHZLZu3YoI
	j29A20/KemsJgqL7+XlgT3FXxR28yLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGtxcoxKGyQ37PxwNBvOA1aDF1KBl62XRF8HS/uFC+E=;
	b=GaTpRqk0UnTWiK6kwDfH8e7ccxnJmcliX/CdyCgC51EK41fLfTSqhsHYl8wpDb79VF3X57
	/ilkZonxQWtlJGAw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=HbocadT5;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GaTpRqk0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1738820784; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGtxcoxKGyQ37PxwNBvOA1aDF1KBl62XRF8HS/uFC+E=;
	b=HbocadT5k2HyJJZzgv133nHwa6ZVBHvXVpFJh4Aan9fs6VAEHWF6tHLhWqcWrZW6JetDHt
	hGu9PBzSCFN1p8mnmY6n2qzWrcj5jEs8HvsbpQUtQFsbRVZy0XGz3WhCyS4tTHZLZu3YoI
	j29A20/KemsJgqL7+XlgT3FXxR28yLw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1738820784;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vGtxcoxKGyQ37PxwNBvOA1aDF1KBl62XRF8HS/uFC+E=;
	b=GaTpRqk0UnTWiK6kwDfH8e7ccxnJmcliX/CdyCgC51EK41fLfTSqhsHYl8wpDb79VF3X57
	/ilkZonxQWtlJGAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F39413795;
	Thu,  6 Feb 2025 05:46:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id rzwYOaxMpGeABwAAD6G6ig
	(envelope-from <neilb@suse.de>); Thu, 06 Feb 2025 05:46:20 +0000
From: NeilBrown <neilb@suse.de>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff Layton <jlayton@kernel.org>,
	Dave Chinner <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/19] VFS: repack DENTRY_ flags.
Date: Thu,  6 Feb 2025 16:42:43 +1100
Message-ID: <20250206054504.2950516-7-neilb@suse.de>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250206054504.2950516-1-neilb@suse.de>
References: <20250206054504.2950516-1-neilb@suse.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F353C1F444
X-Spam-Level: 
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	RCVD_TLS_ALL(0.00)[];
	R_RATELIMIT(0.00)[from(RLewrxuus8mos16izbn)];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01
X-Spam-Flag: NO

Bits 13, 23, 24, and 27 are not used.  Move all those holes to the end.

Signed-off-by: NeilBrown <neilb@suse.de>
---
 include/linux/dcache.h | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/include/linux/dcache.h b/include/linux/dcache.h
index b03cbb0177a3..d5816cf19538 100644
--- a/include/linux/dcache.h
+++ b/include/linux/dcache.h
@@ -203,34 +203,34 @@ struct dentry_operations {
 #define DCACHE_NFSFS_RENAMED		BIT(12)
      /* this dentry has been "silly renamed" and has to be deleted on the last
       * dput() */
-#define DCACHE_FSNOTIFY_PARENT_WATCHED	BIT(14)
+#define DCACHE_FSNOTIFY_PARENT_WATCHED	BIT(13)
      /* Parent inode is watched by some fsnotify listener */
 
-#define DCACHE_DENTRY_KILLED		BIT(15)
+#define DCACHE_DENTRY_KILLED		BIT(14)
 
-#define DCACHE_MOUNTED			BIT(16) /* is a mountpoint */
-#define DCACHE_NEED_AUTOMOUNT		BIT(17) /* handle automount on this dir */
-#define DCACHE_MANAGE_TRANSIT		BIT(18) /* manage transit from this dirent */
+#define DCACHE_MOUNTED			BIT(15) /* is a mountpoint */
+#define DCACHE_NEED_AUTOMOUNT		BIT(16) /* handle automount on this dir */
+#define DCACHE_MANAGE_TRANSIT		BIT(17) /* manage transit from this dirent */
 #define DCACHE_MANAGED_DENTRY \
 	(DCACHE_MOUNTED|DCACHE_NEED_AUTOMOUNT|DCACHE_MANAGE_TRANSIT)
 
-#define DCACHE_LRU_LIST			BIT(19)
+#define DCACHE_LRU_LIST			BIT(18)
 
-#define DCACHE_ENTRY_TYPE		(7 << 20) /* bits 20..22 are for storing type: */
-#define DCACHE_MISS_TYPE		(0 << 20) /* Negative dentry */
-#define DCACHE_WHITEOUT_TYPE		(1 << 20) /* Whiteout dentry (stop pathwalk) */
-#define DCACHE_DIRECTORY_TYPE		(2 << 20) /* Normal directory */
-#define DCACHE_AUTODIR_TYPE		(3 << 20) /* Lookupless directory (presumed automount) */
-#define DCACHE_REGULAR_TYPE		(4 << 20) /* Regular file type */
-#define DCACHE_SPECIAL_TYPE		(5 << 20) /* Other file type */
-#define DCACHE_SYMLINK_TYPE		(6 << 20) /* Symlink */
+#define DCACHE_ENTRY_TYPE		(7 << 19) /* bits 19..21 are for storing type: */
+#define DCACHE_MISS_TYPE		(0 << 19) /* Negative dentry */
+#define DCACHE_WHITEOUT_TYPE		(1 << 19) /* Whiteout dentry (stop pathwalk) */
+#define DCACHE_DIRECTORY_TYPE		(2 << 19) /* Normal directory */
+#define DCACHE_AUTODIR_TYPE		(3 << 19) /* Lookupless directory (presumed automount) */
+#define DCACHE_REGULAR_TYPE		(4 << 19) /* Regular file type */
+#define DCACHE_SPECIAL_TYPE		(5 << 19) /* Other file type */
+#define DCACHE_SYMLINK_TYPE		(6 << 19) /* Symlink */
 
-#define DCACHE_NOKEY_NAME		BIT(25) /* Encrypted name encoded without key */
-#define DCACHE_OP_REAL			BIT(26)
+#define DCACHE_NOKEY_NAME		BIT(22) /* Encrypted name encoded without key */
+#define DCACHE_OP_REAL			BIT(23)
 
-#define DCACHE_PAR_LOOKUP		BIT(28) /* being looked up (with parent locked shared) */
-#define DCACHE_DENTRY_CURSOR		BIT(29)
-#define DCACHE_NORCU			BIT(30) /* No RCU delay for freeing */
+#define DCACHE_PAR_LOOKUP		BIT(24) /* being looked up (with parent locked shared) */
+#define DCACHE_DENTRY_CURSOR		BIT(25)
+#define DCACHE_NORCU			BIT(26) /* No RCU delay for freeing */
 
 extern seqlock_t rename_lock;
 
-- 
2.47.1



Return-Path: <linux-fsdevel+bounces-35413-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 903609D4B89
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 202811F2121C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B21281D358D;
	Thu, 21 Nov 2024 11:22:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD61D0F4D;
	Thu, 21 Nov 2024 11:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188148; cv=none; b=SSxBpANyCeDtP0plXjU9GfxtO4c8YOEj65rX96z1pwp+pVGHqVAv9fv5pv2dyMEG2DdvYkERI/KLeg7rpPPgSMHNiKHCzZ0RfLX7PbCj1KrE0CILbN5+vZWJIyHRdE66XAiCeIvxru1aPWsjKBkGwWKi2698H9yevLj94CoOIhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188148; c=relaxed/simple;
	bh=nx6hkt7Z8hJWhC5uM7Uyy/WMuVLmL8LG7o9QkV0cVLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JAY049WvxIevYadiOwhGR4Dq7tcAa692H2aUuUB+61q+qwsNmkxmF7Gx4hgnVDDEk1tl6WBSXKKKlvHixyjMpm/bz3IPDr07DrfKZSEf4+gXnGJ/IevyVUZkzs0mpT0gXi0pAl/lb1SRUUgTHT0wXOpGrVrGfJprDGMgLLrm8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 7AEBB21A01;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6A86313ACE;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ceABGvAXP2cvfwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 00B4DA0907; Thu, 21 Nov 2024 12:22:23 +0100 (CET)
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
Subject: [PATCH 07/19] fsnotify: introduce pre-content permission events
Date: Thu, 21 Nov 2024 12:22:06 +0100
Message-Id: <20241121112218.8249-8-jack@suse.cz>
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
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Spam-Level: 
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[];
	ASN(0.00)[asn:25478, ipnet:::/0, country:RU]
X-Spam-Score: -4.00
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 7AEBB21A01
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

From: Amir Goldstein <amir73il@gmail.com>

The new FS_PRE_ACCESS permission event is similar to FS_ACCESS_PERM,
but it meant for a different use case of filling file content before
access to a file range, so it has slightly different semantics.

Generate FS_PRE_ACCESS/FS_ACCESS_PERM as two seperate events, so content
scanners could inspect the content filled by pre-content event handler.

Unlike FS_ACCESS_PERM, FS_PRE_ACCESS is also called before a file is
modified by syscalls as write() and fallocate().

FS_ACCESS_PERM is reported also on blockdev and pipes, but the new
pre-content events are only reported for regular files and dirs.

The pre-content events are meant to be used by hierarchical storage
managers that want to fill the content of files on first access.

There are some specific requirements from filesystems that could
be used with pre-content events, so add a flag for fs to opt-in
for pre-content events explicitly before they can be used.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/b934c5e3af205abc4e0e4709f6486815937ddfdf.1731684329.git.josef@toxicpanda.com
---
 fs/notify/fsnotify.c             |  2 +-
 include/linux/fs.h               |  1 +
 include/linux/fsnotify.h         | 19 ++++++++++++++++++-
 include/linux/fsnotify_backend.h | 11 ++++++++---
 security/selinux/hooks.c         |  3 ++-
 5 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/fs/notify/fsnotify.c b/fs/notify/fsnotify.c
index dd1dffd89fd6..d61f6bc679f1 100644
--- a/fs/notify/fsnotify.c
+++ b/fs/notify/fsnotify.c
@@ -688,7 +688,7 @@ static __init int fsnotify_init(void)
 {
 	int ret;
 
-	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 23);
+	BUILD_BUG_ON(HWEIGHT32(ALL_FSNOTIFY_BITS) != 24);
 
 	ret = init_srcu_struct(&fsnotify_mark_srcu);
 	if (ret)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6a170c2c5326..d9bccec6cc4d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1257,6 +1257,7 @@ extern int send_sigurg(struct file *file);
 #define SB_I_RETIRED	0x00000800	/* superblock shouldn't be reused */
 #define SB_I_NOUMASK	0x00001000	/* VFS does not apply umask */
 #define SB_I_NOIDMAP	0x00002000	/* No idmapped mounts on this superblock */
+#define SB_I_ALLOW_HSM	0x00004000	/* Allow HSM events on this superblock */
 
 /* Possible states of 'frozen' field */
 enum {
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 8d1849137a96..d91aa064f0e4 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -144,12 +144,29 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	 */
 	lockdep_assert_once(file_write_not_started(file));
 
-	if (!(perm_mask & MAY_READ))
+	if (!(perm_mask & (MAY_READ | MAY_WRITE | MAY_ACCESS)))
 		return 0;
 
 	if (likely(!FMODE_FSNOTIFY_PERM(file->f_mode)))
 		return 0;
 
+	/*
+	 * read()/write() and other types of access generate pre-content events.
+	 */
+	if (unlikely(FMODE_FSNOTIFY_HSM(file->f_mode))) {
+		int ret = fsnotify_path(&file->f_path, FS_PRE_ACCESS);
+
+		if (ret)
+			return ret;
+	}
+
+	if (!(perm_mask & MAY_READ))
+		return 0;
+
+	/*
+	 * read() also generates the legacy FS_ACCESS_PERM event, so content
+	 * scanners can inspect the content filled by pre-content event.
+	 */
 	return fsnotify_path(&file->f_path, FS_ACCESS_PERM);
 }
 
diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index c38762b62bf1..9bda354b5538 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -57,6 +57,8 @@
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
 /* #define FS_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
+#define FS_PRE_ACCESS		0x00100000	/* Pre-content access hook */
+
 /*
  * Set on inode mark that cares about things that happen to its children.
  * Always set for dnotify and inotify.
@@ -78,11 +80,14 @@
  */
 #define ALL_FSNOTIFY_DIRENT_EVENTS (FS_CREATE | FS_DELETE | FS_MOVE | FS_RENAME)
 
+/* Content events can be used to inspect file content */
+#define FSNOTIFY_CONTENT_PERM_EVENTS (FS_OPEN_PERM | FS_OPEN_EXEC_PERM | \
+				      FS_ACCESS_PERM)
 /* Pre-content events can be used to fill file content */
-#define FSNOTIFY_PRE_CONTENT_EVENTS 0
+#define FSNOTIFY_PRE_CONTENT_EVENTS  (FS_PRE_ACCESS)
 
-#define ALL_FSNOTIFY_PERM_EVENTS (FS_OPEN_PERM | FS_ACCESS_PERM | \
-				  FS_OPEN_EXEC_PERM)
+#define ALL_FSNOTIFY_PERM_EVENTS (FSNOTIFY_CONTENT_PERM_EVENTS | \
+				  FSNOTIFY_PRE_CONTENT_EVENTS)
 
 /*
  * This is a list of all events that may get sent to a parent that is watching
diff --git a/security/selinux/hooks.c b/security/selinux/hooks.c
index fc926d3cac6e..c6f38705c715 100644
--- a/security/selinux/hooks.c
+++ b/security/selinux/hooks.c
@@ -3404,7 +3404,8 @@ static int selinux_path_notify(const struct path *path, u64 mask,
 		perm |= FILE__WATCH_WITH_PERM;
 
 	/* watches on read-like events need the file:watch_reads permission */
-	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_CLOSE_NOWRITE))
+	if (mask & (FS_ACCESS | FS_ACCESS_PERM | FS_PRE_ACCESS |
+		    FS_CLOSE_NOWRITE))
 		perm |= FILE__WATCH_READS;
 
 	return path_has_perm(current_cred(), path, perm);
-- 
2.35.3



Return-Path: <linux-fsdevel+bounces-35430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 707A29D4BD1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 12:26:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DC631F21AF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Nov 2024 11:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6311DE3D8;
	Thu, 21 Nov 2024 11:22:35 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A921CEAB8;
	Thu, 21 Nov 2024 11:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732188155; cv=none; b=ao+KcyBD0fhedRZ1mnXaV2oLx8B7jyzrtkSLr0uGev6EbRPTKvOL3d1MNjOYHZ+HEsuQor95/zNPnEj1kxU9dT4/Q4t8Q9hjJJh16VESIk0/AtfRvxm6ykw9UOe+GLe/m3TVJvvUoeYSnfecmhz/o/+jABdVJVgCpaAdzhEh1Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732188155; c=relaxed/simple;
	bh=Xs8cMnfQn5DHDLLZXJdyTRw1UU4GMDVu5gGLyj8R4eQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ti5L3Dk9IZYkWLLJ+tM7+sH9FjPYWb3LZsYzkGGMcfXdMWD5wfMGXzHi8MfasLlG5P6tu+kjaNC3eisArgucvMDwzIIN0mvzaEcjF8b3iiNiN+0JnebpfvRds4JW1BO1o5PrsK7xu2sU0eVUyJ+gGs0B78B++d7xsFfufkPqzo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 8DE2F1F7FE;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 825C113AC9;
	Thu, 21 Nov 2024 11:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id IL/SH/AXP2c8fwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 21 Nov 2024 11:22:24 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 126D1A0922; Thu, 21 Nov 2024 12:22:24 +0100 (CET)
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
Subject: [PATCH 09/19] fsnotify: generate pre-content permission event on truncate
Date: Thu, 21 Nov 2024 12:22:08 +0100
Message-Id: <20241121112218.8249-10-jack@suse.cz>
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
X-Rspamd-Queue-Id: 8DE2F1F7FE
X-Rspamd-Pre-Result: action=no action;
	module=replies;
	Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org

From: Amir Goldstein <amir73il@gmail.com>

Generate FS_PRE_ACCESS event before truncate, without sb_writers held.

Move the security hooks also before sb_start_write() to conform with
other security hooks (e.g. in write, fallocate).

The event will have a range info of the page surrounding the new size
to provide an opportunity to fill the conetnt at the end of file before
truncating to non-page aligned size.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/23af8201db6ac2efdea94f09ab067d81ba5de7a7.1731684329.git.josef@toxicpanda.com
---
 fs/open.c                | 31 +++++++++++++++++++++----------
 include/linux/fsnotify.h | 20 ++++++++++++++++++++
 2 files changed, 41 insertions(+), 10 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index 9b1fa59d52bf..f7bd176545f5 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -81,14 +81,18 @@ long vfs_truncate(const struct path *path, loff_t length)
 	if (!S_ISREG(inode->i_mode))
 		return -EINVAL;
 
-	error = mnt_want_write(path->mnt);
-	if (error)
-		goto out;
-
 	idmap = mnt_idmap(path->mnt);
 	error = inode_permission(idmap, inode, MAY_WRITE);
 	if (error)
-		goto mnt_drop_write_and_out;
+		return error;
+
+	error = fsnotify_truncate_perm(path, length);
+	if (error)
+		return error;
+
+	error = mnt_want_write(path->mnt);
+	if (error)
+		return error;
 
 	error = -EPERM;
 	if (IS_APPEND(inode))
@@ -114,7 +118,7 @@ long vfs_truncate(const struct path *path, loff_t length)
 	put_write_access(inode);
 mnt_drop_write_and_out:
 	mnt_drop_write(path->mnt);
-out:
+
 	return error;
 }
 EXPORT_SYMBOL_GPL(vfs_truncate);
@@ -175,11 +179,18 @@ long do_ftruncate(struct file *file, loff_t length, int small)
 	/* Check IS_APPEND on real upper inode */
 	if (IS_APPEND(file_inode(file)))
 		return -EPERM;
-	sb_start_write(inode->i_sb);
+
 	error = security_file_truncate(file);
-	if (!error)
-		error = do_truncate(file_mnt_idmap(file), dentry, length,
-				    ATTR_MTIME | ATTR_CTIME, file);
+	if (error)
+		return error;
+
+	error = fsnotify_truncate_perm(&file->f_path, length);
+	if (error)
+		return error;
+
+	sb_start_write(inode->i_sb);
+	error = do_truncate(file_mnt_idmap(file), dentry, length,
+			    ATTR_MTIME | ATTR_CTIME, file);
 	sb_end_write(inode->i_sb);
 
 	return error;
diff --git a/include/linux/fsnotify.h b/include/linux/fsnotify.h
index 87044acf8e79..1a9ef8f6784d 100644
--- a/include/linux/fsnotify.h
+++ b/include/linux/fsnotify.h
@@ -170,6 +170,21 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return fsnotify_path(&file->f_path, FS_ACCESS_PERM);
 }
 
+/*
+ * fsnotify_truncate_perm - permission hook before file truncate
+ */
+static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
+{
+	struct inode *inode = d_inode(path->dentry);
+
+	if (!(inode->i_sb->s_iflags & SB_I_ALLOW_HSM) ||
+	    !fsnotify_sb_has_priority_watchers(inode->i_sb,
+					       FSNOTIFY_PRIO_PRE_CONTENT))
+		return 0;
+
+	return fsnotify_pre_content(path, &length, 0);
+}
+
 /*
  * fsnotify_file_perm - permission hook before file access (unknown range)
  */
@@ -208,6 +223,11 @@ static inline int fsnotify_file_area_perm(struct file *file, int perm_mask,
 	return 0;
 }
 
+static inline int fsnotify_truncate_perm(const struct path *path, loff_t length)
+{
+	return 0;
+}
+
 static inline int fsnotify_file_perm(struct file *file, int perm_mask)
 {
 	return 0;
-- 
2.35.3



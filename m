Return-Path: <linux-fsdevel+bounces-53855-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25A79AF8464
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 01:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ED81D161F23
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jul 2025 23:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76FC2DCBF1;
	Thu,  3 Jul 2025 23:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pjpktw/l";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="Pjpktw/l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7633E2DCBF4
	for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jul 2025 23:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751586171; cv=none; b=aKVmKcDI1sIyhC6//xREmQVA+nB+L1GNQ639KLFIARYA2MegeDSGpiGdH0F/6dxV4qcWy4sj0Xr1LTU/Po9CAp3VpXFEjm0lJ5XTZ/1p1gmjk+4I/1CLqZm2PMhgMD+v3yII6J7bwHtkshwWzE5PUYlo4Qk2y7RtA+PjamvUhK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751586171; c=relaxed/simple;
	bh=iLYqMMQdkW/PgePrU75FJL5LCAAAwHJEz+iBs9v0sgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kLiUFc0he063MlFlRhaGIfHX9b3Gai++a10Mwg5nXB9YxAo+VeSroOeOpNGY22n4Zjr79VJCZc7w8OuUigJcLn0sjNB0qIEN7xVGgWnIWGNQq8WyDSLyBqAYIuV/6jonzoWwdAXDQKITobVNlYAGn43JkN2t58jiZEOGXFXJDeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pjpktw/l; dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b=Pjpktw/l; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 75C7821194;
	Thu,  3 Jul 2025 23:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2cTMOFVLSi4FOef+mXjpJX0bB1CSMTiFxQSLfegoq9s=;
	b=Pjpktw/lT+xJqkXdI3zl48reol5Jf6DcEcYjYwAv9txtDMmY6rWSk0+w0DF4hMADHjE/N4
	rhCyomWDKODbED9S3pPJglrGxhwXYAjFNepgmy3jlS6D1FlJEIOE80BVnzn0BbTvo5fbE1
	RClDc8lKj1Tq6SBQIi+yrKrvHzmaNlE=
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.com header.s=susede1 header.b="Pjpktw/l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
	t=1751586162; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2cTMOFVLSi4FOef+mXjpJX0bB1CSMTiFxQSLfegoq9s=;
	b=Pjpktw/lT+xJqkXdI3zl48reol5Jf6DcEcYjYwAv9txtDMmY6rWSk0+w0DF4hMADHjE/N4
	rhCyomWDKODbED9S3pPJglrGxhwXYAjFNepgmy3jlS6D1FlJEIOE80BVnzn0BbTvo5fbE1
	RClDc8lKj1Tq6SBQIi+yrKrvHzmaNlE=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BCC6013721;
	Thu,  3 Jul 2025 23:42:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id OBeHH28VZ2j7AQAAD6G6ig
	(envelope-from <wqu@suse.com>); Thu, 03 Jul 2025 23:42:39 +0000
From: Qu Wenruo <wqu@suse.com>
To: linux-btrfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	ntfs3@lists.linux.dev,
	linux-xfs@vger.kernel.org
Subject: [PATCH v3 1/6] fs: enhance and rename shutdown() callback to remove_bdev()
Date: Fri,  4 Jul 2025 09:12:14 +0930
Message-ID: <cbe06b06a2fe4c4e0c90fc86503efc06080e6bc8.1751577459.git.wqu@suse.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1751577459.git.wqu@suse.com>
References: <cover.1751577459.git.wqu@suse.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	RCPT_COUNT_SEVEN(0.00)[9];
	DKIM_SIGNED(0.00)[suse.com:s=susede1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,linux.dev:email,suse.com:mid,suse.com:dkim,suse.com:email];
	DKIM_TRACE(0.00)[suse.com:+]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 75C7821194
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

Currently all the filesystems implementing the
super_opearations::shutdown() call back can not afford losing a device.

Thus fs_bdev_mark_dead() will just call the shutdown() callback for the
involved filesystem.

But it will no longer be the case, with multi-device filesystems like
btrfs and bcachefs the filesystem can handle certain device loss without
shutting down the whole filesystem.

To allow those multi-device filesystems to be integrated to use
fs_holder_ops:

- Rename shutdown() call back to remove_bdev()
  To better describe when the call back is called.

- Add a new @bdev parameter to remove_bdev() callback
  To allow the fs to determine which device is missing, and do the
  proper handling when needed.

For the existing shutdown callback users, the change is minimal.

They only need to follow the rename and the new parameter list.
Since the behavior is still to shutdown the fs, they shouldn't change
their function names.

This has a good side effect that, a single line like
".remove_bdev = ext4_shutdown," will easily show the fs behavior and
indicate the fs will shutdown when a device went missing.

Btrfs is going to implement the callback soon, which will either
shutdown the fs or continue read-write operations.

Cc: linux-fsdevel@vger.kernel.org
Cc: linux-ext4@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: ntfs3@lists.linux.dev
Cc: linux-xfs@vger.kernel.org
Signed-off-by: Qu Wenruo <wqu@suse.com>
---
 fs/exfat/super.c   | 4 ++--
 fs/ext4/super.c    | 4 ++--
 fs/f2fs/super.c    | 4 ++--
 fs/ntfs3/super.c   | 6 +++---
 fs/super.c         | 4 ++--
 fs/xfs/xfs_super.c | 7 ++++---
 include/linux/fs.h | 7 ++++++-
 7 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7ed858937d45..a0e11166b194 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -172,7 +172,7 @@ int exfat_force_shutdown(struct super_block *sb, u32 flags)
 	return 0;
 }
 
-static void exfat_shutdown(struct super_block *sb)
+static void exfat_remove_bdev(struct super_block *sb, struct block_device *bdev)
 {
 	exfat_force_shutdown(sb, EXFAT_GOING_DOWN_NOSYNC);
 }
@@ -202,7 +202,7 @@ static const struct super_operations exfat_sops = {
 	.put_super	= exfat_put_super,
 	.statfs		= exfat_statfs,
 	.show_options	= exfat_show_options,
-	.shutdown	= exfat_shutdown,
+	.remove_bdev	= exfat_remove_bdev,
 };
 
 enum {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c7d39da7e733..d75b416401ae 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1456,7 +1456,7 @@ static void ext4_destroy_inode(struct inode *inode)
 			 EXT4_I(inode)->i_reserved_data_blocks);
 }
 
-static void ext4_shutdown(struct super_block *sb)
+static void ext4_remove_bdev(struct super_block *sb, struct block_device *bdev)
 {
        ext4_force_shutdown(sb, EXT4_GOING_FLAGS_NOLOGFLUSH);
 }
@@ -1620,7 +1620,7 @@ static const struct super_operations ext4_sops = {
 	.unfreeze_fs	= ext4_unfreeze,
 	.statfs		= ext4_statfs,
 	.show_options	= ext4_show_options,
-	.shutdown	= ext4_shutdown,
+	.remove_bdev	= ext4_remove_bdev,
 #ifdef CONFIG_QUOTA
 	.quota_read	= ext4_quota_read,
 	.quota_write	= ext4_quota_write,
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index bbf1dad6843f..8667af9f76e4 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2640,7 +2640,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 	return err;
 }
 
-static void f2fs_shutdown(struct super_block *sb)
+static void f2fs_remove_bdev(struct super_block *sb, struct block_device *bdev)
 {
 	f2fs_do_shutdown(F2FS_SB(sb), F2FS_GOING_DOWN_NOSYNC, false, false);
 }
@@ -3264,7 +3264,7 @@ static const struct super_operations f2fs_sops = {
 	.unfreeze_fs	= f2fs_unfreeze,
 	.statfs		= f2fs_statfs,
 	.remount_fs	= f2fs_remount,
-	.shutdown	= f2fs_shutdown,
+	.remove_bdev	= f2fs_remove_bdev,
 };
 
 #ifdef CONFIG_FS_ENCRYPTION
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index 920a1ab47b63..3e69dc805e3a 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -762,9 +762,9 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 }
 
 /*
- * ntfs_shutdown - super_operations::shutdown
+ * ntfs_remove_bdev - super_operations::remove_bdev
  */
-static void ntfs_shutdown(struct super_block *sb)
+static void ntfs_remove_bdev(struct super_block *sb, struct block_device *bdev)
 {
 	set_bit(NTFS_FLAGS_SHUTDOWN_BIT, &ntfs_sb(sb)->flags);
 }
@@ -821,7 +821,7 @@ static const struct super_operations ntfs_sops = {
 	.put_super = ntfs_put_super,
 	.statfs = ntfs_statfs,
 	.show_options = ntfs_show_options,
-	.shutdown = ntfs_shutdown,
+	.remove_bdev = ntfs_remove_bdev,
 	.sync_fs = ntfs_sync_fs,
 	.write_inode = ntfs3_write_inode,
 };
diff --git a/fs/super.c b/fs/super.c
index 80418ca8e215..c972efb38f6a 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1463,8 +1463,8 @@ static void fs_bdev_mark_dead(struct block_device *bdev, bool surprise)
 		sync_filesystem(sb);
 	shrink_dcache_sb(sb);
 	evict_inodes(sb);
-	if (sb->s_op->shutdown)
-		sb->s_op->shutdown(sb);
+	if (sb->s_op->remove_bdev)
+		sb->s_op->remove_bdev(sb, bdev);
 
 	super_unlock_shared(sb);
 }
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 0bc4b5489078..8e307b036133 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1276,8 +1276,9 @@ xfs_fs_free_cached_objects(
 }
 
 static void
-xfs_fs_shutdown(
-	struct super_block	*sb)
+xfs_fs_remove_bdev(
+	struct super_block	*sb,
+	struct block_device	*bdev)
 {
 	xfs_force_shutdown(XFS_M(sb), SHUTDOWN_DEVICE_REMOVED);
 }
@@ -1308,7 +1309,7 @@ static const struct super_operations xfs_super_operations = {
 	.show_options		= xfs_fs_show_options,
 	.nr_cached_objects	= xfs_fs_nr_cached_objects,
 	.free_cached_objects	= xfs_fs_free_cached_objects,
-	.shutdown		= xfs_fs_shutdown,
+	.remove_bdev		= xfs_fs_remove_bdev,
 	.show_stats		= xfs_fs_show_stats,
 };
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index b085f161ed22..b08af63d2d4f 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2367,7 +2367,12 @@ struct super_operations {
 				  struct shrink_control *);
 	long (*free_cached_objects)(struct super_block *,
 				    struct shrink_control *);
-	void (*shutdown)(struct super_block *sb);
+	/*
+	 * Called when block device @bdev belonging to @sb is removed.
+	 *
+	 * If the fs can't afford the device loss, it should be shutdown.
+	 */
+	void (*remove_bdev)(struct super_block *sb, struct block_device *bdev);
 };
 
 /*
-- 
2.50.0



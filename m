Return-Path: <linux-fsdevel+bounces-25346-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFF994AFC2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1ECF1C20F35
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DEFA144D1E;
	Wed,  7 Aug 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+8PUH2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tvKtDZqP";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="b+8PUH2v";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tvKtDZqP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362DC143C60
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055413; cv=none; b=HbQygmn2uGZlln80BtBuK0e6JQ4DleXQvm4Fl7hBMyeRmswezdefiVvwTvpvfiCa8TkjYfJWQi7xYh3dXnWIT1iEcdzozn3e+bQ1IEbx5GVLHrZXN5aZ+/qvE7k7YbVbaQP8/VnqKDI4bdtB0yaW0alVf0YAQY9PujKU5o6tJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055413; c=relaxed/simple;
	bh=Nh7+Gohd80CafAf6rSUlx70GGjPImuDki53aSiRfl7w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FWeSMHS+m1bIFVbBhY3BqLAEvmNpoJlIYjaAUMPAYq9CFMBo1xC2WbLsosRhN5rr77E4M+ngbUbG9tUoXl9nPJVhxpruifudV1oOBmCv0wt7eWFaZpWflDeJnHZFZWflbLeQraLmw2+9v6n7Rk7SiCWS12P71PzIdGHbg4jV2LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+8PUH2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tvKtDZqP; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=b+8PUH2v; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tvKtDZqP; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 94D6B21D18;
	Wed,  7 Aug 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Czxq/KORa09Eh7tdfV7rQVGIZDivar8+/WAku5tZaY=;
	b=b+8PUH2vsXvrL3UmEgblTCncsjDs8ARjWu4fnJ4/mAk3vrLdiJ7lOJU/hQ6RwEGlJOq6uc
	jH/Wq3m2uArdTcGTEfc/C4U0+o0prAEGrhuB1FLkBgHjxtg8GPuIZuno5Ub/3E12Jx0WJu
	VqkXMysIJw0e2WRmOktTaTHcHBAbsXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Czxq/KORa09Eh7tdfV7rQVGIZDivar8+/WAku5tZaY=;
	b=tvKtDZqPpVrQhk8iuI0TBxuPi5rFadAt5/1sHIlEUu9tWRrXa01G3Zb9kD+xJ1qs0ZZApX
	k0qEa05EztYyeJCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Czxq/KORa09Eh7tdfV7rQVGIZDivar8+/WAku5tZaY=;
	b=b+8PUH2vsXvrL3UmEgblTCncsjDs8ARjWu4fnJ4/mAk3vrLdiJ7lOJU/hQ6RwEGlJOq6uc
	jH/Wq3m2uArdTcGTEfc/C4U0+o0prAEGrhuB1FLkBgHjxtg8GPuIZuno5Ub/3E12Jx0WJu
	VqkXMysIJw0e2WRmOktTaTHcHBAbsXc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Czxq/KORa09Eh7tdfV7rQVGIZDivar8+/WAku5tZaY=;
	b=tvKtDZqPpVrQhk8iuI0TBxuPi5rFadAt5/1sHIlEUu9tWRrXa01G3Zb9kD+xJ1qs0ZZApX
	k0qEa05EztYyeJCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 867D313B16;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id EancICy9s2aFNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id E81ACA0896; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 11/13] fs: Make sb_start_write() return error on shutdown filesystem
Date: Wed,  7 Aug 2024 20:29:56 +0200
Message-Id: <20240807183003.23562-11-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7957; i=jack@suse.cz; h=from:subject; bh=Nh7+Gohd80CafAf6rSUlx70GGjPImuDki53aSiRfl7w=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70jN/pdziElOlGS00zJqyOkRF0b9SOLoDJYLwm2 rbD2OfOJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9IwAKCRCcnaoHP2RA2XV5B/ 40OS/OkLJmOGdjXx7Ni+dtp/d/aealGn2D9jwfLzF/q+BzAWoRdYFL4sryshNHj9rOhy9la3Vk78lI aUns5u1zSn+HVkHJDiT0hAZmKfYvXtSYQXzs5BvBLzG7J/1C0snnPw2AgTAXi8zu0PvRLKWnFfH1xU DBNqWsStC9Wldrr784nBrXVLn8l37BTjPkJiZDa/LCnhcWlxz7egMJC5tlGQ6MuJuwmGhaHIH0Wbnw RSKgCExhMAasH6eyyahpJ+Pfj+PrtuWszQx7yMylBNLtvjmcr0ADRRP66Tq2kCVYea7Km/RVAUw7Ih 2WLrkUM112XFIIIo+VII9v1kjHKi8s
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	MID_CONTAINS_FROM(1.00)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Score: -2.80

Introduce new SB_I_SHUTDOWN flag that a filesystem can set when it is
forcefully shutting down (usually due to errors). Make sb_start_write()
return errors for such superblocks to avoid modifications to it which
reduces noise in the error logs and generally makes life somewhat easier
for filesystems. We teach all sb_start_write() callers to handle the
error.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/btrfs/block-group.c |  3 ++-
 fs/btrfs/defrag.c      |  6 +++++-
 fs/btrfs/volumes.c     | 13 +++++++++----
 fs/ext4/mmp.c          |  4 +++-
 fs/namespace.c         |  8 ++++++--
 fs/open.c              |  4 +++-
 fs/overlayfs/util.c    |  3 +--
 fs/quota/quota.c       |  4 ++--
 fs/xfs/xfs_ioctl.c     |  4 +++-
 include/linux/fs.h     | 16 ++++++++++++----
 10 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index 498442d0c216..fdd833f1f7df 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -1800,7 +1800,8 @@ void btrfs_reclaim_bgs_work(struct work_struct *work)
 	if (!btrfs_should_reclaim(fs_info))
 		return;
 
-	sb_start_write(fs_info->sb);
+	if (sb_start_write(fs_info->sb) < 0)
+		return;
 
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
 		sb_end_write(fs_info->sb);
diff --git a/fs/btrfs/defrag.c b/fs/btrfs/defrag.c
index f6dbda37a361..6d14c9be4060 100644
--- a/fs/btrfs/defrag.c
+++ b/fs/btrfs/defrag.c
@@ -274,7 +274,11 @@ static int __btrfs_run_defrag_inode(struct btrfs_fs_info *fs_info,
 	range.start = cur;
 	range.extent_thresh = defrag->extent_thresh;
 
-	sb_start_write(fs_info->sb);
+	ret = sb_start_write(fs_info->sb);
+	if (ret < 0) {
+		iput(inode);
+		goto cleanup;
+	}
 	ret = btrfs_defrag_file(inode, NULL, &range, defrag->transid,
 				       BTRFS_DEFRAG_BATCH);
 	sb_end_write(fs_info->sb);
diff --git a/fs/btrfs/volumes.c b/fs/btrfs/volumes.c
index fcedc43ef291..f7b6b307c4bf 100644
--- a/fs/btrfs/volumes.c
+++ b/fs/btrfs/volumes.c
@@ -4589,9 +4589,11 @@ int btrfs_balance(struct btrfs_fs_info *fs_info,
 static int balance_kthread(void *data)
 {
 	struct btrfs_fs_info *fs_info = data;
-	int ret = 0;
+	int ret;
 
-	sb_start_write(fs_info->sb);
+	ret = sb_start_write(fs_info->sb);
+	if (ret < 0)
+		return ret;
 	mutex_lock(&fs_info->balance_mutex);
 	if (fs_info->balance_ctl)
 		ret = btrfs_balance(fs_info, fs_info->balance_ctl, NULL);
@@ -8231,12 +8233,15 @@ static int relocating_repair_kthread(void *data)
 	struct btrfs_block_group *cache = data;
 	struct btrfs_fs_info *fs_info = cache->fs_info;
 	u64 target;
-	int ret = 0;
+	int ret;
 
 	target = cache->start;
 	btrfs_put_block_group(cache);
 
-	sb_start_write(fs_info->sb);
+	ret = sb_start_write(fs_info->sb);
+	if (ret < 0)
+		return ret;
+
 	if (!btrfs_exclop_start(fs_info, BTRFS_EXCLOP_BALANCE)) {
 		btrfs_info(fs_info,
 			   "zoned: skip relocating block group %llu to repair: EBUSY",
diff --git a/fs/ext4/mmp.c b/fs/ext4/mmp.c
index bd946d0c71b7..96f69b6835f9 100644
--- a/fs/ext4/mmp.c
+++ b/fs/ext4/mmp.c
@@ -63,7 +63,9 @@ static int write_mmp_block(struct super_block *sb, struct buffer_head *bh)
 	 * We protect against freezing so that we don't create dirty buffers
 	 * on frozen filesystem.
 	 */
-	sb_start_write(sb);
+	err = sb_start_write(sb);
+	if (err < 0)
+		return err;
 	err = write_mmp_block_thawed(sb, bh);
 	sb_end_write(sb);
 	return err;
diff --git a/fs/namespace.c b/fs/namespace.c
index 1c5591673f96..43fad685531e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -512,7 +512,9 @@ int mnt_want_write(struct vfsmount *m)
 {
 	int ret;
 
-	sb_start_write(m->mnt_sb);
+	ret = sb_start_write(m->mnt_sb);
+	if (ret)
+		return ret;
 	ret = mnt_get_write_access(m);
 	if (ret)
 		sb_end_write(m->mnt_sb);
@@ -556,7 +558,9 @@ int mnt_want_write_file(struct file *file)
 {
 	int ret;
 
-	sb_start_write(file_inode(file)->i_sb);
+	ret = sb_start_write(file_inode(file)->i_sb);
+	if (ret)
+		return ret;
 	ret = mnt_get_write_access_file(file);
 	if (ret)
 		sb_end_write(file_inode(file)->i_sb);
diff --git a/fs/open.c b/fs/open.c
index 4bce4ba776ab..8fe9f4968969 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -175,7 +175,9 @@ long do_ftruncate(struct file *file, loff_t length, int small)
 	/* Check IS_APPEND on real upper inode */
 	if (IS_APPEND(file_inode(file)))
 		return -EPERM;
-	sb_start_write(inode->i_sb);
+	error = sb_start_write(inode->i_sb);
+	if (error)
+		return error;
 	error = security_file_truncate(file);
 	if (!error)
 		error = do_truncate(file_mnt_idmap(file), dentry, length,
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index b53fa14506a9..f97bf2458c66 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -28,8 +28,7 @@ int ovl_get_write_access(struct dentry *dentry)
 int __must_check ovl_start_write(struct dentry *dentry)
 {
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
-	sb_start_write(ovl_upper_mnt(ofs)->mnt_sb);
-	return 0;
+	return sb_start_write(ovl_upper_mnt(ofs)->mnt_sb);
 }
 
 int ovl_want_write(struct dentry *dentry)
diff --git a/fs/quota/quota.c b/fs/quota/quota.c
index 0e41fb84060f..df9c4d08f135 100644
--- a/fs/quota/quota.c
+++ b/fs/quota/quota.c
@@ -896,8 +896,8 @@ static struct super_block *quotactl_block(const char __user *special, int cmd)
 		else
 			up_read(&sb->s_umount);
 		/* Wait for sb to unfreeze */
-		sb_start_write(sb);
-		sb_end_write(sb);
+		if (sb_start_write(sb) == 0)
+			sb_end_write(sb);
 		put_super(sb);
 		goto retry;
 	}
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 4e933db75b12..5cf9e568324a 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1499,7 +1499,9 @@ xfs_file_ioctl(
 
 		trace_xfs_ioc_free_eofblocks(mp, &icw, _RET_IP_);
 
-		sb_start_write(mp->m_super);
+		error = sb_start_write(mp->m_super);
+		if (error)
+			return error;
 		error = xfs_blockgc_free_space(mp, &icw);
 		sb_end_write(mp->m_super);
 		return error;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 755a4c83a2bf..44ae86f46b12 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1190,6 +1190,9 @@ enum {
 	SB_I_TS_EXPIRY_WARNED,	/* warned about timestamp range expiry */
 	SB_I_RETIRED,		/* superblock shouldn't be reused */
 	SB_I_NOUMASK,		/* VFS does not apply umask */
+	SB_I_SHUTDOWN,		/* The filesystem has shutdown. Refuse
+				 * modification attempts with error as they are
+				 * a futile exercise. */
 };
 
 /* Possible states of 'frozen' field */
@@ -1823,9 +1826,12 @@ static inline void sb_end_intwrite(struct super_block *sb)
  *   -> i_mutex			(write path, truncate, directory ops, ...)
  *   -> s_umount		(freeze_super, thaw_super)
  */
-static inline void sb_start_write(struct super_block *sb)
+static inline int __must_check sb_start_write(struct super_block *sb)
 {
+	if (sb_test_iflag(sb, SB_I_SHUTDOWN))
+		return -EROFS;
 	__sb_start_write(sb, SB_FREEZE_WRITE);
+	return 0;
 }
 
 static inline bool __must_check sb_start_write_trylock(struct super_block *sb)
@@ -2891,8 +2897,7 @@ static inline int __must_check file_start_write(struct file *file)
 {
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return 0;
-	sb_start_write(file_inode(file)->i_sb);
-	return 0;
+	return sb_start_write(file_inode(file)->i_sb);
 }
 
 static inline bool __must_check file_start_write_trylock(struct file *file)
@@ -2925,8 +2930,11 @@ static inline void file_end_write(struct file *file)
 static inline int __must_check kiocb_start_write(struct kiocb *iocb)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
+	int err;
 
-	sb_start_write(inode->i_sb);
+	err = sb_start_write(inode->i_sb);
+	if (err)
+		return err;
 	/*
 	 * Fool lockdep by telling it the lock got released so that it
 	 * doesn't complain about the held lock when we return to userspace.
-- 
2.35.3



Return-Path: <linux-fsdevel+bounces-25341-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F0194AFBC
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7F21C21A75
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEE9414375A;
	Wed,  7 Aug 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="USCom/6A";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5Hg2+No6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="L+xbd6eM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IEwqLGf/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AA713F012
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055409; cv=none; b=FMyzsUUM9HZIx4qJAGnEzpUfd+fYv2G4RkV0aWymhE7j7BJsZ9hT3V10I1EBA9h8OTocWvqUUM5c6MSEQu5qZ+zr535JjMg9R5pz4VAf4ycHsK9LSSmwSvLyvPHtq+bwTrpU1ZhMYIXMHoy+vf9FjG8FZZOD1bnqYp4KuVfDHYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055409; c=relaxed/simple;
	bh=pmU00GFGhFqdo9dFtgioCWIx18MNwL+VWzn/H84Q9Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JJl3Oy7kQXG26SKwXXmrSEnruKw8uB7yCc3UK5q4MiAgvNN1FD7/Ctr8TELi44SWRemoAsDAAxjQvZvxB2uOYEWOmKxrt58SHjV2B+XY+r0KVxfrFVe4x94WKqY25ItbyLnW5XQAETvlmgcNH7clT44Ps0kLSCW+HjPbv+wL04c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=USCom/6A; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5Hg2+No6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=L+xbd6eM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IEwqLGf/; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2B0391FB9B;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hJSnrQLpQHBgUjNMT0pcZBC3s0BXvP07ddUXbWSWF4=;
	b=USCom/6AVT/l0lKqTiYNQOBObwPqm652fjGNrF/TCbcYYlviVQVP6dkksLFZGME9gFRzhL
	xYznfTIzSUnIJqG0w5aMQusEnNIOSamFVuN8KUbxrBvs/GaPonBxGsNUhohKrkMp/c7Asu
	ApPJ3GGl/VD2jiYguwtcFS9TBFU9jeI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hJSnrQLpQHBgUjNMT0pcZBC3s0BXvP07ddUXbWSWF4=;
	b=5Hg2+No6iNVhw9ask8tTBhuGpuh5XWH4udjaOMYhKd/D3g6LHeBDYZSWS0Vfp/x+pYOWQs
	RL5FLsdHvwtQiKBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055404; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hJSnrQLpQHBgUjNMT0pcZBC3s0BXvP07ddUXbWSWF4=;
	b=L+xbd6eMDzvb8rcVV8HS6LQEVbHyNwE1rFszssyzvhh86kJCV+/n8L6zYua1VrhJZgxKH1
	WnTe7bRMHdOcULMpPb4G57g+x47yujVpJVqKeOc+gpt9s4JCh6uXPPrs1Rojy73Zjvt820
	rNlM9Ppl0/Vj2wYQADrwQkywNYzC68o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055404;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2hJSnrQLpQHBgUjNMT0pcZBC3s0BXvP07ddUXbWSWF4=;
	b=IEwqLGf/Iy0j/pFaPWC0dZ4nrWoksmQaVP1ZfEdce/AuVT4DxrDaw/YxVD/WkV3RZnkJ/n
	Fmd2HaNDJ6JZ4UAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 14DC413B08;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 6DMWBSy9s2ZvNAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id B03B1A0857; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 04/13] fs: Convert remaining usage of SB_I_ flags
Date: Wed,  7 Aug 2024 20:29:49 +0200
Message-Id: <20240807183003.23562-4-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=17335; i=jack@suse.cz; h=from:subject; bh=pmU00GFGhFqdo9dFtgioCWIx18MNwL+VWzn/H84Q9Ms=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70dKt3VaUomAJhmhnz2xQwQAlcIzTEWepN647of u03Pr6KJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9HQAKCRCcnaoHP2RA2bnZB/ 9QovmThPaJC9WPlyZTuC2HXfkh3j/3VXSDBmfLNGtjUafTNcjTj/eq2lG3dkGxuEPN3+n32JqkfL9y C27dZTEmMxuIa2wIeielhqAnrm4Nu65XIaVvE0sI0wxBpAepAdnwOJaF1uCSy9f0SW1HaXBes9yBVd azaZcGVJjDRZvEljzaLwMzO/fbpXEu+NV83dH80LFfB4/CjCdJ4OGoxmIwBn16Me1otD9xnlJO55zR v8yBdnULCjPn7TARBaKSUKhGPR7MsPrT7HgeCf1eteSKC8cp5fxZvgwYnuFoKuAL81tTYPjMLUSGb9 M/Bh1AGyOf5Lseynpj47o6P8duIKB2
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spam-Level: 

Convert remaining handling of sb->s_iflags to use the new helper
functions and new bit constants. The patch was generated using
coccinelle with a few manual fixups to improve code style.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/android/binderfs.c            |  4 ++--
 fs/btrfs/super.c                      |  2 +-
 fs/devpts/inode.c                     |  2 +-
 fs/exec.c                             |  2 +-
 fs/ext2/super.c                       |  2 +-
 fs/ext4/super.c                       |  2 +-
 fs/f2fs/super.c                       |  2 +-
 fs/fuse/inode.c                       |  4 ++--
 fs/inode.c                            |  2 +-
 fs/kernfs/mount.c                     |  3 ++-
 fs/namei.c                            |  2 +-
 fs/namespace.c                        |  4 ++--
 fs/nfs/super.c                        |  2 +-
 fs/overlayfs/super.c                  |  6 +++---
 fs/proc/root.c                        |  4 +++-
 fs/super.c                            | 18 +++++++++---------
 fs/sync.c                             |  2 +-
 fs/sysfs/mount.c                      |  2 +-
 fs/xfs/xfs_super.c                    |  2 +-
 include/linux/backing-dev.h           |  2 +-
 include/linux/namei.h                 |  2 +-
 ipc/mqueue.c                          |  3 ++-
 security/integrity/evm/evm_main.c     |  2 +-
 security/integrity/ima/ima_appraise.c |  4 ++--
 security/integrity/ima/ima_main.c     |  4 ++--
 25 files changed, 44 insertions(+), 40 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 3001d754ac36..f9454b93c2f7 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -672,8 +672,8 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * allowed to do. So removing the SB_I_NODEV flag from s_iflags is both
 	 * necessary and safe.
 	 */
-	sb->s_iflags &= ~SB_I_NODEV;
-	sb->s_iflags |= SB_I_NOEXEC;
+	sb_clear_iflag(sb, _SB_I_NODEV);
+	sb_set_iflag(sb, _SB_I_NOEXEC);
 	sb->s_magic = BINDERFS_SUPER_MAGIC;
 	sb->s_op = &binderfs_super_ops;
 	sb->s_time_gran = 1;
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 08d33cb372fb..321696697279 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -950,7 +950,7 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb_set_iflag(sb, _SB_I_CGROUPWB);
 
 	err = super_setup_bdi(sb);
 	if (err) {
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index b20e565b9c5e..d473156d2791 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -428,7 +428,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	struct inode *inode;
 	int error;
 
-	s->s_iflags &= ~SB_I_NODEV;
+	sb_clear_iflag(s, _SB_I_NODEV);
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
diff --git a/fs/exec.c b/fs/exec.c
index a126e3d1cacb..b62b67bea10b 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -112,7 +112,7 @@ static inline void put_binfmt(struct linux_binfmt * fmt)
 bool path_noexec(const struct path *path)
 {
 	return (path->mnt->mnt_flags & MNT_NOEXEC) ||
-	       (path->mnt->mnt_sb->s_iflags & SB_I_NOEXEC);
+	       sb_test_iflag(path->mnt->mnt_sb, _SB_I_NOEXEC);
 }
 
 #ifdef CONFIG_USELIB
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 37f7ce56adce..9da8652c10c5 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -916,7 +916,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb_set_iflag(sb, _SB_I_CGROUPWB);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
 	    (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 93c016b186c0..a776d4e7ec66 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4972,7 +4972,7 @@ static int ext4_check_journal_data_mode(struct super_block *sb)
 		if (test_opt(sb, DELALLOC))
 			clear_opt(sb, DELALLOC);
 	} else {
-		sb->s_iflags |= SB_I_CGROUPWB;
+		sb_set_iflag(sb, _SB_I_CGROUPWB);
 	}
 
 	return 0;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 3959fd137cc9..041b7b7b0810 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4472,7 +4472,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 	super_set_uuid(sb, (void *) raw_super->uuid, sizeof(raw_super->uuid));
 	super_set_sysfs_name_bdev(sb);
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb_set_iflag(sb, _SB_I_CGROUPWB);
 
 	/* init f2fs-specific super block info */
 	sbi->valid_super_block = valid_super_block;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index d8ab4e93916f..3602a578b7b3 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1566,9 +1566,9 @@ static void fuse_sb_defaults(struct super_block *sb)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_time_gran = 1;
 	sb->s_export_op = &fuse_export_operations;
-	sb->s_iflags |= SB_I_IMA_UNVERIFIABLE_SIGNATURE;
+	sb_set_iflag(sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE);
 	if (sb->s_user_ns != &init_user_ns)
-		sb->s_iflags |= SB_I_UNTRUSTED_MOUNTER;
+		sb_set_iflag(sb, _SB_I_UNTRUSTED_MOUNTER);
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index 86670941884b..a8598a968940 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -216,7 +216,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	lockdep_set_class_and_name(&mapping->invalidate_lock,
 				   &sb->s_type->invalidate_lock_key,
 				   "mapping.invalidate_lock");
-	if (sb->s_iflags & SB_I_STABLE_WRITES)
+	if (sb_test_iflag(sb, _SB_I_STABLE_WRITES))
 		mapping_set_stable_writes(mapping);
 	inode->i_private = NULL;
 	inode->i_mapping = mapping;
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 1358c21837f1..762edcf5387e 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -252,7 +252,8 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 
 	info->sb = sb;
 	/* Userspace would break if executables or devices appear on sysfs */
-	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
+	sb_set_iflag(sb, _SB_I_NOEXEC);
+	sb_set_iflag(sb, _SB_I_NODEV);
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = kfc->magic;
diff --git a/fs/namei.c b/fs/namei.c
index 5512cb10fa89..de6936564298 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3308,7 +3308,7 @@ EXPORT_SYMBOL(vfs_mkobj);
 bool may_open_dev(const struct path *path)
 {
 	return !(path->mnt->mnt_flags & MNT_NODEV) &&
-		!(path->mnt->mnt_sb->s_iflags & SB_I_NODEV);
+		!sb_test_iflag(path->mnt->mnt_sb, _SB_I_NODEV);
 }
 
 static int may_open(struct mnt_idmap *idmap, const struct path *path,
diff --git a/fs/namespace.c b/fs/namespace.c
index 75153f61a908..17126569b3c4 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2919,7 +2919,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 	struct super_block *sb = mnt->mnt_sb;
 
 	if (!__mnt_is_readonly(mnt) &&
-	   (!(sb->s_iflags & SB_I_TS_EXPIRY_WARNED)) &&
+	   !sb_test_iflag(sb, _SB_I_TS_EXPIRY_WARNED) &&
 	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
 		char *buf = (char *)__get_free_page(GFP_KERNEL);
 		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
@@ -2931,7 +2931,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 			(unsigned long long)sb->s_time_max);
 
 		free_page((unsigned long)buf);
-		sb->s_iflags |= SB_I_TS_EXPIRY_WARNED;
+		sb_set_iflag(sb, _SB_I_TS_EXPIRY_WARNED);
 	}
 }
 
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index cbbd4866b0b7..b6b806fb6286 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1094,7 +1094,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 		sb->s_export_op = &nfs_export_ops;
 		break;
 	case 4:
-		sb->s_iflags |= SB_I_NOUMASK;
+		sb_set_iflag(sb, _SB_I_NOUMASK);
 		sb->s_time_gran = 1;
 		sb->s_time_min = S64_MIN;
 		sb->s_time_max = S64_MAX;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 06a231970cb5..afa5263ff016 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1453,14 +1453,14 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 #ifdef CONFIG_FS_POSIX_ACL
 	sb->s_flags |= SB_POSIXACL;
 #endif
-	sb->s_iflags |= SB_I_SKIP_SYNC;
+	sb_set_iflag(sb, _SB_I_SKIP_SYNC);
 	/*
 	 * Ensure that umask handling is done by the filesystems used
 	 * for the the upper layer instead of overlayfs as that would
 	 * lead to unexpected results.
 	 */
-	sb->s_iflags |= SB_I_NOUMASK;
-	sb->s_iflags |= SB_I_EVM_HMAC_UNSUPPORTED;
+	sb_set_iflag(sb, _SB_I_NOUMASK);
+	sb_set_iflag(sb, _SB_I_EVM_HMAC_UNSUPPORTED);
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index 06a297a27ba3..ac78ec69dde9 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -171,7 +171,9 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	proc_apply_options(fs_info, fc, current_user_ns());
 
 	/* User space would break if executables or devices appear on proc */
-	s->s_iflags |= SB_I_USERNS_VISIBLE | SB_I_NOEXEC | SB_I_NODEV;
+	sb_set_iflag(s, _SB_I_USERNS_VISIBLE);
+	sb_set_iflag(s, _SB_I_NOEXEC);
+	sb_set_iflag(s, _SB_I_NODEV);
 	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
diff --git a/fs/super.c b/fs/super.c
index 38d72a3cf6fc..e3020b3db4f0 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -355,7 +355,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
 	if (s->s_user_ns != &init_user_ns)
-		s->s_iflags |= SB_I_NODEV;
+		sb_set_iflag(s, _SB_I_NODEV);
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
 	mutex_init(&s->s_sync_lock);
@@ -589,11 +589,11 @@ void retire_super(struct super_block *sb)
 {
 	WARN_ON(!sb->s_bdev);
 	__super_lock_excl(sb);
-	if (sb->s_iflags & SB_I_PERSB_BDI) {
+	if (sb_test_iflag(sb, _SB_I_PERSB_BDI)) {
 		bdi_unregister(sb->s_bdi);
-		sb->s_iflags &= ~SB_I_PERSB_BDI;
+		sb_clear_iflag(sb, _SB_I_PERSB_BDI);
 	}
-	sb->s_iflags |= SB_I_RETIRED;
+	sb_set_iflag(sb, _SB_I_RETIRED);
 	super_unlock_excl(sb);
 }
 EXPORT_SYMBOL(retire_super);
@@ -678,7 +678,7 @@ void generic_shutdown_super(struct super_block *sb)
 	super_wake(sb, SB_DYING);
 	super_unlock_excl(sb);
 	if (sb->s_bdi != &noop_backing_dev_info) {
-		if (sb->s_iflags & SB_I_PERSB_BDI)
+		if (sb_test_iflag(sb, _SB_I_PERSB_BDI))
 			bdi_unregister(sb->s_bdi);
 		bdi_put(sb->s_bdi);
 		sb->s_bdi = &noop_backing_dev_info;
@@ -1331,7 +1331,7 @@ static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
 
 static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
 {
-	return !(s->s_iflags & SB_I_RETIRED) &&
+	return !sb_test_iflag(s, _SB_I_RETIRED) &&
 		s->s_dev == *(dev_t *)fc->sget_key;
 }
 
@@ -1584,7 +1584,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	sb->s_bdev = bdev;
 	sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
 	if (bdev_stable_writes(bdev))
-		sb->s_iflags |= SB_I_STABLE_WRITES;
+		sb_set_iflag(sb, _SB_I_STABLE_WRITES);
 	spin_unlock(&sb_lock);
 
 	snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
@@ -1648,7 +1648,7 @@ EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
 {
-	return !(s->s_iflags & SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
+	return !sb_test_iflag(s, _SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
@@ -1864,7 +1864,7 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
 	}
 	WARN_ON(sb->s_bdi != &noop_backing_dev_info);
 	sb->s_bdi = bdi;
-	sb->s_iflags |= SB_I_PERSB_BDI;
+	sb_set_iflag(sb, _SB_I_PERSB_BDI);
 
 	return 0;
 }
diff --git a/fs/sync.c b/fs/sync.c
index dc725914e1ed..4e5ad48316be 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -79,7 +79,7 @@ static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 
 static void sync_fs_one_sb(struct super_block *sb, void *arg)
 {
-	if (!sb_rdonly(sb) && !(sb->s_iflags & SB_I_SKIP_SYNC) &&
+	if (!sb_rdonly(sb) && !sb_test_iflag(sb, _SB_I_SKIP_SYNC) &&
 	    sb->s_op->sync_fs)
 		sb->s_op->sync_fs(sb, *(int *)arg);
 }
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index 98467bb76737..124385961da7 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -33,7 +33,7 @@ static int sysfs_get_tree(struct fs_context *fc)
 		return ret;
 
 	if (kfc->new_sb_created)
-		fc->root->d_sb->s_iflags |= SB_I_USERNS_VISIBLE;
+		sb_set_iflag(fc->root->d_sb, _SB_I_USERNS_VISIBLE);
 	return 0;
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 27e9f749c4c7..7707f2a1a836 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1701,7 +1701,7 @@ xfs_fs_fill_super(
 		sb->s_time_max = XFS_LEGACY_TIME_MAX;
 	}
 	trace_xfs_inode_timestamp_range(mp, sb->s_time_min, sb->s_time_max);
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb_set_iflag(sb, _SB_I_CGROUPWB);
 
 	set_posix_acl_flag(sb);
 
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 8e7af9a03b41..54fdae7b1be4 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -176,7 +176,7 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
 	return cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
 		cgroup_subsys_on_dfl(io_cgrp_subsys) &&
 		(bdi->capabilities & BDI_CAP_WRITEBACK) &&
-		(inode->i_sb->s_iflags & SB_I_CGROUPWB);
+		sb_test_iflag(inode->i_sb, _SB_I_CGROUPWB);
 }
 
 /**
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 8ec8fed3bce8..3fbf340dac1a 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -107,7 +107,7 @@ extern void unlock_rename(struct dentry *, struct dentry *);
  */
 static inline umode_t __must_check mode_strip_umask(const struct inode *dir, umode_t mode)
 {
-	if (!IS_POSIXACL(dir) && !(dir->i_sb->s_iflags & SB_I_NOUMASK))
+	if (!IS_POSIXACL(dir) && !sb_test_iflag(dir->i_sb, _SB_I_NOUMASK))
 		mode &= ~current_umask();
 	return mode;
 }
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index a7cbd69efbef..e73fff4c2f12 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -406,7 +406,8 @@ static int mqueue_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct inode *inode;
 	struct ipc_namespace *ns = sb->s_fs_info;
 
-	sb->s_iflags |= SB_I_NOEXEC | SB_I_NODEV;
+	sb_set_iflag(sb, _SB_I_NOEXEC);
+	sb_set_iflag(sb, _SB_I_NODEV);
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = MQUEUE_MAGIC;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 62fe66dd53ce..3ff29bf73f04 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -155,7 +155,7 @@ static int is_unsupported_hmac_fs(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	if (inode->i_sb->s_iflags & SB_I_EVM_HMAC_UNSUPPORTED) {
+	if (sb_test_iflag(inode->i_sb, _SB_I_EVM_HMAC_UNSUPPORTED)) {
 		pr_info_once("%s not supported\n", inode->i_sb->s_type->name);
 		return 1;
 	}
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 656c709b974f..9c290dd8a4ac 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -564,8 +564,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	 * system not willing to accept such a risk, fail the file signature
 	 * verification.
 	 */
-	if ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
-	    ((inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) ||
+	if (sb_test_iflag(inode->i_sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
+	    (sb_test_iflag(inode->i_sb, _SB_I_UNTRUSTED_MOUNTER) ||
 	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
 		status = INTEGRITY_FAIL;
 		cause = "unverifiable-signature";
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index f04f43af651c..b04eaa33eca4 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -280,8 +280,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * (Limited to privileged mounted filesystems.)
 	 */
 	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
-	    ((inode->i_sb->s_iflags & SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
-	     !(inode->i_sb->s_iflags & SB_I_UNTRUSTED_MOUNTER) &&
+	    (sb_test_iflag(inode->i_sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
+	     !sb_test_iflag(inode->i_sb, _SB_I_UNTRUSTED_MOUNTER) &&
 	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
 		iint->flags &= ~IMA_DONE_MASK;
 		iint->measured_pcrs = 0;
-- 
2.35.3



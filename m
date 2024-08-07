Return-Path: <linux-fsdevel+bounces-25347-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1019594AFC4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 20:31:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 338841C21289
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Aug 2024 18:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9441145321;
	Wed,  7 Aug 2024 18:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m0oqXG60";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q0oVhd0w";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="m0oqXG60";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q0oVhd0w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DC214374C
	for <linux-fsdevel@vger.kernel.org>; Wed,  7 Aug 2024 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723055413; cv=none; b=txjCxXaCFsK85m+5ChgP2SYyNkpJjS8mwFXn13+Pc0lKIkF+rS+3J+nNUn1NMw3TXJ0K//2E4Fo2qTxf4RoaFEaV7TrclFZkbcQq7/S3lKrBhmAjS0hkGUoXy7qLiCxY4BK9h0024aIebVl85/8uDwOymvyQuV4XtmyJvp3Lt7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723055413; c=relaxed/simple;
	bh=xdVKxLuhh7kQ4pi7CNuIs5KuDljkW9yy7R1YP6bnphA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+UGbijeQTQA1jrmP23EPm59r6kEOA7OzFa2WWg60DR+uQ8KpNITJqSHjPwTDuGnlfqhhKHPxYYy0DncDigggRykac0fbJJLLzyncOSygoVPO4vas34ozg8unlEjJSCkJTe4xGxTyohTDsZFMLmT0ky5REGJagfmxh2W9KDr1Pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m0oqXG60; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q0oVhd0w; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=m0oqXG60; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q0oVhd0w; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 8207C21CEF;
	Wed,  7 Aug 2024 18:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwczmGJuzBlAGThCZWPl+ZsYNhfyPWCCY1cAKUTf6Bs=;
	b=m0oqXG60Uat7Auh7EdhjKna6lH9keceM50szKWnU7uSCAro2N2Y/mfwY+aruEaS+SqA7ZD
	/WYUzfroge5/KKZatD++yzH6rvbxb5TBwWTUEkavhKAUoRFfhfS+XxROpQPsr/gRCBg3lL
	peZ6Mul91186Fec3KpAMnjg0GHIRtJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwczmGJuzBlAGThCZWPl+ZsYNhfyPWCCY1cAKUTf6Bs=;
	b=Q0oVhd0waOXRRkPo5QUqFlRU5tFWGpGwdvUuh9xkrxSG4lzFENO95eKlEDlo8vl081dFwF
	vE4Fee2rnjojdwDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1723055405; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwczmGJuzBlAGThCZWPl+ZsYNhfyPWCCY1cAKUTf6Bs=;
	b=m0oqXG60Uat7Auh7EdhjKna6lH9keceM50szKWnU7uSCAro2N2Y/mfwY+aruEaS+SqA7ZD
	/WYUzfroge5/KKZatD++yzH6rvbxb5TBwWTUEkavhKAUoRFfhfS+XxROpQPsr/gRCBg3lL
	peZ6Mul91186Fec3KpAMnjg0GHIRtJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1723055405;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VwczmGJuzBlAGThCZWPl+ZsYNhfyPWCCY1cAKUTf6Bs=;
	b=Q0oVhd0waOXRRkPo5QUqFlRU5tFWGpGwdvUuh9xkrxSG4lzFENO95eKlEDlo8vl081dFwF
	vE4Fee2rnjojdwDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 636AE13B09;
	Wed,  7 Aug 2024 18:30:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PZpDGCy9s2Z1NAAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 07 Aug 2024 18:30:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id C0151A0873; Wed,  7 Aug 2024 20:30:03 +0200 (CEST)
From: Jan Kara <jack@suse.cz>
To: <linux-fsdevel@vger.kernel.org>
Cc: Dave Chinner <david@fromorbit.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 06/13] fs: Drop unnecessary underscore from _SB_I_ constants
Date: Wed,  7 Aug 2024 20:29:51 +0200
Message-Id: <20240807183003.23562-6-jack@suse.cz>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240807180706.30713-1-jack@suse.cz>
References: <20240807180706.30713-1-jack@suse.cz>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21137; i=jack@suse.cz; h=from:subject; bh=xdVKxLuhh7kQ4pi7CNuIs5KuDljkW9yy7R1YP6bnphA=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBms70fN/jLNwNyk51iZVXXCj6pEJVRT/2kJfWv0Z2O qqDlMMCJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCZrO9HwAKCRCcnaoHP2RA2ZZZB/ 9azu+5TA2B5dO2rStjybow6FrVV6woijRJyjpGse5BwIUva0Pz1QxXSGSzbmhhQDZrdmIUJXoNi4P+ 9G0Qb922fTD2Z6h/b2vCklXsqtpKOfpQaTMP7HFubQwvoxQEeHmIRM4DZhhmzwRwBYURJnmKZ3grMS Ogjl8gACdD7aGZ6bhAgGjtmwFe9nvZWDnBltFdW0SeNkB10a/MC7fMwlBp8DI8CvcEvPxZ93aHJivf 0LSMpgxUgsZAfcvqxGGbircXGL7T1s8ur76VmzH10pEZn9Qc6LoTGQjuLU3Tn2We/ucdRJVM+OM7Rl gTLwOWHpDb+4LEW0Lf+yCXv5bB/i0A
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -2.80
X-Spam-Flag: NO
X-Spam-Level: 

Now that old constants are gone, remove the unnecessary underscore from
the new _SB_I_ constants. Pure mechanical replacement, no functional
changes.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 block/bdev.c                          |  2 +-
 drivers/android/binderfs.c            |  4 ++--
 fs/aio.c                              |  2 +-
 fs/btrfs/super.c                      |  2 +-
 fs/devpts/inode.c                     |  2 +-
 fs/exec.c                             |  2 +-
 fs/ext2/super.c                       |  2 +-
 fs/ext4/super.c                       |  2 +-
 fs/f2fs/super.c                       |  2 +-
 fs/fuse/inode.c                       |  4 ++--
 fs/inode.c                            |  2 +-
 fs/kernfs/mount.c                     |  4 ++--
 fs/namei.c                            |  2 +-
 fs/namespace.c                        |  8 ++++----
 fs/nfs/fs_context.c                   |  2 +-
 fs/nfs/super.c                        |  2 +-
 fs/overlayfs/super.c                  |  6 +++---
 fs/proc/root.c                        |  6 +++---
 fs/super.c                            | 18 ++++++++---------
 fs/sync.c                             |  2 +-
 fs/sysfs/mount.c                      |  2 +-
 fs/xfs/xfs_super.c                    |  2 +-
 include/linux/backing-dev.h           |  2 +-
 include/linux/fs.h                    | 28 +++++++++++++--------------
 include/linux/namei.h                 |  2 +-
 ipc/mqueue.c                          |  4 ++--
 security/integrity/evm/evm_main.c     |  2 +-
 security/integrity/ima/ima_appraise.c |  4 ++--
 security/integrity/ima/ima_main.c     |  4 ++--
 29 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index c1ea2aeb93dd..6c13ba60c0b1 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -373,7 +373,7 @@ static int bd_init_fs_context(struct fs_context *fc)
 	struct pseudo_fs_context *ctx = init_pseudo(fc, BDEVFS_MAGIC);
 	if (!ctx)
 		return -ENOMEM;
-	fc->s_iflags |= 1 << _SB_I_CGROUPWB;
+	fc->s_iflags |= 1 << SB_I_CGROUPWB;
 	ctx->ops = &bdev_sops;
 	return 0;
 }
diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index f9454b93c2f7..6070923fbfbd 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -672,8 +672,8 @@ static int binderfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	 * allowed to do. So removing the SB_I_NODEV flag from s_iflags is both
 	 * necessary and safe.
 	 */
-	sb_clear_iflag(sb, _SB_I_NODEV);
-	sb_set_iflag(sb, _SB_I_NOEXEC);
+	sb_clear_iflag(sb, SB_I_NODEV);
+	sb_set_iflag(sb, SB_I_NOEXEC);
 	sb->s_magic = BINDERFS_SUPER_MAGIC;
 	sb->s_op = &binderfs_super_ops;
 	sb->s_time_gran = 1;
diff --git a/fs/aio.c b/fs/aio.c
index 63ce0736c3a3..48d99221ff57 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -279,7 +279,7 @@ static int aio_init_fs_context(struct fs_context *fc)
 {
 	if (!init_pseudo(fc, AIO_RING_MAGIC))
 		return -ENOMEM;
-	fc->s_iflags |= 1 << _SB_I_NOEXEC;
+	fc->s_iflags |= 1 << SB_I_NOEXEC;
 	return 0;
 }
 
diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 321696697279..fb3938ec127c 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -950,7 +950,7 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-	sb_set_iflag(sb, _SB_I_CGROUPWB);
+	sb_set_iflag(sb, SB_I_CGROUPWB);
 
 	err = super_setup_bdi(sb);
 	if (err) {
diff --git a/fs/devpts/inode.c b/fs/devpts/inode.c
index d473156d2791..6094cb7e1a16 100644
--- a/fs/devpts/inode.c
+++ b/fs/devpts/inode.c
@@ -428,7 +428,7 @@ devpts_fill_super(struct super_block *s, void *data, int silent)
 	struct inode *inode;
 	int error;
 
-	sb_clear_iflag(s, _SB_I_NODEV);
+	sb_clear_iflag(s, SB_I_NODEV);
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
 	s->s_magic = DEVPTS_SUPER_MAGIC;
diff --git a/fs/exec.c b/fs/exec.c
index b62b67bea10b..a8bd15aa6bd8 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -112,7 +112,7 @@ static inline void put_binfmt(struct linux_binfmt * fmt)
 bool path_noexec(const struct path *path)
 {
 	return (path->mnt->mnt_flags & MNT_NOEXEC) ||
-	       sb_test_iflag(path->mnt->mnt_sb, _SB_I_NOEXEC);
+	       sb_test_iflag(path->mnt->mnt_sb, SB_I_NOEXEC);
 }
 
 #ifdef CONFIG_USELIB
diff --git a/fs/ext2/super.c b/fs/ext2/super.c
index 9da8652c10c5..cbe79fb7ac35 100644
--- a/fs/ext2/super.c
+++ b/fs/ext2/super.c
@@ -916,7 +916,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
-	sb_set_iflag(sb, _SB_I_CGROUPWB);
+	sb_set_iflag(sb, SB_I_CGROUPWB);
 
 	if (le32_to_cpu(es->s_rev_level) == EXT2_GOOD_OLD_REV &&
 	    (EXT2_HAS_COMPAT_FEATURE(sb, ~0U) ||
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index a776d4e7ec66..b5b2f17f1b65 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4972,7 +4972,7 @@ static int ext4_check_journal_data_mode(struct super_block *sb)
 		if (test_opt(sb, DELALLOC))
 			clear_opt(sb, DELALLOC);
 	} else {
-		sb_set_iflag(sb, _SB_I_CGROUPWB);
+		sb_set_iflag(sb, SB_I_CGROUPWB);
 	}
 
 	return 0;
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 041b7b7b0810..8437612bf64b 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4472,7 +4472,7 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
 		(test_opt(sbi, POSIX_ACL) ? SB_POSIXACL : 0);
 	super_set_uuid(sb, (void *) raw_super->uuid, sizeof(raw_super->uuid));
 	super_set_sysfs_name_bdev(sb);
-	sb_set_iflag(sb, _SB_I_CGROUPWB);
+	sb_set_iflag(sb, SB_I_CGROUPWB);
 
 	/* init f2fs-specific super block info */
 	sbi->valid_super_block = valid_super_block;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index 3602a578b7b3..5b6254481d5c 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -1566,9 +1566,9 @@ static void fuse_sb_defaults(struct super_block *sb)
 	sb->s_maxbytes = MAX_LFS_FILESIZE;
 	sb->s_time_gran = 1;
 	sb->s_export_op = &fuse_export_operations;
-	sb_set_iflag(sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE);
+	sb_set_iflag(sb, SB_I_IMA_UNVERIFIABLE_SIGNATURE);
 	if (sb->s_user_ns != &init_user_ns)
-		sb_set_iflag(sb, _SB_I_UNTRUSTED_MOUNTER);
+		sb_set_iflag(sb, SB_I_UNTRUSTED_MOUNTER);
 	sb->s_flags &= ~(SB_NOSEC | SB_I_VERSION);
 }
 
diff --git a/fs/inode.c b/fs/inode.c
index a8598a968940..3091385a4de1 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -216,7 +216,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	lockdep_set_class_and_name(&mapping->invalidate_lock,
 				   &sb->s_type->invalidate_lock_key,
 				   "mapping.invalidate_lock");
-	if (sb_test_iflag(sb, _SB_I_STABLE_WRITES))
+	if (sb_test_iflag(sb, SB_I_STABLE_WRITES))
 		mapping_set_stable_writes(mapping);
 	inode->i_private = NULL;
 	inode->i_mapping = mapping;
diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 762edcf5387e..f5331f2e0b2d 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -252,8 +252,8 @@ static int kernfs_fill_super(struct super_block *sb, struct kernfs_fs_context *k
 
 	info->sb = sb;
 	/* Userspace would break if executables or devices appear on sysfs */
-	sb_set_iflag(sb, _SB_I_NOEXEC);
-	sb_set_iflag(sb, _SB_I_NODEV);
+	sb_set_iflag(sb, SB_I_NOEXEC);
+	sb_set_iflag(sb, SB_I_NODEV);
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = kfc->magic;
diff --git a/fs/namei.c b/fs/namei.c
index de6936564298..9e9bca0566e9 100644
--- a/fs/namei.c
+++ b/fs/namei.c
@@ -3308,7 +3308,7 @@ EXPORT_SYMBOL(vfs_mkobj);
 bool may_open_dev(const struct path *path)
 {
 	return !(path->mnt->mnt_flags & MNT_NODEV) &&
-		!sb_test_iflag(path->mnt->mnt_sb, _SB_I_NODEV);
+		!sb_test_iflag(path->mnt->mnt_sb, SB_I_NODEV);
 }
 
 static int may_open(struct mnt_idmap *idmap, const struct path *path,
diff --git a/fs/namespace.c b/fs/namespace.c
index 17126569b3c4..1c5591673f96 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2919,7 +2919,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 	struct super_block *sb = mnt->mnt_sb;
 
 	if (!__mnt_is_readonly(mnt) &&
-	   !sb_test_iflag(sb, _SB_I_TS_EXPIRY_WARNED) &&
+	   !sb_test_iflag(sb, SB_I_TS_EXPIRY_WARNED) &&
 	   (ktime_get_real_seconds() + TIME_UPTIME_SEC_MAX > sb->s_time_max)) {
 		char *buf = (char *)__get_free_page(GFP_KERNEL);
 		char *mntpath = buf ? d_path(mountpoint, buf, PAGE_SIZE) : ERR_PTR(-ENOMEM);
@@ -2931,7 +2931,7 @@ static void mnt_warn_timestamp_expiry(struct path *mountpoint, struct vfsmount *
 			(unsigned long long)sb->s_time_max);
 
 		free_page((unsigned long)buf);
-		sb_set_iflag(sb, _SB_I_TS_EXPIRY_WARNED);
+		sb_set_iflag(sb, SB_I_TS_EXPIRY_WARNED);
 	}
 }
 
@@ -5629,10 +5629,10 @@ static bool mount_too_revealing(const struct super_block *sb, int *new_mnt_flags
 		return false;
 
 	/* Can this filesystem be too revealing? */
-	if (!sb_test_iflag(sb, _SB_I_USERNS_VISIBLE))
+	if (!sb_test_iflag(sb, SB_I_USERNS_VISIBLE))
 		return false;
 
-	if (!sb_test_iflag(sb, _SB_I_NOEXEC) || !sb_test_iflag(sb, _SB_I_NODEV)) {
+	if (!sb_test_iflag(sb, SB_I_NOEXEC) || !sb_test_iflag(sb, SB_I_NODEV)) {
 		WARN_ONCE(1, "Expected s_iflags to contain SB_I_NOEXEC and "
 			  "SB_I_NODEV\n");
 		return true;
diff --git a/fs/nfs/fs_context.c b/fs/nfs/fs_context.c
index 2fbae7e2b6ce..52fc52b6350f 100644
--- a/fs/nfs/fs_context.c
+++ b/fs/nfs/fs_context.c
@@ -1643,7 +1643,7 @@ static int nfs_init_fs_context(struct fs_context *fc)
 		ctx->xprtsec.cert_serial	= TLS_NO_CERT;
 		ctx->xprtsec.privkey_serial	= TLS_NO_PRIVKEY;
 
-		fc->s_iflags		|= 1 << _SB_I_STABLE_WRITES;
+		fc->s_iflags		|= 1 << SB_I_STABLE_WRITES;
 	}
 	fc->fs_private = ctx;
 	fc->ops = &nfs_fs_context_ops;
diff --git a/fs/nfs/super.c b/fs/nfs/super.c
index b6b806fb6286..246ecceda7c8 100644
--- a/fs/nfs/super.c
+++ b/fs/nfs/super.c
@@ -1094,7 +1094,7 @@ static void nfs_fill_super(struct super_block *sb, struct nfs_fs_context *ctx)
 		sb->s_export_op = &nfs_export_ops;
 		break;
 	case 4:
-		sb_set_iflag(sb, _SB_I_NOUMASK);
+		sb_set_iflag(sb, SB_I_NOUMASK);
 		sb->s_time_gran = 1;
 		sb->s_time_min = S64_MIN;
 		sb->s_time_max = S64_MAX;
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index afa5263ff016..f5a60d0bcb1c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1453,14 +1453,14 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 #ifdef CONFIG_FS_POSIX_ACL
 	sb->s_flags |= SB_POSIXACL;
 #endif
-	sb_set_iflag(sb, _SB_I_SKIP_SYNC);
+	sb_set_iflag(sb, SB_I_SKIP_SYNC);
 	/*
 	 * Ensure that umask handling is done by the filesystems used
 	 * for the the upper layer instead of overlayfs as that would
 	 * lead to unexpected results.
 	 */
-	sb_set_iflag(sb, _SB_I_NOUMASK);
-	sb_set_iflag(sb, _SB_I_EVM_HMAC_UNSUPPORTED);
+	sb_set_iflag(sb, SB_I_NOUMASK);
+	sb_set_iflag(sb, SB_I_EVM_HMAC_UNSUPPORTED);
 
 	err = -ENOMEM;
 	root_dentry = ovl_get_root(sb, ctx->upper.dentry, oe);
diff --git a/fs/proc/root.c b/fs/proc/root.c
index ac78ec69dde9..7acfa535b925 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -171,9 +171,9 @@ static int proc_fill_super(struct super_block *s, struct fs_context *fc)
 	proc_apply_options(fs_info, fc, current_user_ns());
 
 	/* User space would break if executables or devices appear on proc */
-	sb_set_iflag(s, _SB_I_USERNS_VISIBLE);
-	sb_set_iflag(s, _SB_I_NOEXEC);
-	sb_set_iflag(s, _SB_I_NODEV);
+	sb_set_iflag(s, SB_I_USERNS_VISIBLE);
+	sb_set_iflag(s, SB_I_NOEXEC);
+	sb_set_iflag(s, SB_I_NODEV);
 	s->s_flags |= SB_NODIRATIME | SB_NOSUID | SB_NOEXEC;
 	s->s_blocksize = 1024;
 	s->s_blocksize_bits = 10;
diff --git a/fs/super.c b/fs/super.c
index e3020b3db4f0..873808245d54 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -355,7 +355,7 @@ static struct super_block *alloc_super(struct file_system_type *type, int flags,
 	s->s_bdi = &noop_backing_dev_info;
 	s->s_flags = flags;
 	if (s->s_user_ns != &init_user_ns)
-		sb_set_iflag(s, _SB_I_NODEV);
+		sb_set_iflag(s, SB_I_NODEV);
 	INIT_HLIST_NODE(&s->s_instances);
 	INIT_HLIST_BL_HEAD(&s->s_roots);
 	mutex_init(&s->s_sync_lock);
@@ -589,11 +589,11 @@ void retire_super(struct super_block *sb)
 {
 	WARN_ON(!sb->s_bdev);
 	__super_lock_excl(sb);
-	if (sb_test_iflag(sb, _SB_I_PERSB_BDI)) {
+	if (sb_test_iflag(sb, SB_I_PERSB_BDI)) {
 		bdi_unregister(sb->s_bdi);
-		sb_clear_iflag(sb, _SB_I_PERSB_BDI);
+		sb_clear_iflag(sb, SB_I_PERSB_BDI);
 	}
-	sb_set_iflag(sb, _SB_I_RETIRED);
+	sb_set_iflag(sb, SB_I_RETIRED);
 	super_unlock_excl(sb);
 }
 EXPORT_SYMBOL(retire_super);
@@ -678,7 +678,7 @@ void generic_shutdown_super(struct super_block *sb)
 	super_wake(sb, SB_DYING);
 	super_unlock_excl(sb);
 	if (sb->s_bdi != &noop_backing_dev_info) {
-		if (sb_test_iflag(sb, _SB_I_PERSB_BDI))
+		if (sb_test_iflag(sb, SB_I_PERSB_BDI))
 			bdi_unregister(sb->s_bdi);
 		bdi_put(sb->s_bdi);
 		sb->s_bdi = &noop_backing_dev_info;
@@ -1331,7 +1331,7 @@ static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
 
 static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
 {
-	return !sb_test_iflag(s, _SB_I_RETIRED) &&
+	return !sb_test_iflag(s, SB_I_RETIRED) &&
 		s->s_dev == *(dev_t *)fc->sget_key;
 }
 
@@ -1584,7 +1584,7 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 	sb->s_bdev = bdev;
 	sb->s_bdi = bdi_get(bdev->bd_disk->bdi);
 	if (bdev_stable_writes(bdev))
-		sb_set_iflag(sb, _SB_I_STABLE_WRITES);
+		sb_set_iflag(sb, SB_I_STABLE_WRITES);
 	spin_unlock(&sb_lock);
 
 	snprintf(sb->s_id, sizeof(sb->s_id), "%pg", bdev);
@@ -1648,7 +1648,7 @@ EXPORT_SYMBOL(get_tree_bdev);
 
 static int test_bdev_super(struct super_block *s, void *data)
 {
-	return !sb_test_iflag(s, _SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
+	return !sb_test_iflag(s, SB_I_RETIRED) && s->s_dev == *(dev_t *)data;
 }
 
 struct dentry *mount_bdev(struct file_system_type *fs_type,
@@ -1864,7 +1864,7 @@ int super_setup_bdi_name(struct super_block *sb, char *fmt, ...)
 	}
 	WARN_ON(sb->s_bdi != &noop_backing_dev_info);
 	sb->s_bdi = bdi;
-	sb_set_iflag(sb, _SB_I_PERSB_BDI);
+	sb_set_iflag(sb, SB_I_PERSB_BDI);
 
 	return 0;
 }
diff --git a/fs/sync.c b/fs/sync.c
index 4e5ad48316be..a7c0645aa9dc 100644
--- a/fs/sync.c
+++ b/fs/sync.c
@@ -79,7 +79,7 @@ static void sync_inodes_one_sb(struct super_block *sb, void *arg)
 
 static void sync_fs_one_sb(struct super_block *sb, void *arg)
 {
-	if (!sb_rdonly(sb) && !sb_test_iflag(sb, _SB_I_SKIP_SYNC) &&
+	if (!sb_rdonly(sb) && !sb_test_iflag(sb, SB_I_SKIP_SYNC) &&
 	    sb->s_op->sync_fs)
 		sb->s_op->sync_fs(sb, *(int *)arg);
 }
diff --git a/fs/sysfs/mount.c b/fs/sysfs/mount.c
index 124385961da7..b461c216731a 100644
--- a/fs/sysfs/mount.c
+++ b/fs/sysfs/mount.c
@@ -33,7 +33,7 @@ static int sysfs_get_tree(struct fs_context *fc)
 		return ret;
 
 	if (kfc->new_sb_created)
-		sb_set_iflag(fc->root->d_sb, _SB_I_USERNS_VISIBLE);
+		sb_set_iflag(fc->root->d_sb, SB_I_USERNS_VISIBLE);
 	return 0;
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 7707f2a1a836..0020724e3b0a 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1701,7 +1701,7 @@ xfs_fs_fill_super(
 		sb->s_time_max = XFS_LEGACY_TIME_MAX;
 	}
 	trace_xfs_inode_timestamp_range(mp, sb->s_time_min, sb->s_time_max);
-	sb_set_iflag(sb, _SB_I_CGROUPWB);
+	sb_set_iflag(sb, SB_I_CGROUPWB);
 
 	set_posix_acl_flag(sb);
 
diff --git a/include/linux/backing-dev.h b/include/linux/backing-dev.h
index 54fdae7b1be4..bc5f96ba499e 100644
--- a/include/linux/backing-dev.h
+++ b/include/linux/backing-dev.h
@@ -176,7 +176,7 @@ static inline bool inode_cgwb_enabled(struct inode *inode)
 	return cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
 		cgroup_subsys_on_dfl(io_cgrp_subsys) &&
 		(bdi->capabilities & BDI_CAP_WRITEBACK) &&
-		sb_test_iflag(inode->i_sb, _SB_I_CGROUPWB);
+		sb_test_iflag(inode->i_sb, SB_I_CGROUPWB);
 }
 
 /**
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 65e70ceb335e..52841aab13fb 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1174,22 +1174,22 @@ extern int send_sigurg(struct fown_struct *fown);
 
 /* sb->s_iflags */
 enum {
-	_SB_I_CGROUPWB,		/* cgroup-aware writeback enabled */
-	_SB_I_NOEXEC,		/* Ignore executables on this fs */
-	_SB_I_NODEV,		/* Ignore devices on this fs */
-	_SB_I_STABLE_WRITES,	/* don't modify blks until WB is done */
+	SB_I_CGROUPWB,		/* cgroup-aware writeback enabled */
+	SB_I_NOEXEC,		/* Ignore executables on this fs */
+	SB_I_NODEV,		/* Ignore devices on this fs */
+	SB_I_STABLE_WRITES,	/* don't modify blks until WB is done */
 
 	/* sb->s_iflags to limit user namespace mounts */
-	_SB_I_USERNS_VISIBLE,	/* fstype already mounted */
-	_SB_I_IMA_UNVERIFIABLE_SIGNATURE,
-	_SB_I_UNTRUSTED_MOUNTER,
-	_SB_I_EVM_HMAC_UNSUPPORTED,
-
-	_SB_I_SKIP_SYNC,	/* Skip superblock at global sync */
-	_SB_I_PERSB_BDI,	/* has a per-sb bdi */
-	_SB_I_TS_EXPIRY_WARNED,	/* warned about timestamp range expiry */
-	_SB_I_RETIRED,		/* superblock shouldn't be reused */
-	_SB_I_NOUMASK,		/* VFS does not apply umask */
+	SB_I_USERNS_VISIBLE,	/* fstype already mounted */
+	SB_I_IMA_UNVERIFIABLE_SIGNATURE,
+	SB_I_UNTRUSTED_MOUNTER,
+	SB_I_EVM_HMAC_UNSUPPORTED,
+
+	SB_I_SKIP_SYNC,	/* Skip superblock at global sync */
+	SB_I_PERSB_BDI,	/* has a per-sb bdi */
+	SB_I_TS_EXPIRY_WARNED,	/* warned about timestamp range expiry */
+	SB_I_RETIRED,		/* superblock shouldn't be reused */
+	SB_I_NOUMASK,		/* VFS does not apply umask */
 };
 
 /* Possible states of 'frozen' field */
diff --git a/include/linux/namei.h b/include/linux/namei.h
index 3fbf340dac1a..0bd6db9adb7f 100644
--- a/include/linux/namei.h
+++ b/include/linux/namei.h
@@ -107,7 +107,7 @@ extern void unlock_rename(struct dentry *, struct dentry *);
  */
 static inline umode_t __must_check mode_strip_umask(const struct inode *dir, umode_t mode)
 {
-	if (!IS_POSIXACL(dir) && !sb_test_iflag(dir->i_sb, _SB_I_NOUMASK))
+	if (!IS_POSIXACL(dir) && !sb_test_iflag(dir->i_sb, SB_I_NOUMASK))
 		mode &= ~current_umask();
 	return mode;
 }
diff --git a/ipc/mqueue.c b/ipc/mqueue.c
index e73fff4c2f12..abe4dfe4374c 100644
--- a/ipc/mqueue.c
+++ b/ipc/mqueue.c
@@ -406,8 +406,8 @@ static int mqueue_fill_super(struct super_block *sb, struct fs_context *fc)
 	struct inode *inode;
 	struct ipc_namespace *ns = sb->s_fs_info;
 
-	sb_set_iflag(sb, _SB_I_NOEXEC);
-	sb_set_iflag(sb, _SB_I_NODEV);
+	sb_set_iflag(sb, SB_I_NOEXEC);
+	sb_set_iflag(sb, SB_I_NODEV);
 	sb->s_blocksize = PAGE_SIZE;
 	sb->s_blocksize_bits = PAGE_SHIFT;
 	sb->s_magic = MQUEUE_MAGIC;
diff --git a/security/integrity/evm/evm_main.c b/security/integrity/evm/evm_main.c
index 3ff29bf73f04..a15a87250d55 100644
--- a/security/integrity/evm/evm_main.c
+++ b/security/integrity/evm/evm_main.c
@@ -155,7 +155,7 @@ static int is_unsupported_hmac_fs(struct dentry *dentry)
 {
 	struct inode *inode = d_backing_inode(dentry);
 
-	if (sb_test_iflag(inode->i_sb, _SB_I_EVM_HMAC_UNSUPPORTED)) {
+	if (sb_test_iflag(inode->i_sb, SB_I_EVM_HMAC_UNSUPPORTED)) {
 		pr_info_once("%s not supported\n", inode->i_sb->s_type->name);
 		return 1;
 	}
diff --git a/security/integrity/ima/ima_appraise.c b/security/integrity/ima/ima_appraise.c
index 9c290dd8a4ac..dfa16dba5d89 100644
--- a/security/integrity/ima/ima_appraise.c
+++ b/security/integrity/ima/ima_appraise.c
@@ -564,8 +564,8 @@ int ima_appraise_measurement(enum ima_hooks func, struct ima_iint_cache *iint,
 	 * system not willing to accept such a risk, fail the file signature
 	 * verification.
 	 */
-	if (sb_test_iflag(inode->i_sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
-	    (sb_test_iflag(inode->i_sb, _SB_I_UNTRUSTED_MOUNTER) ||
+	if (sb_test_iflag(inode->i_sb, SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
+	    (sb_test_iflag(inode->i_sb, SB_I_UNTRUSTED_MOUNTER) ||
 	     (iint->flags & IMA_FAIL_UNVERIFIABLE_SIGS))) {
 		status = INTEGRITY_FAIL;
 		cause = "unverifiable-signature";
diff --git a/security/integrity/ima/ima_main.c b/security/integrity/ima/ima_main.c
index b04eaa33eca4..27d446136c4f 100644
--- a/security/integrity/ima/ima_main.c
+++ b/security/integrity/ima/ima_main.c
@@ -280,8 +280,8 @@ static int process_measurement(struct file *file, const struct cred *cred,
 	 * (Limited to privileged mounted filesystems.)
 	 */
 	if (test_and_clear_bit(IMA_CHANGE_XATTR, &iint->atomic_flags) ||
-	    (sb_test_iflag(inode->i_sb, _SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
-	     !sb_test_iflag(inode->i_sb, _SB_I_UNTRUSTED_MOUNTER) &&
+	    (sb_test_iflag(inode->i_sb, SB_I_IMA_UNVERIFIABLE_SIGNATURE) &&
+	     !sb_test_iflag(inode->i_sb, SB_I_UNTRUSTED_MOUNTER) &&
 	     !(action & IMA_FAIL_UNVERIFIABLE_SIGS))) {
 		iint->flags &= ~IMA_DONE_MASK;
 		iint->measured_pcrs = 0;
-- 
2.35.3



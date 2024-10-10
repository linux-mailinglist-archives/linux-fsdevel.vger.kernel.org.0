Return-Path: <linux-fsdevel+bounces-31632-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C88E99992DC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 21:44:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 859FE288196
	for <lists+linux-fsdevel@lfdr.de>; Thu, 10 Oct 2024 19:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4423D1EF923;
	Thu, 10 Oct 2024 19:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="gE5p1QiS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24ED1CFEA1;
	Thu, 10 Oct 2024 19:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728589294; cv=none; b=uiHEDkesWdicHuvMbFuBFs7t5/Iui7z80molnRS+ygNDM/8SxzBoAJno/gwdhK2DDTlD0YZzRRoCvrJD15OgQd9FnOJYw7L+V3tM6ex8C6vZg/lEtLfbVFlxnpiqFi32R+T1tWGlNvOaa2b/+I2U4MH9LDKL+AW7qy5D0g2wqCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728589294; c=relaxed/simple;
	bh=7pXL8LHCYcsxCKV3KTzPhhYBPQKOJZ85ua6LTenmvTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LMSSJHTL3cLSu+u56G+YK0DcdpQgx9kOuKfPsqTYifPLLGZS068ZGQQmNKM+519UBUOa2GZduypyXReOj6w6qvbVJnGLN26jfiOpPpGR0BXtuBShzVZZtfPEUmwP/3PwIf3Ig2Vq39DV63lEb0hTmI60WaiHBfVJy9lvG+paNxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=gE5p1QiS; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=XHdi9hQBqFVnhv7IC8o5GpggjJLpirJi3kfx0QcBzok=; b=gE5p1QiSfllJwSdRlI3HsbrVUd
	dtP0npquWm+YKdZfvs/6gWGWPskTAFQ0ggKlYH/6lq/Wmw/PQFwprLaLQUb9BmkeX2+dlJDVpcQnB
	wJISy6+Mp6uah+0j5yKvfVDEFFqfW7Kp5af+e7ihAxw7sLH5frwf1pEVByIb3C3jTxeDkYm+6NBPo
	+UtMCfWckcf+Y9QTYIY/tAFlWTz/34RtQWZGRQfCNzBN8Rj83qbenVje5NjDZo/w327yh+GXUYsLR
	VFvkutrJUSo6HOh5NfvCXk46jwOVvfH3fOrIWvCzDAmCQ6AW1azHAPTUha3yKGhj0FlA7UlxAg+hP
	/J3MwBZQ==;
Received: from [187.57.199.212] (helo=[192.168.15.100])
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1syz2P-007SHz-ER; Thu, 10 Oct 2024 21:41:29 +0200
From: =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
Date: Thu, 10 Oct 2024 16:39:42 -0300
Subject: [PATCH v6 07/10] tmpfs: Add casefold lookup support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241010-tonyk-tmpfs-v6-7-79f0ae02e4c8@igalia.com>
References: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
In-Reply-To: <20241010-tonyk-tmpfs-v6-0-79f0ae02e4c8@igalia.com>
To: Gabriel Krisman Bertazi <krisman@kernel.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>, 
 Hugh Dickins <hughd@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, smcv@collabora.com
Cc: kernel-dev@igalia.com, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org, 
 linux-mm@kvack.org, linux-doc@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>
X-Mailer: b4 0.14.2

Enable casefold lookup in tmpfs, based on the encoding defined by
userspace. That means that instead of comparing byte per byte a file
name, it compares to a case-insensitive equivalent of the Unicode
string.

* Dcache handling

There's a special need when dealing with case-insensitive dentries.
First of all, we currently invalidated every negative casefold dentries.
That happens because currently VFS code has no proper support to deal
with that, giving that it could incorrectly reuse a previous filename
for a new file that has a casefold match. For instance, this could
happen:

$ mkdir DIR
$ rm -r DIR
$ mkdir dir
$ ls
DIR/

And would be perceived as inconsistency from userspace point of view,
because even that we match files in a case-insensitive manner, we still
honor whatever is the initial filename.

Along with that, tmpfs stores only the first equivalent name dentry used
in the dcache, preventing duplications of dentries in the dcache. The
d_compare() version for casefold files uses a normalized string, so the
filename under lookup will be compared to another normalized string for
the existing file, achieving a casefolded lookup.

* Enabling casefold via mount options

Most filesystems have their data stored in disk, so casefold option need
to be enabled when building a filesystem on a device (via mkfs).
However, as tmpfs is a RAM backed filesystem, there's no disk
information and thus no mkfs to store information about casefold.

For tmpfs, create casefold options for mounting. Userspace can then
enable casefold support for a mount point using:

$ mount -t tmpfs -o casefold=utf8-12.1.0 fs_name mount_dir/

Userspace must set what Unicode standard is aiming to. The available
options depends on what the kernel Unicode subsystem supports.

And for strict encoding:

$ mount -t tmpfs -o casefold=utf8-12.1.0,strict_encoding fs_name mount_dir/

Strict encoding means that tmpfs will refuse to create invalid UTF-8
sequences. When this option is not enabled, any invalid sequence will be
treated as an opaque byte sequence, ignoring the encoding thus not being
able to be looked up in a case-insensitive way.

* Check for casefold dirs on simple_lookup()

On simple_lookup(), do not create dentries for casefold directories.
Currently, VFS does not support case-insensitive negative dentries and
can create inconsistencies in the filesystem. Prevent such dentries to
being created in the first place.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v4:
- Squash commit Check for casefold dirs on simple_lookup() here
- Fails to mount if strict_encoding is used without encoding
- tmpfs doesn't support fscrypt, so I dropped d_revalidate line

Changes from v3:
- Simplified shmem_parse_opt_casefold()
- sb->s_d_op is set to shmem_ci_dentry_ops during mount time
- got rid of shmem_lookup(), modified simple_lookup()

Changes from v2:
- simple_lookup() now sets d_ops
- reworked shmem_parse_opt_casefold()
- if `mount -o casefold` has no param, load latest UTF-8 version
- using (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir) when possible
---
 fs/libfs.c |   4 +++
 mm/shmem.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 7b290404c5f9901010ada2f921a214dbc94eb5fa..a168ece5cc61b74114f537f5b7b8a07f2d48b2aa 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -77,6 +77,10 @@ struct dentry *simple_lookup(struct inode *dir, struct dentry *dentry, unsigned
 		return ERR_PTR(-ENAMETOOLONG);
 	if (!dentry->d_sb->s_d_op)
 		d_set_d_op(dentry, &simple_dentry_operations);
+
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		return NULL;
+
 	d_add(dentry, NULL);
 	return NULL;
 }
diff --git a/mm/shmem.c b/mm/shmem.c
index 162d68784309bdfb8772aa9ba3ccc360780395fd..935e824990799d927098fd88ebaba384a6284f42 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -40,6 +40,7 @@
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
+#include <linux/unicode.h>
 #include "swap.h"
 
 static struct vfsmount *shm_mnt __ro_after_init;
@@ -123,6 +124,8 @@ struct shmem_options {
 	bool noswap;
 	unsigned short quota_types;
 	struct shmem_quota_limits qlimits;
+	struct unicode_map *encoding;
+	bool strict_encoding;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
@@ -3574,6 +3577,9 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
+	if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
+		return -EINVAL;
+
 	error = simple_acl_create(dir, inode);
 	if (error)
 		goto out_iput;
@@ -3589,7 +3595,12 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
-	d_instantiate(dentry, inode);
+
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		d_add(dentry, inode);
+	else
+		d_instantiate(dentry, inode);
+
 	dget(dentry); /* Extra count - pin the dentry in core */
 	return error;
 
@@ -3680,7 +3691,10 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir,
 	inc_nlink(inode);
 	ihold(inode);	/* New dentry reference */
 	dget(dentry);	/* Extra pinning count for the created dentry */
-	d_instantiate(dentry, inode);
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		d_add(dentry, inode);
+	else
+		d_instantiate(dentry, inode);
 out:
 	return ret;
 }
@@ -3700,6 +3714,14 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	inode_inc_iversion(dir);
 	drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - does all the work */
+
+	/*
+	 * For now, VFS can't deal with case-insensitive negative dentries, so
+	 * we invalidate them
+	 */
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		d_invalidate(dentry);
+
 	return 0;
 }
 
@@ -3844,7 +3866,10 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
-	d_instantiate(dentry, inode);
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		d_add(dentry, inode);
+	else
+		d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
 
@@ -4197,6 +4222,9 @@ enum shmem_param {
 	Opt_usrquota_inode_hardlimit,
 	Opt_grpquota_block_hardlimit,
 	Opt_grpquota_inode_hardlimit,
+	Opt_casefold_version,
+	Opt_casefold,
+	Opt_strict_encoding,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -4228,9 +4256,54 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit),
 	fsparam_string("grpquota_inode_hardlimit", Opt_grpquota_inode_hardlimit),
 #endif
+	fsparam_string("casefold",	Opt_casefold_version),
+	fsparam_flag  ("casefold",	Opt_casefold),
+	fsparam_flag  ("strict_encoding", Opt_strict_encoding),
 	{}
 };
 
+#if IS_ENABLED(CONFIG_UNICODE)
+static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param,
+				    bool latest_version)
+{
+	struct shmem_options *ctx = fc->fs_private;
+	unsigned int version = UTF8_LATEST;
+	struct unicode_map *encoding;
+	char *version_str = param->string + 5;
+
+	if (!latest_version) {
+		if (strncmp(param->string, "utf8-", 5))
+			return invalfc(fc, "Only UTF-8 encodings are supported "
+				       "in the format: utf8-<version number>");
+
+		version = utf8_parse_version(version_str);
+		if (version < 0)
+			return invalfc(fc, "Invalid UTF-8 version: %s", version_str);
+	}
+
+	encoding = utf8_load(version);
+
+	if (IS_ERR(encoding)) {
+		return invalfc(fc, "Failed loading UTF-8 version: utf8-%u.%u.%u\n",
+			       unicode_major(version), unicode_minor(version),
+			       unicode_rev(version));
+	}
+
+	pr_info("tmpfs: Using encoding : utf8-%u.%u.%u\n",
+		unicode_major(version), unicode_minor(version), unicode_rev(version));
+
+	ctx->encoding = encoding;
+
+	return 0;
+}
+#else
+static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param,
+				    bool latest_version)
+{
+	return invalfc(fc, "tmpfs: Kernel not built with CONFIG_UNICODE\n");
+}
+#endif
+
 static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct shmem_options *ctx = fc->fs_private;
@@ -4389,6 +4462,13 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 				       "Group quota inode hardlimit too large.");
 		ctx->qlimits.grpquota_ihardlimit = size;
 		break;
+	case Opt_casefold_version:
+		return shmem_parse_opt_casefold(fc, param, false);
+	case Opt_casefold:
+		return shmem_parse_opt_casefold(fc, param, true);
+	case Opt_strict_encoding:
+		ctx->strict_encoding = true;
+		break;
 	}
 	return 0;
 
@@ -4618,6 +4698,11 @@ static void shmem_put_super(struct super_block *sb)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb->s_encoding)
+		utf8_unload(sb->s_encoding);
+#endif
+
 #ifdef CONFIG_TMPFS_QUOTA
 	shmem_disable_quotas(sb);
 #endif
@@ -4628,6 +4713,14 @@ static void shmem_put_super(struct super_block *sb)
 	sb->s_fs_info = NULL;
 }
 
+#if IS_ENABLED(CONFIG_UNICODE) && defined(CONFIG_TMPFS)
+static const struct dentry_operations shmem_ci_dentry_ops = {
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
+	.d_delete = always_delete_dentry,
+};
+#endif
+
 static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct shmem_options *ctx = fc->fs_private;
@@ -4663,10 +4756,24 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	sb->s_export_op = &shmem_export_ops;
 	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
 
-	sb->s_d_op = &simple_dentry_operations;
+	if (!ctx->encoding && ctx->strict_encoding) {
+		pr_err("tmpfs: strict_encoding option without encoding is forbidden\n");
+		error = -EINVAL;
+		goto failed;
+	}
+
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (ctx->encoding) {
+		sb->s_encoding = ctx->encoding;
+		sb->s_d_op = &shmem_ci_dentry_ops;
+		if (ctx->strict_encoding)
+			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
+	}
+#endif
+
 #else
 	sb->s_flags |= SB_NOUSER;
-#endif
+#endif /* CONFIG_TMPFS */
 	sbinfo->max_blocks = ctx->blocks;
 	sbinfo->max_inodes = ctx->inodes;
 	sbinfo->free_ispace = sbinfo->max_inodes * BOGO_INODE_SIZE;
@@ -4940,6 +5047,8 @@ int shmem_init_fs_context(struct fs_context *fc)
 	ctx->uid = current_fsuid();
 	ctx->gid = current_fsgid();
 
+	ctx->encoding = NULL;
+
 	fc->fs_private = ctx;
 	fc->ops = &shmem_fs_context_ops;
 	return 0;

-- 
2.47.0



Return-Path: <linux-fsdevel+bounces-30820-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7253998E751
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Oct 2024 01:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDFA28865C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2024 23:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5F71C9B6B;
	Wed,  2 Oct 2024 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="WQXH2dH+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F0E1C7B7F;
	Wed,  2 Oct 2024 23:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727912740; cv=none; b=K0JuO8CZF5qB5U3NEf5nvb1fTiUqNHpkX/BT+QixITF983nBSu/ASae3FQn2Y9TVn9BzZnpCG5Co81gaYRjF3fWAIXYJXmvG9gwQmcW6lUtOoGMLY/VcfoOTOEK2DL3BbKz9XYnlWcO0cZsjb8V/w6LJKYRMl7B69dV+F4iCeyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727912740; c=relaxed/simple;
	bh=Sa+//KaquEMlmqekUsr7aQ/KhcNfYjdlVFv0NcFuJyM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uq1/H54tsDQcdKSwB7JHxAZhg3eEX+hy+uMocMLZU+BosxyPd2EiwaG4ADBpgdxWR6I4qau0HJBXaSi0yPVxFir1hsX4UhGhKyaHfP2nBs7LYY5fdLsRniZr41RRlFHXhtaJUfqosBdC3VKEGrU/my6jODPNFbZiZNjE95Hv5gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=WQXH2dH+; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=a44X2hLHZHM6OEDMyxUHO1xVlMNMtLmqduY2AzXe0HA=; b=WQXH2dH+S1J9YIo6G0O001t96K
	J5FiSqTRu2ts8uBrtgp7+vm3sVcL9rJDY2x0K3cGx0tLF2Ft8sN50OJWFJcCUMEIb4ihwv8K83qM8
	j0xJsAd3Soy2U8p9+uTvqu3je5yS0dTvCMbNI+a0qCv2RdNc5vMRf6HUKVi7/9AFPRAH6VhN0jVsU
	06lFGMoUusQhHd11deSJT7hrzmEnZL0BuygM2JU6jq00BJlXr+cHiH/H0A6DWH+/ytKWn8tcGTkLp
	oibfaKgYymHDk8q/Q2s0PJDOYvePUNM2Xc0QJkgrTVO4pWIvjc/5WtudxD3RCYRa9sS5UDJwtuCdV
	YOAVB09g==;
Received: from [187.57.199.212] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sw928-0045tc-SR; Thu, 03 Oct 2024 01:45:29 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	krisman@kernel.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	Christoph Hellwig <hch@lst.de>,
	Theodore Ts'o <tytso@mit.edu>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH v5 07/10] tmpfs: Add casefold lookup support
Date: Wed,  2 Oct 2024 20:44:41 -0300
Message-ID: <20241002234444.398367-8-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20241002234444.398367-1-andrealmeid@igalia.com>
References: <20241002234444.398367-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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
 fs/libfs.c |   4 ++
 mm/shmem.c | 119 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 118 insertions(+), 5 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 7b290404c5f9..a168ece5cc61 100644
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
index 162d68784309..3c8c7b34632a 100644
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
 
+#if IS_ENABLED(CONFIG_UNICODE)
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
2.46.0



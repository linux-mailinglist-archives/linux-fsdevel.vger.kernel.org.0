Return-Path: <linux-fsdevel+bounces-28780-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E1996E2A3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 21:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9FDF289251
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Sep 2024 19:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91800188A2D;
	Thu,  5 Sep 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="Gwu+S2WV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA481A7279;
	Thu,  5 Sep 2024 19:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725563025; cv=none; b=gaLG+2uYXsKxe47hIkcdiWuerabQzr6wp4oGjJb/A4WZZFRRI7jIPikyarG45hyBXSixXD3L9QGL+BtJEHSKjHJNEjXznphuZau954+8o+LzF1yLKZyV5zcX19/2dwUMnCQx57oy6jwCQqC3H+1Qwot1krRdnVRfhzJQx/QW+ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725563025; c=relaxed/simple;
	bh=nHowrrVHa+XhQ3FqfDk+/Gjl455uB5B4EGoL0f3auUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZE/mbRl9KQ3wuoAISCNWqb8JSUqPxXIYX4BTTp08FD/3WZ6GcWhr8dawVJRncU0lVcLR/y2llcYzO5x24sBX+w0l2tYdBqQiTxVTWlbw2ZeQ7jCEnkWt9SevKdGADXDIhIB6t9IrtW5NVdhvCcyTuk/Lvf3CMYdtht4RNl4E8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=Gwu+S2WV; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=VmzlgsaYZjrrC3mQ36z6wkF/DubU3LiA5Bepzx0864k=; b=Gwu+S2WVVmZsGxvWLl052l/1q2
	ltwU0NqVeVAHvuF2fa+ccjSMlRW1/+fl/1eN/6Uhmtl2GytsBpiHQtvU+Oow+lRmw65qbc37/GLKI
	EpfNSdteKTgZS9kAcMhehkpSuoXX9gcHHBNXH0pxrFmsdQbyf2ZHXfKfhqINt/lQTFvVmiXHH0im1
	mI7rw2jvvohjfLB2GOI8sGUNPd08QRa1z7/FtLFANYvOrN4/29SG5zO8iyDvzVYhkoJ8l2Fj8qZEX
	ig8krXC81tItgy+rPSU/ButQMUqhAvqdhIW6l+kaVSFoNMv1PQvhQ2S5wntStcW/+6g6fzYWRczK3
	0fHuQOpg==;
Received: from [177.172.122.98] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1smHlW-00A6Ho-6D; Thu, 05 Sep 2024 21:03:34 +0200
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
Subject: [PATCH v3 6/9] tmpfs: Add casefold lookup support
Date: Thu,  5 Sep 2024 16:02:49 -0300
Message-ID: <20240905190252.461639-7-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905190252.461639-1-andrealmeid@igalia.com>
References: <20240905190252.461639-1-andrealmeid@igalia.com>
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

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
Changes from v2:
- shmem_lookup() now sets d_ops
- reworked shmem_parse_opt_casefold()
- if `mount -o casefold` has no param, load latest UTF-8 version
- using (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir) when possible
---
 mm/shmem.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 4 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..6b61fc5dc0b1 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -40,6 +40,8 @@
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
+#include <linux/unicode.h>
+#include <linux/parser.h>
 #include "swap.h"
 
 static struct vfsmount *shm_mnt __ro_after_init;
@@ -123,6 +125,8 @@ struct shmem_options {
 	bool noswap;
 	unsigned short quota_types;
 	struct shmem_quota_limits qlimits;
+	struct unicode_map *encoding;
+	bool strict_encoding;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
@@ -3427,6 +3431,10 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
+	if (IS_ENABLED(CONFIG_UNICODE))
+		if (!generic_ci_validate_strict_name(dir, &dentry->d_name))
+			return -EINVAL;
+
 	error = simple_acl_create(dir, inode);
 	if (error)
 		goto out_iput;
@@ -3442,7 +3450,12 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
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
 
@@ -3533,7 +3546,10 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir,
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
@@ -3553,6 +3569,14 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
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
 
@@ -3697,7 +3721,10 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
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
 
@@ -4050,6 +4077,9 @@ enum shmem_param {
 	Opt_usrquota_inode_hardlimit,
 	Opt_grpquota_block_hardlimit,
 	Opt_grpquota_inode_hardlimit,
+	Opt_casefold_version,
+	Opt_casefold,
+	Opt_strict_encoding,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -4081,9 +4111,62 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
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
+	unsigned int maj = 0, min = 0, rev = 0, version = 0;
+	struct unicode_map *encoding;
+	char *version_str = param->string + 5;
+	int ret;
+
+	if (latest_version) {
+		version = UTF8_LATEST;
+	} else {
+		if (strncmp(param->string, "utf8-", 5))
+			return invalfc(fc, "Only UTF-8 encodings are supported "
+				       "in the format: utf8-<version number>");
+
+		ret = utf8_parse_version(version_str, &maj, &min, &rev);
+		if (ret)
+			return invalfc(fc, "Invalid UTF-8 version: %s", version_str);
+
+		version = UNICODE_AGE(maj, min, rev);
+	}
+
+	encoding = utf8_load(version);
+
+	if (IS_ERR(encoding)) {
+		if (latest_version)
+			return invalfc(fc, "Failed loading latest UTF-8 version");
+		else
+			return invalfc(fc, "Failed loading UTF-8 version: %s", version_str);
+	}
+
+	if (latest_version)
+		pr_info("tmpfs: Using the latest UTF-8 version available");
+	else
+		pr_info("tmpfs: Using encoding provided by mount options: %s\n", param->string);
+
+	ctx->encoding = encoding;
+
+	return 0;
+}
+#else
+static int shmem_parse_opt_casefold(struct fs_context *fc, struct fs_parameter *param,
+				    bool latest_version)
+{
+	return invalfc(fc, "tmpfs: No kernel support for casefold filesystems\n");
+}
+#endif
+
 static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct shmem_options *ctx = fc->fs_private;
@@ -4242,6 +4325,13 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
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
 
@@ -4471,6 +4561,11 @@ static void shmem_put_super(struct super_block *sb)
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
@@ -4515,6 +4610,16 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_export_op = &shmem_export_ops;
 	sb->s_flags |= SB_NOSEC | SB_I_VERSION;
+
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (ctx->encoding) {
+		sb->s_encoding = ctx->encoding;
+		generic_set_sb_d_ops(sb);
+		if (ctx->strict_encoding)
+			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
+	}
+#endif
+
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
@@ -4704,11 +4809,38 @@ static const struct inode_operations shmem_inode_operations = {
 #endif
 };
 
+static struct dentry *shmem_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
+{
+	const struct dentry_operations *d_ops = &simple_dentry_operations;
+
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (dentry->d_sb->s_encoding)
+		d_ops = &generic_ci_always_del_dentry_ops;
+#endif
+
+	if (dentry->d_name.len > NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	if (!dentry->d_sb->s_d_op)
+		d_set_d_op(dentry, d_ops);
+
+	/*
+	 * For now, VFS can't deal with case-insensitive negative dentries, so
+	 * we prevent them from being created
+	 */
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+		return NULL;
+
+	d_add(dentry, NULL);
+
+	return NULL;
+}
+
 static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
 	.getattr	= shmem_getattr,
 	.create		= shmem_create,
-	.lookup		= simple_lookup,
+	.lookup		= shmem_lookup,
 	.link		= shmem_link,
 	.unlink		= shmem_unlink,
 	.symlink	= shmem_symlink,
@@ -4791,6 +4923,8 @@ int shmem_init_fs_context(struct fs_context *fc)
 	ctx->uid = current_fsuid();
 	ctx->gid = current_fsgid();
 
+	ctx->encoding = NULL;
+
 	fc->fs_private = ctx;
 	fc->ops = &shmem_fs_context_ops;
 	return 0;
-- 
2.46.0



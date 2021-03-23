Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5473C346971
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 Mar 2021 21:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232993AbhCWUAk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 Mar 2021 16:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhCWUAJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 Mar 2021 16:00:09 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61626C061574;
        Tue, 23 Mar 2021 13:00:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 6A9991F44DB3
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     krisman@collabora.com, smcv@collabora.com, kernel@collabora.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Daniel Rosenberg <drosen@google.com>,
        =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [RFC PATCH 2/4] mm: shmem: Support case-insensitive file name lookups
Date:   Tue, 23 Mar 2021 16:59:39 -0300
Message-Id: <20210323195941.69720-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210323195941.69720-1-andrealmeid@collabora.com>
References: <20210323195941.69720-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch implements the support for case-insensitive file name lookups
in tmpfs, based on the encoding passed in the mount options.

A filesystem that has the casefold feature set is able to configure
directories with the +F (TMPFS_CASEFOLD_FL) attribute, enabling lookups
to succeed in that directory in a case-insensitive fashion, i.e: match
a directory entry even if the name used by userspace is not a byte per
byte match with the disk name, but is an equivalent case-insensitive
version of the Unicode string. This operation is called a
case-insensitive file name lookup.

The feature is configured as an inode attribute applied to directories
and inherited by its children. This attribute can only be enabled on
empty directories for filesystems that support the encoding feature,
thus preventing collision of file names that only differ by case.

* dcache handling:

For a +F directory, tmpfs only stores the first equivalent name dentry
used in the dcache. This is done to prevent unintentional duplication of
dentries in the dcache, while also allowing the VFS code to quickly find
the right entry in the cache despite which equivalent string was used in
a previous lookup, without having to resort to ->lookup().

d_hash() of casefolded directories is implemented as the hash of the
casefolded string, such that we always have a well-known bucket for all
the equivalencies of the same string. d_compare() uses the
utf8_strncasecmp() infrastructure, which handles the comparison of
equivalent, same case, names as well.

For now, negative lookups are not inserted in the dcache, since they
would need to be invalidated anyway, because we can't trust missing file
dentries. This is bad for performance but requires some leveraging of
the VFS layer to fix. We can live without that for now, and so does
everyone else.

The lookup() path at tmpfs creates negatives dentries, that are later
instantiated if the file is created. In that way, all files in tmpfs
have a dentry given that the filesystem exists exclusively in memory.
As explained above, we don't have negative dentries for casefold files,
so dentries are created at lookup() iff files aren't casefolded. Else,
the dentry is created just before being instantiated at create path.
At the remove path, dentries are invalidated for casefolded files.

* Dealing with invalid sequences:

By default, when an invalid UTF-8 sequence is identified, tmpfs will treat
it as an opaque byte sequence, ignoring the encoding and reverting to
the old behavior for that unique file. This means that case-insensitive
file name lookup will not work only for that file. An optional flag
(cf_strict) can be set in the mount arguments telling the filesystem
code and userspace tools to enforce the encoding. When that optional
flag is set, any attempt to create a file name using an invalid UTF-8
sequence will fail and return an error to userspace.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 91 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index d82b6f396588..29ee64352807 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -43,6 +43,7 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+	bool casefold;              /* If this mount point supports casefolding */
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/mm/shmem.c b/mm/shmem.c
index b2db4ed0fbc7..20df81763995 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -38,6 +38,7 @@
 #include <linux/hugetlb.h>
 #include <linux/frontswap.h>
 #include <linux/fs_parser.h>
+#include <linux/unicode.h>
 
 #include <asm/tlbflush.h> /* for arch/microblaze update_mmu_cache() */
 
@@ -117,6 +118,8 @@ struct shmem_options {
 	bool full_inums;
 	int huge;
 	int seen;
+	struct unicode_map *encoding;
+	bool cf_strict;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
@@ -161,6 +164,13 @@ static inline struct shmem_sb_info *SHMEM_SB(struct super_block *sb)
 	return sb->s_fs_info;
 }
 
+#ifdef CONFIG_UNICODE
+static const struct dentry_operations casefold_dentry_ops = {
+	.d_hash = generic_ci_d_hash,
+	.d_compare = generic_ci_d_compare,
+};
+#endif
+
 /*
  * shmem_file_setup pre-accounts the whole fixed size of a VM object,
  * for shared memory and for shared anonymous (/dev/zero) mappings
@@ -2859,8 +2869,18 @@ shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 	struct inode *inode;
 	int error = -ENOSPC;
 
+#ifdef CONFIG_UNICODE
+	struct super_block *sb = dir->i_sb;
+
+	if (sb_has_strict_encoding(sb) && IS_CASEFOLDED(dir) &&
+	    sb->s_encoding && utf8_validate(sb->s_encoding, &dentry->d_name))
+		return -EINVAL;
+#endif
+
 	inode = shmem_get_inode(dir->i_sb, dir, mode, dev, VM_NORESERVE);
 	if (inode) {
+		inode->i_flags |= dir->i_flags;
+
 		error = simple_acl_create(dir, inode);
 		if (error)
 			goto out_iput;
@@ -2870,6 +2890,9 @@ shmem_mknod(struct user_namespace *mnt_userns, struct inode *dir,
 		if (error && error != -EOPNOTSUPP)
 			goto out_iput;
 
+		if (IS_CASEFOLDED(dir))
+			d_add(dentry, NULL);
+
 		error = 0;
 		dir->i_size += BOGO_DIRENT_SIZE;
 		dir->i_ctime = dir->i_mtime = current_time(dir);
@@ -2925,6 +2948,19 @@ static int shmem_create(struct user_namespace *mnt_userns, struct inode *dir,
 	return shmem_mknod(&init_user_ns, dir, dentry, mode | S_IFREG, 0);
 }
 
+static struct dentry *shmem_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
+{
+	if (dentry->d_name.len > NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	if (IS_CASEFOLDED(dir))
+		return NULL;
+
+	d_add(dentry, NULL);
+
+	return NULL;
+}
+
 /*
  * Link a file..
  */
@@ -2946,6 +2982,9 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 			goto out;
 	}
 
+	if (IS_CASEFOLDED(dir))
+		d_add(dentry, NULL);
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	inc_nlink(inode);
@@ -2967,6 +3006,10 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
 	drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
+
+	if (IS_CASEFOLDED(dir))
+		d_invalidate(dentry);
+
 	return 0;
 }
 
@@ -3128,6 +3171,8 @@ static int shmem_symlink(struct user_namespace *mnt_userns, struct inode *dir,
 	}
 	dir->i_size += BOGO_DIRENT_SIZE;
 	dir->i_ctime = dir->i_mtime = current_time(dir);
+	if (IS_CASEFOLDED(dir))
+		d_add(dentry, NULL);
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
@@ -3364,6 +3409,8 @@ enum shmem_param {
 	Opt_uid,
 	Opt_inode32,
 	Opt_inode64,
+	Opt_casefold,
+	Opt_cf_strict,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3385,6 +3432,8 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_u32   ("uid",		Opt_uid),
 	fsparam_flag  ("inode32",	Opt_inode32),
 	fsparam_flag  ("inode64",	Opt_inode64),
+	fsparam_string("casefold",	Opt_casefold),
+	fsparam_flag  ("cf_strict",	Opt_cf_strict),
 	{}
 };
 
@@ -3392,9 +3441,11 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct shmem_options *ctx = fc->fs_private;
 	struct fs_parse_result result;
+	struct unicode_map *encoding;
 	unsigned long long size;
+	char version[10];
 	char *rest;
-	int opt;
+	int opt, ret;
 
 	opt = fs_parse(fc, shmem_fs_parameters, param, &result);
 	if (opt < 0)
@@ -3468,6 +3519,23 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->full_inums = true;
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
+	case Opt_casefold:
+		if (strncmp(param->string, "utf8-", 5))
+			return invalfc(fc, "Only utf8 encondings are supported");
+		ret = strscpy(version, param->string + 5, sizeof(version));
+		if (ret < 0)
+			return invalfc(fc, "Invalid enconding argument: %s", param->string);
+
+		encoding = utf8_load(version);
+		if (IS_ERR(encoding))
+			return invalfc(fc, "Invalid utf8 version: %s", version);
+		pr_info("tmpfs: Using encoding defined by mount options: %s\n",
+			param->string);
+		ctx->encoding = encoding;
+		break;
+	case Opt_cf_strict:
+		ctx->cf_strict = true;
+		break;
 	}
 	return 0;
 
@@ -3646,6 +3714,11 @@ static void shmem_put_super(struct super_block *sb)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+#ifdef CONFIG_UNICODE
+	if (sbinfo->casefold)
+		utf8_unload(sb->s_encoding);
+#endif
+
 	free_percpu(sbinfo->ino_batch);
 	percpu_counter_destroy(&sbinfo->used_blocks);
 	mpol_put(sbinfo->mpol);
@@ -3686,6 +3759,18 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	}
 	sb->s_export_op = &shmem_export_ops;
 	sb->s_flags |= SB_NOSEC;
+
+#ifdef CONFIG_UNICODE
+	if (ctx->encoding) {
+		sb->s_d_op = &casefold_dentry_ops;
+		sb->s_encoding = ctx->encoding;
+		if (ctx->cf_strict)
+			sb->s_encoding_flags = SB_ENC_STRICT_MODE_FL;
+		sbinfo->casefold = true;
+	} else if (ctx->cf_strict) {
+		pr_warn("tmpfs: casefold strict mode enabled without encoding, ignoring\n");
+	}
+#endif /* CONFIG_UNICODE */
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
@@ -3846,7 +3931,7 @@ static const struct inode_operations shmem_inode_operations = {
 static const struct inode_operations shmem_dir_inode_operations = {
 #ifdef CONFIG_TMPFS
 	.create		= shmem_create,
-	.lookup		= simple_lookup,
+	.lookup		= shmem_lookup,
 	.link		= shmem_link,
 	.unlink		= shmem_unlink,
 	.symlink	= shmem_symlink,
@@ -3912,6 +3997,8 @@ int shmem_init_fs_context(struct fs_context *fc)
 	ctx->mode = 0777 | S_ISVTX;
 	ctx->uid = current_fsuid();
 	ctx->gid = current_fsgid();
+	ctx->encoding = NULL;
+	ctx->cf_strict = false;
 
 	fc->fs_private = ctx;
 	fc->ops = &shmem_fs_context_ops;
-- 
2.31.0


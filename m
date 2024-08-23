Return-Path: <linux-fsdevel+bounces-26951-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E1395D467
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 19:35:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6636F1C22703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 17:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE25119308C;
	Fri, 23 Aug 2024 17:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="pwiLiZ0j"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F62192D6E;
	Fri, 23 Aug 2024 17:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724434435; cv=none; b=glYazH4aR07Ne8xj7PrTLWr3qbpFcYZa2gc+jiriHvJDUqdqwWCm5ss4faoDho2jfPV14T8R9sD8bvbkerN9xEaB0bDIpnOwjSC/o80vDmdZtiKneeMg0PFau+T9qlPxEpFq1V62MMP3Zp1Z190jqC9Gga4AgX0nSRLQw29Nsxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724434435; c=relaxed/simple;
	bh=AruGVonuzSs4DUN+CPHVatkIT6NULghpsW4KvVqvfuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b2v/1FHcL2oCKaiwurTJpPKkSHcI1shrD0kJxSUdseyhcyCznWJlMlG8iZkh0HRNbkkmTHDqS/5xNeYc5vzZEp4ZhcWQqRKt2tWeNfuLkSR+IaEGAtWnZHba9N1DvXpazPc901SP4EYijdPhKz5i/bWNkGT31aMt1RYcF9+hQ1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=pwiLiZ0j; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
	In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=y9QOgUnGmMfOXt3imEXMFmKZoYcPek4W3U8ViHPXL9E=; b=pwiLiZ0jOOthH9F2SeGr7Suney
	P0Qx8u9N4jscQ8YEczpVwDus5CS5wSiBL8Q9JsZhhRGxJRkTX8IiRtNuQFZszoxBK03p4c1oSyO3s
	g4yUreFx0v96lY3zFE7qXYo8AX3nJhsPHPruhMF0sZGug7HQDKPfggxEmM+NFMM8rFc9MkUpAN6nk
	LmoJGYx0+rsiURnMC6sIdfZN0J4JMV31wPv+kreX3IYbO57f3UBjGJw5GTJrWztr6FCQR+bwveXV4
	w9xbxxMZzi9mpFMK/8maAtNIi7nebYcTsBC/mFVqnktHaptQjcHwYl79abuigeUzxB1H02SMuQdXv
	IqpaWIaA==;
Received: from [179.118.186.198] (helo=localhost.localdomain)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1shYAP-0048Ww-Nr; Fri, 23 Aug 2024 19:33:41 +0200
From: =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
To: Hugh Dickins <hughd@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	kernel-dev@igalia.com,
	krisman@kernel.org,
	Daniel Rosenberg <drosen@google.com>,
	smcv@collabora.com,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>
Subject: [PATCH 1/5] tmpfs: Add casefold lookup support
Date: Fri, 23 Aug 2024 14:33:28 -0300
Message-ID: <20240823173332.281211-2-andrealmeid@igalia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823173332.281211-1-andrealmeid@igalia.com>
References: <20240823173332.281211-1-andrealmeid@igalia.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Enable casefold lookup in tmpfs, based on the enconding defined by
userspace. That means that instead of comparing byte per byte a file
name, it compares to a case-insensitive equivalent of the Unicode
string.

* dcache handling

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
d_compare() version for casefold files stores a normalized string, and
before every lookup, the filename is normalized as well, achieving a
casefolded lookup.

Signed-off-by: André Almeida <andrealmeid@igalia.com>
---
 include/linux/shmem_fs.h |  1 +
 mm/shmem.c               | 63 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 63 insertions(+), 1 deletion(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 1d06b1e5408a..1a1196b077a6 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -73,6 +73,7 @@ struct shmem_sb_info {
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
 	struct shmem_quota_limits qlimits; /* Default quota limits */
+	bool casefold;
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/mm/shmem.c b/mm/shmem.c
index 5a77acf6ac6a..aa272c62f811 100644
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
@@ -3427,6 +3431,12 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (IS_ERR(inode))
 		return PTR_ERR(inode);
 
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sb_has_strict_encoding(dir->i_sb) && IS_CASEFOLDED(dir) &&
+	    dir->i_sb->s_encoding && utf8_validate(dir->i_sb->s_encoding, &dentry->d_name))
+		return -EINVAL;
+#endif
+
 	error = simple_acl_create(dir, inode);
 	if (error)
 		goto out_iput;
@@ -3435,6 +3445,9 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	if (error && error != -EOPNOTSUPP)
 		goto out_iput;
 
+	if (IS_CASEFOLDED(dir))
+		d_add(dentry, NULL);
+
 	error = simple_offset_add(shmem_get_offset_ctx(dir), dentry);
 	if (error)
 		goto out_iput;
@@ -3526,6 +3539,9 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir,
 		goto out;
 	}
 
+	if (IS_CASEFOLDED(dir))
+		d_add(dentry, NULL);
+
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode_set_mtime_to_ts(dir,
 			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
@@ -3553,6 +3569,14 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	inode_inc_iversion(dir);
 	drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - does all the work */
+
+	/*
+	 * For now, VFS can't deal with case-insensitive negative dentries, so
+	 * we destroy them
+	 */
+	if (IS_CASEFOLDED(dir))
+		d_invalidate(dentry);
+
 	return 0;
 }
 
@@ -3697,6 +3721,8 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	dir->i_size += BOGO_DIRENT_SIZE;
 	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
+	if (IS_CASEFOLDED(dir))
+		d_add(dentry, NULL);
 	d_instantiate(dentry, inode);
 	dget(dentry);
 	return 0;
@@ -4471,6 +4497,11 @@ static void shmem_put_super(struct super_block *sb)
 {
 	struct shmem_sb_info *sbinfo = SHMEM_SB(sb);
 
+#if IS_ENABLED(CONFIG_UNICODE)
+	if (sbinfo->casefold)
+		utf8_unload(sb->s_encoding);
+#endif
+
 #ifdef CONFIG_TMPFS_QUOTA
 	shmem_disable_quotas(sb);
 #endif
@@ -4515,6 +4546,17 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
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
+		sbinfo->casefold = true;
+	}
+#endif
+
 #else
 	sb->s_flags |= SB_NOUSER;
 #endif
@@ -4704,11 +4746,28 @@ static const struct inode_operations shmem_inode_operations = {
 #endif
 };
 
+static struct dentry *shmem_lookup(struct inode *dir, struct dentry *dentry, unsigned int flags)
+{
+	if (dentry->d_name.len > NAME_MAX)
+		return ERR_PTR(-ENAMETOOLONG);
+
+	/*
+	 * For now, VFS can't deal with case-insensitive negative dentries, so
+	 * we prevent them from being created
+	 */
+	if (IS_CASEFOLDED(dir))
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
@@ -4791,6 +4850,8 @@ int shmem_init_fs_context(struct fs_context *fc)
 	ctx->uid = current_fsuid();
 	ctx->gid = current_fsgid();
 
+	ctx->encoding = NULL;
+
 	fc->fs_private = ctx;
 	fc->ops = &shmem_fs_context_ops;
 	return 0;
-- 
2.46.0



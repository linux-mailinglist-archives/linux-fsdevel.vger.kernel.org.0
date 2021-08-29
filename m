Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9678B3FAA91
	for <lists+linux-fsdevel@lfdr.de>; Sun, 29 Aug 2021 11:58:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbhH2J5l (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 29 Aug 2021 05:57:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235120AbhH2J5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 29 Aug 2021 05:57:39 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F069C061575;
        Sun, 29 Aug 2021 02:56:47 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id q21so20080300ljj.6;
        Sun, 29 Aug 2021 02:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yGJsVJCtygRnwAdMzY3g4q7mtw/NpAyS2tWSm+JvFXE=;
        b=ZKCQw3e1tx2c8lqwTzvpO4L1S19M2yqb+pj5tupaQy1BdU6no4P09sAH4oIpM1gm1C
         fRurWtWyTzAGay/clu/wRjYnLGxdAfK6os/EUeB/HqCrRdWD1r+dBGsd0NJP8VsGk78Z
         VbrwbI36SpK2UwP3vYNEPswT6QgZGm9o6Iz0UHCm+P4KjkXEfjYt1A0mqqmIx7uVnvhG
         lM80wP+NOYXLa7kZEvqK0GQlulUGFjKAkrVWbAKh2h7axU+Mq62ALE3nbU58C7sdaavs
         Xad3Pz6JpAby6ubS1marcvZNiKGMzz2bV/fWuwunzJ0786Wy5qpW8wfZ7v90L/0HLyTz
         fjzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yGJsVJCtygRnwAdMzY3g4q7mtw/NpAyS2tWSm+JvFXE=;
        b=ChwOkKZbU3BNrD83lAf0/oQ9h6zUpijQGmb0JvUPB+lCGka/57L1P0WCcYWDLbT4/B
         RjrBQd/h6DLM1xGXZ3OSsIX+Es43rm5961PQHw2fjMFdO5gvXS2m7FXsl+/oC8lw1ger
         Z9+h+ur052AyHCqiXfP8MBf9LzPmx1s/CioV/gHOMVnSUAehBIeKcP+em6YntCPx2JUK
         tpi2DlzbUlFsl86co5RwW6B9v9pq78/87ycqmhzIFKiIIE/GWrPZzknH9hGixpFUZe/D
         EeT79PMLnSLO4hmjRnVtS0ZJJu1a6rVGc/H0UOSzd8hAyKwbF1/vHrpbFQyGftkc0AQ5
         f84Q==
X-Gm-Message-State: AOAM530mNfITfCqdRNS681dpD+ttEC+/zZIfN3SuX4Sdgj5+w684f6iX
        triCD8NfTweixlELQv44T+s=
X-Google-Smtp-Source: ABdhPJyxBstZpMp/ULOi8WX/itF9vtZYwDzJvRGIhaHHsY+fKsZEsxDtiQAOYJ6LI6YoFq2etmJBdA==
X-Received: by 2002:a2e:9e1a:: with SMTP id e26mr16082111ljk.265.1630231005720;
        Sun, 29 Aug 2021 02:56:45 -0700 (PDT)
Received: from localhost.localdomain (37-33-245-172.bb.dnainternet.fi. [37.33.245.172])
        by smtp.gmail.com with ESMTPSA id d6sm1090521lfi.57.2021.08.29.02.56.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Aug 2021 02:56:45 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v3 3/9] fs/ntfs3: Convert mount options to pointer in sbi
Date:   Sun, 29 Aug 2021 12:56:08 +0300
Message-Id: <20210829095614.50021-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210829095614.50021-1-kari.argillander@gmail.com>
References: <20210829095614.50021-1-kari.argillander@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use pointer to mount options. We want to do this because we will use new
mount api which will benefit that we have spi and mount options in
different allocations. When we remount we do not have to make whole new
spi it is enough that we will allocate just mount options.

Please note that we can do example remount lot cleaner but things will
change in next patch so this should be just functional.

Signed-off-by: Kari Argillander <kari.argillander@gmail.com>
---
 fs/ntfs3/attrib.c  |  2 +-
 fs/ntfs3/dir.c     |  8 ++++----
 fs/ntfs3/file.c    |  4 ++--
 fs/ntfs3/inode.c   | 12 ++++++------
 fs/ntfs3/ntfs_fs.h |  2 +-
 fs/ntfs3/super.c   | 31 +++++++++++++++++++------------
 fs/ntfs3/xattr.c   |  2 +-
 7 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/fs/ntfs3/attrib.c b/fs/ntfs3/attrib.c
index 4eae9886e27d..7eb366a1b7c7 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -538,7 +538,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		} else if (pre_alloc == -1) {
 			pre_alloc = 0;
 			if (type == ATTR_DATA && !name_len &&
-			    sbi->options.prealloc) {
+			    sbi->options->prealloc) {
 				CLST new_alen2 = bytes_to_cluster(
 					sbi, get_pre_allocated(new_size));
 				pre_alloc = new_alen2 - new_alen;
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index d36d7fbc2b1d..e41e5a259be7 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -25,7 +25,7 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
 	int ret, uni_len, warn;
 	const __le16 *ip;
 	u8 *op;
-	struct nls_table *nls = sbi->options.nls;
+	struct nls_table *nls = sbi->options->nls;
 
 	static_assert(sizeof(wchar_t) == sizeof(__le16));
 
@@ -183,7 +183,7 @@ int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 {
 	int ret, slen;
 	const u8 *end;
-	struct nls_table *nls = sbi->options.nls;
+	struct nls_table *nls = sbi->options->nls;
 	u16 *uname = uni->name;
 
 	static_assert(sizeof(wchar_t) == sizeof(u16));
@@ -296,10 +296,10 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		return 0;
 
 	/* Skip meta files ( unless option to show metafiles is set ) */
-	if (!sbi->options.showmeta && ntfs_is_meta_file(sbi, ino))
+	if (!sbi->options->showmeta && ntfs_is_meta_file(sbi, ino))
 		return 0;
 
-	if (sbi->options.nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
+	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
 		return 0;
 
 	name_len = ntfs_utf16_to_nls(sbi, (struct le_str *)&fname->name_len,
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index a959f6197c99..c79e4aff7a19 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -743,7 +743,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	umode_t mode = inode->i_mode;
 	int err;
 
-	if (sbi->options.no_acs_rules) {
+	if (sbi->options->no_acs_rules) {
 		/* "no access rules" - force any changes of time etc. */
 		attr->ia_valid |= ATTR_FORCE;
 		/* and disable for editing some attributes */
@@ -1189,7 +1189,7 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	int err = 0;
 
 	/* if we are the last writer on the inode, drop the block reservation */
-	if (sbi->options.prealloc && ((file->f_mode & FMODE_WRITE) &&
+	if (sbi->options->prealloc && ((file->f_mode & FMODE_WRITE) &&
 				      atomic_read(&inode->i_writecount) == 1)) {
 		ni_lock(ni);
 		down_write(&ni->file.run_lock);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 520471f35e29..b28dd111e6cf 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -51,8 +51,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	inode->i_op = NULL;
 	/* Setup 'uid' and 'gid' */
-	inode->i_uid = sbi->options.fs_uid;
-	inode->i_gid = sbi->options.fs_gid;
+	inode->i_uid = sbi->options->fs_uid;
+	inode->i_gid = sbi->options->fs_gid;
 
 	err = mi_init(&ni->mi, sbi, ino);
 	if (err)
@@ -231,7 +231,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			t32 = le16_to_cpu(attr->nres.run_off);
 		}
 
-		mode = S_IFREG | (0777 & sbi->options.fs_fmask_inv);
+		mode = S_IFREG | (0777 & sbi->options->fs_fmask_inv);
 
 		if (!attr->non_res) {
 			ni->ni_flags |= NI_FLAG_RESIDENT;
@@ -274,7 +274,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			goto out;
 
 		mode = sb->s_root
-			       ? (S_IFDIR | (0777 & sbi->options.fs_dmask_inv))
+			       ? (S_IFDIR | (0777 & sbi->options->fs_dmask_inv))
 			       : (S_IFDIR | 0777);
 		goto next_attr;
 
@@ -439,7 +439,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;
 	}
 
-	if ((sbi->options.sys_immutable &&
+	if ((sbi->options->sys_immutable &&
 	     (std5->fa & FILE_ATTRIBUTE_SYSTEM)) &&
 	    !S_ISFIFO(mode) && !S_ISSOCK(mode) && !S_ISLNK(mode)) {
 		inode->i_flags |= S_IMMUTABLE;
@@ -1228,7 +1228,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		 *	}
 		 */
 	} else if (S_ISREG(mode)) {
-		if (sbi->options.sparse) {
+		if (sbi->options->sparse) {
 			/* sparsed regular file, cause option 'sparse' */
 			fa = FILE_ATTRIBUTE_SPARSE_FILE |
 			     FILE_ATTRIBUTE_ARCHIVE;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index e3a667e9838f..43b177280f39 100644
--- a/fs/ntfs3/ntfs_fs.h
+++ b/fs/ntfs3/ntfs_fs.h
@@ -279,7 +279,7 @@ struct ntfs_sb_info {
 #endif
 	} compress;
 
-	struct ntfs_mount_options options;
+	struct ntfs_mount_options *options;
 	struct ratelimit_state msg_ratelimit;
 };
 
diff --git a/fs/ntfs3/super.c b/fs/ntfs3/super.c
index c590872070e1..e9dfe274b558 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -379,11 +379,11 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 		return -ENOMEM;
 
 	/* Store  original options */
-	memcpy(&old_opts, &sbi->options, sizeof(old_opts));
-	clear_mount_options(&sbi->options);
-	memset(&sbi->options, 0, sizeof(sbi->options));
+	memcpy(&old_opts, sbi->options, sizeof(old_opts));
+	clear_mount_options(sbi->options);
+	memset(sbi->options, 0, sizeof(old_opts));
 
-	err = ntfs_parse_options(sb, data, 0, &sbi->options);
+	err = ntfs_parse_options(sb, data, 0, sbi->options);
 	if (err)
 		goto restore_opts;
 
@@ -399,7 +399,7 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 	sync_filesystem(sb);
 
 	if (ro_rw && (sbi->volume.flags & VOLUME_FLAG_DIRTY) &&
-	    !sbi->options.force) {
+	    !sbi->options->force) {
 		ntfs_warn(sb, "volume is dirty and \"force\" flag is not set!");
 		err = -EINVAL;
 		goto restore_opts;
@@ -412,8 +412,8 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 	goto out;
 
 restore_opts:
-	clear_mount_options(&sbi->options);
-	memcpy(&sbi->options, &old_opts, sizeof(old_opts));
+	clear_mount_options(sbi->options);
+	memcpy(sbi->options, &old_opts, sizeof(old_opts));
 
 out:
 	kfree(orig_data);
@@ -494,7 +494,8 @@ static noinline void put_ntfs(struct ntfs_sb_info *sbi)
 	xpress_free_decompressor(sbi->compress.xpress);
 	lzx_free_decompressor(sbi->compress.lzx);
 #endif
-	clear_mount_options(&sbi->options);
+	clear_mount_options(sbi->options);
+	kfree(sbi->options);
 
 	kfree(sbi);
 }
@@ -533,7 +534,7 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct super_block *sb = root->d_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
-	struct ntfs_mount_options *opts = &sbi->options;
+	struct ntfs_mount_options *opts = sbi->options;
 	struct user_namespace *user_ns = seq_user_ns(m);
 
 	if (opts->uid)
@@ -910,6 +911,12 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	if (!sbi)
 		return -ENOMEM;
 
+	sbi->options = kzalloc(sizeof(struct ntfs_mount_options), GFP_NOFS);
+	if (!sbi->options) {
+		kfree(sbi);
+		return -ENOMEM;
+	}
+
 	sb->s_fs_info = sbi;
 	sbi->sb = sb;
 	sb->s_flags |= SB_NODIRATIME;
@@ -922,7 +929,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	ratelimit_state_init(&sbi->msg_ratelimit, DEFAULT_RATELIMIT_INTERVAL,
 			     DEFAULT_RATELIMIT_BURST);
 
-	err = ntfs_parse_options(sb, data, silent, &sbi->options);
+	err = ntfs_parse_options(sb, data, silent, sbi->options);
 	if (err)
 		goto out;
 
@@ -1054,7 +1061,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 			goto out;
 		}
 	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
-		if (!is_ro && !sbi->options.force) {
+		if (!is_ro && !sbi->options->force) {
 			ntfs_warn(
 				sb,
 				"volume is dirty and \"force\" flag is not set!");
@@ -1376,7 +1383,7 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
 	if (sbi->flags & NTFS_FLAGS_NODISCARD)
 		return -EOPNOTSUPP;
 
-	if (!sbi->options.discard)
+	if (!sbi->options->discard)
 		return -EOPNOTSUPP;
 
 	lbo = (u64)lcn << sbi->cluster_bits;
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index d3d5b9d331d1..a17d48735b99 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -774,7 +774,7 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
 int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask)
 {
-	if (ntfs_sb(inode->i_sb)->options.no_acs_rules) {
+	if (ntfs_sb(inode->i_sb)->options->no_acs_rules) {
 		/* "no access rules" mode - allow all changes */
 		return 0;
 	}
-- 
2.25.1


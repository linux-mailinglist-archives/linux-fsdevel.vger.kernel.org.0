Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB008402BF0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Sep 2021 17:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345462AbhIGPha (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Sep 2021 11:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345411AbhIGPhV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Sep 2021 11:37:21 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AE39C061757;
        Tue,  7 Sep 2021 08:36:14 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y34so20306092lfa.8;
        Tue, 07 Sep 2021 08:36:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AEccaEZ1KuGRurG9d5/yDZXuAgzQP2nKlToTFKCBLFo=;
        b=FHDOe1xetglcLz0jatZldLk5KDxlFqDzWwfYNlAfi1gdq5/2Imwt5zb7yloc8bu2B7
         mAu1K3Z19BKveUpU5E643e0QP4RTo5aCpoJJ0ep4CM/y57mEAZEOwdtQfK1qnD5zG0YS
         tOM4Qydtl3qzqZJKvN75PwmmzNM0WGPBr+535xsQ5Q3TEKAaTvS3cIeGVDZPoOjAdnSI
         3JnUgIYbjwej4ZFuC6xYGMEqlTqZFjhdfl2b7vE8qNtyl73jdKd3aoTeFA9jnMnkPT2q
         GOGIgky+jwBkPX9aRPqSgA4/d1yZOUtc2pbgaBku7edcC3+Heoh/xqQhdtGt0OGuT6DI
         /oDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AEccaEZ1KuGRurG9d5/yDZXuAgzQP2nKlToTFKCBLFo=;
        b=Y41G3RW9FvskhfA5TCuJkOM4CSidyM49Ol9ai3ux1pBEa1gb9q8jYNSq3ZZ9cUk+lV
         nUWrQUuKKkuzZhAbRJKkvuG9mcPtAuYAW8N8KJ5sYOm2Y9IdSs5jUOsxyAXurZngIHZ9
         a16nEuk/ESvzHU6OENv6YAlZC5O4kH4c02q8rc//wQVZKVcsCIuObcLlNtbe+/Tdr8BH
         cFI1LskaPhLOHoupAwfhNztp3JvtKwhNeau/k2Cfppt7jgbMI7H5ZEm/ZIX8GDgydMZp
         FNGIyUPnv0KjQKnmUOewPxJfurZF418hhvtkcQJEQnm1M4UWei/Jm79i8Zu20nvlVRXA
         /bIg==
X-Gm-Message-State: AOAM533+d6v6lUGb+pW47sk7MJ/b3O8wr+QUY4UKM0on/FHSIG4wXLaK
        zkPcDS1AKWxZG+sZlykfj8I=
X-Google-Smtp-Source: ABdhPJw0wqrFmfGqjcLoy3wYI7pynVCT2RkWmX+6wv/pWmkK5KKMKBUHtyVTdXdKZgpBO/6A1LFZnQ==
X-Received: by 2002:a05:6512:2201:: with SMTP id h1mr13011940lfu.307.1631028972929;
        Tue, 07 Sep 2021 08:36:12 -0700 (PDT)
Received: from kari-VirtualBox.telewell.oy ([31.132.12.44])
        by smtp.gmail.com with ESMTPSA id p14sm1484458lji.56.2021.09.07.08.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 08:36:12 -0700 (PDT)
From:   Kari Argillander <kari.argillander@gmail.com>
To:     Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev
Cc:     Kari Argillander <kari.argillander@gmail.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH v4 3/9] fs/ntfs3: Convert mount options to pointer in sbi
Date:   Tue,  7 Sep 2021 18:35:51 +0300
Message-Id: <20210907153557.144391-4-kari.argillander@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210907153557.144391-1-kari.argillander@gmail.com>
References: <20210907153557.144391-1-kari.argillander@gmail.com>
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
index 34c4cbf7e29b..b1055b284c60 100644
--- a/fs/ntfs3/attrib.c
+++ b/fs/ntfs3/attrib.c
@@ -529,7 +529,7 @@ int attr_set_size(struct ntfs_inode *ni, enum ATTR_TYPE type,
 		} else if (pre_alloc == -1) {
 			pre_alloc = 0;
 			if (type == ATTR_DATA && !name_len &&
-			    sbi->options.prealloc) {
+			    sbi->options->prealloc) {
 				CLST new_alen2 = bytes_to_cluster(
 					sbi, get_pre_allocated(new_size));
 				pre_alloc = new_alen2 - new_alen;
diff --git a/fs/ntfs3/dir.c b/fs/ntfs3/dir.c
index 93f6d485564e..40440df021ef 100644
--- a/fs/ntfs3/dir.c
+++ b/fs/ntfs3/dir.c
@@ -24,7 +24,7 @@ int ntfs_utf16_to_nls(struct ntfs_sb_info *sbi, const struct le_str *uni,
 	int ret, uni_len, warn;
 	const __le16 *ip;
 	u8 *op;
-	struct nls_table *nls = sbi->options.nls;
+	struct nls_table *nls = sbi->options->nls;
 
 	static_assert(sizeof(wchar_t) == sizeof(__le16));
 
@@ -186,7 +186,7 @@ int ntfs_nls_to_utf16(struct ntfs_sb_info *sbi, const u8 *name, u32 name_len,
 {
 	int ret, slen;
 	const u8 *end;
-	struct nls_table *nls = sbi->options.nls;
+	struct nls_table *nls = sbi->options->nls;
 	u16 *uname = uni->name;
 
 	static_assert(sizeof(wchar_t) == sizeof(u16));
@@ -301,10 +301,10 @@ static inline int ntfs_filldir(struct ntfs_sb_info *sbi, struct ntfs_inode *ni,
 		return 0;
 
 	/* Skip meta files. Unless option to show metafiles is set. */
-	if (!sbi->options.showmeta && ntfs_is_meta_file(sbi, ino))
+	if (!sbi->options->showmeta && ntfs_is_meta_file(sbi, ino))
 		return 0;
 
-	if (sbi->options.nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
+	if (sbi->options->nohidden && (fname->dup.fa & FILE_ATTRIBUTE_HIDDEN))
 		return 0;
 
 	name_len = ntfs_utf16_to_nls(sbi, (struct le_str *)&fname->name_len,
diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 424450e77ad5..fef57141b161 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -737,7 +737,7 @@ int ntfs3_setattr(struct user_namespace *mnt_userns, struct dentry *dentry,
 	umode_t mode = inode->i_mode;
 	int err;
 
-	if (sbi->options.no_acs_rules) {
+	if (sbi->options->no_acs_rules) {
 		/* "No access rules" - Force any changes of time etc. */
 		attr->ia_valid |= ATTR_FORCE;
 		/* and disable for editing some attributes. */
@@ -1185,7 +1185,7 @@ static int ntfs_file_release(struct inode *inode, struct file *file)
 	int err = 0;
 
 	/* If we are last writer on the inode, drop the block reservation. */
-	if (sbi->options.prealloc && ((file->f_mode & FMODE_WRITE) &&
+	if (sbi->options->prealloc && ((file->f_mode & FMODE_WRITE) &&
 				      atomic_read(&inode->i_writecount) == 1)) {
 		ni_lock(ni);
 		down_write(&ni->file.run_lock);
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index db2a5a4c38e4..9f740fd301b2 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -49,8 +49,8 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 
 	inode->i_op = NULL;
 	/* Setup 'uid' and 'gid' */
-	inode->i_uid = sbi->options.fs_uid;
-	inode->i_gid = sbi->options.fs_gid;
+	inode->i_uid = sbi->options->fs_uid;
+	inode->i_gid = sbi->options->fs_gid;
 
 	err = mi_init(&ni->mi, sbi, ino);
 	if (err)
@@ -229,7 +229,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			t32 = le16_to_cpu(attr->nres.run_off);
 		}
 
-		mode = S_IFREG | (0777 & sbi->options.fs_fmask_inv);
+		mode = S_IFREG | (0777 & sbi->options->fs_fmask_inv);
 
 		if (!attr->non_res) {
 			ni->ni_flags |= NI_FLAG_RESIDENT;
@@ -272,7 +272,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 			goto out;
 
 		mode = sb->s_root
-			       ? (S_IFDIR | (0777 & sbi->options.fs_dmask_inv))
+			       ? (S_IFDIR | (0777 & sbi->options->fs_dmask_inv))
 			       : (S_IFDIR | 0777);
 		goto next_attr;
 
@@ -443,7 +443,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 		goto out;
 	}
 
-	if ((sbi->options.sys_immutable &&
+	if ((sbi->options->sys_immutable &&
 	     (std5->fa & FILE_ATTRIBUTE_SYSTEM)) &&
 	    !S_ISFIFO(mode) && !S_ISSOCK(mode) && !S_ISLNK(mode)) {
 		inode->i_flags |= S_IMMUTABLE;
@@ -1244,7 +1244,7 @@ struct inode *ntfs_create_inode(struct user_namespace *mnt_userns,
 		 *	}
 		 */
 	} else if (S_ISREG(mode)) {
-		if (sbi->options.sparse) {
+		if (sbi->options->sparse) {
 			/* Sparsed regular file, cause option 'sparse'. */
 			fa = FILE_ATTRIBUTE_SPARSE_FILE |
 			     FILE_ATTRIBUTE_ARCHIVE;
diff --git a/fs/ntfs3/ntfs_fs.h b/fs/ntfs3/ntfs_fs.h
index 97e682ebcfb9..98c90c399ee2 100644
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
index 6cb689605089..0f3820342051 100644
--- a/fs/ntfs3/super.c
+++ b/fs/ntfs3/super.c
@@ -389,11 +389,11 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 		return -ENOMEM;
 
 	/* Store  original options. */
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
 
@@ -409,7 +409,7 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 	sync_filesystem(sb);
 
 	if (ro_rw && (sbi->volume.flags & VOLUME_FLAG_DIRTY) &&
-	    !sbi->options.force) {
+	    !sbi->options->force) {
 		ntfs_warn(sb, "volume is dirty and \"force\" flag is not set!");
 		err = -EINVAL;
 		goto restore_opts;
@@ -422,8 +422,8 @@ static int ntfs_remount(struct super_block *sb, int *flags, char *data)
 	goto out;
 
 restore_opts:
-	clear_mount_options(&sbi->options);
-	memcpy(&sbi->options, &old_opts, sizeof(old_opts));
+	clear_mount_options(sbi->options);
+	memcpy(sbi->options, &old_opts, sizeof(old_opts));
 
 out:
 	kfree(orig_data);
@@ -506,7 +506,8 @@ static noinline void put_ntfs(struct ntfs_sb_info *sbi)
 	xpress_free_decompressor(sbi->compress.xpress);
 	lzx_free_decompressor(sbi->compress.lzx);
 #endif
-	clear_mount_options(&sbi->options);
+	clear_mount_options(sbi->options);
+	kfree(sbi->options);
 
 	kfree(sbi);
 }
@@ -545,7 +546,7 @@ static int ntfs_show_options(struct seq_file *m, struct dentry *root)
 {
 	struct super_block *sb = root->d_sb;
 	struct ntfs_sb_info *sbi = sb->s_fs_info;
-	struct ntfs_mount_options *opts = &sbi->options;
+	struct ntfs_mount_options *opts = sbi->options;
 	struct user_namespace *user_ns = seq_user_ns(m);
 
 	if (opts->uid)
@@ -930,6 +931,12 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
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
@@ -942,7 +949,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 	ratelimit_state_init(&sbi->msg_ratelimit, DEFAULT_RATELIMIT_INTERVAL,
 			     DEFAULT_RATELIMIT_BURST);
 
-	err = ntfs_parse_options(sb, data, silent, &sbi->options);
+	err = ntfs_parse_options(sb, data, silent, sbi->options);
 	if (err)
 		goto out;
 
@@ -1074,7 +1081,7 @@ static int ntfs_fill_super(struct super_block *sb, void *data, int silent)
 			goto out;
 		}
 	} else if (sbi->volume.flags & VOLUME_FLAG_DIRTY) {
-		if (!is_ro && !sbi->options.force) {
+		if (!is_ro && !sbi->options->force) {
 			ntfs_warn(
 				sb,
 				"volume is dirty and \"force\" flag is not set!");
@@ -1394,7 +1401,7 @@ int ntfs_discard(struct ntfs_sb_info *sbi, CLST lcn, CLST len)
 	if (sbi->flags & NTFS_FLAGS_NODISCARD)
 		return -EOPNOTSUPP;
 
-	if (!sbi->options.discard)
+	if (!sbi->options->discard)
 		return -EOPNOTSUPP;
 
 	lbo = (u64)lcn << sbi->cluster_bits;
diff --git a/fs/ntfs3/xattr.c b/fs/ntfs3/xattr.c
index b15d532e4a17..ac4b37bf8832 100644
--- a/fs/ntfs3/xattr.c
+++ b/fs/ntfs3/xattr.c
@@ -769,7 +769,7 @@ int ntfs_acl_chmod(struct user_namespace *mnt_userns, struct inode *inode)
 int ntfs_permission(struct user_namespace *mnt_userns, struct inode *inode,
 		    int mask)
 {
-	if (ntfs_sb(inode->i_sb)->options.no_acs_rules) {
+	if (ntfs_sb(inode->i_sb)->options->no_acs_rules) {
 		/* "No access rules" mode - Allow all changes. */
 		return 0;
 	}
-- 
2.25.1


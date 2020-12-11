Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F07822D82EE
	for <lists+linux-fsdevel@lfdr.de>; Sat, 12 Dec 2020 00:54:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403836AbgLKXwC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 18:52:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389300AbgLKXvg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 18:51:36 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21738C06138C
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 15:50:15 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id t8so7981507pfg.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 11 Dec 2020 15:50:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snTNZOQ9GDXtSNYtcKuKDP326c5ZbLmMTItBezWzaTg=;
        b=x86Z3MhY9LCUirjzHrabzM0jUKYBy2cZuwFHoNfEKKgI2fok3MealWI7xKnxF/+Dnp
         pyJsF+fCuuWQdEq1RO7eJqjKCPcfx1LieyYIF3vNEXO4KZCI2opKMrMPh/aPC5mA5sTM
         M6/X7AmyMgstaB41G9J1yh/n71EpBfIBrjLUU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snTNZOQ9GDXtSNYtcKuKDP326c5ZbLmMTItBezWzaTg=;
        b=DaLsZh0+/YUA5NdiGEEO5Tu4Zp52+kN0wR/Gy9ZmMoWL54zEwTD3i5G9xC0Czkyid8
         ivMlsX3wP61XE3q7mXQQx2S24FUz3XbKJMbPODbTnZAtbU/tksg+aplPmpC3WEWnprlt
         zV7c8w3UIjcxrlmQXiKJZAutXfcOxVwbzU1HrDxuKiboR5VWPuWYBYFMFV4kWQclNfIo
         /LIgj5iDxR71Zp7eis94Dgf1dr9VVPhs3jN7HB1skzQGDqStPsFgaxcMPXdbrPX4LQ8P
         Mfbiysg/J1/Z3YRRitxlMca9anzjl4pz9+g09LS5XmgPz8fq9dgd/FYXhnFYqK1VAxTN
         YYBA==
X-Gm-Message-State: AOAM533DVyWbvSnBiDX70YU0/kQs1gfFPM/Ik2Y4zR+Fut0p2C/DIMFf
        NBKWL0LYXuHIpt8xMEJG0rQeKA==
X-Google-Smtp-Source: ABdhPJzkqM+URvs24nucxo4JEj1YAZGrL0YfI7YJSlFmFr0KHcNplNsOOh+N3aHm4UtMC4ptGOGpYw==
X-Received: by 2002:a05:6a00:ac5:b029:19d:97c2:d3a7 with SMTP id c5-20020a056a000ac5b029019d97c2d3a7mr6881741pfl.61.1607730614530;
        Fri, 11 Dec 2020 15:50:14 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id b12sm11324641pft.114.2020.12.11.15.50.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Dec 2020 15:50:13 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Sargun Dhillon <sargun@sargun.me>, Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v2 3/3] overlay: Implement volatile-specific fsync error behaviour
Date:   Fri, 11 Dec 2020 15:50:02 -0800
Message-Id: <20201211235002.4195-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201211235002.4195-1-sargun@sargun.me>
References: <20201211235002.4195-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs's volatile option allows the user to bypass all forced sync calls
to the upperdir filesystem. This comes at the cost of safety. We can never
ensure that the user's data is intact, but we can make a best effort to
expose whether or not the data is likely to be in a bad state.

We decided[1] that the best way to handle this in the time being is that if
an overlayfs's upperdir experiences an error after a volatile mount occurs,
that error will be returned on fsync, fdatasync, sync, and syncfs. This is
contradictory to the traditional behaviour of VFS which fails the call
once, and only raises an error if a subsequent fsync error has occurred,
and been raised by the filesystem.

One awkward aspect of the patch is that we have to manually set the
superblock's errseq_t after the sync_fs callback as opposed to just
returning an error from syncfs. This is because the call chain looks
something like this:

sys_syncfs ->
	sync_filesystem ->
		__sync_filesystem ->
			/* The return value is ignored here
			sb->s_op->sync_fs(sb)
			_sync_blockdev
		/* Where the VFS fetches the error to raise to userspace */
		errseq_check_and_advance

Because of this we call errseq_set every time the sync_fs callback occurs.

[1]: https://lore.kernel.org/linux-fsdevel/36d820394c3e7cd1faa1b28a8135136d5001dadd.camel@redhat.com/T/#u

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: Jeff Layton <jlayton@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
---
 Documentation/filesystems/overlayfs.rst |  8 +++++++
 fs/overlayfs/file.c                     |  5 +++--
 fs/overlayfs/overlayfs.h                |  1 +
 fs/overlayfs/ovl_entry.h                |  3 +++
 fs/overlayfs/readdir.c                  |  5 +++--
 fs/overlayfs/super.c                    | 26 ++++++++++++++++-------
 fs/overlayfs/util.c                     | 28 +++++++++++++++++++++++++
 7 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 580ab9a0fe31..3af569cea6a7 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -575,6 +575,14 @@ without significant effort.
 The advantage of mounting with the "volatile" option is that all forms of
 sync calls to the upper filesystem are omitted.
 
+In order to avoid a giving a false sense of safety, the syncfs (and fsync)
+semantics of volatile mounts are slightly different than that of the rest of
+VFS.  If any error occurs on the upperdir's filesystem after a volatile mount
+takes place, all sync functions will return the last error observed on the
+upperdir filesystem.  Once this condition is reached, the filesystem will not
+recover, and every subsequent sync call will return an error, even if the
+upperdir has not experience a new error since the last sync call.
+
 When overlay is mounted with "volatile" option, the directory
 "$workdir/work/incompat/volatile" is created.  During next mount, overlay
 checks for this directory and refuses to mount if present. This is a strong
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index efccb7c1f9bc..d7bc3e94a106 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -445,8 +445,9 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	const struct cred *old_cred;
 	int ret;
 
-	if (!ovl_should_sync(OVL_FS(file_inode(file)->i_sb)))
-		return 0;
+	ret = ovl_check_sync(OVL_FS(file_inode(file)->i_sb));
+	if (ret <= 0)
+		return ret;
 
 	ret = ovl_real_fdget_meta(file, &real, !datasync);
 	if (ret)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f8880aa2ba0e..af79c3a2392e 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -322,6 +322,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
 char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 			     int padding);
+int ovl_check_sync(struct ovl_fs *ofs);
 
 static inline bool ovl_is_impuredir(struct super_block *sb,
 				    struct dentry *dentry)
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094df8e..355a0b66ba16 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -79,6 +79,9 @@ struct ovl_fs {
 	atomic_long_t last_ino;
 	/* Whiteout dentry cache */
 	struct dentry *whiteout;
+	/* snapshot of upperdir's errseq_counter for volatile mounts */
+	errseq_t upper_errseq;
+	int upper_errseq_counter;
 };
 
 static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 01620ebae1bd..f7f1a29e290f 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -909,8 +909,9 @@ static int ovl_dir_fsync(struct file *file, loff_t start, loff_t end,
 	struct file *realfile;
 	int err;
 
-	if (!ovl_should_sync(OVL_FS(file->f_path.dentry->d_sb)))
-		return 0;
+	err = ovl_check_sync(OVL_FS(file->f_path.dentry->d_sb));
+	if (err <= 0)
+		return err;
 
 	realfile = ovl_dir_real_file(file, true);
 	err = PTR_ERR_OR_ZERO(realfile);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 290983bcfbb3..ec6bed8f35c8 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -261,11 +261,18 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	struct super_block *upper_sb;
 	int ret;
 
-	if (!ovl_upper_mnt(ofs))
-		return 0;
+	ret = ovl_check_sync(ofs);
+	/*
+	 * We have to always set the err, because the return value isn't
+	 * checked, and instead VFS looks at the writeback errseq after
+	 * this call.
+	 */
+	if (ret < 0)
+		errseq_counter_set(&sb->s_wb_err, ret);
+
+	if (!ret)
+		return ret;
 
-	if (!ovl_should_sync(ofs))
-		return 0;
 	/*
 	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 	 * All the super blocks will be iterated, including upper_sb.
@@ -1927,6 +1934,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &ovl_super_operations;
 
 	if (ofs->config.upperdir) {
+		struct super_block *upper_mnt_sb;
+
 		if (!ofs->config.workdir) {
 			pr_err("missing 'workdir'\n");
 			goto out_err;
@@ -1943,9 +1952,12 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		if (!ofs->workdir)
 			sb->s_flags |= SB_RDONLY;
 
-		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
-		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
-
+		upper_mnt_sb = ovl_upper_mnt(ofs)->mnt_sb;
+		sb->s_stack_depth = upper_mnt_sb->s_stack_depth;
+		sb->s_time_gran = upper_mnt_sb->s_time_gran;
+		errseq_counter_sample(&ofs->upper_errseq,
+				      &ofs->upper_errseq_counter,
+				      &upper_mnt_sb->s_wb_err);
 	}
 	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
 	err = PTR_ERR(oe);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 23f475627d07..1408d56748c0 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -950,3 +950,31 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 	kfree(buf);
 	return ERR_PTR(res);
 }
+
+/*
+ * ovl_check_sync provides sync checking, and safety for volatile mounts
+ *
+ * Returns 1 if sync required.
+ *
+ * Returns 0 if syncing can be skipped because mount is volatile, and no errors
+ * have occurred on the upperdir since the mount.
+ *
+ * Returns -errno if it is a volatile mount, and the error that occurred since
+ * the last mount. If the error code changes, it'll return the latest error
+ * code.
+ */
+
+int ovl_check_sync(struct ovl_fs *ofs)
+{
+	struct vfsmount *mnt;
+
+	if (ovl_should_sync(ofs))
+		return 1;
+
+	mnt = ovl_upper_mnt(ofs);
+	if (!mnt)
+		return 0;
+
+	return errseq_counter_check(&mnt->mnt_sb->s_wb_err, ofs->upper_errseq,
+				    ofs->upper_errseq_counter);
+}
-- 
2.25.1


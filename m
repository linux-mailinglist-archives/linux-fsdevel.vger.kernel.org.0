Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E7452CB8D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 10:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729313AbgLBJ2O (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Dec 2020 04:28:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgLBJ2N (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:28:13 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DC1BC0613D4
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Dec 2020 01:27:33 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id f14so246635pju.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 02 Dec 2020 01:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4QouYoWIu8rXxDOcVqW18RPxH2Lj6h3aQNKVe/lPsM=;
        b=M6BFH+sMhWUf+VMUKOsY1w/oYRsXpw6xQ+MuL9lr1CFFMw6j5CtLP7xQSWcf3EDDzQ
         rfc6yCYCi8EVvm8e1b/II/Sj7G8b/zQOOfS+sD7IPSM7K+kdiKyAkoy9YYypkPELa/Un
         QxHuniEXx39wA4fdx/6Cc7rO9yYUOtucMdFV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d4QouYoWIu8rXxDOcVqW18RPxH2Lj6h3aQNKVe/lPsM=;
        b=do1zlWxU5dwa7fjhntEUHesGr1mzs2tNSTugKfd+EREbGlMFD9eFpXYimW0kT9iMj2
         M7GlVG4k3R32CmylgpyOE+URkHBI2boPV3rERgW64zuwX2/ilfDdzjmpUAwg6gwYZsBr
         1e21ePXyUJnzEuJHSJOcnYjTv11hwY9jJwCh411giN8h95pL0u10XtXGmwkozEO5yUrJ
         1nd/lFSqzJukeA7QyH4jyTJhspaQp+xGew9KsDqviGMujJqUTf+vGdt4dKXj/OBmBD/Z
         3MS31hwu/LwO4hH5TnskzTl8WqfuNcLetUHsUCye9wZ2hsZwFAdEcO8BOA0gGLLWnrcF
         O6Kw==
X-Gm-Message-State: AOAM532cxAZSuY7dBsJO84tgEhWtPw+0JmEQ65p74/rLkv5I8QwoAgqa
        VprmHcMPKkepNWkUYQuPciV0D/AM0LC5UQ==
X-Google-Smtp-Source: ABdhPJyP7SYPA4xCxj1i0/3vLbmSungLkSaHpIo7icEMzV9CWB25AuS2Wbm0dr877U7wqrNaivkKFA==
X-Received: by 2002:a17:90a:c301:: with SMTP id g1mr1567480pjt.150.1606901252586;
        Wed, 02 Dec 2020 01:27:32 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id bg20sm1288207pjb.6.2020.12.02.01.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:27:31 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: [PATCH] overlay: Implement volatile-specific fsync error behaviour
Date:   Wed,  2 Dec 2020 01:27:20 -0800
Message-Id: <20201202092720.41522-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
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
once, and only raises an error if a subsequent fsync error has occured,
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
 Documentation/filesystems/overlayfs.rst |  8 ++++++++
 fs/overlayfs/file.c                     |  5 +++--
 fs/overlayfs/overlayfs.h                |  1 +
 fs/overlayfs/ovl_entry.h                |  2 ++
 fs/overlayfs/readdir.c                  |  5 +++--
 fs/overlayfs/super.c                    | 24 +++++++++++++++-------
 fs/overlayfs/util.c                     | 27 +++++++++++++++++++++++++
 7 files changed, 61 insertions(+), 11 deletions(-)

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
index 802259f33c28..2479b297a966 100644
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
index 1b5a2094df8e..9460a52abea3 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -79,6 +79,8 @@ struct ovl_fs {
 	atomic_long_t last_ino;
 	/* Whiteout dentry cache */
 	struct dentry *whiteout;
+	/* snapshot of upperdir's errseq_t at mount time for volatile mounts */
+	errseq_t upper_errseq;
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
index 290983bcfbb3..82a096a05bce 100644
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
+		errseq_set(&sb->s_wb_err, ret);
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
@@ -1943,9 +1952,10 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		if (!ofs->workdir)
 			sb->s_flags |= SB_RDONLY;
 
-		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
-		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
-
+		upper_mnt_sb = ovl_upper_mnt(ofs)->mnt_sb;
+		sb->s_stack_depth = upper_mnt_sb->s_stack_depth;
+		sb->s_time_gran = upper_mnt_sb->s_time_gran;
+		ofs->upper_errseq = errseq_sample(&upper_mnt_sb->s_wb_err);
 	}
 	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
 	err = PTR_ERR(oe);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 23f475627d07..9b460cd7b151 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -950,3 +950,30 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
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
+	return errseq_check(&mnt->mnt_sb->s_wb_err, ofs->upper_errseq);
+}
-- 
2.25.1


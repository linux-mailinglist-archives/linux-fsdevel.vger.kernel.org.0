Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84B242EEA2B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 01:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728191AbhAHALZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Jan 2021 19:11:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAHALY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Jan 2021 19:11:24 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA40C0612B1
        for <linux-fsdevel@vger.kernel.org>; Thu,  7 Jan 2021 16:10:49 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x12so4728243plr.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Jan 2021 16:10:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VemmJRt3P01EfOt/Xs0GaR4+0L00UbeVA9HwVzMYZ2U=;
        b=N/0AO3Hkrsmpg9he747deZ1NWCfNdSA1YWaiR0ENE5CA73yXFEltWofju2t9HFV2bI
         cylfx8yyKZlsBCjVPftfOFI+UniGkF7xF6Wd+Vf3JoxE1G0RKIsQbDFI0jI9YhVPg041
         WInPhrfeRtXmeSUOXj8hkBTsUDg4pNozyRCF8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VemmJRt3P01EfOt/Xs0GaR4+0L00UbeVA9HwVzMYZ2U=;
        b=OLS7cKmNQWiC8qFz4wQ5uuYegzdlqXfwAqs9wdjgNnxfCeqZCvSYWuIPJnuRgzcfBe
         fDlBxjzhDTYhS3jlZBr5EUSIk/c+qhDwdw64+bFqJmu/oMwzUJMWwjhPpeB4n/7lhQW0
         iP3tsBtEAgW534xIMpXs/fHEHOo3ooBfM0IBvD7sFz/tAnc0xqO7RjbG2NvDFDNIgZ5K
         ZBu04MlCs0uOlJhUzGK5MgTetuFoy8Db1h0nVLVxrGF5NDINGanTlsLLgPJHVu6pbHe5
         odiScLppUF2yxDQLEjnd1Yj3yDLyNJKlfswu08ObPOsqjAH/xs8D277RhbOaXqsFCbWL
         2KFA==
X-Gm-Message-State: AOAM532JxDc84+z2d9BloazKncNPSLRVqJi7/xEl4d1lkeD4p5LKckAc
        MRRagFtUYccx8OiDiB31DRXF3w==
X-Google-Smtp-Source: ABdhPJyMPWJF4SraNB6fF/bnP0KeLcBT4pvkQjkBwm/3jtD55YsYbV6MhAsCtQMmWf8PoQzaEfEsSA==
X-Received: by 2002:a17:902:a3ca:b029:da:df3c:91c8 with SMTP id q10-20020a170902a3cab02900dadf3c91c8mr1222725plb.41.1610064648453;
        Thu, 07 Jan 2021 16:10:48 -0800 (PST)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id k11sm7083997pgt.83.2021.01.07.16.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 16:10:47 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     linux-unionfs@vger.kernel.org, miklos@szeredi.hu,
        Amir Goldstein <amir73il@gmail.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Chengguang Xu <cgxu519@mykernel.net>,
        Christoph Hellwig <hch@lst.de>, NeilBrown <neilb@suse.com>,
        Jan Kara <jack@suse.cz>, stable@vger.kernel.org,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH v4] overlay: Implement volatile-specific fsync error behaviour
Date:   Thu,  7 Jan 2021 16:10:43 -0800
Message-Id: <20210108001043.12683-1-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Overlayfs's volatile option allows the user to bypass all forced sync calls
to the upperdir filesystem. This comes at the cost of safety. We can never
ensure that the user's data is intact, but we can make a best effort to
expose whether or not the data is likely to be in a bad state.

The best way to handle this in the time being is that if an overlayfs's
upperdir experiences an error after a volatile mount occurs, that error
will be returned on fsync, fdatasync, sync, and syncfs. This is
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
Due to the nature of this seen / unseen dichotomy, if the upperdir is an
inconsistent state at the initial mount time, overlayfs will refuse to
mount, as overlayfs cannot get a snapshot of the upperdir's errseq that
will increment on error until the user calls syncfs.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Suggested-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Fixes: c86243b090bc ("ovl: provide a mount option "volatile"")
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-unionfs@vger.kernel.org
Cc: stable@vger.kernel.org
Cc: Jeff Layton <jlayton@redhat.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: Amir Goldstein <amir73il@gmail.com>
Cc: Vivek Goyal <vgoyal@redhat.com>
Cc: Matthew Wilcox <willy@infradead.org>
---
 Documentation/filesystems/overlayfs.rst |  8 ++++++
 fs/overlayfs/file.c                     |  5 ++--
 fs/overlayfs/overlayfs.h                |  1 +
 fs/overlayfs/ovl_entry.h                |  2 ++
 fs/overlayfs/readdir.c                  |  5 ++--
 fs/overlayfs/super.c                    | 34 ++++++++++++++++++++-----
 fs/overlayfs/util.c                     | 27 ++++++++++++++++++++
 7 files changed, 71 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/overlayfs.rst b/Documentation/filesystems/overlayfs.rst
index 580ab9a0fe31..137afeb3f581 100644
--- a/Documentation/filesystems/overlayfs.rst
+++ b/Documentation/filesystems/overlayfs.rst
@@ -575,6 +575,14 @@ without significant effort.
 The advantage of mounting with the "volatile" option is that all forms of
 sync calls to the upper filesystem are omitted.
 
+In order to avoid a giving a false sense of safety, the syncfs (and fsync)
+semantics of volatile mounts are slightly different than that of the rest of
+VFS.  If any writeback error occurs on the upperdir's filesystem after a
+volatile mount takes place, all sync functions will return an error.  Once this
+condition is reached, the filesystem will not recover, and every subsequent sync
+call will return an error, even if the upperdir has not experience a new error
+since the last sync call.
+
 When overlay is mounted with "volatile" option, the directory
 "$workdir/work/incompat/volatile" is created.  During next mount, overlay
 checks for this directory and refuses to mount if present. This is a strong
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index a1f72ac053e5..5c5c3972ebd0 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -445,8 +445,9 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	const struct cred *old_cred;
 	int ret;
 
-	if (!ovl_should_sync(OVL_FS(file_inode(file)->i_sb)))
-		return 0;
+	ret = ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
+	if (ret <= 0)
+		return ret;
 
 	ret = ovl_real_fdget_meta(file, &real, !datasync);
 	if (ret)
diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index f8880aa2ba0e..9f7af98ae200 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -322,6 +322,7 @@ int ovl_check_metacopy_xattr(struct ovl_fs *ofs, struct dentry *dentry);
 bool ovl_is_metacopy_dentry(struct dentry *dentry);
 char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 			     int padding);
+int ovl_sync_status(struct ovl_fs *ofs);
 
 static inline bool ovl_is_impuredir(struct super_block *sb,
 				    struct dentry *dentry)
diff --git a/fs/overlayfs/ovl_entry.h b/fs/overlayfs/ovl_entry.h
index 1b5a2094df8e..b208eba5d0b6 100644
--- a/fs/overlayfs/ovl_entry.h
+++ b/fs/overlayfs/ovl_entry.h
@@ -79,6 +79,8 @@ struct ovl_fs {
 	atomic_long_t last_ino;
 	/* Whiteout dentry cache */
 	struct dentry *whiteout;
+	/* r/o snapshot of upperdir sb's only taken on volatile mounts */
+	errseq_t errseq;
 };
 
 static inline struct vfsmount *ovl_upper_mnt(struct ovl_fs *ofs)
diff --git a/fs/overlayfs/readdir.c b/fs/overlayfs/readdir.c
index 01620ebae1bd..a273ef901e57 100644
--- a/fs/overlayfs/readdir.c
+++ b/fs/overlayfs/readdir.c
@@ -909,8 +909,9 @@ static int ovl_dir_fsync(struct file *file, loff_t start, loff_t end,
 	struct file *realfile;
 	int err;
 
-	if (!ovl_should_sync(OVL_FS(file->f_path.dentry->d_sb)))
-		return 0;
+	err = ovl_sync_status(OVL_FS(file->f_path.dentry->d_sb));
+	if (err <= 0)
+		return err;
 
 	realfile = ovl_dir_real_file(file, true);
 	err = PTR_ERR_OR_ZERO(realfile);
diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index 290983bcfbb3..d23177a53c95 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -261,11 +261,20 @@ static int ovl_sync_fs(struct super_block *sb, int wait)
 	struct super_block *upper_sb;
 	int ret;
 
-	if (!ovl_upper_mnt(ofs))
-		return 0;
+	ret = ovl_sync_status(ofs);
+	/*
+	 * We have to always set the err, because the return value isn't
+	 * checked in syncfs, and instead indirectly return an error via
+	 * the sb's writeback errseq, which VFS inspects after this call.
+	 */
+	if (ret < 0) {
+		errseq_set(&sb->s_wb_err, -EIO);
+		return -EIO;
+	}
+
+	if (!ret)
+		return ret;
 
-	if (!ovl_should_sync(ofs))
-		return 0;
 	/*
 	 * Not called for sync(2) call or an emergency sync (SB_I_SKIP_SYNC).
 	 * All the super blocks will be iterated, including upper_sb.
@@ -1927,6 +1936,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 	sb->s_op = &ovl_super_operations;
 
 	if (ofs->config.upperdir) {
+		struct super_block *upper_sb;
+
 		if (!ofs->config.workdir) {
 			pr_err("missing 'workdir'\n");
 			goto out_err;
@@ -1936,6 +1947,16 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		if (err)
 			goto out_err;
 
+		upper_sb = ovl_upper_mnt(ofs)->mnt_sb;
+		if (!ovl_should_sync(ofs)) {
+			ofs->errseq = errseq_sample(&upper_sb->s_wb_err);
+			if (errseq_check(&upper_sb->s_wb_err, ofs->errseq)) {
+				err = -EIO;
+				pr_err("Cannot mount volatile when upperdir has an unseen error. Sync upperdir fs to clear state.\n");
+				goto out_err;
+			}
+		}
+
 		err = ovl_get_workdir(sb, ofs, &upperpath);
 		if (err)
 			goto out_err;
@@ -1943,9 +1964,8 @@ static int ovl_fill_super(struct super_block *sb, void *data, int silent)
 		if (!ofs->workdir)
 			sb->s_flags |= SB_RDONLY;
 
-		sb->s_stack_depth = ovl_upper_mnt(ofs)->mnt_sb->s_stack_depth;
-		sb->s_time_gran = ovl_upper_mnt(ofs)->mnt_sb->s_time_gran;
-
+		sb->s_stack_depth = upper_sb->s_stack_depth;
+		sb->s_time_gran = upper_sb->s_time_gran;
 	}
 	oe = ovl_get_lowerstack(sb, splitlower, numlower, ofs, layers);
 	err = PTR_ERR(oe);
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 23f475627d07..6e7b8c882045 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -950,3 +950,30 @@ char *ovl_get_redirect_xattr(struct ovl_fs *ofs, struct dentry *dentry,
 	kfree(buf);
 	return ERR_PTR(res);
 }
+
+/*
+ * ovl_sync_status() - Check fs sync status for volatile mounts
+ *
+ * Returns 1 if this is not a volatile mount and a real sync is required.
+ *
+ * Returns 0 if syncing can be skipped because mount is volatile, and no errors
+ * have occurred on the upperdir since the mount.
+ *
+ * Returns -errno if it is a volatile mount, and the error that occurred since
+ * the last mount. If the error code changes, it'll return the latest error
+ * code.
+ */
+
+int ovl_sync_status(struct ovl_fs *ofs)
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
+	return errseq_check(&mnt->mnt_sb->s_wb_err, ofs->errseq);
+}
-- 
2.25.1


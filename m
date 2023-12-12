Return-Path: <linux-fsdevel+bounces-5643-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F1DD80E805
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 10:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3AA61F218ED
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Dec 2023 09:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2BDE59140;
	Tue, 12 Dec 2023 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RYJpYX6W"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A48E9
	for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-40c48d7a7a7so15711825e9.3
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Dec 2023 01:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702374288; x=1702979088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1/K6ChuVhbhljn0qE9o6Wep7Oq1QDR+WhDyuYC63b80=;
        b=RYJpYX6WlU4yjcW789AN9/lgeReiOVkXrqcTgxhijptS5t3Sc5L6oXC9FmBXetoS68
         o5BlqH6XMq/x/pPh08Nf2vaOZMJJY8ELQIzO23LYwsrCvXsD0Q0gzBChQKhutBDlRVI0
         XRz/IiRj9MtgOISGG4xY60RDTRe9wCFQzCDj3rktWkN14IaZj3oN6p17xKsG1rtCVdF5
         vhahvOBk7ppjgBF9vQCO4t2mGSI3It8Ukk4N/NyzvYUmc7qhrpxLgKXC4bx8/huwCqW5
         bxSdn3yCyVGYLZn01TODKIDXx113SFsDpFOzwXnoMxyr2wyqLqqmu3pFL6yMdwZJqb7s
         rp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702374288; x=1702979088;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1/K6ChuVhbhljn0qE9o6Wep7Oq1QDR+WhDyuYC63b80=;
        b=ghZE4LyIpFZ4+sV5XSVu8HbgFQYhLEfNNBs/XjnJuzJ+ESDIitBwCBdmZQnGXPvGeP
         Iw9QL5scIE67mqknfImMbMYJJYQZjIwSYMUtM5ZwryHpn0fkUYxKS27al1+sCLwi62dD
         uSsOP5Oap5/wTZqIod6Co8rRGJSBq/Y0iHp+UOnkBw7VapTO54C0Yowph9GUFmgNuLXi
         dJBKZMWDs6G5LgULL0eCzGedPLxvUKIMi4mSpHwpjsxwcWSbjhJxu+thyRlJGpI+g9hk
         VeqxgDIsrTJA9Z0IUthnshG4DMKlgtKOiwo7yIdmlJ70HreflBfsYjuqpcC0GXPyWBip
         QweQ==
X-Gm-Message-State: AOJu0YxXNBJn0pFUngUBe15hJUpvwKLC+6xf4wkucMVpjYI70n9ru/vd
	gcrxmnwgvAM8ofGArnZOlsk=
X-Google-Smtp-Source: AGHT+IFE7lj//3q8NYPR90btRPSCqeZFdQ82H+p2iBuNzqrfYUeJl5oYM0GRoOZgnsppwOBfZkiRsw==
X-Received: by 2002:a5d:630f:0:b0:336:2a21:c9bd with SMTP id i15-20020a5d630f000000b003362a21c9bdmr561401wru.52.1702374287855;
        Tue, 12 Dec 2023 01:44:47 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id l4-20020a05600012c400b003334041c3edsm10432244wrx.41.2023.12.12.01.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 01:44:47 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH v3 2/5] fs: use splice_copy_file_range() inline helper
Date: Tue, 12 Dec 2023 11:44:37 +0200
Message-Id: <20231212094440.250945-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231212094440.250945-1-amir73il@gmail.com>
References: <20231212094440.250945-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_copy_file_range() is just a wrapper around splice_file_range(),
which caps the maximum copy length.

The only caller of splice_file_range(), namely __ceph_copy_file_range()
is already ready to cope with short copy.

Move the length capping into splice_file_range() and replace the exported
symbol generic_copy_file_range() with a simple inline helper.

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-fsdevel/20231204083849.GC32438@lst.de/
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ceph/file.c         |  4 ++--
 fs/fuse/file.c         |  5 +++--
 fs/nfs/nfs4file.c      |  5 +++--
 fs/read_write.c        | 34 ----------------------------------
 fs/smb/client/cifsfs.c |  5 +++--
 fs/splice.c            |  7 ++++---
 include/linux/fs.h     |  3 ---
 include/linux/splice.h |  7 +++++++
 8 files changed, 22 insertions(+), 48 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index f11de6e1f1c1..d380d9dad0e0 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -3090,8 +3090,8 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 				     len, flags);
 
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src_file, src_off, dst_file,
-					      dst_off, len, flags);
+		ret = splice_copy_file_range(src_file, src_off, dst_file,
+					     dst_off, len);
 	return ret;
 }
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index a660f1f21540..148a71b8b4d0 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -19,6 +19,7 @@
 #include <linux/uio.h>
 #include <linux/fs.h>
 #include <linux/filelock.h>
+#include <linux/splice.h>
 
 static int fuse_send_open(struct fuse_mount *fm, u64 nodeid,
 			  unsigned int open_flags, int opcode,
@@ -3195,8 +3196,8 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
 				     len, flags);
 
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(src_file, src_off, dst_file,
-					      dst_off, len, flags);
+		ret = splice_copy_file_range(src_file, src_off, dst_file,
+					     dst_off, len);
 	return ret;
 }
 
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index 02788c3c85e5..e238abc78a13 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -10,6 +10,7 @@
 #include <linux/mount.h>
 #include <linux/nfs_fs.h>
 #include <linux/nfs_ssc.h>
+#include <linux/splice.h>
 #include "delegation.h"
 #include "internal.h"
 #include "iostat.h"
@@ -195,8 +196,8 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
 				     flags);
 	if (ret == -EOPNOTSUPP || ret == -EXDEV)
-		ret = generic_copy_file_range(file_in, pos_in, file_out,
-					      pos_out, count, flags);
+		ret = splice_copy_file_range(file_in, pos_in, file_out,
+					     pos_out, count);
 	return ret;
 }
 
diff --git a/fs/read_write.c b/fs/read_write.c
index 7783b8522693..e3abf603eaaf 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1396,40 +1396,6 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 }
 #endif
 
-/**
- * generic_copy_file_range - copy data between two files
- * @file_in:	file structure to read from
- * @pos_in:	file offset to read from
- * @file_out:	file structure to write data to
- * @pos_out:	file offset to write data to
- * @len:	amount of data to copy
- * @flags:	copy flags
- *
- * This is a generic filesystem helper to copy data from one file to another.
- * It has no constraints on the source or destination file owners - the files
- * can belong to different superblocks and different filesystem types. Short
- * copies are allowed.
- *
- * This should be called from the @file_out filesystem, as per the
- * ->copy_file_range() method.
- *
- * Returns the number of bytes copied or a negative error indicating the
- * failure.
- */
-
-ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-				struct file *file_out, loff_t pos_out,
-				size_t len, unsigned int flags)
-{
-	/* May only be called from within ->copy_file_range() methods */
-	if (WARN_ON_ONCE(flags))
-		return -EINVAL;
-
-	return splice_file_range(file_in, &pos_in, file_out, &pos_out,
-				 min_t(size_t, len, MAX_RW_COUNT));
-}
-EXPORT_SYMBOL(generic_copy_file_range);
-
 /*
  * Performs necessary checks before doing a file copy
  *
diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index ea3a7a668b45..ee461bf0ef63 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -25,6 +25,7 @@
 #include <linux/freezer.h>
 #include <linux/namei.h>
 #include <linux/random.h>
+#include <linux/splice.h>
 #include <linux/uuid.h>
 #include <linux/xattr.h>
 #include <uapi/linux/magic.h>
@@ -1362,8 +1363,8 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 	free_xid(xid);
 
 	if (rc == -EOPNOTSUPP || rc == -EXDEV)
-		rc = generic_copy_file_range(src_file, off, dst_file,
-					     destoff, len, flags);
+		rc = splice_copy_file_range(src_file, off, dst_file,
+					    destoff, len);
 	return rc;
 }
 
diff --git a/fs/splice.c b/fs/splice.c
index 13030ce192d9..5cce69e9da12 100644
--- a/fs/splice.c
+++ b/fs/splice.c
@@ -1243,7 +1243,7 @@ EXPORT_SYMBOL(do_splice_direct);
  * @len:	number of bytes to splice
  *
  * Description:
- *    For use by generic_copy_file_range() and ->copy_file_range() methods.
+ *    For use by ->copy_file_range() methods.
  *    Like do_splice_direct(), but vfs_copy_file_range() already holds
  *    start_file_write() on @out file.
  *
@@ -1254,8 +1254,9 @@ ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 {
 	lockdep_assert(file_write_started(out));
 
-	return do_splice_direct_actor(in, ppos, out, opos, len, 0,
-				      splice_file_range_actor);
+	return do_splice_direct_actor(in, ppos, out, opos,
+				      min_t(size_t, len, MAX_RW_COUNT),
+				      0, splice_file_range_actor);
 }
 EXPORT_SYMBOL(splice_file_range);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 04422a0eccdd..900d0cd55b50 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2090,9 +2090,6 @@ extern ssize_t vfs_read(struct file *, char __user *, size_t, loff_t *);
 extern ssize_t vfs_write(struct file *, const char __user *, size_t, loff_t *);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
-extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
-				       struct file *file_out, loff_t pos_out,
-				       size_t len, unsigned int flags);
 int __generic_remap_file_range_prep(struct file *file_in, loff_t pos_in,
 				    struct file *file_out, loff_t pos_out,
 				    loff_t *len, unsigned int remap_flags,
diff --git a/include/linux/splice.h b/include/linux/splice.h
index 068a8e8ffd73..9dec4861d09f 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -88,6 +88,13 @@ ssize_t do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 ssize_t splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 			  loff_t *opos, size_t len);
 
+static inline long splice_copy_file_range(struct file *in, loff_t pos_in,
+					  struct file *out, loff_t pos_out,
+					  size_t len)
+{
+	return splice_file_range(in, &pos_in, out, &pos_out, len);
+}
+
 ssize_t do_tee(struct file *in, struct file *out, size_t len,
 	       unsigned int flags);
 ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
-- 
2.34.1



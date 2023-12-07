Return-Path: <linux-fsdevel+bounces-5150-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 303F0808AB5
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 15:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A656B20F84
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C0DB4436F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Dec 2023 14:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PhO7ziab"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F67210D
	for <linux-fsdevel@vger.kernel.org>; Thu,  7 Dec 2023 04:38:36 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3332f1512e8so803016f8f.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 07 Dec 2023 04:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701952714; x=1702557514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X9M7pWIKBdDtotGC+N9xKXKIlgNDiYwgLVF9+Q4cIDk=;
        b=PhO7ziab4/J8ndmeN+oLfUDZvzrHpkDPPH6kw4GR6wn5QQ61E3TVGBpbCvfAsvaNhq
         9tfMtf49+E8wfxCeUMrc8CWJK83dXCWHzgcPgFiR8jOD8ELceHLVvBi0T7OXLgH7MMs6
         RJVS7fW+O5BcJerOiet8KzjQ58CDYuYD33GhcK22MatUIvU6syJf07WAlJIDVN8Dztzg
         /7CxAr6OXW23pp0sqh+sRldpuCYFyMcCMXCyGFfqyzf+oZTzkD7mPjHJ2jQelhQkpSFk
         R604/xbXFWH9mmZ2wV9/B9yuioqDfnPeQOj4ONWEuHaQq1BO9ZOtAYy2/hcdYEnBnleO
         eIDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701952714; x=1702557514;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X9M7pWIKBdDtotGC+N9xKXKIlgNDiYwgLVF9+Q4cIDk=;
        b=mUX+w2yIDuknhjz/et7Dv+gaweTniEk/3TJuXbYrqyPtJgc2NmjI4sxCaTsrrogJgn
         79obYKmxYP3Z43uv6J/nYAip7rQbjwhIcWE2eNOyrIuYOnZRNghutsin5xjVtjeLtoO/
         AHZcSI1skgBN5LhAaFmI8FYJMi7v2kW6CTLFdUVrT60N65vLac5St+C7HNL1nJzJEAaG
         fYvKCSwKW/VBeCnEOEIRrXeK8mFXZMhIa3hfbNzaDEAvSk0uWILZ0ZWY1N1YhcY3R5KW
         rvRDkAC0r75ASMIoAHcVMKJgrzuAZyGIarW8KOg43uy+ZYE9NNIaY4/P0DR7/7ZG7x0g
         KrQw==
X-Gm-Message-State: AOJu0YydcHB/WIjkm1WjT0diH0laOYa8MlKLC700M/hoCBcaXEIyGSyw
	KFbuOZvfoa1jZdSAPtulJYc=
X-Google-Smtp-Source: AGHT+IFuNkGJnJ7z8NF7XAiBnkmGVYD+i+ZNuROCpZmkt74hS+PzoM8fa0aHL/7Eqm3authfIkUjNg==
X-Received: by 2002:a05:6000:4f0:b0:333:42ac:2009 with SMTP id cr16-20020a05600004f000b0033342ac2009mr1460686wrb.96.1701952714300;
        Thu, 07 Dec 2023 04:38:34 -0800 (PST)
Received: from amir-ThinkPad-T480.lan ([5.29.249.86])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d4c91000000b003333abf3edfsm1332431wrs.47.2023.12.07.04.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 04:38:33 -0800 (PST)
From: Amir Goldstein <amir73il@gmail.com>
To: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>
Cc: Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Christoph Hellwig <hch@lst.de>,
	David Howells <dhowells@redhat.com>,
	Jens Axboe <axboe@kernel.dk>,
	Miklos Szeredi <miklos@szeredi.hu>,
	Al Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/4] fs: use splice_copy_file_range() inline helper
Date: Thu,  7 Dec 2023 14:38:22 +0200
Message-Id: <20231207123825.4011620-2-amir73il@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231207123825.4011620-1-amir73il@gmail.com>
References: <20231207123825.4011620-1-amir73il@gmail.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic_copy_file_range() is just a wrapper around splice_file_range().
Move the wrapper to splice.h and rename it to splice_copy_file_range().

Suggested-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/linux-fsdevel/20231204083849.GC32438@lst.de/
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ceph/file.c         |  4 ++--
 fs/fuse/file.c         |  5 +++--
 fs/nfs/nfs4file.c      |  5 +++--
 fs/read_write.c        | 34 ----------------------------------
 fs/smb/client/cifsfs.c |  5 +++--
 fs/splice.c            |  2 +-
 include/linux/fs.h     |  3 ---
 include/linux/splice.h |  8 ++++++++
 8 files changed, 20 insertions(+), 46 deletions(-)

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
index 01a14570015b..97a9d5c7ad96 100644
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
index 7cda013e5a1e..24bd93f8e4c3 100644
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
index 49532d5dda52..b92c4676c59b 100644
--- a/include/linux/splice.h
+++ b/include/linux/splice.h
@@ -89,6 +89,14 @@ long do_splice_direct(struct file *in, loff_t *ppos, struct file *out,
 long splice_file_range(struct file *in, loff_t *ppos, struct file *out,
 		       loff_t *opos, size_t len);
 
+static inline long splice_copy_file_range(struct file *in, loff_t pos_in,
+					  struct file *out, loff_t pos_out,
+					  size_t len)
+{
+	return splice_file_range(in, &pos_in, out, &pos_out,
+				      min_t(size_t, len, MAX_RW_COUNT));
+}
+
 extern long do_tee(struct file *in, struct file *out, size_t len,
 		   unsigned int flags);
 extern ssize_t splice_to_socket(struct pipe_inode_info *pipe, struct file *out,
-- 
2.34.1



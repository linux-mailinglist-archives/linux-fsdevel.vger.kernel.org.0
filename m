Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1C362A8AE
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 08:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727614AbfEZGLS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 02:11:18 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:39172 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbfEZGLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 02:11:18 -0400
Received: by mail-wr1-f67.google.com with SMTP id e2so4888465wrv.6;
        Sat, 25 May 2019 23:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jgXNJIA/nufnSnu4+ud/rPiS77zTsD8AMGRWTfgrrqI=;
        b=qZUVMDlLTY5u48xqKNt2w8xJCocDSQbQTiZpComnmGilfzawivtwGXUU3h9ENBawCi
         v9IO2altJLQZSSvTAYMD6KlL/uPXq+bNFosUyAhXpNGgBp2usMGu6bklaSO5c1eRheq2
         wQhaEo6jbwDgC+SBq4e+WLKrXUetgCTslUeKJrquC7i5u85YS9nrkXN+QH2wd12DMK5d
         ltOWV0AMfKHGWKhDn/SOOSAL8IQuMr3fZHH9im1KiYyzZH+9dtb6tH7w41jgfjLSOOEz
         Kjj3iFQP/6GfWPlckFwHUJrTFh2Snj2KU6Fn5wYAy/esVDztvqHrcw5mzCfGgvjciFyJ
         U5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jgXNJIA/nufnSnu4+ud/rPiS77zTsD8AMGRWTfgrrqI=;
        b=LKik462Ay4N+azunjrAXm7xGrdY5A85h3zqV2WDeWJXpMIn6FZU+SCY+YpAmjqClLp
         YlDICDgQPNIqEbzKj+JN34p/Qa4Isfl6e/YHeRLZLQwzlE6y8e4yN18BlMCLRuBVGAy6
         rGlwAakDBhyJsK2A27IHRuxTAcfrcT4B1sH2WrVwydD06Gu0VHpJVKGOQzFb2yimbm0m
         eXjndP/dyLDiU7/2jsvRPoVayM7w8EyGSTZD+ms/ocltdsGfAkS0yTHgVebokC+96Opa
         GS031k50wCHWivD3zH4pyaTAY6JdofPdK4oqzKlcDNAaqW/hhC/+hlmF3jvvuXrb71LA
         g+sw==
X-Gm-Message-State: APjAAAWIEGTf14hpKbIUQgZYeHE3UIoCzTENypcRK41EFNMGhE9A2WPu
        0W4doB8Mfz0NuYnaixE7irs=
X-Google-Smtp-Source: APXvYqxBB82jF58w2www0dce/6FsyXzVsg1H1geXVnY2uwxAbw5pTgWOEPJAcKprd0J4DWnKAtngVA==
X-Received: by 2002:adf:8023:: with SMTP id 32mr6413925wrk.18.1558851075589;
        Sat, 25 May 2019 23:11:15 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id a124sm5302943wmh.3.2019.05.25.23.11.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 23:11:15 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-api@vger.kernel.org,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v2 2/8] vfs: no fallback for ->copy_file_range
Date:   Sun, 26 May 2019 09:10:53 +0300
Message-Id: <20190526061100.21761-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526061100.21761-1-amir73il@gmail.com>
References: <20190526061100.21761-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Dave Chinner <dchinner@redhat.com>

Now that we have generic_copy_file_range(), remove it as a fallback
case when offloads fail. This puts the responsibility for executing
fallbacks on the filesystems that implement ->copy_file_range and
allows us to add operational validity checks to
generic_copy_file_range().

Rework vfs_copy_file_range() to call a new do_copy_file_range()
helper to exceute the copying callout, and move calls to
generic_file_copy_range() into filesystem methods where they
currently return failures.

[Amir] overlayfs is not responsible of executing the fallback.
It is the responsibility of the underlying filesystem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ceph/file.c    | 21 ++++++++++++++++++---
 fs/cifs/cifsfs.c  |  4 ++++
 fs/fuse/file.c    | 21 ++++++++++++++++++---
 fs/nfs/nfs4file.c | 20 +++++++++++++++++---
 fs/read_write.c   | 25 ++++++++++++++++---------
 5 files changed, 73 insertions(+), 18 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 305daf043eb0..e87f7b2023af 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1889,9 +1889,9 @@ static int is_file_size_ok(struct inode *src_inode, struct inode *dst_inode,
 	return 0;
 }
 
-static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
-				    struct file *dst_file, loff_t dst_off,
-				    size_t len, unsigned int flags)
+static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
+				      struct file *dst_file, loff_t dst_off,
+				      size_t len, unsigned int flags)
 {
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *dst_inode = file_inode(dst_file);
@@ -2100,6 +2100,21 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
 	return ret;
 }
 
+static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
+				    struct file *dst_file, loff_t dst_off,
+				    size_t len, unsigned int flags)
+{
+	ssize_t ret;
+
+	ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
+				     len, flags);
+
+	if (ret == -EOPNOTSUPP)
+		ret = generic_copy_file_range(src_file, src_off, dst_file,
+					      dst_off, len, flags);
+	return ret;
+}
+
 const struct file_operations ceph_file_fops = {
 	.open = ceph_open,
 	.release = ceph_release,
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f5fcd6360056..c65823270313 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1148,6 +1148,10 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
 	rc = cifs_file_copychunk_range(xid, src_file, off, dst_file, destoff,
 					len, flags);
 	free_xid(xid);
+
+	if (rc == -EOPNOTSUPP)
+		rc = generic_copy_file_range(src_file, off, dst_file,
+					     destoff, len, flags);
 	return rc;
 }
 
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 3959f08279e6..e03901ae729b 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3097,9 +3097,9 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 	return err;
 }
 
-static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
-				    struct file *file_out, loff_t pos_out,
-				    size_t len, unsigned int flags)
+static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      size_t len, unsigned int flags)
 {
 	struct fuse_file *ff_in = file_in->private_data;
 	struct fuse_file *ff_out = file_out->private_data;
@@ -3173,6 +3173,21 @@ static ssize_t fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 	return err;
 }
 
+static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
+				    struct file *dst_file, loff_t dst_off,
+				    size_t len, unsigned int flags)
+{
+	ssize_t ret;
+
+	ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
+				     len, flags);
+
+	if (ret == -EOPNOTSUPP)
+		ret = generic_copy_file_range(src_file, src_off, dst_file,
+					      dst_off, len, flags);
+	return ret;
+}
+
 static const struct file_operations fuse_file_operations = {
 	.llseek		= fuse_file_llseek,
 	.read_iter	= fuse_file_read_iter,
diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index cf42a8b939e3..4842f3ab3161 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -129,9 +129,9 @@ nfs4_file_flush(struct file *file, fl_owner_t id)
 }
 
 #ifdef CONFIG_NFS_V4_2
-static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
-				    struct file *file_out, loff_t pos_out,
-				    size_t count, unsigned int flags)
+static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
+				      struct file *file_out, loff_t pos_out,
+				      size_t count, unsigned int flags)
 {
 	if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
 		return -EOPNOTSUPP;
@@ -140,6 +140,20 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	return nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count);
 }
 
+static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
+				    struct file *file_out, loff_t pos_out,
+				    size_t count, unsigned int flags)
+{
+	ssize_t ret;
+
+	ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
+				     flags);
+	if (ret == -EOPNOTSUPP)
+		ret = generic_copy_file_range(file_in, pos_in, file_out,
+					      pos_out, count, flags);
+	return ret;
+}
+
 static loff_t nfs4_file_llseek(struct file *filep, loff_t offset, int whence)
 {
 	loff_t ret;
diff --git a/fs/read_write.c b/fs/read_write.c
index 676b02fae589..b63dcb4e4fe9 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1595,6 +1595,19 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 }
 EXPORT_SYMBOL(generic_copy_file_range);
 
+static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
+				  struct file *file_out, loff_t pos_out,
+				  size_t len, unsigned int flags)
+{
+	if (file_out->f_op->copy_file_range)
+		return file_out->f_op->copy_file_range(file_in, pos_in,
+						       file_out, pos_out,
+						       len, flags);
+
+	return generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
+				       flags);
+}
+
 /*
  * copy_file_range() differs from regular file read and write in that it
  * specifically allows return partial success.  When it does so is up to
@@ -1655,15 +1668,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 		}
 	}
 
-	if (file_out->f_op->copy_file_range) {
-		ret = file_out->f_op->copy_file_range(file_in, pos_in, file_out,
-						      pos_out, len, flags);
-		if (ret != -EOPNOTSUPP)
-			goto done;
-	}
-
-	ret = generic_copy_file_range(file_in, pos_in, file_out, pos_out, len,
-				      flags);
+	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
+				flags);
+	WARN_ON_ONCE(ret == -EOPNOTSUPP);
 done:
 	if (ret > 0) {
 		fsnotify_access(file_in);
-- 
2.17.1


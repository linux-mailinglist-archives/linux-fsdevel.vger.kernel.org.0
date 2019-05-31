Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A500312C9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 18:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbfEaQrR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 12:47:17 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39827 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbfEaQrQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 12:47:16 -0400
Received: by mail-wm1-f65.google.com with SMTP id z23so6340819wma.4;
        Fri, 31 May 2019 09:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+W6U4ETnLrYkikxbMk/wh3iIEZoEwtztQ/QLH5NUi74=;
        b=s6OYwpzSfktPnuWB7OCyn3/Tl6N6XIqLaHNOX1vXUkGxdrkwC4RJZoEkNkg1Xz4Zki
         SeR2xx5Le7pQyBkCJ0EN/V2+8w7YmG59iFW9w6ovln0m8z6nyjnBNpC3BlFRz9JoBNdR
         s7hPvd/1F7vFW+rl6lsdkFuJPPw3+gVO9x35fKrIXjWZE+bMI9iekdg2uZzeFa8G/oBM
         DFbXNFWhBPqBCSjMMHU4wKYNQg76gaA3ouC2HDo1py6TpnM8Dl9+CPhKUxNRj+LBHGRV
         HrscDpDVoVUHPCMiRmAkudCmrsut3SNYFC8MgIXMYr1mglvyX3anOn/6pKadkjq+yjPz
         Hb5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+W6U4ETnLrYkikxbMk/wh3iIEZoEwtztQ/QLH5NUi74=;
        b=lPUHaR5auXw9NUnBczbEOGB0YRdbVrQlF69WH56gcb2LhbnhIVMVNXKFOslI7Mj30f
         g8TGMG0+W1HTbRSIRWDKtNE2tIntH39ENyK+IhmpGg5hEamGvF2KWHqkZhToPq4iVrky
         aQwStAfDrKWwk4A21Ff6fbk7FlLf0HcMjeviKrgQhml9t2Vl5z9BlhSmZrRiB+25N3w1
         grpMY3W3twKlasDH3ZSVsMos+3WsyLnrNsDgG3lESIoAhymSw9jPBQ+hczOBO56zdclf
         jWZY+l/VoZSeLAWB31wJ/yt7Fkf9XLaCVC8A+aSqhfqjA0rTtc8yjDdNpJQ1OYu4/mr0
         yaWA==
X-Gm-Message-State: APjAAAWEwVPJhoxMeNY7C+j/Jvoipcq3u+9R+Ro+zSKkF6ff5l1hn9Sp
        F2O4VjKIdZlylIE6clPpChBN/2v7
X-Google-Smtp-Source: APXvYqzKDScvDo0NdEwGNoYdjUwALmg5duYiEBzHqOazCGLCpbYM2Vr2iMvo78lm8PF+PPP0I3I77Q==
X-Received: by 2002:a1c:c545:: with SMTP id v66mr6486620wmf.51.1559321232909;
        Fri, 31 May 2019 09:47:12 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id n5sm7669593wrj.27.2019.05.31.09.47.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 31 May 2019 09:47:12 -0700 (PDT)
From:   Amir Goldstein <amir73il@gmail.com>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     Dave Chinner <david@fromorbit.com>, Christoph Hellwig <hch@lst.de>,
        linux-xfs@vger.kernel.org,
        Olga Kornievskaia <olga.kornievskaia@gmail.com>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v4 2/9] vfs: no fallback for ->copy_file_range
Date:   Fri, 31 May 2019 19:46:54 +0300
Message-Id: <20190531164701.15112-3-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190531164701.15112-1-amir73il@gmail.com>
References: <20190531164701.15112-1-amir73il@gmail.com>
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
helper to execute the copying callout, and move calls to
generic_file_copy_range() into filesystem methods where they
currently return failures.

[Amir] overlayfs is not responsible of executing the fallback.
It is the responsibility of the underlying filesystem.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
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


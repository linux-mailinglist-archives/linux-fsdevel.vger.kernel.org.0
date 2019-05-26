Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 164E02A8B3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 26 May 2019 08:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbfEZGLY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 26 May 2019 02:11:24 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41862 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbfEZGLX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 26 May 2019 02:11:23 -0400
Received: by mail-wr1-f67.google.com with SMTP id u16so9758466wrn.8;
        Sat, 25 May 2019 23:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hJpvGqVp0Vug8Mb9iaO6z9l1/zymJ1J3cdRetJYK7Bs=;
        b=IeDwTgfuxfRv8fbd84IwJcTY9Vp+VW76FKym3uEZDvVdCBni0KrbSiX7Dv0iZNVeVM
         Nb9l2O9jRVuhHy++ZVNB7UAskPKj3nJ63Q+GT0dVc6r1sJ+okcMB754x6aPrHxMAMvdO
         tBLNIh66tCfJoToi/6NXxvqF+P95e+j0FJXieWr+o7xfSo05WoOGNAUUX3HYqoAEjjvT
         yumMhT5vHLclYix4hqMDq8Qj/Emgq42jLLaWYbs6tV3RQjD/eMHD29CEu4Rte9w/KwAG
         /u24JEKv/lper0CQMYgsG3fxl62EEYpywonbw4QP4HBlNmglldpqpv3laVt/HBTaBvAq
         7BsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hJpvGqVp0Vug8Mb9iaO6z9l1/zymJ1J3cdRetJYK7Bs=;
        b=NWgIjrCAvXrrGR1+56DSF9A3fUlvHrB2eIH5ZfVLpWhfmuTvjSa29NT4niDwMcozmk
         GAt2aHzI8gVasI2LO4XwsdLXzzgKtVsnEdmOF9k6At1OHyqAMwApTkMUrCft+UBszgO+
         1NOdJ/oMKz06GTGqy+hLiSylN4Pmr0DaJnGSP1TpDYR4AKD1vGWX+vcl+FJ2whYCL++1
         6zUX4gsAWW2OqQwNxgWnDfaH/rJ2AoLvoTj5u1pGGFZsWQ3csIGXIj2rXZcvhTTLzun3
         i1ojqDOVs9hTQJa+zyMSDgveVytuJfHnZAfZpeBriAVIrMFRLI7eTfSszTdcs8Ysn5vv
         kObA==
X-Gm-Message-State: APjAAAX1i9V0iZAkD2gh04y69aMPkbUgEGAj7pp7xVILoW7ezNBA2QEO
        s5MzVYRNV5JVASkqp8Nijz0=
X-Google-Smtp-Source: APXvYqwbq/jPIu7D1yhioAjiMprkENPZG1N9iFKs4h3m4EtO0EM6SfViM5nzs7W10hTmaWtq+O2qUg==
X-Received: by 2002:adf:dc8e:: with SMTP id r14mr55228894wrj.121.1558851081412;
        Sat, 25 May 2019 23:11:21 -0700 (PDT)
Received: from localhost.localdomain ([5.102.238.208])
        by smtp.gmail.com with ESMTPSA id a124sm5302943wmh.3.2019.05.25.23.11.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 May 2019 23:11:20 -0700 (PDT)
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
Subject: [PATCH v2 5/8] vfs: copy_file_range needs to strip setuid bits
Date:   Sun, 26 May 2019 09:10:56 +0300
Message-Id: <20190526061100.21761-6-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190526061100.21761-1-amir73il@gmail.com>
References: <20190526061100.21761-1-amir73il@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The file we are copying data into needs to have its setuid bit
stripped before we start the data copy so that unprivileged users
can't copy data into executables that are run with root privs.

[Amir] Introduce the helper generic_copy_file_range_prep() modelled
after generic_remap_file_range_prep(). Helper is called by filesystem
before the copy_file_range operation and with output inode locked.

For ceph and for default generic_copy_file_range() implementation there
is no inode lock held throughout the copy operation, so we do best
effort and remove setuid bit before copy starts. This does not protect
suid file from changing if suid bit is set after copy started.

Signed-off-by: Dave Chinner <dchinner@redhat.com>
Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 fs/ceph/file.c     |  9 +++++++++
 fs/cifs/cifsfs.c   |  9 ++++++---
 fs/fuse/file.c     |  4 ++++
 fs/nfs/nfs42proc.c |  8 +++++---
 fs/read_write.c    | 31 +++++++++++++++++++++++++++++++
 include/linux/fs.h |  2 ++
 6 files changed, 57 insertions(+), 6 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index e87f7b2023af..54cfc877a6ef 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1947,6 +1947,15 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		goto out;
 	}
 
+	/* Should inode lock be held throughout the copy operation? */
+	inode_lock(dst_inode);
+	ret = generic_copy_file_range_prep(src_file, dst_file);
+	inode_unlock(dst_inode);
+	if (ret < 0) {
+		dout("failed to copy from src to dst file (%zd)\n", ret);
+		goto out;
+	}
+
 	/*
 	 * We need FILE_WR caps for dst_ci and FILE_RD for src_ci as other
 	 * clients may have dirty data in their caches.  And OSDs know nothing
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index c65823270313..e103b499aaa8 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1096,6 +1096,10 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 		goto out;
 	}
 
+	rc = -EOPNOTSUPP;
+	if (!target_tcon->ses->server->ops->copychunk_range)
+		goto out;
+
 	/*
 	 * Note: cifs case is easier than btrfs since server responsible for
 	 * checks for proper open modes and file type and if it wants
@@ -1107,11 +1111,10 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	/* should we flush first and last page first */
 	truncate_inode_pages(&target_inode->i_data, 0);
 
-	if (target_tcon->ses->server->ops->copychunk_range)
+	rc = generic_copy_file_range_prep(src_file, dst_file);
+	if (!rc)
 		rc = target_tcon->ses->server->ops->copychunk_range(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
-	else
-		rc = -EOPNOTSUPP;
 
 	/* force revalidate of size and timestamps of target file now
 	 * that target is updated on the server
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index e03901ae729b..3531d4a3d9ec 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3128,6 +3128,10 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
 
 	inode_lock(inode_out);
 
+	err = generic_copy_file_range_prep(file_in, file_out);
+	if (err)
+		goto out;
+
 	if (fc->writeback_cache) {
 		err = filemap_write_and_wait_range(inode_out->i_mapping,
 						   pos_out, pos_out + len);
diff --git a/fs/nfs/nfs42proc.c b/fs/nfs/nfs42proc.c
index 5196bfa7894d..b387951e1d86 100644
--- a/fs/nfs/nfs42proc.c
+++ b/fs/nfs/nfs42proc.c
@@ -345,9 +345,11 @@ ssize_t nfs42_proc_copy(struct file *src, loff_t pos_src,
 
 	do {
 		inode_lock(file_inode(dst));
-		err = _nfs42_proc_copy(src, src_lock,
-				dst, dst_lock,
-				&args, &res);
+		err = generic_copy_file_range_prep(src, dst);
+		if (!err)
+			err = _nfs42_proc_copy(src, src_lock,
+					       dst, dst_lock,
+					       &args, &res);
 		inode_unlock(file_inode(dst));
 
 		if (err >= 0)
diff --git a/fs/read_write.c b/fs/read_write.c
index b0fb1176b628..e16bcafc0da2 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1565,6 +1565,28 @@ COMPAT_SYSCALL_DEFINE4(sendfile64, int, out_fd, int, in_fd,
 }
 #endif
 
+/*
+ * Prepare inodes for copy from @file_in to @file_out.
+ *
+ * Caller must hold output inode lock.
+ */
+int generic_copy_file_range_prep(struct file *file_in, struct file *file_out)
+{
+	int ret;
+
+	WARN_ON_ONCE(!inode_is_locked(file_inode(file_out)));
+
+	/*
+	 * Clear the security bits if the process is not being run by root.
+	 * This keeps people from modifying setuid and setgid binaries.
+	 */
+	ret = file_remove_privs(file_out);
+
+	return ret;
+
+}
+EXPORT_SYMBOL(generic_copy_file_range_prep);
+
 /**
  * generic_copy_file_range - copy data between two files
  * @file_in:	file structure to read from
@@ -1590,6 +1612,15 @@ ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				struct file *file_out, loff_t pos_out,
 				size_t len, unsigned int flags)
 {
+	int ret;
+
+	/* Should inode lock be held throughout the copy operation? */
+	inode_lock(file_inode(file_out));
+	ret = generic_copy_file_range_prep(file_in, file_out);
+	inode_unlock(file_inode(file_out));
+	if (ret)
+		return ret;
+
 	return do_splice_direct(file_in, &pos_in, file_out, &pos_out,
 				len > MAX_RW_COUNT ? MAX_RW_COUNT : len, 0);
 }
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e4d382c4342a..3e03a96d9ab6 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1889,6 +1889,8 @@ extern ssize_t vfs_readv(struct file *, const struct iovec __user *,
 		unsigned long, loff_t *, rwf_t);
 extern ssize_t vfs_copy_file_range(struct file *, loff_t , struct file *,
 				   loff_t, size_t, unsigned int);
+extern int generic_copy_file_range_prep(struct file *file_in,
+					struct file *file_out);
 extern ssize_t generic_copy_file_range(struct file *file_in, loff_t pos_in,
 				       struct file *file_out, loff_t pos_out,
 				       size_t len, unsigned int flags);
-- 
2.17.1


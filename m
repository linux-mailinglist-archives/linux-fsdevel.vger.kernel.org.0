Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B044231DE1E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Feb 2021 18:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbhBQR0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Feb 2021 12:26:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:34706 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230179AbhBQR0h (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Feb 2021 12:26:37 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7BA78B7C2;
        Wed, 17 Feb 2021 17:25:54 +0000 (UTC)
Received: from localhost (brahms [local])
        by brahms (OpenSMTPD) with ESMTPA id 04828e09;
        Wed, 17 Feb 2021 17:26:56 +0000 (UTC)
From:   Luis Henriques <lhenriques@suse.de>
To:     Amir Goldstein <amir73il@gmail.com>,
        Jeff Layton <jlayton@kernel.org>,
        Steve French <sfrench@samba.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Ian Lance Taylor <iant@google.com>,
        Luis Lozano <llozano@chromium.org>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        Luis Henriques <lhenriques@suse.de>
Subject: [PATCH v3] vfs: fix copy_file_range regression in cross-fs copies
Date:   Wed, 17 Feb 2021 17:26:54 +0000
Message-Id: <20210217172654.22519-1-lhenriques@suse.de>
In-Reply-To: <CAOQ4uxii=7KUKv1w32VbjkwS+Z1a0ge0gezNzpn_BiY6MFWkpA@mail.gmail.com>
References: <CAOQ4uxii=7KUKv1w32VbjkwS+Z1a0ge0gezNzpn_BiY6MFWkpA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A regression has been reported by Nicolas Boichat, found while using the
copy_file_range syscall to copy a tracefs file.  Before commit
5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices") the
kernel would return -EXDEV to userspace when trying to copy a file across
different filesystems.  After this commit, the syscall doesn't fail anymore
and instead returns zero (zero bytes copied), as this file's content is
generated on-the-fly and thus reports a size of zero.

This patch restores some cross-filesystems copy restrictions that existed
prior to commit 5dae222a5ff0 ("vfs: allow copy_file_range to copy across
devices").  It also introduces a flag (COPY_FILE_SPLICE) that can be used
by filesystems calling directly into the vfs copy_file_range to override
these restrictions.  Right now, only NFS needs to set this flag.

Fixes: 5dae222a5ff0 ("vfs: allow copy_file_range to copy across devices")
Link: https://lore.kernel.org/linux-fsdevel/20210212044405.4120619-1-drinkcat@chromium.org/
Link: https://lore.kernel.org/linux-fsdevel/CANMq1KDZuxir2LM5jOTm0xx+BnvW=ZmpsG47CyHFJwnw7zSX6Q@mail.gmail.com/
Link: https://lore.kernel.org/linux-fsdevel/20210126135012.1.If45b7cdc3ff707bc1efa17f5366057d60603c45f@changeid/
Reported-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Luis Henriques <lhenriques@suse.de>
---
Ok, I've tried to address all the issues and comments.  Hopefully this v3
is a bit closer to the final fix.

Changes since v2
- do all the required checks earlier, in generic_copy_file_checks(),
  adding new checks for ->remap_file_range
- new COPY_FILE_SPLICE flag
- don't remove filesystem's fallback to generic_copy_file_range()
- updated commit changelog (and subject)
Changes since v1 (after Amir review)
- restored do_copy_file_range() helper
- return -EOPNOTSUPP if fs doesn't implement CFR
- updated commit description

 fs/nfsd/vfs.c      |  3 ++-
 fs/read_write.c    | 44 +++++++++++++++++++++++++++++++++++++++++---
 include/linux/fs.h |  7 +++++++
 3 files changed, 50 insertions(+), 4 deletions(-)

diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 04937e51de56..14e55822c223 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -578,7 +578,8 @@ ssize_t nfsd_copy_file_range(struct file *src, u64 src_pos, struct file *dst,
 	 * limit like this and pipeline multiple COPY requests.
 	 */
 	count = min_t(u64, count, 1 << 22);
-	return vfs_copy_file_range(src, src_pos, dst, dst_pos, count, 0);
+	return vfs_copy_file_range(src, src_pos, dst, dst_pos, count,
+				   COPY_FILE_SPLICE);
 }
 
 __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
diff --git a/fs/read_write.c b/fs/read_write.c
index 75f764b43418..40a16003fb05 100644
--- a/fs/read_write.c
+++ b/fs/read_write.c
@@ -1410,6 +1410,33 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
 				       flags);
 }
 
+/*
+ * This helper function checks whether copy_file_range can actually be used,
+ * depending on the source and destination filesystems being the same.
+ *
+ * In-kernel callers may set COPY_FILE_SPLICE to override these checks.
+ */
+static int fops_copy_file_checks(struct file *file_in, struct file *file_out,
+				 unsigned int flags)
+{
+	if (WARN_ON_ONCE(flags & ~COPY_FILE_SPLICE))
+		return -EINVAL;
+
+	if (flags & COPY_FILE_SPLICE)
+		return 0;
+	/*
+	 * We got here from userspace, so forbid copies if copy_file_range isn't
+	 * implemented or if we're doing a cross-fs copy.
+	 */
+	if (!file_out->f_op->copy_file_range)
+		return -EOPNOTSUPP;
+	else if (file_out->f_op->copy_file_range !=
+		 file_in->f_op->copy_file_range)
+		return -EXDEV;
+
+	return 0;
+}
+
 /*
  * Performs necessary checks before doing a file copy
  *
@@ -1427,6 +1454,14 @@ static int generic_copy_file_checks(struct file *file_in, loff_t pos_in,
 	loff_t size_in;
 	int ret;
 
+	/* Only check f_ops if we're not trying to clone */
+	if (!file_in->f_op->remap_file_range ||
+	    (file_inode(file_in)->i_sb == file_inode(file_out)->i_sb)) {
+		ret = fops_copy_file_checks(file_in, file_out, flags);
+		if (ret)
+			return ret;
+	}
+
 	ret = generic_file_rw_checks(file_in, file_out);
 	if (ret)
 		return ret;
@@ -1474,9 +1509,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 {
 	ssize_t ret;
 
-	if (flags != 0)
-		return -EINVAL;
-
 	ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
 				       flags);
 	if (unlikely(ret))
@@ -1511,6 +1543,9 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
 			ret = cloned;
 			goto done;
 		}
+		ret = fops_copy_file_checks(file_in, file_out, flags);
+		if (ret)
+			return ret;
 	}
 
 	ret = do_copy_file_range(file_in, pos_in, file_out, pos_out, len,
@@ -1543,6 +1578,9 @@ SYSCALL_DEFINE6(copy_file_range, int, fd_in, loff_t __user *, off_in,
 	struct fd f_out;
 	ssize_t ret = -EBADF;
 
+	if (flags != 0)
+		return -EINVAL;
+
 	f_in = fdget(fd_in);
 	if (!f_in.file)
 		goto out2;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index fd47deea7c17..6f604926d955 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1815,6 +1815,13 @@ struct dir_context {
  */
 #define REMAP_FILE_ADVISORY		(REMAP_FILE_CAN_SHORTEN)
 
+/*
+ * This flag control the behavior of copy_file_range from internal (kernel)
+ * users.  It can be used to override the policy of forbidding copies when
+ * source and destination filesystems are different.
+ */
+#define COPY_FILE_SPLICE		(1 << 0)
+
 struct iov_iter;
 
 struct file_operations {

Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A127117004A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Feb 2020 14:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727255AbgBZNlY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Feb 2020 08:41:24 -0500
Received: from relay.sw.ru ([185.231.240.75]:44732 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726400AbgBZNlX (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Feb 2020 08:41:23 -0500
Received: from dhcp-172-16-24-104.sw.ru ([172.16.24.104] helo=localhost.localdomain)
        by relay.sw.ru with esmtp (Exim 4.92.3)
        (envelope-from <ktkhai@virtuozzo.com>)
        id 1j6wvs-0006rT-7k; Wed, 26 Feb 2020 16:41:00 +0300
Subject: [PATCH RFC 2/5] fs: Add new argument to vfs_fallocate()
From:   Kirill Tkhai <ktkhai@virtuozzo.com>
To:     tytso@mit.edu, viro@zeniv.linux.org.uk, adilger.kernel@dilger.ca,
        snitzer@redhat.com, jack@suse.cz, ebiggers@google.com,
        riteshh@linux.ibm.com, krisman@collabora.com, surajjs@amazon.com,
        ktkhai@virtuozzo.com, dmonakhov@gmail.com,
        mbobrowski@mbobrowski.org, enwlinux@gmail.com, sblbir@amazon.com,
        khazhy@google.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Date:   Wed, 26 Feb 2020 16:41:00 +0300
Message-ID: <158272446003.281342.778131694693628667.stgit@localhost.localdomain>
In-Reply-To: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
References: <158272427715.281342.10873281294835953645.stgit@localhost.localdomain>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch propagates @physical into vfs_fallocate().
No functional changes.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 drivers/nvme/target/io-cmd-file.c |    4 ++--
 fs/io_uring.c                     |    2 +-
 fs/ioctl.c                        |    5 +++--
 fs/nfsd/vfs.c                     |    2 +-
 fs/open.c                         |    7 ++++---
 fs/overlayfs/file.c               |    2 +-
 include/linux/fs.h                |    2 +-
 mm/madvise.c                      |    2 +-
 8 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index cd5670b83118..f86ea0dc4638 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -306,7 +306,7 @@ static void nvmet_file_execute_discard(struct nvmet_req *req)
 			break;
 		}
 
-		ret = vfs_fallocate(req->ns->file, mode, offset, len);
+		ret = vfs_fallocate(req->ns->file, mode, offset, len, (u64)-1);
 		if (ret && ret != -EOPNOTSUPP) {
 			req->error_slba = le64_to_cpu(range.slba);
 			status = errno_to_nvme_status(req, ret);
@@ -360,7 +360,7 @@ static void nvmet_file_write_zeroes_work(struct work_struct *w)
 		return;
 	}
 
-	ret = vfs_fallocate(req->ns->file, mode, offset, len);
+	ret = vfs_fallocate(req->ns->file, mode, offset, len, (u64)-1);
 	nvmet_req_complete(req, ret < 0 ? errno_to_nvme_status(req, ret) : 0);
 }
 
diff --git a/fs/io_uring.c b/fs/io_uring.c
index 8866bd60783f..03be497747da 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2512,7 +2512,7 @@ static void io_fallocate_finish(struct io_wq_work **workptr)
 		return;
 
 	ret = vfs_fallocate(req->file, req->sync.mode, req->sync.off,
-				req->sync.len);
+				req->sync.len, (u64)-1);
 	if (ret < 0)
 		req_set_fail_links(req);
 	io_cqring_add_event(req, ret);
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 282d45be6f45..5f3222434e05 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -502,7 +502,7 @@ static int ioctl_preallocate(struct file *filp, int mode, void __user *argp)
 	}
 
 	return vfs_fallocate(filp, mode | FALLOC_FL_KEEP_SIZE, sr.l_start,
-			sr.l_len);
+			sr.l_len, (u64)-1);
 }
 
 /* on ia32 l_start is on a 32-bit boundary */
@@ -530,7 +530,8 @@ static int compat_ioctl_preallocate(struct file *file, int mode,
 		return -EINVAL;
 	}
 
-	return vfs_fallocate(file, mode | FALLOC_FL_KEEP_SIZE, sr.l_start, sr.l_len);
+	return vfs_fallocate(file, mode | FALLOC_FL_KEEP_SIZE,
+			     sr.l_start, sr.l_len, (u64)-1);
 }
 #endif
 
diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
index 0aa02eb18bd3..a6b0acb795f5 100644
--- a/fs/nfsd/vfs.c
+++ b/fs/nfsd/vfs.c
@@ -590,7 +590,7 @@ __be32 nfsd4_vfs_fallocate(struct svc_rqst *rqstp, struct svc_fh *fhp,
 	if (!S_ISREG(file_inode(file)->i_mode))
 		return nfserr_inval;
 
-	error = vfs_fallocate(file, flags, offset, len);
+	error = vfs_fallocate(file, flags, offset, len, (u64)-1);
 	if (!error)
 		error = commit_metadata(fhp);
 
diff --git a/fs/open.c b/fs/open.c
index 73f27c9b518c..596fd3dc3988 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -226,7 +226,8 @@ SYSCALL_DEFINE2(ftruncate64, unsigned int, fd, loff_t, length)
 #endif /* BITS_PER_LONG == 32 */
 
 
-int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
+int vfs_fallocate(struct file *file, int mode,
+		  loff_t offset, loff_t len, u64 physical)
 {
 	struct inode *inode = file_inode(file);
 	long ret;
@@ -306,7 +307,7 @@ int vfs_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		return -EOPNOTSUPP;
 
 	file_start_write(file);
-	ret = file->f_op->fallocate(file, mode, offset, len, (u64)-1);
+	ret = file->f_op->fallocate(file, mode, offset, len, physical);
 
 	/*
 	 * Create inotify and fanotify events.
@@ -329,7 +330,7 @@ int ksys_fallocate(int fd, int mode, loff_t offset, loff_t len)
 	int error = -EBADF;
 
 	if (f.file) {
-		error = vfs_fallocate(f.file, mode, offset, len);
+		error = vfs_fallocate(f.file, mode, offset, len, (u64)-1);
 		fdput(f);
 	}
 	return error;
diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index abe34162d9d4..e1857861c7ba 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -476,7 +476,7 @@ static long ovl_fallocate(struct file *file, int mode,
 		return ret;
 
 	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fallocate(real.file, mode, offset, len);
+	ret = vfs_fallocate(real.file, mode, offset, len, (u64)-1);
 	revert_creds(old_cred);
 
 	/* Update size */
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 17c111e164d2..0222599a4b9b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2538,7 +2538,7 @@ extern long vfs_truncate(const struct path *, loff_t);
 extern int do_truncate(struct dentry *, loff_t start, unsigned int time_attrs,
 		       struct file *filp);
 extern int vfs_fallocate(struct file *file, int mode, loff_t offset,
-			loff_t len);
+			loff_t len, u64 physical);
 extern long do_sys_open(int dfd, const char __user *filename, int flags,
 			umode_t mode);
 extern struct file *file_open_name(struct filename *, int, umode_t);
diff --git a/mm/madvise.c b/mm/madvise.c
index 43b47d3fae02..89c2e8bab44a 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -849,7 +849,7 @@ static long madvise_remove(struct vm_area_struct *vma,
 	}
 	error = vfs_fallocate(f,
 				FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				offset, end - start);
+				offset, end - start, (u64)-1);
 	fput(f);
 	down_read(&current->mm->mmap_sem);
 	return error;



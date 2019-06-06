Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFFF36990
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Jun 2019 03:46:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbfFFBpO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jun 2019 21:45:14 -0400
Received: from mga03.intel.com ([134.134.136.65]:36140 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfFFBpM (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jun 2019 21:45:12 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jun 2019 18:45:11 -0700
X-ExtLoop1: 1
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga002.jf.intel.com with ESMTP; 05 Jun 2019 18:45:11 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>, Jeff Layton <jlayton@kernel.org>,
        Dave Chinner <david@fromorbit.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        linux-xfs@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        John Hubbard <jhubbard@nvidia.com>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-ext4@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH RFC 02/10] fs/locks: Export F_LAYOUT lease to user space
Date:   Wed,  5 Jun 2019 18:45:35 -0700
Message-Id: <20190606014544.8339-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190606014544.8339-1-ira.weiny@intel.com>
References: <20190606014544.8339-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

GUP longterm pins of non-pagecache file system pages (eg FS DAX) are
currently disallowed because they are unsafe.

The danger for pinning these pages comes from the fact that hole punch
and/or truncate of those files results in the pages being mapped and
pinned by a user space process while DAX has potentially allocated those
pages to other processes.

Most (All) users who are mapping FS DAX pages for long term pin purposes
(such as RDMA) are not going to want to deallocate these pages while
those pages are in use.  To do so would mean the application would lose
data.  So the use case for allowing truncate operations of such pages
is limited.

However, the kernel must protect itself and users from potential
mistakes and/or malicious user space code.  Rather than disabling long
term pins as is done now.   Allow for users who know they are going to
be pinning this memory to alert the file system of this intention.
Furthermore, allow users to be alerted such that they can react if a
truncate operation occurs for some reason.

Example user space pseudocode for a user using RDMA and wanting to allow
a truncate would look like this:

lease_break_sigio_handler() {
...
	if (sigio.fd == rdma_fd) {
		complete_rdma_operations(...);
		ibv_dereg_mr(mr);
		close(rdma_fd);
		fcntl(rdma_fd, F_SETLEASE, F_UNLCK);
	}
}

setup_rdma_to_dax_file() {
...
	rdma_fd = open(...)
	fcntl(rdma_fd, F_SETLEASE, F_LAYOUT);
	sigaction(SIGIO, ...  lease_break ...);
	ptr = mmap(rdma_fd, ...);
	mr = ibv_reg_mr(ptr, ...);
	do_rdma_stuff(...);
}

Follow on patches implement the notification of the lease holder on
truncate as well as failing the truncate if the GUP pin is not released.

This first patch exports the F_LAYOUT lease type and allows the user to set
and get it.

After the complete series:

1) Failure to obtain a F_LAYOUT lease on an open FS DAX file will result
   in a failure to GUP pin any pages in that file.  An example of a call
   which results in GUP pin is ibv_reg_mr().
2) While the GUP pin is in place (eg MR is in use) truncates of the
   affected pages will fail.
3) If the user registers a sigaction they will be notified of the
   truncate so they can react.  Failure to react will result in the
   lease being revoked after <sysfs>/lease-break-time seconds.  After
   this time new GUP pins will fail without a new lease being taken.
4) A truncate will work if the pages being truncated are not actively
   pinned at the time of truncate.  Attempts to pin these pages after
   will result in a failure.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/locks.c                       | 36 +++++++++++++++++++++++++++-----
 include/linux/fs.h               |  2 +-
 include/uapi/asm-generic/fcntl.h |  3 +++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 0cc2b9f30e22..de9761c068de 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -191,6 +191,8 @@ static int target_leasetype(struct file_lock *fl)
 		return F_UNLCK;
 	if (fl->fl_flags & FL_DOWNGRADE_PENDING)
 		return F_RDLCK;
+	if (fl->fl_flags & FL_LAYOUT)
+		return F_LAYOUT;
 	return fl->fl_type;
 }
 
@@ -611,7 +613,8 @@ static const struct lock_manager_operations lease_manager_ops = {
 /*
  * Initialize a lease, use the default lock manager operations
  */
-static int lease_init(struct file *filp, long type, struct file_lock *fl)
+static int lease_init(struct file *filp, long type, unsigned int flags,
+		      struct file_lock *fl)
 {
 	if (assign_type(fl, type) != 0)
 		return -EINVAL;
@@ -621,6 +624,8 @@ static int lease_init(struct file *filp, long type, struct file_lock *fl)
 
 	fl->fl_file = filp;
 	fl->fl_flags = FL_LEASE;
+	if (flags & FL_LAYOUT)
+		fl->fl_flags |= FL_LAYOUT;
 	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_ops = NULL;
@@ -629,7 +634,8 @@ static int lease_init(struct file *filp, long type, struct file_lock *fl)
 }
 
 /* Allocate a file_lock initialised to this type of lease */
-static struct file_lock *lease_alloc(struct file *filp, long type)
+static struct file_lock *lease_alloc(struct file *filp, long type,
+				     unsigned int flags)
 {
 	struct file_lock *fl = locks_alloc_lock();
 	int error = -ENOMEM;
@@ -637,7 +643,7 @@ static struct file_lock *lease_alloc(struct file *filp, long type)
 	if (fl == NULL)
 		return ERR_PTR(error);
 
-	error = lease_init(filp, type, fl);
+	error = lease_init(filp, type, flags, fl);
 	if (error) {
 		locks_free_lock(fl);
 		return ERR_PTR(error);
@@ -1588,7 +1594,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	int want_write = (mode & O_ACCMODE) != O_RDONLY;
 	LIST_HEAD(dispose);
 
-	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
+	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK, 0);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
 	new_fl->fl_flags = type;
@@ -1725,6 +1731,8 @@ EXPORT_SYMBOL(lease_get_mtime);
  *
  *	%F_UNLCK to indicate no lease is held.
  *
+ *	%F_LAYOUT to indicate a layout lease is held.
+ *
  *	(if a lease break is pending):
  *
  *	%F_RDLCK to indicate an exclusive lease needs to be
@@ -2015,8 +2023,26 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
 	struct file_lock *fl;
 	struct fasync_struct *new;
 	int error;
+	unsigned int flags = 0;
+
+	/*
+	 * NOTE on F_LAYOUT lease
+	 *
+	 * LAYOUT lease types are taken on files which the user knows that
+	 * they will be pinning in memory for some indeterminate amount of
+	 * time.  Such as for use with RDMA.  While we don't know what user
+	 * space is going to do with the file we still use a F_RDLOCK level of
+	 * lease.  This ensures that there are no conflicts between
+	 * 2 users.  The conflict should only come from the File system wanting
+	 * to revoke the lease in break_layout()  And this is done by using
+	 * F_WRLCK in the break code.
+	 */
+	if (arg == F_LAYOUT) {
+		arg = F_RDLCK;
+		flags = FL_LAYOUT;
+	}
 
-	fl = lease_alloc(filp, arg);
+	fl = lease_alloc(filp, arg, flags);
 	if (IS_ERR(fl))
 		return PTR_ERR(fl);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index f7fdfe93e25d..9e9d8d35ee93 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -998,7 +998,7 @@ static inline struct file *get_file(struct file *f)
 #define FL_DOWNGRADE_PENDING	256 /* Lease is being downgraded */
 #define FL_UNLOCK_PENDING	512 /* Lease is being broken */
 #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
-#define FL_LAYOUT	2048	/* outstanding pNFS layout */
+#define FL_LAYOUT	2048	/* outstanding pNFS layout or user held pin */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..baddd54f3031 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -174,6 +174,9 @@ struct f_owner_ex {
 #define F_SHLCK		8	/* or 4 */
 #endif
 
+#define F_LAYOUT	16      /* layout lease to allow longterm pins such as
+				   RDMA */
+
 /* operations for bsd flock(), also used by the kernel implementation */
 #define LOCK_SH		1	/* shared lock */
 #define LOCK_EX		2	/* exclusive lock */
-- 
2.20.1


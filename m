Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44106886BB
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 01:01:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbfHIW6n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 18:58:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:7086 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726022AbfHIW6n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:58:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:58:42 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="374631453"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:58:41 -0700
From:   ira.weiny@intel.com
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jason Gunthorpe <jgg@ziepe.ca>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        "Theodore Ts'o" <tytso@mit.edu>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-mm@kvack.org,
        Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH v2 01/19] fs/locks: Export F_LAYOUT lease to user space
Date:   Fri,  9 Aug 2019 15:58:15 -0700
Message-Id: <20190809225833.6657-2-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190809225833.6657-1-ira.weiny@intel.com>
References: <20190809225833.6657-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

In order to support an opt-in policy for users to allow long term pins
of FS DAX pages we need to export the LAYOUT lease to user space.

This is the first of 2 new lease flags which must be used to allow a
long term pin to be made on a file.

After the complete series:

0) Registrations to Device DAX char devs are not affected

1) The user has to opt in to allowing page pins on a file with an exclusive
   layout lease.  Both exclusive and layout lease flags are user visible now.

2) page pins will fail if the lease is not active when the file back page is
   encountered.

3) Any truncate or hole punch operation on a pinned DAX page will fail.

4) The user has the option of holding the lease or releasing it.  If they
   release it no other pin calls will work on the file.

5) Closing the file is ok.

6) Unmapping the file is ok

7) Pins against the files are tracked back to an owning file or an owning mm
   depending on the internal subsystem needs.  With RDMA there is an owning
   file which is related to the pined file.

8) Only RDMA is currently supported

9) Truncation of pages which are not actively pinned nor covered by a lease
   will succeed.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/locks.c                       | 36 +++++++++++++++++++++++++++-----
 include/linux/fs.h               |  2 +-
 include/uapi/asm-generic/fcntl.h |  3 +++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 24d1db632f6c..ad17c6ffca06 100644
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
@@ -1583,7 +1589,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	int want_write = (mode & O_ACCMODE) != O_RDONLY;
 	LIST_HEAD(dispose);
 
-	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
+	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK, 0);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
 	new_fl->fl_flags = type;
@@ -1720,6 +1726,8 @@ EXPORT_SYMBOL(lease_get_mtime);
  *
  *	%F_UNLCK to indicate no lease is held.
  *
+ *	%F_LAYOUT to indicate a layout lease is held.
+ *
  *	(if a lease break is pending):
  *
  *	%F_RDLCK to indicate an exclusive lease needs to be
@@ -2022,8 +2030,26 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
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
index 046108cd4ed9..dd60d5be9886 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1004,7 +1004,7 @@ static inline struct file *get_file(struct file *f)
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B8442DB4F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 06:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725468AbfD2EyJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 00:54:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:28440 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726937AbfD2EyI (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 21:54:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146566280"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 21:54:06 -0700
From:   ira.weiny@intel.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH 02/10] fs/locks: Introduce FL_LONGTERM file lease
Date:   Sun, 28 Apr 2019 21:53:51 -0700
Message-Id: <20190429045359.8923-3-ira.weiny@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190429045359.8923-1-ira.weiny@intel.com>
References: <20190429045359.8923-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

GUP longterm pins of non-pagecache file system pages (FS DAX) are
currently disallowed because they are unsafe.

The danger for pinning these pages comes from the fact that hole punch
and/or truncate of those files results in the pages being mapped and
pinned by a user space process while DAX has potentially allocated those
pages to other processes.

Attempts to hold those pages in reserve defeat the purpose of allowing
for FS truncate/hole punch should the user truely desire those
operations.

That said most users who are mapping FS DAX pages for long term pin
purposes (such as RDMA) are not going to want to deallocate these pages
while those pages are in use.  To do so would mean the application would
lose data.  So the use case for allowing these operations of such pages
seems limited.

However, the kernel must protect itself and users from potential
mistakes and or malicious user space code.  Rather than disable long
term pins as is done now.   Allow for users who know they are going to
be pinning this memory to alert the file system of this intention.
Furthermore, allow them to be alerted if the pages they have pined are
going away such that they can react.

Example user space pseudocode for a user using RDMA and reacting to a
lease break of this type would look like this:

lease_break() {
...
	if (sigio.fd == rdma_fd) {
		ibv_dereg_mr(mr);
		close(rdma_fd);
	}
}

foo() {
	rdma_fd = open()
	fcntl(rdma_fd, F_SETLEASE, F_LONGTERM);
	sigaction(SIGIO, ...  lease_break ...);
	ptr = mmap(rdma_fd, ...);
	mr = ibv_reg_mr(ptr, ...);
}

Follow on patches present 2 possible solutions to what to do should an
application not take this lease.

1) failure to take the lease results in a failure of the ibv_reg_mr() (or
   other pin system call which results in GUP being called.)
2) failure to take the lease results in GUP taking the lease on behalf
   of the user.

In both of these cases a failure to react and unpin the memory of the
file in question will result in a SIGBUS being sent to the application
holding the lease.  This is slightly different behavior from what would
happen if an application were to write to a hole punched area of a file
but it still seems reasonable given that this operation is not allowed
at all currently.

This patch 1 of X... exports the FL_LONGTERM lease type to user space
and implements taking this lease on a file.

Follow on patches implement failing a longterm GUP as well as sending a
SIGBUS.  The last patch in the series removes the restriction of failing
FOLL_LONGTERM for DAX operations.

A follow on series (not yet completed) will remove the FOLL_LONGTERM
restrictions within GUP for calls such as get_user_pages_locked because
vma access is no longer required.

RFC NOTEs / questions:

Should F_LONGTERM be a "flag" of some sort OR'ed in with F_RDLCK?

	It was considered to use F_WRLCK vs F_RDLCK to indicate if the
	user was going to be writing vs reading from the file in
	question.

	However, in the end this does not matter as far as the FS is
	concerned.  While internally we treat this as a F_RDLCK type the
	user should consider this a F_LONGTERM lease type which has no
	concept of read or write.

FL_LAYOUT was not used because FL_LAYOUT lease break in XFS would have
created a "chicken and the egg" problem.  FL_LONGTERM must be broken and
the ref counts of devmap page dropped to 1 before FL_LAYOUT could be
broken.  Not using FL_LAYOUT also makes it very clear we don't have
issues conflicting with NFS code.  Although I don't think that there
would have been any conflict other than the XFS lease break order.

The name "FL_LONGTERM" is probably not the best name for this feature.
Alternative names are welcome.

---
 fs/locks.c                       | 38 +++++++++++++++++++++++++++-----
 include/linux/fs.h               |  1 +
 include/uapi/asm-generic/fcntl.h |  2 ++
 3 files changed, 35 insertions(+), 6 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index 4b66ed91fb53..8ea1c5713e6a 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -610,7 +610,8 @@ static const struct lock_manager_operations lease_manager_ops = {
 /*
  * Initialize a lease, use the default lock manager operations
  */
-static int lease_init(struct file *filp, long type, struct file_lock *fl)
+static int lease_init(struct file *filp, long type, unsigned int flags,
+		      struct file_lock *fl)
 {
 	if (assign_type(fl, type) != 0)
 		return -EINVAL;
@@ -620,6 +621,8 @@ static int lease_init(struct file *filp, long type, struct file_lock *fl)
 
 	fl->fl_file = filp;
 	fl->fl_flags = FL_LEASE;
+	if (flags & FL_LONGTERM)
+		fl->fl_flags |= FL_LONGTERM;
 	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_ops = NULL;
@@ -628,7 +631,8 @@ static int lease_init(struct file *filp, long type, struct file_lock *fl)
 }
 
 /* Allocate a file_lock initialised to this type of lease */
-static struct file_lock *lease_alloc(struct file *filp, long type)
+static struct file_lock *lease_alloc(struct file *filp, long type,
+				     unsigned int flags)
 {
 	struct file_lock *fl = locks_alloc_lock();
 	int error = -ENOMEM;
@@ -636,7 +640,7 @@ static struct file_lock *lease_alloc(struct file *filp, long type)
 	if (fl == NULL)
 		return ERR_PTR(error);
 
-	error = lease_init(filp, type, fl);
+	error = lease_init(filp, type, flags, fl);
 	if (error) {
 		locks_free_lock(fl);
 		return ERR_PTR(error);
@@ -1530,6 +1534,10 @@ static bool leases_conflict(struct file_lock *lease, struct file_lock *breaker)
 {
 	bool rc;
 
+	if ((breaker->fl_flags & FL_LONGTERM) != (lease->fl_flags & FL_LONGTERM)) {
+		rc = false;
+		goto trace;
+	}
 	if ((breaker->fl_flags & FL_LAYOUT) != (lease->fl_flags & FL_LAYOUT)) {
 		rc = false;
 		goto trace;
@@ -1582,7 +1590,7 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	int want_write = (mode & O_ACCMODE) != O_RDONLY;
 	LIST_HEAD(dispose);
 
-	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK);
+	new_fl = lease_alloc(NULL, want_write ? F_WRLCK : F_RDLCK, 0);
 	if (IS_ERR(new_fl))
 		return PTR_ERR(new_fl);
 	new_fl->fl_flags = type;
@@ -1773,7 +1781,7 @@ check_conflicting_open(const struct dentry *dentry, const long arg, int flags)
 	int ret = 0;
 	struct inode *inode = dentry->d_inode;
 
-	if (flags & FL_LAYOUT)
+	if (flags & FL_LAYOUT || flags & FL_LONGTERM)
 		return 0;
 
 	if ((arg == F_RDLCK) && inode_is_open_for_write(inode))
@@ -2009,8 +2017,26 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
 	struct file_lock *fl;
 	struct fasync_struct *new;
 	int error;
+	unsigned int flags = 0;
+
+	/*
+	 * NOTE on F_LONGTERM lease
+	 *
+	 * LONGTERM lease types are taken on files which the user knows that
+	 * they will be pinning in memory for some indeterminate amount of
+	 * time.  Such as for use with RDMA.  While we don't know what user
+	 * space is going to do with the file we still use a F_RDLOCK level of
+	 * lease.  This ensures that there are no conflicts between
+	 * 2 users.  The conflict should only come from the File system wanting
+	 * to revoke the lease in break_layout()  And this is done by using
+	 * F_WRLCK in the break code.
+	 */
+	if (arg == F_LONGTERM) {
+		arg = F_RDLCK;
+		flags = FL_LONGTERM;
+	}
 
-	fl = lease_alloc(filp, arg);
+	fl = lease_alloc(filp, arg, flags);
 	if (IS_ERR(fl))
 		return PTR_ERR(fl);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 8b42df09b04c..ace21c6feb19 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -991,6 +991,7 @@ static inline struct file *get_file(struct file *f)
 #define FL_UNLOCK_PENDING	512 /* Lease is being broken */
 #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
 #define FL_LAYOUT	2048	/* outstanding pNFS layout */
+#define FL_LONGTERM	4096	/* user held pin */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index 9dc0bf0c5a6e..9938ebc24adf 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -174,6 +174,8 @@ struct f_owner_ex {
 #define F_SHLCK		8	/* or 4 */
 #endif
 
+#define F_LONGTERM	16      /* lease to allow longterm GUP */
+
 /* operations for bsd flock(), also used by the kernel implementation */
 #define LOCK_SH		1	/* shared lock */
 #define LOCK_EX		2	/* exclusive lock */
-- 
2.20.1


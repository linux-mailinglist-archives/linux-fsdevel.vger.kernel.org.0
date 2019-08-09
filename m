Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8269A886B5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Aug 2019 01:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729788AbfHIXA3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Aug 2019 19:00:29 -0400
Received: from mga17.intel.com ([192.55.52.151]:9691 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729112AbfHIW6o (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Aug 2019 18:58:44 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:58:43 -0700
X-IronPort-AV: E=Sophos;i="5.64,367,1559545200"; 
   d="scan'208";a="199539184"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2019 15:58:43 -0700
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
Subject: [RFC PATCH v2 02/19] fs/locks: Add Exclusive flag to user Layout lease
Date:   Fri,  9 Aug 2019 15:58:16 -0700
Message-Id: <20190809225833.6657-3-ira.weiny@intel.com>
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

Add an exclusive lease flag which indicates that the layout mechanism
can not be broken.

Exclusive layout leases allow the file system to know that pages may be
GUP pined and that attempts to change the layout, ie truncate, should be
failed.

A process which attempts to break it's own exclusive lease gets an
EDEADLOCK return to help determine that this is likely a programming bug
vs someone else holding a resource.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/locks.c                       | 23 +++++++++++++++++++++--
 include/linux/fs.h               |  1 +
 include/uapi/asm-generic/fcntl.h |  2 ++
 3 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/fs/locks.c b/fs/locks.c
index ad17c6ffca06..0c7359cdab92 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -626,6 +626,8 @@ static int lease_init(struct file *filp, long type, unsigned int flags,
 	fl->fl_flags = FL_LEASE;
 	if (flags & FL_LAYOUT)
 		fl->fl_flags |= FL_LAYOUT;
+	if (flags & FL_EXCLUSIVE)
+		fl->fl_flags |= FL_EXCLUSIVE;
 	fl->fl_start = 0;
 	fl->fl_end = OFFSET_MAX;
 	fl->fl_ops = NULL;
@@ -1619,6 +1621,14 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 	list_for_each_entry_safe(fl, tmp, &ctx->flc_lease, fl_list) {
 		if (!leases_conflict(fl, new_fl))
 			continue;
+		if (fl->fl_flags & FL_EXCLUSIVE) {
+			error = -ETXTBSY;
+			if (new_fl->fl_pid == fl->fl_pid) {
+				error = -EDEADLOCK;
+				goto out;
+			}
+			continue;
+		}
 		if (want_write) {
 			if (fl->fl_flags & FL_UNLOCK_PENDING)
 				continue;
@@ -1634,6 +1644,13 @@ int __break_lease(struct inode *inode, unsigned int mode, unsigned int type)
 			locks_delete_lock_ctx(fl, &dispose);
 	}
 
+	/* We differentiate between -EDEADLOCK and -ETXTBSY so the above loop
+	 * continues with -ETXTBSY looking for a potential deadlock instead.
+	 * If deadlock is not found go ahead and return -ETXTBSY.
+	 */
+	if (error == -ETXTBSY)
+		goto out;
+
 	if (list_empty(&ctx->flc_lease))
 		goto out;
 
@@ -2044,9 +2061,11 @@ static int do_fcntl_add_lease(unsigned int fd, struct file *filp, long arg)
 	 * to revoke the lease in break_layout()  And this is done by using
 	 * F_WRLCK in the break code.
 	 */
-	if (arg == F_LAYOUT) {
+	if ((arg & F_LAYOUT) == F_LAYOUT) {
+		if ((arg & F_EXCLUSIVE) == F_EXCLUSIVE)
+			flags |= FL_EXCLUSIVE;
 		arg = F_RDLCK;
-		flags = FL_LAYOUT;
+		flags |= FL_LAYOUT;
 	}
 
 	fl = lease_alloc(filp, arg, flags);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index dd60d5be9886..2e41ce547913 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1005,6 +1005,7 @@ static inline struct file *get_file(struct file *f)
 #define FL_UNLOCK_PENDING	512 /* Lease is being broken */
 #define FL_OFDLCK	1024	/* lock is "owned" by struct file */
 #define FL_LAYOUT	2048	/* outstanding pNFS layout or user held pin */
+#define FL_EXCLUSIVE	4096	/* Layout lease is exclusive */
 
 #define FL_CLOSE_POSIX (FL_POSIX | FL_CLOSE)
 
diff --git a/include/uapi/asm-generic/fcntl.h b/include/uapi/asm-generic/fcntl.h
index baddd54f3031..88b175ceccbc 100644
--- a/include/uapi/asm-generic/fcntl.h
+++ b/include/uapi/asm-generic/fcntl.h
@@ -176,6 +176,8 @@ struct f_owner_ex {
 
 #define F_LAYOUT	16      /* layout lease to allow longterm pins such as
 				   RDMA */
+#define F_EXCLUSIVE	32      /* layout lease is exclusive */
+				/* FIXME or shoudl this be F_EXLCK??? */
 
 /* operations for bsd flock(), also used by the kernel implementation */
 #define LOCK_SH		1	/* shared lock */
-- 
2.20.1


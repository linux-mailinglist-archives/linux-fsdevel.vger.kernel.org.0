Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E441DB50
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Apr 2019 06:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727243AbfD2Eyk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 00:54:40 -0400
Received: from mga03.intel.com ([134.134.136.65]:28445 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfD2EyK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 00:54:10 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Apr 2019 21:54:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,408,1549958400"; 
   d="scan'208";a="146566310"
Received: from iweiny-desk2.sc.intel.com ([10.3.52.157])
  by orsmga003.jf.intel.com with ESMTP; 28 Apr 2019 21:54:09 -0700
From:   ira.weiny@intel.com
To:     lsf-pc@lists.linux-foundation.org
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Dan Williams <dan.j.williams@intel.com>,
        Jan Kara <jack@suse.cz>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Michal Hocko <mhocko@suse.com>, Ira Weiny <ira.weiny@intel.com>
Subject: [RFC PATCH 08/10] mm/gup: fs: Send SIGBUS on truncate of active file
Date:   Sun, 28 Apr 2019 21:53:57 -0700
Message-Id: <20190429045359.8923-9-ira.weiny@intel.com>
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

Now that the taking of LONGTERM leases is in place we can now facilitate
sending a SIGBUS to process if a file truncate or hole punch is
performed and they do not respond by releasing the lease.

The standard file lease_break_time is used to time out the LONGTERM
lease which is in place on the inode.
---
 fs/ext4/inode.c    |  4 ++++
 fs/locks.c         | 13 +++++++++++--
 fs/xfs/xfs_file.c  |  4 ++++
 include/linux/fs.h | 13 +++++++++++++
 4 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index b32a57bc5d5d..bee456c8c805 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4237,6 +4237,10 @@ int ext4_break_layouts(struct inode *inode)
 	if (WARN_ON_ONCE(!rwsem_is_locked(&ei->i_mmap_sem)))
 		return -EINVAL;
 
+	/* Break longterm leases */
+	if (dax_mapping_is_dax(inode->i_mapping))
+		break_longterm(inode);
+
 	do {
 		page = dax_layout_busy_page(inode->i_mapping);
 		if (!page)
diff --git a/fs/locks.c b/fs/locks.c
index 58c6d7a411b6..c77eee081d11 100644
--- a/fs/locks.c
+++ b/fs/locks.c
@@ -1580,6 +1580,7 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 {
 	struct file_lock_context *ctx = inode->i_flctx;
 	struct file_lock *fl, *tmp;
+	struct task_struct *tsk;
 
 	lockdep_assert_held(&ctx->flc_lock);
 
@@ -1587,8 +1588,16 @@ static void time_out_leases(struct inode *inode, struct list_head *dispose)
 		trace_time_out_leases(inode, fl);
 		if (past_time(fl->fl_downgrade_time))
 			lease_modify(fl, F_RDLCK, dispose);
-		if (past_time(fl->fl_break_time))
-			lease_modify(fl, F_UNLCK, dispose);
+		if (past_time(fl->fl_break_time)) {
+			if (fl->fl_flags & FL_LONGTERM) {
+				tsk = find_task_by_vpid(fl->fl_pid);
+				fl->fl_break_time = 1 + jiffies + lease_break_time * HZ;
+				lease_modify_longterm(fl, F_UNLCK, dispose);
+				kill_pid(tsk->thread_pid, SIGBUS, 0);
+			} else {
+				lease_modify(fl, F_UNLCK, dispose);
+			}
+		}
 	}
 }
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 1f2e2845eb76..ebd310f3ae65 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -739,6 +739,10 @@ xfs_break_dax_layouts(
 
 	ASSERT(xfs_isilocked(XFS_I(inode), XFS_MMAPLOCK_EXCL));
 
+	/* Break longterm leases */
+	if (dax_mapping_is_dax(inode->i_mapping))
+		break_longterm(inode);
+
 	page = dax_layout_busy_page(inode->i_mapping);
 	if (!page)
 		return 0;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index be2d08080aa5..0e8b21240a71 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2459,6 +2459,14 @@ static inline int break_layout(struct inode *inode, bool wait)
 	return 0;
 }
 
+static inline int break_longterm(struct inode *inode)
+{
+	smp_mb();
+	if (inode->i_flctx && !list_empty_careful(&inode->i_flctx->flc_lease))
+		return __break_lease(inode, O_WRONLY, FL_LONGTERM);
+	return 0;
+}
+
 #else /* !CONFIG_FILE_LOCKING */
 static inline int break_lease(struct inode *inode, unsigned int mode)
 {
@@ -2486,6 +2494,11 @@ static inline int break_layout(struct inode *inode, bool wait)
 	return 0;
 }
 
+static inline int break_longterm(struct inode *inode, bool wait)
+{
+	return 0;
+}
+
 #endif /* CONFIG_FILE_LOCKING */
 
 /* fs/open.c */
-- 
2.20.1


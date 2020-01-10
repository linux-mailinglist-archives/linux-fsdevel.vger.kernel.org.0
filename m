Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7887113771E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Jan 2020 20:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728994AbgAJTaM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Jan 2020 14:30:12 -0500
Received: from mga17.intel.com ([192.55.52.151]:56599 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbgAJTaL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Jan 2020 14:30:11 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:10 -0800
X-IronPort-AV: E=Sophos;i="5.69,418,1571727600"; 
   d="scan'208";a="238521007"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.157])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 11:30:10 -0800
From:   ira.weiny@intel.com
To:     linux-kernel@vger.kernel.org
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.cz>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [RFC PATCH V2 09/12] fs: Prevent mode change if file is mmap'ed
Date:   Fri, 10 Jan 2020 11:29:39 -0800
Message-Id: <20200110192942.25021-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200110192942.25021-1-ira.weiny@intel.com>
References: <20200110192942.25021-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Page faults need to ensure the inode mode is correct and consistent with
the vmf information at the time of the fault.  There is no easy way to
ensure the vmf information is correct if a mode change is in progress.
Furthermore, there is no good use case to require a mode change while
the file is mmap'ed.

Track mmap's of the file and fail the mode change if the file is
mmap'ed.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 fs/inode.c         |  2 ++
 fs/xfs/xfs_ioctl.c |  8 ++++++++
 include/linux/fs.h |  1 +
 mm/mmap.c          | 19 +++++++++++++++++--
 4 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 2b0f51161918..944711aed6f8 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -245,6 +245,8 @@ static struct inode *alloc_inode(struct super_block *sb)
 		return NULL;
 	}
 
+	atomic64_set(&inode->i_mapped, 0);
+
 	return inode;
 }
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index bc3654fe3b5d..1ab0906c6c7f 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -1200,6 +1200,14 @@ xfs_ioctl_setattr_dax_invalidate(
 		goto out_unlock;
 	}
 
+	/*
+	 * If there is a mapping in place we must remain in our current mode.
+	 */
+	if (atomic64_read(&inode->i_mapped)) {
+		error = -EBUSY;
+		goto out_unlock;
+	}
+
 	error = filemap_write_and_wait(inode->i_mapping);
 	if (error)
 		goto out_unlock;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 631f11d6246e..6e7dc626b657 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -740,6 +740,7 @@ struct inode {
 #endif
 
 	void			*i_private; /* fs or device private pointer */
+	atomic64_t               i_mapped;
 } __randomize_layout;
 
 struct timespec64 timestamp_truncate(struct timespec64 t, struct inode *inode);
diff --git a/mm/mmap.c b/mm/mmap.c
index dfaf1130e706..e6b68924b7ca 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -171,12 +171,17 @@ void unlink_file_vma(struct vm_area_struct *vma)
 static struct vm_area_struct *remove_vma(struct vm_area_struct *vma)
 {
 	struct vm_area_struct *next = vma->vm_next;
+	struct file *f = vma->vm_file;
 
 	might_sleep();
 	if (vma->vm_ops && vma->vm_ops->close)
 		vma->vm_ops->close(vma);
-	if (vma->vm_file)
-		fput(vma->vm_file);
+	if (f) {
+		struct inode *inode = file_inode(f);
+		if (inode)
+			atomic64_dec(&inode->i_mapped);
+		fput(f);
+	}
 	mpol_put(vma_policy(vma));
 	vm_area_free(vma);
 	return next;
@@ -1837,6 +1842,16 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
 
 	vma_set_page_prot(vma);
 
+	/*
+	 * Track if there is mapping in place such that a mode change
+	 * does not occur on a file which is mapped
+	 */
+	if (file) {
+		struct inode		*inode = file_inode(file);
+
+		atomic64_inc(&inode->i_mapped);
+	}
+
 	return addr;
 
 unmap_and_free_vma:
-- 
2.21.0


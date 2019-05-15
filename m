Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1EA71FAD3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 21:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbfEOT3i (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 May 2019 15:29:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727591AbfEOT1e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 May 2019 15:27:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1BDAC09AD12;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.29])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BCF9760C2A;
        Wed, 15 May 2019 19:27:33 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
        id 0694C22548C; Wed, 15 May 2019 15:27:30 -0400 (EDT)
From:   Vivek Goyal <vgoyal@redhat.com>
To:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, linux-nvdimm@lists.01.org
Cc:     vgoyal@redhat.com, miklos@szeredi.hu, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: [PATCH v2 24/30] fuse, dax: Take ->i_mmap_sem lock during dax page fault
Date:   Wed, 15 May 2019 15:27:09 -0400
Message-Id: <20190515192715.18000-25-vgoyal@redhat.com>
In-Reply-To: <20190515192715.18000-1-vgoyal@redhat.com>
References: <20190515192715.18000-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Wed, 15 May 2019 19:27:33 +0000 (UTC)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need some kind of locking mechanism here. Normal file systems like
ext4 and xfs seems to take their own semaphore to protect agains
truncate while fault is going on.

We have additional requirement to protect against fuse dax memory range
reclaim. When a range has been selected for reclaim, we need to make sure
no other read/write/fault can try to access that memory range while
reclaim is in progress. Once reclaim is complete, lock will be released
and read/write/fault will trigger allocation of fresh dax range.

Taking inode_lock() is not an option in fault path as lockdep complains
about circular dependencies. So define a new fuse_inode->i_mmap_sem.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 fs/fuse/dir.c    |  2 ++
 fs/fuse/file.c   | 17 +++++++++++++----
 fs/fuse/fuse_i.h |  7 +++++++
 fs/fuse/inode.c  |  1 +
 4 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index fd8636e67ae9..84c0b638affb 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1559,8 +1559,10 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 	 */
 	if ((is_truncate || !is_wb) &&
 	    S_ISREG(inode->i_mode) && oldsize != outarg.attr.size) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache(inode, outarg.attr.size);
 		invalidate_inode_pages2(inode->i_mapping);
+		up_write(&fi->i_mmap_sem);
 	}
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index 2777355bc245..e536a04aaa06 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -2638,13 +2638,20 @@ static int __fuse_dax_fault(struct vm_fault *vmf, enum page_entry_size pe_size,
 	if (write)
 		sb_start_pagefault(sb);
 
-	/* TODO inode semaphore to protect faults vs truncate */
-
+	/*
+	 * We need to serialize against not only truncate but also against
+	 * fuse dax memory range reclaim. While a range is being reclaimed,
+	 * we do not want any read/write/mmap to make progress and try
+	 * to populate page cache or access memory we are trying to free.
+	 */
+	down_read(&get_fuse_inode(inode)->i_mmap_sem);
 	ret = dax_iomap_fault(vmf, pe_size, &pfn, NULL, &fuse_iomap_ops);
 
 	if (ret & VM_FAULT_NEEDDSYNC)
 		ret = dax_finish_sync_fault(vmf, pe_size, pfn);
 
+	up_read(&get_fuse_inode(inode)->i_mmap_sem);
+
 	if (write)
 		sb_end_pagefault(sb);
 
@@ -3593,9 +3600,11 @@ static long fuse_file_fallocate(struct file *file, int mode, loff_t offset,
 			file_update_time(file);
 	}
 
-	if (mode & FALLOC_FL_PUNCH_HOLE)
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		down_write(&fi->i_mmap_sem);
 		truncate_pagecache_range(inode, offset, offset + length - 1);
-
+		up_write(&fi->i_mmap_sem);
+	}
 	fuse_invalidate_attr(inode);
 
 out:
diff --git a/fs/fuse/fuse_i.h b/fs/fuse/fuse_i.h
index f1ae549eff98..a234cf30538d 100644
--- a/fs/fuse/fuse_i.h
+++ b/fs/fuse/fuse_i.h
@@ -212,6 +212,13 @@ struct fuse_inode {
 	 */
 	struct rw_semaphore i_dmap_sem;
 
+	/**
+	 * Can't take inode lock in fault path (leads to circular dependency).
+	 * So take this in fuse dax fault path to make sure truncate and
+	 * punch hole etc. can't make progress in parallel.
+	 */
+	struct rw_semaphore i_mmap_sem;
+
 	/** Sorted rb tree of struct fuse_dax_mapping elements */
 	struct rb_root_cached dmap_tree;
 	unsigned long nr_dmaps;
diff --git a/fs/fuse/inode.c b/fs/fuse/inode.c
index ad66a353554b..713c5f32ab35 100644
--- a/fs/fuse/inode.c
+++ b/fs/fuse/inode.c
@@ -85,6 +85,7 @@ static struct inode *fuse_alloc_inode(struct super_block *sb)
 	fi->state = 0;
 	fi->nr_dmaps = 0;
 	mutex_init(&fi->mutex);
+	init_rwsem(&fi->i_mmap_sem);
 	init_rwsem(&fi->i_dmap_sem);
 	spin_lock_init(&fi->lock);
 	fi->forget = fuse_alloc_forget();
-- 
2.20.1


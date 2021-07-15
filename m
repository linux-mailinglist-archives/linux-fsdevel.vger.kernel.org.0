Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB2D3C9FDC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Jul 2021 15:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238145AbhGONnv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Jul 2021 09:43:51 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55810 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237749AbhGONnf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Jul 2021 09:43:35 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A74D622A80;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626356433; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiTPK3VbhB8SGIIgtQ8YaJoAHU79xdWWrLD1Cz+9DnA=;
        b=xThUyV02yzTwAn0wY7JIFZnsgMBZN0LSmrOARvk1km6I2mNmX5aOSg6vlUmPi9jCPVD4iS
        Nt7fU53lwOrkcfB5Cg5snfYb8Lb3qPS0WQ0joLWXeJ40cjRr8CurDy6TIAK8nM58dckoTE
        6pw050ODGaVt/CYvkKcWfOVbk5vw1Xc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626356433;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiTPK3VbhB8SGIIgtQ8YaJoAHU79xdWWrLD1Cz+9DnA=;
        b=Z0yU6Ey4B79YEflwTC9JMw7tuthFxtV5es2889R9e0hqarVnpxRLyYNoBn2aeinSE2nmh2
        j4mTFHNrfvFIevDA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 6C688A3BA1;
        Thu, 15 Jul 2021 13:40:33 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 256551E0E33; Thu, 15 Jul 2021 15:40:33 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Ted Tso <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
        Matthew Wilcox <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 10/14] zonefs: Convert to using invalidate_lock
Date:   Thu, 15 Jul 2021 15:40:20 +0200
Message-Id: <20210715134032.24868-10-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210715133202.5975-1-jack@suse.cz>
References: <20210715133202.5975-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3579; h=from:subject; bh=A/7AtC2eRQANRoxuBRHLYLyusp8+Mdp8nN+Gi+I3MCo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg8DrEO3dYj/Mgvj7UVbam0r3XqE0cuodG8u0lHKX2 sTw+xtuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYPA6xAAKCRCcnaoHP2RA2W7iB/ 9Rr4rYt29r9OteDYOD5KGYGNIdVXzFVly5KFNWpbENDAnyWaED/ht35k066V0i46mFNsBYq6kbmVTo nHlfgk5At/dN4qG1TeYOBdksybSXuJ+w9qTodhzXW8wX1sR4ejWDPzDzDcR2Ge0XoACVIMeIIxUkzk cva03vvIfap9HzOX8Pm/8jz+VjSPOW5uT3u891IwYWKAPHmX7pyqBPLNPtmza5EAqU3Ft5ympgXWUG wJViNbI2+6m1c4BINQl1iyqiolYgYNRmulmPXupRKg/0RTdX/aBBISoKrOGzHsFL44yFnlR5BDKtjc RM2JUCr4r+E21jcL2SxNJZoUwZTqWz
X-Developer-Key: i=jack@suse.cz; a=openpgp; fpr=93C6099A142276A28BBE35D815BC833443038D8C
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Use invalidate_lock instead of zonefs' private i_mmap_sem. The intended
purpose is exactly the same.

CC: Damien Le Moal <damien.lemoal@wdc.com>
CC: Johannes Thumshirn <jth@kernel.org>
CC: <linux-fsdevel@vger.kernel.org>
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/zonefs/super.c  | 23 +++++------------------
 fs/zonefs/zonefs.h |  7 +++----
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index dbf03635869c..f323bf3b0e82 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -462,7 +462,7 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 	inode_dio_wait(inode);
 
 	/* Serialize against page faults */
-	down_write(&zi->i_mmap_sem);
+	filemap_invalidate_lock(inode->i_mapping);
 
 	/* Serialize against zonefs_iomap_begin() */
 	mutex_lock(&zi->i_truncate_mutex);
@@ -500,7 +500,7 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 
 unlock:
 	mutex_unlock(&zi->i_truncate_mutex);
-	up_write(&zi->i_mmap_sem);
+	filemap_invalidate_unlock(inode->i_mapping);
 
 	return ret;
 }
@@ -575,18 +575,6 @@ static int zonefs_file_fsync(struct file *file, loff_t start, loff_t end,
 	return ret;
 }
 
-static vm_fault_t zonefs_filemap_fault(struct vm_fault *vmf)
-{
-	struct zonefs_inode_info *zi = ZONEFS_I(file_inode(vmf->vma->vm_file));
-	vm_fault_t ret;
-
-	down_read(&zi->i_mmap_sem);
-	ret = filemap_fault(vmf);
-	up_read(&zi->i_mmap_sem);
-
-	return ret;
-}
-
 static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
@@ -607,16 +595,16 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
 	file_update_time(vmf->vma->vm_file);
 
 	/* Serialize against truncates */
-	down_read(&zi->i_mmap_sem);
+	filemap_invalidate_lock_shared(inode->i_mapping);
 	ret = iomap_page_mkwrite(vmf, &zonefs_iomap_ops);
-	up_read(&zi->i_mmap_sem);
+	filemap_invalidate_unlock_shared(inode->i_mapping);
 
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 }
 
 static const struct vm_operations_struct zonefs_file_vm_ops = {
-	.fault		= zonefs_filemap_fault,
+	.fault		= filemap_fault,
 	.map_pages	= filemap_map_pages,
 	.page_mkwrite	= zonefs_filemap_page_mkwrite,
 };
@@ -1158,7 +1146,6 @@ static struct inode *zonefs_alloc_inode(struct super_block *sb)
 
 	inode_init_once(&zi->i_vnode);
 	mutex_init(&zi->i_truncate_mutex);
-	init_rwsem(&zi->i_mmap_sem);
 	zi->i_wr_refcnt = 0;
 
 	return &zi->i_vnode;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 51141907097c..7b147907c328 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -70,12 +70,11 @@ struct zonefs_inode_info {
 	 * and changes to the inode private data, and in particular changes to
 	 * a sequential file size on completion of direct IO writes.
 	 * Serialization of mmap read IOs with truncate and syscall IO
-	 * operations is done with i_mmap_sem in addition to i_truncate_mutex.
-	 * Only zonefs_seq_file_truncate() takes both lock (i_mmap_sem first,
-	 * i_truncate_mutex second).
+	 * operations is done with invalidate_lock in addition to
+	 * i_truncate_mutex.  Only zonefs_seq_file_truncate() takes both lock
+	 * (invalidate_lock first, i_truncate_mutex second).
 	 */
 	struct mutex		i_truncate_mutex;
-	struct rw_semaphore	i_mmap_sem;
 
 	/* guarded by i_truncate_mutex */
 	unsigned int		i_wr_refcnt;
-- 
2.26.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E737335DDC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Apr 2021 13:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238304AbhDML33 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 07:29:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:55014 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231346AbhDML3X (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 07:29:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 570B4B167;
        Tue, 13 Apr 2021 11:29:00 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id E1F7C1F2B6E; Tue, 13 Apr 2021 13:28:59 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     <linux-ext4@vger.kernel.org>, <linux-xfs@vger.kernel.org>,
        Ted Tso <tytso@mit.edu>, Christoph Hellwig <hch@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>,
        Dave Chinner <david@fromorbit.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH 7/7] fs: Remove i_mapping_sem protection from .page_mkwrite handlers
Date:   Tue, 13 Apr 2021 13:28:51 +0200
Message-Id: <20210413112859.32249-7-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210413105205.3093-1-jack@suse.cz>
References: <20210413105205.3093-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Using i_mapping_sem in .page_mkwrite handlers is generally unnecessary
since these handlers do not create any new pages in the page cache. Thus
if the handler locks the page and it is still attached to appropriate
mapping, we are certain there cannot be truncate or hole punch in
progress past its page cache invalidation step (remember that a page
cannot be created in the page cache from the moment hole punch acquires
i_mapping_sem and starts invalidating page cache to the moment the
operation is finished and i_mapping_sem is released) and any page cache
invalidation will wait until we release the page lock. So just remove
i_mapping_sem usage from .page_mkwrite handlers.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/inode.c   | 3 ---
 fs/xfs/xfs_file.c | 2 --
 fs/zonefs/super.c | 3 ---
 3 files changed, 8 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index d76803eba884..4779b6084a30 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -6064,8 +6064,6 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vma->vm_file);
 
-	down_read(&inode->i_mapping_sem);
-
 	err = ext4_convert_inline_data(inode);
 	if (err)
 		goto out_ret;
@@ -6177,7 +6175,6 @@ vm_fault_t ext4_page_mkwrite(struct vm_fault *vmf)
 out_ret:
 	ret = block_page_mkwrite_return(err);
 out:
-	up_read(&inode->i_mapping_sem);
 	sb_end_pagefault(inode->i_sb);
 	return ret;
 out_error:
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index a76404708312..416a5c8ccdda 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -1316,10 +1316,8 @@ __xfs_filemap_fault(
 		xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 	} else {
 		if (write_fault) {
-			xfs_ilock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 			ret = iomap_page_mkwrite(vmf,
 					&xfs_buffered_write_iomap_ops);
-			xfs_iunlock(XFS_I(inode), XFS_MMAPLOCK_SHARED);
 		} else
 			ret = filemap_fault(vmf);
 	}
diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index ace6f3a223da..a90ef0f09a9f 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -594,10 +594,7 @@ static vm_fault_t zonefs_filemap_page_mkwrite(struct vm_fault *vmf)
 	sb_start_pagefault(inode->i_sb);
 	file_update_time(vmf->vma->vm_file);
 
-	/* Serialize against truncates */
-	down_read(&inode->i_mapping_sem);
 	ret = iomap_page_mkwrite(vmf, &zonefs_iomap_ops);
-	up_read(&inode->i_mapping_sem);
 
 	sb_end_pagefault(inode->i_sb);
 	return ret;
-- 
2.31.0.99.g0d91da736d9f.dirty


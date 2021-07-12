Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D5C3C6130
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 18:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhGLQ7Y (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 12:59:24 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:54496 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234810AbhGLQ7D (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 12:59:03 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 565261FFD9;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1626108970; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiTPK3VbhB8SGIIgtQ8YaJoAHU79xdWWrLD1Cz+9DnA=;
        b=DWtfRnKWjNKnxMsTQ1SGvNjLcy4rPG8skM8ju6TeA/lForojRvwk41zmqAdEVU+4j2Sl0T
        2lj26+6LLT3CEcH0/dQ5CwT92qBu7y9vMSaQ73kdSBwtg8o8gFZWUbWAcPWbXM6o77QSqR
        wGcBUjNjuC1/UkJIHpJlWcTwtKu3o9w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1626108970;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YiTPK3VbhB8SGIIgtQ8YaJoAHU79xdWWrLD1Cz+9DnA=;
        b=QPP3aWNGs6SfoVhsIbbywwbfUy2k9ad5zIPQlxhzUK/19Pf82NWtcwFChtQuMqeWK1uL+e
        6SjL/cWoReVvY2Bg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 20129A3B92;
        Mon, 12 Jul 2021 16:56:10 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id DAA901F2CDD; Mon, 12 Jul 2021 18:56:09 +0200 (CEST)
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
Date:   Mon, 12 Jul 2021 18:56:01 +0200
Message-Id: <20210712165609.13215-10-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210712163901.29514-1-jack@suse.cz>
References: <20210712163901.29514-1-jack@suse.cz>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3579; h=from:subject; bh=A/7AtC2eRQANRoxuBRHLYLyusp8+Mdp8nN+Gi+I3MCo=; b=owEBbQGS/pANAwAIAZydqgc/ZEDZAcsmYgBg7HQhO3dYj/Mgvj7UVbam0r3XqE0cuodG8u0lHKX2 sTw+xtuJATMEAAEIAB0WIQSrWdEr1p4yirVVKBycnaoHP2RA2QUCYOx0IQAKCRCcnaoHP2RA2ZqECA Cl/AMWcOtUoG5AqMmm9U66OrwxCWfjmzWhiUUE7/g+ZDsh+x5V9pS4ZjlUFCZnNkQhFnI+cafQaKQS jgqRC1tR5Gg3V/gWt9okHslcx9q0q2WIVMDkzr+YcXTaT9EDNFcpSTQOjuHUkmsZdDsrkM7ZD/v4bn NNkbghi9t+eYi1RyDU3mrtdWoef3tRwW5HmjabHyKAbakl40vDKfYdCFCS+bEdISF2xGhUhakHDsGW IjoBMkjU95+L0nSKOSYbxiSD0CPAh9htJdEWEFApAo8gha6s/ZAOk+Y+ZtaGvSko/dEh8lOHsVB9mV tScsND0zUtnLiV5+Rz+JPrb0l4bw2o
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


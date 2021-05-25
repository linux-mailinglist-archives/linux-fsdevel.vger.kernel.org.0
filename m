Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECA93902EB
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 May 2021 15:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbhEYNwt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 09:52:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:42682 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233395AbhEYNwf (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 09:52:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1621950662; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kB8D9k39JtQJCl3AVAkwJZ425HH4XDMjMOFRNOgKP/I=;
        b=hhFjuewPPkzpqwyim/+s6EstHlCtUmWSrztFo7NO2/aAxnYnCzUXvcrLKdJ9U45DXyEy8q
        G6mrF6Uz1Nj8rCsxoMf2QBAhjJ7H7yUl8jEcHTJfl3j+F6NxaTGjstzwsvrIUuzTkxyHLk
        hytCQupPMqj3oOhWSkIGandHsOC+6Ss=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1621950662;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kB8D9k39JtQJCl3AVAkwJZ425HH4XDMjMOFRNOgKP/I=;
        b=o9w/h1SuZLQO+PynVUZFVqaRzYYdF8Huu70O3irbRSFqgpcdRVfcfC2ywp/lWKL6jGfFqp
        b5UqwndivSC4e4Bg==
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 04B66AED6;
        Tue, 25 May 2021 13:51:01 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 342821F2CB8; Tue, 25 May 2021 15:51:00 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-fsdevel@vger.kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Dave Chinner <david@fromorbit.com>, ceph-devel@vger.kernel.org,
        Chao Yu <yuchao0@huawei.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Jeff Layton <jlayton@kernel.org>,
        Johannes Thumshirn <jth@kernel.org>,
        linux-cifs@vger.kernel.org, <linux-ext4@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net, <linux-mm@kvack.org>,
        <linux-xfs@vger.kernel.org>, Miklos Szeredi <miklos@szeredi.hu>,
        Steve French <sfrench@samba.org>, Ted Tso <tytso@mit.edu>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 09/13] zonefs: Convert to using invalidate_lock
Date:   Tue, 25 May 2021 15:50:46 +0200
Message-Id: <20210525135100.11221-9-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210525125652.20457-1-jack@suse.cz>
References: <20210525125652.20457-1-jack@suse.cz>
MIME-Version: 1.0
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
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/zonefs/super.c  | 23 +++++------------------
 fs/zonefs/zonefs.h |  7 +++----
 2 files changed, 8 insertions(+), 22 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index cd145d318b17..da2e95d98677 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -462,7 +462,7 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 	inode_dio_wait(inode);
 
 	/* Serialize against page faults */
-	down_write(&zi->i_mmap_sem);
+	down_write(&inode->i_mapping->invalidate_lock);
 
 	/* Serialize against zonefs_iomap_begin() */
 	mutex_lock(&zi->i_truncate_mutex);
@@ -500,7 +500,7 @@ static int zonefs_file_truncate(struct inode *inode, loff_t isize)
 
 unlock:
 	mutex_unlock(&zi->i_truncate_mutex);
-	up_write(&zi->i_mmap_sem);
+	up_write(&inode->i_mapping->invalidate_lock);
 
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
+	down_read(&inode->i_mapping->invalidate_lock);
 	ret = iomap_page_mkwrite(vmf, &zonefs_iomap_ops);
-	up_read(&zi->i_mmap_sem);
+	up_read(&inode->i_mapping->invalidate_lock);
 
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5191AE27E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Oct 2019 03:59:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408139AbfJXB7B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Oct 2019 21:59:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:34896 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408092AbfJXB7B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Oct 2019 21:59:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=0h70dGDOK05vm1Ih0GsIq9J9o32Y+rfowYypTFnY+YU=; b=FvYNi1N0v7S11gHtJLTUG37e4
        yq5DERi0tBZLKVtRByJPqmVo/GZGYlTUUUleW/NdAr2klQWnv0JfjEqCUPBvpzsrBwZ8upYS/BVVj
        lM88rVphVa6O2CsuBgt+wx9jEx3vCuX2jbw6ColppZ7yR6givPG5yy04srq1eC8+l7EUppsRv7A8Z
        Rqs/TPdi6Gg8m8rG6A2heMt5Rs39hKoX8qouHLCJf7JaynJbH3mq9gJqH7R+jzdpheUIuSRUjc/89
        zdsR4Wf3sQUOJ1lDXXQGC9pskj1ZZd0MB4iAyygJixRdUEM1f1T6bODno7+41YaPcUb4Yi5Dgxkpo
        mIuggkxvg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iNSOv-0003Ka-HU; Thu, 24 Oct 2019 01:58:57 +0000
Date:   Wed, 23 Oct 2019 18:58:57 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Matthew Bobrowski <mbobrowski@mbobrowski.org>
Cc:     Jan Kara <jack@suse.cz>, "Theodore Y. Ts'o" <tytso@mit.edu>,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v5 00/12] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191024015857.GB14940@infradead.org>
References: <cover.1571647178.git.mbobrowski@mbobrowski.org>
 <20191021133111.GA4675@mit.edu>
 <20191021194330.GJ25184@quack2.suse.cz>
 <20191023023519.GA16505@bobrowski>
 <20191023100153.GB22307@quack2.suse.cz>
 <20191023101138.GA6725@bobrowski>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191023101138.GA6725@bobrowski>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Maybe something like the version below which declutter the thing a bit?

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 5508baa11bb6..ab601c6779d2 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -80,6 +80,41 @@ static int ext4_sync_parent(struct inode *inode)
 	return ret;
 }
 
+static int ext4_fsync_nojournal(struct inode *inode, bool datasync,
+		bool *needs_barrier)
+{
+	int ret, err;
+
+	ret = sync_mapping_buffers(inode->i_mapping);
+	if (!(inode->i_state & I_DIRTY_ALL))
+		return ret;
+	if (datasync && !(inode->i_state & I_DIRTY_DATASYNC))
+		return ret;
+
+	err = sync_inode_metadata(inode, 1);
+	if (!ret)
+		ret = err;
+
+	if (!ret)
+		ret = ext4_sync_parent(inode);
+	if (test_opt(inode->i_sb, BARRIER))
+		*needs_barrier = true;
+	return ret;
+}
+
+static int ext4_fsync_journal(struct inode *inode, bool datasync,
+		bool *needs_barrier)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+	tid_t commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
+
+	if (journal->j_flags & JBD2_BARRIER &&
+	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
+		*needs_barrier = true;
+	return jbd2_complete_transaction(journal, commit_tid);
+}
+
 /*
  * akpm: A new design for ext4_sync_file().
  *
@@ -95,13 +130,11 @@ static int ext4_sync_parent(struct inode *inode)
 int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
 	struct inode *inode = file->f_mapping->host;
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int ret = 0, err;
-	tid_t commit_tid;
 	bool needs_barrier = false;
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(sbi)))
 		return -EIO;
 
 	J_ASSERT(ext4_journal_current_handle() == NULL);
@@ -116,18 +149,10 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 		goto out;
 	}
 
-	if (!journal) {
-		ret = __generic_file_fsync(file, start, end, datasync);
-		if (!ret)
-			ret = ext4_sync_parent(inode);
-		if (test_opt(inode->i_sb, BARRIER))
-			goto issue_flush;
-		goto out;
-	}
-
 	ret = file_write_and_wait_range(file, start, end);
 	if (ret)
 		return ret;
+
 	/*
 	 * data=writeback,ordered:
 	 *  The caller's filemap_fdatawrite()/wait will sync the data.
@@ -142,18 +167,14 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	 *  (they were dirtied by commit).  But that's OK - the blocks are
 	 *  safe in-journal, which is all fsync() needs to ensure.
 	 */
-	if (ext4_should_journal_data(inode)) {
+	if (!sbi->s_journal) 
+		ret = ext4_fsync_nojournal(inode, datasync, &needs_barrier);
+	else if (ext4_should_journal_data(inode))
 		ret = ext4_force_commit(inode->i_sb);
-		goto out;
-	}
+	else
+		ret = ext4_fsync_journal(inode, datasync, &needs_barrier);
 
-	commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
-	if (journal->j_flags & JBD2_BARRIER &&
-	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
-		needs_barrier = true;
-	ret = jbd2_complete_transaction(journal, commit_tid);
 	if (needs_barrier) {
-	issue_flush:
 		err = blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);
 		if (!ret)
 			ret = err;

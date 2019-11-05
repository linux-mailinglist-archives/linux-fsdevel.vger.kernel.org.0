Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5265EFCE1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Nov 2019 13:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730971AbfKEMCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Nov 2019 07:02:32 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43232 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbfKEMCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Nov 2019 07:02:32 -0500
Received: by mail-pg1-f196.google.com with SMTP id l24so13977016pgh.10
        for <linux-fsdevel@vger.kernel.org>; Tue, 05 Nov 2019 04:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=FCXNM1/u8MXFatH/bliHUcCJojxaabMwp7gXdYHudrI=;
        b=EqT1vkY1v+5H8zuPL7noN3DGNkf1QzdTS6vsDZX4W/+xR95EgvUTc4G9huJbxU71ou
         5thw4DMywxBhAbA9WaPrsLZEuIWkZghIOId8G8q2rFxAmQsGQiuxtR/CaM/X6Udempr0
         rgktWr+qXx8+GWwXbvV16gPVfMcB2eN5hE0FYxikhqX2rqCRcV/36XricXbX0Txiqwxh
         Pb7+5CVjOun7u6w1ZopKTBNRlSgPnzMeKjmJykGFMBFsi0Mc/TRtM7FKVOOtYVTBJjCe
         7xOagpQkoyYwicKK3Q5Ko3LED8K47+yz2NvF3pwfgC/YF3Yf3hntHlxKafA/zK4v77+T
         4ZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=FCXNM1/u8MXFatH/bliHUcCJojxaabMwp7gXdYHudrI=;
        b=nuW+r84O8lIQgWJXmVIFbBhiQ9M5hQhSAx3vt4BgJNdAOddv4OMVhQdJz21dnb5uim
         piwJdTNvoUxGKZqZsGIUR5rJueQj6kobj9FTghJ47pX/6SKvlxN3aS+7oXSF0BFLy04z
         sxGhYUl+50NFZUS6CPu+cOML5WBKKohZjNKRfXV70TioB+g99snqeuewhUC4dIKOzDK3
         hJcc9+flEuV5BCrZC4T123skRgKAn0oy5FH472yEC2XajhHkTT+VVgXsXmgxT6op99/w
         EZqfeuF7OKCdTjT9FstRHWWhRCbc6obXw193XkBSToTGykt4swdKI4Ylq5jk+TaeiCnR
         XHhg==
X-Gm-Message-State: APjAAAWUUuibtbg1X4BA5uzLQCi3ziDxhf4eHxaqxnFMRXj4U1myYKiS
        /rTI2C7jJOIoD/4K5iHhC0Tc
X-Google-Smtp-Source: APXvYqwess4EqxYZl4426W7Pk1Tj4E9hROBvrGLbtzjDO9spCXeuQxvJ5dRc5IGuOa8g/U/t5QsVtA==
X-Received: by 2002:a17:90a:1788:: with SMTP id q8mr6034299pja.139.1572955351511;
        Tue, 05 Nov 2019 04:02:31 -0800 (PST)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id m68sm18781631pfb.122.2019.11.05.04.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 04:02:30 -0800 (PST)
Date:   Tue, 5 Nov 2019 23:02:23 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        riteshh@linux.ibm.com
Subject: [PATCH v7 10/11] ext4: update ext4_sync_file() to not use
 __generic_file_fsync()
Message-ID: <3495f35ef67f2021b567e28e6f59222e583689b8.1572949325.git.mbobrowski@mbobrowski.org>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1572949325.git.mbobrowski@mbobrowski.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the filesystem is created without a journal, we eventually call
into __generic_file_fsync() in order to write out all the modified
in-core data to the permanent storage device. This function happens to
try and obtain an inode_lock() while synchronizing the files buffer
and it's associated metadata.

Generally, this is fine, however it becomes a problem when there is
higher level code that has already obtained an inode_lock() as this
leads to a recursive lock situation. This case is especially true when
porting across direct I/O to iomap infrastructure as we obtain an
inode_lock() early on in the I/O within ext4_dio_write_iter() and hold
it until the I/O has been completed. Consequently, to not run into
this specific issue, we move away from calling into
__generic_file_fsync() and perform the necessary synchronization tasks
within ext4_sync_file().

Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/fsync.c | 72 ++++++++++++++++++++++++++++++++-----------------
 1 file changed, 47 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/fsync.c b/fs/ext4/fsync.c
index 5508baa11bb6..e10206e7f4bb 100644
--- a/fs/ext4/fsync.c
+++ b/fs/ext4/fsync.c
@@ -80,6 +80,43 @@ static int ext4_sync_parent(struct inode *inode)
 	return ret;
 }
 
+static int ext4_fsync_nojournal(struct inode *inode, bool datasync,
+				bool *needs_barrier)
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
+
+	return ret;
+}
+
+static int ext4_fsync_journal(struct inode *inode, bool datasync,
+			     bool *needs_barrier)
+{
+	struct ext4_inode_info *ei = EXT4_I(inode);
+	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
+	tid_t commit_tid = datasync ? ei->i_datasync_tid : ei->i_sync_tid;
+
+	if (journal->j_flags & JBD2_BARRIER &&
+	    !jbd2_trans_will_send_data_barrier(journal, commit_tid))
+		*needs_barrier = true;
+
+	return jbd2_complete_transaction(journal, commit_tid);
+}
+
 /*
  * akpm: A new design for ext4_sync_file().
  *
@@ -91,17 +128,14 @@ static int ext4_sync_parent(struct inode *inode)
  * What we do is just kick off a commit and wait on it.  This will snapshot the
  * inode to disk.
  */
-
 int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 {
-	struct inode *inode = file->f_mapping->host;
-	struct ext4_inode_info *ei = EXT4_I(inode);
-	journal_t *journal = EXT4_SB(inode->i_sb)->s_journal;
 	int ret = 0, err;
-	tid_t commit_tid;
 	bool needs_barrier = false;
+	struct inode *inode = file->f_mapping->host;
+	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 
-	if (unlikely(ext4_forced_shutdown(EXT4_SB(inode->i_sb))))
+	if (unlikely(ext4_forced_shutdown(sbi)))
 		return -EIO;
 
 	J_ASSERT(ext4_journal_current_handle() == NULL);
@@ -111,23 +145,15 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
 	if (sb_rdonly(inode->i_sb)) {
 		/* Make sure that we read updated s_mount_flags value */
 		smp_rmb();
-		if (EXT4_SB(inode->i_sb)->s_mount_flags & EXT4_MF_FS_ABORTED)
+		if (sbi->s_mount_flags & EXT4_MF_FS_ABORTED)
 			ret = -EROFS;
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
@@ -142,18 +168,14 @@ int ext4_sync_file(struct file *file, loff_t start, loff_t end, int datasync)
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
-- 
2.20.1


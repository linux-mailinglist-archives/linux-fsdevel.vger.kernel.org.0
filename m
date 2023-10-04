Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509097B8CF9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 21:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244904AbjJDS5o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:57:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244868AbjJDSze (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:55:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDFC11C;
        Wed,  4 Oct 2023 11:54:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87ACDC433C7;
        Wed,  4 Oct 2023 18:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445692;
        bh=Mlu83hY0TA0SLWkTa1E2exWbT45LagfXuubQHrGjCyQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Et7cLkKBjBGX5glVGBenmgupLEcBZ+Q1K0VDSOEsB8bG+xPxOCiGpeNwhgArqtX1+
         cFS5mLxR7pCEhakR+u4udX35gIKJCPwcfGXJUcF6p19xNA3Ad1grlFgs3yf+8rNHvc
         y16B/B8sZRfFWZh+i97JB99XvihBtDRUBVQoXnjqToWgD/XqRHFQFQw/sZJadkvoyj
         Hdb6j1Otw51cITIueiiICqhg8EKlsQ0X93u/TuQNsVkBrY++bce9Ff79fhXo42bi6A
         JIIAx9GWV0lDmVoHTZsFHNj1eUuKfQQOK4q9zq911tTmcPcEY3ocvIE1vSRmiv+qCI
         7TV+A1zO8POEg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ntfs3@lists.linux.dev
Subject: [PATCH v2 55/89] ntfs3: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:40 -0400
Message-ID: <20231004185347.80880-53-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ntfs3/file.c    |  6 +++---
 fs/ntfs3/frecord.c | 11 +++++++----
 fs/ntfs3/inode.c   | 25 +++++++++++++++----------
 fs/ntfs3/namei.c   |  4 ++--
 4 files changed, 27 insertions(+), 19 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 1f7a194983c5..ad4a70b5d432 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -342,7 +342,7 @@ static int ntfs_extend(struct inode *inode, loff_t pos, size_t count,
 		err = 0;
 	}
 
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	mark_inode_dirty(inode);
 
 	if (IS_SYNC(inode)) {
@@ -400,7 +400,7 @@ static int ntfs_truncate(struct inode *inode, loff_t new_size)
 	ni_unlock(ni);
 
 	ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (!IS_DIRSYNC(inode)) {
 		dirty = 1;
 	} else {
@@ -642,7 +642,7 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		filemap_invalidate_unlock(mapping);
 
 	if (!err) {
-		inode->i_mtime = inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 		mark_inode_dirty(inode);
 	}
 
diff --git a/fs/ntfs3/frecord.c b/fs/ntfs3/frecord.c
index dad976a68985..3df2d9e34b91 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3271,7 +3271,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 	if (is_rec_inuse(ni->mi.mrec) &&
 	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
 		bool modified = false;
-		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 ts;
 
 		/* Update times in standard attribute. */
 		std = ni_std(ni);
@@ -3281,19 +3281,22 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 		}
 
 		/* Update the access times if they have changed. */
-		dup.m_time = kernel2nt(&inode->i_mtime);
+		ts = inode_get_mtime(inode);
+		dup.m_time = kernel2nt(&ts);
 		if (std->m_time != dup.m_time) {
 			std->m_time = dup.m_time;
 			modified = true;
 		}
 
-		dup.c_time = kernel2nt(&ctime);
+		ts = inode_get_mtime(inode);
+		dup.c_time = kernel2nt(&ts);
 		if (std->c_time != dup.c_time) {
 			std->c_time = dup.c_time;
 			modified = true;
 		}
 
-		dup.a_time = kernel2nt(&inode->i_atime);
+		ts = inode_get_atime(inode);
+		dup.a_time = kernel2nt(&ts);
 		if (std->a_time != dup.a_time) {
 			std->a_time = dup.a_time;
 			modified = true;
diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index d6d021e19aaa..5e3d71374918 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -44,7 +44,7 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 	u64 t64;
 	struct MFT_REC *rec;
 	struct runs_tree *run;
-	struct timespec64 ctime;
+	struct timespec64 ts;
 
 	inode->i_op = NULL;
 	/* Setup 'uid' and 'gid' */
@@ -169,10 +169,12 @@ static struct inode *ntfs_read_mft(struct inode *inode,
 #ifdef STATX_BTIME
 		nt2kernel(std5->cr_time, &ni->i_crtime);
 #endif
-		nt2kernel(std5->a_time, &inode->i_atime);
-		nt2kernel(std5->c_time, &ctime);
-		inode_set_ctime_to_ts(inode, ctime);
-		nt2kernel(std5->m_time, &inode->i_mtime);
+		nt2kernel(std5->a_time, &ts);
+		inode_set_atime_to_ts(inode, ts);
+		nt2kernel(std5->c_time, &ts);
+		inode_set_ctime_to_ts(inode, ts);
+		nt2kernel(std5->m_time, &ts);
+		inode_set_mtime_to_ts(inode, ts);
 
 		ni->std_fa = std5->fa;
 
@@ -960,7 +962,8 @@ int ntfs_write_end(struct file *file, struct address_space *mapping, loff_t pos,
 
 	if (err >= 0) {
 		if (!(ni->std_fa & FILE_ATTRIBUTE_ARCHIVE)) {
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 			ni->std_fa |= FILE_ATTRIBUTE_ARCHIVE;
 			dirty = true;
 		}
@@ -1660,9 +1663,11 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 
 	/* Set original time. inode times (i_ctime) may be changed in ntfs_init_acl. */
-	inode->i_atime = inode->i_mtime =
-		inode_set_ctime_to_ts(inode, ni->i_crtime);
-	dir->i_mtime = inode_set_ctime_to_ts(dir, ni->i_crtime);
+	inode_set_atime_to_ts(inode, ni->i_crtime);
+	inode_set_ctime_to_ts(inode, ni->i_crtime);
+	inode_set_mtime_to_ts(inode, ni->i_crtime);
+	inode_set_mtime_to_ts(dir, ni->i_crtime);
+	inode_set_ctime_to_ts(dir, ni->i_crtime);
 
 	mark_inode_dirty(dir);
 	mark_inode_dirty(inode);
@@ -1768,7 +1773,7 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
 
 	if (!err) {
 		drop_nlink(inode);
-		dir->i_mtime = inode_set_ctime_current(dir);
+		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 		mark_inode_dirty(dir);
 		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 		if (inode->i_nlink)
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index eedacf94edd8..ee3093be5170 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -156,8 +156,8 @@ static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry *de)
 	err = ntfs_link_inode(inode, de);
 
 	if (!err) {
-		dir->i_mtime = inode_set_ctime_to_ts(
-			inode, inode_set_ctime_current(dir));
+		inode_set_ctime_current(inode);
+		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 		mark_inode_dirty(inode);
 		mark_inode_dirty(dir);
 		d_instantiate(de, inode);
-- 
2.41.0


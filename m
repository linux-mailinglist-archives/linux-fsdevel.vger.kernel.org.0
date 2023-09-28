Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AA817B1A18
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232350AbjI1LJC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbjI1LHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:07:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26C0F1BD5;
        Thu, 28 Sep 2023 04:05:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 581C0C433C7;
        Thu, 28 Sep 2023 11:05:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899117;
        bh=VoOddC0bAwArgHb3vOT5rLghytzRLWgaGpSm4OmTeJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KhNBn3BxYCjBr/dMVL/hIQjTNr+8NbowJiR6Dsl8pueNgpBQh51yt5Ur4vy9xuGmt
         A72lETOnQh8pXxWkFCmlrzDX95obZWYaCs8PS0Y38F7LKiG99OBvZpE4Mn+sNGedmH
         u0+L4smaq6SjssulnuJeDn66hD49QD3y2/aqllG+sqfn5Il6PlD2k2iCDCDfIEfx7M
         k9orEIDx83ipmxtvKfVye6p3aLSzEUnD7lZb44AWMWBwLaj4KmrWysRBm2f93g/8Xa
         hUdwx2/FqvIoGNY6c/KwE+Yh7YNYaWGwGctADjKIbYOpp5D6juQTiZXWJ2LwDfpqRM
         eDRkh172EohCQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     ntfs3@lists.linux.dev
Subject: [PATCH 54/87] fs/ntfs3: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:03 -0400
Message-ID: <20230928110413.33032-53-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230928110413.33032-1-jlayton@kernel.org>
References: <20230928110300.32891-1-jlayton@kernel.org>
 <20230928110413.33032-1-jlayton@kernel.org>
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

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/ntfs3/file.c    |  6 +++---
 fs/ntfs3/frecord.c | 11 +++++++----
 fs/ntfs3/inode.c   | 22 +++++++++++++---------
 fs/ntfs3/namei.c   |  4 ++--
 4 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 962f12ce6c0a..322fb960ba5d 100644
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
index 2b85cb10f0be..9f66dcf5da8f 100644
--- a/fs/ntfs3/frecord.c
+++ b/fs/ntfs3/frecord.c
@@ -3265,7 +3265,7 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
 	if (is_rec_inuse(ni->mi.mrec) &&
 	    !(sbi->flags & NTFS_FLAGS_LOG_REPLAYING) && inode->i_nlink) {
 		bool modified = false;
-		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 ts;
 
 		/* Update times in standard attribute. */
 		std = ni_std(ni);
@@ -3275,19 +3275,22 @@ int ni_write_inode(struct inode *inode, int sync, const char *hint)
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
index eb2ed0701495..27fb4255f428 100644
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
-		ctime = inode_get_ctime(inode);
-		nt2kernel(std5->c_time, &ctime);
-		nt2kernel(std5->m_time, &inode->i_mtime);
+		ts = inode_get_atime(inode);
+		nt2kernel(std5->a_time, &ts);
+		ts = inode_get_ctime(inode);
+		nt2kernel(std5->c_time, &ts);
+		ts = inode_get_mtime(inode);
+		nt2kernel(std5->m_time, &ts);
 
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
@@ -1660,8 +1663,9 @@ struct inode *ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	d_instantiate(dentry, inode);
 
 	/* Set original time. inode times (i_ctime) may be changed in ntfs_init_acl. */
-	inode->i_atime = inode->i_mtime = inode_set_ctime_to_ts(inode, ni->i_crtime);
-	dir->i_mtime = inode_set_ctime_to_ts(dir, ni->i_crtime);
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, ni->i_crtime)));
+	inode_set_mtime_to_ts(dir, inode_set_ctime_to_ts(dir, ni->i_crtime));
 
 	mark_inode_dirty(dir);
 	mark_inode_dirty(inode);
@@ -1767,7 +1771,7 @@ int ntfs_unlink_inode(struct inode *dir, const struct dentry *dentry)
 
 	if (!err) {
 		drop_nlink(inode);
-		dir->i_mtime = inode_set_ctime_current(dir);
+		inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 		mark_inode_dirty(dir);
 		inode_set_ctime_to_ts(inode, inode_get_ctime(dir));
 		if (inode->i_nlink)
diff --git a/fs/ntfs3/namei.c b/fs/ntfs3/namei.c
index ad430d50bd79..4052edb726ee 100644
--- a/fs/ntfs3/namei.c
+++ b/fs/ntfs3/namei.c
@@ -156,8 +156,8 @@ static int ntfs_link(struct dentry *ode, struct inode *dir, struct dentry *de)
 	err = ntfs_link_inode(inode, de);
 
 	if (!err) {
-		dir->i_mtime = inode_set_ctime_to_ts(inode,
-						     inode_set_ctime_current(dir));
+		inode_set_mtime_to_ts(dir,
+				      inode_set_ctime_to_ts(inode, inode_set_ctime_current(dir)));
 		mark_inode_dirty(inode);
 		mark_inode_dirty(dir);
 		d_instantiate(de, inode);
-- 
2.41.0


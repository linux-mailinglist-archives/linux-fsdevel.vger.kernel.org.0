Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF9EC7B1AD7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjI1LXJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:23:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjI1LWr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:22:47 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD912704;
        Thu, 28 Sep 2023 04:05:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26AEBC433AB;
        Thu, 28 Sep 2023 11:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899140;
        bh=EETefCC4PhJP5eqMugpUBPNyeKL9S9OpYWxMmw5MjD0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=LXCpuJUeH9PEnmpKwiVfopj/Q6aTMU6bxwUvNx+C1K8sab0ITDY3zapTRuo7c27Qv
         txaV4jwIEybdz9E/JVFgfIhyM4Xda4PyYjQTvNvgKeA8YOPKh7uu5qlkeCkBe2LLlI
         OoINeKE8yPkmW2oqB5ToBNbhVQA9mw98SdhMctkxmDx9oCTwBR0qYz2ZyUPFAAMiIl
         JwNZjo3CV4v1fM5Juc9cQpiQ+zKN4cPf6x/UWna3lkfA5ghTmVAHskBR3k3jmBaCpi
         9nG4h83VqiFmUaJpd1rytFf3yu+SIgQw60fVbO7CSr/6ItvOUOmFr6AxEbXaOy7m80
         Fl11VTRgHm0kg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 73/87] fs/udf: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:22 -0400
Message-ID: <20230928110413.33032-72-jlayton@kernel.org>
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
 fs/udf/ialloc.c |  4 ++--
 fs/udf/inode.c  | 38 ++++++++++++++++++++++----------------
 fs/udf/namei.c  | 16 ++++++++--------
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/fs/udf/ialloc.c b/fs/udf/ialloc.c
index 6b558cbbeb6b..5f1f969f4134 100644
--- a/fs/udf/ialloc.c
+++ b/fs/udf/ialloc.c
@@ -100,8 +100,8 @@ struct inode *udf_new_inode(struct inode *dir, umode_t mode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
-	iinfo->i_crtime = inode->i_mtime;
+	simple_inode_init_ts(inode);
+	iinfo->i_crtime = inode_get_mtime(inode);
 	if (unlikely(insert_inode_locked(inode) < 0)) {
 		make_bad_inode(inode);
 		iput(inode);
diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index a17a6184cc39..d8493449d4c5 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -1296,7 +1296,7 @@ int udf_setsize(struct inode *inode, loff_t newsize)
 			goto out_unlock;
 	}
 update_time:
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	if (IS_SYNC(inode))
 		udf_sync_inode(inode);
 	else
@@ -1327,7 +1327,7 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 	int bs = inode->i_sb->s_blocksize;
 	int ret = -EIO;
 	uint32_t uid, gid;
-	struct timespec64 ctime;
+	struct timespec64 ts;
 
 reread:
 	if (iloc->partitionReferenceNum >= sbi->s_partitions) {
@@ -1504,10 +1504,12 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		inode->i_blocks = le64_to_cpu(fe->logicalBlocksRecorded) <<
 			(inode->i_sb->s_blocksize_bits - 9);
 
-		udf_disk_stamp_to_time(&inode->i_atime, fe->accessTime);
-		udf_disk_stamp_to_time(&inode->i_mtime, fe->modificationTime);
-		udf_disk_stamp_to_time(&ctime, fe->attrTime);
-		inode_set_ctime_to_ts(inode, ctime);
+		udf_disk_stamp_to_time(&ts, fe->accessTime);
+		inode_set_atime_to_ts(inode, ts);
+		udf_disk_stamp_to_time(&ts, fe->modificationTime);
+		inode_set_mtime_to_ts(inode, ts);
+		udf_disk_stamp_to_time(&ts, fe->attrTime);
+		inode_set_ctime_to_ts(inode, ts);
 
 		iinfo->i_unique = le64_to_cpu(fe->uniqueID);
 		iinfo->i_lenEAttr = le32_to_cpu(fe->lengthExtendedAttr);
@@ -1519,11 +1521,13 @@ static int udf_read_inode(struct inode *inode, bool hidden_inode)
 		inode->i_blocks = le64_to_cpu(efe->logicalBlocksRecorded) <<
 		    (inode->i_sb->s_blocksize_bits - 9);
 
-		udf_disk_stamp_to_time(&inode->i_atime, efe->accessTime);
-		udf_disk_stamp_to_time(&inode->i_mtime, efe->modificationTime);
+		udf_disk_stamp_to_time(&ts, efe->accessTime);
+		inode_set_atime_to_ts(inode, ts);
+		udf_disk_stamp_to_time(&ts, efe->modificationTime);
+		inode_set_mtime_to_ts(inode, ts);
+		udf_disk_stamp_to_time(&ts, efe->attrTime);
+		inode_set_ctime_to_ts(inode, ts);
 		udf_disk_stamp_to_time(&iinfo->i_crtime, efe->createTime);
-		udf_disk_stamp_to_time(&ctime, efe->attrTime);
-		inode_set_ctime_to_ts(inode, ctime);
 
 		iinfo->i_unique = le64_to_cpu(efe->uniqueID);
 		iinfo->i_lenEAttr = le32_to_cpu(efe->lengthExtendedAttr);
@@ -1798,8 +1802,8 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 		       inode->i_sb->s_blocksize - sizeof(struct fileEntry));
 		fe->logicalBlocksRecorded = cpu_to_le64(lb_recorded);
 
-		udf_time_to_disk_stamp(&fe->accessTime, inode->i_atime);
-		udf_time_to_disk_stamp(&fe->modificationTime, inode->i_mtime);
+		udf_time_to_disk_stamp(&fe->accessTime, inode_get_atime(inode));
+		udf_time_to_disk_stamp(&fe->modificationTime, inode_get_mtime(inode));
 		udf_time_to_disk_stamp(&fe->attrTime, inode_get_ctime(inode));
 		memset(&(fe->impIdent), 0, sizeof(struct regid));
 		strcpy(fe->impIdent.ident, UDF_ID_DEVELOPER);
@@ -1829,12 +1833,14 @@ static int udf_update_inode(struct inode *inode, int do_sync)
 				cpu_to_le32(inode->i_sb->s_blocksize);
 		}
 
-		udf_adjust_time(iinfo, inode->i_atime);
-		udf_adjust_time(iinfo, inode->i_mtime);
+		udf_adjust_time(iinfo, inode_get_atime(inode));
+		udf_adjust_time(iinfo, inode_get_mtime(inode));
 		udf_adjust_time(iinfo, inode_get_ctime(inode));
 
-		udf_time_to_disk_stamp(&efe->accessTime, inode->i_atime);
-		udf_time_to_disk_stamp(&efe->modificationTime, inode->i_mtime);
+		udf_time_to_disk_stamp(&efe->accessTime,
+				       inode_get_atime(inode));
+		udf_time_to_disk_stamp(&efe->modificationTime,
+				       inode_get_mtime(inode));
 		udf_time_to_disk_stamp(&efe->createTime, iinfo->i_crtime);
 		udf_time_to_disk_stamp(&efe->attrTime, inode_get_ctime(inode));
 
diff --git a/fs/udf/namei.c b/fs/udf/namei.c
index ae55ab8859b6..3508ac484da3 100644
--- a/fs/udf/namei.c
+++ b/fs/udf/namei.c
@@ -365,7 +365,7 @@ static int udf_add_nondir(struct dentry *dentry, struct inode *inode)
 	*(__le32 *)((struct allocDescImpUse *)iter.fi.icb.impUse)->impUse =
 		cpu_to_le32(iinfo->i_unique & 0x00000000FFFFFFFFUL);
 	udf_fiiter_write_fi(&iter, NULL);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	udf_fiiter_release(&iter);
 	udf_add_fid_counter(dir->i_sb, false, 1);
@@ -471,7 +471,7 @@ static int udf_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	udf_fiiter_release(&iter);
 	udf_add_fid_counter(dir->i_sb, true, 1);
 	inc_nlink(dir);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	d_instantiate_new(dentry, inode);
 
@@ -523,8 +523,8 @@ static int udf_rmdir(struct inode *dir, struct dentry *dentry)
 	inode->i_size = 0;
 	inode_dec_link_count(dir);
 	udf_add_fid_counter(dir->i_sb, true, -1);
-	dir->i_mtime = inode_set_ctime_to_ts(dir,
-					     inode_set_ctime_current(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	mark_inode_dirty(dir);
 	ret = 0;
 end_rmdir:
@@ -555,7 +555,7 @@ static int udf_unlink(struct inode *dir, struct dentry *dentry)
 		set_nlink(inode, 1);
 	}
 	udf_fiiter_delete_entry(&iter);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	inode_dec_link_count(inode);
 	udf_add_fid_counter(dir->i_sb, false, -1);
@@ -748,7 +748,7 @@ static int udf_link(struct dentry *old_dentry, struct inode *dir,
 	udf_add_fid_counter(dir->i_sb, false, 1);
 	inode_set_ctime_current(inode);
 	mark_inode_dirty(inode);
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	ihold(inode);
 	d_instantiate(dentry, inode);
@@ -866,8 +866,8 @@ static int udf_rename(struct mnt_idmap *idmap, struct inode *old_dir,
 		udf_add_fid_counter(old_dir->i_sb, S_ISDIR(new_inode->i_mode),
 				    -1);
 	}
-	old_dir->i_mtime = inode_set_ctime_current(old_dir);
-	new_dir->i_mtime = inode_set_ctime_current(new_dir);
+	inode_set_mtime_to_ts(old_dir, inode_set_ctime_current(old_dir));
+	inode_set_mtime_to_ts(new_dir, inode_set_ctime_current(new_dir));
 	mark_inode_dirty(old_dir);
 	mark_inode_dirty(new_dir);
 
-- 
2.41.0


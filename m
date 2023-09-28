Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D53A87B19F3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232330AbjI1LHf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232327AbjI1LFw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:05:52 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9E71719;
        Thu, 28 Sep 2023 04:05:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D6BC433CC;
        Thu, 28 Sep 2023 11:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899100;
        bh=o/qo3CrzMmkLPvPpAAGO/0Dnli2+rjIlheR89soL8dY=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=aFkp7KS1saMawsxU7dNgzftiDxydL6FnD5UtpsQeKyRaLj93a/GTEfNuYvXZGxLUa
         y2h2Bgf0bkIPU+vGWI4HOI85Lijq4bblTdLW7b9PYqMOF+cKCk1b7gvN+DgQN24Cnf
         bMu06kRr/FRbStBoa15L4rxELzL+PMWd2y7PtXdnTt+hDSIAYuicY4XkzALqO2wdbh
         TI9vzINDVMgZpZvxTENx6ltIGnkfZfLpux6RaSDHZ5D1UyfJGcn6s2b98MUamUARa3
         DU4l2kQ1FO+ZnJFb/pKoGuLouI2Gl1XVI8hL3oKqH0yZOCzfLoSGPf11nKQ6h/Fh8n
         iPTRFU7dSce4Q==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 40/87] fs/hfs: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:02:49 -0400
Message-ID: <20230928110413.33032-39-jlayton@kernel.org>
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
 fs/hfs/catalog.c |  8 ++++----
 fs/hfs/inode.c   | 16 ++++++++--------
 fs/hfs/sysdep.c  | 10 ++++++----
 3 files changed, 18 insertions(+), 16 deletions(-)

diff --git a/fs/hfs/catalog.c b/fs/hfs/catalog.c
index 632c226a3972..d63880e7d9d6 100644
--- a/fs/hfs/catalog.c
+++ b/fs/hfs/catalog.c
@@ -133,7 +133,7 @@ int hfs_cat_create(u32 cnid, struct inode *dir, const struct qstr *str, struct i
 		goto err1;
 
 	dir->i_size++;
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	hfs_find_exit(&fd);
 	return 0;
@@ -269,7 +269,7 @@ int hfs_cat_delete(u32 cnid, struct inode *dir, const struct qstr *str)
 	}
 
 	dir->i_size--;
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	mark_inode_dirty(dir);
 	res = 0;
 out:
@@ -337,7 +337,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 	if (err)
 		goto out;
 	dst_dir->i_size++;
-	dst_dir->i_mtime = inode_set_ctime_current(dst_dir);
+	inode_set_mtime_to_ts(dst_dir, inode_set_ctime_current(dst_dir));
 	mark_inode_dirty(dst_dir);
 
 	/* finally remove the old entry */
@@ -349,7 +349,7 @@ int hfs_cat_move(u32 cnid, struct inode *src_dir, const struct qstr *src_name,
 	if (err)
 		goto out;
 	src_dir->i_size--;
-	src_dir->i_mtime = inode_set_ctime_current(src_dir);
+	inode_set_mtime_to_ts(src_dir, inode_set_ctime_current(src_dir));
 	mark_inode_dirty(src_dir);
 
 	type = entry.type;
diff --git a/fs/hfs/inode.c b/fs/hfs/inode.c
index ee349b72cfb3..a7bc4690a780 100644
--- a/fs/hfs/inode.c
+++ b/fs/hfs/inode.c
@@ -200,7 +200,7 @@ struct inode *hfs_new_inode(struct inode *dir, const struct qstr *name, umode_t
 	inode->i_uid = current_fsuid();
 	inode->i_gid = current_fsgid();
 	set_nlink(inode, 1);
-	inode->i_mtime = inode->i_atime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	HFS_I(inode)->flags = 0;
 	HFS_I(inode)->rsrc_inode = NULL;
 	HFS_I(inode)->fs_blocks = 0;
@@ -355,8 +355,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 			inode->i_mode |= S_IWUGO;
 		inode->i_mode &= ~hsb->s_file_umask;
 		inode->i_mode |= S_IFREG;
-		inode->i_atime = inode->i_mtime = inode_set_ctime_to_ts(inode,
-									hfs_m_to_utime(rec->file.MdDat));
+		inode_set_mtime_to_ts(inode,
+				      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->file.MdDat))));
 		inode->i_op = &hfs_file_inode_operations;
 		inode->i_fop = &hfs_file_operations;
 		inode->i_mapping->a_ops = &hfs_aops;
@@ -366,8 +366,8 @@ static int hfs_read_inode(struct inode *inode, void *data)
 		inode->i_size = be16_to_cpu(rec->dir.Val) + 2;
 		HFS_I(inode)->fs_blocks = 0;
 		inode->i_mode = S_IFDIR | (S_IRWXUGO & ~hsb->s_dir_umask);
-		inode->i_atime = inode->i_mtime = inode_set_ctime_to_ts(inode,
-									hfs_m_to_utime(rec->dir.MdDat));
+		inode_set_mtime_to_ts(inode,
+				      inode_set_atime_to_ts(inode, inode_set_ctime_to_ts(inode, hfs_m_to_utime(rec->dir.MdDat))));
 		inode->i_op = &hfs_dir_inode_operations;
 		inode->i_fop = &hfs_dir_operations;
 		break;
@@ -474,7 +474,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		    be32_to_cpu(rec.dir.DirID) != inode->i_ino) {
 		}
 
-		rec.dir.MdDat = hfs_u_to_mtime(inode->i_mtime);
+		rec.dir.MdDat = hfs_u_to_mtime(inode_get_mtime(inode));
 		rec.dir.Val = cpu_to_be16(inode->i_size - 2);
 
 		hfs_bnode_write(fd.bnode, &rec, fd.entryoffset,
@@ -502,7 +502,7 @@ int hfs_write_inode(struct inode *inode, struct writeback_control *wbc)
 		else
 			rec.file.Flags |= HFS_FIL_LOCK;
 		hfs_inode_write_fork(inode, rec.file.ExtRec, &rec.file.LgLen, &rec.file.PyLen);
-		rec.file.MdDat = hfs_u_to_mtime(inode->i_mtime);
+		rec.file.MdDat = hfs_u_to_mtime(inode_get_mtime(inode));
 
 		hfs_bnode_write(fd.bnode, &rec, fd.entryoffset,
 			    sizeof(struct hfs_cat_file));
@@ -654,7 +654,7 @@ int hfs_inode_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 		truncate_setsize(inode, attr->ia_size);
 		hfs_file_truncate(inode);
-		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+		simple_inode_init_ts(inode);
 	}
 
 	setattr_copy(&nop_mnt_idmap, inode, attr);
diff --git a/fs/hfs/sysdep.c b/fs/hfs/sysdep.c
index dc27d418fbcd..76fa02e3835b 100644
--- a/fs/hfs/sysdep.c
+++ b/fs/hfs/sysdep.c
@@ -28,11 +28,13 @@ static int hfs_revalidate_dentry(struct dentry *dentry, unsigned int flags)
 	/* fix up inode on a timezone change */
 	diff = sys_tz.tz_minuteswest * 60 - HFS_I(inode)->tz_secondswest;
 	if (diff) {
-		struct timespec64 ctime = inode_get_ctime(inode);
+		struct timespec64 ts = inode_get_ctime(inode);
 
-		inode_set_ctime(inode, ctime.tv_sec + diff, ctime.tv_nsec);
-		inode->i_atime.tv_sec += diff;
-		inode->i_mtime.tv_sec += diff;
+		inode_set_ctime(inode, ts.tv_sec + diff, ts.tv_nsec);
+		ts = inode_get_atime(inode);
+		inode_set_atime(inode, ts.tv_sec + diff, ts.tv_nsec);
+		ts = inode_get_mtime(inode);
+		inode_set_mtime(inode, ts.tv_sec + diff, ts.tv_nsec);
 		HFS_I(inode)->tz_secondswest += diff;
 	}
 	return 1;
-- 
2.41.0


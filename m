Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF95B7B8BD1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245018AbjJDSzy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:55:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244845AbjJDSyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3996F10EC;
        Wed,  4 Oct 2023 11:54:30 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550FFC433CA;
        Wed,  4 Oct 2023 18:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445669;
        bh=F1w46M8uNPh8dz51qRijLO0+0UFVX+P0B4bmFxVHd34=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=sQNNxDf3hAYMEpihh9arqCjkOyLgNsRjzSacYhqh9DV5Ll2zT5dPNrBqiatsTTgLN
         6C2q+UexIKOqn+Oe3toL6RNtw69QewLLzivk2wk64y8k5EI0NwZ63PoE6TNmLYQ9UP
         WTeKEyKKYiyrv+UgPj8n1PE7fjfrNuRo6lNGcTcbtzPnG/0CD1Igs0dQwCzUOhpo73
         NCRX5ycxcPVWFhU77cwpcBMyTGKaIj+WVxAAvJUZeArWVBTlZh9rNEAH+dK0wAI2MF
         e066QfpvLl3VVfa4mZdScCxhtRz5LjZBk0QLkPUPJC5KyvY9shgBP4Mu6m/d1YNS/E
         h4BvqcBVuYegQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 37/89] fat: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:52:22 -0400
Message-ID: <20231004185347.80880-35-jlayton@kernel.org>
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
 fs/fat/inode.c | 25 +++++++++++++++++--------
 fs/fat/misc.c  |  6 +++---
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/fs/fat/inode.c b/fs/fat/inode.c
index cdd39b6020f3..aa87f323fd44 100644
--- a/fs/fat/inode.c
+++ b/fs/fat/inode.c
@@ -512,6 +512,7 @@ static int fat_validate_dir(struct inode *dir)
 int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 {
 	struct msdos_sb_info *sbi = MSDOS_SB(inode->i_sb);
+	struct timespec64 mtime;
 	int error;
 
 	MSDOS_I(inode)->i_pos = 0;
@@ -561,14 +562,18 @@ int fat_fill_inode(struct inode *inode, struct msdos_dir_entry *de)
 	inode->i_blocks = ((inode->i_size + (sbi->cluster_size - 1))
 			   & ~((loff_t)sbi->cluster_size - 1)) >> 9;
 
-	fat_time_fat2unix(sbi, &inode->i_mtime, de->time, de->date, 0);
-	inode_set_ctime_to_ts(inode, inode->i_mtime);
+	fat_time_fat2unix(sbi, &mtime, de->time, de->date, 0);
+	inode_set_mtime_to_ts(inode, mtime);
+	inode_set_ctime_to_ts(inode, mtime);
 	if (sbi->options.isvfat) {
-		fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
+		struct timespec64 atime;
+
+		fat_time_fat2unix(sbi, &atime, 0, de->adate, 0);
+		inode_set_atime_to_ts(inode, atime);
 		fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
 				  de->cdate, de->ctime_cs);
 	} else
-		inode->i_atime = fat_truncate_atime(sbi, &inode->i_mtime);
+		inode_set_atime_to_ts(inode, fat_truncate_atime(sbi, &mtime));
 
 	return 0;
 }
@@ -849,6 +854,7 @@ static int __fat_write_inode(struct inode *inode, int wait)
 	struct msdos_sb_info *sbi = MSDOS_SB(sb);
 	struct buffer_head *bh;
 	struct msdos_dir_entry *raw_entry;
+	struct timespec64 mtime;
 	loff_t i_pos;
 	sector_t blocknr;
 	int err, offset;
@@ -882,12 +888,14 @@ static int __fat_write_inode(struct inode *inode, int wait)
 		raw_entry->size = cpu_to_le32(inode->i_size);
 	raw_entry->attr = fat_make_attrs(inode);
 	fat_set_start(raw_entry, MSDOS_I(inode)->i_logstart);
-	fat_time_unix2fat(sbi, &inode->i_mtime, &raw_entry->time,
+	fat_time_unix2fat(sbi, &mtime, &raw_entry->time,
 			  &raw_entry->date, NULL);
+	inode_set_mtime_to_ts(inode, mtime);
 	if (sbi->options.isvfat) {
+		struct timespec64 ts = inode_get_atime(inode);
 		__le16 atime;
-		fat_time_unix2fat(sbi, &inode->i_atime, &atime,
-				  &raw_entry->adate, NULL);
+
+		fat_time_unix2fat(sbi, &ts, &atime, &raw_entry->adate, NULL);
 		fat_time_unix2fat(sbi, &MSDOS_I(inode)->i_crtime, &raw_entry->ctime,
 				  &raw_entry->cdate, &raw_entry->ctime_cs);
 	}
@@ -1407,7 +1415,8 @@ static int fat_read_root(struct inode *inode)
 	MSDOS_I(inode)->mmu_private = inode->i_size;
 
 	fat_save_attrs(inode, ATTR_DIR);
-	inode->i_mtime = inode->i_atime = inode_set_ctime(inode, 0, 0);
+	inode_set_mtime_to_ts(inode,
+			      inode_set_atime_to_ts(inode, inode_set_ctime(inode, 0, 0)));
 	set_nlink(inode, fat_subdirs(inode)+2);
 
 	return 0;
diff --git a/fs/fat/misc.c b/fs/fat/misc.c
index f2304a1054aa..c7a2d27120ba 100644
--- a/fs/fat/misc.c
+++ b/fs/fat/misc.c
@@ -325,15 +325,15 @@ int fat_truncate_time(struct inode *inode, struct timespec64 *now, int flags)
 	}
 
 	if (flags & S_ATIME)
-		inode->i_atime = fat_truncate_atime(sbi, now);
+		inode_set_atime_to_ts(inode, fat_truncate_atime(sbi, now));
 	/*
 	 * ctime and mtime share the same on-disk field, and should be
 	 * identical in memory. all mtime updates will be applied to ctime,
 	 * but ctime updates are ignored.
 	 */
 	if (flags & S_MTIME)
-		inode->i_mtime = inode_set_ctime_to_ts(inode,
-						       fat_truncate_mtime(sbi, now));
+		inode_set_mtime_to_ts(inode,
+				      inode_set_ctime_to_ts(inode, fat_truncate_mtime(sbi, now)));
 
 	return 0;
 }
-- 
2.41.0


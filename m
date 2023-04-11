Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7C116DDE25
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Apr 2023 16:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229778AbjDKOhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Apr 2023 10:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbjDKOhM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Apr 2023 10:37:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDE244A5;
        Tue, 11 Apr 2023 07:37:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C152B627D5;
        Tue, 11 Apr 2023 14:37:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11462C433D2;
        Tue, 11 Apr 2023 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681223828;
        bh=0tABut1wgcVqOORC6SjkhEn9chzMnRxYPBvizenz41c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lntjKiiqZL6UbCt/BYubnJScSkK71phIse7M0U/lbZ0038OMjKxYZ86HeesTUNRiW
         6on5MlC3P7XAYgkRSTqi+5y4jfRKmMERr9fmB5rmT2g2nxB1OyYiqsFg07Fbjp7SaJ
         pxLUkZoPVRLV3lesysLW9ycHuy2mc0iJ2vqpsCcvIgg6TVIJcEW9FYcPzyLsIz4Q0c
         t18Z5idZUpbhweCcB5aHNZP3jJl4/NXMWsMrQI7f2lvwoKivfceipbq+9TywahTo+i
         mqrgqNEYWK1vf+bEmSZSLnC3n2tgkSZpsbghL49bnexSbyv0nAYLmKmEwJYMUkmnew
         3esCI9rV5pXUw==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org
Subject: [RFC PATCH 2/3][RESEND] shmem: mark for high-res timestamps on next update after getattr
Date:   Tue, 11 Apr 2023 10:37:01 -0400
Message-Id: <20230411143702.64495-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230411143702.64495-1-jlayton@kernel.org>
References: <20230411143702.64495-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When the mtime or ctime is being queried via getattr, ensure that we
mark the inode for a high-res timestamp update on the next pass. Also,
switch to current_cmtime for other c/mtime updates.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 448f393d8ab2..75dd09492c36 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1039,7 +1039,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 {
 	shmem_undo_range(inode, lstart, lend, false);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_ctime = inode->i_mtime = current_cmtime(inode);
 	inode_inc_iversion(inode);
 }
 EXPORT_SYMBOL_GPL(shmem_truncate_range);
@@ -1065,7 +1065,10 @@ static int shmem_getattr(struct mnt_idmap *idmap,
 	stat->attributes_mask |= (STATX_ATTR_APPEND |
 			STATX_ATTR_IMMUTABLE |
 			STATX_ATTR_NODUMP);
+
 	generic_fillattr(idmap, inode, stat);
+	if (request_mask & (STATX_CTIME|STATX_MTIME))
+		fill_cmtime_and_mark(inode, stat);
 
 	if (shmem_is_huge(inode, 0, false, NULL, 0))
 		stat->blksize = HPAGE_PMD_SIZE;
@@ -1136,7 +1139,7 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
 	if (!error && update_ctime) {
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_cmtime(inode);
 		if (update_mtime)
 			inode->i_mtime = inode->i_ctime;
 		inode_inc_iversion(inode);
@@ -2361,7 +2364,7 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 		inode->i_ino = ino;
 		inode_init_owner(idmap, inode, dir, mode);
 		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode->i_ctime = current_cmtime(inode);
 		inode->i_generation = get_random_u32();
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
@@ -2940,7 +2943,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 
 		error = 0;
 		dir->i_size += BOGO_DIRENT_SIZE;
-		dir->i_ctime = dir->i_mtime = current_time(dir);
+		dir->i_ctime = dir->i_mtime = current_cmtime(dir);
 		inode_inc_iversion(dir);
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
@@ -3016,7 +3019,7 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 	}
 
 	dir->i_size += BOGO_DIRENT_SIZE;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_cmtime(inode);
 	inode_inc_iversion(dir);
 	inc_nlink(inode);
 	ihold(inode);	/* New dentry reference */
@@ -3034,7 +3037,7 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 		shmem_free_inode(inode->i_sb);
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_cmtime(inode);
 	inode_inc_iversion(dir);
 	drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
@@ -3124,7 +3127,7 @@ static int shmem_rename2(struct mnt_idmap *idmap,
 	new_dir->i_size += BOGO_DIRENT_SIZE;
 	old_dir->i_ctime = old_dir->i_mtime =
 	new_dir->i_ctime = new_dir->i_mtime =
-	inode->i_ctime = current_time(old_dir);
+	inode->i_ctime = current_cmtime(old_dir);
 	inode_inc_iversion(old_dir);
 	inode_inc_iversion(new_dir);
 	return 0;
@@ -3178,7 +3181,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_put(folio);
 	}
 	dir->i_size += BOGO_DIRENT_SIZE;
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_ctime = dir->i_mtime = current_cmtime(dir);
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);
@@ -3250,7 +3253,7 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
 		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
 
 	shmem_set_inode_flags(inode, info->fsflags);
-	inode->i_ctime = current_time(inode);
+	inode->i_ctime = current_cmtime(inode);
 	inode_inc_iversion(inode);
 	return 0;
 }
@@ -3320,7 +3323,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 	name = xattr_full_name(handler, name);
 	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
 	if (!err) {
-		inode->i_ctime = current_time(inode);
+		inode->i_ctime = current_cmtime(inode);
 		inode_inc_iversion(inode);
 	}
 	return err;
-- 
2.39.2


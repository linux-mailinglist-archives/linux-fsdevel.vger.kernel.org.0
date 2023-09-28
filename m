Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6287B1AA1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Sep 2023 13:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231935AbjI1LUr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Sep 2023 07:20:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjI1LU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Sep 2023 07:20:27 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A71630D0;
        Thu, 28 Sep 2023 04:05:51 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA775C116A4;
        Thu, 28 Sep 2023 11:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695899149;
        bh=uFrEzvYVQCsriiMGkk8AKLTd0LQsQsSJjSLze8FhJ9E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=By3nvlPwwALdU/McvKHBoddMEDKfobu2wT0jBMPExLOGfgXT7dqsgh7GI1xdf7haq
         wDtMEr6nybvX6l/M/85HTUlMX7yEVTLkzoFkHYiJ/3wP9SVesXSe1RTNOgJhfJ1rdo
         3Y13+MJ0VUOStyZz/0Oq/gy3FNncWzGLN29tLpmVFCDOTUuDS2oCpQBF+53VkbPuea
         wNUZrINU+eN/Rw+31QzziJWDr3kybOsf88fvuRociCfPJ0EOGi8zZjvVrBNP0JHknr
         jWNtQBkKy0PIMofs4A2OaNWPYgsTY5zB0TzMvYSY0JUMxCdOIl2Wq1XyDxxjA1+F06
         vsMHBm6doTiXQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org
Subject: [PATCH 80/87] mm: convert to new inode {a,m}time accessors
Date:   Thu, 28 Sep 2023 07:03:29 -0400
Message-ID: <20230928110413.33032-79-jlayton@kernel.org>
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
 mm/shmem.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 69595d341882..c48239bfa646 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1112,7 +1112,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 {
 	shmem_undo_range(inode, lstart, lend, false);
-	inode->i_mtime = inode_set_ctime_current(inode);
+	inode_set_mtime_to_ts(inode, inode_set_ctime_current(inode));
 	inode_inc_iversion(inode);
 }
 EXPORT_SYMBOL_GPL(shmem_truncate_range);
@@ -1224,7 +1224,7 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 	if (!error && update_ctime) {
 		inode_set_ctime_current(inode);
 		if (update_mtime)
-			inode->i_mtime = inode_get_ctime(inode);
+			inode_set_mtime_to_ts(inode, inode_get_ctime(inode));
 		inode_inc_iversion(inode);
 	}
 	return error;
@@ -2455,7 +2455,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	inode->i_ino = ino;
 	inode_init_owner(idmap, inode, dir, mode);
 	inode->i_blocks = 0;
-	inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
+	simple_inode_init_ts(inode);
 	inode->i_generation = get_random_u32();
 	info = SHMEM_I(inode);
 	memset(info, 0, (char *)inode - (char *)info);
@@ -2463,7 +2463,7 @@ static struct inode *__shmem_get_inode(struct mnt_idmap *idmap,
 	atomic_set(&info->stop_eviction, 0);
 	info->seals = F_SEAL_SEAL;
 	info->flags = flags & VM_NORESERVE;
-	info->i_crtime = inode->i_mtime;
+	info->i_crtime = inode_get_mtime(inode);
 	info->fsflags = (dir == NULL) ? 0 :
 		SHMEM_I(dir)->fsflags & SHMEM_FL_INHERITED;
 	if (info->fsflags)
@@ -3229,7 +3229,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 		goto out_iput;
 
 	dir->i_size += BOGO_DIRENT_SIZE;
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry); /* Extra count - pin the dentry in core */
@@ -3318,8 +3318,8 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 	}
 
 	dir->i_size += BOGO_DIRENT_SIZE;
-	dir->i_mtime = inode_set_ctime_to_ts(dir,
-					     inode_set_ctime_current(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	inode_inc_iversion(dir);
 	inc_nlink(inode);
 	ihold(inode);	/* New dentry reference */
@@ -3339,8 +3339,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
-	dir->i_mtime = inode_set_ctime_to_ts(dir,
-					     inode_set_ctime_current(inode));
+	inode_set_mtime_to_ts(dir,
+			      inode_set_ctime_to_ts(dir, inode_set_ctime_current(inode)));
 	inode_inc_iversion(dir);
 	drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
@@ -3488,7 +3488,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_put(folio);
 	}
 	dir->i_size += BOGO_DIRENT_SIZE;
-	dir->i_mtime = inode_set_ctime_current(dir);
+	inode_set_mtime_to_ts(dir, inode_set_ctime_current(dir));
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);
-- 
2.41.0


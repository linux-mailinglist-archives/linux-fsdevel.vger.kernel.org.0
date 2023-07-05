Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 420B7748D76
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbjGETLB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:11:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234076AbjGETKY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:10:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B9B3C27;
        Wed,  5 Jul 2023 12:05:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFD3C616D1;
        Wed,  5 Jul 2023 19:05:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D8DC433C9;
        Wed,  5 Jul 2023 19:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583941;
        bh=GKBCwLrYWAi3v0y6MO93lIfNnq+o58agxgcNSmD247M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VjCutnJIUPMgnmCBtHf33PNh66QZiXyZbegxgDSHMXLyEpi+E2XZBS7unmk8g5A/E
         1vRwbOcVg4MwoSTulTtqWD0yc1P69v1xHCJV2TMVBBJoxmXNBIRwRd0uEEIJWTotPd
         wxit/iq+dAgVTkGNqSQYiC9d5RYFXT1Ct1ySxYchal2VyA1P7wrcmB1oXBE87t0tWS
         08zPWFehqqaG8ePSrnTE+HN/vd5S0N1pAxoYU7s3aoKTrQVfbRMXKh2JCs67bTUQkQ
         VygI7K4nV0a1+8iHMw7HZrrGWS5C8bZmEz03rcLQBUucWi0VIBEWLmYHSbaViiOSvy
         CR1BGZAbDI8Wg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH v2 87/92] shmem: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:52 -0400
Message-ID: <20230705190309.579783-85-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 mm/shmem.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/mm/shmem.c b/mm/shmem.c
index 1693134959c5..51aaaf479437 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -1064,7 +1064,7 @@ static void shmem_undo_range(struct inode *inode, loff_t lstart, loff_t lend,
 void shmem_truncate_range(struct inode *inode, loff_t lstart, loff_t lend)
 {
 	shmem_undo_range(inode, lstart, lend, false);
-	inode->i_ctime = inode->i_mtime = current_time(inode);
+	inode->i_mtime = inode_set_ctime_current(inode);
 	inode_inc_iversion(inode);
 }
 EXPORT_SYMBOL_GPL(shmem_truncate_range);
@@ -1161,9 +1161,9 @@ static int shmem_setattr(struct mnt_idmap *idmap,
 	if (attr->ia_valid & ATTR_MODE)
 		error = posix_acl_chmod(idmap, dentry, inode->i_mode);
 	if (!error && update_ctime) {
-		inode->i_ctime = current_time(inode);
+		inode_set_ctime_current(inode);
 		if (update_mtime)
-			inode->i_mtime = inode->i_ctime;
+			inode->i_mtime = inode_get_ctime(inode);
 		inode_inc_iversion(inode);
 	}
 	return error;
@@ -2394,7 +2394,7 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 		inode->i_ino = ino;
 		inode_init_owner(idmap, inode, dir, mode);
 		inode->i_blocks = 0;
-		inode->i_atime = inode->i_mtime = inode->i_ctime = current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 		inode->i_generation = get_random_u32();
 		info = SHMEM_I(inode);
 		memset(info, 0, (char *)inode - (char *)info);
@@ -3110,7 +3110,7 @@ shmem_mknod(struct mnt_idmap *idmap, struct inode *dir,
 			goto out_iput;
 
 		dir->i_size += BOGO_DIRENT_SIZE;
-		dir->i_ctime = dir->i_mtime = current_time(dir);
+		dir->i_mtime = inode_set_ctime_current(dir);
 		inode_inc_iversion(dir);
 		d_instantiate(dentry, inode);
 		dget(dentry); /* Extra count - pin the dentry in core */
@@ -3193,7 +3193,8 @@ static int shmem_link(struct dentry *old_dentry, struct inode *dir, struct dentr
 	}
 
 	dir->i_size += BOGO_DIRENT_SIZE;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	dir->i_mtime = inode_set_ctime_to_ts(dir,
+					     inode_set_ctime_current(inode));
 	inode_inc_iversion(dir);
 	inc_nlink(inode);
 	ihold(inode);	/* New dentry reference */
@@ -3213,7 +3214,8 @@ static int shmem_unlink(struct inode *dir, struct dentry *dentry)
 	simple_offset_remove(shmem_get_offset_ctx(dir), dentry);
 
 	dir->i_size -= BOGO_DIRENT_SIZE;
-	inode->i_ctime = dir->i_ctime = dir->i_mtime = current_time(inode);
+	dir->i_mtime = inode_set_ctime_to_ts(dir,
+					     inode_set_ctime_current(inode));
 	inode_inc_iversion(dir);
 	drop_nlink(inode);
 	dput(dentry);	/* Undo the count from "create" - this does all the work */
@@ -3360,7 +3362,7 @@ static int shmem_symlink(struct mnt_idmap *idmap, struct inode *dir,
 		folio_put(folio);
 	}
 	dir->i_size += BOGO_DIRENT_SIZE;
-	dir->i_ctime = dir->i_mtime = current_time(dir);
+	dir->i_mtime = inode_set_ctime_current(dir);
 	inode_inc_iversion(dir);
 	d_instantiate(dentry, inode);
 	dget(dentry);
@@ -3438,7 +3440,7 @@ static int shmem_fileattr_set(struct mnt_idmap *idmap,
 		(fa->flags & SHMEM_FL_USER_MODIFIABLE);
 
 	shmem_set_inode_flags(inode, info->fsflags);
-	inode->i_ctime = current_time(inode);
+	inode_set_ctime_current(inode);
 	inode_inc_iversion(inode);
 	return 0;
 }
@@ -3508,7 +3510,7 @@ static int shmem_xattr_handler_set(const struct xattr_handler *handler,
 	name = xattr_full_name(handler, name);
 	err = simple_xattr_set(&info->xattrs, name, value, size, flags, NULL);
 	if (!err) {
-		inode->i_ctime = current_time(inode);
+		inode_set_ctime_current(inode);
 		inode_inc_iversion(inode);
 	}
 	return err;
-- 
2.41.0


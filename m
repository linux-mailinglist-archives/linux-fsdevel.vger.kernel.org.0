Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9D9748D40
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233859AbjGETIr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbjGETGp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:06:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B31892D53;
        Wed,  5 Jul 2023 12:04:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66F95616EF;
        Wed,  5 Jul 2023 19:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38065C433C8;
        Wed,  5 Jul 2023 19:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583874;
        bh=X2pGXZ9WnTAlxpicvepJDU/c0P2YuAYLSHDxSOea4yA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sswrxT7QljvYJl/DMZUrW9aVJ2kRxPvvzSjtPkGuZvJRgurmDzsX/Cd0Z92sni7Le
         JvISGCnw8RRu1eCTKEmaNYUPRvHn/cku7bsK9YM/LZwLa0zcpFeV8dkAQTtVdiP1Ez
         QTKO0gDdtrojBT7tIQNoxQS/nN+bzyxZ9GG8gJ9/DyDSGVmqwYR8pES4LX/C8QOT0Q
         sq3KmstcweJXHbBtByO6Hgw/fb4miHcT1Gc6IOsMrHP+dkzQ3JxFyT94B8zfBkkVh8
         QIK0nPepFH7MdmoLqOjsVoOuwhgFNb/Fkbdvyrx6MWEvDVkPhwt2UANfR5GcWJmYn3
         4AtOKzET38xIA==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 51/92] hpfs: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:01:16 -0400
Message-ID: <20230705190309.579783-49-jlayton@kernel.org>
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
 fs/hpfs/dir.c   |  8 ++++----
 fs/hpfs/inode.c |  6 +++---
 fs/hpfs/namei.c | 26 +++++++++++++++-----------
 fs/hpfs/super.c |  5 +++--
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/fs/hpfs/dir.c b/fs/hpfs/dir.c
index f32f15669996..f36566d61215 100644
--- a/fs/hpfs/dir.c
+++ b/fs/hpfs/dir.c
@@ -277,10 +277,10 @@ struct dentry *hpfs_lookup(struct inode *dir, struct dentry *dentry, unsigned in
 	 * inode.
 	 */
 
-	if (!result->i_ctime.tv_sec) {
-		if (!(result->i_ctime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->creation_date))))
-			result->i_ctime.tv_sec = 1;
-		result->i_ctime.tv_nsec = 0;
+	if (!inode_get_ctime(result).tv_sec) {
+		time64_t csec = local_to_gmt(dir->i_sb, le32_to_cpu(de->creation_date));
+
+		inode_set_ctime(result, csec ? csec : 1, 0);
 		result->i_mtime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->write_date));
 		result->i_mtime.tv_nsec = 0;
 		result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(de->read_date));
diff --git a/fs/hpfs/inode.c b/fs/hpfs/inode.c
index e50e92a42432..479166378bae 100644
--- a/fs/hpfs/inode.c
+++ b/fs/hpfs/inode.c
@@ -36,7 +36,7 @@ void hpfs_init_inode(struct inode *i)
 	hpfs_inode->i_rddir_off = NULL;
 	hpfs_inode->i_dirty = 0;
 
-	i->i_ctime.tv_sec = i->i_ctime.tv_nsec = 0;
+	inode_set_ctime(i, 0, 0);
 	i->i_mtime.tv_sec = i->i_mtime.tv_nsec = 0;
 	i->i_atime.tv_sec = i->i_atime.tv_nsec = 0;
 }
@@ -232,7 +232,7 @@ void hpfs_write_inode_nolock(struct inode *i)
 	if (de) {
 		de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
 		de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
-		de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_ctime.tv_sec));
+		de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_ctime(i).tv_sec));
 		de->read_only = !(i->i_mode & 0222);
 		de->ea_size = cpu_to_le32(hpfs_inode->i_ea_size);
 		hpfs_mark_4buffers_dirty(&qbh);
@@ -242,7 +242,7 @@ void hpfs_write_inode_nolock(struct inode *i)
 		if ((de = map_dirent(i, hpfs_inode->i_dno, "\001\001", 2, NULL, &qbh))) {
 			de->write_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_mtime.tv_sec));
 			de->read_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_atime.tv_sec));
-			de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, i->i_ctime.tv_sec));
+			de->creation_date = cpu_to_le32(gmt_to_local(i->i_sb, inode_get_ctime(i).tv_sec));
 			de->read_only = !(i->i_mode & 0222);
 			de->ea_size = cpu_to_le32(/*hpfs_inode->i_ea_size*/0);
 			de->file_size = cpu_to_le32(0);
diff --git a/fs/hpfs/namei.c b/fs/hpfs/namei.c
index 69fb40b2c99a..36babb78b510 100644
--- a/fs/hpfs/namei.c
+++ b/fs/hpfs/namei.c
@@ -13,10 +13,10 @@ static void hpfs_update_directory_times(struct inode *dir)
 {
 	time64_t t = local_to_gmt(dir->i_sb, local_get_seconds(dir->i_sb));
 	if (t == dir->i_mtime.tv_sec &&
-	    t == dir->i_ctime.tv_sec)
+	    t == inode_get_ctime(dir).tv_sec)
 		return;
-	dir->i_mtime.tv_sec = dir->i_ctime.tv_sec = t;
-	dir->i_mtime.tv_nsec = dir->i_ctime.tv_nsec = 0;
+	dir->i_mtime.tv_sec = inode_set_ctime(dir, t, 0).tv_sec;
+	dir->i_mtime.tv_nsec = 0;
 	hpfs_write_inode_nolock(dir);
 }
 
@@ -59,8 +59,9 @@ static int hpfs_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	result->i_ino = fno;
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
 	hpfs_i(result)->i_dno = dno;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
-	result->i_ctime.tv_nsec = 0; 
+	inode_set_ctime(result,
+			result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)),
+			0);
 	result->i_mtime.tv_nsec = 0; 
 	result->i_atime.tv_nsec = 0; 
 	hpfs_i(result)->i_ea_size = 0;
@@ -167,8 +168,9 @@ static int hpfs_create(struct mnt_idmap *idmap, struct inode *dir,
 	result->i_fop = &hpfs_file_ops;
 	set_nlink(result, 1);
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
-	result->i_ctime.tv_nsec = 0;
+	inode_set_ctime(result,
+			result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)),
+			0);
 	result->i_mtime.tv_nsec = 0;
 	result->i_atime.tv_nsec = 0;
 	hpfs_i(result)->i_ea_size = 0;
@@ -250,8 +252,9 @@ static int hpfs_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	hpfs_init_inode(result);
 	result->i_ino = fno;
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
-	result->i_ctime.tv_nsec = 0;
+	inode_set_ctime(result,
+			result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)),
+			0);
 	result->i_mtime.tv_nsec = 0;
 	result->i_atime.tv_nsec = 0;
 	hpfs_i(result)->i_ea_size = 0;
@@ -326,8 +329,9 @@ static int hpfs_symlink(struct mnt_idmap *idmap, struct inode *dir,
 	result->i_ino = fno;
 	hpfs_init_inode(result);
 	hpfs_i(result)->i_parent_dir = dir->i_ino;
-	result->i_ctime.tv_sec = result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date));
-	result->i_ctime.tv_nsec = 0;
+	inode_set_ctime(result,
+			result->i_mtime.tv_sec = result->i_atime.tv_sec = local_to_gmt(dir->i_sb, le32_to_cpu(dee.creation_date)),
+			0);
 	result->i_mtime.tv_nsec = 0;
 	result->i_atime.tv_nsec = 0;
 	hpfs_i(result)->i_ea_size = 0;
diff --git a/fs/hpfs/super.c b/fs/hpfs/super.c
index 1cb89595b875..758a51564124 100644
--- a/fs/hpfs/super.c
+++ b/fs/hpfs/super.c
@@ -729,8 +729,9 @@ static int hpfs_fill_super(struct super_block *s, void *options, int silent)
 		root->i_atime.tv_nsec = 0;
 		root->i_mtime.tv_sec = local_to_gmt(s, le32_to_cpu(de->write_date));
 		root->i_mtime.tv_nsec = 0;
-		root->i_ctime.tv_sec = local_to_gmt(s, le32_to_cpu(de->creation_date));
-		root->i_ctime.tv_nsec = 0;
+		inode_set_ctime(root,
+				local_to_gmt(s, le32_to_cpu(de->creation_date)),
+				0);
 		hpfs_i(root)->i_ea_size = le32_to_cpu(de->ea_size);
 		hpfs_i(root)->i_parent_dir = root->i_ino;
 		if (root->i_size == -1)
-- 
2.41.0


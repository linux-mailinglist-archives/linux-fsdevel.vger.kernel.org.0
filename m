Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99D5D7AD87B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:00:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbjIYNAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231530AbjIYNAs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:00:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36A3D10A
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:00:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1078CC433CB;
        Mon, 25 Sep 2023 13:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695646839;
        bh=v4g7jvCenLxaO3C6aa4EjCZ8NiVLlWBQcGRycZ/8Y5Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=M0GeRUt5q5eVwB8Nm5qgSv9GIIHLrQ5HFrO784W3yeVqRoAzHkdLaiDKes88k2itt
         6RfSFjrZULJXTcKeqgz5mir+pvc/quowFFr1BNzCbO5NEq2t5JMFQvfqJhvn0z/kBm
         8J/j0Mvuvlcj7/iD4QHRJ0rJIHdnDcm6Co35/aiiQ5/GvxH6kuNgx1BrBGRUH3LFot
         dAybbhUhcYX3gLJHlXTecGJ8QOycTFL/th5IO8TT98MrntNeOxeb0+bl4HC3vVZ9Of
         sJX5bHkm4+OeSEam/kLUjvVEL1FG9tc9keAg6kLtvo3Tw9qX5VZbCFbF8hRvt4Lq5N
         S+z046hJ5v4KA==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     hughd@google.com, brauner@kernel.org, jack@suse.cz
Subject: [PATCH 1/3] tmpfs: add project ID support
Date:   Mon, 25 Sep 2023 15:00:26 +0200
Message-Id: <20230925130028.1244740-2-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925130028.1244740-1-cem@kernel.org>
References: <20230925130028.1244740-1-cem@kernel.org>
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

From: Carlos Maiolino <cem@kernel.org>

Lay down infrastructure to support project quotas.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 include/linux/shmem_fs.h | 11 ++++++++---
 mm/shmem.c               |  6 ++++++
 mm/shmem_quota.c         | 10 ++++++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 6b0c626620f5..e82a64f97917 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -15,7 +15,10 @@
 
 #ifdef CONFIG_TMPFS_QUOTA
 #define SHMEM_MAXQUOTAS 2
-#endif
+
+/* Default project ID */
+#define SHMEM_DEF_PROJID 0
+#endif /* CONFIG_TMPFS_QUOTA */
 
 struct shmem_inode_info {
 	spinlock_t		lock;
@@ -33,14 +36,16 @@ struct shmem_inode_info {
 	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
 #ifdef CONFIG_TMPFS_QUOTA
 	struct dquot		*i_dquot[MAXQUOTAS];
+	kprojid_t		i_projid;
 #endif
 	struct offset_ctx	dir_offsets;	/* stable entry offsets */
 	struct inode		vfs_inode;
 };
 
-#define SHMEM_FL_USER_VISIBLE		FS_FL_USER_VISIBLE
+#define SHMEM_FL_USER_VISIBLE		(FS_FL_USER_VISIBLE | FS_PROJINHERIT_FL)
 #define SHMEM_FL_USER_MODIFIABLE \
-	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL)
+	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | \
+	 FS_NOATIME_FL | FS_PROJINHERIT_FL)
 #define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL)
 
 struct shmem_quota_limits {
diff --git a/mm/shmem.c b/mm/shmem.c
index 67d93dd37a5e..6ccf60bd1690 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2539,6 +2539,12 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap,
 	if (IS_ERR(inode))
 		return inode;
 
+	if (dir && sb_has_quota_active(sb, PRJQUOTA))
+		SHMEM_I(inode)->i_projid = SHMEM_I(dir)->i_projid;
+	else
+		SHMEM_I(inode)->i_projid = make_kprojid(&init_user_ns,
+							SHMEM_DEF_PROJID);
+
 	err = dquot_initialize(inode);
 	if (err)
 		goto errout;
diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index 062d1c1097ae..71224caa3e85 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -325,6 +325,15 @@ static int shmem_dquot_write_info(struct super_block *sb, int type)
 	return 0;
 }
 
+static int shmem_get_projid(struct inode *inode, kprojid_t *projid)
+{
+	if (!sb_has_quota_active(inode->i_sb, PRJQUOTA))
+		return -EOPNOTSUPP;
+
+	*projid = SHMEM_I(inode)->i_projid;
+	return 0;
+}
+
 static const struct quota_format_ops shmem_format_ops = {
 	.check_quota_file	= shmem_check_quota_file,
 	.read_file_info		= shmem_read_file_info,
@@ -346,5 +355,6 @@ const struct dquot_operations shmem_quota_operations = {
 	.write_info		= shmem_dquot_write_info,
 	.mark_dirty		= shmem_mark_dquot_dirty,
 	.get_next_id		= shmem_get_next_id,
+	.get_projid		= shmem_get_projid,
 };
 #endif /* CONFIG_TMPFS_QUOTA */
-- 
2.39.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2AED57ADD6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Jul 2022 04:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238389AbiGTC1o (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Jul 2022 22:27:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238289AbiGTC11 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Jul 2022 22:27:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E0967B1E6;
        Tue, 19 Jul 2022 19:22:59 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s21so16398943pjq.4;
        Tue, 19 Jul 2022 19:22:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cO1rkdmuR7oU7bdfMTLhtMVH5g0UFDfLxXUgSSq290Q=;
        b=Pg+23lszg/SMLvpTmuUuWn7zjrLDDUntSNiqSnY9WYIdZX/j15HznIbwfe6QbVfLfp
         f6rctMgHQYPkaceqThkzrLIK0LgkpI/jV3EQenObsbg6f12v9mHQQetSWZGFeDCCy5Kz
         VDC13JEj7ZqqP2hpBqBXPqj4vVLVc9WhaneWRXlCaqm5mCvMupRHQwBDhfWPir3ZIY9+
         5cd7gNbxEZYvDd1JnQ51MS0kN0JJmvbASMGr79k6oXMya+crLOP3qS11M/l64IoFPdZS
         7DM5ZVQvCAU5TowlrZ4RR3ajmC2pvb9t57I2+cWD7sshfFy6IFh6CkQmQq1Rfsz7IRey
         cQmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cO1rkdmuR7oU7bdfMTLhtMVH5g0UFDfLxXUgSSq290Q=;
        b=GmCsZ+Dy5wLCcKIm5UjibTO9vBj4Tc+3Nj7rTH6/ipiTd3Ix+UwEH5F7nbwddofbNp
         XbJkhpa3CRSqdyd93Amen4Q0DiFQ9U10StLYL5RT4wLE1xEmxZ3L+wuR/AfCXti9JILU
         OfLcofdDue8hPlzoQkmyK/il1oYCPa+Fpzw+83KEENgu+Qg1kBZV4NwHRN1SefNr87JL
         3AqLVPxp/+ukyoaQU6Dv1/ciOnsSJAMBTYJqy81j4A5tWmafGrkTgODePIAliM4EebgO
         eqmPYtbl2xoEUkDyqozFOfBo2GHUYX7GNfVgmEeaLTNch89M2YNPO1di15gtWH5vt/U6
         2wLg==
X-Gm-Message-State: AJIora/cplC38CQee4QE+kw6a09vvXp92Kfwa5so+d6umlkxonjznv+6
        hxraYnBRzUHRr7nVyVJbl4g=
X-Google-Smtp-Source: AGRyM1tHNsb+oWEVREcDzaw1lIXwkfEzP1rakZkQKX9TOABe/2TEHuqjDnSIhJIm2G8raA5nLI9n4A==
X-Received: by 2002:a17:902:e551:b0:16c:5a22:4823 with SMTP id n17-20020a170902e55100b0016c5a224823mr35231811plf.38.1658283776923;
        Tue, 19 Jul 2022 19:22:56 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id f129-20020a625187000000b00525b61fc3f8sm12361724pfb.40.2022.07.19.19.22.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 19:22:56 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: yang.yang29@zte.com.cn
To:     viro@zeniv.linux.org.uk, hughd@google.com,
        akpm@linux-foundation.org, hch@infradead.org,
        hsiangkao@linux.alibaba.com
Cc:     yang.yang29@zte.com.cn, axboe@kernel.dk, yangerkun@huawei.com,
        johannes.thumshirn@wdc.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        CGEL ZTE <cgel.zte@gmail.com>
Subject: [PATCH] fs: drop_caches: skip dropping pagecache which is always dirty
Date:   Wed, 20 Jul 2022 02:21:19 +0000
Message-Id: <20220720022118.1495752-1-yang.yang29@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Yang Yang <yang.yang29@zte.com.cn>

Pagecache of some kind of fs has PG_dirty bit set once it was
allocated, so it can't be dropped. These fs include ramfs and
tmpfs. This can make drop_pagecache_sb() more efficient.

Introduce a new fs flag to do this, and this new flag may be
used in other case in future.

Signed-off-by: Ran Xiaokai <ran.xiaokai@zte.com.cn>
Signed-off-by: Yang Yang <yang.yang29@zte.com.cn>
Signed-off-by: CGEL ZTE <cgel.zte@gmail.com>
---
 fs/drop_caches.c   | 7 +++++++
 fs/ramfs/inode.c   | 2 +-
 include/linux/fs.h | 1 +
 mm/shmem.c         | 2 +-
 4 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/fs/drop_caches.c b/fs/drop_caches.c
index e619c31b6bd9..16956d5d3922 100644
--- a/fs/drop_caches.c
+++ b/fs/drop_caches.c
@@ -19,6 +19,13 @@ static void drop_pagecache_sb(struct super_block *sb, void *unused)
 {
 	struct inode *inode, *toput_inode = NULL;
 
+	/*
+	 * Pagecache of this kind of fs has PG_dirty bit set once it was
+	 * allocated, so it can't be dropped.
+	 */
+	if (sb->s_type->fs_flags & FS_ALWAYS_DIRTY)
+		return;
+
 	spin_lock(&sb->s_inode_list_lock);
 	list_for_each_entry(inode, &sb->s_inodes, i_sb_list) {
 		spin_lock(&inode->i_lock);
diff --git a/fs/ramfs/inode.c b/fs/ramfs/inode.c
index bc66d0173e33..5fb62d37618f 100644
--- a/fs/ramfs/inode.c
+++ b/fs/ramfs/inode.c
@@ -289,7 +289,7 @@ static struct file_system_type ramfs_fs_type = {
 	.init_fs_context = ramfs_init_fs_context,
 	.parameters	= ramfs_fs_parameters,
 	.kill_sb	= ramfs_kill_sb,
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALWAYS_DIRTY,
 };
 
 static int __init init_ramfs_fs(void)
diff --git a/include/linux/fs.h b/include/linux/fs.h
index e285bd9d6188..90cdd10d683e 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2532,6 +2532,7 @@ struct file_system_type {
 #define FS_USERNS_MOUNT		8	/* Can be mounted by userns root */
 #define FS_DISALLOW_NOTIFY_PERM	16	/* Disable fanotify permission events */
 #define FS_ALLOW_IDMAP         32      /* FS has been updated to handle vfs idmappings. */
+#define FS_ALWAYS_DIRTY		64	/* Pagecache is always dirty. */
 #define FS_RENAME_DOES_D_MOVE	32768	/* FS will handle d_move() during rename() internally. */
 	int (*init_fs_context)(struct fs_context *);
 	const struct fs_parameter_spec *parameters;
diff --git a/mm/shmem.c b/mm/shmem.c
index 8baf26eda989..5d549f61735f 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3974,7 +3974,7 @@ static struct file_system_type shmem_fs_type = {
 	.parameters	= shmem_fs_parameters,
 #endif
 	.kill_sb	= kill_litter_super,
-	.fs_flags	= FS_USERNS_MOUNT,
+	.fs_flags	= FS_USERNS_MOUNT | FS_ALWAYS_DIRTY,
 };
 
 void __init shmem_init(void)
-- 
2.25.1


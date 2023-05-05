Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3A166F88B3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 May 2023 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjEESjW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 May 2023 14:39:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjEESjV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 May 2023 14:39:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 327DC14E55
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 11:39:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBE64612A1
        for <linux-fsdevel@vger.kernel.org>; Fri,  5 May 2023 18:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A46C433D2;
        Fri,  5 May 2023 18:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683311959;
        bh=jG5QsAgQy5Mjew+JAoL0OfLKEJrcHnLf8qAY4PJvrrE=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=p9GDQu+vZszpETOyvfR4rHyQa1kwd6uFM8dbwfuK7e/KOge9Me3RcbD0r5s9CEEgI
         2V9AOmfXwJhcVU871H3wbRE8s76IAWFArmonrcfdKCFPM3FMrwnMHpMmMdwhzvDTaD
         VYuLBvTmIboasavp31nosHMD+Qnp8PS4gYDZdQlYc49geuoQFU8/0U8atgvy2Eh1+h
         oTJqsknyjv2wBvh/cxXhCeSsQ1WNnPPwIhEaaOtJLwWC978+uUGZoJY+chewonkuxM
         PRlBAnw+oyd9X7rp+Tu/Qkp5qLc0WlIuet91L2T9KJZsoP/wrhM1LLoD0EekA4RNDy
         4/e+QwLTLgNPw==
Subject: [PATCH v2 3/5] shmem: Add a per-directory xarray
From:   Chuck Lever <cel@kernel.org>
To:     hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Date:   Fri, 05 May 2023 14:39:07 -0400
Message-ID: <168331193783.20728.5584061722473821745.stgit@oracle-102.nfsv4bat.org>
In-Reply-To: <168331111400.20728.2327812215536431362.stgit@oracle-102.nfsv4bat.org>
References: <168331111400.20728.2327812215536431362.stgit@oracle-102.nfsv4bat.org>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chuck Lever <chuck.lever@oracle.com>

Add the infrastructure for managing a per-directory
directory-offset-to-dentry map. For the moment it is unused.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 include/linux/shmem_fs.h |    2 ++
 mm/shmem.c               |   28 ++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 9029abd29b1c..c1a12eac778d 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -27,6 +27,8 @@ struct shmem_inode_info {
 	atomic_t		stop_eviction;	/* hold when working on inode */
 	struct timespec64	i_crtime;	/* file creation time */
 	unsigned int		fsflags;	/* flags for FS_IOC_[SG]ETFLAGS */
+	struct xarray		doff_map;	/* dir offset to entry mapping */
+	u32			next_doff;
 	struct inode		vfs_inode;
 };
 
diff --git a/mm/shmem.c b/mm/shmem.c
index e48a0947bcaf..b78253996108 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -40,6 +40,8 @@
 #include <linux/fs_parser.h>
 #include <linux/swapfile.h>
 #include <linux/iversion.h>
+#include <linux/xarray.h>
+
 #include "swap.h"
 
 static struct vfsmount *shm_mnt;
@@ -2412,6 +2414,8 @@ static struct inode *shmem_get_inode(struct mnt_idmap *idmap, struct super_block
 			inode->i_size = 2 * BOGO_DIRENT_SIZE;
 			inode->i_op = &shmem_dir_inode_operations;
 			inode->i_fop = &shmem_dir_operations;
+			xa_init_flags(&info->doff_map, XA_FLAGS_ALLOC1);
+			info->next_doff = 0;
 			break;
 		case S_IFLNK:
 			/*
@@ -2930,6 +2934,22 @@ static int shmem_statfs(struct dentry *dentry, struct kstatfs *buf)
 	return 0;
 }
 
+static struct xarray *shmem_doff_map(struct inode *dir)
+{
+	return &SHMEM_I(dir)->doff_map;
+}
+
+/*
+ * During fs teardown (eg. umount), a directory's doff_map might still
+ * contain entries. xa_destroy() cleans out anything that remains.
+ */
+static void shmem_doff_map_destroy(struct inode *inode)
+{
+	struct xarray *xa = shmem_doff_map(inode);
+
+	xa_destroy(xa);
+}
+
 /*
  * File creation. Allocate an inode, and we're done..
  */
@@ -3905,6 +3925,12 @@ static int shmem_show_options(struct seq_file *seq, struct dentry *root)
 	return 0;
 }
 
+#else /* CONFIG_TMPFS */
+
+static inline void shmem_doff_map_destroy(struct inode *dir)
+{
+}
+
 #endif /* CONFIG_TMPFS */
 
 static void shmem_put_super(struct super_block *sb)
@@ -4052,6 +4078,8 @@ static void shmem_destroy_inode(struct inode *inode)
 {
 	if (S_ISREG(inode->i_mode))
 		mpol_free_shared_policy(&SHMEM_I(inode)->policy);
+	if (S_ISDIR(inode->i_mode))
+		shmem_doff_map_destroy(inode);
 }
 
 static void shmem_init_inode(void *foo)



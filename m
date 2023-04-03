Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7A6D3F67
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Apr 2023 10:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231893AbjDCIso (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Apr 2023 04:48:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231882AbjDCIs3 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Apr 2023 04:48:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B9D6EAF
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 01:48:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2F494B815CB
        for <linux-fsdevel@vger.kernel.org>; Mon,  3 Apr 2023 08:48:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4FFC433A1;
        Mon,  3 Apr 2023 08:48:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680511704;
        bh=LdVL5qK221tpZqXs/tk4ISbpY6XmJKeHGjUE00rYUPY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=t2f+kQnXIc22dSP4i0ua9+2Dd4BSoYmUUWwBeL4wV9ob9hd0ByntT4GittPehhTKe
         O1vgdYX6jevHnHlWHtHX1mSqQFqlFZDR8r8DbCjJkuqiTf1E7ujuiUbutZffi1v4B0
         xAJVwhnWRrsx46PyQrVoh2oUwMDdtd3p3P/6tOs43S6R0cC34mzJqemRzIF8+owQly
         ensE+2NN+zVfg2Pq5eKolZwiMKiWAydmbfV10VkfurrkwnDIqlG3HVGNkeS862oBHO
         zQl6mkH+9EKqYL/LHxYWgR5wx1+U7KbIaLD627zNNOq19jSnez9kg24lL1boN+vqZR
         5vHPb/hIOVBrQ==
From:   cem@kernel.org
To:     hughd@google.com
Cc:     jack@suse.cz, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH 6/6] Add default quota limit mount options
Date:   Mon,  3 Apr 2023 10:47:59 +0200
Message-Id: <20230403084759.884681-7-cem@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230403084759.884681-1-cem@kernel.org>
References: <20230403084759.884681-1-cem@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Lukas Czerner <lczerner@redhat.com>

Allow system administrator to set default global quota limits at tmpfs
mount time.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 Documentation/filesystems/tmpfs.rst | 34 ++++++++++----
 include/linux/shmem_fs.h            |  8 ++++
 mm/shmem.c                          | 69 +++++++++++++++++++++++++++++
 mm/shmem_quota.c                    |  9 ++++
 4 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 3f8d89bb7e1a5..ec442a3ef90a0 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -88,15 +88,31 @@ that instance in a system with many CPUs making intensive use of it.
 
 tmpfs also supports quota with the following mount options
 
-========  =============================================================
-quota     User and group quota accounting and enforcement is enabled on
-          the mount. Tmpfs is using hidden system quota files that are
-          initialized on mount.
-usrquota  User quota accounting and enforcement is enabled on the
-          mount.
-grpquota  Group quota accounting and enforcement is enabled on the
-          mount.
-========  =============================================================
+======================== =================================================
+quota                    User and group quota accounting and enforcement
+                         is enabled on the mount. Tmpfs is using hidden
+                         system quota files that are initialized on mount.
+usrquota                 User quota accounting and enforcement is enabled
+                         on the mount.
+grpquota                 Group quota accounting and enforcement is enabled
+                         on the mount.
+usrquota_block_hardlimit Set global user quota block hard limit.
+usrquota_inode_hardlimit Set global user quota inode hard limit.
+grpquota_block_hardlimit Set global group quota block hard limit.
+grpquota_inode_hardlimit Set global group quota inode hard limit.
+======================== =================================================
+
+None of the quota related mount options can be set or changed on remount.
+
+Quota limit parameters accept a suffix k, m or g for kilo, mega and giga
+and can't be changed on remount. Default global quota limits are taking
+effect for any and all user/group/project except root the first time the
+quota entry for user/group/project id is being accessed - typically the
+first time an inode with a particular id ownership is being created after
+the mount. In other words, instead of the limits being initialized to zero,
+they are initialized with the particular value provided with these mount
+options. The limits can be changed for any user/group id at any time as it
+normally can.
 
 tmpfs has a mount option to set the NUMA memory allocation policy for
 all files in that instance (if CONFIG_NUMA is enabled) - which can be
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 3e7e18726feb5..5527bd27a429d 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -37,6 +37,13 @@ struct shmem_inode_info {
 	(FS_IMMUTABLE_FL | FS_APPEND_FL | FS_NODUMP_FL | FS_NOATIME_FL)
 #define SHMEM_FL_INHERITED		(FS_NODUMP_FL | FS_NOATIME_FL)
 
+struct shmem_quota_limits {
+	qsize_t usrquota_bhardlimit; /* Default user quota block hard limit */
+	qsize_t usrquota_ihardlimit; /* Default user quota inode hard limit */
+	qsize_t grpquota_bhardlimit; /* Default group quota block hard limit */
+	qsize_t grpquota_ihardlimit; /* Default group quota inode hard limit */
+};
+
 struct shmem_sb_info {
 	unsigned long max_blocks;   /* How many blocks are allowed */
 	struct percpu_counter used_blocks;  /* How many are allocated */
@@ -54,6 +61,7 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+	struct shmem_quota_limits qlimits; /* Default quota limits */
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/mm/shmem.c b/mm/shmem.c
index d7529c883eaf5..80270213fd012 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -118,6 +118,7 @@ struct shmem_options {
 	int huge;
 	int seen;
 	unsigned short quota_types;
+	struct shmem_quota_limits qlimits;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
@@ -3570,6 +3571,10 @@ enum shmem_param {
 	Opt_quota,
 	Opt_usrquota,
 	Opt_grpquota,
+	Opt_usrquota_block_hardlimit,
+	Opt_usrquota_inode_hardlimit,
+	Opt_grpquota_block_hardlimit,
+	Opt_grpquota_inode_hardlimit,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3595,6 +3600,10 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_flag  ("quota",		Opt_quota),
 	fsparam_flag  ("usrquota",	Opt_usrquota),
 	fsparam_flag  ("grpquota",	Opt_grpquota),
+	fsparam_string("usrquota_block_hardlimit", Opt_usrquota_block_hardlimit),
+	fsparam_string("usrquota_inode_hardlimit", Opt_usrquota_inode_hardlimit),
+	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit),
+	fsparam_string("grpquota_inode_hardlimit", Opt_grpquota_inode_hardlimit),
 #endif
 	{}
 };
@@ -3691,6 +3700,50 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->seen |= SHMEM_SEEN_QUOTA;
 		ctx->quota_types |= QTYPE_MASK_GRP;
 		break;
+	case Opt_usrquota_block_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		if (size > SHMEM_QUOTA_MAX_SPC_LIMIT)
+			return invalfc(fc,
+				       "User quota block hardlimit too large.");
+		ctx->qlimits.usrquota_bhardlimit = size;
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		ctx->quota_types |= QTYPE_MASK_USR;
+		break;
+	case Opt_grpquota_block_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		if (size > SHMEM_QUOTA_MAX_SPC_LIMIT)
+			return invalfc(fc,
+				       "Group quota block hardlimit too large.");
+		ctx->qlimits.grpquota_bhardlimit = size;
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		ctx->quota_types |= QTYPE_MASK_GRP;
+		break;
+	case Opt_usrquota_inode_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		if (size > SHMEM_QUOTA_MAX_INO_LIMIT)
+			return invalfc(fc,
+				       "User quota inode hardlimit too large.");
+		ctx->qlimits.usrquota_ihardlimit = size;
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		ctx->quota_types |= QTYPE_MASK_USR;
+		break;
+	case Opt_grpquota_inode_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		if (size > SHMEM_QUOTA_MAX_INO_LIMIT)
+			return invalfc(fc,
+				       "Group quota inode hardlimit too large.");
+		ctx->qlimits.grpquota_ihardlimit = size;
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		ctx->quota_types |= QTYPE_MASK_GRP;
+		break;
 	}
 	return 0;
 
@@ -3796,6 +3849,18 @@ static int shmem_reconfigure(struct fs_context *fc)
 		goto out;
 	}
 
+#ifdef CONFIG_TMPFS_QUOTA
+#define CHANGED_LIMIT(name)						\
+	(ctx->qlimits.name## hardlimit &&				\
+	(ctx->qlimits.name## hardlimit != sbinfo->qlimits.name## hardlimit))
+
+	if (CHANGED_LIMIT(usrquota_b) || CHANGED_LIMIT(usrquota_i) ||
+	    CHANGED_LIMIT(grpquota_b) || CHANGED_LIMIT(grpquota_i)) {
+		err = "Cannot change global quota limit on remount";
+		goto out;
+	}
+#endif /* CONFIG_TMPFS_QUOTA */
+
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
 	if (ctx->seen & SHMEM_SEEN_INUMS)
@@ -3965,6 +4030,10 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 		sb->s_qcop = &dquot_quotactl_sysfile_ops;
 		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
 
+		/* Copy the default limits from ctx into sbinfo */
+		memcpy(&sbinfo->qlimits, &ctx->qlimits,
+		       sizeof(struct shmem_quota_limits));
+
 		if (shmem_enable_quotas(sb, ctx->quota_types))
 			goto failed;
 	}
diff --git a/mm/shmem_quota.c b/mm/shmem_quota.c
index c415043a71e67..77ba7c3494c70 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -168,6 +168,7 @@ static int shmem_acquire_dquot(struct dquot *dquot)
 {
 	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
 	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
+	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
 	struct rb_node *parent = NULL, *new_node = NULL;
 	struct quota_id *new_entry, *entry;
 	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
@@ -197,6 +198,14 @@ static int shmem_acquire_dquot(struct dquot *dquot)
 	}
 
 	new_entry->id = id;
+	if (dquot->dq_id.type == USRQUOTA) {
+		new_entry->bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
+		new_entry->ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
+	} else if (dquot->dq_id.type == GRPQUOTA) {
+		new_entry->bhardlimit = sbinfo->qlimits.grpquota_bhardlimit;
+		new_entry->ihardlimit = sbinfo->qlimits.grpquota_ihardlimit;
+	}
+
 	new_node = &new_entry->node;
 	rb_link_node(new_node, parent, n);
 	rb_insert_color(new_node, (struct rb_root *)info->dqi_priv);
-- 
2.30.2


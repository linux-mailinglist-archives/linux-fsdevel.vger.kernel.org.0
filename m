Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7139761C20
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jul 2023 16:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjGYOpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jul 2023 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230459AbjGYOpf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jul 2023 10:45:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0301412D
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 07:45:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 868FF61703
        for <linux-fsdevel@vger.kernel.org>; Tue, 25 Jul 2023 14:45:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDE7EC433CD;
        Tue, 25 Jul 2023 14:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690296333;
        bh=lISOjIRoZ8eyNsvIWJg3pEzAgdhmgsQyuciEDHNazkM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ICbNbwGK9vPDstPO+SP6gjRMfJPQmQ439ac+WmNnjrEofwPgn2a052ZfY/qgOVTJe
         wg6JS4Y8YJP3llQfB+CIthE7rEkkdZXUwdNC+IvP5BoiGTcnMZc3qEgwIjerzCkzgS
         OvXT44hXRcfvRnuo/JxCSgyha5SMALEDg9nuX1SrSgmSTbSrqWxcaFeiCkW/aAZvaI
         qj9imUV9s+f1KLnUWcV3ikA1Aas8emPYtwz+DwX47+xahOXLI3n6dv7X8lw7RmdPFq
         tKAL2tGGJsUQpGVxPqWPJF1bc2IAmFTsXztaAq+SOjlgoIfy883HaTlzclKu6eiTkD
         W4KsRrR4NCBzA==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     jack@suse.cz, akpm@linux-foundation.org, viro@zeniv.linux.org.uk,
        linux-mm@kvack.org, djwong@kernel.org, hughd@google.com,
        brauner@kernel.org, mcgrof@kernel.org
Subject: [PATCH 6/7] shmem: Add default quota limit mount options
Date:   Tue, 25 Jul 2023 16:45:09 +0200
Message-Id: <20230725144510.253763-7-cem@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230725144510.253763-1-cem@kernel.org>
References: <20230725144510.253763-1-cem@kernel.org>
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

From: Lukas Czerner <lczerner@redhat.com>

Allow system administrator to set default global quota limits at tmpfs
mount time.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 Documentation/filesystems/tmpfs.rst | 34 +++++++++++-----
 include/linux/shmem_fs.h            |  8 ++++
 mm/shmem.c                          | 61 +++++++++++++++++++++++++++++
 mm/shmem_quota.c                    | 34 +++++++++++++++-
 4 files changed, 127 insertions(+), 10 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 0c7d8bd052f1..f843dbbeb589 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -132,15 +132,31 @@ for emergency or testing purposes. The values you can set for shmem_enabled are:
 
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
+options. The limits can be changed for any user/group id at any time as they
+normally can be.
 
 Note that tmpfs quotas do not support user namespaces so no uid/gid
 translation is done if quotas are enabled inside user namespaces.
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 1a568a0f542f..c0058f3bba70 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -42,6 +42,13 @@ struct shmem_inode_info {
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
@@ -60,6 +67,7 @@ struct shmem_sb_info {
 	spinlock_t shrinklist_lock;   /* Protects shrinklist */
 	struct list_head shrinklist;  /* List of shinkable inodes */
 	unsigned long shrinklist_len; /* Length of shrinklist */
+	struct shmem_quota_limits qlimits; /* Default quota limits */
 };
 
 static inline struct shmem_inode_info *SHMEM_I(struct inode *inode)
diff --git a/mm/shmem.c b/mm/shmem.c
index 7c75f30309ff..bd02909bacd6 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -118,6 +118,7 @@ struct shmem_options {
 	int seen;
 	bool noswap;
 	unsigned short quota_types;
+	struct shmem_quota_limits qlimits;
 #define SHMEM_SEEN_BLOCKS 1
 #define SHMEM_SEEN_INODES 2
 #define SHMEM_SEEN_HUGE 4
@@ -3735,6 +3736,10 @@ enum shmem_param {
 	Opt_quota,
 	Opt_usrquota,
 	Opt_grpquota,
+	Opt_usrquota_block_hardlimit,
+	Opt_usrquota_inode_hardlimit,
+	Opt_grpquota_block_hardlimit,
+	Opt_grpquota_inode_hardlimit,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3761,6 +3766,10 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
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
@@ -3871,6 +3880,42 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
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
+		break;
+	case Opt_grpquota_block_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		if (size > SHMEM_QUOTA_MAX_SPC_LIMIT)
+			return invalfc(fc,
+				       "Group quota block hardlimit too large.");
+		ctx->qlimits.grpquota_bhardlimit = size;
+		break;
+	case Opt_usrquota_inode_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		if (size > SHMEM_QUOTA_MAX_INO_LIMIT)
+			return invalfc(fc,
+				       "User quota inode hardlimit too large.");
+		ctx->qlimits.usrquota_ihardlimit = size;
+		break;
+	case Opt_grpquota_inode_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		if (size > SHMEM_QUOTA_MAX_INO_LIMIT)
+			return invalfc(fc,
+				       "Group quota inode hardlimit too large.");
+		ctx->qlimits.grpquota_ihardlimit = size;
+		break;
 	}
 	return 0;
 
@@ -3984,6 +4029,18 @@ static int shmem_reconfigure(struct fs_context *fc)
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
@@ -4163,6 +4220,10 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
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
index e92b8ece9880..062d1c1097ae 100644
--- a/mm/shmem_quota.c
+++ b/mm/shmem_quota.c
@@ -166,6 +166,7 @@ static int shmem_acquire_dquot(struct dquot *dquot)
 {
 	struct mem_dqinfo *info = sb_dqinfo(dquot->dq_sb, dquot->dq_id.type);
 	struct rb_node **n = &((struct rb_root *)info->dqi_priv)->rb_node;
+	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
 	struct rb_node *parent = NULL, *new_node = NULL;
 	struct quota_id *new_entry, *entry;
 	qid_t id = from_kqid(&init_user_ns, dquot->dq_id);
@@ -195,6 +196,14 @@ static int shmem_acquire_dquot(struct dquot *dquot)
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
@@ -224,6 +233,29 @@ static int shmem_acquire_dquot(struct dquot *dquot)
 	return ret;
 }
 
+static bool shmem_is_empty_dquot(struct dquot *dquot)
+{
+	struct shmem_sb_info *sbinfo = dquot->dq_sb->s_fs_info;
+	qsize_t bhardlimit;
+	qsize_t ihardlimit;
+
+	if (dquot->dq_id.type == USRQUOTA) {
+		bhardlimit = sbinfo->qlimits.usrquota_bhardlimit;
+		ihardlimit = sbinfo->qlimits.usrquota_ihardlimit;
+	} else if (dquot->dq_id.type == GRPQUOTA) {
+		bhardlimit = sbinfo->qlimits.grpquota_bhardlimit;
+		ihardlimit = sbinfo->qlimits.grpquota_ihardlimit;
+	}
+
+	if (test_bit(DQ_FAKE_B, &dquot->dq_flags) ||
+		(dquot->dq_dqb.dqb_curspace == 0 &&
+		 dquot->dq_dqb.dqb_curinodes == 0 &&
+		 dquot->dq_dqb.dqb_bhardlimit == bhardlimit &&
+		 dquot->dq_dqb.dqb_ihardlimit == ihardlimit))
+		return true;
+
+	return false;
+}
 /*
  * Store limits from dquot in the tree unless it's fake. If it is fake
  * remove the id from the tree since there is no useful information in
@@ -261,7 +293,7 @@ static int shmem_release_dquot(struct dquot *dquot)
 	return -ENOENT;
 
 found:
-	if (test_bit(DQ_FAKE_B, &dquot->dq_flags)) {
+	if (shmem_is_empty_dquot(dquot)) {
 		/* Remove entry from the tree */
 		rb_erase(&entry->node, info->dqi_priv);
 		kfree(entry);
-- 
2.39.2


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D1C6325CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 15:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbiKUOad (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 09:30:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiKUOaZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 09:30:25 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D225C742
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 06:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1669040964;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pRGHhuDBx+/l9wP0R9J00DCzohqoXEyBoIXABqcZq/I=;
        b=RfXMuZv2LCVUAOHzBHu7RTWuwMHsNa5MIdCG493VEzWuIIQ2dcL8EzSN57fKYQyJFiIKg8
        oRF2YZqFDkwyjbpb7r6sx9Susr+tAnpoMF3WWNJPaxKV/1WlM1Y/vElSy/UH3wRDjxscRy
        0RhZ7dSJes+IeIA+nJzV9AAPTnXBpRU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-610-MoDfppYKM-u-ti7kvqVAow-1; Mon, 21 Nov 2022 09:29:21 -0500
X-MC-Unique: MoDfppYKM-u-ti7kvqVAow-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B20D2A5954E;
        Mon, 21 Nov 2022 14:29:20 +0000 (UTC)
Received: from ovpn-193-186.brq.redhat.com (ovpn-193-186.brq.redhat.com [10.40.193.186])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 805BF2166B26;
        Mon, 21 Nov 2022 14:29:19 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Jan Kara <jack@suse.com>, Eric Sandeen <sandeen@redhat.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        djwong@kernel.org
Subject: [PATCH v2 3/3] shmem: implement mount options for global quota limits
Date:   Mon, 21 Nov 2022 15:28:54 +0100
Message-Id: <20221121142854.91109-4-lczerner@redhat.com>
In-Reply-To: <20221121142854.91109-1-lczerner@redhat.com>
References: <20221121142854.91109-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Implement a set of mount options for setting glopbal quota limits on
tmpfs.

usrquota_block_hardlimit - global user quota block hard limit
usrquota_inode_hardlimit - global user quota inode hard limit
grpquota_block_hardlimit - global group quota block hard limit
grpquota_inode_hardlimit - global group quota inode hard limit

Quota limit parameters accept a suffix k, m or g for kilo, mega and giga
and can't be changed on remount. Default global quota limits are taking
effect for any and all user/group except root the first time the quota
entry for user/group id is being accessed - typically the first time an
inode with a particular id ownership is being created after the mount. In
other words, instead of the limits being initialized to zero, they are
initialized with the particular value provided with these mount options.
The limits can be changed for any user/group id at any time as it normally
can.

When any of the default quota limits are set, quota enforcement is enabled
automatically as well.

None of the quota related mount options can be set or changed on remount.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
v2: Rename mount option to something more sensible.
    Improve documentation.
    Check if the user provided limit isn't too large.

 Documentation/filesystems/tmpfs.rst |  36 +++++--
 include/linux/shmem_fs.h            |  10 ++
 mm/shmem.c                          | 162 ++++++++++++++++++++++++++--
 3 files changed, 190 insertions(+), 18 deletions(-)

diff --git a/Documentation/filesystems/tmpfs.rst b/Documentation/filesystems/tmpfs.rst
index 9c4f228ef4f3..7150aeb3e546 100644
--- a/Documentation/filesystems/tmpfs.rst
+++ b/Documentation/filesystems/tmpfs.rst
@@ -88,14 +88,34 @@ that instance in a system with many CPUs making intensive use of it.
 
 tmpfs also supports quota with the following mount options
 
-========  =============================================================
-quota     Quota accounting is enabled on the mount. Tmpfs is using
-          hidden system quota files that are initialized on mount.
-          Quota limits can quota enforcement can be enabled using
-          standard quota tools.
-usrquota  Same as quota option. Exists for compatibility reasons.
-grpquota  Same as quota option. Exists for compatibility reasons.
-========  =============================================================
+======================== =================================================
+quota                    Quota accounting is enabled on the mount. Tmpfs
+                         is using hidden system quota files that are
+                         initialized on mount. Quota limits can quota
+                         enforcement can be enabled using standard quota
+                         tools.
+usrquota                 Same as quota option. Exists for compatibility.
+grpquota                 Same as quota option. Exists for compatibility.
+usrquota_block_hardlimit Set global user quota block hard limit.
+usrquota_inode_hardlimit Set global user quota inode hard limit.
+usrquota_block_hardlimit Set global group quota block hard limit.
+usrquota_inode_hardlimit Set global group quota inode hard limit.
+======================== =================================================
+
+Quota limit parameters accept a suffix k, m or g for kilo, mega and giga
+and can't be changed on remount. Default global quota limits are taking
+effect for any and all user/group except root the first time the quota
+entry for user/group id is being accessed - typically the first time an
+inode with a particular id ownership is being created after the mount. In
+other words, instead of the limits being initialized to zero, they are
+initialized with the particular value provided with these mount options.
+The limits can be changed for any user/group id at any time as it normally
+can.
+
+When any of the default quota limits are set, quota enforcement is enabled
+automatically as well.
+
+None of the quota related mount options can be set or changed on remount.
 
 
 tmpfs has a mount option to set the NUMA memory allocation policy for
diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index 02a328c98d3a..174daeb5d554 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -10,6 +10,10 @@
 #include <linux/xattr.h>
 #include <linux/fs_parser.h>
 
+#if defined(CONFIG_TMPFS) && defined(CONFIG_QUOTA)
+#define SHMEM_QUOTA_TMPFS
+#endif
+
 /* inode in-kernel data */
 
 struct shmem_inode_info {
@@ -39,6 +43,12 @@ struct shmem_inode_info {
 
 struct shmem_sb_info {
 	unsigned long max_blocks;   /* How many blocks are allowed */
+#ifdef SHMEM_QUOTA_TMPFS
+	unsigned long usrquota_block_hardlimit; /* Default user quota block hard limit */
+	unsigned long usrquota_inode_hardlimit; /* Default user quota inode hard limit */
+	unsigned long grpquota_block_hardlimit; /* Default group quota block hard limit */
+	unsigned long grpquota_inode_hardlimit; /* Default group quota inode hard limit */
+#endif
 	struct percpu_counter used_blocks;  /* How many are allocated */
 	unsigned long max_inodes;   /* How many inodes are allowed */
 	unsigned long free_inodes;  /* How many are left for allocation */
diff --git a/mm/shmem.c b/mm/shmem.c
index 26f2effd8f7c..a66a1e4cd0cb 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -110,6 +110,12 @@ struct shmem_falloc {
 struct shmem_options {
 	unsigned long long blocks;
 	unsigned long long inodes;
+#ifdef SHMEM_QUOTA_TMPFS
+	unsigned long usrquota_block_hardlimit;
+	unsigned long usrquota_inode_hardlimit;
+	unsigned long grpquota_block_hardlimit;
+	unsigned long grpquota_inode_hardlimit;
+#endif
 	struct mempolicy *mpol;
 	kuid_t uid;
 	kgid_t gid;
@@ -142,10 +148,6 @@ static unsigned long shmem_default_max_inodes(void)
 }
 #endif
 
-#if defined(CONFIG_TMPFS) && defined(CONFIG_QUOTA)
-#define SHMEM_QUOTA_TMPFS
-#endif
-
 static int shmem_swapin_folio(struct inode *inode, pgoff_t index,
 			     struct folio **foliop, enum sgp_type sgp,
 			     gfp_t gfp, struct vm_area_struct *vma,
@@ -271,6 +273,57 @@ static DEFINE_MUTEX(shmem_swaplist_mutex);
 
 #define SHMEM_MAXQUOTAS 2
 
+int shmem_dquot_acquire(struct dquot *dquot)
+{
+	int type, ret = 0;
+	unsigned int memalloc;
+	struct quota_info *dqopt = sb_dqopt(dquot->dq_sb);
+	struct shmem_sb_info *sbinfo = SHMEM_SB(dquot->dq_sb);
+
+
+	mutex_lock(&dquot->dq_lock);
+	memalloc = memalloc_nofs_save();
+	if (test_bit(DQ_READ_B, &dquot->dq_flags)) {
+		smp_mb__before_atomic();
+		set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
+		goto out_iolock;
+	}
+
+	type = dquot->dq_id.type;
+	ret = dqopt->ops[type]->read_dqblk(dquot);
+	if (ret < 0)
+		goto out_iolock;
+	/* Set the defaults */
+	if (type == USRQUOTA) {
+		dquot->dq_dqb.dqb_bhardlimit =
+			(sbinfo->usrquota_block_hardlimit << PAGE_SHIFT);
+		dquot->dq_dqb.dqb_ihardlimit = sbinfo->usrquota_inode_hardlimit;
+	} else if (type == GRPQUOTA) {
+		dquot->dq_dqb.dqb_bhardlimit =
+			(sbinfo->grpquota_block_hardlimit << PAGE_SHIFT);
+		dquot->dq_dqb.dqb_ihardlimit = sbinfo->grpquota_inode_hardlimit;
+	}
+	/* Make sure flags update is visible after dquot has been filled */
+	smp_mb__before_atomic();
+	set_bit(DQ_READ_B, &dquot->dq_flags);
+	set_bit(DQ_ACTIVE_B, &dquot->dq_flags);
+out_iolock:
+	memalloc_nofs_restore(memalloc);
+	mutex_unlock(&dquot->dq_lock);
+	return ret;
+}
+
+const struct dquot_operations shmem_dquot_operations = {
+	.write_dquot	= dquot_commit,
+	.acquire_dquot	= shmem_dquot_acquire,
+	.release_dquot	= dquot_release,
+	.mark_dirty	= dquot_mark_dquot_dirty,
+	.write_info	= dquot_commit_info,
+	.alloc_dquot	= dquot_alloc,
+	.destroy_dquot	= dquot_destroy,
+	.get_next_id	= dquot_get_next_id,
+};
+
 /*
  * We don't have any quota files to read, or write to/from, but quota code
  * requires .quota_read and .quota_write to exist.
@@ -288,14 +341,14 @@ static ssize_t shmem_quota_read(struct super_block *sb, int type, char *data,
 }
 
 
-static int shmem_enable_quotas(struct super_block *sb)
+static int shmem_enable_quotas(struct super_block *sb, unsigned int dquot_flags)
 {
 	int type, err = 0;
 
 	sb_dqopt(sb)->flags |= DQUOT_QUOTA_SYS_FILE | DQUOT_NOLIST_DIRTY;
 	for (type = 0; type < SHMEM_MAXQUOTAS; type++) {
 		err = dquot_load_quota_sb(sb, type, QFMT_MEM_ONLY,
-					  DQUOT_USAGE_ENABLED);
+					  dquot_flags);
 		if (err)
 			goto out_err;
 	}
@@ -3559,6 +3612,10 @@ enum shmem_param {
 	Opt_inode32,
 	Opt_inode64,
 	Opt_quota,
+	Opt_usrquota_block_hardlimit,
+	Opt_usrquota_inode_hardlimit,
+	Opt_grpquota_block_hardlimit,
+	Opt_grpquota_inode_hardlimit,
 };
 
 static const struct constant_table shmem_param_enums_huge[] = {
@@ -3583,6 +3640,10 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_flag  ("quota",		Opt_quota),
 	fsparam_flag  ("usrquota",	Opt_quota),
 	fsparam_flag  ("grpquota",	Opt_quota),
+	fsparam_string("usrquota_block_hardlimit",	Opt_usrquota_block_hardlimit),
+	fsparam_string("usrquota_inode_hardlimit",	Opt_usrquota_inode_hardlimit),
+	fsparam_string("grpquota_block_hardlimit",	Opt_grpquota_block_hardlimit),
+	fsparam_string("grpquota_inode_hardlimit",	Opt_grpquota_inode_hardlimit),
 	{}
 };
 
@@ -3666,13 +3727,60 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->full_inums = true;
 		ctx->seen |= SHMEM_SEEN_INUMS;
 		break;
-	case Opt_quota:
 #ifdef CONFIG_QUOTA
+	case Opt_quota:
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		break;
+	case Opt_usrquota_block_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		size = DIV_ROUND_UP(size, PAGE_SIZE);
+		if (size > ULONG_MAX)
+			return invalfc(fc,
+				       "User quota block hardlimit too large.");
+		ctx->usrquota_block_hardlimit = size;
+		ctx->seen |=  SHMEM_SEEN_QUOTA;
+		break;
+	case Opt_grpquota_block_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		size = DIV_ROUND_UP(size, PAGE_SIZE);
+		if (size > ULONG_MAX)
+			return invalfc(fc,
+				       "Group quota block hardlimit too large.");
+		ctx->grpquota_block_hardlimit = size;
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		break;
+	case Opt_usrquota_inode_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		if (size > ULONG_MAX)
+			return invalfc(fc,
+				       "User quota inode hardlimit too large.");
+		ctx->usrquota_inode_hardlimit = size;
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		break;
+	case Opt_grpquota_inode_hardlimit:
+		size = memparse(param->string, &rest);
+		if (*rest || !size)
+			goto bad_value;
+		if (size > ULONG_MAX)
+			return invalfc(fc,
+				       "Group quota inode hardlimit too large.");
+		ctx->grpquota_inode_hardlimit = size;
 		ctx->seen |= SHMEM_SEEN_QUOTA;
+		break;
 #else
+	case Opt_quota:
+	case Opt_usrquota_block_hardlimit:
+	case Opt_grpquota_block_hardlimit:
+	case Opt_usrquota_inode_hardlimit:
+	case Opt_grpquota_inode_hardlimit:
 		goto unsupported_parameter;
 #endif
-		break;
 	}
 	return 0;
 
@@ -3778,6 +3886,18 @@ static int shmem_reconfigure(struct fs_context *fc)
 		goto out;
 	}
 
+#ifdef CONFIG_QUOTA
+#define CHANGED_LIMIT(name)						\
+	(ctx->name## _hardlimit &&					\
+	(ctx->name## _hardlimit != sbinfo->name## _hardlimit))
+
+	if (CHANGED_LIMIT(usrquota_block) || CHANGED_LIMIT(usrquota_inode) ||
+	    CHANGED_LIMIT(grpquota_block) || CHANGED_LIMIT(grpquota_inode)) {
+		err = "Cannot change global quota limit on remount";
+		goto out;
+	}
+#endif /* CONFIG_QUOTA */
+
 	if (ctx->seen & SHMEM_SEEN_HUGE)
 		sbinfo->huge = ctx->huge;
 	if (ctx->seen & SHMEM_SEEN_INUMS)
@@ -3942,11 +4062,22 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 
 #ifdef SHMEM_QUOTA_TMPFS
 	if (ctx->seen & SHMEM_SEEN_QUOTA) {
-		sb->dq_op = &dquot_operations;
+		unsigned int dquot_flags;
+
+		sb->dq_op = &shmem_dquot_operations;
 		sb->s_qcop = &dquot_quotactl_sysfile_ops;
 		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
 
-		if (shmem_enable_quotas(sb))
+		dquot_flags = DQUOT_USAGE_ENABLED;
+		/*
+		 * If any of the global quota limits are set, enable
+		 * quota enforcement
+		 */
+		if (ctx->usrquota_block_hardlimit || ctx->usrquota_inode_hardlimit ||
+		    ctx->grpquota_block_hardlimit || ctx->grpquota_inode_hardlimit)
+			dquot_flags |= DQUOT_LIMITS_ENABLED;
+
+		if (shmem_enable_quotas(sb, dquot_flags))
 			goto failed;
 	}
 #endif  /* SHMEM_QUOTA_TMPFS */
@@ -3960,6 +4091,17 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (!sb->s_root)
 		goto failed;
 
+#ifdef SHMEM_QUOTA_TMPFS
+	/*
+	 * Set quota hard limits after shmem_get_inode() to avoid setting
+	 * it for root
+	 */
+	sbinfo->usrquota_block_hardlimit = ctx->usrquota_block_hardlimit;
+	sbinfo->usrquota_inode_hardlimit = ctx->usrquota_inode_hardlimit;
+	sbinfo->grpquota_block_hardlimit = ctx->grpquota_block_hardlimit;
+	sbinfo->grpquota_inode_hardlimit = ctx->grpquota_inode_hardlimit;
+#endif  /* SHMEM_QUOTA_TMPFS */
+
 	return 0;
 
 failed:
-- 
2.38.1


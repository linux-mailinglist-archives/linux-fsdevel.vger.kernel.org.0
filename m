Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDFBB43CBED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:20:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242467AbhJ0OWg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:22:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25061 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236701AbhJ0OW2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:22:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344402;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+2IO286+9Ac8mT5hb2fyIzXPMhsV2azu295MiEaYca8=;
        b=HfGjbsBADC0aUJiLKEn3vESncLAhdbG2ZAp7c+zjnU44aY4mhXjGY6iGy0eRq67RUVBvoc
        +AFLpW+LUzWRo7oX51hezr7s3Sd96sSsGPVTtVWBJANDs71IeNI514v5oHS0poiIfbm+z8
        v2CU6AX6nN6z4JTeiEGO5zBjPYFrc5s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-36-H9Bip2QvMmOBH6_bfV5aKA-1; Wed, 27 Oct 2021 10:20:01 -0400
X-MC-Unique: H9Bip2QvMmOBH6_bfV5aKA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31AB98C2664;
        Wed, 27 Oct 2021 14:20:00 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1871C5DF5F;
        Wed, 27 Oct 2021 14:19:58 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 06/13] ext4: move quota configuration out of handle_mount_opt()
Date:   Wed, 27 Oct 2021 16:18:50 +0200
Message-Id: <20211027141857.33657-7-lczerner@redhat.com>
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At the parsing phase of mount in the new mount api sb will not be
available so move quota confiquration out of handle_mount_opt() by
noting the quota file names in the ext4_fs_context structure to be
able to apply it later.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ext4/super.c | 258 +++++++++++++++++++++++++++++++-----------------
 1 file changed, 165 insertions(+), 93 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b3c545695f2f..69e51b4037d3 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -88,6 +88,10 @@ static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 					    unsigned int journal_inum);
 static int ext4_validate_options(struct fs_context *fc);
+static int ext4_check_quota_consistency(struct fs_context *fc,
+					struct super_block *sb);
+static void ext4_apply_quota_options(struct fs_context *fc,
+				     struct super_block *sb);
 
 /*
  * Lock ordering
@@ -1979,71 +1983,6 @@ static const char deprecated_msg[] =
 	"Mount option \"%s\" will be removed by %s\n"
 	"Contact linux-ext4@vger.kernel.org if you think we should keep it.\n";
 
-#ifdef CONFIG_QUOTA
-static int set_qf_name(struct super_block *sb, int qtype,
-		       struct fs_parameter *param)
-{
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *qname, *old_qname = get_qf_name(sb, sbi, qtype);
-	int ret = -1;
-
-	if (sb_any_quota_loaded(sb) && !old_qname) {
-		ext4_msg(sb, KERN_ERR,
-			"Cannot change journaled "
-			"quota options when quota turned on");
-		return -1;
-	}
-	if (ext4_has_feature_quota(sb)) {
-		ext4_msg(sb, KERN_INFO, "Journaled quota options "
-			 "ignored when QUOTA feature is enabled");
-		return 1;
-	}
-	qname = kmemdup_nul(param->string, param->size, GFP_KERNEL);
-	if (!qname) {
-		ext4_msg(sb, KERN_ERR,
-			"Not enough memory for storing quotafile name");
-		return -1;
-	}
-	if (old_qname) {
-		if (strcmp(old_qname, qname) == 0)
-			ret = 1;
-		else
-			ext4_msg(sb, KERN_ERR,
-				 "%s quota file already specified",
-				 QTYPE2NAME(qtype));
-		goto errout;
-	}
-	if (strchr(qname, '/')) {
-		ext4_msg(sb, KERN_ERR,
-			"quotafile must be on filesystem root");
-		goto errout;
-	}
-	rcu_assign_pointer(sbi->s_qf_names[qtype], qname);
-	set_opt(sb, QUOTA);
-	return 1;
-errout:
-	kfree(qname);
-	return ret;
-}
-
-static int clear_qf_name(struct super_block *sb, int qtype)
-{
-
-	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	char *old_qname = get_qf_name(sb, sbi, qtype);
-
-	if (sb_any_quota_loaded(sb) && old_qname) {
-		ext4_msg(sb, KERN_ERR, "Cannot change journaled quota options"
-			" when quota turned on");
-		return -1;
-	}
-	rcu_assign_pointer(sbi->s_qf_names[qtype], NULL);
-	synchronize_rcu();
-	kfree(old_qname);
-	return 1;
-}
-#endif
-
 #define MOPT_SET	0x0001
 #define MOPT_CLEAR	0x0002
 #define MOPT_NOSUPPORT	0x0004
@@ -2247,11 +2186,70 @@ static int ext4_set_test_dummy_encryption(struct super_block *sb,
 }
 
 struct ext4_fs_context {
-	unsigned long journal_devnum;
-	unsigned int journal_ioprio;
-	int mb_optimize_scan;
+	char		*s_qf_names[EXT4_MAXQUOTAS];
+	int		s_jquota_fmt;	/* Format of quota to use */
+	unsigned short	qname_spec;
+	unsigned long	journal_devnum;
+	unsigned int	journal_ioprio;
+	int 		mb_optimize_scan;
 };
 
+#ifdef CONFIG_QUOTA
+/*
+ * Note the name of the specified quota file.
+ */
+static int note_qf_name(struct fs_context *fc, int qtype,
+		       struct fs_parameter *param)
+{
+	struct ext4_fs_context *ctx = fc->fs_private;
+	char *qname;
+
+	if (param->size < 1) {
+		ext4_msg(NULL, KERN_ERR, "Missing quota name");
+		return -EINVAL;
+	}
+	if (strchr(param->string, '/')) {
+		ext4_msg(NULL, KERN_ERR,
+			 "quotafile must be on filesystem root");
+		return -EINVAL;
+	}
+	if (ctx->s_qf_names[qtype]) {
+		if (strcmp(ctx->s_qf_names[qtype], param->string) != 0) {
+			ext4_msg(NULL, KERN_ERR,
+				 "%s quota file already specified",
+				 QTYPE2NAME(qtype));
+			return -EINVAL;
+		}
+		return 0;
+	}
+
+	qname = kmemdup_nul(param->string, param->size, GFP_KERNEL);
+	if (!qname) {
+		ext4_msg(NULL, KERN_ERR,
+			 "Not enough memory for storing quotafile name");
+		return -ENOMEM;
+	}
+	ctx->s_qf_names[qtype] = qname;
+	ctx->qname_spec |= 1 << qtype;
+	return 0;
+}
+
+/*
+ * Clear the name of the specified quota file.
+ */
+static int unnote_qf_name(struct fs_context *fc, int qtype)
+{
+	struct ext4_fs_context *ctx = fc->fs_private;
+
+	if (ctx->s_qf_names[qtype])
+		kfree(ctx->s_qf_names[qtype]);
+
+	ctx->s_qf_names[qtype] = NULL;
+	ctx->qname_spec |= 1 << qtype;
+	return 0;
+}
+#endif
+
 static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 {
 	struct ext4_fs_context *ctx = fc->fs_private;
@@ -2272,14 +2270,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 #ifdef CONFIG_QUOTA
 	if (token == Opt_usrjquota) {
 		if (!*param->string)
-			return clear_qf_name(sb, USRQUOTA);
+			return unnote_qf_name(fc, USRQUOTA);
 		else
-			return set_qf_name(sb, USRQUOTA, param);
+			return note_qf_name(fc, USRQUOTA, param);
 	} else if (token == Opt_grpjquota) {
 		if (!*param->string)
-			return clear_qf_name(sb, GRPQUOTA);
+			return unnote_qf_name(fc, GRPQUOTA);
 		else
-			return set_qf_name(sb, GRPQUOTA, param);
+			return note_qf_name(fc, GRPQUOTA, param);
 	}
 #endif
 	switch (token) {
@@ -2353,11 +2351,6 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 	}
 	if (m->flags & MOPT_CLEAR_ERR)
 		clear_opt(sb, ERRORS_MASK);
-	if (token == Opt_noquota && sb_any_quota_loaded(sb)) {
-		ext4_msg(NULL, KERN_ERR, "Cannot change quota "
-			 "options when quota turned on");
-		return -EINVAL;
-	}
 
 	if (m->flags & MOPT_NOSUPPORT) {
 		ext4_msg(NULL, KERN_ERR, "%s option not supported",
@@ -2479,19 +2472,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		}
 #ifdef CONFIG_QUOTA
 	} else if (m->flags & MOPT_QFMT) {
-		if (sb_any_quota_loaded(sb) &&
-		    sbi->s_jquota_fmt != m->mount_opt) {
-			ext4_msg(NULL, KERN_ERR, "Cannot change journaled "
-				 "quota options when quota turned on");
-			return -EINVAL;
-		}
-		if (ext4_has_feature_quota(sb)) {
-			ext4_msg(NULL, KERN_INFO,
-				 "Quota format mount options ignored "
-				 "when QUOTA feature is enabled");
-			return 1;
-		}
-		sbi->s_jquota_fmt = m->mount_opt;
+		ctx->s_jquota_fmt = m->mount_opt;
 #endif
 	} else if (token == Opt_dax || token == Opt_dax_always ||
 		   token == Opt_dax_inode || token == Opt_dax_never) {
@@ -2588,7 +2569,7 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 }
 
 static int parse_options(char *options, struct super_block *sb,
-			 struct ext4_fs_context *ret_opts,
+			 struct ext4_fs_context *ctx,
 			 int is_remount)
 {
 	struct fs_parameter param;
@@ -2600,7 +2581,7 @@ static int parse_options(char *options, struct super_block *sb,
 		return 1;
 
 	memset(&fc, 0, sizeof(fc));
-	fc.fs_private = ret_opts;
+	fc.fs_private = ctx;
 	fc.s_fs_info = EXT4_SB(sb);
 
 	if (is_remount)
@@ -2642,9 +2623,100 @@ static int parse_options(char *options, struct super_block *sb,
 	if (ret < 0)
 		return 0;
 
+	ret = ext4_check_quota_consistency(&fc, sb);
+	if (ret < 0)
+		return 0;
+
+	if (ctx->qname_spec)
+		ext4_apply_quota_options(&fc, sb);
+
 	return 1;
 }
 
+static void ext4_apply_quota_options(struct fs_context *fc,
+				     struct super_block *sb)
+{
+#ifdef CONFIG_QUOTA
+	struct ext4_fs_context *ctx = fc->fs_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	char *qname;
+	int i;
+
+	for (i = 0; i < EXT4_MAXQUOTAS; i++) {
+		if (!(ctx->qname_spec & (1 << i)))
+			continue;
+		qname = ctx->s_qf_names[i]; /* May be NULL */
+		ctx->s_qf_names[i] = NULL;
+		kfree(sbi->s_qf_names[i]);
+		rcu_assign_pointer(sbi->s_qf_names[i], qname);
+		set_opt(sb, QUOTA);
+	}
+#endif
+}
+
+/*
+ * Check quota settings consistency.
+ */
+static int ext4_check_quota_consistency(struct fs_context *fc,
+					struct super_block *sb)
+{
+#ifdef CONFIG_QUOTA
+	struct ext4_fs_context *ctx = fc->fs_private;
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	bool quota_feature = ext4_has_feature_quota(sb);
+	bool quota_loaded = sb_any_quota_loaded(sb);
+	int i;
+
+	if (ctx->qname_spec && quota_loaded) {
+		if (quota_feature)
+			goto err_feature;
+
+		for (i = 0; i < EXT4_MAXQUOTAS; i++) {
+			if (!(ctx->qname_spec & (1 << i)))
+				continue;
+
+			if (!!sbi->s_qf_names[i] != !!ctx->s_qf_names[i])
+				goto err_jquota_change;
+
+			if (sbi->s_qf_names[i] && ctx->s_qf_names[i] &&
+			    strcmp(sbi->s_qf_names[i],
+				   ctx->s_qf_names[i]) != 0)
+				goto err_jquota_specified;
+		}
+	}
+
+	if (ctx->s_jquota_fmt) {
+		if (sbi->s_jquota_fmt != ctx->s_jquota_fmt && quota_loaded)
+			goto err_quota_change;
+		if (quota_feature) {
+			ext4_msg(NULL, KERN_INFO, "Quota format mount options "
+				 "ignored when QUOTA feature is enabled");
+			return 0;
+		}
+	}
+	return 0;
+
+err_quota_change:
+	ext4_msg(NULL, KERN_ERR,
+		 "Cannot change quota options when quota turned on");
+	return -EINVAL;
+err_jquota_change:
+	ext4_msg(NULL, KERN_ERR, "Cannot change journaled quota "
+		 "options when quota turned on");
+	return -EINVAL;
+err_jquota_specified:
+	ext4_msg(NULL, KERN_ERR, "%s quota file already specified",
+		 QTYPE2NAME(i));
+	return -EINVAL;
+err_feature:
+	ext4_msg(NULL, KERN_ERR, "Journaled quota options ignored "
+		 "when QUOTA feature is enabled");
+	return 0;
+#else
+	return 0;
+#endif
+}
+
 static int ext4_validate_options(struct fs_context *fc)
 {
 	struct ext4_sb_info *sbi = fc->s_fs_info;
@@ -4099,7 +4171,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 	__u64 blocks_count;
 	int err = 0;
 	ext4_group_t first_not_zeroed;
-	struct ext4_fs_context parsed_opts;
+	struct ext4_fs_context parsed_opts = {0};
 
 	/* Set defaults for the variables that will be set during parsing */
 	parsed_opts.journal_ioprio = DEFAULT_JOURNAL_IOPRIO;
-- 
2.31.1


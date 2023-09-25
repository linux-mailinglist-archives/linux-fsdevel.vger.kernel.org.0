Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1DF97AD87C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 15:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbjIYNAw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 09:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231559AbjIYNAv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:00:51 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94BE7111
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 06:00:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E90C433C7;
        Mon, 25 Sep 2023 13:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695646843;
        bh=OCO3d4i2KdqO4TOtwL0mRMjJoxh5pd66flX2299oYPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GYBf0cqxsro788pRLG4+dCWj9UcTUyHISGdPuDehjYhteDD+pU+J6T343pcoc5jg7
         oWzxljoImO4sa+Hn1YTysMp+8Zw/vaWejVbXFkfylG3mYm9rRmBEAXKsXF2flDC7M6
         6zQBii6riknquz7Ds9Pjz8O+giAQOQ/9o92CuvF+TKcdHP+WtFy2hrtNin4pDXYh5J
         5PVZWAtV8OThv8Z4IpmKoF7LVhCIHV2oEz7Q8nf+Luc/Oa8WhKgBqunliNkKTXugLZ
         pWDIQY6D3CqmlakmLHINfEerPXkQ1/tqO1Gjxhl4jqsPbYaQBD04zbu+38AQ0AL3SP
         wpxXV1tPn6WFg==
From:   cem@kernel.org
To:     linux-fsdevel@vger.kernel.org
Cc:     hughd@google.com, brauner@kernel.org, jack@suse.cz
Subject: [PATCH 2/3] tmpfs: Add project quota mount option
Date:   Mon, 25 Sep 2023 15:00:27 +0200
Message-Id: <20230925130028.1244740-3-cem@kernel.org>
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

Enable tmpfs filesystems to be mounted using project quotas.

Signed-off-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 include/linux/shmem_fs.h |  2 +-
 mm/shmem.c               | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/include/linux/shmem_fs.h b/include/linux/shmem_fs.h
index e82a64f97917..c897cb6a70a2 100644
--- a/include/linux/shmem_fs.h
+++ b/include/linux/shmem_fs.h
@@ -14,7 +14,7 @@
 /* inode in-kernel data */
 
 #ifdef CONFIG_TMPFS_QUOTA
-#define SHMEM_MAXQUOTAS 2
+#define SHMEM_MAXQUOTAS 3
 
 /* Default project ID */
 #define SHMEM_DEF_PROJID 0
diff --git a/mm/shmem.c b/mm/shmem.c
index 6ccf60bd1690..4d2b713bff06 100644
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -3865,6 +3865,7 @@ enum shmem_param {
 	Opt_quota,
 	Opt_usrquota,
 	Opt_grpquota,
+	Opt_prjquota,
 	Opt_usrquota_block_hardlimit,
 	Opt_usrquota_inode_hardlimit,
 	Opt_grpquota_block_hardlimit,
@@ -3895,6 +3896,7 @@ const struct fs_parameter_spec shmem_fs_parameters[] = {
 	fsparam_flag  ("quota",		Opt_quota),
 	fsparam_flag  ("usrquota",	Opt_usrquota),
 	fsparam_flag  ("grpquota",	Opt_grpquota),
+	fsparam_flag  ("prjquota",	Opt_prjquota),
 	fsparam_string("usrquota_block_hardlimit", Opt_usrquota_block_hardlimit),
 	fsparam_string("usrquota_inode_hardlimit", Opt_usrquota_inode_hardlimit),
 	fsparam_string("grpquota_block_hardlimit", Opt_grpquota_block_hardlimit),
@@ -4029,6 +4031,12 @@ static int shmem_parse_one(struct fs_context *fc, struct fs_parameter *param)
 		ctx->seen |= SHMEM_SEEN_QUOTA;
 		ctx->quota_types |= QTYPE_MASK_GRP;
 		break;
+	case Opt_prjquota:
+		if (fc->user_ns != &init_user_ns)
+			return invalfc(fc, "Quotas in unprivileged tmpfs mounts are unsupported");
+		ctx->seen |= SHMEM_SEEN_QUOTA;
+		ctx->quota_types |= QTYPE_MASK_PRJ;
+		break;
 	case Opt_usrquota_block_hardlimit:
 		size = memparse(param->string, &rest);
 		if (*rest || !size)
@@ -4363,7 +4371,8 @@ static int shmem_fill_super(struct super_block *sb, struct fs_context *fc)
 	if (ctx->seen & SHMEM_SEEN_QUOTA) {
 		sb->dq_op = &shmem_quota_operations;
 		sb->s_qcop = &dquot_quotactl_sysfile_ops;
-		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP;
+		sb->s_quota_types = QTYPE_MASK_USR | QTYPE_MASK_GRP |
+				    QTYPE_MASK_PRJ;
 
 		/* Copy the default limits from ctx into sbinfo */
 		memcpy(&sbinfo->qlimits, &ctx->qlimits,
-- 
2.39.2


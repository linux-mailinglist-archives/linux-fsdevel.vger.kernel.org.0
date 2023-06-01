Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2123D719788
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Jun 2023 11:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233017AbjFAJqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Jun 2023 05:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbjFAJqU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Jun 2023 05:46:20 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2E2138;
        Thu,  1 Jun 2023 02:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Qfuay10AzkmA8DYupLvHg2nTBv/KnX5g5wKQF7ueM4o=; b=cHjl0o/9Srq1e+L+HNiuLViu4O
        Z5kCmnaomYKlFSR24zlJsKkmY7WFQnpl19MDpA5h+AVV8YfCuKmkHRChRcxDK9Nknm4/jV5OnBC7U
        R5EG9B1zfnYP/55SzK8WDAg9vMHUimEXq+6OqaztURies2iniANZGUjZYGojAj69UaMYjNWE9iPWm
        HzluJIiEjHAT+tQHUQ9FoayWZMC6AlC5KJauuhDuTFYj3zG+QCJhEKsnmH5QvWVv3ei4zjYKqcSoM
        1JPDjD0K6gvUXvCz2usFFcrKbRQCtOYX6JNKtsDl+TNsatcvdSsaxeGP/MZoWjBdFo0qKYc4aqLzp
        JvqpETwQ==;
Received: from [2001:4bb8:182:6d06:35f3:1da0:1cc3:d86d] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q4esq-002mBV-1f;
        Thu, 01 Jun 2023 09:46:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: [PATCH 14/16] ext4: split ext4_shutdown
Date:   Thu,  1 Jun 2023 11:44:57 +0200
Message-Id: <20230601094459.1350643-15-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601094459.1350643-1-hch@lst.de>
References: <20230601094459.1350643-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Split ext4_shutdown into a low-level helper that will be reused for
implementing the shutdown super operation and a wrapper for the ioctl
handling.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/ext4/ext4.h  |  1 +
 fs/ext4/ioctl.c | 24 +++++++++++++++---------
 2 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 6948d673bba2e8..2d60bbe8d171d9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2965,6 +2965,7 @@ int ext4_fileattr_set(struct mnt_idmap *idmap,
 int ext4_fileattr_get(struct dentry *dentry, struct fileattr *fa);
 extern void ext4_reset_inode_seed(struct inode *inode);
 int ext4_update_overhead(struct super_block *sb, bool force);
+int ext4_force_shutdown(struct super_block *sb, u32 flags);
 
 /* migrate.c */
 extern int ext4_ext_migrate(struct inode *);
diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index f9a43015206323..961284cc9b65cc 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -793,16 +793,9 @@ static int ext4_ioctl_setproject(struct inode *inode, __u32 projid)
 }
 #endif
 
-static int ext4_shutdown(struct super_block *sb, unsigned long arg)
+int ext4_force_shutdown(struct super_block *sb, u32 flags)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
-	__u32 flags;
-
-	if (!capable(CAP_SYS_ADMIN))
-		return -EPERM;
-
-	if (get_user(flags, (__u32 __user *)arg))
-		return -EFAULT;
 
 	if (flags > EXT4_GOING_FLAGS_NOLOGFLUSH)
 		return -EINVAL;
@@ -838,6 +831,19 @@ static int ext4_shutdown(struct super_block *sb, unsigned long arg)
 	return 0;
 }
 
+static int ext4_ioctl_shutdown(struct super_block *sb, unsigned long arg)
+{
+	u32 flags;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EPERM;
+
+	if (get_user(flags, (__u32 __user *)arg))
+		return -EFAULT;
+
+	return ext4_force_shutdown(sb, flags);
+}
+
 struct getfsmap_info {
 	struct super_block	*gi_sb;
 	struct fsmap_head __user *gi_data;
@@ -1566,7 +1572,7 @@ static long __ext4_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 		return ext4_ioctl_get_es_cache(filp, arg);
 
 	case EXT4_IOC_SHUTDOWN:
-		return ext4_shutdown(sb, arg);
+		return ext4_ioctl_shutdown(sb, arg);
 
 	case FS_IOC_ENABLE_VERITY:
 		if (!ext4_has_feature_verity(sb))
-- 
2.39.2


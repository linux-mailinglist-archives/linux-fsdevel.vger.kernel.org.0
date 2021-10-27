Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7784243CBF3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Oct 2021 16:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242486AbhJ0OXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Oct 2021 10:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39871 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236730AbhJ0OXI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Oct 2021 10:23:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1635344443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jjNfQh62aTbvnZnilhSR9KBXXedQowR4t0jicaRIMEc=;
        b=WZ8Q+t+Rg4GyHW8ACXS7YiwZnO+RUdODXnDpnySpRB7fPZCnEIFhGSltKrNm2wCqIfd1bJ
        48oXGqyFRsbmjOQORxFfw9YHNWHekbeQevvjWR3fI+HtKwffr4Illeop2sjuoiT2SBVMaX
        ubVCp1ag5WwaqCARDi5aFoyWTkI/VXo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-33-ovmWMYldM7y2_2pf5e-Zpg-1; Wed, 27 Oct 2021 10:20:37 -0400
X-MC-Unique: ovmWMYldM7y2_2pf5e-Zpg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA346BAFA1;
        Wed, 27 Oct 2021 14:20:36 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.65])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 853EF5DF35;
        Wed, 27 Oct 2021 14:20:00 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     linux-ext4@vger.kernel.org, tytso@mit.edu
Cc:     linux-fsdevel@vger.kernel.org,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v4 07/13] ext4: check ext2/3 compatibility outside handle_mount_opt()
Date:   Wed, 27 Oct 2021 16:18:51 +0200
Message-Id: <20211027141857.33657-8-lczerner@redhat.com>
In-Reply-To: <20211027141857.33657-1-lczerner@redhat.com>
References: <20211027141857.33657-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

At the parsing phase of mount in the new mount api sb will not be
available so move ext2/3 compatibility check outside handle_mount_opt().
Unfortunately we will lose the ability to show exactly which option is
not compatible.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
---
 fs/ext4/super.c | 41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 69e51b4037d3..81027834aeb2 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -88,8 +88,8 @@ static void ext4_clear_request_list(void);
 static struct inode *ext4_get_journal_inode(struct super_block *sb,
 					    unsigned int journal_inum);
 static int ext4_validate_options(struct fs_context *fc);
-static int ext4_check_quota_consistency(struct fs_context *fc,
-					struct super_block *sb);
+static int ext4_check_opt_consistency(struct fs_context *fc,
+				      struct super_block *sb);
 static void ext4_apply_quota_options(struct fs_context *fc,
 				     struct super_block *sb);
 
@@ -2192,6 +2192,7 @@ struct ext4_fs_context {
 	unsigned long	journal_devnum;
 	unsigned int	journal_ioprio;
 	int 		mb_optimize_scan;
+	unsigned int	opt_flags;	/* MOPT flags */
 };
 
 #ifdef CONFIG_QUOTA
@@ -2322,25 +2323,14 @@ static int handle_mount_opt(struct fs_context *fc, struct fs_parameter *param)
 		if (token == m->token)
 			break;
 
+	ctx->opt_flags |= m->flags;
+
 	if (m->token == Opt_err) {
 		ext4_msg(NULL, KERN_ERR, "Unrecognized mount option \"%s\" "
 			 "or missing value", param->key);
 		return -EINVAL;
 	}
 
-	if ((m->flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
-		ext4_msg(NULL, KERN_ERR,
-			 "Mount option \"%s\" incompatible with ext2",
-			 param->key);
-		return -EINVAL;
-	}
-	if ((m->flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
-		ext4_msg(NULL, KERN_ERR,
-			 "Mount option \"%s\" incompatible with ext3",
-			 param->key);
-		return -EINVAL;
-	}
-
 	if (m->flags & MOPT_EXPLICIT) {
 		if (m->mount_opt & EXT4_MOUNT_DELALLOC) {
 			set_opt2(sb, EXPLICIT_DELALLOC);
@@ -2623,7 +2613,7 @@ static int parse_options(char *options, struct super_block *sb,
 	if (ret < 0)
 		return 0;
 
-	ret = ext4_check_quota_consistency(&fc, sb);
+	ret = ext4_check_opt_consistency(&fc, sb);
 	if (ret < 0)
 		return 0;
 
@@ -2717,6 +2707,25 @@ static int ext4_check_quota_consistency(struct fs_context *fc,
 #endif
 }
 
+static int ext4_check_opt_consistency(struct fs_context *fc,
+				      struct super_block *sb)
+{
+	struct ext4_fs_context *ctx = fc->fs_private;
+
+	if ((ctx->opt_flags & MOPT_NO_EXT2) && IS_EXT2_SB(sb)) {
+		ext4_msg(NULL, KERN_ERR,
+			 "Mount option(s) incompatible with ext2");
+		return -EINVAL;
+	}
+	if ((ctx->opt_flags & MOPT_NO_EXT3) && IS_EXT3_SB(sb)) {
+		ext4_msg(NULL, KERN_ERR,
+			 "Mount option(s) incompatible with ext3");
+		return -EINVAL;
+	}
+
+	return ext4_check_quota_consistency(fc, sb);
+}
+
 static int ext4_validate_options(struct fs_context *fc)
 {
 	struct ext4_sb_info *sbi = fc->s_fs_info;
-- 
2.31.1


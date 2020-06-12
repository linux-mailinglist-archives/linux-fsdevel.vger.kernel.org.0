Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB101F7688
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFLKNT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 06:13:19 -0400
Received: from lgeamrelo12.lge.com ([156.147.23.52]:58201 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726255AbgFLKNS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:13:18 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.52 with ESMTP; 12 Jun 2020 18:43:15 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO localhost.localdomain) (10.177.225.35)
        by 156.147.1.121 with ESMTP; 12 Jun 2020 18:43:15 +0900
X-Original-SENDERIP: 10.177.225.35
X-Original-MAILFROM: hyc.lee@gmail.com
From:   Hyunchul Lee <hyc.lee@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: [PATCH 2/2] exfat: allow to change some mount options for remount
Date:   Fri, 12 Jun 2020 18:42:50 +0900
Message-Id: <20200612094250.9347-2-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200612094250.9347-1-hyc.lee@gmail.com>
References: <20200612094250.9347-1-hyc.lee@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Allow to change permission masks, allow_utime,
errors. But ignore other options.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/exfat/super.c | 40 +++++++++++++++++++++++++++++-----------
 1 file changed, 29 insertions(+), 11 deletions(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 61c6cf240c19..3c1d47289ba2 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -696,9 +696,13 @@ static void exfat_free(struct fs_context *fc)
 static int exfat_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
+	struct exfat_sb_info *sbi = EXFAT_SB(sb);
+	struct exfat_mount_options *new_opts;
 	int ret;
 	bool new_rdonly;
 
+	new_opts = &((struct exfat_sb_info *)fc->s_fs_info)->options;
+
 	new_rdonly = fc->sb_flags & SB_RDONLY;
 	if (new_rdonly != sb_rdonly(sb)) {
 		if (new_rdonly) {
@@ -708,6 +712,12 @@ static int exfat_reconfigure(struct fs_context *fc)
 				return ret;
 		}
 	}
+
+	/* allow to change these options but ignore others */
+	sbi->options.fs_fmask = new_opts->fs_fmask;
+	sbi->options.fs_dmask = new_opts->fs_dmask;
+	sbi->options.allow_utime = new_opts->allow_utime;
+	sbi->options.errors = new_opts->errors;
 	return 0;
 }
 
@@ -726,17 +736,25 @@ static int exfat_init_fs_context(struct fs_context *fc)
 	if (!sbi)
 		return -ENOMEM;
 
-	mutex_init(&sbi->s_lock);
-	ratelimit_state_init(&sbi->ratelimit, DEFAULT_RATELIMIT_INTERVAL,
-			DEFAULT_RATELIMIT_BURST);
-
-	sbi->options.fs_uid = current_uid();
-	sbi->options.fs_gid = current_gid();
-	sbi->options.fs_fmask = current->fs->umask;
-	sbi->options.fs_dmask = current->fs->umask;
-	sbi->options.allow_utime = -1;
-	sbi->options.iocharset = exfat_default_iocharset;
-	sbi->options.errors = EXFAT_ERRORS_RO;
+	if (fc->root) {
+		/* reconfiguration */
+		memcpy(&sbi->options, &EXFAT_SB(fc->root->d_sb)->options,
+			sizeof(struct exfat_mount_options));
+		sbi->options.iocharset = exfat_default_iocharset;
+	} else {
+		mutex_init(&sbi->s_lock);
+		ratelimit_state_init(&sbi->ratelimit,
+				DEFAULT_RATELIMIT_INTERVAL,
+				DEFAULT_RATELIMIT_BURST);
+
+		sbi->options.fs_uid = current_uid();
+		sbi->options.fs_gid = current_gid();
+		sbi->options.fs_fmask = current->fs->umask;
+		sbi->options.fs_dmask = current->fs->umask;
+		sbi->options.allow_utime = -1;
+		sbi->options.iocharset = exfat_default_iocharset;
+		sbi->options.errors = EXFAT_ERRORS_RO;
+	}
 
 	fc->s_fs_info = sbi;
 	fc->ops = &exfat_context_ops;
-- 
2.17.1


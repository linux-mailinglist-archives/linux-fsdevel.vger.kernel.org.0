Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC551F7687
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jun 2020 12:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726134AbgFLKNQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jun 2020 06:13:16 -0400
Received: from lgeamrelo13.lge.com ([156.147.23.53]:51496 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725872AbgFLKNO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jun 2020 06:13:14 -0400
Received: from unknown (HELO lgemrelse6q.lge.com) (156.147.1.121)
        by 156.147.23.53 with ESMTP; 12 Jun 2020 18:43:11 +0900
X-Original-SENDERIP: 156.147.1.121
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO localhost.localdomain) (10.177.225.35)
        by 156.147.1.121 with ESMTP; 12 Jun 2020 18:43:11 +0900
X-Original-SENDERIP: 10.177.225.35
X-Original-MAILFROM: hyc.lee@gmail.com
From:   Hyunchul Lee <hyc.lee@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@lge.com
Subject: [PATCH 1/2] exfat: call sync_filesystem for read-only remount
Date:   Fri, 12 Jun 2020 18:42:49 +0900
Message-Id: <20200612094250.9347-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to commit dirty metadata and pages to disk
before remounting exfat as read-only.

This fixes a failure in xfstests generic/452

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/exfat/super.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e650e65536f8..61c6cf240c19 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -693,10 +693,29 @@ static void exfat_free(struct fs_context *fc)
 	}
 }
 
+static int exfat_reconfigure(struct fs_context *fc)
+{
+	struct super_block *sb = fc->root->d_sb;
+	int ret;
+	bool new_rdonly;
+
+	new_rdonly = fc->sb_flags & SB_RDONLY;
+	if (new_rdonly != sb_rdonly(sb)) {
+		if (new_rdonly) {
+			/* volume flag will be updated in exfat_sync_fs */
+			ret = sync_filesystem(sb);
+			if (ret < 0)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 static const struct fs_context_operations exfat_context_ops = {
 	.parse_param	= exfat_parse_param,
 	.get_tree	= exfat_get_tree,
 	.free		= exfat_free,
+	.reconfigure	= exfat_reconfigure,
 };
 
 static int exfat_init_fs_context(struct fs_context *fc)
-- 
2.17.1


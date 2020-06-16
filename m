Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 050791FA850
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jun 2020 07:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgFPFfB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jun 2020 01:35:01 -0400
Received: from lgeamrelo11.lge.com ([156.147.23.51]:43506 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgFPFfB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jun 2020 01:35:01 -0400
Received: from unknown (HELO lgeamrelo01.lge.com) (156.147.1.125)
        by 156.147.23.51 with ESMTP; 16 Jun 2020 14:34:59 +0900
X-Original-SENDERIP: 156.147.1.125
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO localhost.localdomain) (10.177.225.35)
        by 156.147.1.125 with ESMTP; 16 Jun 2020 14:34:59 +0900
X-Original-SENDERIP: 10.177.225.35
X-Original-MAILFROM: hyc.lee@gmail.com
From:   Hyunchul Lee <hyc.lee@gmail.com>
To:     Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>
Cc:     Hyunchul Lee <hyc.lee@gmail.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-team@lge.com
Subject: [PATCH v2] exfat: call sync_filesystem for read-only remount
Date:   Tue, 16 Jun 2020 14:34:45 +0900
Message-Id: <20200616053445.18125-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We need to commit dirty metadata and pages to disk
before remounting exfat as read-only.

This fixes a failure in xfstests generic/452

generic/452 does the following:
cp something <exfat>/
mount -o remount,ro <exfat>

the <exfat>/something is corrupted. because while
exfat is remounted as read-only, exfat doesn't
have a chance to commit metadata and
vfs invalidates page caches in a block device.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
Changes from v1:
- Does not check the return value of sync_filesystem to
  allow to change from "rw" to "ro" even when this function
  fails.
- Add the detailed explanation why generic/452 fails

 fs/exfat/super.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index e650e65536f8..253a92460d52 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -693,10 +693,20 @@ static void exfat_free(struct fs_context *fc)
 	}
 }
 
+static int exfat_reconfigure(struct fs_context *fc)
+{
+	fc->sb_flags |= SB_NODIRATIME;
+
+	/* volume flag will be updated in exfat_sync_fs */
+	sync_filesystem(fc->root->d_sb);
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


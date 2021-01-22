Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A69F6300703
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Jan 2021 16:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728784AbhAVPTH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Jan 2021 10:19:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbhAVPRa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:17:30 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B324C061794
        for <linux-fsdevel@vger.kernel.org>; Fri, 22 Jan 2021 07:16:07 -0800 (PST)
Received: from dude02.hi.pengutronix.de ([2001:67c:670:100:1d::28])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2yA1-0004Bw-H9; Fri, 22 Jan 2021 16:15:41 +0100
Received: from sha by dude02.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <sha@pengutronix.de>)
        id 1l2yA0-0003qx-TQ; Fri, 22 Jan 2021 16:15:40 +0100
From:   Sascha Hauer <s.hauer@pengutronix.de>
To:     linux-fsdevel@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>, linux-mtd@lists.infradead.org,
        kernel@pengutronix.de, Jan Kara <jack@suse.com>,
        Sascha Hauer <s.hauer@pengutronix.de>
Subject: [PATCH 5/8] ubifs: Factor out ubifs_set_feature_flag()
Date:   Fri, 22 Jan 2021 16:15:33 +0100
Message-Id: <20210122151536.7982-6-s.hauer@pengutronix.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210122151536.7982-1-s.hauer@pengutronix.de>
References: <20210122151536.7982-1-s.hauer@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::28
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-fsdevel@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The code setting a feature flag can be reused for upcoming projid
support. Factor out a function to share the code.

Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
---
 fs/ubifs/sb.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/ubifs/sb.c b/fs/ubifs/sb.c
index c160f718c288..87466836fcfc 100644
--- a/fs/ubifs/sb.c
+++ b/fs/ubifs/sb.c
@@ -924,28 +924,34 @@ int ubifs_fixup_free_space(struct ubifs_info *c)
 	return err;
 }
 
-int ubifs_enable_encryption(struct ubifs_info *c)
+static int ubifs_set_feature_flag(struct ubifs_info *c, unsigned int flag)
 {
-	int err;
 	struct ubifs_sb_node *sup = c->sup_node;
 
-	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
-		return -EOPNOTSUPP;
-
-	if (c->encrypted)
+	if ((sup->flags & cpu_to_le32(flag)) == cpu_to_le32(flag))
 		return 0;
 
 	if (c->ro_mount || c->ro_media)
 		return -EROFS;
 
 	if (c->fmt_version < 5) {
-		ubifs_err(c, "on-flash format version 5 is needed for encryption");
+		ubifs_err(c, "on-flash format version 5 is needed for feature flags");
 		return -EINVAL;
 	}
 
-	sup->flags |= cpu_to_le32(UBIFS_FLG_ENCRYPTION);
+	sup->flags |= cpu_to_le32(flag);
+
+	return ubifs_write_sb_node(c, sup);
+}
+
+int ubifs_enable_encryption(struct ubifs_info *c)
+{
+	int err;
+
+	if (!IS_ENABLED(CONFIG_FS_ENCRYPTION))
+		return -EOPNOTSUPP;
 
-	err = ubifs_write_sb_node(c, sup);
+	err = ubifs_set_feature_flag(c, UBIFS_FLG_ENCRYPTION);
 	if (!err)
 		c->encrypted = 1;
 
-- 
2.20.1


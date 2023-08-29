Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF9478C88A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 17:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbjH2PZN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbjH2PYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:24:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F73CC3
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 08:24:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E60E4622F0
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 15:24:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0E10C433CA;
        Tue, 29 Aug 2023 15:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693322681;
        bh=iP4dX2qCO+ZT04YIUw2BpQIHHbY58GWkfTXwxjlTxA4=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=TasYuIJ5FvFMPV+4dFzGIueImrgHopM2U1xqEuJ7omaEP9KA61mG16XScH5IPD3bB
         /uxaqFt0xQaZdKohK3yDCh7VCPxMYfZNaDAJ4diSP1YR6Me7HZeKsw+I/PnPwL8mcg
         83bYZVwrnbgRLoR6SCyqp/8c+DTpaN8zzQOTIMtrsVqVFKdPmjvBV88P85WvInYi56
         YrJCBxQM1kq3gT5BrY1rHD2ADmqMcQVHnJT1rhiq3SX3P+QZZMmovGmJuIeRhyAA85
         e5RXoqHYzXAV0hsfI4VkDS5e0IzOPejGANUHMnrMFPiaVAAE/BE/6+YNdGZxMSOS2G
         WTm8+XjG/WhWg==
From:   Christian Brauner <brauner@kernel.org>
Date:   Tue, 29 Aug 2023 17:23:56 +0200
Subject: [PATCH 1/2] fs: export sget_dev()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
In-Reply-To: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>,
        Richard Weinberger <richard@nod.at>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=openpgp-sha256; l=2131; i=brauner@kernel.org;
 h=from:subject:message-id; bh=iP4dX2qCO+ZT04YIUw2BpQIHHbY58GWkfTXwxjlTxA4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS8490qzBjFfnbXuqO3TmVoL1PUndKY1uB5OrYr6T/n8sK6
 65JqHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMR3czwTydzp6XBYuu6z66RFfkK3n
 5au3U23GjZIOFs7Pz9T0eDMiNDX5LE1Eere1XPzrIxqUrdwnpV1n3hzcm+NTet53xyr1BmAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

They will be used for mtd devices as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 14 ++++++++++----
 include/linux/fs.h |  1 +
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index ad7ac3a24d38..88cb628de6a1 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1435,12 +1435,12 @@ static int set_bdev_super(struct super_block *s, void *data)
 	return 0;
 }
 
-static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
+static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
 {
 	return set_bdev_super(s, fc->sget_key);
 }
 
-static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
+static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
 {
 	return !(s->s_iflags & SB_I_RETIRED) &&
 		s->s_dev == *(dev_t *)fc->sget_key;
@@ -1500,6 +1500,13 @@ int setup_bdev_super(struct super_block *sb, int sb_flags,
 }
 EXPORT_SYMBOL_GPL(setup_bdev_super);
 
+struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
+{
+	fc->sget_key = &dev;
+	return sget_fc(fc, super_s_dev_set, super_s_dev_test);
+}
+EXPORT_SYMBOL(sget_dev);
+
 /**
  * get_tree_bdev - Get a superblock based on a single block device
  * @fc: The filesystem context holding the parameters
@@ -1523,8 +1530,7 @@ int get_tree_bdev(struct fs_context *fc,
 	}
 
 	fc->sb_flags |= SB_NOSEC;
-	fc->sget_key = &dev;
-	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
+	s = sget_dev(fc, dev);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ca8ceccde3d6..8a8d1cd5b0a9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2274,6 +2274,7 @@ struct super_block *sget(struct file_system_type *type,
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
 			int flags, void *data);
+struct super_block *sget_dev(struct fs_context *fc, dev_t dev);
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \

-- 
2.34.1


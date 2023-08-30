Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9C278DAD0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 30 Aug 2023 20:38:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237370AbjH3ShN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Aug 2023 14:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbjH3KCz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:02:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E367C1B0
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 03:02:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 739C262643
        for <linux-fsdevel@vger.kernel.org>; Wed, 30 Aug 2023 10:02:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F44C433C7;
        Wed, 30 Aug 2023 10:02:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693389771;
        bh=21KpJvsxmen+6ltxslnavLUss7C8n6CYIrpV8T6qub8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=c/m6uqfPOwtPSKlaXs9m67r/QL9JLEqrF9sLTeU3bDqWTeD4GBm93iknTCupun88O
         ZAPieOkVfWTo0CDEK0Pq1K+dFKJ94bgt0AAxpMc86JDAbRcpK+/4UaOPvreJeuuXbx
         UZz6hrKzHbv/27R6uuYCzaiGWndIVJYrkPBOleEB5mAFhes3VGudZnwDa1ormIYJlu
         Q8ktSHnNmM1FwTKpDGBlMyYDMNrXeGLL8tb8HTujAodzvirPOT5PuwW7LdpcxTQcaW
         ajOhFlCCIh/IhYlUdFSbmznUu2TpEWJm+fNpkjmwMuJp1YUnw8+lq6AeHSiJomudAe
         MpMr0MJngJe7Q==
Date:   Wed, 30 Aug 2023 12:02:47 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 1/2] fs: export sget_dev()
Message-ID: <20230830-theater-quizsendung-4ba64e87df36@brauner>
References: <20230829-vfs-super-mtd-v1-0-fecb572e5df3@kernel.org>
 <20230829-vfs-super-mtd-v1-1-fecb572e5df3@kernel.org>
 <20230830061409.GB17785@lst.de>
 <20230830-befanden-geahndet-2f084125d861@brauner>
 <20230830093851.uwdgpt645niysuji@quack3>
 <20230830-ohnedies-umland-fb2b1a45db10@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230830-ohnedies-umland-fb2b1a45db10@brauner>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Yeah, good point. Done.

From fe40c7fe1a87814f92f9b1d0b9fb78ac69404c33 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 29 Aug 2023 15:05:28 +0200
Subject: [PATCH 1/2] fs: export sget_dev()

They will be used for mtd devices as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 64 ++++++++++++++++++++++++++++++++--------------
 include/linux/fs.h |  1 +
 2 files changed, 46 insertions(+), 19 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index ad7ac3a24d38..d27d80bf7c43 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1371,6 +1371,50 @@ int get_tree_keyed(struct fs_context *fc,
 }
 EXPORT_SYMBOL(get_tree_keyed);
 
+static int set_bdev_super(struct super_block *s, void *data)
+{
+	s->s_dev = *(dev_t *)data;
+	return 0;
+}
+
+static int super_s_dev_set(struct super_block *s, struct fs_context *fc)
+{
+	return set_bdev_super(s, fc->sget_key);
+}
+
+static int super_s_dev_test(struct super_block *s, struct fs_context *fc)
+{
+	return !(s->s_iflags & SB_I_RETIRED) &&
+		s->s_dev == *(dev_t *)fc->sget_key;
+}
+
+/**
+ * sget_dev - Find or create a superblock by device number
+ * @fc: Filesystem context.
+ * @dev: device number
+ *
+ * Find or create a superblock using the provided device number that
+ * will be stored in fc->sget_key.
+ *
+ * If an extant superblock is matched, then that will be returned with
+ * an elevated reference count that the caller must transfer or discard.
+ *
+ * If no match is made, a new superblock will be allocated and basic
+ * initialisation will be performed (s_type, s_fs_info, s_id, s_dev will
+ * be set). The superblock will be published and it will be returned in
+ * a partially constructed state with SB_BORN and SB_ACTIVE as yet
+ * unset.
+ *
+ * Return: an existing or newly created superblock on success, an error
+ *         pointer on failure.
+ */
+struct super_block *sget_dev(struct fs_context *fc, dev_t dev)
+{
+	fc->sget_key = &dev;
+	return sget_fc(fc, super_s_dev_test, super_s_dev_set);
+}
+EXPORT_SYMBOL(sget_dev);
+
 #ifdef CONFIG_BLOCK
 /*
  * Lock a super block that the callers holds a reference to.
@@ -1429,23 +1473,6 @@ const struct blk_holder_ops fs_holder_ops = {
 };
 EXPORT_SYMBOL_GPL(fs_holder_ops);
 
-static int set_bdev_super(struct super_block *s, void *data)
-{
-	s->s_dev = *(dev_t *)data;
-	return 0;
-}
-
-static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
-{
-	return set_bdev_super(s, fc->sget_key);
-}
-
-static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
-{
-	return !(s->s_iflags & SB_I_RETIRED) &&
-		s->s_dev == *(dev_t *)fc->sget_key;
-}
-
 int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
 {
@@ -1523,8 +1550,7 @@ int get_tree_bdev(struct fs_context *fc,
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


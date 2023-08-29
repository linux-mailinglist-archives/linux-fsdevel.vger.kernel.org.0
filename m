Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D7378C65C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 15:44:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233146AbjH2Nnw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 09:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234994AbjH2Nn2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 09:43:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 516F7E65
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 06:42:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2AEFD640D6
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 13:41:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5C0AC433C7;
        Tue, 29 Aug 2023 13:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316468;
        bh=UHaZZUfNKJG8LMBQZDyewbl0KkKUaQSpeq4dZruj2eE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CjrrfW4iBysmWyeRw9khS7d7+bPKBzxkVWZdOJnvKsx5xhYfdGCXYPBCXYcan3LFn
         brfInsZvFx8dkSsSt3SUA0kGeUCcrqejkTKSh5TJUhg8gX/zQOu3oinVHeVOoOxUiU
         FD7+GmWuMSoWx6aE5sNsfP1nKox27NZmjo4SgunqqKI22ri1cw0AGMHf5RwyD2Lnah
         KWg2bt4TvTG7r/cZuYJVX3ir27x1jPQnRSKtJL12Tzaci9GXh2Gy6vaCiB/aTCeMRq
         P40tOvLthEZNi+s9b2BvX/+uqz3o+CHE3CX7uhsHvF8w2BQ30PgZOs+ogxDp/xWAnD
         SAPAiAMfsya8g==
Date:   Tue, 29 Aug 2023 15:41:04 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Christoph Hellwig <hch@lst.de>, Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: mtd
Message-ID: <20230829-abkassieren-pizzen-c34ca3731a5c@brauner>
References: <20230829-weitab-lauwarm-49c40fc85863@brauner>
 <20230829125118.GA24767@lst.de>
 <20230829-erzeugen-verruf-6c06640844b0@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230829-erzeugen-verruf-6c06640844b0@brauner>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:57:02PM +0200, Christian Brauner wrote:
> On Tue, Aug 29, 2023 at 02:51:18PM +0200, Christoph Hellwig wrote:
> > On Tue, Aug 29, 2023 at 01:46:20PM +0200, Christian Brauner wrote:
> > > Something like the following might already be enough (IT'S A DRAFT, AND
> > > UNTESTED, AND PROBABLY BROKEN)?
> > 
> > It's probably the right thing conceptually, but it will also need
> > the SB_I_RETIRED from test_bdev_super_fc or even just reuse
> > test_bdev_super_fc after that's been renamed to be more generic.
> 
> I'll rename it and use it. Let me send a patch.

Hmkay, how does that look? I think this is a fairly acceptable change
and looks better than the mtd special-test/set-sauce we currently have:

From b85ee296f59b0a8e739f10ab9005b7c1fe1aad23 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 29 Aug 2023 15:05:28 +0200
Subject: [PATCH 1/2] fs: export vfs_super_s_dev_{set,test} helpers

They will be used in other places as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/super.c         | 8 +++++---
 include/linux/fs.h | 2 ++
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index ad7ac3a24d38..a122154facbf 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1435,16 +1435,18 @@ static int set_bdev_super(struct super_block *s, void *data)
 	return 0;
 }
 
-static int set_bdev_super_fc(struct super_block *s, struct fs_context *fc)
+int vfs_super_s_dev_set(struct super_block *s, struct fs_context *fc)
 {
 	return set_bdev_super(s, fc->sget_key);
 }
+EXPORT_SYMBOL(vfs_super_s_dev_set);
 
-static int test_bdev_super_fc(struct super_block *s, struct fs_context *fc)
+int vfs_super_s_dev_test(struct super_block *s, struct fs_context *fc)
 {
 	return !(s->s_iflags & SB_I_RETIRED) &&
 		s->s_dev == *(dev_t *)fc->sget_key;
 }
+EXPORT_SYMBOL(vfs_super_s_dev_test);
 
 int setup_bdev_super(struct super_block *sb, int sb_flags,
 		struct fs_context *fc)
@@ -1524,7 +1526,7 @@ int get_tree_bdev(struct fs_context *fc,
 
 	fc->sb_flags |= SB_NOSEC;
 	fc->sget_key = &dev;
-	s = sget_fc(fc, test_bdev_super_fc, set_bdev_super_fc);
+	s = sget_fc(fc, vfs_super_s_dev_set, vfs_super_s_dev_test);
 	if (IS_ERR(s))
 		return PTR_ERR(s);
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index ca8ceccde3d6..fd32ae238700 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2274,6 +2274,8 @@ struct super_block *sget(struct file_system_type *type,
 			int (*test)(struct super_block *,void *),
 			int (*set)(struct super_block *,void *),
 			int flags, void *data);
+int vfs_super_s_dev_set(struct super_block *s, struct fs_context *fc);
+int vfs_super_s_dev_test(struct super_block *s, struct fs_context *fc);
 
 /* Alas, no aliases. Too much hassle with bringing module.h everywhere */
 #define fops_get(fops) \
-- 
2.34.1

From a91589157e4582182d48a5b7451c4303add26a69 Mon Sep 17 00:00:00 2001
From: Christian Brauner <brauner@kernel.org>
Date: Tue, 29 Aug 2023 14:58:33 +0200
Subject: [PATCH 2/2] mtd: key superblock by device number

The mtd driver has similar problems than the one that was fixed in
commit dc3216b14160 ("super: ensure valid info").

The kill_mtd_super() helper calls shuts the superblock down but leaves
the superblock on fs_supers as the devices are still in use but puts the
mtd device and cleans out the superblock's s_mtd field.

This means another mounter can find the superblock on the list accessing
its s_mtd field while it is curently in the process of being freed or
already freed.

Prevent that from happening by keying superblock by dev_t just as we do
in the generic code.

Link: https://lore.kernel.org/linux-fsdevel/20230829-weitab-lauwarm-49c40fc85863@brauner
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/mtd/mtdsuper.c | 47 ++++++++++++------------------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index 5ff001140ef4..29870a375743 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -19,38 +19,6 @@
 #include <linux/fs_context.h>
 #include "mtdcore.h"
 
-/*
- * compare superblocks to see if they're equivalent
- * - they are if the underlying MTD device is the same
- */
-static int mtd_test_super(struct super_block *sb, struct fs_context *fc)
-{
-	struct mtd_info *mtd = fc->sget_key;
-
-	if (sb->s_mtd == fc->sget_key) {
-		pr_debug("MTDSB: Match on device %d (\"%s\")\n",
-			 mtd->index, mtd->name);
-		return 1;
-	}
-
-	pr_debug("MTDSB: No match, device %d (\"%s\"), device %d (\"%s\")\n",
-		 sb->s_mtd->index, sb->s_mtd->name, mtd->index, mtd->name);
-	return 0;
-}
-
-/*
- * mark the superblock by the MTD device it is using
- * - set the device number to be the correct MTD block device for pesuperstence
- *   of NFS exports
- */
-static int mtd_set_super(struct super_block *sb, struct fs_context *fc)
-{
-	sb->s_mtd = fc->sget_key;
-	sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, sb->s_mtd->index);
-	sb->s_bdi = bdi_get(mtd_bdi);
-	return 0;
-}
-
 /*
  * get a superblock on an MTD-backed filesystem
  */
@@ -61,9 +29,10 @@ static int mtd_get_sb(struct fs_context *fc,
 {
 	struct super_block *sb;
 	int ret;
+	dev_t dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);
 
-	fc->sget_key = mtd;
-	sb = sget_fc(fc, mtd_test_super, mtd_set_super);
+	fc->sget_key = &dev;
+	sb = sget_fc(fc, vfs_super_s_dev_test, vfs_super_s_dev_set);
 	if (IS_ERR(sb))
 		return PTR_ERR(sb);
 
@@ -77,6 +46,16 @@ static int mtd_get_sb(struct fs_context *fc,
 		pr_debug("MTDSB: New superblock for device %d (\"%s\")\n",
 			 mtd->index, mtd->name);
 
+		/*
+		 * Would usually have been set with @sb_lock held but in
+		 * contrast to sb->s_bdev that's checked with only
+		 * @sb_lock held, nothing checks sb->s_mtd without also
+		 * holding sb->s_umount and we're holding sb->s_umount
+		 * here.
+		 */
+		sb->s_mtd = mtd;
+		sb->s_bdi = bdi_get(mtd_bdi);
+
 		ret = fill_super(sb, fc);
 		if (ret < 0)
 			goto error_sb;
-- 
2.34.1


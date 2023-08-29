Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CDA78C38F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Aug 2023 13:47:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjH2Lqw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Aug 2023 07:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjH2Lq2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Aug 2023 07:46:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B5E11B
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 04:46:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 208BE60AF7
        for <linux-fsdevel@vger.kernel.org>; Tue, 29 Aug 2023 11:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FC2DC433C8;
        Tue, 29 Aug 2023 11:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693309584;
        bh=0DanF8gk+k8DCNqTYmzjITXga3C/BAgi1e9X/iezLoA=;
        h=Date:From:To:Cc:Subject:From;
        b=OCyAgFGHyODpW5Bopo+FzNNRP1Tm7QYsIQW9/XwcL317LBUvIkc1sSLQYcH3kSitL
         k49zqTqKvkh4IinosvAlnj/759OQ15i4IgA5o2GuDyTyPp4Mx05XxLosQrwwlCktCV
         NTT6B74AqU07LNVADYTMB8bcLKzognzM77NfFYODAu1mUNOv+tNYTBUjVxA14YV0/8
         a/8dOnAZGPF4/6IT/xlp1AnLN4m3RQj9tBjb/mDoKMkAhn+flQs4GEBI8xmynU2D04
         hFrlOtt+OhFULOGFh0zNgOoThIm2487X7fezoKzhRnsZYB9qwz76mrbYHPgRnBSQWM
         jhFf/Htu55kew==
Date:   Tue, 29 Aug 2023 13:46:20 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Cc:     linux-fsdevel@vger.kernel.org
Subject: mtd
Message-ID: <20230829-weitab-lauwarm-49c40fc85863@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I just looked through every single kill_sb once more with an eye
specifically on the bug we just fixed. While doing so I realized that
mtd devices are borked. Taking jffs2 as an example we have:

static void jffs2_kill_sb(struct super_block *sb)
{
        struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
        if (c && !sb_rdonly(sb))
                jffs2_stop_garbage_collect_thread(c);
        kill_mtd_super(sb);
        kfree(c);
}

kill_mtd_super() calls generic_shutdown_super() which shuts the sb down
but leaves the superblock on fs_supers - which is what we want as the
devices are still in use. But then afterwards it puts the mtd device and
cleans out sb->s_mtd:

void kill_mtd_super(struct super_block *sb)
{
        generic_shutdown_super(sb);
        put_mtd_device(sb->s_mtd);
        sb->s_mtd = NULL;
}

But as you can see in

static int mtd_get_sb()
{
         fc->sget_key = mtd;
         sb = sget_fc(fc, mtd_test_super, mtd_set_super);
}

static int mtd_test_super(struct super_block *sb, struct fs_context *fc)
{
        struct mtd_info *mtd = fc->sget_key;

        if (sb->s_mtd == fc->sget_key) {
                pr_debug("MTDSB: Match on device %d (\"%s\")\n",
                         mtd->index, mtd->name);
                return 1;
        }

        pr_debug("MTDSB: No match, device %d (\"%s\"), device %d (\"%s\")\n",
                 sb->s_mtd->index, sb->s_mtd->name, mtd->index, mtd->name);
        return 0;
}

it can UAF if s_mtd is freed during put_mtd_device(). Yes, there's also
a data race but that's not that problematic.

Of course, the simple hotfix is to notify from kill_mtd_super() and
fixup cramfs and romfs but the proper fix is to do what we did for
get_tree_bdev() and friends and key mtd devices by dev_t. The patch
should be fairly small, I think.

Anyone has cycles to tackle this or should I try?

Something like the following might already be enough (IT'S A DRAFT, AND
UNTESTED, AND PROBABLY BROKEN)?

diff --git a/drivers/mtd/mtdsuper.c b/drivers/mtd/mtdsuper.c
index 5ff001140ef4..992a65d4b90b 100644
--- a/drivers/mtd/mtdsuper.c
+++ b/drivers/mtd/mtdsuper.c
@@ -25,16 +25,15 @@
  */
 static int mtd_test_super(struct super_block *sb, struct fs_context *fc)
 {
-       struct mtd_info *mtd = fc->sget_key;
+       dev_t dev = *(dev_t *)fc->sget_key;

-       if (sb->s_mtd == fc->sget_key) {
-               pr_debug("MTDSB: Match on device %d (\"%s\")\n",
-                        mtd->index, mtd->name);
+       if (sb->s_dev == dev) {
+               pr_debug("MTDSB: Match on device %d\n", MINOR(sb->s_dev));
                return 1;
        }

-       pr_debug("MTDSB: No match, device %d (\"%s\"), device %d (\"%s\")\n",
-                sb->s_mtd->index, sb->s_mtd->name, mtd->index, mtd->name);
+       pr_debug("MTDSB: No match, device %d, device %d\n",
+                MINOR(sb->s_dev), MINOR(dev));
        return 0;
 }

@@ -45,9 +44,7 @@ static int mtd_test_super(struct super_block *sb, struct fs_context *fc)
  */
 static int mtd_set_super(struct super_block *sb, struct fs_context *fc)
 {
-       sb->s_mtd = fc->sget_key;
        sb->s_dev = MKDEV(MTD_BLOCK_MAJOR, sb->s_mtd->index);
-       sb->s_bdi = bdi_get(mtd_bdi);
        return 0;
 }

@@ -61,8 +58,9 @@ static int mtd_get_sb(struct fs_context *fc,
 {
        struct super_block *sb;
        int ret;
+       dev_t dev = MKDEV(MTD_BLOCK_MAJOR, mtd->index);

-       fc->sget_key = mtd;
+       fc->sget_key = &dev;
        sb = sget_fc(fc, mtd_test_super, mtd_set_super);
        if (IS_ERR(sb))
                return PTR_ERR(sb);
@@ -77,6 +75,16 @@ static int mtd_get_sb(struct fs_context *fc,
                pr_debug("MTDSB: New superblock for device %d (\"%s\")\n",
                         mtd->index, mtd->name);

+               /*
+                * Would usually have been set with @sb_lock held but in
+                * contrast to sb->s_bdev that's checked in e.g.,
+                * get_active_super() with only @sb_lock held, nothing seems to
+                * check sb->s_mtd without also holding sb->s_umount and we're
+                * holding sb->s_umount here.
+                */
+               sb->s_mtd = mtd;
+               sb->s_bdi = bdi_get(mtd_bdi);
+
                ret = fill_super(sb, fc);
                if (ret < 0)
                        goto error_sb;

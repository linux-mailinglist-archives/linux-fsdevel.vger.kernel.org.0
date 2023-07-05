Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21AF748CE2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Jul 2023 21:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbjGETEo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Jul 2023 15:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233508AbjGETD6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:03:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EA211FDC;
        Wed,  5 Jul 2023 12:03:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DACE7616F9;
        Wed,  5 Jul 2023 19:03:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE0CC433CA;
        Wed,  5 Jul 2023 19:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688583818;
        bh=IFjY2ZG1/G67P/89fD6mRVOfDYWsWXSwb+QK0dFqNJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kyPlfPUq+2nOnWMrdZof8wN2AB7vG7VWbFXzPh3rce7JWRwzaQLXNUwnECAgz3Gu2
         LM3FOB/jGtRhMqyLhHiCieTjP9F16SQTqdWmJReFJGWpn4CgQFKbJbhJm1MB9T+il6
         XMs3Qmdg93yJiavrPH9nySnCk9SB4gh4SS3o1sJOcwWJJldu+0MLoegHErmfNjtH7n
         wOf2f3Lm1wFJ+hfjji3JxmGPmOR5Fty+NLh2V1Zae6s8u3dbCBzJ2e5q4ADXwAsiWA
         kZqgcLlgB3MeVC+MPpJw6pvEEiAD3hPyBMbEsHlFfsbHVL9a/ETvT3ehQLhEnWTmiA
         SzodEM1TJAHCg==
From:   Jeff Layton <jlayton@kernel.org>
To:     Christian Brauner <brauner@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 20/92] usb: convert to ctime accessor functions
Date:   Wed,  5 Jul 2023 15:00:45 -0400
Message-ID: <20230705190309.579783-18-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705190309.579783-1-jlayton@kernel.org>
References: <20230705185755.579053-1-jlayton@kernel.org>
 <20230705190309.579783-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In later patches, we're going to change how the inode's ctime field is
used. Switch to using accessor functions instead of raw accesses of
inode->i_ctime.

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/usb/core/devio.c           | 16 ++++++++--------
 drivers/usb/gadget/function/f_fs.c |  3 +--
 drivers/usb/gadget/legacy/inode.c  |  3 +--
 3 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 1a16a8bdea60..4f68f6ef3cc1 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2642,21 +2642,21 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CONTROL\n", __func__);
 		ret = proc_control(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_set_ctime_current(inode);
 		break;
 
 	case USBDEVFS_BULK:
 		snoop(&dev->dev, "%s: BULK\n", __func__);
 		ret = proc_bulk(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_set_ctime_current(inode);
 		break;
 
 	case USBDEVFS_RESETEP:
 		snoop(&dev->dev, "%s: RESETEP\n", __func__);
 		ret = proc_resetep(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_set_ctime_current(inode);
 		break;
 
 	case USBDEVFS_RESET:
@@ -2668,7 +2668,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CLEAR_HALT\n", __func__);
 		ret = proc_clearhalt(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_set_ctime_current(inode);
 		break;
 
 	case USBDEVFS_GETDRIVER:
@@ -2695,7 +2695,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: SUBMITURB\n", __func__);
 		ret = proc_submiturb(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_set_ctime_current(inode);
 		break;
 
 #ifdef CONFIG_COMPAT
@@ -2703,14 +2703,14 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CONTROL32\n", __func__);
 		ret = proc_control_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_set_ctime_current(inode);
 		break;
 
 	case USBDEVFS_BULK32:
 		snoop(&dev->dev, "%s: BULK32\n", __func__);
 		ret = proc_bulk_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_set_ctime_current(inode);
 		break;
 
 	case USBDEVFS_DISCSIGNAL32:
@@ -2722,7 +2722,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: SUBMITURB32\n", __func__);
 		ret = proc_submiturb_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode->i_ctime = current_time(inode);
+			inode->i_mtime = inode_set_ctime_current(inode);
 		break;
 
 	case USBDEVFS_IOCTL32:
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index f41a385a5c42..6e9ef35a43a7 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1377,7 +1377,7 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
 	inode = new_inode(sb);
 
 	if (inode) {
-		struct timespec64 ts = current_time(inode);
+		struct timespec64 ts = inode_set_ctime_current(inode);
 
 		inode->i_ino	 = get_next_ino();
 		inode->i_mode    = perms->mode;
@@ -1385,7 +1385,6 @@ ffs_sb_make_inode(struct super_block *sb, void *data,
 		inode->i_gid     = perms->gid;
 		inode->i_atime   = ts;
 		inode->i_mtime   = ts;
-		inode->i_ctime   = ts;
 		inode->i_private = data;
 		if (fops)
 			inode->i_fop = fops;
diff --git a/drivers/usb/gadget/legacy/inode.c b/drivers/usb/gadget/legacy/inode.c
index 28249d0bf062..ce9e31f3d26b 100644
--- a/drivers/usb/gadget/legacy/inode.c
+++ b/drivers/usb/gadget/legacy/inode.c
@@ -1969,8 +1969,7 @@ gadgetfs_make_inode (struct super_block *sb,
 		inode->i_mode = mode;
 		inode->i_uid = make_kuid(&init_user_ns, default_uid);
 		inode->i_gid = make_kgid(&init_user_ns, default_gid);
-		inode->i_atime = inode->i_mtime = inode->i_ctime
-				= current_time(inode);
+		inode->i_atime = inode->i_mtime = inode_set_ctime_current(inode);
 		inode->i_private = data;
 		inode->i_fop = fops;
 	}
-- 
2.41.0


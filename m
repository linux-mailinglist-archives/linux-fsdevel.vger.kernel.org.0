Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFD017B8BB8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Oct 2023 20:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244594AbjJDSyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Oct 2023 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244632AbjJDSyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Oct 2023 14:54:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E354DC;
        Wed,  4 Oct 2023 11:54:02 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58CB9C433CC;
        Wed,  4 Oct 2023 18:54:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696445641;
        bh=aL1npQRaDyxdHQaKUM6htVz4FWw9EZM92Fgw5A+XXLA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lMzzUiYmge9Kq/nics+ARjGwK5zm37X+AARlUtLSvvB84nkLMgyhLoFLrqdZS2FI5
         TTKxgfHNAYt0gynJx2ek5ZMptrQWACq6lcQNDaZ0D93HlWy8gFwf7HL4TFJXvRkub5
         T33ZENW1Fad0h1irMmnfTzYogqAcFbkOaFqdd2nBqn2JJbEPzZBAZb2XzWbjpTzLtr
         6bcWEGpEeCu1RgsLF6AQ+SF1N3Jw5vUZme8hDoEMXlyMcChB+jbsqcKLjh2xCaTc06
         f+jDTaaiRn2qThPmXfI3fzj1clZ9RjHOpyZrHJ3cuTNiBuTQFZieRqlSzDqFTOVa7F
         pDLFPWpXKyLGQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linux-usb@vger.kernel.org
Subject: [PATCH v2 14/89] usb: convert to new timestamp accessors
Date:   Wed,  4 Oct 2023 14:51:59 -0400
Message-ID: <20231004185347.80880-12-jlayton@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004185347.80880-1-jlayton@kernel.org>
References: <20231004185221.80802-1-jlayton@kernel.org>
 <20231004185347.80880-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Convert to using the new inode timestamp accessor functions.

Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 drivers/usb/core/devio.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 4f68f6ef3cc1..3beb6a862e80 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -2642,21 +2642,24 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CONTROL\n", __func__);
 		ret = proc_control(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		break;
 
 	case USBDEVFS_BULK:
 		snoop(&dev->dev, "%s: BULK\n", __func__);
 		ret = proc_bulk(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		break;
 
 	case USBDEVFS_RESETEP:
 		snoop(&dev->dev, "%s: RESETEP\n", __func__);
 		ret = proc_resetep(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		break;
 
 	case USBDEVFS_RESET:
@@ -2668,7 +2671,8 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CLEAR_HALT\n", __func__);
 		ret = proc_clearhalt(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		break;
 
 	case USBDEVFS_GETDRIVER:
@@ -2695,7 +2699,8 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: SUBMITURB\n", __func__);
 		ret = proc_submiturb(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		break;
 
 #ifdef CONFIG_COMPAT
@@ -2703,14 +2708,16 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: CONTROL32\n", __func__);
 		ret = proc_control_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		break;
 
 	case USBDEVFS_BULK32:
 		snoop(&dev->dev, "%s: BULK32\n", __func__);
 		ret = proc_bulk_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		break;
 
 	case USBDEVFS_DISCSIGNAL32:
@@ -2722,7 +2729,8 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
 		snoop(&dev->dev, "%s: SUBMITURB32\n", __func__);
 		ret = proc_submiturb_compat(ps, p);
 		if (ret >= 0)
-			inode->i_mtime = inode_set_ctime_current(inode);
+			inode_set_mtime_to_ts(inode,
+					      inode_set_ctime_current(inode));
 		break;
 
 	case USBDEVFS_IOCTL32:
@@ -2804,7 +2812,7 @@ static long usbdev_do_ioctl(struct file *file, unsigned int cmd,
  done:
 	usb_unlock_device(dev);
 	if (ret >= 0)
-		inode->i_atime = current_time(inode);
+		inode_set_atime_to_ts(inode, current_time(inode));
 	return ret;
 }
 
-- 
2.41.0


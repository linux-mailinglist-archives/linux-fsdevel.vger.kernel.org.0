Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40A161E71A3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728831AbgE2Af3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728820AbgE2AfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:35:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69000C08C5CB;
        Thu, 28 May 2020 17:35:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSzR-00HFRU-Vs; Fri, 29 May 2020 00:35:14 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 09/10] comedi: do_cmd_ioctl(): lift copyin/copyout into the caller
Date:   Fri, 29 May 2020 01:35:12 +0100
Message-Id: <20200529003512.4110852-9-viro@ZenIV.linux.org.uk>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
References: <20200529003419.GX23230@ZenIV.linux.org.uk>
 <20200529003512.4110852-1-viro@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/comedi/comedi_fops.c | 48 ++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index a40a865ed45c..f5ecfbfcdaf5 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1741,9 +1741,8 @@ static int __comedi_get_user_chanlist(struct comedi_device *dev,
  *	possibly modified comedi_cmd structure (when -EAGAIN returned)
  */
 static int do_cmd_ioctl(struct comedi_device *dev,
-			struct comedi_cmd __user *arg, void *file)
+			struct comedi_cmd *cmd, bool *copy, void *file)
 {
-	struct comedi_cmd cmd;
 	struct comedi_subdevice *s;
 	struct comedi_async *async;
 	unsigned int __user *user_chanlist;
@@ -1751,20 +1750,15 @@ static int do_cmd_ioctl(struct comedi_device *dev,
 
 	lockdep_assert_held(&dev->mutex);
 
-	if (copy_from_user(&cmd, arg, sizeof(cmd))) {
-		dev_dbg(dev->class_dev, "bad cmd address\n");
-		return -EFAULT;
-	}
-
-	/* get the user's cmd and do some simple validation */
-	ret = __comedi_get_user_cmd(dev, &cmd);
+	/* do some simple cmd validation */
+	ret = __comedi_get_user_cmd(dev, cmd);
 	if (ret)
 		return ret;
 
 	/* save user's chanlist pointer so it can be restored later */
-	user_chanlist = (unsigned int __user *)cmd.chanlist;
+	user_chanlist = (unsigned int __user *)cmd->chanlist;
 
-	s = &dev->subdevices[cmd.subdev];
+	s = &dev->subdevices[cmd->subdev];
 	async = s->async;
 
 	/* are we locked? (ioctl lock) */
@@ -1780,13 +1774,13 @@ static int do_cmd_ioctl(struct comedi_device *dev,
 	}
 
 	/* make sure channel/gain list isn't too short */
-	if (cmd.chanlist_len < 1) {
+	if (cmd->chanlist_len < 1) {
 		dev_dbg(dev->class_dev, "channel/gain list too short %u < 1\n",
-			cmd.chanlist_len);
+			cmd->chanlist_len);
 		return -EINVAL;
 	}
 
-	async->cmd = cmd;
+	async->cmd = *cmd;
 	async->cmd.data = NULL;
 
 	/* load channel/gain list */
@@ -1798,15 +1792,11 @@ static int do_cmd_ioctl(struct comedi_device *dev,
 
 	if (async->cmd.flags & CMDF_BOGUS || ret) {
 		dev_dbg(dev->class_dev, "test returned %d\n", ret);
-		cmd = async->cmd;
+		*cmd = async->cmd;
 		/* restore chanlist pointer before copying back */
-		cmd.chanlist = (unsigned int __force *)user_chanlist;
-		cmd.data = NULL;
-		if (copy_to_user(arg, &cmd, sizeof(cmd))) {
-			dev_dbg(dev->class_dev, "fault writing cmd\n");
-			ret = -EFAULT;
-			goto cleanup;
-		}
+		cmd->chanlist = (unsigned int __force *)user_chanlist;
+		cmd->data = NULL;
+		*copy = true;
 		ret = -EAGAIN;
 		goto cleanup;
 	}
@@ -2207,9 +2197,19 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 	case COMEDI_CANCEL:
 		rc = do_cancel_ioctl(dev, arg, file);
 		break;
-	case COMEDI_CMD:
-		rc = do_cmd_ioctl(dev, (struct comedi_cmd __user *)arg, file);
+	case COMEDI_CMD: {
+		struct comedi_cmd cmd;
+		bool copy = false;
+
+		if (copy_from_user(&cmd, (void __user *)arg, sizeof(cmd))) {
+			rc = -EFAULT;
+			break;
+		}
+		rc = do_cmd_ioctl(dev, &cmd, &copy, file);
+		if (copy && copy_to_user((void __user *)arg, &cmd, sizeof(cmd)))
+			rc = -EFAULT;
 		break;
+	}
 	case COMEDI_CMDTEST: {
 		struct comedi_cmd cmd;
 		bool copy = false;
-- 
2.11.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 064AF1E719B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438057AbgE2Afa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728818AbgE2AfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:35:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6174AC08C5C6;
        Thu, 28 May 2020 17:35:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSzR-00HFRO-TQ; Fri, 29 May 2020 00:35:13 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 08/10] comedi: do_cmdtest_ioctl(): lift copyin/copyout into the caller
Date:   Fri, 29 May 2020 01:35:11 +0100
Message-Id: <20200529003512.4110852-8-viro@ZenIV.linux.org.uk>
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
 drivers/staging/comedi/comedi_fops.c | 45 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 23 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index e85a143057a1..a40a865ed45c 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1856,49 +1856,39 @@ static int do_cmd_ioctl(struct comedi_device *dev,
  *	possibly modified comedi_cmd structure
  */
 static int do_cmdtest_ioctl(struct comedi_device *dev,
-			    struct comedi_cmd __user *arg, void *file)
+			    struct comedi_cmd *cmd, bool *copy, void *file)
 {
-	struct comedi_cmd cmd;
 	struct comedi_subdevice *s;
 	unsigned int __user *user_chanlist;
 	int ret;
 
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
 
 	/* user_chanlist can be NULL for COMEDI_CMDTEST ioctl */
 	if (user_chanlist) {
 		/* load channel/gain list */
-		ret = __comedi_get_user_chanlist(dev, s, user_chanlist, &cmd);
+		ret = __comedi_get_user_chanlist(dev, s, user_chanlist, cmd);
 		if (ret)
 			return ret;
 	}
 
-	ret = s->do_cmdtest(dev, s, &cmd);
+	ret = s->do_cmdtest(dev, s, cmd);
 
-	kfree(cmd.chanlist);	/* free kernel copy of user chanlist */
+	kfree(cmd->chanlist);	/* free kernel copy of user chanlist */
 
 	/* restore chanlist pointer before copying back */
-	cmd.chanlist = (unsigned int __force *)user_chanlist;
-
-	if (copy_to_user(arg, &cmd, sizeof(cmd))) {
-		dev_dbg(dev->class_dev, "bad cmd address\n");
-		ret = -EFAULT;
-	}
+	cmd->chanlist = (unsigned int __force *)user_chanlist;
+	*copy = true;
 
 	return ret;
 }
@@ -2220,10 +2210,19 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 	case COMEDI_CMD:
 		rc = do_cmd_ioctl(dev, (struct comedi_cmd __user *)arg, file);
 		break;
-	case COMEDI_CMDTEST:
-		rc = do_cmdtest_ioctl(dev, (struct comedi_cmd __user *)arg,
-				      file);
+	case COMEDI_CMDTEST: {
+		struct comedi_cmd cmd;
+		bool copy = false;
+
+		if (copy_from_user(&cmd, (void __user *)arg, sizeof(cmd))) {
+			rc = -EFAULT;
+			break;
+		}
+		rc = do_cmdtest_ioctl(dev, &cmd, &copy, file);
+		if (copy && copy_to_user((void __user *)arg, &cmd, sizeof(cmd)))
+			rc = -EFAULT;
 		break;
+	}
 	case COMEDI_INSNLIST: {
 		struct comedi_insnlist insnlist;
 		struct comedi_insn *insns = NULL;
-- 
2.11.0


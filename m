Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0ED31E7FF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 16:16:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbgE2OQK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 10:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgE2OQK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 10:16:10 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39932C03E969;
        Fri, 29 May 2020 07:16:09 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jefnf-00HZzJ-1U; Fri, 29 May 2020 14:15:55 +0000
Date:   Fri, 29 May 2020 15:15:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ian Abbott <abbotti@mev.co.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHES] uaccess comedi compat
Message-ID: <20200529141555.GC23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529003419.GX23230@ZenIV.linux.org.uk>
 <b18a9407-8124-ff94-8c9b-333a32e0a137@mev.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b18a9407-8124-ff94-8c9b-333a32e0a137@mev.co.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 11:48:51AM +0100, Ian Abbott wrote:

> > Al Viro (10):
> >        comedi: move compat ioctl handling to native fops
> >        comedi: get rid of indirection via translated_ioctl()
> >        comedi: get rid of compat_alloc_user_space() mess in COMEDI_CHANINFO compat
> >        comedi: get rid of compat_alloc_user_space() mess in COMEDI_RANGEINFO compat
> >        comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSN compat
> >        comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSNLIST compat
> >        comedi: lift copy_from_user() into callers of __comedi_get_user_cmd()
> >        comedi: do_cmdtest_ioctl(): lift copyin/copyout into the caller
> >        comedi: do_cmd_ioctl(): lift copyin/copyout into the caller
> >        comedi: get rid of compat_alloc_user_space() mess in COMEDI_CMD{,TEST} compat
> 
> There is a bug in patch 05. Patch 10 doesn't seem to have been sent yet (I
> didn't receive it and I can't see it in the thread in the LKML archives).
> I've signed off on 01-04, 06-09.

#5 fixed, force-pushed to the same branch.  As for s-o-b... are you sure that's
the header you have in mind?  Normally it's for the chain of transmission...

Do you offer to take that series through comedi (or staging, or...) git tree?
In that case s-o-b would make sense and I'd be happy to have it taken off
my hands.  Otherwise it probably should be Acked-by: or Reviewed-by: or
Read-through-and-managed-not-to-throw-up: - up to you...

> These should be Cc'd to Greg KH and to devel@driverdev.osuosl.org.

FWIW, 10/10 seems to have been really lost; follows here:

From 88833127a8f00da422ddef03425ad9b19eb65558 Mon Sep 17 00:00:00 2001
From: Al Viro <viro@zeniv.linux.org.uk>
Date: Sun, 26 Apr 2020 09:27:23 -0400
Subject: [PATCH 10/10] comedi: get rid of compat_alloc_user_space() mess in
 COMEDI_CMD{,TEST} compat

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/comedi/comedi_fops.c | 181 +++++++++++++----------------------
 1 file changed, 66 insertions(+), 115 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index f5ecfbfcdaf5..bcdb059e6bb6 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2930,155 +2930,106 @@ static int compat_rangeinfo(struct file *file, unsigned long arg)
 }
 
 /* Copy 32-bit cmd structure to native cmd structure. */
-static int get_compat_cmd(struct comedi_cmd __user *cmd,
+static int get_compat_cmd(struct comedi_cmd *cmd,
 			  struct comedi32_cmd_struct __user *cmd32)
 {
-	int err;
-	union {
-		unsigned int uint;
-		compat_uptr_t uptr;
-	} temp;
-
-	/* Copy cmd structure. */
-	if (!access_ok(cmd32, sizeof(*cmd32)) ||
-	    !access_ok(cmd, sizeof(*cmd)))
+	struct comedi32_cmd_struct v32;
+
+	if (copy_from_user(&v32, cmd32, sizeof(v32)))
 		return -EFAULT;
 
-	err = 0;
-	err |= __get_user(temp.uint, &cmd32->subdev);
-	err |= __put_user(temp.uint, &cmd->subdev);
-	err |= __get_user(temp.uint, &cmd32->flags);
-	err |= __put_user(temp.uint, &cmd->flags);
-	err |= __get_user(temp.uint, &cmd32->start_src);
-	err |= __put_user(temp.uint, &cmd->start_src);
-	err |= __get_user(temp.uint, &cmd32->start_arg);
-	err |= __put_user(temp.uint, &cmd->start_arg);
-	err |= __get_user(temp.uint, &cmd32->scan_begin_src);
-	err |= __put_user(temp.uint, &cmd->scan_begin_src);
-	err |= __get_user(temp.uint, &cmd32->scan_begin_arg);
-	err |= __put_user(temp.uint, &cmd->scan_begin_arg);
-	err |= __get_user(temp.uint, &cmd32->convert_src);
-	err |= __put_user(temp.uint, &cmd->convert_src);
-	err |= __get_user(temp.uint, &cmd32->convert_arg);
-	err |= __put_user(temp.uint, &cmd->convert_arg);
-	err |= __get_user(temp.uint, &cmd32->scan_end_src);
-	err |= __put_user(temp.uint, &cmd->scan_end_src);
-	err |= __get_user(temp.uint, &cmd32->scan_end_arg);
-	err |= __put_user(temp.uint, &cmd->scan_end_arg);
-	err |= __get_user(temp.uint, &cmd32->stop_src);
-	err |= __put_user(temp.uint, &cmd->stop_src);
-	err |= __get_user(temp.uint, &cmd32->stop_arg);
-	err |= __put_user(temp.uint, &cmd->stop_arg);
-	err |= __get_user(temp.uptr, &cmd32->chanlist);
-	err |= __put_user((unsigned int __force *)compat_ptr(temp.uptr),
-			  &cmd->chanlist);
-	err |= __get_user(temp.uint, &cmd32->chanlist_len);
-	err |= __put_user(temp.uint, &cmd->chanlist_len);
-	err |= __get_user(temp.uptr, &cmd32->data);
-	err |= __put_user(compat_ptr(temp.uptr), &cmd->data);
-	err |= __get_user(temp.uint, &cmd32->data_len);
-	err |= __put_user(temp.uint, &cmd->data_len);
-	return err ? -EFAULT : 0;
+	cmd->subdev = v32.subdev;
+	cmd->flags = v32.flags;
+	cmd->start_src = v32.start_src;
+	cmd->start_arg = v32.start_arg;
+	cmd->scan_begin_src = v32.scan_begin_src;
+	cmd->scan_begin_arg = v32.scan_begin_arg;
+	cmd->convert_src = v32.convert_src;
+	cmd->convert_arg = v32.convert_arg;
+	cmd->scan_end_src = v32.scan_end_src;
+	cmd->scan_end_arg = v32.scan_end_arg;
+	cmd->stop_src = v32.stop_src;
+	cmd->stop_arg = v32.stop_arg;
+	cmd->chanlist = compat_ptr(v32.chanlist);
+	cmd->chanlist_len = v32.chanlist_len;
+	cmd->data = compat_ptr(v32.data);
+	cmd->data_len = v32.data_len;
+	return 0;
 }
 
 /* Copy native cmd structure to 32-bit cmd structure. */
 static int put_compat_cmd(struct comedi32_cmd_struct __user *cmd32,
-			  struct comedi_cmd __user *cmd)
-{
-	int err;
-	unsigned int temp;
-
-	/*
-	 * Copy back most of cmd structure.
-	 *
-	 * Assume the pointer values are already valid.
-	 * (Could use ptr_to_compat() to set them.)
-	 */
-	if (!access_ok(cmd, sizeof(*cmd)) ||
-	    !access_ok(cmd32, sizeof(*cmd32)))
-		return -EFAULT;
-
-	err = 0;
-	err |= __get_user(temp, &cmd->subdev);
-	err |= __put_user(temp, &cmd32->subdev);
-	err |= __get_user(temp, &cmd->flags);
-	err |= __put_user(temp, &cmd32->flags);
-	err |= __get_user(temp, &cmd->start_src);
-	err |= __put_user(temp, &cmd32->start_src);
-	err |= __get_user(temp, &cmd->start_arg);
-	err |= __put_user(temp, &cmd32->start_arg);
-	err |= __get_user(temp, &cmd->scan_begin_src);
-	err |= __put_user(temp, &cmd32->scan_begin_src);
-	err |= __get_user(temp, &cmd->scan_begin_arg);
-	err |= __put_user(temp, &cmd32->scan_begin_arg);
-	err |= __get_user(temp, &cmd->convert_src);
-	err |= __put_user(temp, &cmd32->convert_src);
-	err |= __get_user(temp, &cmd->convert_arg);
-	err |= __put_user(temp, &cmd32->convert_arg);
-	err |= __get_user(temp, &cmd->scan_end_src);
-	err |= __put_user(temp, &cmd32->scan_end_src);
-	err |= __get_user(temp, &cmd->scan_end_arg);
-	err |= __put_user(temp, &cmd32->scan_end_arg);
-	err |= __get_user(temp, &cmd->stop_src);
-	err |= __put_user(temp, &cmd32->stop_src);
-	err |= __get_user(temp, &cmd->stop_arg);
-	err |= __put_user(temp, &cmd32->stop_arg);
+			  struct comedi_cmd *cmd)
+{
+	struct comedi32_cmd_struct v32;
+
+	memset(&v32, 0, sizeof(v32));
+	v32.subdev = cmd->subdev;
+	v32.flags = cmd->flags;
+	v32.start_src = cmd->start_src;
+	v32.start_arg = cmd->start_arg;
+	v32.scan_begin_src = cmd->scan_begin_src;
+	v32.scan_begin_arg = cmd->scan_begin_arg;
+	v32.convert_src = cmd->convert_src;
+	v32.convert_arg = cmd->convert_arg;
+	v32.scan_end_src = cmd->scan_end_src;
+	v32.scan_end_arg = cmd->scan_end_arg;
+	v32.stop_src = cmd->stop_src;
+	v32.stop_arg = cmd->stop_arg;
 	/* Assume chanlist pointer is unchanged. */
-	err |= __get_user(temp, &cmd->chanlist_len);
-	err |= __put_user(temp, &cmd32->chanlist_len);
-	/* Assume data pointer is unchanged. */
-	err |= __get_user(temp, &cmd->data_len);
-	err |= __put_user(temp, &cmd32->data_len);
-	return err ? -EFAULT : 0;
+	v32.chanlist = ptr_to_compat(cmd->chanlist);
+	v32.chanlist_len = cmd->chanlist_len;
+	v32.data = ptr_to_compat(cmd->data);
+	v32.data_len = cmd->data_len;
+	return copy_to_user(cmd32, &v32, sizeof(v32));
 }
 
 /* Handle 32-bit COMEDI_CMD ioctl. */
 static int compat_cmd(struct file *file, unsigned long arg)
 {
-	struct comedi_cmd __user *cmd;
-	struct comedi32_cmd_struct __user *cmd32;
+	struct comedi_file *cfp = file->private_data;
+	struct comedi_device *dev = cfp->dev;
+	struct comedi_cmd cmd;
+	bool copy = false;
 	int rc, err;
 
-	cmd32 = compat_ptr(arg);
-	cmd = compat_alloc_user_space(sizeof(*cmd));
-
-	rc = get_compat_cmd(cmd, cmd32);
+	rc = get_compat_cmd(&cmd, compat_ptr(arg));
 	if (rc)
 		return rc;
 
-	rc = comedi_unlocked_ioctl(file, COMEDI_CMD, (unsigned long)cmd);
-	if (rc == -EAGAIN) {
+	mutex_lock(&dev->mutex);
+	rc = do_cmd_ioctl(dev, &cmd, &copy, file);
+	mutex_unlock(&dev->mutex);
+	if (copy) {
 		/* Special case: copy cmd back to user. */
-		err = put_compat_cmd(cmd32, cmd);
+		err = put_compat_cmd(compat_ptr(arg), &cmd);
 		if (err)
 			rc = err;
 	}
-
 	return rc;
 }
 
 /* Handle 32-bit COMEDI_CMDTEST ioctl. */
 static int compat_cmdtest(struct file *file, unsigned long arg)
 {
-	struct comedi_cmd __user *cmd;
-	struct comedi32_cmd_struct __user *cmd32;
+	struct comedi_file *cfp = file->private_data;
+	struct comedi_device *dev = cfp->dev;
+	struct comedi_cmd cmd;
+	bool copy = false;
 	int rc, err;
 
-	cmd32 = compat_ptr(arg);
-	cmd = compat_alloc_user_space(sizeof(*cmd));
-
-	rc = get_compat_cmd(cmd, cmd32);
+	rc = get_compat_cmd(&cmd, compat_ptr(arg));
 	if (rc)
 		return rc;
 
-	rc = comedi_unlocked_ioctl(file, COMEDI_CMDTEST, (unsigned long)cmd);
-	if (rc < 0)
-		return rc;
-
-	err = put_compat_cmd(cmd32, cmd);
-	if (err)
-		rc = err;
-
+	mutex_lock(&dev->mutex);
+	rc = do_cmdtest_ioctl(dev, &cmd, &copy, file);
+	mutex_unlock(&dev->mutex);
+	if (copy) {
+		err = put_compat_cmd(compat_ptr(arg), &cmd);
+		if (err)
+			rc = err;
+	}
 	return rc;
 }
 
-- 
2.11.0


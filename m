Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92EDA1E71A6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438155AbgE2Afo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728813AbgE2AfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:35:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F9EC08C5C7;
        Thu, 28 May 2020 17:35:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSzR-00HFQt-7L; Fri, 29 May 2020 00:35:13 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 03/10] comedi: get rid of compat_alloc_user_space() mess in COMEDI_CHANINFO compat
Date:   Fri, 29 May 2020 01:35:06 +0100
Message-Id: <20200529003512.4110852-3-viro@ZenIV.linux.org.uk>
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

Just take copy_from_user() out of do_chaninfo_ioctl() into the caller and
have compat_chaninfo() build a native version and pass it to do_chaninfo_ioctl()
directly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/comedi/comedi_fops.c | 68 ++++++++++++++++--------------------
 1 file changed, 30 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index ecd29f28673c..ab811735cd1b 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1049,31 +1049,28 @@ static int do_subdinfo_ioctl(struct comedi_device *dev,
  *	array of range table lengths to chaninfo->range_table_list if requested
  */
 static int do_chaninfo_ioctl(struct comedi_device *dev,
-			     struct comedi_chaninfo __user *arg)
+			     struct comedi_chaninfo *it)
 {
 	struct comedi_subdevice *s;
-	struct comedi_chaninfo it;
 
 	lockdep_assert_held(&dev->mutex);
-	if (copy_from_user(&it, arg, sizeof(it)))
-		return -EFAULT;
 
-	if (it.subdev >= dev->n_subdevices)
+	if (it->subdev >= dev->n_subdevices)
 		return -EINVAL;
-	s = &dev->subdevices[it.subdev];
+	s = &dev->subdevices[it->subdev];
 
-	if (it.maxdata_list) {
+	if (it->maxdata_list) {
 		if (s->maxdata || !s->maxdata_list)
 			return -EINVAL;
-		if (copy_to_user(it.maxdata_list, s->maxdata_list,
+		if (copy_to_user(it->maxdata_list, s->maxdata_list,
 				 s->n_chan * sizeof(unsigned int)))
 			return -EFAULT;
 	}
 
-	if (it.flaglist)
+	if (it->flaglist)
 		return -EINVAL;	/* flaglist not supported */
 
-	if (it.rangelist) {
+	if (it->rangelist) {
 		int i;
 
 		if (!s->range_table_list)
@@ -1081,9 +1078,9 @@ static int do_chaninfo_ioctl(struct comedi_device *dev,
 		for (i = 0; i < s->n_chan; i++) {
 			int x;
 
-			x = (dev->minor << 28) | (it.subdev << 24) | (i << 16) |
+			x = (dev->minor << 28) | (it->subdev << 24) | (i << 16) |
 			    (s->range_table_list[i]->length);
-			if (put_user(x, it.rangelist + i))
+			if (put_user(x, it->rangelist + i))
 				return -EFAULT;
 		}
 	}
@@ -2205,9 +2202,14 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 				       (struct comedi_subdinfo __user *)arg,
 				       file);
 		break;
-	case COMEDI_CHANINFO:
-		rc = do_chaninfo_ioctl(dev, (void __user *)arg);
+	case COMEDI_CHANINFO: {
+		struct comedi_chaninfo it;
+		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
+			rc = -EFAULT;
+		else
+			rc = do_chaninfo_ioctl(dev, &it);
 		break;
+	}
 	case COMEDI_RANGEINFO:
 		rc = do_rangeinfo_ioctl(dev, (void __user *)arg);
 		break;
@@ -2874,35 +2876,25 @@ struct comedi32_insnlist_struct {
 /* Handle 32-bit COMEDI_CHANINFO ioctl. */
 static int compat_chaninfo(struct file *file, unsigned long arg)
 {
-	struct comedi_chaninfo __user *chaninfo;
-	struct comedi32_chaninfo_struct __user *chaninfo32;
+	struct comedi_file *cfp = file->private_data;
+	struct comedi_device *dev = cfp->dev;
+	struct comedi32_chaninfo_struct chaninfo32;
+	struct comedi_chaninfo chaninfo;
 	int err;
-	union {
-		unsigned int uint;
-		compat_uptr_t uptr;
-	} temp;
 
-	chaninfo32 = compat_ptr(arg);
-	chaninfo = compat_alloc_user_space(sizeof(*chaninfo));
-
-	/* Copy chaninfo structure.  Ignore unused members. */
-	if (!access_ok(chaninfo32, sizeof(*chaninfo32)) ||
-	    !access_ok(chaninfo, sizeof(*chaninfo)))
+	if (copy_from_user(&chaninfo32, compat_ptr(arg), sizeof(chaninfo32)))
 		return -EFAULT;
 
-	err = 0;
-	err |= __get_user(temp.uint, &chaninfo32->subdev);
-	err |= __put_user(temp.uint, &chaninfo->subdev);
-	err |= __get_user(temp.uptr, &chaninfo32->maxdata_list);
-	err |= __put_user(compat_ptr(temp.uptr), &chaninfo->maxdata_list);
-	err |= __get_user(temp.uptr, &chaninfo32->flaglist);
-	err |= __put_user(compat_ptr(temp.uptr), &chaninfo->flaglist);
-	err |= __get_user(temp.uptr, &chaninfo32->rangelist);
-	err |= __put_user(compat_ptr(temp.uptr), &chaninfo->rangelist);
-	if (err)
-		return -EFAULT;
+	memset(&chaninfo, 0, sizeof(chaninfo));
+	chaninfo.subdev = chaninfo32.subdev;
+	chaninfo.maxdata_list = compat_ptr(chaninfo32.maxdata_list);
+	chaninfo.flaglist = compat_ptr(chaninfo32.flaglist);
+	chaninfo.rangelist = compat_ptr(chaninfo32.rangelist);
 
-	return comedi_unlocked_ioctl(file, COMEDI_CHANINFO, (unsigned long)chaninfo);
+	mutex_lock(&dev->mutex);
+	err = do_chaninfo_ioctl(dev, &chaninfo);
+	mutex_unlock(&dev->mutex);
+	return err;
 }
 
 /* Handle 32-bit COMEDI_RANGEINFO ioctl. */
-- 
2.11.0


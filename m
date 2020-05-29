Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BABB1E71A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:36:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438159AbgE2Afo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgE2AfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:35:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 432E8C08C5C8;
        Thu, 28 May 2020 17:35:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSzR-00HFR0-Hq; Fri, 29 May 2020 00:35:13 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 04/10] comedi: get rid of compat_alloc_user_space() mess in COMEDI_RANGEINFO compat
Date:   Fri, 29 May 2020 01:35:07 +0100
Message-Id: <20200529003512.4110852-4-viro@ZenIV.linux.org.uk>
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

Just take copy_from_user() out of do_rangeing_ioctl() into the caller and
have compat_rangeinfo() build a native version and pass it to do_rangeinfo_ioctl()
directly.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/comedi/comedi_fops.c     | 43 ++++++++++++++------------------
 drivers/staging/comedi/comedi_internal.h |  2 +-
 drivers/staging/comedi/range.c           | 17 ++++++-------
 3 files changed, 27 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index ab811735cd1b..d96dc85d8a98 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2210,9 +2210,14 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 			rc = do_chaninfo_ioctl(dev, &it);
 		break;
 	}
-	case COMEDI_RANGEINFO:
-		rc = do_rangeinfo_ioctl(dev, (void __user *)arg);
+	case COMEDI_RANGEINFO: {
+		struct comedi_rangeinfo it;
+		if (copy_from_user(&it, (void __user *)arg, sizeof(it)))
+			rc = -EFAULT;
+		else
+			rc = do_rangeinfo_ioctl(dev, &it);
 		break;
+	}
 	case COMEDI_BUFINFO:
 		rc = do_bufinfo_ioctl(dev,
 				      (struct comedi_bufinfo __user *)arg,
@@ -2900,32 +2905,22 @@ static int compat_chaninfo(struct file *file, unsigned long arg)
 /* Handle 32-bit COMEDI_RANGEINFO ioctl. */
 static int compat_rangeinfo(struct file *file, unsigned long arg)
 {
-	struct comedi_rangeinfo __user *rangeinfo;
-	struct comedi32_rangeinfo_struct __user *rangeinfo32;
+	struct comedi_file *cfp = file->private_data;
+	struct comedi_device *dev = cfp->dev;
+	struct comedi32_rangeinfo_struct rangeinfo32;
+	struct comedi_rangeinfo rangeinfo;
 	int err;
-	union {
-		unsigned int uint;
-		compat_uptr_t uptr;
-	} temp;
-
-	rangeinfo32 = compat_ptr(arg);
-	rangeinfo = compat_alloc_user_space(sizeof(*rangeinfo));
 
-	/* Copy rangeinfo structure. */
-	if (!access_ok(rangeinfo32, sizeof(*rangeinfo32)) ||
-	    !access_ok(rangeinfo, sizeof(*rangeinfo)))
+	if (copy_from_user(&rangeinfo32, compat_ptr(arg), sizeof(rangeinfo32)))
 		return -EFAULT;
+	memset(&rangeinfo, 0, sizeof(rangeinfo));
+	rangeinfo.range_type = rangeinfo32.range_type;
+	rangeinfo.range_ptr = compat_ptr(rangeinfo32.range_ptr);
 
-	err = 0;
-	err |= __get_user(temp.uint, &rangeinfo32->range_type);
-	err |= __put_user(temp.uint, &rangeinfo->range_type);
-	err |= __get_user(temp.uptr, &rangeinfo32->range_ptr);
-	err |= __put_user(compat_ptr(temp.uptr), &rangeinfo->range_ptr);
-	if (err)
-		return -EFAULT;
-
-	return comedi_unlocked_ioctl(file, COMEDI_RANGEINFO,
-				(unsigned long)rangeinfo);
+	mutex_lock(&dev->mutex);
+	err = do_rangeinfo_ioctl(dev, &rangeinfo);
+	mutex_unlock(&dev->mutex);
+	return err;
 }
 
 /* Copy 32-bit cmd structure to native cmd structure. */
diff --git a/drivers/staging/comedi/comedi_internal.h b/drivers/staging/comedi/comedi_internal.h
index 515f293a5d26..7c8f18f55122 100644
--- a/drivers/staging/comedi/comedi_internal.h
+++ b/drivers/staging/comedi/comedi_internal.h
@@ -18,7 +18,7 @@ struct comedi_subdevice;
 struct device;
 
 int do_rangeinfo_ioctl(struct comedi_device *dev,
-		       struct comedi_rangeinfo __user *arg);
+		       struct comedi_rangeinfo *it);
 struct comedi_device *comedi_alloc_board_minor(struct device *hardware_device);
 void comedi_release_hardware_device(struct device *hardware_device);
 int comedi_alloc_subdevice_minor(struct comedi_subdevice *s);
diff --git a/drivers/staging/comedi/range.c b/drivers/staging/comedi/range.c
index 89d599877445..a4e6fe0fb729 100644
--- a/drivers/staging/comedi/range.c
+++ b/drivers/staging/comedi/range.c
@@ -46,17 +46,14 @@ EXPORT_SYMBOL_GPL(range_unknown);
  *	array of comedi_krange structures to rangeinfo->range_ptr pointer
  */
 int do_rangeinfo_ioctl(struct comedi_device *dev,
-		       struct comedi_rangeinfo __user *arg)
+		       struct comedi_rangeinfo *it)
 {
-	struct comedi_rangeinfo it;
 	int subd, chan;
 	const struct comedi_lrange *lr;
 	struct comedi_subdevice *s;
 
-	if (copy_from_user(&it, arg, sizeof(struct comedi_rangeinfo)))
-		return -EFAULT;
-	subd = (it.range_type >> 24) & 0xf;
-	chan = (it.range_type >> 16) & 0xff;
+	subd = (it->range_type >> 24) & 0xf;
+	chan = (it->range_type >> 16) & 0xff;
 
 	if (!dev->attached)
 		return -EINVAL;
@@ -73,15 +70,15 @@ int do_rangeinfo_ioctl(struct comedi_device *dev,
 		return -EINVAL;
 	}
 
-	if (RANGE_LENGTH(it.range_type) != lr->length) {
+	if (RANGE_LENGTH(it->range_type) != lr->length) {
 		dev_dbg(dev->class_dev,
 			"wrong length %d should be %d (0x%08x)\n",
-			RANGE_LENGTH(it.range_type),
-			lr->length, it.range_type);
+			RANGE_LENGTH(it->range_type),
+			lr->length, it->range_type);
 		return -EINVAL;
 	}
 
-	if (copy_to_user(it.range_ptr, lr->range,
+	if (copy_to_user(it->range_ptr, lr->range,
 			 sizeof(struct comedi_krange) * lr->length))
 		return -EFAULT;
 
-- 
2.11.0


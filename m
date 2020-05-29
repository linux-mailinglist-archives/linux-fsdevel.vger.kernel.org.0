Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD70B1E71A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:36:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgE2Af3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728679AbgE2AfR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:35:17 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A234CC08C5D1;
        Thu, 28 May 2020 17:35:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSzR-00HFR6-Kw; Fri, 29 May 2020 00:35:13 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 05/10] comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSN compat
Date:   Fri, 29 May 2020 01:35:08 +0100
Message-Id: <20200529003512.4110852-5-viro@ZenIV.linux.org.uk>
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

Just take copy_from_user() out of do_insn_ioctl() into the caller and
have compat_insn() build a native version and pass it to do_insn_ioctl()
directly.

One difference from the previous commits is that the helper used to
convert 32bit variant to native has two users - compat_insn() and
compat_insnlist().  The latter will be converted in next commit;
for now we simply split the helper in two variants - "userland 32bit
to kernel native" and "userland 32bit to userland native".  The latter
is renamed old get_compat_insn(); it will be gone in the next commit.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 drivers/staging/comedi/comedi_fops.c | 73 +++++++++++++++++++++++-------------
 1 file changed, 46 insertions(+), 27 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index d96dc85d8a98..ae0067ab5ead 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1615,22 +1615,19 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
  *	data (for reads) to insn->data pointer
  */
 static int do_insn_ioctl(struct comedi_device *dev,
-			 struct comedi_insn __user *arg, void *file)
+			 struct comedi_insn *insn, void *file)
 {
-	struct comedi_insn insn;
 	unsigned int *data = NULL;
 	unsigned int n_data = MIN_SAMPLES;
 	int ret = 0;
 
 	lockdep_assert_held(&dev->mutex);
-	if (copy_from_user(&insn, arg, sizeof(insn)))
-		return -EFAULT;
 
-	n_data = max(n_data, insn.n);
+	n_data = max(n_data, insn->n);
 
 	/* This is where the behavior of insn and insnlist deviate. */
-	if (insn.n > MAX_SAMPLES) {
-		insn.n = MAX_SAMPLES;
+	if (insn->n > MAX_SAMPLES) {
+		insn->n = MAX_SAMPLES;
 		n_data = MAX_SAMPLES;
 	}
 
@@ -1640,26 +1637,26 @@ static int do_insn_ioctl(struct comedi_device *dev,
 		goto error;
 	}
 
-	if (insn.insn & INSN_MASK_WRITE) {
+	if (insn->insn & INSN_MASK_WRITE) {
 		if (copy_from_user(data,
-				   insn.data,
-				   insn.n * sizeof(unsigned int))) {
+				   insn->data,
+				   insn->n * sizeof(unsigned int))) {
 			ret = -EFAULT;
 			goto error;
 		}
 	}
-	ret = parse_insn(dev, &insn, data, file);
+	ret = parse_insn(dev, insn, data, file);
 	if (ret < 0)
 		goto error;
-	if (insn.insn & INSN_MASK_READ) {
-		if (copy_to_user(insn.data,
+	if (insn->insn & INSN_MASK_READ) {
+		if (copy_to_user(insn->data,
 				 data,
-				 insn.n * sizeof(unsigned int))) {
+				 insn->n * sizeof(unsigned int))) {
 			ret = -EFAULT;
 			goto error;
 		}
 	}
-	ret = insn.n;
+	ret = insn->n;
 
 error:
 	kfree(data);
@@ -2244,10 +2241,13 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 				       (struct comedi_insnlist __user *)arg,
 				       file);
 		break;
-	case COMEDI_INSN:
-		rc = do_insn_ioctl(dev, (struct comedi_insn __user *)arg,
-				   file);
+	case COMEDI_INSN: {
+		struct comedi_insn insn;
+		if (copy_from_user(&insn, (void __user *)arg, sizeof(insn)))
+			rc = -EFAULT;
+		rc = do_insn_ioctl(dev, &insn, file);
 		break;
+	}
 	case COMEDI_POLL:
 		rc = do_poll_ioctl(dev, arg, file);
 		break;
@@ -3077,7 +3077,25 @@ static int compat_cmdtest(struct file *file, unsigned long arg)
 }
 
 /* Copy 32-bit insn structure to native insn structure. */
-static int get_compat_insn(struct comedi_insn __user *insn,
+static int get_compat_insn(struct comedi_insn *insn,
+			   struct comedi32_insn_struct __user *insn32)
+{
+	struct comedi32_insn_struct v32;
+
+	/* Copy insn structure.  Ignore the unused members. */
+	if (copy_from_user(&v32, insn32, sizeof(v32)))
+		return -EFAULT;
+	memset(insn, 0, sizeof(*insn));
+	insn->insn = v32.insn;
+	insn->n = v32.n;
+	insn->data = compat_ptr(v32.data);
+	insn->subdev = v32.subdev;
+	insn->chanspec = v32.chanspec;
+	return 0;
+}
+
+/* Copy 32-bit insn structure to native insn structure. */
+static int __get_compat_insn(struct comedi_insn __user *insn,
 			   struct comedi32_insn_struct __user *insn32)
 {
 	int err;
@@ -3146,7 +3164,7 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 
 	/* Copy insn structures. */
 	for (n = 0; n < n_insns; n++) {
-		rc = get_compat_insn(&s->insn[n], &insn32[n]);
+		rc = __get_compat_insn(&s->insn[n], &insn32[n]);
 		if (rc)
 			return rc;
 	}
@@ -3158,18 +3176,19 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 /* Handle 32-bit COMEDI_INSN ioctl. */
 static int compat_insn(struct file *file, unsigned long arg)
 {
-	struct comedi_insn __user *insn;
-	struct comedi32_insn_struct __user *insn32;
+	struct comedi_file *cfp = file->private_data;
+	struct comedi_device *dev = cfp->dev;
+	struct comedi_insn insn;
 	int rc;
 
-	insn32 = compat_ptr(arg);
-	insn = compat_alloc_user_space(sizeof(*insn));
-
-	rc = get_compat_insn(insn, insn32);
+	rc = get_compat_insn(&insn, (void __user *)arg);
 	if (rc)
 		return rc;
 
-	return comedi_unlocked_ioctl(file, COMEDI_INSN, (unsigned long)insn);
+	mutex_lock(&dev->mutex);
+	rc = do_insn_ioctl(dev, &insn, file);
+	mutex_unlock(&dev->mutex);
+	return rc;
 }
 
 /*
-- 
2.11.0


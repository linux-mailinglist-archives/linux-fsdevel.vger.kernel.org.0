Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030BC1E7196
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388873AbgE2AfS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbgE2AfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:35:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5466CC08C5C9;
        Thu, 28 May 2020 17:35:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSzR-00HFRC-Nu; Fri, 29 May 2020 00:35:13 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 06/10] comedi: get rid of compat_alloc_user_space() mess in COMEDI_INSNLIST compat
Date:   Fri, 29 May 2020 01:35:09 +0100
Message-Id: <20200529003512.4110852-6-viro@ZenIV.linux.org.uk>
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
 drivers/staging/comedi/comedi_fops.c | 138 ++++++++++++-----------------------
 1 file changed, 48 insertions(+), 90 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index ae0067ab5ead..d80a416e70b2 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -1520,34 +1520,19 @@ static int parse_insn(struct comedi_device *dev, struct comedi_insn *insn,
 #define MIN_SAMPLES 16
 #define MAX_SAMPLES 65536
 static int do_insnlist_ioctl(struct comedi_device *dev,
-			     struct comedi_insnlist __user *arg, void *file)
+			     struct comedi_insn *insns,
+			     unsigned int n_insns,
+			     void *file)
 {
-	struct comedi_insnlist insnlist;
-	struct comedi_insn *insns = NULL;
 	unsigned int *data = NULL;
 	unsigned int max_n_data_required = MIN_SAMPLES;
 	int i = 0;
 	int ret = 0;
 
 	lockdep_assert_held(&dev->mutex);
-	if (copy_from_user(&insnlist, arg, sizeof(insnlist)))
-		return -EFAULT;
-
-	insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
-	if (!insns) {
-		ret = -ENOMEM;
-		goto error;
-	}
-
-	if (copy_from_user(insns, insnlist.insns,
-			   sizeof(*insns) * insnlist.n_insns)) {
-		dev_dbg(dev->class_dev, "copy_from_user failed\n");
-		ret = -EFAULT;
-		goto error;
-	}
 
 	/* Determine maximum memory needed for all instructions. */
-	for (i = 0; i < insnlist.n_insns; ++i) {
+	for (i = 0; i < n_insns; ++i) {
 		if (insns[i].n > MAX_SAMPLES) {
 			dev_dbg(dev->class_dev,
 				"number of samples too large\n");
@@ -1565,7 +1550,7 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 		goto error;
 	}
 
-	for (i = 0; i < insnlist.n_insns; ++i) {
+	for (i = 0; i < n_insns; ++i) {
 		if (insns[i].insn & INSN_MASK_WRITE) {
 			if (copy_from_user(data, insns[i].data,
 					   insns[i].n * sizeof(unsigned int))) {
@@ -1592,7 +1577,6 @@ static int do_insnlist_ioctl(struct comedi_device *dev,
 	}
 
 error:
-	kfree(insns);
 	kfree(data);
 
 	if (ret < 0)
@@ -2236,11 +2220,30 @@ static long comedi_unlocked_ioctl(struct file *file, unsigned int cmd,
 		rc = do_cmdtest_ioctl(dev, (struct comedi_cmd __user *)arg,
 				      file);
 		break;
-	case COMEDI_INSNLIST:
-		rc = do_insnlist_ioctl(dev,
-				       (struct comedi_insnlist __user *)arg,
-				       file);
+	case COMEDI_INSNLIST: {
+		struct comedi_insnlist insnlist;
+		struct comedi_insn *insns = NULL;
+
+		if (copy_from_user(&insnlist, (void __user *)arg,
+				   sizeof(insnlist))) {
+			rc = -EFAULT;
+			break;
+		}
+		insns = kcalloc(insnlist.n_insns, sizeof(*insns), GFP_KERNEL);
+		if (!insns) {
+			rc = -ENOMEM;
+			break;
+		}
+		if (copy_from_user(insns, insnlist.insns,
+				   sizeof(*insns) * insnlist.n_insns)) {
+			rc = -EFAULT;
+			kfree(insns);
+			break;
+		}
+		rc = do_insnlist_ioctl(dev, insns, insnlist.n_insns, file);
+		kfree(insns);
 		break;
+	}
 	case COMEDI_INSN: {
 		struct comedi_insn insn;
 		if (copy_from_user(&insn, (void __user *)arg, sizeof(insn)))
@@ -3094,83 +3097,38 @@ static int get_compat_insn(struct comedi_insn *insn,
 	return 0;
 }
 
-/* Copy 32-bit insn structure to native insn structure. */
-static int __get_compat_insn(struct comedi_insn __user *insn,
-			   struct comedi32_insn_struct __user *insn32)
-{
-	int err;
-	union {
-		unsigned int uint;
-		compat_uptr_t uptr;
-	} temp;
-
-	/* Copy insn structure.  Ignore the unused members. */
-	err = 0;
-	if (!access_ok(insn32, sizeof(*insn32)) ||
-	    !access_ok(insn, sizeof(*insn)))
-		return -EFAULT;
-
-	err |= __get_user(temp.uint, &insn32->insn);
-	err |= __put_user(temp.uint, &insn->insn);
-	err |= __get_user(temp.uint, &insn32->n);
-	err |= __put_user(temp.uint, &insn->n);
-	err |= __get_user(temp.uptr, &insn32->data);
-	err |= __put_user(compat_ptr(temp.uptr), &insn->data);
-	err |= __get_user(temp.uint, &insn32->subdev);
-	err |= __put_user(temp.uint, &insn->subdev);
-	err |= __get_user(temp.uint, &insn32->chanspec);
-	err |= __put_user(temp.uint, &insn->chanspec);
-	return err ? -EFAULT : 0;
-}
-
 /* Handle 32-bit COMEDI_INSNLIST ioctl. */
 static int compat_insnlist(struct file *file, unsigned long arg)
 {
-	struct combined_insnlist {
-		struct comedi_insnlist insnlist;
-		struct comedi_insn insn[1];
-	} __user *s;
-	struct comedi32_insnlist_struct __user *insnlist32;
+	struct comedi_file *cfp = file->private_data;
+	struct comedi_device *dev = cfp->dev;
+	struct comedi32_insnlist_struct insnlist32;
 	struct comedi32_insn_struct __user *insn32;
-	compat_uptr_t uptr;
-	unsigned int n_insns, n;
-	int err, rc;
-
-	insnlist32 = compat_ptr(arg);
-
-	/* Get 32-bit insnlist structure.  */
-	if (!access_ok(insnlist32, sizeof(*insnlist32)))
-		return -EFAULT;
-
-	err = 0;
-	err |= __get_user(n_insns, &insnlist32->n_insns);
-	err |= __get_user(uptr, &insnlist32->insns);
-	insn32 = compat_ptr(uptr);
-	if (err)
-		return -EFAULT;
-
-	/* Allocate user memory to copy insnlist and insns into. */
-	s = compat_alloc_user_space(offsetof(struct combined_insnlist,
-					     insn[n_insns]));
+	struct comedi_insn *insns;
+	unsigned int n;
+	int rc;
 
-	/* Set native insnlist structure. */
-	if (!access_ok(&s->insnlist, sizeof(s->insnlist)))
+	if (copy_from_user(&insnlist32, compat_ptr(arg), sizeof(insnlist32)))
 		return -EFAULT;
 
-	err |= __put_user(n_insns, &s->insnlist.n_insns);
-	err |= __put_user(&s->insn[0], &s->insnlist.insns);
-	if (err)
-		return -EFAULT;
+	insns = kcalloc(insnlist32.n_insns, sizeof(*insns), GFP_KERNEL);
+	if (!insns)
+		return -ENOMEM;
 
 	/* Copy insn structures. */
-	for (n = 0; n < n_insns; n++) {
-		rc = __get_compat_insn(&s->insn[n], &insn32[n]);
-		if (rc)
+	insn32 = compat_ptr(insnlist32.insns);
+	for (n = 0; n < insnlist32.n_insns; n++) {
+		rc = get_compat_insn(insns + n, insn32 + n);
+		if (rc) {
+			kfree(insns);
 			return rc;
+		}
 	}
 
-	return comedi_unlocked_ioctl(file, COMEDI_INSNLIST,
-				(unsigned long)&s->insnlist);
+	mutex_lock(&dev->mutex);
+	rc = do_insnlist_ioctl(dev, insns, insnlist32.n_insns, file);
+	mutex_unlock(&dev->mutex);
+	return rc;
 }
 
 /* Handle 32-bit COMEDI_INSN ioctl. */
-- 
2.11.0


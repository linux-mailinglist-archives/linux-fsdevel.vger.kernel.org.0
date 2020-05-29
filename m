Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7EFF1E7199
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 02:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbgE2AfR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 20:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728811AbgE2AfQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 20:35:16 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 041BAC08C5C6;
        Thu, 28 May 2020 17:35:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jeSzR-00HFQm-1i; Fri, 29 May 2020 00:35:13 +0000
From:   Al Viro <viro@ZenIV.linux.org.uk>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Ian Abbott <abbotti@mev.co.uk>
Subject: [PATCH 02/10] comedi: get rid of indirection via translated_ioctl()
Date:   Fri, 29 May 2020 01:35:05 +0100
Message-Id: <20200529003512.4110852-2-viro@ZenIV.linux.org.uk>
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
 drivers/staging/comedi/comedi_fops.c | 26 ++++++++------------------
 1 file changed, 8 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/comedi/comedi_fops.c b/drivers/staging/comedi/comedi_fops.c
index 9dfb81dfe43c..ecd29f28673c 100644
--- a/drivers/staging/comedi/comedi_fops.c
+++ b/drivers/staging/comedi/comedi_fops.c
@@ -2871,16 +2871,6 @@ struct comedi32_insnlist_struct {
 	compat_uptr_t insns;	/* 32-bit 'struct comedi_insn *' */
 };
 
-/* Handle translated ioctl. */
-static int translated_ioctl(struct file *file, unsigned int cmd,
-			    unsigned long arg)
-{
-	if (file->f_op->unlocked_ioctl)
-		return file->f_op->unlocked_ioctl(file, cmd, arg);
-
-	return -ENOTTY;
-}
-
 /* Handle 32-bit COMEDI_CHANINFO ioctl. */
 static int compat_chaninfo(struct file *file, unsigned long arg)
 {
@@ -2912,7 +2902,7 @@ static int compat_chaninfo(struct file *file, unsigned long arg)
 	if (err)
 		return -EFAULT;
 
-	return translated_ioctl(file, COMEDI_CHANINFO, (unsigned long)chaninfo);
+	return comedi_unlocked_ioctl(file, COMEDI_CHANINFO, (unsigned long)chaninfo);
 }
 
 /* Handle 32-bit COMEDI_RANGEINFO ioctl. */
@@ -2942,7 +2932,7 @@ static int compat_rangeinfo(struct file *file, unsigned long arg)
 	if (err)
 		return -EFAULT;
 
-	return translated_ioctl(file, COMEDI_RANGEINFO,
+	return comedi_unlocked_ioctl(file, COMEDI_RANGEINFO,
 				(unsigned long)rangeinfo);
 }
 
@@ -3063,7 +3053,7 @@ static int compat_cmd(struct file *file, unsigned long arg)
 	if (rc)
 		return rc;
 
-	rc = translated_ioctl(file, COMEDI_CMD, (unsigned long)cmd);
+	rc = comedi_unlocked_ioctl(file, COMEDI_CMD, (unsigned long)cmd);
 	if (rc == -EAGAIN) {
 		/* Special case: copy cmd back to user. */
 		err = put_compat_cmd(cmd32, cmd);
@@ -3088,7 +3078,7 @@ static int compat_cmdtest(struct file *file, unsigned long arg)
 	if (rc)
 		return rc;
 
-	rc = translated_ioctl(file, COMEDI_CMDTEST, (unsigned long)cmd);
+	rc = comedi_unlocked_ioctl(file, COMEDI_CMDTEST, (unsigned long)cmd);
 	if (rc < 0)
 		return rc;
 
@@ -3174,7 +3164,7 @@ static int compat_insnlist(struct file *file, unsigned long arg)
 			return rc;
 	}
 
-	return translated_ioctl(file, COMEDI_INSNLIST,
+	return comedi_unlocked_ioctl(file, COMEDI_INSNLIST,
 				(unsigned long)&s->insnlist);
 }
 
@@ -3192,7 +3182,7 @@ static int compat_insn(struct file *file, unsigned long arg)
 	if (rc)
 		return rc;
 
-	return translated_ioctl(file, COMEDI_INSN, (unsigned long)insn);
+	return comedi_unlocked_ioctl(file, COMEDI_INSN, (unsigned long)insn);
 }
 
 /*
@@ -3212,7 +3202,7 @@ static long comedi_compat_ioctl(struct file *file, unsigned int cmd, unsigned lo
 	case COMEDI_BUFINFO:
 		/* Just need to translate the pointer argument. */
 		arg = (unsigned long)compat_ptr(arg);
-		rc = translated_ioctl(file, cmd, arg);
+		rc = comedi_unlocked_ioctl(file, cmd, arg);
 		break;
 	case COMEDI_LOCK:
 	case COMEDI_UNLOCK:
@@ -3221,7 +3211,7 @@ static long comedi_compat_ioctl(struct file *file, unsigned int cmd, unsigned lo
 	case COMEDI_SETRSUBD:
 	case COMEDI_SETWSUBD:
 		/* No translation needed. */
-		rc = translated_ioctl(file, cmd, arg);
+		rc = comedi_unlocked_ioctl(file, cmd, arg);
 		break;
 	case COMEDI32_CHANINFO:
 		rc = compat_chaninfo(file, arg);
-- 
2.11.0


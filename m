Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53DE1D1867
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731935AbfJITNu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:13:50 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:51095 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731922AbfJITLU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:20 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MXXdn-1iajhJ3863-00YxNA; Wed, 09 Oct 2019 21:11:10 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH v6 13/43] compat_ioctl: use correct compat_ptr() translation in drivers
Date:   Wed,  9 Oct 2019 21:10:13 +0200
Message-Id: <20191009191044.308087-13-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:2Ri+AmqHP2IgSyuBrP8IXouAO/GywqDxk3Oop8VJyII1VjvrXgG
 g9gF3z2VGIP5Ci2S3stEsEM2C9eWsVyZmsGxAiDAfzJw7LKUcEYJOFbJRXQkXmcdsOMKvw9
 fORHBgakc1Gdv3KXkP8MUEYgTFVmyg5fHUUjBj/mYAHfrWwOIE/hUagBclbnVofe8zyZPa+
 CH0sYmDNlNMuFz+vaBFhg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:2NQGECvoGC4=:S58aRpaPBAOZ8FNVwSW1SG
 50dLXpGb+RJ5ycryuKaEPzaJ1PXl9S/CSYXP7wskUMoL5TZTX90q6pTa0t/7dUQRPTcR3KGQv
 Zyp8IomcQKdRb1MXkib3kFg+OsuNBdJE3XNbg2F6XdrfvZtvoo54Wo8J3uQzc4NdkeHoA1IKk
 9+aNqCP6mRUcOu4v+6xkZK493jV1ag1oywXC5C+DDpT/hA1SQEm8zi9PLsvLSAfWgs+0FnzQ2
 dOdiy/L9Azg57TodxpwlT0k0OdGDx+Hu2NTmeYGzKE3RC3zw6BDs6NvU5LbLY6O7CZrMqbUoG
 vjTMTPty4v2H+kFxYR+4iM6V8TR5BedxaMMWtM3BNfBzGLWklJ5Z7p8vaQw3k+q6fDEUHrHIg
 2xx3aNmLyQJPK/VT4DTujtqiqNaKl1nUEIae/axjp+Xx/jNI1nrKLqd0C/gu+igGT8NFXuJ5O
 iz3Yh6E1xlkPhdBcvwviyh6ExMfef9Q3fFcT1gurQlJbOiOQUiTPY4dUbfNSzSq84vMFYhFqB
 0zFWpev0UXhtamltB3ITKlXky5E0xj2JMhvdm7Rrux71FRQSIGkpLNNSYhl8qSWdCZco7TDbb
 d4vnw3oUL4UTXPOJhQxB4IiwB4srl8Kn+eDSCAkyWHgGlGebIc4fQUR05mHqI9K3knM9xc17K
 onwIUjw6wnOdCIZWLeYI4X0jBotHQ6ayJ+w4+zt0o5bHDF0doVwq/BV5pCa3QCANq43sTm2+Z
 YJRM4LWvZ7WC2QFFFAmEudb2J3yOCZ3d4RhR72YT57dPqbHZVsMhD1tqMYzLTF9YPyvB8c5BV
 Jsk0u6lFgMhckIw48ZYmnchOh82+4BgBWm0snIHhbyUUYgNzs+oOoEZY5NT/hkgSJ8tTiDENu
 N7NoF0vA3e3mY2dhv16A==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

A handful of drivers all have a trivial wrapper around their ioctl
handler, but don't call the compat_ptr() conversion function at the
moment. In practice this does not matter, since none of them are used
on the s390 architecture and for all other architectures, compat_ptr()
does not do anything, but using the new compat_ptr_ioctl()
helper makes it more correct in theory, and simplifies the code.

I checked that all ioctl handlers in these files are compatible
and take either pointer arguments or no argument.

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Acked-by: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/misc/cxl/flash.c            |  8 +-------
 drivers/misc/genwqe/card_dev.c      | 23 +----------------------
 drivers/scsi/megaraid/megaraid_mm.c | 28 +---------------------------
 drivers/usb/gadget/function/f_fs.c  | 12 +-----------
 4 files changed, 4 insertions(+), 67 deletions(-)

diff --git a/drivers/misc/cxl/flash.c b/drivers/misc/cxl/flash.c
index 4d6836f19489..cb9cca35a226 100644
--- a/drivers/misc/cxl/flash.c
+++ b/drivers/misc/cxl/flash.c
@@ -473,12 +473,6 @@ static long device_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		return -EINVAL;
 }
 
-static long device_compat_ioctl(struct file *file, unsigned int cmd,
-				unsigned long arg)
-{
-	return device_ioctl(file, cmd, arg);
-}
-
 static int device_close(struct inode *inode, struct file *file)
 {
 	struct cxl *adapter = file->private_data;
@@ -514,7 +508,7 @@ static const struct file_operations fops = {
 	.owner		= THIS_MODULE,
 	.open		= device_open,
 	.unlocked_ioctl	= device_ioctl,
-	.compat_ioctl	= device_compat_ioctl,
+	.compat_ioctl	= compat_ptr_ioctl,
 	.release	= device_close,
 };
 
diff --git a/drivers/misc/genwqe/card_dev.c b/drivers/misc/genwqe/card_dev.c
index 0e34c0568fed..040a0bda3125 100644
--- a/drivers/misc/genwqe/card_dev.c
+++ b/drivers/misc/genwqe/card_dev.c
@@ -1215,34 +1215,13 @@ static long genwqe_ioctl(struct file *filp, unsigned int cmd,
 	return rc;
 }
 
-#if defined(CONFIG_COMPAT)
-/**
- * genwqe_compat_ioctl() - Compatibility ioctl
- *
- * Called whenever a 32-bit process running under a 64-bit kernel
- * performs an ioctl on /dev/genwqe<n>_card.
- *
- * @filp:        file pointer.
- * @cmd:         command.
- * @arg:         user argument.
- * Return:       zero on success or negative number on failure.
- */
-static long genwqe_compat_ioctl(struct file *filp, unsigned int cmd,
-				unsigned long arg)
-{
-	return genwqe_ioctl(filp, cmd, arg);
-}
-#endif /* defined(CONFIG_COMPAT) */
-
 static const struct file_operations genwqe_fops = {
 	.owner		= THIS_MODULE,
 	.open		= genwqe_open,
 	.fasync		= genwqe_fasync,
 	.mmap		= genwqe_mmap,
 	.unlocked_ioctl	= genwqe_ioctl,
-#if defined(CONFIG_COMPAT)
-	.compat_ioctl   = genwqe_compat_ioctl,
-#endif
+	.compat_ioctl   = compat_ptr_ioctl,
 	.release	= genwqe_release,
 };
 
diff --git a/drivers/scsi/megaraid/megaraid_mm.c b/drivers/scsi/megaraid/megaraid_mm.c
index 59cca898f088..e83163c66884 100644
--- a/drivers/scsi/megaraid/megaraid_mm.c
+++ b/drivers/scsi/megaraid/megaraid_mm.c
@@ -41,10 +41,6 @@ static int mraid_mm_setup_dma_pools(mraid_mmadp_t *);
 static void mraid_mm_free_adp_resources(mraid_mmadp_t *);
 static void mraid_mm_teardown_dma_pools(mraid_mmadp_t *);
 
-#ifdef CONFIG_COMPAT
-static long mraid_mm_compat_ioctl(struct file *, unsigned int, unsigned long);
-#endif
-
 MODULE_AUTHOR("LSI Logic Corporation");
 MODULE_DESCRIPTION("LSI Logic Management Module");
 MODULE_LICENSE("GPL");
@@ -68,9 +64,7 @@ static wait_queue_head_t wait_q;
 static const struct file_operations lsi_fops = {
 	.open	= mraid_mm_open,
 	.unlocked_ioctl = mraid_mm_unlocked_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = mraid_mm_compat_ioctl,
-#endif
+	.compat_ioctl = compat_ptr_ioctl,
 	.owner	= THIS_MODULE,
 	.llseek = noop_llseek,
 };
@@ -224,7 +218,6 @@ mraid_mm_unlocked_ioctl(struct file *filep, unsigned int cmd,
 {
 	int err;
 
-	/* inconsistent: mraid_mm_compat_ioctl doesn't take the BKL */
 	mutex_lock(&mraid_mm_mutex);
 	err = mraid_mm_ioctl(filep, cmd, arg);
 	mutex_unlock(&mraid_mm_mutex);
@@ -1228,25 +1221,6 @@ mraid_mm_init(void)
 }
 
 
-#ifdef CONFIG_COMPAT
-/**
- * mraid_mm_compat_ioctl	- 32bit to 64bit ioctl conversion routine
- * @filep	: file operations pointer (ignored)
- * @cmd		: ioctl command
- * @arg		: user ioctl packet
- */
-static long
-mraid_mm_compat_ioctl(struct file *filep, unsigned int cmd,
-		      unsigned long arg)
-{
-	int err;
-
-	err = mraid_mm_ioctl(filep, cmd, arg);
-
-	return err;
-}
-#endif
-
 /**
  * mraid_mm_exit	- Module exit point
  */
diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
index 59d9d512dcda..ce1d0235969c 100644
--- a/drivers/usb/gadget/function/f_fs.c
+++ b/drivers/usb/gadget/function/f_fs.c
@@ -1352,14 +1352,6 @@ static long ffs_epfile_ioctl(struct file *file, unsigned code,
 	return ret;
 }
 
-#ifdef CONFIG_COMPAT
-static long ffs_epfile_compat_ioctl(struct file *file, unsigned code,
-		unsigned long value)
-{
-	return ffs_epfile_ioctl(file, code, value);
-}
-#endif
-
 static const struct file_operations ffs_epfile_operations = {
 	.llseek =	no_llseek,
 
@@ -1368,9 +1360,7 @@ static const struct file_operations ffs_epfile_operations = {
 	.read_iter =	ffs_epfile_read_iter,
 	.release =	ffs_epfile_release,
 	.unlocked_ioctl =	ffs_epfile_ioctl,
-#ifdef CONFIG_COMPAT
-	.compat_ioctl = ffs_epfile_compat_ioctl,
-#endif
+	.compat_ioctl = compat_ptr_ioctl,
 };
 
 
-- 
2.20.0


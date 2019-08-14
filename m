Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 674E48DF8D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 22:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbfHNU6r (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 16:58:47 -0400
Received: from mout.kundenserver.de ([212.227.126.130]:54847 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729984AbfHNU6r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:58:47 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MWixU-1hmtSX2IDQ-00X2el; Wed, 14 Aug 2019 22:57:17 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Hannes Reinecke <hare@suse.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH v5 16/18] compat_ioctl: move SG_GET_REQUEST_TABLE handling
Date:   Wed, 14 Aug 2019 22:54:51 +0200
Message-Id: <20190814205521.122180-7-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190814204259.120942-1-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Oh96NWxdPZEW/yuDMF44sbWZBSLaeWtZ7p1wHLQUZgKNUin6CaT
 SZsCIC9diZmfoU/GHahmeQsbLYDGVw9hBTHQoYo+YRxvApsSXI4/JvVsY94AYTDxLkf9CMi
 5MpmJ74hVdE/JoAAlIpgiEZxJzKJTxI15YS2DiE/O5HamfDJ1XxqguJssl1WJOIVRNW2q/y
 cMHt+ifIU8CzvdCJuIrzw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:0HxL3DcyvMs=:Z7H2CT2juldoHXDfO9q1XL
 Fgz7raKdxxOXC6ou7IDYER15xW5hebo9Q0WrHIgFrXoe9Nj09LOZE1qAlCjGZk3l4H5hu+aPC
 DRBYOuEgMjUMonLNSKQfT3dxF11JNbxlSq0mEnrnFMpXgApAd+ceoP1pA3vOZ1p8V6mifgx5y
 iuJmYinYWHp0IqrhSRR5l/fdfslGO2rNu/iCpFOhHgtieX/nSqSrtKSLR60j86VsSGeWmT5+q
 0vI3NSoUcZ6kQCjQ0hJjyx0OiP01uuKF3TgD7KYEn7UwKwECabMZFKmttvOG9A2I0fuxLe7lR
 ZgKFifwRqHJbeaPq6nwLPdBM4t9EKIw6OdbCm5IfLTmgp2w3owSEADl/GmXt42+JvYrfVG4m5
 61b6jOlUBMZ/qz9xqITSIjoYcmo5+y4BgawmhjaghExwj+xro2w6uk9N2firAF8FTlnK042Oc
 yzFt+sEqUOqNZo8xi2RRPVAtiCtOOwRVKX9DRwxGsUEm1YUfV2OQ0AgH3BEF604YwN+igSTYL
 +V+Fuv3yn/h5SZahPgmffvZOj2V0pir7DGuZlTR0jZq91fgX7Fe0BhOrzsSNOlEvK8bWYtoSk
 YuTGG5BRHL4sNjiBwmwngw/U5fYLuwCB7SF32u7MH+MgftGGEGOpXYR1dNzCdUYt0MGESyhFp
 ZODj5N5oLP+p5bGOenb2BwLCrsx3quIlcHQ3swWCy/EaLhDiUQP3DnY9DhbbdhRR8nDjr7s26
 bP625blLw14sfIHa1ovsph3fNpRQCgDMip3/n1ZXtiO2nlM95cS/5yeRoCpQ0hW1RP3HtfCU4
 sGHgQtIR0OEy5FPnN2XiGMCtWisrQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SG_GET_REQUEST_TABLE is now the last ioctl command that needs a conversion
handler. This is only used in a single file, so the implementation should
be there.

I'm trying to simplify it in the process, to get rid of
the compat_alloc_user_space() and extra copy, by adding a
put_compat_request_table() function instead, which copies the data in
the right format to user space.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/sg.c | 40 ++++++++++++++++++++++++++++++-----
 fs/compat_ioctl.c | 54 +----------------------------------------------
 2 files changed, 36 insertions(+), 58 deletions(-)

diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
index 8ae096af2667..9e4ef22b3579 100644
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -889,6 +889,33 @@ sg_fill_request_table(Sg_fd *sfp, sg_req_info_t *rinfo)
 	}
 }
 
+#ifdef CONFIG_COMPAT
+struct compat_sg_req_info { /* used by SG_GET_REQUEST_TABLE ioctl() */
+	char req_state;
+	char orphan;
+	char sg_io_owned;
+	char problem;
+	int pack_id;
+	compat_uptr_t usr_ptr;
+	unsigned int duration;
+	int unused;
+};
+
+static int put_compat_request_table(struct compat_sg_req_info __user *o,
+				    struct sg_req_info *rinfo)
+{
+	int i;
+	for (i = 0; i < SG_MAX_QUEUE; i++) {
+		if (copy_to_user(o + i, rinfo + i, offsetof(sg_req_info_t, usr_ptr)) ||
+		    put_user((uintptr_t)rinfo[i].usr_ptr, &o[i].usr_ptr) ||
+		    put_user(rinfo[i].duration, &o[i].duration) ||
+		    put_user(rinfo[i].unused, &o[i].unused))
+			return -EFAULT;
+	}
+	return 0;
+}
+#endif
+
 static long
 sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 {
@@ -1069,9 +1096,7 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 		val = (sdp->device ? 1 : 0);
 		return put_user(val, ip);
 	case SG_GET_REQUEST_TABLE:
-		if (!access_ok(p, SZ_SG_REQ_INFO * SG_MAX_QUEUE))
-			return -EFAULT;
-		else {
+		{
 			sg_req_info_t *rinfo;
 
 			rinfo = kcalloc(SG_MAX_QUEUE, SZ_SG_REQ_INFO,
@@ -1081,8 +1106,13 @@ sg_ioctl(struct file *filp, unsigned int cmd_in, unsigned long arg)
 			read_lock_irqsave(&sfp->rq_list_lock, iflags);
 			sg_fill_request_table(sfp, rinfo);
 			read_unlock_irqrestore(&sfp->rq_list_lock, iflags);
-			result = __copy_to_user(p, rinfo,
-						SZ_SG_REQ_INFO * SG_MAX_QUEUE);
+	#ifdef CONFIG_COMPAT
+			if (in_compat_syscall())
+				result = put_compat_request_table(p, rinfo);
+			else
+	#endif
+				result = copy_to_user(p, rinfo,
+						      SZ_SG_REQ_INFO * SG_MAX_QUEUE);
 			result = result ? -EFAULT : 0;
 			kfree(rinfo);
 			return result;
diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 3d127bb6357a..6837a3904b8c 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -52,53 +52,6 @@
 
 #include <linux/sort.h>
 
-static int do_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
-{
-	int err;
-
-	err = security_file_ioctl(file, cmd, arg);
-	if (err)
-		return err;
-
-	return vfs_ioctl(file, cmd, arg);
-}
-
-#ifdef CONFIG_BLOCK
-struct compat_sg_req_info { /* used by SG_GET_REQUEST_TABLE ioctl() */
-	char req_state;
-	char orphan;
-	char sg_io_owned;
-	char problem;
-	int pack_id;
-	compat_uptr_t usr_ptr;
-	unsigned int duration;
-	int unused;
-};
-
-static int sg_grt_trans(struct file *file,
-		unsigned int cmd, struct compat_sg_req_info __user *o)
-{
-	int err, i;
-	sg_req_info_t __user *r;
-	r = compat_alloc_user_space(sizeof(sg_req_info_t)*SG_MAX_QUEUE);
-	err = do_ioctl(file, cmd, (unsigned long)r);
-	if (err < 0)
-		return err;
-	for (i = 0; i < SG_MAX_QUEUE; i++) {
-		void __user *ptr;
-		int d;
-
-		if (copy_in_user(o + i, r + i, offsetof(sg_req_info_t, usr_ptr)) ||
-		    get_user(ptr, &r[i].usr_ptr) ||
-		    get_user(d, &r[i].duration) ||
-		    put_user((u32)(unsigned long)(ptr), &o[i].usr_ptr) ||
-		    put_user(d, &o[i].duration))
-			return -EFAULT;
-	}
-	return err;
-}
-#endif /* CONFIG_BLOCK */
-
 /*
  * simple reversible transform to make our table more evenly
  * distributed after sorting.
@@ -121,6 +74,7 @@ COMPATIBLE_IOCTL(SCSI_IOCTL_GET_PCI)
 #ifdef CONFIG_BLOCK
 /* SG stuff */
 COMPATIBLE_IOCTL(SG_IO)
+COMPATIBLE_IOCTL(SG_GET_REQUEST_TABLE)
 COMPATIBLE_IOCTL(SG_SET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_GET_TIMEOUT)
 COMPATIBLE_IOCTL(SG_EMULATED_HOST)
@@ -156,13 +110,7 @@ COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
 static long do_ioctl_trans(unsigned int cmd,
 		 unsigned long arg, struct file *file)
 {
-	void __user *argp = compat_ptr(arg);
-
 	switch (cmd) {
-#ifdef CONFIG_BLOCK
-	case SG_GET_REQUEST_TABLE:
-		return sg_grt_trans(file, cmd, argp);
-#endif
 	}
 
 	return -ENOIOCTLCMD;
-- 
2.20.0


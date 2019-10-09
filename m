Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4A8DFD1836
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732092AbfJITLd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:11:33 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:45423 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbfJITLd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:33 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MXotA-1ib0Xm0A5U-00Y8QV; Wed, 09 Oct 2019 21:11:22 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-scsi@vger.kernel.org, Doug Gilbert <dgilbert@interlog.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: [PATCH v6 41/43] compat_ioctl: move SG_GET_REQUEST_TABLE handling
Date:   Wed,  9 Oct 2019 21:10:42 +0200
Message-Id: <20191009191044.308087-42-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:p7Tc//BuR7qdz2xwgrqekZl/T08X8CkoWdOtYvxnp+Bnzgn9Uj7
 sAo1jJmlSHjzs5xbyAt88mQJgrMQQkQlwzqT+rSKafIvWdfeMntJkYSBMs+BkJy82ISeh0H
 cIsrVtG2023QK4n/BOJ/SXqjlr6TRtcLNDDt5CVctNJTL0LmzQ9SRSfu7eEaTflg8MfvlnX
 T4k+u6NPrU4atJQvOg9Mw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:d4mN/yyRcj8=:TTGVKCdrOl6cbcoLsASAxH
 kEVn9N9blBIh/ydPtDoiNrGXUt0w+lsODlOQ4ZbQ10H7P0nGg5FB8Ix2gqOzHwQPg5XjYvA0M
 OxUWCMQuGZ6e2hiDbTK7u6VvVLryKAbvKE5d7HfNePfwIi8nwwKUCwZ5VZBU8H8J8kRfqLb5B
 q6Lbp46cimVpv3E83rzt/wq0YxKERx4nGqHZ1YpBztjPBuAGLuh11mdTZTnnKeeHi09MrubPl
 9BL7+y6WbEyCuWOHIxmPrHHGkpe4pvuIL26//2Nbi7D3u511PEMowfGuDFBF0xqAvd1zHAL4i
 unBTi8+fTlnq3kzqbdrn2V5N2uhMinIrDNqv6hmm5kpxLozsE9OJu91n5xzye5CSUNNIScPeX
 Hw++dibuo02BNKb493CplF4yRZlxIGW7cpMJxg2OF+bxEq0NVQ21cgJ4yGzwIj08KZPJ8wUGn
 VG70GU21vGUva1yJrY8e1cz8PQLg009xUSWHOPqI64FN6UBDzmvxZzImnnDEfVnXvFGX4ra+D
 eEnrakXeTjJbmSQ1javGLTQICDgHjcFEjfO3cOAKfWNzdxmfEQSXfhvz1OaiOvQ2lbClhvRmG
 DWB/VWNLLLv7qrljQFMCAZzIQSS2Pq+4qPOHSVOV/dnLtEf4QFpH8wGkUynZy+8LxgyYPHZas
 opv6lbCaVeqYW7YYNkEf80JuxWQMyxLCoRcy13mlz00Uu3AASfuSMJ/xLwo7yIUnofnmDdZHO
 eeVfsGhwQu4mMURh1fQxLhwxr4YApqOLakENRSJXlo++sCJmCqokyXVMJy8PquYBhWcG5TP5L
 +mHLDB6hbb8JrMiieemRSJKIszB2z6RZcNLbSnNDoMKohPz5vcXywWsR3BtSOKUiWWhv6LLRI
 eslWOrwcydSqNlIZ4EkA==
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

Cc: linux-scsi@vger.kernel.org
Cc: Doug Gilbert <dgilbert@interlog.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/scsi/sg.c | 40 ++++++++++++++++++++++++++++-----
 fs/compat_ioctl.c | 57 +----------------------------------------------
 2 files changed, 36 insertions(+), 61 deletions(-)

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
index 3cf8b6d113c3..9ae90d728c0f 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -52,53 +52,6 @@
 
 #include <linux/sort.h>
 
-#ifdef CONFIG_BLOCK
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
@@ -156,15 +110,6 @@ COMPATIBLE_IOCTL(SG_GET_KEEP_ORPHAN)
 static long do_ioctl_trans(unsigned int cmd,
 		 unsigned long arg, struct file *file)
 {
-#ifdef CONFIG_BLOCK
-	void __user *argp = compat_ptr(arg);
-
-	switch (cmd) {
-	case SG_GET_REQUEST_TABLE:
-		return sg_grt_trans(file, cmd, argp);
-	}
-#endif
-
 	return -ENOIOCTLCMD;
 }
 
-- 
2.20.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 336857B341
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 21:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbfG3T1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jul 2019 15:27:49 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:58195 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727797AbfG3T1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jul 2019 15:27:49 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MsqIi-1iCGYg0g8m-00tAnf; Tue, 30 Jul 2019 21:27:42 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Alexander Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Amir Goldstein <amir73il@gmail.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>
Subject: [PATCH v5 05/29] compat: move FS_IOC_RESVSP_32 handling to fs/ioctl.c
Date:   Tue, 30 Jul 2019 21:25:16 +0200
Message-Id: <20190730192552.4014288-6-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190730192552.4014288-1-arnd@arndb.de>
References: <20190730192552.4014288-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:dX0rFn6Lm0g176R2j8aLSlUXtVSxnFFpTjiGEtz+uG2yFRMoLpW
 gJcCYxwoCpkXung1LVVkFOxfZhdD7ENcquhCe2bYCjXRxSG+pORCi7WhsWWvLGThivYPE1k
 3r2tXzAMS4I7Df4uy0RXLSLfrnvtoqABKA9fspjIAYCWu7lCIeRlBRGV/iRLH9tgp30nFJ2
 UtllthknH6+3gVDzSb8QA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:G9802wau1lg=:CDAVQ6YWBIfOldoKNgof5s
 R85xKlPdmMVXNKvI24p5c+9dYMHdOvB9DhlEf+FUKkkhJ8Po9nXkO/OrIEKO/5lKOMLcktS9V
 umhtKfDvlPxB0Xf+7nsGimQg1cUH2mKBlkCB90ggCkcsrNbYn1DcUq0gir5UxmDo3wdzpqq1u
 FbZ09PLvX1oJHOj9toMaQEi3urf1tzUh6pXJmlSrENGkTmxc8gGMxEvDtF7YMzWAQOj6ZwX2h
 uj5bjRVwqxSflpznqRDlgCbQwwuibuv+Q8qDNIVKhNFcMdQ+OVlMx1TalpTN44oS2dH6VMskx
 xzXN3IVfTszifttPr05w70qnO9uztHT/Mnh5fiFe8XeXHe4VmsegfXtEjU1wldZmn/olxnmKF
 l5VR/Dg/8MvvC7+swqU4AiHEPnWT8yQ2PdscLluBZxApelqkMnTk5rbZ2fj1FxelKu5ovm0iF
 BOUwa2r/zjvOQW2faH1/qxNRxEeinOXsfc/5oHx8VxRK66zOFn8pmzbla8LnGfBhn6LvQj0hU
 kVHa1nI3V48NS6fdH/7KeeeGQJXJUZagHCVCFIpRPVeenZIUZcrFCRNZKYo6d97c/w4Wj+qrv
 3Z4P3J5ilFP7yt+BeYkac97GGI8KLJkSCxJoqxFIYBSv7z+h+gnZoiFuj1HxyCHt75HrfXj9t
 XgCDa9WShhV2HQ4/+qnWgI2fUBsY9DmH7BA3TZcioHzUkp6XZ8leZmSo0jcYbXkYdXYoHp0VF
 JwDqVP9FTctWPp5INUlZwYFye76ytFTTlKCDQQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Al Viro <viro@zeniv.linux.org.uk>

... and lose the ridiculous games with compat_alloc_user_space()
there.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/compat_ioctl.c      | 35 -----------------------------------
 fs/ioctl.c             | 29 +++++++++++++++++++++++++++++
 include/linux/falloc.h | 20 ++++++++++++++++++++
 3 files changed, 49 insertions(+), 35 deletions(-)

diff --git a/fs/compat_ioctl.c b/fs/compat_ioctl.c
index 3d08817be7b8..0a748324f96f 100644
--- a/fs/compat_ioctl.c
+++ b/fs/compat_ioctl.c
@@ -467,41 +467,6 @@ static int rtc_ioctl(struct file *file,
 	return -ENOIOCTLCMD;
 }
 
-/* on ia32 l_start is on a 32-bit boundary */
-#if defined(CONFIG_X86_64)
-struct space_resv_32 {
-	__s16		l_type;
-	__s16		l_whence;
-	__s64		l_start	__attribute__((packed));
-			/* len == 0 means until end of file */
-	__s64		l_len __attribute__((packed));
-	__s32		l_sysid;
-	__u32		l_pid;
-	__s32		l_pad[4];	/* reserve area */
-};
-
-#define FS_IOC_RESVSP_32		_IOW ('X', 40, struct space_resv_32)
-#define FS_IOC_RESVSP64_32	_IOW ('X', 42, struct space_resv_32)
-
-/* just account for different alignment */
-static int compat_ioctl_preallocate(struct file *file,
-			struct space_resv_32    __user *p32)
-{
-	struct space_resv	__user *p = compat_alloc_user_space(sizeof(*p));
-
-	if (copy_in_user(&p->l_type,	&p32->l_type,	sizeof(s16)) ||
-	    copy_in_user(&p->l_whence,	&p32->l_whence, sizeof(s16)) ||
-	    copy_in_user(&p->l_start,	&p32->l_start,	sizeof(s64)) ||
-	    copy_in_user(&p->l_len,	&p32->l_len,	sizeof(s64)) ||
-	    copy_in_user(&p->l_sysid,	&p32->l_sysid,	sizeof(s32)) ||
-	    copy_in_user(&p->l_pid,	&p32->l_pid,	sizeof(u32)) ||
-	    copy_in_user(&p->l_pad,	&p32->l_pad,	4*sizeof(u32)))
-		return -EFAULT;
-
-	return ioctl_preallocate(file, p);
-}
-#endif
-
 /*
  * simple reversible transform to make our table more evenly
  * distributed after sorting.
diff --git a/fs/ioctl.c b/fs/ioctl.c
index 3f28b39f32f3..9d26251f34a9 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -490,6 +490,35 @@ int ioctl_preallocate(struct file *filp, void __user *argp)
 	return vfs_fallocate(filp, FALLOC_FL_KEEP_SIZE, sr.l_start, sr.l_len);
 }
 
+/* on ia32 l_start is on a 32-bit boundary */
+#if defined CONFIG_COMPAT && defined(CONFIG_X86_64)
+/* just account for different alignment */
+int compat_ioctl_preallocate(struct file *file,
+				struct space_resv_32 __user *argp)
+{
+	struct inode *inode = file_inode(file);
+	struct space_resv_32 sr;
+
+	if (copy_from_user(&sr, argp, sizeof(sr)))
+		return -EFAULT;
+
+	switch (sr.l_whence) {
+	case SEEK_SET:
+		break;
+	case SEEK_CUR:
+		sr.l_start += file->f_pos;
+		break;
+	case SEEK_END:
+		sr.l_start += i_size_read(inode);
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return vfs_fallocate(file, FALLOC_FL_KEEP_SIZE, sr.l_start, sr.l_len);
+}
+#endif
+
 static int file_ioctl(struct file *filp, unsigned int cmd,
 		unsigned long arg)
 {
diff --git a/include/linux/falloc.h b/include/linux/falloc.h
index 674d59f4d6ce..fc61fdb9d1e9 100644
--- a/include/linux/falloc.h
+++ b/include/linux/falloc.h
@@ -29,4 +29,24 @@ struct space_resv {
 					 FALLOC_FL_INSERT_RANGE |	\
 					 FALLOC_FL_UNSHARE_RANGE)
 
+/* on ia32 l_start is on a 32-bit boundary */
+#if defined(CONFIG_X86_64)
+struct space_resv_32 {
+	__s16		l_type;
+	__s16		l_whence;
+	__s64		l_start	__attribute__((packed));
+			/* len == 0 means until end of file */
+	__s64		l_len __attribute__((packed));
+	__s32		l_sysid;
+	__u32		l_pid;
+	__s32		l_pad[4];	/* reserve area */
+};
+
+#define FS_IOC_RESVSP_32		_IOW ('X', 40, struct space_resv_32)
+#define FS_IOC_RESVSP64_32	_IOW ('X', 42, struct space_resv_32)
+
+int compat_ioctl_preallocate(struct file *, struct space_resv_32 __user *);
+
+#endif
+
 #endif /* _FALLOC_H_ */
-- 
2.20.0


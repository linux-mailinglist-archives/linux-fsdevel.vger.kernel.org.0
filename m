Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8042FD1893
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Oct 2019 21:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731798AbfJITPL (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Oct 2019 15:15:11 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:49547 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731254AbfJITLH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Oct 2019 15:11:07 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MlNYj-1hoyMW1KMH-00lpcY; Wed, 09 Oct 2019 21:11:05 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v6 05/43] compat: move FS_IOC_RESVSP_32 handling to fs/ioctl.c
Date:   Wed,  9 Oct 2019 21:10:05 +0200
Message-Id: <20191009191044.308087-5-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191009190853.245077-1-arnd@arndb.de>
References: <20191009190853.245077-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:rsGECA5U1Pe5E0luoyAv0WbzCrVjbsQOadFEWZ5NMCYNiZjylnu
 l5AG2Lwa7eM8lTTPAW292gekCpIw4QZxGwpxflTrtG2BDGKIpf1CN2Fl5l9GNrbXFFlS38E
 w2ZW30erZFv5JqXeNwH0pBcbw1RjwNJKb+TpsgUEfmyxdLqRpNtQXRVItdMM5xyq4aINV9o
 QDrteYoQYjcT2Lb8hfZQQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k9SWxQ9A46E=:lP2JygFTkqc2drkSj6/yBE
 XK4ZqUNVpsvyjl5vBBOymBIrFQWcnaxvUhc/LCsPRUgc+Uy11/Gaq6ijurj0KYajjnJLto9Mg
 16oDHj/fPWUbB9oAfQalgAn/xa/7h6AvdHw2Qox+EB27RvgZkxrVPAS87cI/QbJ4sIbYi6sYk
 E4h0EU1xUuM4HjEtoXHIqL9+CI1hJCx9z6m3ggTQyfcj2NLF+kXFVx2jS6cXKEYsBtI4GerVK
 tfMzjvAigi/u9jaufKbWwAFOHfh3rzvMCr+NjATrIaBNJHc2Vz3k86syucP2dfc5jbD9fu7Lk
 lJYE8fISka4IUCVHX3AuxzcQGSI8Pq8KoDMqWVtP30nTxUWRhZcwlWMY2eNCDEZCyBx0chsK9
 arvsuaO1LzchSmGfUqJkD9t7Tx1ZEr2enXW2vdEaZNuz0rRfsBXsOQpmPNko9/ukaicr12KnI
 hbZFKY8EQ298JkolT+j852h7ESOl1pVtQgaTvzHnnD86XMALxLZyxczia59VESHuUf+qlqlAZ
 hy7mP8tqX8rGRDBiQ1AR05y6g9bKygQwCYHrDKmqw6ly0hy3FFPNG15jTQi7QaEfFOYu/SBsD
 U2If/yq7omoGMmXFaPbd7yTOWzndKD/tPiC287ZklEnLCLNgWwKgqcGOlcC6rLaEuA8aMibBI
 kzSZCNwzRs4DLA1NDEFkkRlJWEZ6JOkNLSW5Vt6bnsxV4EzI/BGwpm9a/XGXw6yZiiqqXET/t
 aprAN8ZlSJJcK7sjDTnlKGGsLV/dm8gAx+v0nfLYfeSqc8rAktmvMLm1fnH1aK3R9TwYBHkxe
 iu+NjzrE47vuHaAPpj2KLjocVOcmx9B0JfxpXpRjyXvWjc8XQxhgblNsffJ17gPR70oAyTtMr
 twtf4+O51liNOFwlTvwA==
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
index 46e8a8f8b6f1..ce995d4fa1f4 100644
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


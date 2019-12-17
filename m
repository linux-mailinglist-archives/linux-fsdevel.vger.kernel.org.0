Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 54290123971
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Dec 2019 23:18:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfLQWRx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Dec 2019 17:17:53 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:42629 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726733AbfLQWRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Dec 2019 17:17:48 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mzhf5-1hlv0p2OMj-00vgXP; Tue, 17 Dec 2019 23:17:34 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        y2038@lists.linaro.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Ben Hutchings <ben.hutchings@codethink.co.uk>,
        linux-doc@vger.kernel.org, corbet@lwn.net, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 25/27] compat_ioctl: block: simplify compat_blkpg_ioctl()
Date:   Tue, 17 Dec 2019 23:17:06 +0100
Message-Id: <20191217221708.3730997-26-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191217221708.3730997-1-arnd@arndb.de>
References: <20191217221708.3730997-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u56YlEGvfOa9zyhVPxWeQqyyoHmVfXUnvL4Wd9qSUxbgXqKfNbk
 iDq+NFs5bgKJDjeu7lGnuYYHi3u/BRMa/UcOlmalAwI2H3P5YhBTDahqHW/DAc+lt0Hhgw4
 vLYECIgCJZGl+I7guuXe2oI+wxIscuJl80F0kddfubjLPvNRRB6U0/XdvmrbKjjNezmZ9j2
 9+jZtiIYRPvS3t58syV5w==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:BsIoG4Z5w2Y=:A1Ag1+Uyp7HVkUxJlC4qWg
 rhyX78tMCYlnIGy3LuqwuziiIzcT3YTTOH4OX9r4adRYRTBfULoxLMOyRTwe4mlEM/nSYZt74
 zNhRZR0aLBvuasUfLWWwm6CZBaUyCFlSIjhdixhboNw7av3BKYmf0czmbvkn4uQQVi9gwMeuY
 OoFqlXqocn9lHT7Mv1ozdaVpy3H9Sd9l8Qm3Iu9Nno5pJiwxXDGHf56JqEg+s3NLZfNqA6OZ0
 Bn1lWTMLw4GqZmwyBG25tUUwh9JPPF2vONgMwIPwsb30VFL1bHu+azoMlyH1N646Ri5FpMVaD
 sHiMAC4L8cuxOrI3y6HmNpvnq1zzEauJA9El76OrQ0olKbn9U8Tjot97/cpUT5qeNTT0UasMk
 SIHAH/9XHerjD5sCDID0BhGaszJXf/toBnQVWzrYW0oA0MH67RWlY4fcp9lw7bFKUFttz+CLB
 q8VUfzeAqNWTqX0qE0dfDZlH3pL9QavtoP2qL32K7hUEQX6d7CdlpWednik//c9xm3Qye5+eq
 R3An18Y9fn5EZjy/oseZH5rpfGEW6gn91At2RmvlzAF0ou/9QmIdlwesXBix/D+wQ7J8gqwAV
 ZDCeSNLRMn+zLi76kfK45CX0rm+BWmG2AldhjSgNCABc3PIQhQqt4XRYSBc8jgf/cKt2KOQIO
 Djm8Jgi/L/VxcQ8K2eJU88hhhU40z+cS1T8Cd8VT2FVdnetClznvBoWmLmrbQ51yyGc3ITrfQ
 ug2bg5CRthgohTeHncxRK4/NnXb+TyvDGEdlOaf3rGnz1aheRruKAV1I30N/3aSlk2bQkhEGl
 0VmiHbbdZZUE2KUIiovszFRvIWeQSr+Sih1AaBqeWqs2OjM/GyTpU9x9fQm0EB+PFl4lZFvcE
 XJZWwiN8A8nAoene4fsw==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There is no need to go through a compat_alloc_user_space()
copy any more, just wrap the function in a small helper that
works the same way for native and compat mode.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/ioctl.c | 74 ++++++++++++++++++++++++++-------------------------
 1 file changed, 38 insertions(+), 36 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index f8c4e2649335..d6911a1149f5 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -12,12 +12,12 @@
 #include <linux/pr.h>
 #include <linux/uaccess.h>
 
-static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user *arg)
+static int blkpg_do_ioctl(struct block_device *bdev,
+			  struct blkpg_partition __user *upart, int op)
 {
 	struct block_device *bdevp;
 	struct gendisk *disk;
 	struct hd_struct *part, *lpart;
-	struct blkpg_ioctl_arg a;
 	struct blkpg_partition p;
 	struct disk_part_iter piter;
 	long long start, length;
@@ -25,9 +25,7 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
-	if (copy_from_user(&a, arg, sizeof(struct blkpg_ioctl_arg)))
-		return -EFAULT;
-	if (copy_from_user(&p, a.data, sizeof(struct blkpg_partition)))
+	if (copy_from_user(&p, upart, sizeof(struct blkpg_partition)))
 		return -EFAULT;
 	disk = bdev->bd_disk;
 	if (bdev != bdev->bd_contains)
@@ -35,7 +33,7 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 	partno = p.pno;
 	if (partno <= 0)
 		return -EINVAL;
-	switch (a.op) {
+	switch (op) {
 		case BLKPG_ADD_PARTITION:
 			start = p.start >> 9;
 			length = p.length >> 9;
@@ -156,6 +154,39 @@ static int blkpg_ioctl(struct block_device *bdev, struct blkpg_ioctl_arg __user
 	}
 }
 
+static int blkpg_ioctl(struct block_device *bdev,
+		       struct blkpg_ioctl_arg __user *arg)
+{
+	struct blkpg_partition __user *udata;
+	int op;
+
+	if (get_user(op, &arg->op) || get_user(udata, &arg->data))
+		return -EFAULT;
+
+	return blkpg_do_ioctl(bdev, udata, op);
+}
+
+#ifdef CONFIG_COMPAT
+struct compat_blkpg_ioctl_arg {
+	compat_int_t op;
+	compat_int_t flags;
+	compat_int_t datalen;
+	compat_caddr_t data;
+};
+
+static int compat_blkpg_ioctl(struct block_device *bdev,
+			      struct compat_blkpg_ioctl_arg __user *arg)
+{
+	compat_caddr_t udata;
+	int op;
+
+	if (get_user(op, &arg->op) || get_user(udata, &arg->data))
+		return -EFAULT;
+
+	return blkpg_do_ioctl(bdev, compat_ptr(udata), op);
+}
+#endif
+
 static int blkdev_reread_part(struct block_device *bdev)
 {
 	int ret;
@@ -676,35 +707,6 @@ int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
 EXPORT_SYMBOL_GPL(blkdev_ioctl);
 
 #ifdef CONFIG_COMPAT
-struct compat_blkpg_ioctl_arg {
-	compat_int_t op;
-	compat_int_t flags;
-	compat_int_t datalen;
-	compat_caddr_t data;
-};
-
-static int compat_blkpg_ioctl(struct block_device *bdev, fmode_t mode,
-		unsigned int cmd, struct compat_blkpg_ioctl_arg __user *ua32)
-{
-	struct blkpg_ioctl_arg __user *a = compat_alloc_user_space(sizeof(*a));
-	compat_caddr_t udata;
-	compat_int_t n;
-	int err;
-
-	err = get_user(n, &ua32->op);
-	err |= put_user(n, &a->op);
-	err |= get_user(n, &ua32->flags);
-	err |= put_user(n, &a->flags);
-	err |= get_user(n, &ua32->datalen);
-	err |= put_user(n, &a->datalen);
-	err |= get_user(udata, &ua32->data);
-	err |= put_user(compat_ptr(udata), &a->data);
-	if (err)
-		return err;
-
-	return blkdev_ioctl(bdev, mode, cmd, (unsigned long)a);
-}
-
 #define BLKBSZGET_32		_IOR(0x12, 112, int)
 #define BLKBSZSET_32		_IOW(0x12, 113, int)
 #define BLKGETSIZE64_32		_IOR(0x12, 114, int)
@@ -767,7 +769,7 @@ long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 		return blkdev_ioctl(bdev, mode, BLKBSZSET,
 				(unsigned long)compat_ptr(arg));
 	case BLKPG:
-		return compat_blkpg_ioctl(bdev, mode, cmd, compat_ptr(arg));
+		return compat_blkpg_ioctl(bdev, compat_ptr(arg));
 	case BLKRAGET:
 	case BLKFRAGET:
 		if (!arg)
-- 
2.20.0


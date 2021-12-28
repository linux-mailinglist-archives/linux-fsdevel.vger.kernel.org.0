Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33232480C9E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Dec 2021 19:42:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237104AbhL1Smh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Dec 2021 13:42:37 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61586 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S237099AbhL1Smg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Dec 2021 13:42:36 -0500
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.16.1.2/8.16.1.2) with ESMTP id 1BSB8RAp020118
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 10:42:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=evbN69T3QxNVx+WY39C6l4/zLIQujwuSG/KcVoYSBm4=;
 b=RxEG9AgEm/lios15ZotbmOYDekN0viaQW0tbW1iOJuMrDLoN3zETDXatSKdfzNVixOkI
 IsMUnd8s/7WXmyn2M0bPI8fcSelKTm1bI9zGLSOJ5mwNFhzUYrb6Eikegdrnd2PZGdwB
 FsxmuG3ehEfPieQh5KqOjp48OvK0khUmvDI= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by m0001303.ppops.net (PPS) with ESMTPS id 3d80p4a74r-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 28 Dec 2021 10:42:36 -0800
Received: from twshared18912.14.frc2.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::6) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 28 Dec 2021 10:42:02 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 1E0758B3D9C6; Tue, 28 Dec 2021 10:41:48 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     <torvalds@linux-foundation.org>, <christian.brauner@ubuntu.com>,
        <shr@fb.com>
Subject: [PATCH v9 2/5] fs: split off setxattr_copy and do_setxattr function from setxattr
Date:   Tue, 28 Dec 2021 10:41:42 -0800
Message-ID: <20211228184145.1131605-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211228184145.1131605-1-shr@fb.com>
References: <20211228184145.1131605-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: zSds_guRur5IBWYEx9giWrmd6MbSLS2A
X-Proofpoint-ORIG-GUID: zSds_guRur5IBWYEx9giWrmd6MbSLS2A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-28_10,2021-12-28_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112280084
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This splits of the setup part of the function
setxattr in its own dedicated function called
setxattr_copy. In addition it also exposes a
new function called do_setxattr for making the
setxattr call.

This makes it possible to call these two functions
from io_uring in the processing of an xattr request.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/internal.h | 21 +++++++++++++
 fs/xattr.c    | 82 ++++++++++++++++++++++++++++++++++++---------------
 2 files changed, 80 insertions(+), 23 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 432ea3ce76ec..00c98b0cd634 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -202,3 +202,24 @@ struct linux_dirent64;
=20
 int vfs_getdents(struct file *file, struct linux_dirent64 __user *dirent=
,
 		 unsigned int count, loff_t *pos);
+
+ /*
+  * fs/xattr.c:
+  */
+struct xattr_name {
+	char name[XATTR_NAME_MAX + 1];
+};
+
+struct xattr_ctx {
+	/* Value of attribute */
+	const void __user *value;
+	void *kvalue;
+	size_t size;
+	/* Attribute name */
+	struct xattr_name *kname;
+	unsigned int flags;
+};
+
+int setxattr_copy(const char __user *name, struct xattr_ctx *ctx);
+int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry=
,
+		struct xattr_ctx *ctx);
diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c5175b385..923ba944d20e 100644
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@ -25,6 +25,8 @@
=20
 #include <linux/uaccess.h>
=20
+#include "internal.h"
+
 static const char *
 strcmp_prefix(const char *a, const char *a_prefix)
 {
@@ -539,43 +541,77 @@ EXPORT_SYMBOL_GPL(vfs_removexattr);
 /*
  * Extended attribute SET operations
  */
-static long
-setxattr(struct user_namespace *mnt_userns, struct dentry *d,
-	 const char __user *name, const void __user *value, size_t size,
-	 int flags)
+
+int setxattr_copy(const char __user *name, struct xattr_ctx *ctx)
 {
 	int error;
-	void *kvalue =3D NULL;
-	char kname[XATTR_NAME_MAX + 1];
=20
-	if (flags & ~(XATTR_CREATE|XATTR_REPLACE))
+	if (ctx->flags & ~(XATTR_CREATE|XATTR_REPLACE))
 		return -EINVAL;
=20
-	error =3D strncpy_from_user(kname, name, sizeof(kname));
-	if (error =3D=3D 0 || error =3D=3D sizeof(kname))
-		error =3D -ERANGE;
+	error =3D strncpy_from_user(ctx->kname->name, name,
+				sizeof(ctx->kname->name));
+	if (error =3D=3D 0 || error =3D=3D sizeof(ctx->kname->name))
+		return  -ERANGE;
 	if (error < 0)
 		return error;
=20
-	if (size) {
-		if (size > XATTR_SIZE_MAX)
+	if (ctx->size) {
+		if (ctx->size > XATTR_SIZE_MAX)
 			return -E2BIG;
-		kvalue =3D kvmalloc(size, GFP_KERNEL);
-		if (!kvalue)
+
+		ctx->kvalue =3D kvmalloc(ctx->size, GFP_KERNEL);
+		if (!ctx->kvalue)
 			return -ENOMEM;
-		if (copy_from_user(kvalue, value, size)) {
-			error =3D -EFAULT;
-			goto out;
+
+		if (copy_from_user(ctx->kvalue, ctx->value, ctx->size)) {
+			kvfree(ctx->kvalue);
+			return -EFAULT;
 		}
-		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) =3D=3D 0) ||
-		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) =3D=3D 0))
-			posix_acl_fix_xattr_from_user(mnt_userns, kvalue, size);
 	}
=20
-	error =3D vfs_setxattr(mnt_userns, d, kname, kvalue, size, flags);
-out:
-	kvfree(kvalue);
+	return 0;
+}
+
+static void setxattr_convert(struct user_namespace *mnt_userns,
+			struct xattr_ctx *ctx)
+{
+	if (ctx->size &&
+		((strcmp(ctx->kname->name, XATTR_NAME_POSIX_ACL_ACCESS) =3D=3D 0) ||
+		(strcmp(ctx->kname->name, XATTR_NAME_POSIX_ACL_DEFAULT) =3D=3D 0)))
+		posix_acl_fix_xattr_from_user(mnt_userns, ctx->kvalue, ctx->size);
+}
+
+int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry=
,
+		struct xattr_ctx *ctx)
+{
+	setxattr_convert(mnt_userns, ctx);
+	return vfs_setxattr(mnt_userns, dentry, ctx->kname->name,
+			ctx->kvalue, ctx->size, ctx->flags);
+}
+
+static long
+setxattr(struct user_namespace *mnt_userns, struct dentry *d,
+	const char __user *name, const void __user *value, size_t size,
+	int flags)
+{
+	struct xattr_name kname;
+	struct xattr_ctx ctx =3D {
+		.value    =3D value,
+		.kvalue   =3D NULL,
+		.size     =3D size,
+		.kname    =3D &kname,
+		.flags    =3D flags,
+	};
+	int error;
+
+	error =3D setxattr_copy(name, &ctx);
+	if (error)
+		return error;
+
+	error =3D do_setxattr(mnt_userns, d, &ctx);
=20
+	kvfree(ctx.kvalue);
 	return error;
 }
=20
--=20
2.30.2


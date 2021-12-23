Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9242C47E88B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Dec 2021 20:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350181AbhLWT5Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Dec 2021 14:57:25 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:30926 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350134AbhLWT5Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Dec 2021 14:57:24 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BN6toF1032203
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 11:57:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=7/A1DepU/fBrUyy/BRZEvS2npa+SOw9kN2ynssO49yc=;
 b=Q/x7jk3g0JRosLVgG4TEM0VamlV3WBiDQvhKkwQH1oDMC+rmbpNlDK84ykIGRjHXYxao
 YNFQhntLymrtjNTK3+wOytxkPZuAV6D76aofWJOUHBSQx9hlc0lyrLdjaD2HOo2Ek9rC
 FbKGih+ZI5fIX8b95qOPrUscbaatEG9As5g= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d4m96vhsv-19
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Dec 2021 11:57:24 -0800
Received: from twshared3115.02.ash8.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:11d::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 23 Dec 2021 11:57:20 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id C2E5B87A074B; Thu, 23 Dec 2021 11:57:08 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     <torvalds@linux-foundation.org>, <christian.brauner@ubuntu.com>,
        <shr@fb.com>
Subject: [PATCH v7 2/5] fs: split off setxattr_copy and do_setxattr function from setxattr
Date:   Thu, 23 Dec 2021 11:56:55 -0800
Message-ID: <20211223195658.2805049-3-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211223195658.2805049-1-shr@fb.com>
References: <20211223195658.2805049-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: qp5S-x1_sbAnFvb--hlnLHkobFfDQZ5L
X-Proofpoint-GUID: qp5S-x1_sbAnFvb--hlnLHkobFfDQZ5L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-23_04,2021-12-22_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 suspectscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 mlxlogscore=999
 clxscore=1015 spamscore=0 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112230102
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
 fs/internal.h | 19 +++++++++++
 fs/xattr.c    | 87 ++++++++++++++++++++++++++++++++++++++-------------
 2 files changed, 84 insertions(+), 22 deletions(-)

diff --git a/fs/internal.h b/fs/internal.h
index 432ea3ce76ec..28b9f947f26e 100644
--- a/fs/internal.h
+++ b/fs/internal.h
@@ -202,3 +202,22 @@ struct linux_dirent64;
=20
 int vfs_getdents(struct file *file, struct linux_dirent64 __user *dirent=
,
 		 unsigned int count, loff_t *pos);
+
+ /*
+  * fs/xattr.c:
+  */
+struct xattr_ctx {
+	/* Value of attribute */
+	const void __user *value;
+	size_t size;
+	/* Attribute name */
+	char *kname;
+	int kname_sz;
+	unsigned int flags;
+};
+
+
+int setxattr_copy(const char __user *name, struct xattr_ctx *ctx,
+		void **xattr_val);
+int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry=
,
+		struct xattr_ctx *ctx, void *xattr_val);
diff --git a/fs/xattr.c b/fs/xattr.c
index 5c8c5175b385..fbe6c2b7ec47 100644
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
@@ -539,43 +541,84 @@ EXPORT_SYMBOL_GPL(vfs_removexattr);
 /*
  * Extended attribute SET operations
  */
-static long
-setxattr(struct user_namespace *mnt_userns, struct dentry *d,
-	 const char __user *name, const void __user *value, size_t size,
-	 int flags)
+
+int setxattr_copy(const char __user *name, struct xattr_ctx *ctx,
+		void **xattr_val)
 {
-	int error;
 	void *kvalue =3D NULL;
-	char kname[XATTR_NAME_MAX + 1];
+	int error;
=20
-	if (flags & ~(XATTR_CREATE|XATTR_REPLACE))
+	if (ctx->flags & ~(XATTR_CREATE|XATTR_REPLACE))
 		return -EINVAL;
=20
-	error =3D strncpy_from_user(kname, name, sizeof(kname));
-	if (error =3D=3D 0 || error =3D=3D sizeof(kname))
-		error =3D -ERANGE;
+	error =3D strncpy_from_user(ctx->kname, name, ctx->kname_sz);
+	if (error =3D=3D 0 || error =3D=3D ctx->kname_sz)
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
+
+		kvalue =3D kvmalloc(ctx->size, GFP_KERNEL);
 		if (!kvalue)
 			return -ENOMEM;
-		if (copy_from_user(kvalue, value, size)) {
-			error =3D -EFAULT;
-			goto out;
+
+		if (copy_from_user(kvalue, ctx->value, ctx->size)) {
+			kvfree(kvalue);
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
+	*xattr_val =3D kvalue;
+	return 0;
+}
+
+static void setxattr_convert(struct user_namespace *mnt_userns,
+			struct xattr_ctx *ctx, void *xattr_value)
+{
+	if (ctx->size &&
+		((strcmp(ctx->kname, XATTR_NAME_POSIX_ACL_ACCESS) =3D=3D 0) ||
+		(strcmp(ctx->kname, XATTR_NAME_POSIX_ACL_DEFAULT) =3D=3D 0)))
+		posix_acl_fix_xattr_from_user(mnt_userns, xattr_value, ctx->size);
+}
+
+int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry=
,
+		struct xattr_ctx *ctx, void *xattr_value)
+{
+	int error;
+
+	setxattr_convert(mnt_userns, ctx, xattr_value);
+	error =3D vfs_setxattr(mnt_userns, dentry, ctx->kname,
+			xattr_value, ctx->size, ctx->flags);
+
+	return error;
+}
+
+static long
+setxattr(struct user_namespace *mnt_userns, struct dentry *d,
+	const char __user *name, const void __user *value, size_t size,
+	int flags)
+{
+	char kname[XATTR_NAME_MAX + 1];
+	struct xattr_ctx ctx =3D {
+		.value    =3D value,
+		.size     =3D size,
+		.kname    =3D kname,
+		.kname_sz =3D sizeof(kname),
+		.flags    =3D flags,
+	};
+	void *xattr_value =3D NULL;
+	int error;
+
+	error =3D setxattr_copy(name, &ctx, &xattr_value);
+	if (error)
+		return error;
+
+	error =3D do_setxattr(mnt_userns, d, &ctx, xattr_value);
=20
+	kvfree(xattr_value);
 	return error;
 }
=20
--=20
2.30.2


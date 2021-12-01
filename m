Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31954646E2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 06:51:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346816AbhLAFzQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 00:55:16 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:57752 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1346808AbhLAFzO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 00:55:14 -0500
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B10XHR2003528
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 21:51:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=facebook;
 bh=vxtuKADC3kJmyhe7dFgu1SS+zEuy8gw4KZIS5/m7GCc=;
 b=PDmAU+167KYrOBSVugAEmDeIDOPEQVuJhHpXe1ouY2kSqGLyyaQhxpEqYU25fPCU8C5i
 ot+LIqNH3o3I6keUGI/TROC8HVzUOEPbiC9BIg0ALckm/YThuK5IkdPftlPwcfAdRaWU
 RG3Sh8UWrmnigTLqlk3/rxC86uzUd6B7Go0= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3cnvbttfw5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Nov 2021 21:51:54 -0800
Received: from intmgw002.25.frc3.facebook.com (2620:10d:c085:208::f) by
 mail.thefacebook.com (2620:10d:c085:21d::5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 30 Nov 2021 21:51:53 -0800
Received: by devvm225.atn0.facebook.com (Postfix, from userid 425415)
        id 6CACF7227187; Tue, 30 Nov 2021 21:51:46 -0800 (PST)
From:   Stefan Roesch <shr@fb.com>
To:     <io-uring@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <kernel-team@fb.com>
CC:     <shr@fb.com>
Subject: [PATCH v2 4/5] io_uring: add fsetxattr and setxattr support
Date:   Tue, 30 Nov 2021 21:51:43 -0800
Message-ID: <20211201055144.3141001-5-shr@fb.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211201055144.3141001-1-shr@fb.com>
References: <20211201055144.3141001-1-shr@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-FB-Source: Intern
X-Proofpoint-ORIG-GUID: MEOR-pVtSjLbQb6iN47cJK3h0cHKCEwt
X-Proofpoint-GUID: MEOR-pVtSjLbQb6iN47cJK3h0cHKCEwt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015 phishscore=0
 impostorscore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112010033
X-FB-Internal: deliver
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds support to io_uring for the fsetxattr and setxattr API.

Signed-off-by: Stefan Roesch <shr@fb.com>
---
 fs/io_uring.c                 | 174 ++++++++++++++++++++++++++++++++++
 include/uapi/linux/io_uring.h |   6 +-
 2 files changed, 179 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 568729677e25..9d977bf243fd 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -81,6 +81,7 @@
 #include <linux/tracehook.h>
 #include <linux/audit.h>
 #include <linux/security.h>
+#include <linux/xattr.h>
=20
 #define CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
@@ -717,6 +718,13 @@ struct io_async_rw {
 	struct wait_page_queue		wpq;
 };
=20
+struct io_xattr {
+	struct file			*file;
+	struct xattr_ctx		ctx;
+	void				*value;
+	struct filename			*filename;
+};
+
 enum {
 	REQ_F_FIXED_FILE_BIT	=3D IOSQE_FIXED_FILE_BIT,
 	REQ_F_IO_DRAIN_BIT	=3D IOSQE_IO_DRAIN_BIT,
@@ -856,6 +864,7 @@ struct io_kiocb {
 		struct io_mkdir		mkdir;
 		struct io_symlink	symlink;
 		struct io_hardlink	hardlink;
+		struct io_xattr		xattr;
 	};
=20
 	u8				opcode;
@@ -1105,6 +1114,10 @@ static const struct io_op_def io_op_defs[] =3D {
 	[IORING_OP_MKDIRAT] =3D {},
 	[IORING_OP_SYMLINKAT] =3D {},
 	[IORING_OP_LINKAT] =3D {},
+	[IORING_OP_FSETXATTR] =3D {
+		.needs_file =3D 1
+	},
+	[IORING_OP_SETXATTR] =3D {},
 };
=20
 /* requests with any of those set should undergo io_disarm_next() */
@@ -3818,6 +3831,147 @@ static int io_renameat(struct io_kiocb *req, unsi=
gned int issue_flags)
 	return 0;
 }
=20
+static int __io_setxattr_prep(struct io_kiocb *req,
+			const struct io_uring_sqe *sqe,
+			struct user_namespace *user_ns)
+{
+	struct io_xattr *ix =3D &req->xattr;
+	const char __user *name;
+	void *ret;
+
+	if (unlikely(req->ctx->flags & IORING_SETUP_IOPOLL))
+		return -EINVAL;
+	if (unlikely(sqe->ioprio))
+		return -EINVAL;
+	if (unlikely(req->flags & REQ_F_FIXED_FILE))
+		return -EBADF;
+
+	ix->filename =3D NULL;
+	name =3D u64_to_user_ptr(READ_ONCE(sqe->addr));
+	ix->ctx.value =3D u64_to_user_ptr(READ_ONCE(sqe->addr2));
+	ix->ctx.size =3D READ_ONCE(sqe->len);
+	ix->ctx.flags =3D READ_ONCE(sqe->xattr_flags);
+
+	ix->ctx.kname =3D kmalloc(XATTR_NAME_MAX + 1, GFP_KERNEL);
+	if (!ix->ctx.kname)
+		return -ENOMEM;
+	ix->ctx.kname_sz =3D XATTR_NAME_MAX + 1;
+
+	ret =3D setxattr_setup(user_ns, name, &ix->ctx);
+	if (IS_ERR(ret)) {
+		kfree(ix->ctx.kname);
+		return PTR_ERR(ret);
+	}
+
+	ix->value =3D ret;
+	req->flags |=3D REQ_F_NEED_CLEANUP;
+	return 0;
+}
+
+static int io_setxattr_prep(struct io_kiocb *req,
+			const struct io_uring_sqe *sqe)
+{
+	struct io_xattr *ix =3D &req->xattr;
+	const char __user *path;
+	int ret;
+
+	ret =3D __io_setxattr_prep(req, sqe, current_user_ns());
+	if (ret)
+		return ret;
+
+	path =3D u64_to_user_ptr(READ_ONCE(sqe->addr3));
+
+	ix->filename =3D getname_flags(path, LOOKUP_FOLLOW, NULL);
+	if (IS_ERR(ix->filename)) {
+		ret =3D PTR_ERR(ix->filename);
+		ix->filename =3D NULL;
+	}
+
+	return ret;
+}
+
+static int io_fsetxattr_prep(struct io_kiocb *req,
+			const struct io_uring_sqe *sqe)
+{
+	if (!req->file)
+		return -EBADF;
+
+	return __io_setxattr_prep(req, sqe, file_mnt_user_ns(req->file));
+}
+
+static int __io_setxattr(struct io_kiocb *req, unsigned int issue_flags,
+			struct path *path)
+{
+	struct io_xattr *ix =3D &req->xattr;
+	int ret;
+
+	ret =3D mnt_want_write(path->mnt);
+	if (!ret) {
+		ret =3D vfs_setxattr(mnt_user_ns(path->mnt), path->dentry,
+				ix->ctx.kname, ix->value, ix->ctx.size,
+				ix->ctx.flags);
+		mnt_drop_write(path->mnt);
+	}
+
+	return ret;
+}
+
+static int io_fsetxattr(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_xattr *ix =3D &req->xattr;
+	int ret;
+
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
+
+	ret =3D __io_setxattr(req, issue_flags, &req->file->f_path);
+
+	req->flags &=3D ~REQ_F_NEED_CLEANUP;
+	kfree(ix->ctx.kname);
+
+	if (ix->value)
+		kvfree(ix->value);
+	if (ret < 0)
+		req_set_fail(req);
+
+	io_req_complete(req, ret);
+	return 0;
+}
+
+static int io_setxattr(struct io_kiocb *req, unsigned int issue_flags)
+{
+	struct io_xattr *ix =3D &req->xattr;
+	unsigned int lookup_flags =3D LOOKUP_FOLLOW;
+	struct path path;
+	int ret;
+
+	if (issue_flags & IO_URING_F_NONBLOCK)
+		return -EAGAIN;
+
+retry:
+	ret =3D do_user_path_at_empty(AT_FDCWD, ix->filename, lookup_flags, &pa=
th);
+	putname(ix->filename);
+	if (!ret) {
+		ret =3D __io_setxattr(req, issue_flags, &path);
+		path_put(&path);
+		if (retry_estale(ret, lookup_flags)) {
+			lookup_flags |=3D LOOKUP_REVAL;
+			goto retry;
+		}
+	}
+
+	req->flags &=3D ~REQ_F_NEED_CLEANUP;
+	kfree(ix->ctx.kname);
+
+	if (ix->value)
+		kvfree(ix->value);
+	if (ret < 0)
+		req_set_fail(req);
+
+	io_req_complete(req, ret);
+	return 0;
+}
+
 static int io_unlinkat_prep(struct io_kiocb *req,
 			    const struct io_uring_sqe *sqe)
 {
@@ -6531,6 +6685,10 @@ static int io_req_prep(struct io_kiocb *req, const=
 struct io_uring_sqe *sqe)
 		return io_symlinkat_prep(req, sqe);
 	case IORING_OP_LINKAT:
 		return io_linkat_prep(req, sqe);
+	case IORING_OP_FSETXATTR:
+		return io_fsetxattr_prep(req, sqe);
+	case IORING_OP_SETXATTR:
+		return io_setxattr_prep(req, sqe);
 	}
=20
 	printk_once(KERN_WARNING "io_uring: unhandled opcode %d\n",
@@ -6674,6 +6832,15 @@ static void io_clean_op(struct io_kiocb *req)
 			putname(req->hardlink.oldpath);
 			putname(req->hardlink.newpath);
 			break;
+		case IORING_OP_SETXATTR:
+			if (req->xattr.filename)
+				putname(req->xattr.filename);
+			fallthrough;
+		case IORING_OP_FSETXATTR:
+			kfree(req->xattr.ctx.kname);
+			if (req->xattr.value)
+				kvfree(req->xattr.value);
+			break;
 		}
 	}
 	if ((req->flags & REQ_F_POLLED) && req->apoll) {
@@ -6816,6 +6983,12 @@ static int io_issue_sqe(struct io_kiocb *req, unsi=
gned int issue_flags)
 	case IORING_OP_LINKAT:
 		ret =3D io_linkat(req, issue_flags);
 		break;
+	case IORING_OP_FSETXATTR:
+		ret =3D io_fsetxattr(req, issue_flags);
+		break;
+	case IORING_OP_SETXATTR:
+		ret =3D io_setxattr(req, issue_flags);
+		break;
 	default:
 		ret =3D -EINVAL;
 		break;
@@ -11183,6 +11356,7 @@ static int __init io_uring_init(void)
 	BUILD_BUG_SQE_ELEM(42, __u16,  personality);
 	BUILD_BUG_SQE_ELEM(44, __s32,  splice_fd_in);
 	BUILD_BUG_SQE_ELEM(44, __u32,  file_index);
+	BUILD_BUG_SQE_ELEM(48, __u64,  addr3);
=20
 	BUILD_BUG_ON(sizeof(struct io_uring_files_update) !=3D
 		     sizeof(struct io_uring_rsrc_update));
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.=
h
index 787f491f0d2a..dbf473900da2 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -45,6 +45,7 @@ struct io_uring_sqe {
 		__u32		rename_flags;
 		__u32		unlink_flags;
 		__u32		hardlink_flags;
+		__u32		xattr_flags;
 	};
 	__u64	user_data;	/* data to be passed back at completion time */
 	/* pack this to avoid bogus arm OABI complaints */
@@ -60,7 +61,8 @@ struct io_uring_sqe {
 		__s32	splice_fd_in;
 		__u32	file_index;
 	};
-	__u64	__pad2[2];
+	__u64	addr3;
+	__u64	__pad2[1];
 };
=20
 enum {
@@ -143,6 +145,8 @@ enum {
 	IORING_OP_MKDIRAT,
 	IORING_OP_SYMLINKAT,
 	IORING_OP_LINKAT,
+	IORING_OP_FSETXATTR,
+	IORING_OP_SETXATTR,
=20
 	/* this goes last, obviously */
 	IORING_OP_LAST,
--=20
2.30.2


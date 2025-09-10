Return-Path: <linux-fsdevel+bounces-60803-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F02EAB51A8F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 16:58:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6FB48413E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Sep 2025 14:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA0637C0F3;
	Wed, 10 Sep 2025 14:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ll+kEwF1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29E03338F59;
	Wed, 10 Sep 2025 14:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757515200; cv=none; b=OWjewkKPBJ+yyVJ2Sg4/9eGZO40uJGOsMVbVO4nVLrHJ276nRwILeQJ+ThOvuw9IIcaFWB12GOgPDUiwq1c4uY0eYvi6lakqS5v+Uvns6ofvJ1ukvIL4aWuM2FZ72nu4lg7DTuTpYGsZaGkhyNDVmENy8s/JqWOb0HEYZAtYvgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757515200; c=relaxed/simple;
	bh=/bhxoRXWkhRdK1c5aNMl+246ELQ0nVNgj4h3FoKhvM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nUYPvg18k2ebSJc16EEKJLdfNIIORfNkueJOgMpW36xF9vn4Q0Hgte04NsOXaen/cFwQalCejnMSp16CTkBddMXd7VZ6jHdjIIyGMsIJnnhbglLF/UIkfMVBJzI2tP5UGRBO3l/3hd1TN93Ey/06VaEC92ynvrQpeWMW3GoBWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ll+kEwF1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F552C4CEFF;
	Wed, 10 Sep 2025 14:39:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757515199;
	bh=/bhxoRXWkhRdK1c5aNMl+246ELQ0nVNgj4h3FoKhvM4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ll+kEwF1z1oBF5f3RoZ+kVTXqp6+SRoBn0tEjX/tnlZM7CM7bEyXjuBcYDlHFBKIG
	 GuEdzNJFIng8675w1L88MhiZaaaOnX02CCzoz2OQrkukZ3S424U2avchDuF7EfGe4E
	 TF8tpESldvbJYERE7DCmHjaBzebU1Ejoia9sFLPa1cjaQ8urtEx9ylPKHj1aPOCt0u
	 zMfmPZfsQmIKnLagRsz2Xh5iefpCeyDiTQCNvhwHZrn9JzsKZEShyerp+DHEYFR/SW
	 jk7b2DxZ7Qm2fLSWQSCgkX/a9n5doU8ts2EIzdTABZCcLZL+esh6lKNiPrPZDhcPcg
	 rmq3c8jCO9vcQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 10 Sep 2025 16:37:14 +0200
Subject: [PATCH 29/32] nsfs: add missing id retrieval support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-work-namespace-v1-29-4dd56e7359d8@kernel.org>
References: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
In-Reply-To: <20250910-work-namespace-v1-0-4dd56e7359d8@kernel.org>
To: Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>, 
 linux-fsdevel@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>, Jeff Layton <jlayton@kernel.org>, 
 Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Lennart Poettering <mzxreary@0pointer.de>, 
 Daan De Meyer <daan.j.demeyer@gmail.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Chuck Lever <chuck.lever@oracle.com>, linux-nfs@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org, 
 netdev@vger.kernel.org, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.14.3-dev-385fa
X-Developer-Signature: v=1; a=openpgp-sha256; l=4132; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/bhxoRXWkhRdK1c5aNMl+246ELQ0nVNgj4h3FoKhvM4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc7OVkZRC7/qTS9vu6nrKH17l2rfwfyX3I8PVHaZ+HF
 pu2zNKI7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIxk1GhutynhNmPXY5mTQ3
 +XV2/eMbcx3qdfdnHVpccel2YuWjpUaMDCdi1Ccq3n7h9+Df7YCfv7Ie21cczVrFN9v41brcS6f
 mmPIDAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The mount namespace has supported id retrieval for a while already.
Add support for the other types as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c                 | 74 +++++++++++++++++++++++++++++++++++++++--------
 include/uapi/linux/nsfs.h | 12 ++++++--
 2 files changed, 72 insertions(+), 14 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 3c6fcf652633..527480e67fd1 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -173,6 +173,13 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
 	case NS_GET_NSTYPE:
 	case NS_GET_OWNER_UID:
 	case NS_GET_MNTNS_ID:
+	case NS_GET_NETNS_ID:
+	case NS_GET_CGROUPNS_ID:
+	case NS_GET_IPCNS_ID:
+	case NS_GET_UTSNS_ID:
+	case NS_GET_PIDNS_ID:
+	case NS_GET_TIMENS_ID:
+	case NS_GET_USERNS_ID:
 	case NS_GET_PID_FROM_PIDNS:
 	case NS_GET_TGID_FROM_PIDNS:
 	case NS_GET_PID_IN_PIDNS:
@@ -226,18 +233,6 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		argp = (uid_t __user *) arg;
 		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
 		return put_user(uid, argp);
-	case NS_GET_MNTNS_ID: {
-		__u64 __user *idp;
-		__u64 id;
-
-		if (ns->ops->type != CLONE_NEWNS)
-			return -EINVAL;
-
-		mnt_ns = container_of(ns, struct mnt_namespace, ns);
-		idp = (__u64 __user *)arg;
-		id = mnt_ns->ns.ns_id;
-		return put_user(id, idp);
-	}
 	case NS_GET_PID_FROM_PIDNS:
 		fallthrough;
 	case NS_GET_TGID_FROM_PIDNS:
@@ -283,6 +278,61 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			ret = -ESRCH;
 		return ret;
 	}
+	case NS_GET_MNTNS_ID:
+		fallthrough;
+	case NS_GET_NETNS_ID:
+		fallthrough;
+	case NS_GET_CGROUPNS_ID:
+		fallthrough;
+	case NS_GET_IPCNS_ID:
+		fallthrough;
+	case NS_GET_UTSNS_ID:
+		fallthrough;
+	case NS_GET_PIDNS_ID:
+		fallthrough;
+	case NS_GET_TIMENS_ID:
+		fallthrough;
+	case NS_GET_USERNS_ID: {
+		__u64 __user *idp;
+		__u64 id;
+		int expected_type;
+
+		switch (ioctl) {
+		case NS_GET_MNTNS_ID:
+			expected_type = CLONE_NEWNS;
+			break;
+		case NS_GET_NETNS_ID:
+			expected_type = CLONE_NEWNET;
+			break;
+		case NS_GET_CGROUPNS_ID:
+			expected_type = CLONE_NEWCGROUP;
+			break;
+		case NS_GET_IPCNS_ID:
+			expected_type = CLONE_NEWIPC;
+			break;
+		case NS_GET_UTSNS_ID:
+			expected_type = CLONE_NEWUTS;
+			break;
+		case NS_GET_PIDNS_ID:
+			expected_type = CLONE_NEWPID;
+			break;
+		case NS_GET_TIMENS_ID:
+			expected_type = CLONE_NEWTIME;
+			break;
+		case NS_GET_USERNS_ID:
+			expected_type = CLONE_NEWUSER;
+			break;
+		default:
+			return -EINVAL;
+		}
+
+		if (ns->ops->type != expected_type)
+			return -EINVAL;
+
+		idp = (__u64 __user *)arg;
+		id = ns->ns_id;
+		return put_user(id, idp);
+	}
 	}
 
 	/* extensible ioctls */
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index 97d8d80d139f..f7c21840cc09 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -16,8 +16,6 @@
 #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
 /* Get owner UID (in the caller's user namespace) for a user namespace */
 #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
-/* Get the id for a mount namespace */
-#define NS_GET_MNTNS_ID		_IOR(NSIO, 0x5, __u64)
 /* Translate pid from target pid namespace into the caller's pid namespace. */
 #define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x6, int)
 /* Return thread-group leader id of pid in the callers pid namespace. */
@@ -42,6 +40,16 @@ struct mnt_ns_info {
 /* Get previous namespace. */
 #define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
 
+/* Retrieve namespace identifiers. */
+#define NS_GET_MNTNS_ID		_IOR(NSIO, 5,  __u64)
+#define NS_GET_NETNS_ID		_IOR(NSIO, 13, __u64)
+#define NS_GET_CGROUPNS_ID	_IOR(NSIO, 14, __u64)
+#define NS_GET_IPCNS_ID		_IOR(NSIO, 15, __u64)
+#define NS_GET_UTSNS_ID		_IOR(NSIO, 16, __u64)
+#define NS_GET_PIDNS_ID		_IOR(NSIO, 17, __u64)
+#define NS_GET_TIMENS_ID	_IOR(NSIO, 18, __u64)
+#define NS_GET_USERNS_ID	_IOR(NSIO, 19, __u64)
+
 enum init_ns_ino {
 	IPC_NS_INIT_INO		= 0xEFFFFFFFU,
 	UTS_NS_INIT_INO		= 0xEFFFFFFEU,

-- 
2.47.3



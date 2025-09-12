Return-Path: <linux-fsdevel+bounces-61075-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFD5B54CAE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 14:10:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB5C0A07EC3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Sep 2025 12:06:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9625434DCD6;
	Fri, 12 Sep 2025 11:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uI6Mq85z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61C0345722;
	Fri, 12 Sep 2025 11:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678155; cv=none; b=qrEpsV6Eynk0Y2I6X2FLyJk0QGY5LnKbb8TC95TJFtqvnySDvmCXOQYku1hJ1qBBn6g07JVUOEvgK9hC42n7cJVGuUfj/Ll63PNe0LcozcCu59jrpqoZU7zhjhbcirrpYtQSMkly4cOFu5cQdM86LcLcClXLVR4wX177JYCF8rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678155; c=relaxed/simple;
	bh=QrmIOWpNmJ265k1EdAtkGyosrdV3+sxbSBcDaWsa/Mw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bwgeBTAaclGzgagHkk7Pj0dH9QNTXbpX+OHHAUfuTKuqlaF5JCbzX5b0/bOdpPihC8BkWxYDCyA77o98jEarwB8UEsutF7iFBaLgc89dsL9Opvd+yvOddQfxo4/w3k39pbkoPcDTvyRrkYsdoUuDQjB1E+N/DmmnG4qnQwjOkjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uI6Mq85z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB047C4CEF4;
	Fri, 12 Sep 2025 11:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757678155;
	bh=QrmIOWpNmJ265k1EdAtkGyosrdV3+sxbSBcDaWsa/Mw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uI6Mq85zq/mLU9oxrqZFZ7LEr3KHkpAk/NqATr2LkPHf7EPu+CuqDL9m4j4Sb3NPE
	 gDsqB1F2vZJGoeLH/kVxb7MDFLmaklDlRsx67mBzuh4ZqRCrwQtOWjxKh1UpteeI99
	 jwiMdtCMl9B74cCy5/4PbpUxFHAcy1tNxPM6jPs5w0G9BdkL2M/hL302xmuAt8inC9
	 whi3kTeMvoJlhCZLcCOZzSGqOKR/uguy4N6cE7ESPLUS/vLe+L3wshqGfeeHnkzLS5
	 OAt353mbQ5jGpw6/YRbWBGi37OwAdqjECh8rl9Gna+yn2CyDfwtGOvgwmRdwgWrt4q
	 pvnHbQg0IQgMQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 12 Sep 2025 13:52:53 +0200
Subject: [PATCH v2 30/33] nsfs: add missing id retrieval support
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250912-work-namespace-v2-30-1a247645cef5@kernel.org>
References: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
In-Reply-To: <20250912-work-namespace-v2-0-1a247645cef5@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2646; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QrmIOWpNmJ265k1EdAtkGyosrdV3+sxbSBcDaWsa/Mw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQc4Zyqu3LKL73QvQ/mHt55M3qHa+E0Of+iX6rVKRw3P
 qzMiuqS6ShlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI/FaG/36twqHfxCcueZ+f
 otOYLN0ffn4DV+DLCcG5ouZe0mVl9owMr3ce9OfbGynJ7X1nw5/9C2936M/YdVArwU+84X6+w/U
 XnAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The mount namespace has supported id retrieval for a while already.
Add support for the other types as well.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nsfs.c                 | 25 +++++++++++++------------
 include/uapi/linux/nsfs.h |  6 ++++--
 2 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 22765fcab18e..8484bc4dd3de 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -177,6 +177,7 @@ static bool nsfs_ioctl_valid(unsigned int cmd)
 	case NS_GET_TGID_FROM_PIDNS:
 	case NS_GET_PID_IN_PIDNS:
 	case NS_GET_TGID_IN_PIDNS:
+	case NS_GET_ID:
 		return true;
 	}
 
@@ -226,18 +227,6 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
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
@@ -283,6 +272,18 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			ret = -ESRCH;
 		return ret;
 	}
+	case NS_GET_MNTNS_ID:
+		if (ns->ops->type != CLONE_NEWNS)
+			return -EINVAL;
+		fallthrough;
+	case NS_GET_ID: {
+		__u64 __user *idp;
+		__u64 id;
+
+		idp = (__u64 __user *)arg;
+		id = ns->ns_id;
+		return put_user(id, idp);
+	}
 	}
 
 	/* extensible ioctls */
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index fa86fe3c8bd3..5d5bf22464c9 100644
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
@@ -42,6 +40,10 @@ struct mnt_ns_info {
 /* Get previous namespace. */
 #define NS_MNT_GET_PREV		_IOR(NSIO, 12, struct mnt_ns_info)
 
+/* Retrieve namespace identifiers. */
+#define NS_GET_MNTNS_ID		_IOR(NSIO, 5,  __u64)
+#define NS_GET_ID		_IOR(NSIO, 13, __u64)
+
 enum init_ns_ino {
 	IPC_NS_INIT_INO		= 0xEFFFFFFFU,
 	UTS_NS_INIT_INO		= 0xEFFFFFFEU,

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-21922-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE11590EF5B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 15:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 870F71C209CC
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Jun 2024 13:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60A0D14EC42;
	Wed, 19 Jun 2024 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hz7MfeVh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29F813DDAF
	for <linux-fsdevel@vger.kernel.org>; Wed, 19 Jun 2024 13:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718805012; cv=none; b=uTMVeGaHpbl7JYYFFhK0HmKs6KDwqbtWaY7TqIZbLp+S2ofvs75yNL3VO+JJ0JMeIFLKIRBGnR4Ova6rHWCLidjF1I6a9YENuD0z3MJYtSFwOOw2t0n9otcElvm298jMEplrH0Cc3PoOO3NlYJrSRbVtVJCH9WyY2mIM+HU6XPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718805012; c=relaxed/simple;
	bh=fCL3g8DtL84ABq8M/oNiNxKZcYZ5E1vpWj0L6GYR3jk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tR/UFgtKKSOIKEkW04wcLKxcIdRW/1glTTspc+afZSg1GIRFoTL7yRq3JY+iobQ5lSHqhQVX331HvdldZLINvxRWZ1eXEXFFBsN2f8OzR9xUFTbAqKk2hnXl3R+zdeQMdjKTLbVtGtnVk+1gHaXCiZCI+NUBbuTDFbmebXs3jTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hz7MfeVh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94674C2BBFC;
	Wed, 19 Jun 2024 13:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718805012;
	bh=fCL3g8DtL84ABq8M/oNiNxKZcYZ5E1vpWj0L6GYR3jk=;
	h=From:Date:Subject:To:Cc:From;
	b=hz7MfeVhd9bspBiENCSLCwguXHhbFUG/MfIy64Rbmy0/Dj1p+70pEdLg/8THC8UWY
	 jFNPZhsMTRPCoVCIlYbAZDdb7UeBi361ashp1wVuoevjOM3EcIMdvbh9/9IJek+HoK
	 uZu95W223bfj+/Zq+75f/E0fqk/nlVlI3Wi9KSnDxLIKm120lI9+xBSodvjL6/4SXW
	 m2stpCxpMj89CLowZrXcyl1F0xUV4j4ZpM94Xs2URY7qSZqS0AziQaWmmdutsvsJ4F
	 +/mKVRRV5LBnBjaiFJjOJwEKfQrg07ty/aNpOLW32hesJDzgc5negiGCiNecx3dI23
	 OWnGZQUlKI7NQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 19 Jun 2024 15:49:57 +0200
Subject: [PATCH] nsfs: add pid translation ioctls
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240619-work-ns_ioctl-v1-1-7c0097e6bb6b@kernel.org>
X-B4-Tracking: v=1; b=H4sIAATicmYC/x3MQQrCMBBA0auUWTslCaE1XkVE0ji1g5qUmVKF0
 rsbXb7F/xsoCZPCqdlAaGXlkivsoYE0xXwn5Fs1OOO86WzAd5EHZr1yScsTve9DH9Jojs5AbWa
 hkT//3/lSPUQlHCTmNP0ur6gLSbt2rTUoycK+fwFR73gNggAAAA==
To: linux-fsdevel@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>, 
 Stephane Graber <stgraber@stgraber.org>, 
 Tycho Andersen <tandersen@netflix.com>, Aleksa Sarai <cyphar@cyphar.com>, 
 Joel Fernandes <joel@joelfernandes.org>
X-Mailer: b4 0.15-dev-13183
X-Developer-Signature: v=1; a=openpgp-sha256; l=5124; i=brauner@kernel.org;
 h=from:subject:message-id; bh=fCL3g8DtL84ABq8M/oNiNxKZcYZ5E1vpWj0L6GYR3jk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQVPRJq/v3XbXcLX59z3ds02c8XV+banFZ4Z/9BcU3qu
 4gcMTv5jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYzmRkOMCybbLJFauKvQlO
 N/8du83gd7NxEkengMjbG7lc4qG1Sxj+51xX8hSafi7klT2br6fzDOEHD732zbl1VdK3zVbizem
 PDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Add ioctl()s to translate pids between pid namespaces.

LXCFS is a tiny fuse filesystem used to virtualize various aspects of
procfs. LXCFS is run on the host. The files and directories it creates
can be bind-mounted by e.g. a container at startup and mounted over the
various procfs files the container wishes to have virtualized. When e.g.
a read request for uptime is received, LXCFS will receive the pid of the
reader. In order to virtualize the corresponding read, LXCFS needs to
know the pid of the init process of the reader's pid namespace. In order
to do this, LXCFS first needs to fork() two helper processes. The first
helper process setns() to the readers pid namespace. The second helper
process is needed to create a process that is a proper member of the pid
namespace. The second helper process then creates a ucred message with
ucred.pid set to 1 and sends it back to LXCFS. The kernel will translate
the ucred.pid field to the corresponding pid number in LXCFS's pid
namespace. This way LXCFS can learn the init pid number of the reader's
pid namespace and can go on to virtualize. Since these two forks() are
costly LXCFS maintains an init pid cache that caches a given pid for a
fixed amount of time. The cache is pruned during new read requests.
However, even with the cache the hit of the two forks() is singificant
when a very large number of containers are running. With this simple
patch we add an ns ioctl that let's a caller retrieve the init pid nr of
a pid namespace through its pid namespace fd. This significantly
improves performance with a very simple change.

Support translation of pids and tgids. Other concepts can be added but
there are no obvious users for this right now.

To protect against races pidfds can be used to check whether the process
is still valid. If needed, this can also be extended to work on pidfds
directly.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
---
 fs/nsfs.c                 | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 include/uapi/linux/nsfs.h |  8 ++++++++
 2 files changed, 55 insertions(+)

diff --git a/fs/nsfs.c b/fs/nsfs.c
index 07e22a15ef02..4a4d7b1eb38c 100644
--- a/fs/nsfs.c
+++ b/fs/nsfs.c
@@ -8,9 +8,11 @@
 #include <linux/magic.h>
 #include <linux/ktime.h>
 #include <linux/seq_file.h>
+#include <linux/pid_namespace.h>
 #include <linux/user_namespace.h>
 #include <linux/nsfs.h>
 #include <linux/uaccess.h>
+#include <linux/cleanup.h>
 
 #include "internal.h"
 
@@ -123,9 +125,12 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 			unsigned long arg)
 {
 	struct user_namespace *user_ns;
+	struct pid_namespace *pid_ns;
+	struct task_struct *tsk;
 	struct ns_common *ns = get_proc_ns(file_inode(filp));
 	uid_t __user *argp;
 	uid_t uid;
+	pid_t pid_nr;
 
 	switch (ioctl) {
 	case NS_GET_USERNS:
@@ -143,6 +148,48 @@ static long ns_ioctl(struct file *filp, unsigned int ioctl,
 		argp = (uid_t __user *) arg;
 		uid = from_kuid_munged(current_user_ns(), user_ns->owner);
 		return put_user(uid, argp);
+	case NS_GET_PID_FROM_PIDNS:
+		fallthrough;
+	case NS_GET_TGID_FROM_PIDNS:
+		fallthrough;
+	case NS_GET_PID_IN_PIDNS:
+		fallthrough;
+	case NS_GET_TGID_IN_PIDNS:
+		if (ns->ops->type != CLONE_NEWPID)
+			return -EINVAL;
+
+		pid_ns = container_of(ns, struct pid_namespace, ns);
+
+		guard(rcu)();
+		if (ioctl == NS_GET_PID_IN_PIDNS ||
+		    ioctl == NS_GET_TGID_IN_PIDNS)
+			tsk = find_task_by_vpid(arg);
+		else
+			tsk = find_task_by_pid_ns(arg, pid_ns);
+		if (!tsk)
+			return -ESRCH;
+
+		switch (ioctl) {
+		case NS_GET_PID_FROM_PIDNS:
+			pid_nr = task_pid_vnr(tsk);
+			break;
+		case NS_GET_TGID_FROM_PIDNS:
+			pid_nr = task_tgid_vnr(tsk);
+			break;
+		case NS_GET_PID_IN_PIDNS:
+			pid_nr = task_pid_nr_ns(tsk, pid_ns);
+			break;
+		case NS_GET_TGID_IN_PIDNS:
+			pid_nr = task_tgid_nr_ns(tsk, pid_ns);
+			break;
+		default:
+			pid_nr = 0;
+			break;
+		}
+		if (!pid_nr)
+			return -ESRCH;
+
+		return pid_nr;
 	default:
 		return -ENOTTY;
 	}
diff --git a/include/uapi/linux/nsfs.h b/include/uapi/linux/nsfs.h
index a0c8552b64ee..faeb9195da08 100644
--- a/include/uapi/linux/nsfs.h
+++ b/include/uapi/linux/nsfs.h
@@ -15,5 +15,13 @@
 #define NS_GET_NSTYPE		_IO(NSIO, 0x3)
 /* Get owner UID (in the caller's user namespace) for a user namespace */
 #define NS_GET_OWNER_UID	_IO(NSIO, 0x4)
+/* Translate pid from target pid namespace into the caller's pid namespace. */
+#define NS_GET_PID_FROM_PIDNS	_IOR(NSIO, 0x5, int)
+/* Return thread-group leader id of pid in the callers pid namespace. */
+#define NS_GET_TGID_FROM_PIDNS	_IOR(NSIO, 0x7, int)
+/* Translate pid from caller's pid namespace into a target pid namespace. */
+#define NS_GET_PID_IN_PIDNS	_IOR(NSIO, 0x6, int)
+/* Return thread-group leader id of pid in the target pid namespace. */
+#define NS_GET_TGID_IN_PIDNS	_IOR(NSIO, 0x8, int)
 
 #endif /* __LINUX_NSFS_H */

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240619-work-ns_ioctl-447979cf0820



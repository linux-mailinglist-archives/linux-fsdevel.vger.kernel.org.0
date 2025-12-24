Return-Path: <linux-fsdevel+bounces-72045-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94453CDC2AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 13:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7992D3008D44
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Dec 2025 12:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4912EDD63;
	Wed, 24 Dec 2025 12:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiKNfV6C"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379D51C5F1B
	for <linux-fsdevel@vger.kernel.org>; Wed, 24 Dec 2025 12:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766577641; cv=none; b=ffQJrwfRcZMn2OonbYlbHXkONRJUM8NNc1kLOQYGw89d1nOVNUmVgw3FcMPIQyzlXC4KMDvxiP54rgXlMzBLZkAipqrZerpKRRyFG/EIQCWeZZEmaGJuJXa+txPiJQ29TKaQeGlodOX/LCj/5BqwT0Qy8A/0MFSYsMSTcLwHB0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766577641; c=relaxed/simple;
	bh=nDp3W7aZADOLuHOyGpLYX8Z6yb2C24/EhbHScbEhUJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZFTSB5xFWc0RvRvJuxpo9voDwysHoHvROMng3zMaEDK6iEjjP+C4xi/NnFDjmdAJeP+KXH9J7nvNJqzbDtlYnQYP2zrS4rBstZw9GAlhGR+tz3LqlE3srrg7tA5wFBHVd17UburASyP+HsXGf9oGGqjj/ruDgQQajCTl/Q7/zT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiKNfV6C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12D57C4CEFB;
	Wed, 24 Dec 2025 12:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766577640;
	bh=nDp3W7aZADOLuHOyGpLYX8Z6yb2C24/EhbHScbEhUJ4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DiKNfV6Ccb/iQ39AjEW8A5qH6Zo1bya51IU+luizyCojGmDnAs4860+bL6XmXyxyi
	 tPRXZXpehCBwZknFoRcpXoWIrm1dnEKGLcnNbTS+8vqUBY16ice5u7US9UfwO8gSdP
	 EYCVGIaDSWoHnE5Knrx+f0ug5paCODywg9weRrcg8Y0aph6E/m3YwkReJ9Ri97Ph1m
	 nmCU6X2oIniOCuoaImCrsj2KKBa3Yt4kWcgK3ibZRIYWhZJazML5Xmxlz9qSfZbcNc
	 JruV/IyYev/iuDRWuWtTFdPQfiwPGOit0I1Wm9R2uHwXgI9zn5/5CNwA5sQT+h3ZZt
	 ZbcrRb/WkCP3A==
From: Christian Brauner <brauner@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Jan Kara <jack@suse.cz>,
	Amir Goldstein <amir73il@gmail.com>
Subject: [PATCH] pidfs: protect PIDFD_GET_* ioctls() via ifdef
Date: Wed, 24 Dec 2025 13:00:24 +0100
Message-ID: <20251224-ununterbrochen-gagen-ea949b83f8f2@brauner>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251222214907.GA189632@quark>
References: <20251222214907.GA189632@quark>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3376; i=brauner@kernel.org; h=from:subject:message-id; bh=nDp3W7aZADOLuHOyGpLYX8Z6yb2C24/EhbHScbEhUJ4=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWR6X73XxVUax5Zkejbq2Yf/p34yqIqu+/Lwz539LmdWP szfXWXws6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi/UsZ/hcmqi26VM5lqf+j +PC7CYnfM7QEuU46NyglHsnZusR6Aw8jw//+l555ZVHZCmsNtx/zuunntmXx9CXecqc83R8fvSN 0kB8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

We originally protected PIDFD_GET_<ns-type>_NAMESPACE ioctls() through
ifdefs and recent rework made it possible to drop them. There was an
oversight though. When the relevant namespace is turned off ns->ops will
be NULL so even though opening a file descriptor is perfectly legitimate
it would fail during inode eviction when the file was closed.

The simple fix would be to check ns->ops for NULL and continue allow to
retrieve namespace fds from pidfds but we don't allow retrieving them
when the relevant namespace type is turned off. So keep the
simplification but add the ifdefs back in.

Reported-by: Eric Biggers <ebiggers@kernel.org>
Link: https://lore.kernel.org/20251222214907.GA189632@quark
Fixes: a71e4f103aed ("pidfs: simplify PIDFD_GET_<type>_NAMESPACE ioctls")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/pidfs.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fs/pidfs.c b/fs/pidfs.c
index dba703d4ce4a..1e20e36e0ed5 100644
--- a/fs/pidfs.c
+++ b/fs/pidfs.c
@@ -517,14 +517,18 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	switch (cmd) {
 	/* Namespaces that hang of nsproxy. */
 	case PIDFD_GET_CGROUP_NAMESPACE:
+#ifdef CONFIG_CGROUPS
 		if (!ns_ref_get(nsp->cgroup_ns))
 			break;
 		ns_common = to_ns_common(nsp->cgroup_ns);
+#endif
 		break;
 	case PIDFD_GET_IPC_NAMESPACE:
+#ifdef CONFIG_IPC_NS
 		if (!ns_ref_get(nsp->ipc_ns))
 			break;
 		ns_common = to_ns_common(nsp->ipc_ns);
+#endif
 		break;
 	case PIDFD_GET_MNT_NAMESPACE:
 		if (!ns_ref_get(nsp->mnt_ns))
@@ -532,32 +536,43 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		ns_common = to_ns_common(nsp->mnt_ns);
 		break;
 	case PIDFD_GET_NET_NAMESPACE:
+#ifdef CONFIG_NET_NS
 		if (!ns_ref_get(nsp->net_ns))
 			break;
 		ns_common = to_ns_common(nsp->net_ns);
+#endif
 		break;
 	case PIDFD_GET_PID_FOR_CHILDREN_NAMESPACE:
+#ifdef CONFIG_PID_NS
 		if (!ns_ref_get(nsp->pid_ns_for_children))
 			break;
 		ns_common = to_ns_common(nsp->pid_ns_for_children);
+#endif
 		break;
 	case PIDFD_GET_TIME_NAMESPACE:
+#ifdef CONFIG_TIME_NS
 		if (!ns_ref_get(nsp->time_ns))
 			break;
 		ns_common = to_ns_common(nsp->time_ns);
+#endif
 		break;
 	case PIDFD_GET_TIME_FOR_CHILDREN_NAMESPACE:
+#ifdef CONFIG_TIME_NS
 		if (!ns_ref_get(nsp->time_ns_for_children))
 			break;
 		ns_common = to_ns_common(nsp->time_ns_for_children);
+#endif
 		break;
 	case PIDFD_GET_UTS_NAMESPACE:
+#ifdef CONFIG_UTS_NS
 		if (!ns_ref_get(nsp->uts_ns))
 			break;
 		ns_common = to_ns_common(nsp->uts_ns);
+#endif
 		break;
 	/* Namespaces that don't hang of nsproxy. */
 	case PIDFD_GET_USER_NAMESPACE:
+#ifdef CONFIG_USER_NS
 		scoped_guard(rcu) {
 			struct user_namespace *user_ns;
 
@@ -566,8 +581,10 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				break;
 			ns_common = to_ns_common(user_ns);
 		}
+#endif
 		break;
 	case PIDFD_GET_PID_NAMESPACE:
+#ifdef CONFIG_PID_NS
 		scoped_guard(rcu) {
 			struct pid_namespace *pid_ns;
 
@@ -576,6 +593,7 @@ static long pidfd_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 				break;
 			ns_common = to_ns_common(pid_ns);
 		}
+#endif
 		break;
 	default:
 		return -ENOIOCTLCMD;
-- 
2.47.3



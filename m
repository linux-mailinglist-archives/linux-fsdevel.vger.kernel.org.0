Return-Path: <linux-fsdevel+bounces-42229-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FB0A3F5A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 14:20:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ECCC1188DEDC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2025 13:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A31C20F091;
	Fri, 21 Feb 2025 13:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jrq8iDn7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6914420B812
	for <linux-fsdevel@vger.kernel.org>; Fri, 21 Feb 2025 13:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740143623; cv=none; b=pip7xv7LVH7PdL7Zz00Ft8Q0R31DCz9pG8FuOfgMRHls4wwzfIwNLH9IV9FW3I/JkubQzsUZjNLfDYagGOGlukl/va4xTKZzZMkjAhpkgEUtzK/SBQfEPM3EyoATQHH1KXEmjXf9+WZbQWkIzJWeGwG2JVWMvsHyS5JT46x5HLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740143623; c=relaxed/simple;
	bh=2ABkRpc3fT2dPlaRJehf3U9kSkKoclvFQ+Axz0gt9cQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nPrmcxMZSJ0X0EJk3DnBYQ2ErXH4FJ0h8GUFxwO6JvhAFvvgd7nZWZHhnFJ9dXwgO44iyt6RgexRRHZKgbW4ejql83lqmlpDH1Tkh5gcYP91gicCEciZyV0zCPqC7vlfi8PVuJc15XhE9D5G8R4tt/q5SPKp+jAcS0IBQ93rGnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jrq8iDn7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F7EC4CEE4;
	Fri, 21 Feb 2025 13:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740143621;
	bh=2ABkRpc3fT2dPlaRJehf3U9kSkKoclvFQ+Axz0gt9cQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jrq8iDn7sGxbyP9YjutrkVMkxk/NuZEbaojUKRe8riGymb/5EUHdSrfQhrvV0aw3q
	 mjMbkOOgl/o/+W53/QMzR2rrROLHZwQfJel2UWTsxFJiT7ZXxLMu47N+fcx244ifg4
	 FOlWzHXidZkO2O/bAi2ovPkocrurDuzSlHzxE9eKdW1iGtvnBHpKY2BaDTcEQ/aTPQ
	 tmGBDxbQgUqQtzS+IzR9kbv8vRmHbq2klXAzT+M2xwKUVoXwVF+VfvnsnN7h5hnD25
	 zAwQ8vbtgrYmY75lrGNtFtbb5GzxHvOZXLcNZmZfAUdCHEEJ1vcvfwx7zjVj6YfM8q
	 C/rHmGLycm/8Q==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 21 Feb 2025 14:13:03 +0100
Subject: [PATCH RFC 04/16] fs: add fastpath for dissolve_on_fput()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250221-brauner-open_tree-v1-4-dbcfcb98c676@kernel.org>
References: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
In-Reply-To: <20250221-brauner-open_tree-v1-0-dbcfcb98c676@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Al Viro <viro@zeniv.linux.org.uk>, Miklos Szeredi <miklos@szeredi.hu>, 
 Jeff Layton <jlayton@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 Seth Forshee <sforshee@kernel.org>, Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=2505; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2ABkRpc3fT2dPlaRJehf3U9kSkKoclvFQ+Axz0gt9cQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaTvqP61yejKDs7vXPKBjZ/YolV5Ljoej+hiaVd7Ilpgw
 Bmk63mqo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCIBPxn+u5/p2/docTNnr4rQ
 hXO8pjciV9/cGOOdUZV/beFj3Wb9DQz/Y6/dfsHPanfibtl8tdA7Vr1xck2SV1IPzDh3/sYa9QZ
 HZgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Instead of acquiring the namespace semaphore and the mount lock
everytime we close a file with FMODE_NEED_UNMOUNT set add a fastpath
that checks whether we need to at all. Most of the time the caller will
have attached the mount to the filesystem hierarchy and there's nothing
to do.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 59 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 12 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 7d0fa8ef8674..2cffcda8a48e 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2246,22 +2246,57 @@ struct vfsmount *collect_mounts(const struct path *path)
 static void free_mnt_ns(struct mnt_namespace *);
 static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
 
+static inline bool must_dissolve(struct mnt_namespace *mnt_ns)
+{
+	/*
+        * This mount belonged to an anonymous mount namespace
+        * but was moved to a non-anonymous mount namespace and
+        * then unmounted.
+        */
+	if (unlikely(!mnt_ns))
+		return false;
+
+	/*
+        * This mount belongs to a non-anonymous mount namespace
+        * and we know that such a mount can never transition to
+        * an anonymous mount namespace again.
+        */
+	if (!is_anon_ns(mnt_ns)) {
+		/*
+		 * A detached mount either belongs to an anonymous mount
+		 * namespace or a non-anonymous mount namespace. It
+		 * should never belong to something purely internal.
+		 */
+		VFS_WARN_ON_ONCE(mnt_ns == MNT_NS_INTERNAL);
+		return false;
+	}
+
+	return true;
+}
+
 void dissolve_on_fput(struct vfsmount *mnt)
 {
 	struct mnt_namespace *ns;
-	namespace_lock();
-	lock_mount_hash();
-	ns = real_mount(mnt)->mnt_ns;
-	if (ns) {
-		if (is_anon_ns(ns))
-			umount_tree(real_mount(mnt), UMOUNT_CONNECTED);
-		else
-			ns = NULL;
+	struct mount *m = real_mount(mnt);
+
+	scoped_guard(rcu) {
+		if (!must_dissolve(READ_ONCE(m->mnt_ns)))
+			return;
 	}
-	unlock_mount_hash();
-	namespace_unlock();
-	if (ns)
-		free_mnt_ns(ns);
+
+	scoped_guard(rwsem_write, &namespace_sem) {
+		ns = m->mnt_ns;
+		if (!must_dissolve(ns))
+			return;
+
+		lock_mount_hash();
+		umount_tree(m, UMOUNT_CONNECTED);
+		unlock_mount_hash();
+	}
+
+	/* Make sure we notice when we leak mounts. */
+	VFS_WARN_ON_ONCE(!mnt_ns_empty(ns));
+	free_mnt_ns(ns);
 }
 
 void drop_collected_mounts(struct vfsmount *mnt)

-- 
2.47.2



Return-Path: <linux-fsdevel+bounces-51126-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD94AD3000
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 10:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B82431724B1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Jun 2025 08:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8462328314A;
	Tue, 10 Jun 2025 08:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XimAXxJI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB2B28002E
	for <linux-fsdevel@vger.kernel.org>; Tue, 10 Jun 2025 08:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749543714; cv=none; b=lUv/NF0mYMexwz05w4jRKUouAet0zlUFQSYUSWkWqBx7PE3NAZQ5Fs2CqJkIbh/Rco9jE6g7ieOLw8iAfUWSPiXddetEVdG+aT1sQ1S0P14Xuejv4OaQYfyKzqxssgMAyTtzgYeSlwkWpOqP19VItaW+22TfRR90gkxCke4be1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749543714; c=relaxed/simple;
	bh=IdwFzoAVBXeKq8RY+E0340qESrTfrYbIXdhL6jKE63U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FUcfWokbV7R8GiHQLgd67rvLEopmdO5Dt60oDVp8K5KYuaqz2V+CQ3p6t3c8aGzXomaDwSEejkc9sgRkXMgDKvsCp0ePhLVLE7MsVvuypDHCDn3gVVUvi1W+3tSTD0ZuQQrE5KfyTvWlui895PMW76Di3K77o/ssDlaP73lRSc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XimAXxJI; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=xZu9B00HwuWO387gFgQp0/CEsltf8qUS/pcslAQXW14=; b=XimAXxJIb9c5kJ02EZcpnxAruc
	P1busroDQrnw56kIqNWgyH0E0xlBBz5RsbvpIWAC58wsnu7kZXM/ouP+tWUSQqmmlmrkL7EgBk0Ke
	L3deVh5Up9isGpMTbhNMc7WgsX4yJ3qg1fcfyXDhRaE+2xNz/sIGjmOCPKDWGn8SAu4hz4G0NBxqD
	dHILILH/cDsdSZht91+i13KPgJ6x5qENJQqX0gkRzOuSBTYyiAAnhMtH07zvumYDEKGuW0XDsqBDT
	brFzruS5XLW7NgNs52+Mi74E840OSIPv8UsL9f03FNgOj7Znn/s5xVg9Z11/hAW0wcJlz2FghdQEp
	6xLAV08Q==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uOuEw-00000004jLk-0Z3y;
	Tue, 10 Jun 2025 08:21:50 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 07/26] dissolve_on_fput(): use anon_ns_root()
Date: Tue, 10 Jun 2025 09:21:29 +0100
Message-ID: <20250610082148.1127550-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
References: <20250610081758.GE299672@ZenIV>
 <20250610082148.1127550-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

that's the condition we are actually trying to check there...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 62 +++++++++++---------------------------------------
 1 file changed, 13 insertions(+), 49 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index b229f74762de..e783eb801060 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2329,67 +2329,31 @@ struct vfsmount *collect_mounts(const struct path *path)
 static void free_mnt_ns(struct mnt_namespace *);
 static struct mnt_namespace *alloc_mnt_ns(struct user_namespace *, bool);
 
-static inline bool must_dissolve(struct mnt_namespace *mnt_ns)
-{
-	/*
-        * This mount belonged to an anonymous mount namespace
-        * but was moved to a non-anonymous mount namespace and
-        * then unmounted.
-        */
-	if (unlikely(!mnt_ns))
-		return false;
-
-	/*
-        * This mount belongs to a non-anonymous mount namespace
-        * and we know that such a mount can never transition to
-        * an anonymous mount namespace again.
-        */
-	if (!is_anon_ns(mnt_ns)) {
-		/*
-		 * A detached mount either belongs to an anonymous mount
-		 * namespace or a non-anonymous mount namespace. It
-		 * should never belong to something purely internal.
-		 */
-		VFS_WARN_ON_ONCE(mnt_ns == MNT_NS_INTERNAL);
-		return false;
-	}
-
-	return true;
-}
-
 void dissolve_on_fput(struct vfsmount *mnt)
 {
 	struct mnt_namespace *ns;
 	struct mount *m = real_mount(mnt);
 
+	/*
+	 * m used to be the root of anon namespace; if it still is one,
+	 * we need to dissolve the mount tree and free that namespace.
+	 * Let's try to avoid taking namespace_sem if we can determine
+	 * that there's nothing to do without it - rcu_read_lock() is
+	 * enough to make anon_ns_root() memory-safe and once m has
+	 * left its namespace, it's no longer our concern, since it will
+	 * never become a root of anon ns again.
+	 */
+
 	scoped_guard(rcu) {
-		if (!must_dissolve(READ_ONCE(m->mnt_ns)))
+		if (!anon_ns_root(m))
 			return;
 	}
 
 	scoped_guard(namespace_lock, &namespace_sem) {
-		ns = m->mnt_ns;
-		if (!must_dissolve(ns))
-			return;
-
-		/*
-		 * After must_dissolve() we know that this is a detached
-		 * mount in an anonymous mount namespace.
-		 *
-		 * Now when mnt_has_parent() reports that this mount
-		 * tree has a parent, we know that this anonymous mount
-		 * tree has been moved to another anonymous mount
-		 * namespace.
-		 *
-		 * So when closing this file we cannot unmount the mount
-		 * tree. This will be done when the file referring to
-		 * the root of the anonymous mount namespace will be
-		 * closed (It could already be closed but it would sync
-		 * on @namespace_sem and wait for us to finish.).
-		 */
-		if (mnt_has_parent(m))
+		if (!anon_ns_root(m))
 			return;
 
+		ns = m->mnt_ns;
 		lock_mount_hash();
 		umount_tree(m, UMOUNT_CONNECTED);
 		unlock_mount_hash();
-- 
2.39.5



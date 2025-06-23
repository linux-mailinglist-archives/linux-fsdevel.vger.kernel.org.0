Return-Path: <linux-fsdevel+bounces-52446-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25CE7AE3474
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 380E0188FE57
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8CD1DFDAB;
	Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OlBS1oj+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E0E1C84D3
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654473; cv=none; b=BwY/7oXOuwqJV4uLLnAxXCjj/NWp89EwkFEwH/luDeqUWXjUkpouuP69jyQ0fpdWTQDgh72vLva+1I470v8nLi+towdefr124ZiRs6MZRBvTNMqaxWV8eboura4UtOX0ShxcO6dDAlogL1WR+XwQJsfvOMD3gqaEjhjysuDaEic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654473; c=relaxed/simple;
	bh=wEV3Ei9N3NUXbRAiiMoRtyIvPYGKjBjjamdVpPr7kZc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJOKAOeZXuTgos97JpEqdJ+gM1wuwinXUX2/aGOoZnUgX7/vYAQXR6R0c0dQz4qOFvBgIynA203j3OMXCKqmVqOFUhOHTcAew9Iy++bseQOSbp6VXUwkODUczsW0t/ojPKiuwbCt9PJjOYVr8ON9Qjmp0GXXE38KwrpFSKZKOgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OlBS1oj+; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=5qCuZ2B5tHjbhfqdshM/BFXJdMfIeMrELnJat6XEuOk=; b=OlBS1oj+6rJPfbe5mqC1BPv6wx
	YRPOFCyuoVPiJ/IT1RvwgGmpliLpL0VgogLhBt/NuxHxn00GOfoVuV0oB7kyJMPNg5Hseo9ukJaV6
	dEiiMogkI3KJxB26Hycix9JuU44TMwcPddmqbsdIhdCrV3MNIu2tsdcQpkvGO5bD11g0ynxR1z3Mz
	7dAtHJIKkKh509sEnRuE+4mVL4TNoLsFNy3K5N0L+wdwGBW3o/2XpISeta6VXEo14uJvJmmToZjku
	7SWXOFnh1OfBhLsxTcv6H3AUI4khBit/nQF8c9BkO/AoihUC+BylpUjtYjExRo+bMDHYqMNIoy4Hg
	xub39jOA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCP-00000005KpY-2Ekq;
	Mon, 23 Jun 2025 04:54:29 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 12/35] dissolve_on_fput(): use anon_ns_root()
Date: Mon, 23 Jun 2025 05:54:05 +0100
Message-ID: <20250623045428.1271612-12-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
References: <20250623044912.GA1248894@ZenIV>
 <20250623045428.1271612-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

that's the condition we are actually trying to check there...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 62 +++++++++++---------------------------------------
 1 file changed, 13 insertions(+), 49 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 82791f636442..fb15bd04333a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2333,67 +2333,31 @@ void drop_collected_paths(struct path *paths, struct path *prealloc)
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



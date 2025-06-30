Return-Path: <linux-fsdevel+bounces-53251-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B8CAED290
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 906673B51EC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3CE31D9324;
	Mon, 30 Jun 2025 02:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="jAvSTs6B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832E617C220
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251979; cv=none; b=NB03cJ2jDvYovgAtziKCtqyFY7HBoA028iVANqu3nTcsrfs+sgLaID6vNlnexSTL3T2GIpaSikOMk7jW/Azx+z4dezx8Nf4ktSLgBSrpelOmqFaQddvYJdWjvCEtzsB314HGcj+BeyFgHR32QoOsc9iYOztbewTeKRRUrpGxvIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251979; c=relaxed/simple;
	bh=GGbBEVjyeR1rsOYTRmv4cHUClI9KuOdCNJVWOvQNX3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=psDnJ28rfI0P0Q6UK+ExEsxSyWizfPcFIkqI6AjDGyuam6O4o9quZrT8QDmqvnx1czCxzh4GGmEtH8RBWsmcGqgoZVEYuJSIryTeN0iagvFEacizzgAv/f27uTWbFN1Sc+A+XNqeqFuHq2S5jGkrsEKq9evPYiSVm8v5gRSb8Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=jAvSTs6B; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=27a0jEP9YKY8YMj2Mzgl5S4YfW+1sB7iKIEVvR6V2Jg=; b=jAvSTs6Bv0iSi5BTSAlkeHcv0G
	joXA2dlr7OrNNMtY5kA2lxbJf2LDRPZbBOc+EmlH9KMQ8Ll4VXyBxvUtRmlvvTVR+0VZqrU5D2bAn
	3BcO+X1peSeaXHw7WQY1+1T+BTB6owgrpqwr9/7NsXt81zRtYUvNZpWpplZuAbqBiS5l7WzXioKVa
	pqKWcF5uTEN7r3zQJvuzvjBAHTeW3Afl0+9VY4/D69W38wTOjPfYTuQvMnaXjlZE7KYtIAighxvKe
	BtELqwt2d5MUisvhL5YM20SEqPmF1caoIoobPA9UREUrkxXSHG2cdGIwhZvtMQNaEXpF9vylqCIiP
	UMLFh0mg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dc-00000005owb-0uJp;
	Mon, 30 Jun 2025 02:52:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 09/48] new predicate: anon_ns_root(mount)
Date: Mon, 30 Jun 2025 03:52:16 +0100
Message-ID: <20250630025255.1387419-9-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
References: <20250630025148.GA1383774@ZenIV>
 <20250630025255.1387419-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

checks if mount is the root of an anonymouns namespace.
Switch open-coded equivalents to using it.

For mounts that belong to anon namespace !mnt_has_parent(mount)
is the same as mount == ns->root, and intent is more obvious in
the latter form.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/mount.h     |  7 +++++++
 fs/namespace.c | 28 +++-------------------------
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/fs/mount.h b/fs/mount.h
index f10776003643..f20e6ed845fe 100644
--- a/fs/mount.h
+++ b/fs/mount.h
@@ -161,6 +161,13 @@ static inline bool is_anon_ns(struct mnt_namespace *ns)
 	return ns->seq == 0;
 }
 
+static inline bool anon_ns_root(const struct mount *m)
+{
+	struct mnt_namespace *ns = READ_ONCE(m->mnt_ns);
+
+	return !IS_ERR_OR_NULL(ns) && is_anon_ns(ns) && m == ns->root;
+}
+
 static inline bool mnt_ns_attached(const struct mount *mnt)
 {
 	return !RB_EMPTY_NODE(&mnt->mnt_node);
diff --git a/fs/namespace.c b/fs/namespace.c
index c4feb8315978..ea01fea2ac93 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2480,9 +2480,7 @@ struct vfsmount *clone_private_mount(const struct path *path)
 	 * loops get created.
 	 */
 	if (!check_mnt(old_mnt)) {
-		if (!is_mounted(&old_mnt->mnt) ||
-			!is_anon_ns(old_mnt->mnt_ns) ||
-			mnt_has_parent(old_mnt))
+		if (!anon_ns_root(old_mnt))
 			return ERR_PTR(-EINVAL);
 
 		if (!check_for_nsfs_mounts(old_mnt))
@@ -3649,9 +3647,6 @@ static int do_move_mount(struct path *old_path,
 	ns = old->mnt_ns;
 
 	err = -EINVAL;
-	/* The thing moved must be mounted... */
-	if (!is_mounted(&old->mnt))
-		goto out;
 
 	if (check_mnt(old)) {
 		/* if the source is in our namespace... */
@@ -3664,10 +3659,8 @@ static int do_move_mount(struct path *old_path,
 	} else {
 		/*
 		 * otherwise the source must be the root of some anon namespace.
-		 * AV: check for mount being root of an anon namespace is worth
-		 * an inlined predicate...
 		 */
-		if (!is_anon_ns(ns) || mnt_has_parent(old))
+		if (!anon_ns_root(old))
 			goto out;
 		/*
 		 * Bail out early if the target is within the same namespace -
@@ -5028,22 +5021,7 @@ static int do_mount_setattr(struct path *path, struct mount_kattr *kattr)
 	err = -EINVAL;
 	lock_mount_hash();
 
-	/* Ensure that this isn't anything purely vfs internal. */
-	if (!is_mounted(&mnt->mnt))
-		goto out;
-
-	/*
-	 * If this is an attached mount make sure it's located in the callers
-	 * mount namespace. If it's not don't let the caller interact with it.
-	 *
-	 * If this mount doesn't have a parent it's most often simply a
-	 * detached mount with an anonymous mount namespace. IOW, something
-	 * that's simply not attached yet. But there are apparently also users
-	 * that do change mount properties on the rootfs itself. That obviously
-	 * neither has a parent nor is it a detached mount so we cannot
-	 * unconditionally check for detached mounts.
-	 */
-	if ((mnt_has_parent(mnt) || !is_anon_ns(mnt->mnt_ns)) && !check_mnt(mnt))
+	if (!anon_ns_root(mnt) && !check_mnt(mnt))
 		goto out;
 
 	/*
-- 
2.39.5



Return-Path: <linux-fsdevel+bounces-60106-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1341CB413FE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE4621BA1529
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A1E72DCF56;
	Wed,  3 Sep 2025 04:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="HZK+cQAF"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D672D9ED0
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875354; cv=none; b=ZB6cQOvMBQYM9kaI5lgc7phCkG1UYvpGY0HkF7OduP5NvZU+NqRpbwnwdbYHvmY2s5Gs/KPztlIuHqH17oPL03Gm46YBcse1ysswu2Fh3esksL17vW8HeVQ1kgrX28uFUKsPLYXqLIZptG4pmACNO5OClvjf8Dg6guYS2xiakjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875354; c=relaxed/simple;
	bh=OWMLw4YdOxwArhH5ptjh5FAuIjFgvA+oO8InG/MmvPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Czs1/j0whRuT4Ax/Zo5lX2XVN4/Qhe7W5m5D8CbdmSjOPnupB1AcUOfu7WZtmuvGrwLXOXpQZTiG2z0pGNraip6DoGGqJR4HEyRbeaZVHUQ91FNPRegl3bnf5uVPfaB+OHWsE5wB1JoSG+HP7CrE+sO7wQIh2N7mJkETPNpvt0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=HZK+cQAF; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mW1NMWRqf505Y5qJGtZXSLWDh1azLSpJjLOkVFR0zo4=; b=HZK+cQAFdQDlamveCG3qrHCgdV
	htfxicDk4l/IbnOQb9cTkckEgqE795G2XD11spX1owdzQ2NvL3B6t2ZQGLuVdR1cSRLJKCDGxASz/
	FkyzUPnwz+A6Stst9WUK7h4+vUDxUCEvXjEn7PhffqMMGxOYxnKru/lIDu2HP5Qlz18GgFHlEphSa
	wTGbkW4Zl/M2wDhQZsJTQIHmSalESHXJ0GRJc+ajtzFA/K/Z4SlhEeo/k5Qu0UzhBaYMgUi5ACjnN
	MXyK0AdPrm6zUYf1JKtNAL0fsD8xce6qhypNJxbepxc6qpkCPCeAgZAaxTHIEK5i0biIskKk9Ut7G
	f9W/z+/A==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXD-0000000ApJ0-2VcY;
	Wed, 03 Sep 2025 04:55:51 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 58/63] copy_mnt_ns(): use guards
Date: Wed,  3 Sep 2025 05:55:24 +0100
Message-ID: <20250903045537.2579614-63-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
References: <20250903045432.GH39973@ZenIV>
 <20250903045537.2579614-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

* mntput() of rootmnt and pwdmnt done via __free(mntput)
* mnt_ns_tree_add() can be done within namespace_excl scope.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a418555586ef..9e16231d4561 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4164,7 +4164,8 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		struct user_namespace *user_ns, struct fs_struct *new_fs)
 {
 	struct mnt_namespace *new_ns;
-	struct vfsmount *rootmnt = NULL, *pwdmnt = NULL;
+	struct vfsmount *rootmnt __free(mntput) = NULL;
+	struct vfsmount *pwdmnt __free(mntput) = NULL;
 	struct mount *p, *q;
 	struct mount *old;
 	struct mount *new;
@@ -4183,7 +4184,7 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	if (IS_ERR(new_ns))
 		return new_ns;
 
-	namespace_lock();
+	guard(namespace_excl)();
 	/* First pass: copy the tree topology */
 	copy_flags = CL_COPY_UNBINDABLE | CL_EXPIRE;
 	if (user_ns != ns->user_ns)
@@ -4191,13 +4192,11 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 	new = copy_tree(old, old->mnt.mnt_root, copy_flags);
 	if (IS_ERR(new)) {
 		emptied_ns = new_ns;
-		namespace_unlock();
 		return ERR_CAST(new);
 	}
 	if (user_ns != ns->user_ns) {
-		lock_mount_hash();
+		guard(mount_writer)();
 		lock_mnt_tree(new);
-		unlock_mount_hash();
 	}
 	new_ns->root = new;
 
@@ -4229,14 +4228,6 @@ struct mnt_namespace *copy_mnt_ns(unsigned long flags, struct mnt_namespace *ns,
 		while (p->mnt.mnt_root != q->mnt.mnt_root)
 			p = next_mnt(skip_mnt_tree(p), old);
 	}
-	namespace_unlock();
-
-	if (rootmnt)
-		mntput(rootmnt);
-	if (pwdmnt)
-		mntput(pwdmnt);
-
-	mnt_ns_tree_add(new_ns);
 	return new_ns;
 }
 
-- 
2.47.2



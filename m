Return-Path: <linux-fsdevel+bounces-53247-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C491EAED28B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 04:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3925189360B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 30 Jun 2025 02:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 708D61B043E;
	Mon, 30 Jun 2025 02:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="SPkgAFEv"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6B217BB21
	for <linux-fsdevel@vger.kernel.org>; Mon, 30 Jun 2025 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751251979; cv=none; b=eAMCx0UatEuo/hDGrsmtEDJdMW1XpvAYHToKmoCBz1e8mwSwEFX8m/h3Si+tskUwBSzclmEa/A7F8QuKYRQUNS0veVVlCE9gDMrvAyn8M5/eZB4iPcV3WtXmblxZZLQIFlu0W5X64pymBR+RRbU508+IeGiOg2wS5nH8M3UWnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751251979; c=relaxed/simple;
	bh=YTuo29mQHWVCP9v3JZEnrL1brxtF67abHjB5sZMgW2A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mI9h0bB1Pzho0mRVm3we3wrA2jgs/UpeZ3pIiZwpLmtpc2FeXzLsI7m6iN6nXxkDlmmX3vV1L4rxstHOy21MMN0+rAMC7M+p2Ez3vJOaAvl+PFYq3JjRroNj55JWF4m+649NC8Fgc2Z6zZy0N+XUU17EMDQ9zwAG+j769Z2b5mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=SPkgAFEv; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=3I3aQb45fmlx+KnGvW1o9VnFHge2UCHDzHTYGtkxGB8=; b=SPkgAFEvImwrqj2wZr8vKU+39U
	Q1pBFGwV8xqN7Iv4aKuabUJOwUKUxvnpkJJAywRiisoprfQnfs65p3BdzySsdQ/KTyS+tJ5lDIaIi
	adOTL5Izer3iehWBtFiTQHQXkLUeDqmhLr0A7dEoib4GtHVamm1MdUHHa3YnT7j0QCQSf0fMqJCb/
	mSbnPzSLauoawX+ng//7uoPzNAmejVeVgLHrfSxqGbx8S0nhO5eOAPmNtQk4lOwc/0leMwQkQrN7F
	ttDf8YZjTq5DASRRxxWfKA6YSzSVqF+FFLabJoSwL0/PGjTaa5sXnVaSNckHrl7IqkonFibIYuj0W
	zuxrKZ3w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uW4dc-00000005owP-0GSc;
	Mon, 30 Jun 2025 02:52:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 07/48] new predicate: mount_is_ancestor()
Date: Mon, 30 Jun 2025 03:52:14 +0100
Message-ID: <20250630025255.1387419-7-viro@zeniv.linux.org.uk>
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

mount_is_ancestor(p1, p2) returns true iff there is a possibly
empty ancestry chain from p1 to p2.

Convert the open-coded checks.  Unlike those open-coded variants
it does not depend upon p1 not being root...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index f0a56dbceff9..aa93e1a48b5d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3483,6 +3483,17 @@ static inline bool path_overmounted(const struct path *path)
 	return unlikely(!no_child);
 }
 
+/*
+ * Check if there is a possibly empty chain of descent from p1 to p2.
+ * Locks: namespace_sem (shared) or mount_lock (read_seqlock_excl).
+ */
+static bool mount_is_ancestor(const struct mount *p1, const struct mount *p2)
+{
+	while (p2 != p1 && mnt_has_parent(p2))
+		p2 = p2->mnt_parent;
+	return p2 == p1;
+}
+
 /**
  * can_move_mount_beneath - check that we can mount beneath the top mount
  * @from: mount to mount beneath
@@ -3534,9 +3545,8 @@ static int can_move_mount_beneath(const struct path *from,
 	if (parent_mnt_to == current->nsproxy->mnt_ns->root)
 		return -EINVAL;
 
-	for (struct mount *p = mnt_from; mnt_has_parent(p); p = p->mnt_parent)
-		if (p == mnt_to)
-			return -EINVAL;
+	if (mount_is_ancestor(mnt_to, mnt_from))
+		return -EINVAL;
 
 	/*
 	 * If the parent mount propagates to the child mount this would
@@ -3705,9 +3715,8 @@ static int do_move_mount(struct path *old_path,
 	err = -ELOOP;
 	if (!check_for_nsfs_mounts(old))
 		goto out;
-	for (; mnt_has_parent(p); p = p->mnt_parent)
-		if (p == old)
-			goto out;
+	if (mount_is_ancestor(old, p))
+		goto out;
 
 	err = attach_recursive_mnt(old, real_mount(new_path->mnt), mp, flags);
 	if (err)
-- 
2.39.5



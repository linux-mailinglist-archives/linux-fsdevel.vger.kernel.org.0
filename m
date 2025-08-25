Return-Path: <linux-fsdevel+bounces-58916-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 089C1B33570
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:45:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 096A918895D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0D3127FB1F;
	Mon, 25 Aug 2025 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="XEGlYizy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CDD272E61
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097041; cv=none; b=VogpTbxQnvfEar1UABOW6LR7I/CDiYOj1jIuN0ull7aiIoPpdRZWvomCJT2lJTTbaToSJW3RA9xXx8YPut45auFh6gJIhRtnZwg17ybUq8lZ/kEZf5oWkzeTCHSBZZl+JZxcaYyMphGtr/6l2mZxIYEJSCyqoGALEy8V1PBx/AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097041; c=relaxed/simple;
	bh=8IHbF+7XPyJH6IQwxHMIUDaFeNzYiQtDxAJu4kvEWdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=slmTnCMX+BRLGQGZBgkML2m4fZAm73dFboO6uZyKY6kXxH1ebRFOC9jliUFpvPaf/XUjYPbLanGL1JK6EBgX59KBUeYIeaaafHiciaENlkTO2J0tC8mS/U9zoYFL+3dplZJ1tMy64Ii8exnvU4NJX0v0k12A3jmXLRpYTEHdsPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=XEGlYizy; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=oXsdB3rsDOQl+KT1NkyXIVLcEZFO3S8znsVDAzXFwbA=; b=XEGlYizyTVcSHU4vIG+amwfTlm
	hwhEt8uaM+e5uwVJ+w9lFrfRn2e11yWAykbLgtJfSvq6wTffJE+BMM9WG1CW4rMG76e8CFhnMvojC
	4RzfclRcROe7CUhGyAgaqvsBEGVEFlKpypCnK4L1hOfcbT/fj8MpjymqBxlrsZ3S3pznBOEvNjTrD
	lqZss8c1hxALO/1fUX2+VvkEfX/UGV6/yHviD5W3ibGWYBxHCV2lLo8gkv4ygGYz3uGQJv2iO5Pno
	GAG78qhM5iu5e/TYoeuqqRN0DfRrBnpQa1feqLk8QGFcWY4bPegRB4YyoSIhuaIaxokPZju4eMPzk
	JkPKIAuA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3l-00000006TAk-2onr;
	Mon, 25 Aug 2025 04:43:57 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 18/52] do_move_mount(): trim local variables
Date: Mon, 25 Aug 2025 05:43:21 +0100
Message-ID: <20250825044355.1541941-18-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
References: <20250825044046.GI39973@ZenIV>
 <20250825044355.1541941-1-viro@zeniv.linux.org.uk>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>

Both 'parent' and 'ns' are used at most once, no point precalculating those...

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a8b586e635d8..1a076aac5d73 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3564,10 +3564,8 @@ static inline bool may_use_mount(struct mount *mnt)
 static int do_move_mount(struct path *old_path,
 			 struct path *new_path, enum mnt_tree_flags_t flags)
 {
-	struct mnt_namespace *ns;
 	struct mount *p;
 	struct mount *old;
-	struct mount *parent;
 	struct pinned_mountpoint mp;
 	int err;
 	bool beneath = flags & MNT_TREE_BENEATH;
@@ -3578,8 +3576,6 @@ static int do_move_mount(struct path *old_path,
 
 	old = real_mount(old_path->mnt);
 	p = real_mount(new_path->mnt);
-	parent = old->mnt_parent;
-	ns = old->mnt_ns;
 
 	err = -EINVAL;
 
@@ -3588,12 +3584,12 @@ static int do_move_mount(struct path *old_path,
 		/* ... it should be detachable from parent */
 		if (!mnt_has_parent(old) || IS_MNT_LOCKED(old))
 			goto out;
+		/* ... which should not be shared */
+		if (IS_MNT_SHARED(old->mnt_parent))
+			goto out;
 		/* ... and the target should be in our namespace */
 		if (!check_mnt(p))
 			goto out;
-		/* parent of the source should not be shared */
-		if (IS_MNT_SHARED(parent))
-			goto out;
 	} else {
 		/*
 		 * otherwise the source must be the root of some anon namespace.
@@ -3605,7 +3601,7 @@ static int do_move_mount(struct path *old_path,
 		 * subsequent checks would've rejected that, but they lose
 		 * some corner cases if we check it early.
 		 */
-		if (ns == p->mnt_ns)
+		if (old->mnt_ns == p->mnt_ns)
 			goto out;
 		/*
 		 * Target should be either in our namespace or in an acceptable
-- 
2.47.2



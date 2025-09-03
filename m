Return-Path: <linux-fsdevel+bounces-60062-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A365B413D6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 254D05456F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7732D7814;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="j0b7PU2Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F952D542A
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875344; cv=none; b=kGQ5kOx/lyFo7xqFAPE3j3I+3Tx1jbPDAj1eZztLsZC1F3bsvmNY9wR9Mblr1VHAys1VPS8hkMpJiX2JVPUvgGrIjDLlIuvtQGuiiV8U3Dtz2eVE9j+eFbc45H/5GT+yuRL0l8Kv7lAbSdH/Lmj4dJdiAPeKwXExPiLYkzOxNx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875344; c=relaxed/simple;
	bh=ehJe1yP5mWXsWoekjJTQux8UmIhLQAfj83I4VFR4X+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MzaO28vCy95A6PmAoMRKPJzd5B2YdUImZWFd7ghvRuMQW51CXFDvPwe1oxjIrX/h44mDA13+ZUBJEny2ZLZFRLJRulvJMzT+BsvFpQ8uxSzwjJ3YMWLpSn0kskXDv8+DKCjyhKt5MMFQ+TErYvxWhZXkO6vqKHBZuVls/rwmRT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=j0b7PU2Z; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=+Boazuucs05bS539r/q+eKSDykQQi0QIqxSir9gnhqA=; b=j0b7PU2Ze2Q/DWomornHHBGYRh
	b1P7FTKaG3cUwbmjwc6m2aTiV31Nff04jK2V91r3cRTUWRlobgDKyQAoZVjD9tCuc9TW/Ip7zfpBU
	VqNoOJtMjXIrdXeD1MWrvSVxhY8AK7RD+oSI8zRuipojF3gbBJYEh50qmkKX4bqAiJavjnkUh7SO3
	BVXMbYGeKAQiYgiOMxw931CWZbWhgD42kQd9vxTTw78aPES1GYAw6qQg4mWNbIGB7Z1TlOgd5IQON
	p77MqH27Sx+GbVtx0Xw3D7B9b8TB3Phj959sMjNcY2FP0z8lq6sKXWJKGhNsz+LgrdmJx2vpZoAEn
	8I0IEIjQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX3-0000000Ap8K-00ax;
	Wed, 03 Sep 2025 04:55:41 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 19/65] do_move_mount(): trim local variables
Date: Wed,  3 Sep 2025 05:54:40 +0100
Message-ID: <20250903045537.2579614-19-viro@zeniv.linux.org.uk>
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

Both 'parent' and 'ns' are used at most once, no point precalculating those...

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 9b575c9eee0b..ad9b5687ff15 100644
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



Return-Path: <linux-fsdevel+bounces-52441-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B26E8AE3471
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 06:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FF0C189054F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 04:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619EB1DE8A0;
	Mon, 23 Jun 2025 04:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="TIxh8OiA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E62B18DF6D
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Jun 2025 04:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750654473; cv=none; b=RYGi6rc1HFPfFLzwfuRZVCLXhkT6jCnM2A/rx3YfKKVP7lVAdpcjQXVU9xcW9cwe9qS8srE4ujjVYjNVvFy77teyt9gHxtpnUAynovZl9IHLXs4nY1WcVcFodkRv6ok1ZV1mJui1HtS3HOp1ddyV/RxyWs61n2e7tFKE/IHRJq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750654473; c=relaxed/simple;
	bh=axNLlAQtxweDBjq6R4OR3BTlpwN2Pduz3UfCwDt/gf4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aXVMFgi8fd6KIwEgWKFm7KvJHsDivae0ZYvt9cBCdbZHbPzbtVQ9Sn2nmEVpwiH/Rg22g5SqOW0o8oIWd0H/eLlPVNHj6vu3GkQI9IhI6gLV3PIMBjoZvia4XwOgJ/2EjKx1p7y5q7Fx15JdTbLJB5JI0fxqJme6BYocP9X/mHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=TIxh8OiA; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=i0na2wf9LXRmM8WBoI++ig/uVjJUqN8/3yIlKVvWo8A=; b=TIxh8OiAguoYNIIVhmt4BN+eWe
	AjNuckwKWTdEPCEmmRN7wtLf639OpKs4q+/T5IaprlvOsFdyDOix3JkEEkUU+bcp548prKswK/6q4
	CKob7dIiXvnrN5KSeA1/yYcM/9mWiI7D/bE36jJbY7hP8G8qFVo0wjzEStVu7FzLANMrjMVw1S+OS
	ql0rdz7NK3Csc01fpQeV4v3NzOOOpBEnFlPTletjUxy0f1FknSFCsOLbQ2nT7vEwUcS3O9z+yMG8d
	h37M248PDuzb8x+Fo8+eM6biWfxbDd9b/FLA0dgnGVWYH39r3idL8qiCoVRcRFVtqnyBbyMB4UiHY
	jMv+ILIg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uTZCO-00000005KoO-3ZB8;
	Mon, 23 Jun 2025 04:54:28 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	ebiederm@xmission.com,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 04/35] get rid of mnt_set_mountpoint_beneath()
Date: Mon, 23 Jun 2025 05:53:57 +0100
Message-ID: <20250623045428.1271612-4-viro@zeniv.linux.org.uk>
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

mnt_set_mountpoint_beneath() consists of attaching new mount side-by-side
with the one we want to mount beneath (by mnt_set_mountpoint()), followed
by mnt_change_mountpoint() shifting the the top mount onto the new one
(by mnt_change_mountpoint()).

Both callers of mnt_set_mountpoint_beneath (both in attach_recursive_mnt())
have the same form - in 'beneath' case we call mnt_set_mountpoint_beneath(),
otherwise - mnt_set_mountpoint().

The thing is, expressing that as unconditional mnt_set_mountpoint(),
followed, in 'beneath' case, by mnt_change_mountpoint() is just as easy.
And these mnt_change_mountpoint() callers are similar to the ones we
do when it comes to attaching propagated copies, which will allow more
cleanups in the next commits.

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c6cac3603661..18ab7241749a 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -1076,33 +1076,6 @@ void mnt_set_mountpoint(struct mount *mnt,
 	hlist_add_head(&child_mnt->mnt_mp_list, &mp->m_list);
 }
 
-/**
- * mnt_set_mountpoint_beneath - mount a mount beneath another one
- *
- * @new_parent: the source mount
- * @top_mnt:    the mount beneath which @new_parent is mounted
- * @new_mp:     the new mountpoint of @top_mnt on @new_parent
- *
- * Remove @top_mnt from its current mountpoint @top_mnt->mnt_mp and
- * parent @top_mnt->mnt_parent and mount it on top of @new_parent at
- * @new_mp. And mount @new_parent on the old parent and old
- * mountpoint of @top_mnt.
- *
- * Context: This function expects namespace_lock() and lock_mount_hash()
- *          to have been acquired in that order.
- */
-static void mnt_set_mountpoint_beneath(struct mount *new_parent,
-				       struct mount *top_mnt,
-				       struct mountpoint *new_mp)
-{
-	struct mount *old_top_parent = top_mnt->mnt_parent;
-	struct mountpoint *old_top_mp = top_mnt->mnt_mp;
-
-	mnt_set_mountpoint(old_top_parent, old_top_mp, new_parent);
-	mnt_change_mountpoint(new_parent, new_mp, top_mnt);
-}
-
-
 static void __attach_mnt(struct mount *mnt, struct mount *parent)
 {
 	hlist_add_head_rcu(&mnt->mnt_hash,
@@ -2729,10 +2702,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 
 	if (moving) {
 		unhash_mnt(source_mnt);
+		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		if (beneath)
-			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
-		else
-			mnt_set_mountpoint(top_mnt, dest_mp, source_mnt);
+			mnt_change_mountpoint(source_mnt, smp, top_mnt);
 		__attach_mnt(source_mnt, source_mnt->mnt_parent);
 		mnt_notify_add(source_mnt);
 		touch_mnt_namespace(source_mnt->mnt_ns);
@@ -2745,10 +2717,9 @@ static int attach_recursive_mnt(struct mount *source_mnt,
 				move_from_ns(p, &head);
 			list_del_init(&head);
 		}
+		mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
 		if (beneath)
-			mnt_set_mountpoint_beneath(source_mnt, top_mnt, smp);
-		else
-			mnt_set_mountpoint(dest_mnt, dest_mp, source_mnt);
+			mnt_change_mountpoint(source_mnt, smp, top_mnt);
 		commit_tree(source_mnt);
 	}
 
-- 
2.39.5



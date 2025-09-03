Return-Path: <linux-fsdevel+bounces-60057-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A6CB413D1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:56:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E211BA1354
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A1B42D73B2;
	Wed,  3 Sep 2025 04:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="OtVajn03"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A81B2D4B4E
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875344; cv=none; b=SGoghMUk04fcFsIbG05Z65fOZMRJF4kRounueh02DeeDdn5WvBPUkYxHqUprY+NKDRwA8BN4q+/ZEYXNTuSoKybhHPIZRktWKaoNEbYJQcfzfOL4Wzlen83sN0ArO8yPE623+TBLajd89GxuwdC1giFgYmpNNeFXeUHJwuGkdps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875344; c=relaxed/simple;
	bh=6nfyLDdxams4zXmnEhRPZu63MCtOZuaStcK8KpViyRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OyEjbz57tE43rbzbSbGYcnydwAERLrJvEzymfU92DSuFskh6vsBT7PNmwoFGBMlWM5x/zem1e8RPf2mGYe7sAzlyin4ZJoKrGSZ2RyGKwjgm6g5V+xxrwRcl6gmKsT5MEtDxYWPXTvrSTBL+3FQyIltz2BFUC9WDikupp3DpbFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=OtVajn03; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1FYT0/Q48M/VoRXEoVNAyzpBYW6hjU+n7hQrx40XXeA=; b=OtVajn03nNbAVw/jphJHcGdaGG
	mJWsd2ET3JJq9ignihZAtg5sVEqylkk81HyVdwU6e+alHYFi2JEdV8fmvnD/aQ1BrXT51SLf5oeBi
	WsKuGRlBWL43kKUY1qu2In1ioHeRoI9N9ketOtpxohDtb+6IAMOneKV7sSjUaMNNI7vD6oSs4cAAn
	C8Ap8+6gLvGKj3S9jPiFiD/JqMVVs45UaCCNbEr0t2yY6Sr1ny5ANWy6nO30qY4mgXMsmSjRL8spZ
	kqp/QgH+M359TNnWW0AgxB3foG4s7GNrr7p3XexmjFuD/Yo01tlwj2K3S/Cg8WwmjD9OTmYgUX4vf
	kfI8JHDQ==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX1-0000000Ap6K-33Y0;
	Wed, 03 Sep 2025 04:55:39 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 07/65] do_set_group(): use guards
Date: Wed,  3 Sep 2025 05:54:28 +0100
Message-ID: <20250903045537.2579614-7-viro@zeniv.linux.org.uk>
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

clean fit; namespace_excl to modify propagation graph

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 33 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 20 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index a6a7b068770a..13e2f3837a26 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3349,47 +3349,44 @@ static inline int tree_contains_unbindable(struct mount *mnt)
 
 static int do_set_group(struct path *from_path, struct path *to_path)
 {
-	struct mount *from, *to;
+	struct mount *from = real_mount(from_path->mnt);
+	struct mount *to = real_mount(to_path->mnt);
 	int err;
 
-	from = real_mount(from_path->mnt);
-	to = real_mount(to_path->mnt);
-
-	namespace_lock();
+	guard(namespace_excl)();
 
 	err = may_change_propagation(from);
 	if (err)
-		goto out;
+		return err;
 	err = may_change_propagation(to);
 	if (err)
-		goto out;
+		return err;
 
-	err = -EINVAL;
 	/* To and From paths should be mount roots */
 	if (!path_mounted(from_path))
-		goto out;
+		return -EINVAL;
 	if (!path_mounted(to_path))
-		goto out;
+		return -EINVAL;
 
 	/* Setting sharing groups is only allowed across same superblock */
 	if (from->mnt.mnt_sb != to->mnt.mnt_sb)
-		goto out;
+		return -EINVAL;
 
 	/* From mount root should be wider than To mount root */
 	if (!is_subdir(to->mnt.mnt_root, from->mnt.mnt_root))
-		goto out;
+		return -EINVAL;
 
 	/* From mount should not have locked children in place of To's root */
 	if (__has_locked_children(from, to->mnt.mnt_root))
-		goto out;
+		return -EINVAL;
 
 	/* Setting sharing groups is only allowed on private mounts */
 	if (IS_MNT_SHARED(to) || IS_MNT_SLAVE(to))
-		goto out;
+		return -EINVAL;
 
 	/* From should not be private */
 	if (!IS_MNT_SHARED(from) && !IS_MNT_SLAVE(from))
-		goto out;
+		return -EINVAL;
 
 	if (IS_MNT_SLAVE(from)) {
 		hlist_add_behind(&to->mnt_slave, &from->mnt_slave);
@@ -3401,11 +3398,7 @@ static int do_set_group(struct path *from_path, struct path *to_path)
 		list_add(&to->mnt_share, &from->mnt_share);
 		set_mnt_shared(to);
 	}
-
-	err = 0;
-out:
-	namespace_unlock();
-	return err;
+	return 0;
 }
 
 /**
-- 
2.47.2



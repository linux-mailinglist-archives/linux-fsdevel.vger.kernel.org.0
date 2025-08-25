Return-Path: <linux-fsdevel+bounces-58905-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B72A0B33562
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:44:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FA131888CEC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:44:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35B2277818;
	Mon, 25 Aug 2025 04:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="PzEd8IfZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE072258CF7
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097039; cv=none; b=p11oKPWFo99bbR/hnFLe+EDmlgJ8hln3kBiJWp2F+HOoQ7ZvCIBeuqFuz6W6yT5CMWWaOqE25UlJ9tpV6skeNTfFIXDmWgod83BZuRfQH1K/llyJokg8bNgrVnLxPxmweC7r1KJ8xdMyaHF5DZEyIV1c6aths+57AqdJAriG6Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097039; c=relaxed/simple;
	bh=nrgj2b3domq50d7ssMlHgt1VWSrmasmHHJlLWz4pr+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YJxnv+/Ew79OcmquGt4dWgX1Q5u2lYT+BO5uaI0ahJLESZJT25ZwV2ir1hYrUMngBSPoRirvkGPoJlq0BCUqqibLsrXLMkURwDtNymbj1RNd5eH0hmYLFIUJr+yVuVVFgB6YkmKb//VQS4TlHQtX/0MDWBePQ9I9ClvPtXbg/ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=PzEd8IfZ; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=Def8gKOO5sCecYS7gSxvYQH+KAxInZAY2DSqCoN1Hw0=; b=PzEd8IfZoxYBSNcVFUm4Ws5NIj
	qK7pjUHwAd+2+Cb94iSwYaw851zIlO7IJndzG58JtKiWMpnLhQHzqsTN43I+7PtI7XkA6xhCewi/n
	KU1icU0ZU3xAqMVB9XrUeSle8hs/vMjv4jjaFED9ZMnzgwAfBN0wvj/p6FyzvduvpqLGZCOLaxp2S
	zVJ5ti32/fWqfmLOOyYEfpcE/vr+8a1dkRUtDDdvY/quH6ZEZI4fzoHuLA10qwjq3VbxNni0CTekn
	jXzogN58bQww6NqTga/hPx1EgQFsrGvCaWEDkg+WHSk1x65vfzfai9YSSNjBylByZzfO/2YCbsf4J
	UKGIb/Rw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3k-00000006T8x-1eHv;
	Mon, 25 Aug 2025 04:43:56 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 07/52] do_set_group(): use guards
Date: Mon, 25 Aug 2025 05:43:10 +0100
Message-ID: <20250825044355.1541941-7-viro@zeniv.linux.org.uk>
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

clean fit; namespace_excl to modify propagation graph

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



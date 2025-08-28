Return-Path: <linux-fsdevel+bounces-59548-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E34B3AE07
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606159884F4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D934C2ECEA2;
	Thu, 28 Aug 2025 23:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="kkqRhl1Y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613AD2D060B
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422492; cv=none; b=jlt+/pJ7DYyhG6i2hulzsfr/9SdnsHJhJkzaRt67izxRPEXR4kU7AIkJMZCNk/Q9JZX1ya1Uz1+CogodXG9jhhVeib7KmCqYubRW8HdrpKbMlAVq2fquh39ZhIyhI2LcyW04S+lIsdqeERdPeKoWXbGeZ3riLYbPpIUS7TtmXJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422492; c=relaxed/simple;
	bh=6nfyLDdxams4zXmnEhRPZu63MCtOZuaStcK8KpViyRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ASEhD9M4mCvrSy8oLxe2x6HmcTwrVGHxAhCr+5ZL7VHTA04+4QdrNP+OOsr+azxtO/5t3ztgCsc9exDmqteax2nVZqc41ZwV6bIqdInmVK8P78mBT2lBDhRxT73+fzX7JWTeK2KQYLAwsmuiqBAvUmmChq+MprfNckEsX4Nh/XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=kkqRhl1Y; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=1FYT0/Q48M/VoRXEoVNAyzpBYW6hjU+n7hQrx40XXeA=; b=kkqRhl1Y9I3155mf66oDvbWwLR
	E87zyGUyX0WmH5mJeYfu2ynI3g6r7F8ko75Udj9xA27/49/t2pBk4TkwwHNHaVx9msB/JxYDiKRmD
	xQmw3IPMAzvtpRFWVCEZf3qFoLiXBEMarqj5c53W6dzHzaS7+374/tOqj7WKI1a4JxUrzYeCeTuwD
	CCBYtQodw4V6MXbSNn0ID/4zhyweRue65V3AHDITPBiMd+tY7BsWZwomM+P0qo5BgtSUBR9n+admx
	EAT5vR36fbSndNkyqP4MWAR3U8FwPUnZC1RRi2wU8Ghaz6Fg8GwUf8lrA25PsW03cVvGBhytZD6S5
	ecsILUtA==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlix-0000000F21e-2gyb;
	Thu, 28 Aug 2025 23:08:07 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 07/63] do_set_group(): use guards
Date: Fri, 29 Aug 2025 00:07:10 +0100
Message-ID: <20250828230806.3582485-7-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
References: <20250828230706.GA3340273@ZenIV>
 <20250828230806.3582485-1-viro@zeniv.linux.org.uk>
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



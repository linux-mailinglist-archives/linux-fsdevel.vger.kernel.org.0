Return-Path: <linux-fsdevel+bounces-60101-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 607A2B413FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:58:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F7AE1BA1551
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5A2D5938;
	Wed,  3 Sep 2025 04:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="VwRX/Q+T"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A635A2DAFC8
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875353; cv=none; b=CC+Djsk42Z0noe9wMrSsxoaDEBRiUJY9b2aNPLVpbKYjV32IbIgibTJZ52Nm8rlY6O2CEVnUnwb7Asa9buRTvh4j+SXQI4TIUCTjEgfRIt0TLAdzLaLKJeUnFxrT/SMM61u7Zh0i3ox05tyz9lEmSCBhIJrMfQKcY8Mih1/85FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875353; c=relaxed/simple;
	bh=AWKT5TO3rj65ElYFdHFErd8GhWFRVbcnGhf3BEGojK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OP89tW6FxVqXOSA5ke28Qb0RV0CiXQxwOyjMjykYs/rqpBbUypgcYBFBUhrBAM0ptehnnT0s/70N8vBXIP//PeDG0c2X2QxRdawZDzhhy9IxgxQM8x/4dvdUG4Diq2Wg0nINRnBVeT2pfX5zTxXdpV8aPfntiDg2QjsCDT8ogJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=VwRX/Q+T; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=mBJ39pTgXzz6+vZIEIUrtF43nm61CQa/M7x1BsHuZfE=; b=VwRX/Q+TBF50LsCSaKORZthVsx
	YlVLveYOgArNupSYMT2X+KOmvesDUPgJU7ic+3takVajedFbyNhVZ1ZK/DHBIvmLecHNdewn80u8U
	BEjAt8RMQ38huev5k3gNG+vt3V8aGY49MuY95H7HuRgB2SABw7EZhAZBKMkXs5XojtBkJBte9cryT
	zk8fafDuA5b437PYmlPJySXG4yJJVALh3OLjgRMQRk0imAzgLquOobntlZv99DrJQJf0/eitSrFKv
	uCqkr5iWn7rspayT2UgGzj92h813zEPOKUJ5ZJ+3NulA5nLvYKfzcFIhQhZtH88EJI7gW74ni96Hc
	gLbSAWxg==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfXB-0000000ApH2-2QE8;
	Wed, 03 Sep 2025 04:55:49 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 55/63] open_detached_copy(): separate creation of namespace into helper
Date: Wed,  3 Sep 2025 05:55:19 +0100
Message-ID: <20250903045537.2579614-58-viro@zeniv.linux.org.uk>
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

... and convert the helper to use of a guard(namespace_excl)

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 425c33377770..c324800e770c 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3053,18 +3053,17 @@ static int do_loopback(const struct path *path, const char *old_name,
 	return err;
 }
 
-static struct file *open_detached_copy(struct path *path, bool recursive)
+static struct mnt_namespace *get_detached_copy(const struct path *path, bool recursive)
 {
 	struct mnt_namespace *ns, *mnt_ns = current->nsproxy->mnt_ns, *src_mnt_ns;
 	struct user_namespace *user_ns = mnt_ns->user_ns;
 	struct mount *mnt, *p;
-	struct file *file;
 
 	ns = alloc_mnt_ns(user_ns, true);
 	if (IS_ERR(ns))
-		return ERR_CAST(ns);
+		return ns;
 
-	namespace_lock();
+	guard(namespace_excl)();
 
 	/*
 	 * Record the sequence number of the source mount namespace.
@@ -3081,8 +3080,7 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 
 	mnt = __do_loopback(path, recursive);
 	if (IS_ERR(mnt)) {
-		namespace_unlock();
-		free_mnt_ns(ns);
+		emptied_ns = ns;
 		return ERR_CAST(mnt);
 	}
 
@@ -3091,11 +3089,19 @@ static struct file *open_detached_copy(struct path *path, bool recursive)
 		ns->nr_mounts++;
 	}
 	ns->root = mnt;
-	mntget(&mnt->mnt);
-	namespace_unlock();
+	return ns;
+}
+
+static struct file *open_detached_copy(struct path *path, bool recursive)
+{
+	struct mnt_namespace *ns = get_detached_copy(path, recursive);
+	struct file *file;
+
+	if (IS_ERR(ns))
+		return ERR_CAST(ns);
 
 	mntput(path->mnt);
-	path->mnt = &mnt->mnt;
+	path->mnt = mntget(&ns->root->mnt);
 	file = dentry_open(path, O_PATH, current_cred());
 	if (IS_ERR(file))
 		dissolve_on_fput(path->mnt);
-- 
2.47.2



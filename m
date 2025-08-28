Return-Path: <linux-fsdevel+bounces-59555-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEA4B3AE14
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Aug 2025 01:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8966358399E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Aug 2025 23:09:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECBA2D1F6B;
	Thu, 28 Aug 2025 23:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="GSgBx9FC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45A12D7DF8
	for <linux-fsdevel@vger.kernel.org>; Thu, 28 Aug 2025 23:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756422493; cv=none; b=Al5jtzY0IwSTcbzxacpJp5cyrl91cCUPaeq31fBMgGUmN7lfwMWufdtWRZTNYz5SCPhWdFmEoJjpb/+sqa+yfX5CMPPEz4DK8Se69Vx5u4iMGCy7te/lFn0DpRnAIDbzXfW8DE04mQiDSeUBJTPAm1d9fieLY3i8xU871hB0VAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756422493; c=relaxed/simple;
	bh=t0fiDl9XEhvWZPp/EkL7Pm3/uiq/U9zk1hZ7b69Oq1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cj7P71G/w3iMraqXTbve5WS9cDJX9qhRtFb8tEIzyddZysBxYsoTuQa5M6qvQih5wruETqaPQiRzvUds/qwLEibfOKgEIc94LO8HtMyRcBCowEqegqe5Cy5guhZq6sC9l/gg9xooCcCinXBMJRiDIT3v5KT14CdmjtttKyDckR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=GSgBx9FC; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y//+K7LN5EywRYUUneZo1Z1DDJ+CidDBMjw/LrYsc2Q=; b=GSgBx9FCaviW0O0NWXJBDz0Jg0
	GKlp0zZi51EUULjMpCwivTCHySEtfvly/70SCQQFemP1KkyBCS3cHnpF/9YXjWdNp5GdqZ+kSgiFh
	9cGGf9uiif7GzMUcc7N4xcv2lRzW8LKwq8YtU80I7Zh6WZ6tQNXLZbiKOWRZLFI2wJSHaqevyAD7D
	xHYiT/YwD5gh7TU5SnBuqndOJl1ev9jKg4SS1SLrodtrctHpDJ2XyHhRgiy+RCfR1JFpgKKmFO84q
	6twRmlc9r60msI5dlp4isNS6IoyOhF6jEr4TTpSkKXnVLC7HH6HTru0wYlSlJ+jJ1d0OjDDZJuGXp
	7OnqU1gw==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1urlj0-0000000F24q-05tI;
	Thu, 28 Aug 2025 23:08:10 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v2 27/63] finish_automount(): use __free() to deal with dropping mnt on failure
Date: Fri, 29 Aug 2025 00:07:30 +0100
Message-ID: <20250828230806.3582485-27-viro@zeniv.linux.org.uk>
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

same story as with do_new_mount_fc().

Reviewed-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 3551e51461a2..779cfed04291 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3801,8 +3801,9 @@ static int lock_mount_exact(const struct path *path,
 	return err;
 }
 
-int finish_automount(struct vfsmount *m, const struct path *path)
+int finish_automount(struct vfsmount *__m, const struct path *path)
 {
+	struct vfsmount *m __free(mntput) = __m;
 	struct pinned_mountpoint mp = {};
 	struct mount *mnt;
 	int err;
@@ -3814,10 +3815,8 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 
 	mnt = real_mount(m);
 
-	if (m->mnt_root == path->dentry) {
-		err = -ELOOP;
-		goto discard;
-	}
+	if (m->mnt_root == path->dentry)
+		return -ELOOP;
 
 	/*
 	 * we don't want to use lock_mount() - in this case finding something
@@ -3825,19 +3824,14 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 	 * got", not "try to mount it on top".
 	 */
 	err = lock_mount_exact(path, &mp);
-	if (unlikely(err)) {
-		mntput(m);
+	if (unlikely(err))
 		return err == -EBUSY ? 0 : err;
-	}
+
 	err = do_add_mount(mnt, mp.mp, path,
 			   path->mnt->mnt_flags | MNT_SHRINKABLE);
+	if (likely(!err))
+		retain_and_null_ptr(m);
 	unlock_mount(&mp);
-	if (unlikely(err))
-		goto discard;
-	return 0;
-
-discard:
-	mntput(m);
 	return err;
 }
 
-- 
2.47.2



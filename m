Return-Path: <linux-fsdevel+bounces-58925-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0007B33582
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 06:46:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C651B23C68
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Aug 2025 04:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5A772820B1;
	Mon, 25 Aug 2025 04:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="bXZ4eKH4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562792798FB
	for <linux-fsdevel@vger.kernel.org>; Mon, 25 Aug 2025 04:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756097042; cv=none; b=r9Oldntq2MaMqYjJ9qS64k6+SVY85AOlcnITeasjQLx0MbZFq+EddmtHODjWC0+uxTddjgGLb3vphNbYyg9LXyqVyBZrcSNhrqTnMI3eMBCiUIGad73jnRqpTjxq7jDjDSuDFcRscJ41ksa8xzQ+ZU2fwCBNlU9U0Bmfq9Ov07c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756097042; c=relaxed/simple;
	bh=inQ0aUelblBg4w1YdoYms1qyJJBmnAO3rJzuzxn2fO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzMY/hsxXyiNNAyCa9T1dvZDUceneyfOQAdz/p/uOZQNbmSpvu+/UI38Ug872nCZkeYtRyzL/ejYHGOB8L2orwMfG3FyQCDgqQTRJcgFpfqLWrS6YzgFGE3cm1ed0fhgrcgGc98gIKANMwwaPI5s2pUETMW1dr9kuR3f+OhVNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=bXZ4eKH4; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=4IyGu7F3hYx+C6zg6jLlzM05ubIuc6uqqLmC7SxVMqQ=; b=bXZ4eKH4D/bKS+5k9zuYmGlXDq
	Dr3bXnlq7y9nVX9qWVXhvQOM+bPjyFh3Y6WGl6I3tIqeE/bH4KtIWZhqI6knUQ/XTcXXno1ijzgEe
	07KdRn3Dppk9DnmUzWXz5p6oeP5baFj9PWjz9MRT5FDQl5Z3n9g2IZCp3XLAYhfG/eWhutoSiCOZv
	/rFjUwc+X5tzoVkppCMG0aaRdP+oVJDqDLQwRbtDzstqVODsDgqXqOuDcwE8Iiv+ewjnViAC/18qv
	dgTBdorFzNlRvl3NTl2Ofj8Ht/xwQ5WF53zzjv0LMCrCXSovKHmA0D404Z/L+q1uxTiPkMjNdWr8U
	7guo1T2w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uqP3m-00000006TBw-2ZPc;
	Mon, 25 Aug 2025 04:43:58 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH 26/52] finish_automount(): use __free() to deal with dropping mnt on failure
Date: Mon, 25 Aug 2025 05:43:29 +0100
Message-ID: <20250825044355.1541941-26-viro@zeniv.linux.org.uk>
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

same story as with do_new_mount_fc().

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/namespace.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 79c87937a7dd..5819a50d7d67 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3806,8 +3806,9 @@ static int lock_mount_exact(const struct path *path,
 	return err;
 }
 
-int finish_automount(struct vfsmount *m, const struct path *path)
+int finish_automount(struct vfsmount *__m, const struct path *path)
 {
+	struct vfsmount *m __free(mntput) = __m;
 	struct pinned_mountpoint mp = {};
 	struct mount *mnt;
 	int err;
@@ -3819,10 +3820,8 @@ int finish_automount(struct vfsmount *m, const struct path *path)
 
 	mnt = real_mount(m);
 
-	if (m->mnt_root == path->dentry) {
-		err = -ELOOP;
-		goto discard;
-	}
+	if (m->mnt_root == path->dentry)
+		return -ELOOP;
 
 	/*
 	 * we don't want to use lock_mount() - in this case finding something
@@ -3830,19 +3829,14 @@ int finish_automount(struct vfsmount *m, const struct path *path)
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



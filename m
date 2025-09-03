Return-Path: <linux-fsdevel+bounces-60067-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F66AB413DB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 06:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82C55560D2D
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Sep 2025 04:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6D12D7DF5;
	Wed,  3 Sep 2025 04:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b="DNX6nw8o"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from zeniv.linux.org.uk (zeniv.linux.org.uk [62.89.141.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5692D63F6
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Sep 2025 04:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.89.141.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756875345; cv=none; b=MQuk6JzWvykzSKbX+yzAaAsAPsgUwjsZdJmik/g9bePiHfsY3EXdUtG8vaHSW7pbs9ExiQCmI5ZHYQcmeUGLxxApGbt246zKYbQ/UZcyFUmlBACdEJDB5zkSHywN3U2KB8JDIGEvZGN80BwcaMEif7rDtz4ZvAqYElzKZEeYHi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756875345; c=relaxed/simple;
	bh=t0fiDl9XEhvWZPp/EkL7Pm3/uiq/U9zk1hZ7b69Oq1Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V2BL+xAufDl9xP1ZD6fnpkMSIcC2fWKSLFYgVP3VTVGQnidKFq8mFsdfQaST7iMldozBuAmmZGiI6K2oBCuvrjMT7KdC3X9hVTOXckO4EPSj/nZK+ab7BdjpLbkZef+kLrDSqvdr8IZYlJPiONj9EFgZtkKVefHm5IBFqJbcPOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk; spf=none smtp.mailfrom=ftp.linux.org.uk; dkim=pass (2048-bit key) header.d=linux.org.uk header.i=@linux.org.uk header.b=DNX6nw8o; arc=none smtp.client-ip=62.89.141.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zeniv.linux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ftp.linux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=linux.org.uk; s=zeniv-20220401; h=Sender:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description;
	bh=y//+K7LN5EywRYUUneZo1Z1DDJ+CidDBMjw/LrYsc2Q=; b=DNX6nw8oM25MXFBZHx6UfyV8Fu
	2zxrgYJRxjgCjsxWCGGD230fZDk/F1Cnb3yDoRHF1dA9j9b3A8qj8wX+mVj+vWO2QLGP8fNTiuAOH
	nRn25qyriqokBBsAt1yNWgx1kqw1X0du70ZG0GZRFaMFSctw2aWeXwgCrkLqpQm9ZQ+jwyDHeN5Ne
	LHZtoz8Ya68A88PReX1vXijE/gNBpG33g+i0663Wbd8Lnj76nJqIeZ6xieRPtoI/o3t3qLbe1915+
	9CECa6c5ASMXnjOzL+6sAYDz3zm3nOPoBaQTZK7aAwX1bkM3rmWVtGcwiLfD4pjPXoMwu7fxuu5XO
	7cVaym8w==;
Received: from viro by zeniv.linux.org.uk with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1utfX4-0000000Ap9q-0jTs;
	Wed, 03 Sep 2025 04:55:42 +0000
From: Al Viro <viro@zeniv.linux.org.uk>
To: linux-fsdevel@vger.kernel.org
Cc: brauner@kernel.org,
	jack@suse.cz,
	torvalds@linux-foundation.org
Subject: [PATCH v3 27/65] finish_automount(): use __free() to deal with dropping mnt on failure
Date: Wed,  3 Sep 2025 05:54:49 +0100
Message-ID: <20250903045537.2579614-28-viro@zeniv.linux.org.uk>
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



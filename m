Return-Path: <linux-fsdevel+bounces-44344-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C79CA6797C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 17:31:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF23B17CCE8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Mar 2025 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91139213221;
	Tue, 18 Mar 2025 16:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a21XhFon"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0CF212D6A;
	Tue, 18 Mar 2025 16:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742315363; cv=none; b=dUq2uLdkpsWeyUVxHhty9LolrZ3pBD8kvhqfr3EQBU4L61Igv6PGzuJOeC1fuR63h//Qx88piQtyihbnzfkql32+X/V9bXbA5JgTEtR9xkV0XPdVZKi6s9Vc1kcIVh5VzalWT2MG37UXv8HF6c3+YIiK0ncirEPV5Ks5yZnajGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742315363; c=relaxed/simple;
	bh=aOc3hWMiJHHvq9ozTn4FksmAxzbKBPQJs4hv9fKckZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JEyH4PRZCMcelB2Sxg7uNgbpl+KQspfTA0AEFWPvLuKcRw1RV6djsiOhr0vmGo+uM31U/CPmKgrf9/sFxKXnZj48PNIXvTFy/XmFQV/2K5HLAvWNqQsFQ6OdS3IyhlS/G3G4SmiYn90iy76WqIjx+vw0XT7t3WePzQabmpTZIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a21XhFon; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 469BEC4CEE9;
	Tue, 18 Mar 2025 16:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742315362;
	bh=aOc3hWMiJHHvq9ozTn4FksmAxzbKBPQJs4hv9fKckZE=;
	h=From:To:Cc:Subject:Date:From;
	b=a21XhFon2CPVKaw5Gq1Yk/G/u/0QKpwGo+GIF0NeqMaTPotDCgfGdGLtdBV3cI4tx
	 aTvnBRYkwjnQjVM5ogzMyPDhlb8ZcQBJkhe/dRd3HG5Ls5ug+xaFUr5kOfTCCGgiNL
	 PPStzQUlMFloNzlipYQF2pwL8DD/ZUUiXy0PT5m7ISzhmCfzOtMz5jfPzMz90xrn5U
	 lL412MSP7gF1pln5J0bq6YWQpqvqYnEjFPkzCYowibCCOSXro49LkCZ3npW/xO6G0m
	 +Q9sSSkXUpR4hqDzFPC2nCB6qgzF94B7xxiiptqYt5UXV5vYpqBdjU3h2VlIxxJU9a
	 ECQZ9Z6ky5E6Q==
From: trondmy@kernel.org
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	linux-fsdevel@vger.kernel.org,
	linux-nfs@vger.kernel.org
Subject: [PATCH] umount: Allow superblock owners to force umount
Date: Tue, 18 Mar 2025 12:29:21 -0400
Message-ID: <12f212d4ef983714d065a6bb372fbb378753bf4c.1742315194.git.trond.myklebust@hammerspace.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Trond Myklebust <trond.myklebust@hammerspace.com>

Loosen the permission check on forced umount to allow users holding
CAP_SYS_ADMIN privileges in namespaces that are privileged with respect
to the userns that originally mounted the filesystem.

Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 8f1000f9f3df..d401486fe95d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -2026,6 +2026,7 @@ static void warn_mandlock(void)
 static int can_umount(const struct path *path, int flags)
 {
 	struct mount *mnt = real_mount(path->mnt);
+	struct super_block *sb = path->dentry->d_sb;
 
 	if (!may_mount())
 		return -EPERM;
@@ -2035,7 +2036,7 @@ static int can_umount(const struct path *path, int flags)
 		return -EINVAL;
 	if (mnt->mnt.mnt_flags & MNT_LOCKED) /* Check optimistically */
 		return -EINVAL;
-	if (flags & MNT_FORCE && !capable(CAP_SYS_ADMIN))
+	if (flags & MNT_FORCE && !ns_capable(sb->s_user_ns, CAP_SYS_ADMIN))
 		return -EPERM;
 	return 0;
 }
-- 
2.48.1



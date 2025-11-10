Return-Path: <linux-fsdevel+bounces-67640-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D54BC4561C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 09:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC0684E962A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Nov 2025 08:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7800222A4E9;
	Mon, 10 Nov 2025 08:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJQtbQTM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80A821CC59
	for <linux-fsdevel@vger.kernel.org>; Mon, 10 Nov 2025 08:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762763481; cv=none; b=PvDnnzkeJzurhxs1e0UNTJxSlwX883hCp57S+eRQQTabf0S7fazQaeFehac4e0O9EJC13oNJ8JffMSzJhGbwZVVh95hP2bm6QA0TKXs6RVzoPngEcBCaybEpAGbKPuKWKq9FdQS/+srrHEWfJWxGPgiNENrug1haMb4xr6waON0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762763481; c=relaxed/simple;
	bh=9k0h6OBkjBgZGpcbd3i9Y8P8ilrE6Zk4KJUTWDKQBT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RA863dI8/eUQAteYPdZ9WLlDsn+PtSSFpCn5fcB/hPKH+1PbP1QK6v/b+4IArB9ACIf3qRt7ydBhbxOBctpzG5FRKw01AAdnzr/dhTM+77Mhn2VjAd7d6t/gdUTeGXcAeUm+uODUpy38ArB0CZvlHP5zSE1UlCFEy5qskNLheaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJQtbQTM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6DD51C4CEFB;
	Mon, 10 Nov 2025 08:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762763481;
	bh=9k0h6OBkjBgZGpcbd3i9Y8P8ilrE6Zk4KJUTWDKQBT4=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MJQtbQTMP1nEsGd3bSFJ1ubfnPTFRv2NrSeVC6JG3dyO93C0JHtWdZYucKyVnfZNV
	 Y3kGL6LQRGCoEoOeFWmgByTjWM2nOxlQtWUqff+XXKdn+mknbdp6dqJP3k7S9Kobo0
	 fFDBzAZxEoBQcy3a2zF3PRSLl39ukFPKGdegVMgqnaNSSPp33mCnoLaJWgRHi80zBk
	 HJyHwSN06AmdmkLRRTWEMGQBO8P0RHfgGcWvdpdDFapJun1WFXMt0BOouuUwO2fev7
	 IVtScWMBvA/KjnH1nSTVG59zAF3vN9IWVWrByUd7elazsW/kGjk+N5cFE1aKzmLiPd
	 vxcfD/XH186sQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64E1DCCFA13;
	Mon, 10 Nov 2025 08:31:21 +0000 (UTC)
From: Xin Wang via B4 Relay <devnull+xwang.ddn.com@kernel.org>
Date: Mon, 10 Nov 2025 08:31:02 +0000
Subject: [PATCH] fuse: Umask handling problem if FUSE_CAP_DONT_MASK is
 disabled
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20251110-fuse_acl_umask-v1-1-cf1d431cae06@ddn.com>
X-B4-Tracking: v=1; b=H4sIAMWiEWkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI1NDQ0MD3bTS4tT4xOSc+NLcxOJs3cQ08yQTkxQjYzNTCyWgpoKi1LTMCrC
 B0bG1tQDNpDN+YAAAAA==
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, bschubert@ddn.com, gwu@ddn.com, 
 Xin Wang <xwang@ddn.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1762763481; l=3412;
 i=xwang@ddn.com; s=20251110; h=from:subject:message-id;
 bh=Gy+2d2kF9z2hAE/298jrIqc0SMibW2BMrzDNvDUnckQ=;
 b=+417Hkhu3M6dN87YbsEfWVcZkOiooZmV3ZhyYKQoM6kunPcwS3jmKn786NUOHGw9tryaItxAz
 U8kxgK3C1JeAL4OzZUFLuy2tAWGV8VNgO+/Qdgbzpp9GENc0DhSZmpE
X-Developer-Key: i=xwang@ddn.com; a=ed25519;
 pk=2NZ7S3gXVdveRFk4yNU1Q6JCNiAedXyGWBm7ipgv5kE=
X-Endpoint-Received: by B4 Relay for xwang@ddn.com/20251110 with
 auth_id=563
X-Original-From: Xin Wang <xwang@ddn.com>
Reply-To: xwang@ddn.com

From: Xin Wang <xwang@ddn.com>

According to umask manpage, it should be ignored if the parent has a
default ACL.  But currently, if FUSE_CAP_DONT_MASK is disabled, fuse
always applies umask no matter if the parent has a default ACL or not.
This behaviior is not consistent with the behavior described in the
manpage.

Fix the problem by checking if the parent has a default ACL before
applying umask if FUSE_CAP_DONT_MASK is disabled.

---
We found that there may be a problem about umask handling in fuse code.
According to umask manpage, it should be ignored if the parent has a
default ACL. But currently, if FUSE_CAP_DONT_MASK is disabled, fuse always
applies umask no matter if the parent has a default ACL or not. So, we
think this may be a problem because it is not consistent with the behavior
described in the manpage.

umask manpage:
       Alternatively, if the parent directory has a default ACL
       (see acl(5)), the umask is ignored, the default ACL is inherited,
       the permission bits are set based on the inherited ACL, …

Signed-off-by: Xin Wang <xwang@ddn.com>
---
 fs/fuse/dir.c | 42 ++++++++++++++++++++++++++++++++++++------
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index ecaec0fea3a1..f8ab6d76ae35 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -645,8 +645,18 @@ static int fuse_create_open(struct mnt_idmap *idmap, struct inode *dir,
 	if (!ff)
 		goto out_put_forget_req;
 
-	if (!fm->fc->dont_mask)
-		mode &= ~current_umask();
+	if (!fm->fc->dont_mask) {
+		/*
+		 * If the parent has a default ACL, the umask is
+		 * ignored, the default ACL is inherited, the
+		 * permission bits are set based on the inherited
+		 * default ACL
+		 */
+		struct posix_acl *p =
+			get_inode_acl(dir, ACL_TYPE_DEFAULT);
+		if (!p || p == ERR_PTR(-EOPNOTSUPP))
+			mode &= ~current_umask();
+	}
 
 	flags &= ~O_NOCTTY;
 	memset(&inarg, 0, sizeof(inarg));
@@ -872,8 +882,18 @@ static int fuse_mknod(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
 
-	if (!fm->fc->dont_mask)
-		mode &= ~current_umask();
+	if (!fm->fc->dont_mask) {
+		/*
+		 * If the parent has a default ACL, the umask is
+		 * ignored, the default ACL is inherited, the
+		 * permission bits are set based on the inherited
+		 * default ACL
+		 */
+		struct posix_acl *p =
+			get_inode_acl(dir, ACL_TYPE_DEFAULT);
+		if (!p || p == ERR_PTR(-EOPNOTSUPP))
+			mode &= ~current_umask();
+	}
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mode = mode;
@@ -919,8 +939,18 @@ static struct dentry *fuse_mkdir(struct mnt_idmap *idmap, struct inode *dir,
 	struct fuse_mount *fm = get_fuse_mount(dir);
 	FUSE_ARGS(args);
 
-	if (!fm->fc->dont_mask)
-		mode &= ~current_umask();
+	if (!fm->fc->dont_mask) {
+		/*
+		 * If the parent has a default ACL, the umask is
+		 * ignored, the default ACL is inherited, the
+		 * permission bits are set based on the inherited
+		 * default ACL
+		 */
+		struct posix_acl *p =
+			get_inode_acl(dir, ACL_TYPE_DEFAULT);
+		if (!p || p == ERR_PTR(-EOPNOTSUPP))
+			mode &= ~current_umask();
+	}
 
 	memset(&inarg, 0, sizeof(inarg));
 	inarg.mode = mode;

---
base-commit: 4a0c9b3391999818e2c5b93719699b255be1f682
change-id: 20251110-fuse_acl_umask-af7b44d23658

Best regards,
-- 
Xin Wang <xwang@ddn.com>




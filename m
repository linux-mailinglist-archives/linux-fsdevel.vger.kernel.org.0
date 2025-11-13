Return-Path: <linux-fsdevel+bounces-68313-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 820BBC58E5C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1257A42714F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1511136402F;
	Thu, 13 Nov 2025 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CN36vYu/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615F135A941;
	Thu, 13 Nov 2025 16:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051887; cv=none; b=MB1QmnE6GcCHdejHwPFM0n+5UMjIDEdyH16jctbEn+GJalyE3qEs3ci7T3r8RNYWc0nNe54SF4Whun77JaXsrnSe6UqSja56kvYt5HTFO/98gcXKh8o9p5QpQBsLCWTc3U4+OnXwxr2pc1JDdDygYi63HAWLl7uwuTS1CK+NTOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051887; c=relaxed/simple;
	bh=Tucb6WN+IMoXaAu63NR8a/8BdWpxMFgPYTFFk7c1rhE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EYNUCpJAgIbtZMvJ5ob/Uc5aEzO7mJ6M42HWOau/+9ygtSLv0FjlglR1beYsx3YqRhiValf6TSrg+zNDIrm3Z5kSilSeese7RQjq+3zdDrujpaOWhUZqcc2XytuCPqqaD3eBh926EVwttgjO5J/34Sjts+r9DNfxldkRfUshjPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CN36vYu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84D84C19424;
	Thu, 13 Nov 2025 16:38:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051886;
	bh=Tucb6WN+IMoXaAu63NR8a/8BdWpxMFgPYTFFk7c1rhE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CN36vYu/hvau5uWS2EBexIXwdaWJlCZo8bWLXfJ+H18nOMBQ47MynFCoa5PGipENM
	 hqDyttcYdsKDHQfVFQJ2VcmeXALfRuzGkOXTN9pR1tTc8/wl0jGGYgn2QdZ79NngpL
	 9ULfm55Dj05eBxIwdQTbXZLnk24QLh2nslHB0FKNQoAu4+G+uEe4XgPlov0JS4bXbj
	 6F/Ig3v3nCAshrdAHq39hSgtQkN3QpGSiNXQ4wWpemIvQEPy5hUJvMK0XWmYHBlLt2
	 t27Te71OX7zB5hrM/3EIa/e8/7SbLYaB3+d2AhqBTvHjK6QuH2G7mq2jo5kY82sRJb
	 J9VHoJQqGQb1w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:25 +0100
Subject: [PATCH v2 20/42] ovl: port ovl_fileattr_set() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-20-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1145; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Tucb6WN+IMoXaAu63NR8a/8BdWpxMFgPYTFFk7c1rhE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbqt6ygUUl4xZ/XJBF2hQkXxKeIXP/c5cO381OHdo
 h2a9ehiRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQe+jAyPNLdeHT7tDNnWRYz
 KCtfeLtCbf2fdy8t7n+fmP8v8eZ69SpGhv02km3fWl943a+M7WK47nbyM++UmpdXUrc+kl75u+r
 Pd04A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 5574ce30e0b2..3a23eb038097 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -638,7 +638,6 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 {
 	struct inode *inode = d_inode(dentry);
 	struct path upperpath;
-	const struct cred *old_cred;
 	unsigned int flags;
 	int err;
 
@@ -650,7 +649,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		if (err)
 			goto out;
 
-		old_cred = ovl_override_creds(inode->i_sb);
+		with_ovl_creds(inode->i_sb) {
 			/*
 			 * Store immutable/append-only flags in xattr and clear them
 			 * in upper fileattr (in case they were set by older kernel)
@@ -661,7 +660,7 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 			err = ovl_set_protattr(inode, upperpath.dentry, fa);
 			if (!err)
 				err = ovl_real_fileattr_set(&upperpath, fa);
-		ovl_revert_creds(old_cred);
+		}
 		ovl_drop_write(dentry);
 
 		/*

-- 
2.47.3



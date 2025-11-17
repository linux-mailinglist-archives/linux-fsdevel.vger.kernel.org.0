Return-Path: <linux-fsdevel+bounces-68672-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5213BC634F0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0B2823681E9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC2232E13F;
	Mon, 17 Nov 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a18mWg0l"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2587B32E121;
	Mon, 17 Nov 2025 09:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372077; cv=none; b=Rus5CCnCupcBDEcsgFhXa2g6SKRU8IMRW2efUnI7WvTwqGFuHoRAOLAYw0KqlJuVeuwFBxYtgnT7L0zLCeigRbeLDWaJWm6wpVSI5mA4BDz46gcmZopBEo4Smtl/jp9wDaXa7QO5kLwuoGv7RUKpLWIoMmUn9l4ROm6+YqKbI6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372077; c=relaxed/simple;
	bh=v9EfvUjy/UZTOSxkY5Jk5IzQxKITiZRl2FR/498WhRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=py9JoEZYv3RkTP2gKVNOufHUqBQBObVnFrv5h/zZDY5MfrDEG+w3WMMakq/ipTYtNjeogAhoE79rjFR16TfmmPU1R+IQJJDriUe6L62aasJr4p3O6iwNL1/znEZlIrpCEIXkjVGCqGLqFnGokkEOY4LTB/P5WdfJSn3GIbwOyo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a18mWg0l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89233C4CEFB;
	Mon, 17 Nov 2025 09:34:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372076;
	bh=v9EfvUjy/UZTOSxkY5Jk5IzQxKITiZRl2FR/498WhRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=a18mWg0leUhIhYkU+/FPr+FdizIMSm4U+bPRTOeHg6eVJMkIiQfIKds3G4A0sqtj2
	 lI2XZIbvIkko4kK5F9xv9FRyP9VS+viiArXsHKzyl2n3B1c6uotvw+7S3S+Z9FD6PO
	 vzuJg+qd9WA+DLSN+yarmFUW8KjkWLrKnhJhchloJbtARB9BEyYPsoMT3D5Ndwfbov
	 QUVKJBNPI9IfkNBvUPYzIyA0kTAaxJTScgbLljEGF+23W/bln0WKqIg5Yvc1t0I/u5
	 V+Zx+8QcRTjVNcMlisNk+nqGqGLWTkCXrwTG7ApCz2gv7WnXja5zWRfNVP0A+6Vw0z
	 aeIBqG5nfIz4w==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:00 +0100
Subject: [PATCH v4 29/42] ovl: port ovl_nlink_end() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-29-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=brauner@kernel.org;
 h=from:subject:message-id; bh=v9EfvUjy/UZTOSxkY5Jk5IzQxKITiZRl2FR/498WhRA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf7mfPPvG+dDT38oNu+fImxmZDbDszf6darcgln5r
 zuUp/yz7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZiInB8jw58LgZ7V7k8ela48
 eOxfE5u14Qzt4sP+LeayK+O33XOKP83I0P8/qPh0tcSXhkJHk5ULqr/bP/VTO7fs95MrK13PL1m
 bwwgA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/util.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 2280980cb3c3..e2f2e0d17f0b 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1211,11 +1211,8 @@ void ovl_nlink_end(struct dentry *dentry)
 	ovl_drop_write(dentry);
 
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(dentry->d_sb);
+		with_ovl_creds(dentry->d_sb)
 			ovl_cleanup_index(dentry);
-		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);

-- 
2.47.3



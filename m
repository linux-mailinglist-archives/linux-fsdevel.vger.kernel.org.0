Return-Path: <linux-fsdevel+bounces-68646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B3539C63433
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6F75335F24C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 566FB328629;
	Mon, 17 Nov 2025 09:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MczYxfXU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B198A328617;
	Mon, 17 Nov 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372030; cv=none; b=I6foN5ReV38sTvjAzCfrYf4TITgDdOiv7zAtn8Ma/bH4Od41Z8l/CXQeb9KG0Et3myvOqHBLNHvVfaCk7jZdKFL0jsIbaR/4O6+FlOS7uJ2vNb7PudT5Ng9YvEAsVklE2lKc6a2k0nDmgwagq8cLuC/qX0vx0mDcSUTtwX6DJLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372030; c=relaxed/simple;
	bh=RWN46hxxO3PbVkc/uDitbpirE1sdO2zZT61ELJ82I94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H0UsjBWvht7M75SZkKIGYvw7xoUhctGL6bhZQgqj8evBRSb0Pv+ralPVOF3AmZv/epd5AdTDRZEjDB+jITJjL2bpPYDdvBxvgXpQohGOTTqWtaoaQY6/aaYbxWK1T3ffwzb9W+Cx5sJjUKwMzTCjLw6lN7n29TpWObJ2KpU3ZZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MczYxfXU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB307C4CEF5;
	Mon, 17 Nov 2025 09:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372030;
	bh=RWN46hxxO3PbVkc/uDitbpirE1sdO2zZT61ELJ82I94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=MczYxfXUN6tUfhMyjw+CGPAqxDsT0KFgVJjT7NGH99Ay59litn7IYSR0Atu2mbOCm
	 xLf7dQy8Ergpd5f+UTQpxtC/rfdnJjJrAoOo2qxFDRQAnpYs7g9o5FYq/auNvqVQCZ
	 9Z/kVbfiwAJ/PcV6khYlAgHzRww9VUwGxnf7GXEaxs955mxR5HOR+g7MGW/FIIfmDJ
	 fte9ql7hJutgGKE5i2Vh+nZoNaB9AUArCs4qWJGjv9PdSp1acFc4JBhvRtBQcUJdyC
	 Yb5Oe2onVk0nwD+cJOkfHwuSv/mstNURHNU9IPFxhXel4TAHYSGw4zDWkOTXTbYlzT
	 EMjs4b9rJBNpA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:34 +0100
Subject: [PATCH v4 03/42] ovl: port ovl_create_or_link() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-3-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RWN46hxxO3PbVkc/uDitbpirE1sdO2zZT61ELJ82I94=;
 b=kA0DAAoWkcYbwGV43KIByyZiAGka6/Si8Zuzs/HBQ/y1hTo6RvhHmwpTwqi9VQ9KflJGZJaZI
 Yh1BAAWCgAdFiEEQIc0Vx6nDHizMmkokcYbwGV43KIFAmka6/QACgkQkcYbwGV43KJWagEArcQ5
 QoBVJQzy4AOqyJ50Als5sCOPNfYBwG3Y3u0IxBYBAIvW71k3sQJmqPjldt558eM2vglTxlh22uv
 y9xCb6NUH
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index a5e9ddf3023b..93b81d4b6fb1 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -612,11 +612,10 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
-	const struct cred *old_cred, *new_cred = NULL;
+	const struct cred *new_cred __free(put_cred) = NULL;
 	struct dentry *parent = dentry->d_parent;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-
+	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
 		/*
 		 * When linking a file with copy up origin into a new parent, mark the
 		 * new parent dir "impure".
@@ -624,7 +623,7 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		if (origin) {
 			err = ovl_set_impure(parent, ovl_dentry_upper(parent));
 			if (err)
-			goto out_revert_creds;
+				return err;
 		}
 
 		if (!attr->hardlink) {
@@ -641,23 +640,17 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			 * create a new inode, so just use the ovl mounter's
 			 * fs{u,g}id.
 			 */
-		new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode,
-						     old_cred);
-		err = PTR_ERR(new_cred);
-		if (IS_ERR(new_cred)) {
-			new_cred = NULL;
-			goto out_revert_creds;
-		}
+			new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
+			if (IS_ERR(new_cred))
+				return PTR_ERR(new_cred);
 		}
 
 		if (!ovl_dentry_is_whiteout(dentry))
-		err = ovl_create_upper(dentry, inode, attr);
-	else
-		err = ovl_create_over_whiteout(dentry, inode, attr);
+			return ovl_create_upper(dentry, inode, attr);
 
-out_revert_creds:
-	ovl_revert_creds(old_cred);
-	put_cred(new_cred);
+		return ovl_create_over_whiteout(dentry, inode, attr);
+
+	}
 	return err;
 }
 

-- 
2.47.3



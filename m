Return-Path: <linux-fsdevel+bounces-68296-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE1D6C58DF7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:52:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF179425BD0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC5C35A136;
	Thu, 13 Nov 2025 16:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+t/8XsT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E1A35A127;
	Thu, 13 Nov 2025 16:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051855; cv=none; b=c8Y45VELOCb8Eo7Gs3Nh2zpKr2F3zU3+xZ25MGw0CMr4wEptMEIJ8xdAlXIlRFHghy0ZmFJpROf1v7ku4RffzOmHayKy21QmMEwVRVbuBUaz6vAF0s7mbsJFxxc0Ef2cS+A61sImeslSBTVxIZ8oPh9I6hMIji559FdMH+h/xn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051855; c=relaxed/simple;
	bh=K05rJcsTSxesI0K4W414eSV8oZcN9PZHGdFlF02WwKE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PP8Ok7eXFsZsUDcBjGSkBFjBn7ytEj0ZdXVXC1C9BToKZ+pyiokQvW4HfmmYT6urtOuYzGCqOvYQGAVM/nGZVhyp3Vo0PBRxI4IjASGD+L2NPeABTPxKatNmdoZ/Q5QHJqiuX7iV7KL8QYAlDQDJogBG8hwgAbAiREZ4ptRok/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+t/8XsT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00614C4CEF8;
	Thu, 13 Nov 2025 16:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051855;
	bh=K05rJcsTSxesI0K4W414eSV8oZcN9PZHGdFlF02WwKE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=E+t/8XsTXIBWQGeZ6OdO47ZQWEmnggTDpo+7qY+SVrs2PPccKOUEvej3brXwJ2bdz
	 Xvwvqjaxo/NX/JhOVh+BppP4stb3adimvrbLYB/sO+UOJbT6l1XHL2kWfM1+yZWpnY
	 AKDwSBU9o64TA5g4R0Lu6OYWhod2+N0L1YFnXqIT0DjUB/MTGmeGZ+Ys8H7trM5b4J
	 zvvZV7oThjq6VUot8ry50tnToXT++0QJECCXki55GBj+QD/exoakPT/RRo8NKsJx4C
	 v+/hNMwz3mIbupICBeekKzERahKYtZd/NTgh1cFDb5aBw7x2SvJyyAvfPrz5Aty+Dy
	 KBCzdgk//h3Cg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:08 +0100
Subject: [PATCH v2 03/42] ovl: port ovl_create_or_link() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-3-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2083; i=brauner@kernel.org;
 h=from:subject:message-id; bh=K05rJcsTSxesI0K4W414eSV8oZcN9PZHGdFlF02WwKE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbrm5eurPrvgwFLx9ffDs5dvduzw/cojLGulddS6m
 OVtdNLSjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl8fcbI8E12XfqqH2/Ykp87
 TV0Q6/z30PL78fucdDvTdZnFfs2s3cDwV/ztoT/rpV4nClvPmxB76aHMse47SgI6fy3SPIuyTDs
 y+QE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

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



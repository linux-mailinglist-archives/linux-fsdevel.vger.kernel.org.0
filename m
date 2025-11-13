Return-Path: <linux-fsdevel+bounces-68359-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC91C5A2AE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D46444EFDE2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A20C832570A;
	Thu, 13 Nov 2025 21:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EjWb3aqV"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FCA324B14;
	Thu, 13 Nov 2025 21:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069536; cv=none; b=UQVZQXSKJ38zL+2VjlO2xihTRQ6GOw4eXyLs3UdyhXH8TaHS4K81pc8WMRul6QVfUpZ1yOg4p0K7KUP5PWE+Vv9s2L6Izz7/QGJBx3kjPgNTT/wuQAXUDTSTmAxDMwnDgdCOfrHxp8A72xwCrpUxLLQUPKTZjsklneL/vXSaXmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069536; c=relaxed/simple;
	bh=RWN46hxxO3PbVkc/uDitbpirE1sdO2zZT61ELJ82I94=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nqMwORaDC89bHigBLTusJYOxUzGbu8zAeHh3fvp4LWvRZopLk8T47P+vihPCl1VkCRlSXN3bysbHKB4tpouQJrlGwWZ5Mbx98ZqUxqPovmCRpGHAydcFWzKutMWxrlts+Zv/mx4sxk6N9R8Kdw1h5LRmQwjtelu5mPobrETaU4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EjWb3aqV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B34C4AF0B;
	Thu, 13 Nov 2025 21:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069535;
	bh=RWN46hxxO3PbVkc/uDitbpirE1sdO2zZT61ELJ82I94=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EjWb3aqVmHzGqd3slWP+HDhIZFa7JiDRDnLIGDQBoAUS4s7UXZW6+L6VfDoUX05PC
	 yX0S4og52ekm50xNsf16Ib8CT1zQY3GOXqRiY9fbTEjod+knUeVDTfJBrsXxkBhrTx
	 xkayxQ5DVm860otosvH214xLxFvxknPpz2m8wOq6E+BmFn9V4DJ14rk7awVEcek135
	 vY794qNHRmBrQ5ah4DR1g1gdByJ8vEqYgWtXqQNv8JPVsGWmWG8bzRlChZNEHGvfph
	 CEB3jcReezzeA+OzN14hKpwo97DaX5jzzGDthSQlHLEgEWnNNW8OKeXgDRXZx278gL
	 TMwV8a+4B0fQw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:46 +0100
Subject: [PATCH v3 03/42] ovl: port ovl_create_or_link() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-3-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2133; i=brauner@kernel.org;
 h=from:subject:message-id; bh=RWN46hxxO3PbVkc/uDitbpirE1sdO2zZT61ELJ82I94=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YVdv2LTr7Km7ljQtTQt2RieO3pFZ7WrJk/te2Dem
 ZBdzynRUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGJhxgZ3r93n+G0/YSYJ4PC
 vpKSA1HFBsfma8UKv5l1ZF+Lge80BYb/jm1yX6etcjDri/PMWh+r31S+Nyi2Xfn9lTNNfurHZPJ
 5AA==
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



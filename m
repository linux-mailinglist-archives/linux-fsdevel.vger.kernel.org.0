Return-Path: <linux-fsdevel+bounces-68238-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 366AEC5787B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E31E4E1C73
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0C0235293C;
	Thu, 13 Nov 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HKKqrKq+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 188C435293D;
	Thu, 13 Nov 2025 13:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038989; cv=none; b=IB4enIFDyatHCFeFtTd8af45+rR1h/IfInJYw5E2F+3ZK+qMlbC1V7SyE/9JIHgVSqyp5h3v8xSyAu3W1my6NkHUhZsOKoYKq5Poz0koqlob+ncS+IhfXPotDOqbAjrAbHgFV1O9U94cCrELisGU8h0wpIOLCS839O9qy4/26lQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038989; c=relaxed/simple;
	bh=hzuwmuT13cbBELF/adNXR1aI+DE6g/rEkJQCPV7CDds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hPTYxnr79SQ67us/UDQuQCjWMsZVm5kwc+6XU4efIx92fngnKqjDk//I0Uig7NQ/c5wpPoB7UJT+r7BhDhuKyxwOs/lvVVTKbgUGX2ZQ27MvaHCCp2X3DfZqSKoU7CFTmnLPiCjB1GlbjTyKm+xMkc7goWoutVCGm9FoU6UVNww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HKKqrKq+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8996EC4CEFB;
	Thu, 13 Nov 2025 13:03:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038988;
	bh=hzuwmuT13cbBELF/adNXR1aI+DE6g/rEkJQCPV7CDds=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=HKKqrKq+2fjx1bwb1swqwSAzrDPkpBriNQA8qVZRGQei46zr85lpGGrpcF3Ckucsl
	 qawnQZprYFeUUIsMIiUyGUDSnwEYKgElemQgTXlLl0oWd0kSx8wrvFOVX2WkAmt5wg
	 4pXz/6vsZ4NmSddaIHTm7kFTkF1SacnihUqjeNDRy1wEHYEzfAzk0bJhKptAuGZMM4
	 F+TNL8yFm+Kdot5Ltd/mBhLu58a9NclozuylBIu+K149S3mg98Pk1004dVav4OUFzR
	 8JLxlfvdY9lWnhxzcsFkfgajUSMqRoI8vu8qk7CR7PTElHS+ntYx7YEyHYI36j15EW
	 k1yXXZDZfBMPw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:41 +0100
Subject: [PATCH RFC 21/42] ovl: port ovl_fileattr_set() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-21-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1707; i=brauner@kernel.org;
 h=from:subject:message-id; bh=hzuwmuT13cbBELF/adNXR1aI+DE6g/rEkJQCPV7CDds=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnscJpWd+ZHhsv2jLV6vtye2OC2pcGILuFfy44WaQ
 ueu9g8GHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABM5t4SR4fMOPfMmnRWey9J4
 NE7lrko7y3JzUwt7nCFH6+8XTme7DzH8swxYrHXEcI+59pyngZG7snfVBj8LXVj3fGm9/JbSUya
 /uQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

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
 
@@ -650,18 +649,18 @@ int ovl_fileattr_set(struct mnt_idmap *idmap,
 		if (err)
 			goto out;
 
-		old_cred = ovl_override_creds(inode->i_sb);
-		/*
-		 * Store immutable/append-only flags in xattr and clear them
-		 * in upper fileattr (in case they were set by older kernel)
-		 * so children of "ovl-immutable" directories lower aliases of
-		 * "ovl-immutable" hardlinks could be copied up.
-		 * Clear xattr when flags are cleared.
-		 */
-		err = ovl_set_protattr(inode, upperpath.dentry, fa);
-		if (!err)
-			err = ovl_real_fileattr_set(&upperpath, fa);
-		ovl_revert_creds(old_cred);
+		with_ovl_creds(inode->i_sb) {
+			/*
+			 * Store immutable/append-only flags in xattr and clear them
+			 * in upper fileattr (in case they were set by older kernel)
+			 * so children of "ovl-immutable" directories lower aliases of
+			 * "ovl-immutable" hardlinks could be copied up.
+			 * Clear xattr when flags are cleared.
+			 */
+			err = ovl_set_protattr(inode, upperpath.dentry, fa);
+			if (!err)
+				err = ovl_real_fileattr_set(&upperpath, fa);
+		}
 		ovl_drop_write(dentry);
 
 		/*

-- 
2.47.3



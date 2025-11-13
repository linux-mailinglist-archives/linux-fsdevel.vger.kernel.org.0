Return-Path: <linux-fsdevel+bounces-68388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F5CC5A34D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A78D84F4934
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39B82329365;
	Thu, 13 Nov 2025 21:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OELwX0f/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972C3328B4D;
	Thu, 13 Nov 2025 21:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069588; cv=none; b=H2ACKVdQOAGH9yZppyHJuTkayODPMUZvfRzYPWiy9O5jC9sC1JlCfA7EVXdfnsE5WqfhYy+zZ+QpVxPSU+Yafr/9CPRJASnxZ9xtQVEDrQzOdrR+yEsd25DTJY8F5ygf0n3o1zwfT5cnuYUI7Hf6MuuXFdRu2Oc4miwiRfFjriw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069588; c=relaxed/simple;
	bh=tbbll9BaN3ZfB9tP2Vl53xUN16ilfJAE9+ubAwOu1aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JyVsPVxpCJF4+WsdiOvOGWk1kkD0tCSuLLM71m9kTxVLy9f2+1Zb3hSvD4BQl1U4v113OlEqMrZa5EFEBIXMmF/1wlRVzGPp9eGPfPFkRBXJ8Lwa5mfbEYwPlj/GJ/qYE86FpQoyF2KXsweAa9d/JTFHmlI4Z6JaLSkqwuw144Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OELwX0f/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080CBC19423;
	Thu, 13 Nov 2025 21:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069588;
	bh=tbbll9BaN3ZfB9tP2Vl53xUN16ilfJAE9+ubAwOu1aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OELwX0f/pj78G8qSD/awVSOyAw51xh4Z/EnbZizqAUY1TSfhCmHH4gP8aavnXqXya
	 UXTJhSVMq2Z7XNPT1x0Me6TJoBk20bb5C5c3qeeTW3pkOOIiSaSkF4X70C9qZJPdui
	 WNEgVA/Torlqf2kVUi38hjFBO1rwZwILwyU+JphONb0sqWLBe3HU888ZfUOykWdZmQ
	 s7TAQQjM7TBixPOoSUGPxzaDFu7WSmQn3AMrgDQsTVR/4Pyk0HaoHRSP2Ppl9yrrci
	 jbXAPjJM33mDXPmMMS3QUj7vrAGNmuaKbzg1j1yPAVa63Q19wY/UEdfYvxceL066wS
	 uf9yVAzZk7P2A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:15 +0100
Subject: [PATCH v3 32/42] ovl: port ovl_listxattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-32-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tbbll9BaN3ZfB9tP2Vl53xUN16ilfJAE9+ubAwOu1aY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YW/vsT7UafuHO812YevM3ntDQWui04L3bPkXGz+j
 QtL/87O6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIf3VGhlm8O1bpRD91fGbY
 VThB5kHKw0q3GlVNzxPlN4Xb33HIxjMyzPjLG7224XH9W9fP7y58n9yy3Plrgvje4wWejVWyhzd
 t5gEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 788182fff3e0..aa95855c7023 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -109,12 +109,10 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	ssize_t res;
 	size_t len;
 	char *s;
-	const struct cred *old_cred;
 	size_t prefix_len, name_len;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb)
 		res = vfs_listxattr(realdentry, list, size);
-	ovl_revert_creds(old_cred);
 	if (res <= 0 || size == 0)
 		return res;
 

-- 
2.47.3



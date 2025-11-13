Return-Path: <linux-fsdevel+bounces-68252-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0638C5796F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF4383BE08B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B00335504E;
	Thu, 13 Nov 2025 13:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IoMf4ZUC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66F7535293A;
	Thu, 13 Nov 2025 13:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039014; cv=none; b=hON29uNlW9tNMnji3UbcpkXzZhxUUORgqqYIt5my9b/mrx1n4cT+gOBGBtj7FsPbXHd9/cgD67I8GnCtbwwz8G6N0YCwUiSENelHrss686lL8b2cR0Nd8ZIYK+LLj+1jKoYDCo4veR+uHJEJeVw1Ev7fIlXMUXuD2otgWYuTBDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039014; c=relaxed/simple;
	bh=CFmDSJn60lAcCqKxODsd7qHmFYdSq5vO37dkl+EU1jg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CPDNO5P8rxmSxmvLuq3JaEyVQtCrusNd9bQgyHB6FkxN16AM9VlGN0O9VcGt+LWwYV0NY3QBCeGrSXTAsAQFCViweylU8OVXOwYFFHS6ScSvDgxAHI1Cx9t5npcEV0PfjaBU1aa9ZjrHpqHlikFSG+Zl7s5dZUUp1PcuHM5VvRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IoMf4ZUC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF8AC4CEF1;
	Thu, 13 Nov 2025 13:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039014;
	bh=CFmDSJn60lAcCqKxODsd7qHmFYdSq5vO37dkl+EU1jg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=IoMf4ZUC3gZoaQOODoFYULaY6klK0JKDGncVX1UT4JShJ1gbvqcCwUNr1e3A03O/e
	 jtK2Im0fNjnpQk+RDkYmIthjS5dhMAOg8G0VLUHMJCUT5C4GWggBT/pE0BH15TG/38
	 xSQJ5De7iE/XOX543Oit7r8sUEMRguTEfsURbWYlyWpYurdOo2m29LcfU8LxBTgMP4
	 oGZn3m8PzbUzZdUJ8a1klnrfdu4SSHDB0qW6blvwRsvi9gNwq+Sxp73NMKmwq8NPBi
	 kkbkcCRzubjBpPQGQZCxlY0dcpuCk3IC6uj90HpIO5p/+LMQqsGsg+MOF25/z/0Wwp
	 JmCDJCOedqPhg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:55 +0100
Subject: [PATCH RFC 35/42] ovl: port ovl_rename() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-35-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1040; i=brauner@kernel.org;
 h=from:subject:message-id; bh=CFmDSJn60lAcCqKxODsd7qHmFYdSq5vO37dkl+EU1jg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnsyI/a48Hv2onlcT/zfKwet26rzmOm17TGh/mmuD
 9pznTandpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzkkBvDP+OlN+rf3PhwZN+C
 HXbcghftD+v1HVsleO5ciap7Yc2X93yMDM21SeV5Rpucr1rr/f5lKzCvZaIGg/56u0c/71RO2sT
 DwQcA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index d61f5d681fec..c4aac04fafae 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1246,7 +1246,6 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	bool overwrite = !(flags & RENAME_EXCHANGE);
 	bool is_dir = d_is_dir(old);
 	bool new_is_dir = d_is_dir(new);
-	const struct cred *old_cred = NULL;
 	struct ovl_renamedata ovlrd = {
 		.old_parent		= old->d_parent,
 		.old_dentry		= old,
@@ -1317,11 +1316,9 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 			goto out;
 	}
 
-	old_cred = ovl_override_creds(old->d_sb);
+	with_ovl_creds(old->d_sb)
+		err = do_ovl_rename(&ovlrd, &list);
 
-	err = do_ovl_rename(&ovlrd, &list);
-
-	ovl_revert_creds(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 	else

-- 
2.47.3



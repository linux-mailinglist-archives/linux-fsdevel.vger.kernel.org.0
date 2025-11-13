Return-Path: <linux-fsdevel+bounces-68331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4117AC58E8C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6E64420BA4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F03836997B;
	Thu, 13 Nov 2025 16:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oR2F4O37"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA9D92ED151;
	Thu, 13 Nov 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051919; cv=none; b=K9ACEJ8HFXRNYZ6J1ZLbDU/sCWTLK+3od9W4V77h100tgP8UzVkprbpJymP1Jseyxd0xNgzOqUZsqc2Wo61tqxjgnWSLUpFEcyL+ZAiPV4EYYzUz8h1LszTn171PvhAuAoJzMA252l1TSE9eMoby3SV+DIPk8KDm1sI48dyhJno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051919; c=relaxed/simple;
	bh=8rbNdTRr/OrmniwQ4NlCbGbMxw2Lwhzj5g/pDbMJ9HY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CJcUODVwkgyU7nwXW19IBIT3/6FbWtB8AvntzY6Vvp94eqEb0JSmRMVr7rJ/W951QqpgxpdTp/CJZM5GDl1FEgsBGP971sBXZVkWZb9Ok208FhvNwBoqzbmf6aRmAK1bcUkWczPJS8f/s1dsPc82szq2sQHTF4iBX7y08oW+mTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oR2F4O37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679E0C19423;
	Thu, 13 Nov 2025 16:38:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051919;
	bh=8rbNdTRr/OrmniwQ4NlCbGbMxw2Lwhzj5g/pDbMJ9HY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=oR2F4O37oH5bB2CzhKOt5VmRtSrm4eylpV57MJXh8OQlT7EB/vKW31dou+Otv9nA7
	 9TxVm9gKo2L7wnfPjK+ks737EslqxwPbbE9j2taUhp+cnD/pgaLf7TzcJIhV5F88mG
	 XeoMiZWLXEXJOn+LRHKjJtEepWnTnSLz/INsEmTpYCYRwtFbk/giFB7420iWrFzuCS
	 /I+vCVeAspCj7No2f/TZt+30ies/Q7XSloRWnYRbOF4ii2k3HBd1iXviIpvR9cV57f
	 I8TZ4bZGWhY8qKQw2ChmuLhsJxZuY40JGqt7xBaqNPxO3k8YyhqpvnkntOeFL3TglW
	 VuqJoQKETgLdQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:43 +0100
Subject: [PATCH v2 38/42] ovl: port ovl_lower_positive() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-38-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1629; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8rbNdTRr/OrmniwQ4NlCbGbMxw2Lwhzj5g/pDbMJ9HY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbrv3SHGYKrqM/VfzP5jmTov1r39ZZu4fZPq3DjdH
 xP07IJ2d5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEykKpbhr1Sj2cNW97Zd4vs1
 TzJdP8nFVSVoUvnJ5P89ZRb2+WLV3gz/vX89SFJ/N9da6b1e4PHr4dKXsrfb/1Prif0aMHPSk7M
 MrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 9c0c539b3a37..9364deac0459 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1418,7 +1418,6 @@ bool ovl_lower_positive(struct dentry *dentry)
 {
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	const struct qstr *name = &dentry->d_name;
-	const struct cred *old_cred;
 	unsigned int i;
 	bool positive = false;
 	bool done = false;
@@ -1434,7 +1433,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 	if (!ovl_dentry_upper(dentry))
 		return true;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb) {
 		/* Positive upper -> have to look up lower to see whether it exists */
 		for (i = 0; !done && !positive && i < ovl_numlower(poe); i++) {
 			struct dentry *this;
@@ -1445,8 +1444,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 			 * because lookup_one_positive_unlocked() will hash name
 			 * with parentpath base, which is on another (lower fs).
 			 */
-		this = lookup_one_positive_unlocked(
-				mnt_idmap(parentpath->layer->mnt),
+			this = lookup_one_positive_unlocked(mnt_idmap(parentpath->layer->mnt),
 							    &QSTR_LEN(name->name, name->len),
 							    parentpath->dentry);
 			if (IS_ERR(this)) {
@@ -1473,7 +1471,7 @@ bool ovl_lower_positive(struct dentry *dentry)
 				dput(this);
 			}
 		}
-	ovl_revert_creds(old_cred);
+	}
 
 	return positive;
 }

-- 
2.47.3



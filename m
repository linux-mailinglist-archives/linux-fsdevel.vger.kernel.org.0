Return-Path: <linux-fsdevel+bounces-68395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E4432C5A3A4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:48:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D766B4F6A4E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D49F329C74;
	Thu, 13 Nov 2025 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iC6io8mX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C12A324B14;
	Thu, 13 Nov 2025 21:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069601; cv=none; b=Ssg5B/KJ4SgSRYvUgFGK7DZn6OarB8FsU14OfBfztsnyLUSOjSfz96e+C4aQPEHvrqFPNVQHkbbYt/IhzQ3x2OsjnOGQaYcDQWoxD1+Smxwl1wvwb3q7g1n7N58xwJg7UMBIMWoYZsofKUF0FNMKvCxJvKXNChuh1158FGyHCO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069601; c=relaxed/simple;
	bh=2vXGl11y4rFMzthu7FaEYFzqig0JEuF9SfBTKuDpYJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BxutvROwgQi5+EvSu3kUPWn6eq92IjBxuAfjaO3BPpnlIsSzItjCAS2jRNLsbaP1VCOQtTvhhaOqJSlv43Vn5hNm9DOCXFpuodxAcysT31Yq5Kuf43zAXEPTd3BgHQQJ5n+DSwTk2hjjDhrMqJKJhlIa8pjAKnufpI40F1EIV6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iC6io8mX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA008C4CEF7;
	Thu, 13 Nov 2025 21:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069601;
	bh=2vXGl11y4rFMzthu7FaEYFzqig0JEuF9SfBTKuDpYJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=iC6io8mXm6UYBF6WqvCNmvecspCzPQolyUbY5CF9otb/9v/xoDVewg9Mgo1iSkzdz
	 /dFDEo1tXnzwpM2w1yFxFqKgJufA+ve4/g9/R41MaHv0zK6Jhek9kA4DjaYmGz4cFC
	 OqlJKWhbg6lQt3ZKnA6baICLWh7tmOlyc3C7hgWKNHTgLWjmPrc+msFD2kfAVx/jM2
	 L8N1+tm+wzUX9a2TYWlblZYzcpAb3SsZAwHBYqm/c50KI99T+ZtbVS44g0fV3F55gI
	 bQeOqaP6gO5allQu1/gf4JweUywNfJiyuYB1c5s2veo2ba/EwSncqSm1XDMrQsjBNt
	 c6o0rcZcd2gQg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:22 +0100
Subject: [PATCH v3 39/42] ovl: port ovl_lower_positive() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-39-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2vXGl11y4rFMzthu7FaEYFzqig0JEuF9SfBTKuDpYJQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+UVstffysA/WkpvX5Ts9e8mRq1PnsMWH9ru4z/LhC
 nm8iYejo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJl6xkZnhtwHFA25+MNNzE8
 sCy8+vpzZu1fewUXrpa+nRerllsWzMjwp8jsdJFHu57vxFl3liV9TVBYHf7d5d6PfXKGOdtf2c7
 jBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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



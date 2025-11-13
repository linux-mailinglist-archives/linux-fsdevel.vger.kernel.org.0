Return-Path: <linux-fsdevel+bounces-68256-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7746C57986
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:16:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2573BFF26
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654F63557EB;
	Thu, 13 Nov 2025 13:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dhYR5gT1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C135D34D91E;
	Thu, 13 Nov 2025 13:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039021; cv=none; b=n81tf5PVSnMgOAWdxk0JjSMeqcpywXQgxx7yCFn/9gdfIIXG8zgqSOl/+vSG1Hq4j9eDoTWi74fFjbec1Wr0bHb4tUYylQmPk0ps4StHtwE1nwLLZxyXz/As0/wpnIlRFeDz4Wkzl1QSVML2/F2SeUYMG9zym8M3niVYFxpHeN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039021; c=relaxed/simple;
	bh=gApilVSdZedlVhBUAEa27wGpMwN4KpqL1zZLdcAKGhk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+Bbiy/Tbthnlkez+R4nQgmJDKxTiJ/x9nY6ddPBa3gVTJq0uDHAv7jXvsAPGYNGjRCdT6mdVRy+jnc015ROGCBBiU757SwaJKogtPdXq49ueU/u/JOuK6MGXlpQnCOj3pTv+v5o8B0X+34Adh6wI6QJ5v73eR3zg9Zi0M67M7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dhYR5gT1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05F1C4CEF5;
	Thu, 13 Nov 2025 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039021;
	bh=gApilVSdZedlVhBUAEa27wGpMwN4KpqL1zZLdcAKGhk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dhYR5gT1v96ECE/PLBAQhwELIw2vAxuvI+WiamwMa3TkqGogBtV0CZA8/bHPC3z9o
	 4DiBMMS//EvCayJBf7Ta+FN7eavzQZlI0rKx/XDzQp0agbXKAi7OTiMRon2EEwdbBQ
	 r0Kl7Da8IyJBxTLbD6qQe4cDVRm2dMU1mqAqM2cJv43W29nakOl9HngB2aqvxCI8r4
	 DMPgeLi2gETj7URfwHLeJ17eSZDv+XxjeZuc5ogaWFWBI7u9v3bLCexi/pWRS1OTCX
	 EYe6Dq/HR7+q8x73I1vO/Pkj5JMb/y6Rxrq3IKLR7CvgRBPv9r4wTqe3b/an936ni4
	 BNUA6ZAQyDcXw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:59 +0100
Subject: [PATCH RFC 39/42] ovl: port ovl_lower_positive() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-39-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3075; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gApilVSdZedlVhBUAEa27wGpMwN4KpqL1zZLdcAKGhk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnsyRfVwldiE48ypbw5ezp32daZh9HUn3i/n4g4tD
 iiQyTqU11HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARUTaG/447WuLL2v5cP3/0
 2kbXjMLlHf/8ZV0sDJr+Bt5S3hZhKs7I8I7tQtThHQKnX9qv5b21LXjv7JnGK3SE+TTZqq5tD0y
 5yAYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 72 +++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 37 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 03ef31afdd8d..abcda3c85173 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1419,7 +1419,6 @@ bool ovl_lower_positive(struct dentry *dentry)
 {
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	const struct qstr *name = &dentry->d_name;
-	const struct cred *old_cred;
 	unsigned int i;
 	bool positive = false;
 	bool done = false;
@@ -1435,46 +1434,45 @@ bool ovl_lower_positive(struct dentry *dentry)
 	if (!ovl_dentry_upper(dentry))
 		return true;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	/* Positive upper -> have to look up lower to see whether it exists */
-	for (i = 0; !done && !positive && i < ovl_numlower(poe); i++) {
-		struct dentry *this;
-		struct ovl_path *parentpath = &ovl_lowerstack(poe)[i];
+	with_ovl_creds(dentry->d_sb) {
+		/* Positive upper -> have to look up lower to see whether it exists */
+		for (i = 0; !done && !positive && i < ovl_numlower(poe); i++) {
+			struct dentry *this;
+			struct ovl_path *parentpath = &ovl_lowerstack(poe)[i];
 
-		/*
-		 * We need to make a non-const copy of dentry->d_name,
-		 * because lookup_one_positive_unlocked() will hash name
-		 * with parentpath base, which is on another (lower fs).
-		 */
-		this = lookup_one_positive_unlocked(
-				mnt_idmap(parentpath->layer->mnt),
-				&QSTR_LEN(name->name, name->len),
-				parentpath->dentry);
-		if (IS_ERR(this)) {
-			switch (PTR_ERR(this)) {
-			case -ENOENT:
-			case -ENAMETOOLONG:
-				break;
-
-			default:
-				/*
-				 * Assume something is there, we just couldn't
-				 * access it.
-				 */
-				positive = true;
-				break;
+			/*
+			 * We need to make a non-const copy of dentry->d_name,
+			 * because lookup_one_positive_unlocked() will hash name
+			 * with parentpath base, which is on another (lower fs).
+			 */
+			this = lookup_one_positive_unlocked(mnt_idmap(parentpath->layer->mnt),
+							    &QSTR_LEN(name->name, name->len),
+							    parentpath->dentry);
+			if (IS_ERR(this)) {
+				switch (PTR_ERR(this)) {
+				case -ENOENT:
+				case -ENAMETOOLONG:
+					break;
+
+				default:
+					/*
+						 * Assume something is there, we just couldn't
+						 * access it.
+						 */
+					positive = true;
+					break;
+				}
+			} else {
+				struct path path = {
+					.dentry = this,
+					.mnt = parentpath->layer->mnt,
+				};
+				positive = !ovl_path_is_whiteout(OVL_FS(dentry->d_sb), &path);
+				done = true;
+				dput(this);
 			}
-		} else {
-			struct path path = {
-				.dentry = this,
-				.mnt = parentpath->layer->mnt,
-			};
-			positive = !ovl_path_is_whiteout(OVL_FS(dentry->d_sb), &path);
-			done = true;
-			dput(this);
 		}
 	}
-	ovl_revert_creds(old_cred);
 
 	return positive;
 }

-- 
2.47.3



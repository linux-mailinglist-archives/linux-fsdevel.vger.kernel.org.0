Return-Path: <linux-fsdevel+bounces-68682-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E4BC634AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D4D0B355AD4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57BF32E727;
	Mon, 17 Nov 2025 09:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdlsRyvq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB1B328262;
	Mon, 17 Nov 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372095; cv=none; b=lF/mFiSg75Xv8lTZaOTgCfUQS/JCHnQrsgCEg2oEf03pM9TTbrNG8syBbs7mtiu42wDhd/1E2h6UkTyb7h4Vxhpkj8lFDNyur0wzcJatWYyn6LYggak1li1Z3koDNj6sYtUn++tIbvRmnRG1BYPc7n22mBTLN0fPwQwJSeyUQMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372095; c=relaxed/simple;
	bh=2vXGl11y4rFMzthu7FaEYFzqig0JEuF9SfBTKuDpYJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ul7npOY/mYfwdiNxsI00A0wBm4291u3JRfHAWT3ZQ0D3CyTclTQKnVXoLbcc4B7GFjmVPGEzyu1L25TM4d+tGkTxCB6IFjIWC7h4ITJlemVcKUSKHmeJ8isKUwOyV3okHYIZKMg48IZCAiipt+e710bFVB1w8AKuJKJjs0ZM130=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hdlsRyvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A8FC116B1;
	Mon, 17 Nov 2025 09:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372094;
	bh=2vXGl11y4rFMzthu7FaEYFzqig0JEuF9SfBTKuDpYJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hdlsRyvqFJkDp0i2it6yrtNMCIrbr3rkD/c1vGKgjaueEAG90VVgYKQug9pQ9231Y
	 IXIIk/Tl2FWdHdg58YLUs8drhoiPVR0roy1xLsNR85h9ObjcWgk8/cMtxDFh4OMVCa
	 ctkD/VLlkjbMj6aaJ36xJpuTKNW12YfpQkR1ybRYxtl5eGjccHsePVjSmBvs54K8nJ
	 pAknvQuUf8CHpTqVkGKLtEoNvOmb8mohZhTngYvw8ZRVW9IIVNc94t+deTipM+KGyV
	 KadVUKDbVQqUNBnnkwDOxx05Ii7Y19UiVsYGF0KmSKVxJMs9hELpNO21PfioNIa5aY
	 83e/KtoUxCHCg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:10 +0100
Subject: [PATCH v4 39/42] ovl: port ovl_lower_positive() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-39-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1679; i=brauner@kernel.org;
 h=from:subject:message-id; bh=2vXGl11y4rFMzthu7FaEYFzqig0JEuF9SfBTKuDpYJQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf62fEnVlkd+vlZ8ff8kH0bZ/khhXj7TPL970+8Xv
 AbKojcPdJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAEzk0XNGhg49Sa6JyYWnZ/We
 EanfYyOZkxTz9Wy41oOHKy/fFZp64iMjw8OYEmkhMxHDN3Prvt8UeHl5sxj7FsOtKZe4kjqy9a6
 VsAEA
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



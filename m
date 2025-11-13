Return-Path: <linux-fsdevel+bounces-68397-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02704C5A25D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B4C513AC55C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5F63254A7;
	Thu, 13 Nov 2025 21:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KnhcnIKd"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C7A324B14;
	Thu, 13 Nov 2025 21:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069605; cv=none; b=KiEocwGVGGGolmMy3Tz5lJyriBf7ns+FXfXyL23b9ZUno2OjcHeJecK8Rb0b/c4s/XTygetnDimOE9ACMzBu7h4WjGwBN8Alxss3RtF1tVbUvHnla5B2X/XwQBtc43e44QTNUsK51lPXyZ4T8c2zWZoCdpLYtFEpw2zLAFsdV70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069605; c=relaxed/simple;
	bh=4ViGONZA18LPah3ntvkWt+hXmAFdyvqaR0vIurrBrcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UNmXbB+ge8xCa4KJDAv4+hwbQpigq36vVlYWJHoYsh75GThDW13RG4090j29V7eaaLSznMelJTmYbwh+2fYNqhC/dwUx5/Rmu9g0dYtPHleRaAv9axF+kWH7LDaTwjLt/GR0y6aBOoObQtGJuTatkhya3nYksvcBMZQDIUDvxIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KnhcnIKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED013C4CEFB;
	Thu, 13 Nov 2025 21:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069605;
	bh=4ViGONZA18LPah3ntvkWt+hXmAFdyvqaR0vIurrBrcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=KnhcnIKdt4PthEmkbt6J+3Yd3PvEOZjG0iLCxsXXybKiLDKQb2u7KWfUF/BPc3qdc
	 2VrhngOoGCkg3k3qH+Loa7ulEqicAm928eMpFXI7iDLtpauZIAFpoBzVgFZGEB1X3j
	 +gZpbLvRua5WMXrhGUJwt2VEk/srkAEHjZ5IdZIzGa+FC53aaMx07h+MTIUehsunAk
	 A2BGVe26B1WLxJHoPJ+E65cZ09KIPs/pTCtFutVf03CmPnbcEv9EmEj5sdL5KVsDpm
	 KqChcL37P6OkXI1oF29nqG/tX6pY6bH+eFL5kvNqDbWSN+qnyuPh+iMOAKzK9pVfZt
	 RilH8yxietBUg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:24 +0100
Subject: [PATCH v3 41/42] ovl: port ovl_fill_super() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-41-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4ViGONZA18LPah3ntvkWt+hXmAFdyvqaR0vIurrBrcc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+UXIHT/0dcmXsK5s3X7HEDcLjzzfd8+qnkV+6a+V8
 Xmh67Sko5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCKr+hgZ5l1j5ForeydPomyh
 emb5ZZ1NizOYXjWdkP179M4fz8ei7xj++7TYzLVu5dIMkvSo4GY1Djo6lfvQlPOyk9R+v/477dg
 lPgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/super.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e3781fccaef8..3b9b9b569e5c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1545,8 +1545,6 @@ static int do_ovl_fill_super(struct fs_context *fc, struct super_block *sb)
 int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
-	const struct cred *old_cred = NULL;
-	struct cred *cred;
 	int err;
 
 	err = -EIO;
@@ -1555,20 +1553,16 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	ovl_set_d_op(sb);
 
+	if (!ofs->creator_cred) {
 		err = -ENOMEM;
+		ofs->creator_cred = prepare_creds();
 		if (!ofs->creator_cred)
-		ofs->creator_cred = cred = prepare_creds();
-	else
-		cred = (struct cred *)ofs->creator_cred;
-	if (!cred)
 			goto out_err;
+	}
 
-	old_cred = ovl_override_creds(sb);
-
+	with_ovl_creds(sb)
 		err = do_ovl_fill_super(fc, sb);
 
-	ovl_revert_creds(old_cred);
-
 out_err:
 	if (err) {
 		ovl_free_fs(ofs);

-- 
2.47.3



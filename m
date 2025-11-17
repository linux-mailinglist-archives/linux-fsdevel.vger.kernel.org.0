Return-Path: <linux-fsdevel+bounces-68675-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D4652C63493
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2640C34F66E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0944332E155;
	Mon, 17 Nov 2025 09:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtXdyViH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC932E149;
	Mon, 17 Nov 2025 09:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372082; cv=none; b=IXUOkWzW6WdAUmmxwrQFCM/R+ZBQgFVaJgrwe0vk7OdpnOJsoD5BTSw298eHk5jStE/hfTjSQosA7yfBTXkKmFYnFsrfujf4/vycT61HteaeEsAAGizHmLWxDvtn6zfihJf1Rhx52bLxcjEZdUS7FJ2mx0GC9vwxt6FGW+b6WpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372082; c=relaxed/simple;
	bh=tbbll9BaN3ZfB9tP2Vl53xUN16ilfJAE9+ubAwOu1aY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PhlBpNHbTCyjRu9w+yppHtFX6f3tJad4zXVCO8oyZXynZ1FfX4CvqQtlBeBPdcKX90OTwdLsTGvfz1AYwCrwVDPX5o4SwSQUm5KGkNql3CNGYQ+DbIsFu7ypjIdWMrKLKpHylHiKRXZPL1cL80kAsUBsu2pqzspHv2NodOq83Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtXdyViH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A94C2BC86;
	Mon, 17 Nov 2025 09:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372082;
	bh=tbbll9BaN3ZfB9tP2Vl53xUN16ilfJAE9+ubAwOu1aY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LtXdyViHXTT3rdMBWPQrVGVs7M45X/wxGlYeVOZKx1llm2OLUVXVPmAp/gtEwcrIs
	 XwcUOoP4h4QX5vsofj45v9g4LhrLVot0mK8U51thioXQr+49R2IbxN7ewWS39TYrJI
	 nys+iWDfDB5h/8EVL1YJ0UiCey3b1wN63bjj7n8Ha4xlmvJE/M5NuKoSQ/zNImVN2z
	 89glUbTqA1fJU/KsKt19eCsSvDA8vBblZhuhVGSqlvmNoixems6NYml79AWo09wGoU
	 0Btd4VW3vEb3B27YtCKfiHCW4Oulh4OvXMRm+PvNhsOxanRmt1SAX2plVgZvxA3MJL
	 AJmaUSaF0peaw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:03 +0100
Subject: [PATCH v4 32/42] ovl: port ovl_listxattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-32-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=814; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tbbll9BaN3ZfB9tP2Vl53xUN16ilfJAE9+ubAwOu1aY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf4mFJjW9fY48+zM4Op9fLNZFr9zKDOKXDXvaOp/M
 wa3halJHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZVsjIMJVhdtmcdRdWTY6R
 lHKOaRPTaJwmasuc6f8otGjL5Wtazxj+e+UtP3ee19B5v/0BZTtvqTPJT3+fOmj8NUdMavGuuqp
 QRgA=
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



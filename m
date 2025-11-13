Return-Path: <linux-fsdevel+bounces-68379-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 806FDC5A3BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:49:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C8AAF4F2E66
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3968327218;
	Thu, 13 Nov 2025 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cyh9ahU2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9F325709;
	Thu, 13 Nov 2025 21:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069572; cv=none; b=gsqKXdTMJIUgZPOWztzIFZU8CeybC7O9tWhixNPTDha9BnpoO8Iby5eyYRj5tFeVptHbWNeYS7hCOZNwpSPg+BGuqvmELMBCR3J6aw/4IR5ETSES3InNWsBNLrKcIdgABs/n2NXIuD4rZkDe83uuBDe8rR3TN7iwf8poFxj9Axo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069572; c=relaxed/simple;
	bh=+g/GluygF5pVg5i/7eHUgEExa2gHAg95DrhJtpYm2Sg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ay3JyUDLiRwMPxIAe8KUvuWFcFtNkvRFVLq9GJPecyg4iHQL5L6MGDRFan102ZzGuNowvSGIWx/OtipvCFYzypbmnENJad8BOdqnRA15odQsQdDBa8++URC1+XdROoHeIfU3NSJ50kQiG0DTzpmijlQq5qbyNEdQ1rbORsx/Dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cyh9ahU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AD22C4CEF8;
	Thu, 13 Nov 2025 21:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069572;
	bh=+g/GluygF5pVg5i/7eHUgEExa2gHAg95DrhJtpYm2Sg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cyh9ahU2mdd38NZHHo6FVgrTFfH78mKkcTmqfzfApJXJrKt9Rq7XV3hHlKN5ewpdC
	 iM6fzAMoVHk2qHOU41KpDbAqEW3gWPXyW8q2rT8Vd5I0G0hvaNhQ7iCOkMCfkvZGoP
	 YFlrmAGSeoU6CsRrBa2pWL/6b5obK4vR2S91lgDculvpCzxBtiSxziDBUikDC44SDe
	 Ji3IaI3sKnos6XnB/37HAnuxefvm3+7phMTCk9hf9O3Bj9N6LkCYA7pbNRDM6W+6Je
	 bZCDxo6Ove9dUBP6VBVvY1OqDsf3JkwBFjPJXDLbuSkPY2p5vJjqVOJmyZe+MZQDlr
	 PSjhPZCku3dkA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:06 +0100
Subject: [PATCH v3 23/42] ovl: port ovl_maybe_lookup_lowerdata() to cred
 guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-23-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=brauner@kernel.org;
 h=from:subject:message-id; bh=+g/GluygF5pVg5i/7eHUgEExa2gHAg95DrhJtpYm2Sg=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YWL3zE5It28iCUpgnXKucr2W/vkZSuOqJ1aY3nXN
 N3P3upBRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESenmf4H7gndvpyxRQLe48V
 5U21zRM2/vv7yLJhUcGJrrBF/r5W6xkZPlW/qjCfF1CneGeel6MzA8u+Bxyd6udeH76xYjFjkdV
 9BgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index dbacf02423cb..49874525cf52 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -996,7 +996,6 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	struct inode *inode = d_inode(dentry);
 	const char *redirect = ovl_lowerdata_redirect(inode);
 	struct ovl_path datapath = {};
-	const struct cred *old_cred;
 	int err;
 
 	if (!redirect || ovl_dentry_lowerdata(dentry))
@@ -1014,9 +1013,8 @@ static int ovl_maybe_lookup_lowerdata(struct dentry *dentry)
 	if (ovl_dentry_lowerdata(dentry))
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb)
 		err = ovl_lookup_data_layers(dentry, redirect, &datapath);
-	ovl_revert_creds(old_cred);
 	if (err)
 		goto out_err;
 

-- 
2.47.3



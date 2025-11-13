Return-Path: <linux-fsdevel+bounces-68358-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB6FC5A290
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:40:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4D5E4E9018
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5DE3254B1;
	Thu, 13 Nov 2025 21:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbkJL1Yq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276A3324B14;
	Thu, 13 Nov 2025 21:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069534; cv=none; b=qVIdHMquztfimPOnThgtGHWcsR86JopK0LSkYUtgkzgiAFhhzr9e+1waCf+TF2OX6nzNT65lDI+EYxo9w9cb0t4+aP1rvK12nwFcvebhha19hp/tZL7Ae3BqsVWGP08VLr8NeOhihwfAnP1CI9FbJr0V2BLx+cz1cDUJFTSV8Sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069534; c=relaxed/simple;
	bh=jWaE5YKn/LlM2xmgC7PRVuH+dwbfgM8GZZeUmesP9FE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RI/Ad6xZQ01Bbfech6lUzys7n1olfE21OBKFjuCDad+4TVlz+zJr3CIrYFQj0PzrgHHVmTvkJOgUi7wqKcMushsO3SrO9SKgIoFCU/5xekODc4JY9yn9p/qfU7PgHrLKaqj0M/3fkvlkg9hzocAYUQJ/F3om5N+Z5EVOTCeI5Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbkJL1Yq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63781C113D0;
	Thu, 13 Nov 2025 21:32:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069533;
	bh=jWaE5YKn/LlM2xmgC7PRVuH+dwbfgM8GZZeUmesP9FE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZbkJL1YqAmT39WKo3pie2FdaedWLz4m3pte5HrrkN58l0NAAnhf8K1xOFQS2vNApw
	 0fk8VRw2qW87Boz1PzUWDKJpFKkbzRnC1I/D1bjZe4LObx5KR35XbyT6VPNh+BBWmO
	 Gn1/2JQQ0Aavn9kalo/gpZ2tmc2SabGh8+J/FUAcYR+lhe6FpNIPNo7QlRk0ROReI+
	 Adm7KP+f4YU1Pmt17t6joLSRjIIL5yHAPaNhpRuVi26BnzfK4gJNhcmBu5Ov9Eho9d
	 Ecf0f4ATEsVXUs+NhZC3/UGWHrft4wH2h0nGX4jFBXb/vCK6M2MAnxbsSM+YZs2gtO
	 27FfXr5QzGUYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:45 +0100
Subject: [PATCH v3 02/42] ovl: port ovl_copy_up_flags() to cred guards
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-2-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1229; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jWaE5YKn/LlM2xmgC7PRVuH+dwbfgM8GZZeUmesP9FE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YVldLmoeS9mPjjlb7myxZc9ry7n9ewXvzG3e8vuw
 6fn8d6P7ChlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhI+RSG/w7vuy4KbWG61nKm
 YfM37b050XKXFL7FfT+W8Ojsnd3hkrIM/1O+RLx9M2/3YjmHEyUXP99XLddrsl3A7SMoZp8qW28
 WwgYA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/copy_up.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/copy_up.c b/fs/overlayfs/copy_up.c
index 604a82acd164..bb0231fc61fc 100644
--- a/fs/overlayfs/copy_up.c
+++ b/fs/overlayfs/copy_up.c
@@ -1214,7 +1214,6 @@ static int ovl_copy_up_one(struct dentry *parent, struct dentry *dentry,
 static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 {
 	int err = 0;
-	const struct cred *old_cred;
 	bool disconnected = (dentry->d_flags & DCACHE_DISCONNECTED);
 
 	/*
@@ -1234,7 +1233,6 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
 	while (!err) {
 		struct dentry *next;
 		struct dentry *parent = NULL;
@@ -1254,12 +1252,12 @@ static int ovl_copy_up_flags(struct dentry *dentry, int flags)
 			next = parent;
 		}
 
+		with_ovl_creds(dentry->d_sb)
 			err = ovl_copy_up_one(parent, next, flags);
 
 		dput(parent);
 		dput(next);
 	}
-	ovl_revert_creds(old_cred);
 
 	return err;
 }

-- 
2.47.3



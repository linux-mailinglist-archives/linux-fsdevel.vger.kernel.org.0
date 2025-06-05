Return-Path: <linux-fsdevel+bounces-50728-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A19ABACEF8D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 14:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7111B7A8B5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jun 2025 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF22221F11;
	Thu,  5 Jun 2025 12:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q82I1EKw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5091E7C1B
	for <linux-fsdevel@vger.kernel.org>; Thu,  5 Jun 2025 12:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749127864; cv=none; b=JfzZrpXKgn/Xe1ZatKmG8u0epXYzslcTv+xD2P1Dy6JO7IrcbjfglaMCRqbs39BDXw7Tf4NzwKKahGYKzhE3zaUWc+/PAjRzUxo5LxoMzJ7GjvdkWY8zcKg4bzcOSBMhSU1gjZLfeQyZeril+wGNTF+aDk2erbzAgWs717wptSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749127864; c=relaxed/simple;
	bh=jpq6lG/GVgakkKxnUt5O86lRUsa8j8pwLqI5svvf7ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mjJq+pz/HWjklTZpecsXxXo+cmzbYUfZQ+NAzg3p1fGW3N7FwcOEduBgqmdeMKNjQZZqaBPW/bEznKp20r6lIT40+xut0zQcY2WSzp2t27vUwQwuI1jywsJVkLHvr5YtA4Lcoazmfqtho0PBVqLhuI89tmGLJF3nblof0vNuCiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q82I1EKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15A91C4CEEB;
	Thu,  5 Jun 2025 12:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749127863;
	bh=jpq6lG/GVgakkKxnUt5O86lRUsa8j8pwLqI5svvf7ck=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=q82I1EKwKO8Sml+AxRFxrkl6lk28x6wUHem/wwyubOm+eotgmt9E0frGdue1wRX7R
	 PYwR20dNNiGfbYfiwZU45ZD+lHy+WgXb9P6q3bcnxzz1lH5ftr1juS92bCPWAMRUt+
	 Qv/q32oRjPVYfgOmOGxvKvDqJV2V3AggtehVB0e9OOuM48pYL2+D62e95CGjOteMiE
	 55RcAyE0TrZSdfdxNRjpTkXv85gdC53QMoUJakljb9f+v13yS/GYrnBTaDu/wJiqtS
	 oNrxhCKPIvTu/BI3QOKb/uV2owX4ZXl29gUmB6sjhtBlG4o9PtWNPLCpAu1C8Nffck
	 K//I3nvDGAU3g==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 05 Jun 2025 14:50:53 +0200
Subject: [PATCH 1/2] mount: fix detached mount regression
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250605-work-mount-regression-v1-1-60c89f4f4cf5@kernel.org>
References: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
In-Reply-To: <20250605-work-mount-regression-v1-0-60c89f4f4cf5@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, 
 Miklos Szeredi <miklos@szeredi.hu>, Jan Kara <jack@suse.cz>, 
 Christian Brauner <brauner@kernel.org>, 
 Allison Karlitskaya <lis@redhat.com>
X-Mailer: b4 0.15-dev-6f78e
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jpq6lG/GVgakkKxnUt5O86lRUsa8j8pwLqI5svvf7ck=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ4TtrcKZc93WOniut/m2+797t5yM32XJzanN3xWdv68
 pFww4OhHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPJDWNkeGnLW+bOJX24cOaT
 EkWxgwqewmEc+1c9XOWorN+x35+XiZHhB7+hkH/GlyojpZdXue7m/bJYfX7Wdz3XlmKnU5lW/zt
 YAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

When we disabled mount propagation into detached trees again this
accidently broke mounting detached mount trees onto other detached mount
trees. The mount_setattr_tests selftests fail and Allison reported it as
well. Fix the regression.

Fixes: 3b5260d12b1f ("Don't propagate mounts into detached trees")
Reported-by: Allison Karlitskaya <lis@redhat.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index 2f2e93927f46..cc08eab031db 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3634,22 +3634,22 @@ static int do_move_mount(struct path *old_path,
 	if (!(attached ? check_mnt(old) : is_anon_ns(ns)))
 		goto out;
 
-	if (is_anon_ns(ns) && ns == p->mnt_ns) {
-		/*
-		 * Ending up with two files referring to the root of the
-		 * same anonymous mount namespace would cause an error
-		 * as this would mean trying to move the same mount
-		 * twice into the mount tree which would be rejected
-		 * later. But be explicit about it right here.
-		 */
+	/*
+	 * Ending up with two files referring to the root of the
+	 * same anonymous mount namespace would cause an error
+	 * as this would mean trying to move the same mount
+	 * twice into the mount tree which would be rejected
+	 * later. But be explicit about it right here.
+	 */
+	if (is_anon_ns(ns) && ns == p->mnt_ns)
 		goto out;
-	} else if (is_anon_ns(p->mnt_ns)) {
-		/*
-		 * Don't allow moving an attached mount tree to an
-		 * anonymous mount tree.
-		 */
+
+	/*
+	 * Don't allow moving an attached mount tree to an
+	 * anonymous mount tree.
+	 */
+	if (!is_anon_ns(ns) && is_anon_ns(p->mnt_ns))
 		goto out;
-	}
 
 	if (old->mnt.mnt_flags & MNT_LOCKED)
 		goto out;

-- 
2.47.2



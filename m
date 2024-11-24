Return-Path: <linux-fsdevel+bounces-35689-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E39D72DC
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:21:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAD9316407D
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6A20B1E3;
	Sun, 24 Nov 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLHf9Ae8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51E4020ADEA;
	Sun, 24 Nov 2024 13:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455885; cv=none; b=I1ThPzTGL0jlKjDlrk4TDsLqhSotc2cRxD1rm0/fyIGZbhbXsY16FeAmUytfRLMPeQ48ki09KQeFMvqC9v7Gkce3XmFfDyWdEGBnub/f7e+u4YAVmNyvGmIJa+gX2T4HASutxRHEV20OxKGlYLymziScVZf9hAdgNG19RG/6eoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455885; c=relaxed/simple;
	bh=jZb6EkV6JzPYeldarSe+SomjASuUO2RJ9OILfv+gDsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EWpp344so9Wnxd5SN8sdI3xgslz3sn+Jf9uuM8rb6FfRBcfUSMxhoq0VyTwcYuOmW+lsd7HfC4W47Z+P9SBucNqpZ48WVUWyU/UqTLoMmt83nJCbswygEVffHUL3izdGyNEXTr6V5zoDjJM8axPlIWhLPhMVbFY/GFO+I42lhVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLHf9Ae8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 724F8C4CED7;
	Sun, 24 Nov 2024 13:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455885;
	bh=jZb6EkV6JzPYeldarSe+SomjASuUO2RJ9OILfv+gDsc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PLHf9Ae8ir64GAIiy6SV/w3+6Bg7JVc69rU4bX7pjYc6c0Oby3miLFkgvR+81mgNj
	 XDyi453KUksGztHc+DzYy+6vtp3cwLa3nxTpaL8UaK7BSYGu0XoeOC0uK4PozqYtDo
	 8SmP3eazdAd7ETB+grOqqSt5trpJS3xMVH00gjGJC28d/lcy+xHsCz6oATvqDTwquQ
	 LS3gCbgNGY+rs4FD9EyB+VGauNgs2Ve9z4roG0XB9jiDXR/hu3uU+SHOw2ntaeopTP
	 lGE4/KZAASJaIEezGDHLgI1RlhKCqw0QXBS3Zaxq7XYaPxbxAnaFgXsVAgOnHl0DfX
	 P+sGKQQsrq0Jg==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 14/26] nfs/nfs4idmap: avoid pointless reference count bump
Date: Sun, 24 Nov 2024 14:44:00 +0100
Message-ID: <20241124-work-cred-v1-14-f352241c3970@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
References: <20241124-work-cred-v1-0-f352241c3970@kernel.org>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=853; i=brauner@kernel.org; h=from:subject:message-id; bh=jZb6EkV6JzPYeldarSe+SomjASuUO2RJ9OILfv+gDsc=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7685rrFGTe/F3pU7M4eUbM34X1DoJTrLZvXRC7krlB YHvHqr1dJSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExknTIjw2kZr4ebb8hP2M1V 75hzVeTfhpzC+0tW+eVfVMhaXLWU7SUjwzLB9ufT/r7ZlsG8M5C32Gxr674svwmslZZvt3A/rNl 6mgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/nfs/nfs4idmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/nfs4idmap.c b/fs/nfs/nfs4idmap.c
index 25b6a8920a6545d43f437f2f0330ccc35380ccc3..25a7c771cfd89f3e6d494f26a78212d3d619c135 100644
--- a/fs/nfs/nfs4idmap.c
+++ b/fs/nfs/nfs4idmap.c
@@ -311,9 +311,9 @@ static ssize_t nfs_idmap_get_key(const char *name, size_t namelen,
 	const struct user_key_payload *payload;
 	ssize_t ret;
 
-	saved_cred = override_creds(get_new_cred(id_resolver_cache));
+	saved_cred = override_creds(id_resolver_cache);
 	rkey = nfs_idmap_request_key(name, namelen, type, idmap);
-	put_cred(revert_creds(saved_cred));
+	revert_creds(saved_cred);
 
 	if (IS_ERR(rkey)) {
 		ret = PTR_ERR(rkey);

-- 
2.45.2



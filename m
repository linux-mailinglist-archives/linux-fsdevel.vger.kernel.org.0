Return-Path: <linux-fsdevel+bounces-35684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41EDD9D7631
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 17:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A24E5B2E06B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB01209F26;
	Sun, 24 Nov 2024 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEadPYHz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D93A4209695;
	Sun, 24 Nov 2024 13:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455874; cv=none; b=uQMldah1ui+UsKnmzncx+wwU2wXFZ4P9Tbdt9iesHz1QYk4y+ANdaSeSlqSFnkfpNkHlk2bjCUWfkHw1k+H88DXdQnXnNrZE+U3h9Wr+hiWUMaJrQfD/ZHExPFDfyGUuJOANx6DdCTdyxW0nrG8o8GHuPTLHSq1TCO65gb+dVkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455874; c=relaxed/simple;
	bh=C/wR2ku2PTKFCMQ8eQB1+MnF9WOeryw7aC1vMHma/eU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ecy7HUEYWNLQjkf+quQ3Fo3esuUBTBS5uZroj80DaDI0JI36ms4UzJkIdw8ix3j5Hc9HkULmgWovVNxhIiHwhLM14KBJUwLfVl/5Cj5yL2v2K/JsHxZhNKEs4l3LPHc6NK0viaTYi5DEDdCUDGX7uWtohBtBrJNGFzopUn1OJJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEadPYHz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0AEC4CECC;
	Sun, 24 Nov 2024 13:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455874;
	bh=C/wR2ku2PTKFCMQ8eQB1+MnF9WOeryw7aC1vMHma/eU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEadPYHzer9PRgNVdigPvPMS0fTvjyx8CK7vhZ5lAJ7k/yzIQ6tzvVpj9MACtNsOB
	 YGHlgR8c1lTLSFK1HKKHy7fO6oXUE95eNdHPvHokNDM1PfcuS4wBYNAw5mB6tRyhAo
	 zs6hg4moTnhh+FOgBr+BfwqCHNInJWAEOsXTirdyK9aXoWHPhHdwo7J52EdTPNOIhx
	 Jx46YoYYsKF8qO3qbado55lbFyQ7yg93ytDORD4vDF2fgFI5n2SggyCm00FTbI+7XM
	 9UxqHQ52psuhXJcuravjF9Mp0Xo5VhKRqhAxcxnfUYuyyb3FvaSNV4GWfPLWLvmgV7
	 pVdrOVrYnd5cA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 09/26] target_core_configfs: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:43:55 +0100
Message-ID: <20241124-work-cred-v1-9-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=857; i=brauner@kernel.org; h=from:subject:message-id; bh=C/wR2ku2PTKFCMQ8eQB1+MnF9WOeryw7aC1vMHma/eU=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ7685eacK0T/CCq6aZQvQFkZfO/j8PnZZ7N32PYMNDO 8H/pv/zO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSsZjhn3XHx/sfGC+JL3oZ e3HT2v08lQulRfZfvs/7/V7vv6vOPfcYGS40PhIsXM3xdvdjg3d1u83PuG/LWX5krvUT/hvfZx1 kYeIBAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

The creds are allocated via prepare_kernel_cred() which has already
taken a reference.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/target/target_core_configfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/target/target_core_configfs.c b/drivers/target/target_core_configfs.c
index ec7a5598719397da5cadfed12a05ca8eb81e46a9..d102ab79c56dd7977465f7455749e6e7a2c9fba1 100644
--- a/drivers/target/target_core_configfs.c
+++ b/drivers/target/target_core_configfs.c
@@ -3756,10 +3756,9 @@ static int __init target_core_init_configfs(void)
 		ret = -ENOMEM;
 		goto out;
 	}
-	old_cred = override_creds(get_new_cred(kern_cred));
+	old_cred = override_creds(kern_cred);
 	target_init_dbroot();
 	put_cred(revert_creds(old_cred));
-	put_cred(kern_cred);
 
 	return 0;
 

-- 
2.45.2



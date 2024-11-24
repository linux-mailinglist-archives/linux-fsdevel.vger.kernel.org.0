Return-Path: <linux-fsdevel+bounces-35699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD699D72FD
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 15:25:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F8D328512B
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Nov 2024 14:25:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA69120E33B;
	Sun, 24 Nov 2024 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bm6QdHNo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2738920D514;
	Sun, 24 Nov 2024 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732455906; cv=none; b=NHopUElRCp9kjNlvbbN4aHH+oXxzqIyisvIwN6EpBfpbUuJMsUXNy8TEKPFM7iv5iKVClZ/YsK8wx45UJdU5kAMPMjEgq0x/S3JDfI9S5+5ult1WFewuZZ8zhHsgEs8Qs+OD/7u83iKMb+rIbk36oWu4H4UkXrTrEX+5Tbp518g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732455906; c=relaxed/simple;
	bh=wcnUSwtChL+VJdcCKPWSyAxsaM/o7Qx5RaqxsWjwVKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Sq/UF5FCWkfXU8TeX8911D2YGvwe+msFdxilGUysLE9f6L0inoXsFbFx9wAou7CLidLdOBUuAIXAzngzWcmToupr6Rb8QDHgixtfxC5DCyOjFjohPwU5VROzUVRjrYe0v3cXN9WMUtyIwZ/dps0C41vxZNBh+Wae03iQBkjXnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bm6QdHNo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FCB1C4CED1;
	Sun, 24 Nov 2024 13:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732455905;
	bh=wcnUSwtChL+VJdcCKPWSyAxsaM/o7Qx5RaqxsWjwVKA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bm6QdHNoI4FGfmvNhn7WOM2k7vrZ0svCm+G+lPxSsLj4MlWSCaNZYSit4mL0mPriQ
	 4/2QVRzJxGjpML2qPcUx7c18zBAWd0V+uWEV2whaVIjWmk6tRqhH7UOMUbynRzIbqI
	 lIqzge8/YjwoWxo3IPLSKly0DHTAYfAbB0N/cTh/nHV2cu3MXizwqFl+O7GCTCOA1G
	 uDOMwWZPdL6rWINZiUAfHXbuJrteiHRhNtbq9hmDdYQCj/UjI5csA9CRYnycjjRTFo
	 RodCDZAIHiTpwIa1aw9Ryi/hyI6/oRY6EDRkLoqQZ9hYfQt2u6U25A8HjITqDVA8FZ
	 yiY1sn6coRDkw==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	Amir Goldstein <amir73il@gmail.com>,
	Miklos Szeredi <miklos@szeredi.hu>,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Subject: [PATCH 24/26] cgroup: avoid pointless cred reference count bump
Date: Sun, 24 Nov 2024 14:44:10 +0100
Message-ID: <20241124-work-cred-v1-24-f352241c3970@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=978; i=brauner@kernel.org; h=from:subject:message-id; bh=wcnUSwtChL+VJdcCKPWSyAxsaM/o7Qx5RaqxsWjwVKA=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaQ76y560DbfetrpF/c2OH7pahcpa1H7lNdQJ/3zRti+J k7rZ5oMHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPRsGBkaL3EY/NB0OztZ6EX rRlWvh3f/VdLPXTlXPfhRMWmStvkyYwMDa9O6rkLauVp2QtXLK8QZY2aoLfowdkF89rWPWKxrEx lBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

No need for the extra reference count bump.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 kernel/cgroup/cgroup.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 1a94e8b154beeed45d69056917f3dd9fc6d950fa..d9061bd55436b502e065b477a903ed682d722c2e 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -5216,11 +5216,11 @@ static ssize_t __cgroup_procs_write(struct kernfs_open_file *of, char *buf,
 	 * permissions using the credentials from file open to protect against
 	 * inherited fd attacks.
 	 */
-	saved_cred = override_creds(get_new_cred(of->file->f_cred));
+	saved_cred = override_creds(of->file->f_cred);
 	ret = cgroup_attach_permissions(src_cgrp, dst_cgrp,
 					of->file->f_path.dentry->d_sb,
 					threadgroup, ctx->ns);
-	put_cred(revert_creds(saved_cred));
+	revert_creds(saved_cred);
 	if (ret)
 		goto out_finish;
 

-- 
2.45.2



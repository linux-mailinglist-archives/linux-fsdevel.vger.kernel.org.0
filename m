Return-Path: <linux-fsdevel+bounces-35821-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8307A9D8886
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19F4DB60805
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784F01D362B;
	Mon, 25 Nov 2024 14:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qyCEkHS9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E1D1D318F;
	Mon, 25 Nov 2024 14:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543875; cv=none; b=PmjrEuiGJ6RgFYIY5gpPbNEZaBBDTIN2ROETV+It5Sy8WeMhfRzdPmo3iXIr2rrmJAKs9+k4f8CJTvXHGfnThgHZdyo25Pi+msAaTUmnEQsxLxfvkEw+MVONPgggNjXWTzRcmzs1oRpX/c84ll1tAr573xICBVZoLj/d3sLsdNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543875; c=relaxed/simple;
	bh=ARuoMeAmm6v0ZYv+MQ725lBpeEcaXVmaaIcqkE8icBE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AFJeCfCnQ5rNrmWt2HaXXBWkwbTcxeg2qXS885H0kgE0cmmhX/ghoWWjoR/CgZ73JtFhovaIMN1eXdmTZdiqj6DPVh4RvLqsHmrwVt/jUvWykaywV5/RPEhK5JLZt8ctku4An5cArXqnOwObyzqBUreMf+3nGDkWPWrcLHWsOF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qyCEkHS9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C752C4CECF;
	Mon, 25 Nov 2024 14:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543875;
	bh=ARuoMeAmm6v0ZYv+MQ725lBpeEcaXVmaaIcqkE8icBE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qyCEkHS98Q7Yh/sZsW2v3EXBsjIVWHrvopYAS9dTxyee+uu+nCIloY62eTWN2Ya8J
	 eEx4TukhlZhpP0eHo2zGgwIpYBHHtCw/DBV9dcTPGFqUkZiv6qKWASStXAUVnLtuWx
	 ZVB2ANP+Zj30UIi6fza+Uar4Q2s0F3nZEtAaaGmG2gpEhmUeCXpFYS5wAPCjnlPx0P
	 c2zWIskWCpTmMupExShHNx+uMsxxKOhb0cszYwlouASg1K0sPhROpucTw8ejZ4oEL5
	 7ghOId/xVE2NlWgDuHMrIT1LpYxNWp8GqlxftDEEOg6pE/u9+CZOeXZsX27xeBBZzZ
	 Vn/MmT2B4ICWA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:20 +0100
Subject: [PATCH v2 24/29] cgroup: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-24-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1021; i=brauner@kernel.org;
 h=from:subject:message-id; bh=ARuoMeAmm6v0ZYv+MQ725lBpeEcaXVmaaIcqkE8icBE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHoJhuYf1n9yu1nn7NeLMguyNeacXO2Uz3jqQEulf
 K/d7qatHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABORLmP4Z8XXs+aji2DI+VvR
 Rl0fV6RO9r264sytbpHNiXqH70ge+c7wP/Lg1teldn1C/5WX/e1cWjm5Y6PVfcFezaqy4vQ9Zie
 YOAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

of->file->f_cred already holds a reference count that is stable during
the operation.

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



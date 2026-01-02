Return-Path: <linux-fsdevel+bounces-72322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AA4CEEC60
	for <lists+linux-fsdevel@lfdr.de>; Fri, 02 Jan 2026 15:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3071830285ED
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Jan 2026 14:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793B1CEADB;
	Fri,  2 Jan 2026 14:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JU5jsHCk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E19C1C28E;
	Fri,  2 Jan 2026 14:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767364594; cv=none; b=i5bN6zZ72bs+yt/6abllPl3xGNyThUUG/YISiKPGglFjlBcTW8OrfYTfLJz2MGPCtbNS54ORdKYaqOL1zXSFuj/9wlEVaVLJvmZ1Z9Nqjgj85RZdg1kwIiCdi0GDr7y8vaMNnIc5E2G+GEZmSlPvr5bkVOE+OZguisC314fsgzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767364594; c=relaxed/simple;
	bh=BRJskyW4bSDrzfRFjFr9KkoMVvsZwgfeOOmGrr6KHTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q+sE3aXI6zvrX7iGZX6UbOBu+848hYQT7TfwfsQwW5jNsXyd87jHrnRqY3NGKlQR3MtEur11h0Hz8hK8s3fpX8qHGshDbsEZKeuiX2mhTX1H2t+ZiYGhj1r+K/AZKze9STo/C2glzJNVe2Kjy7ckA8gJ/ET7Pl833Y/0GZLbgDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JU5jsHCk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4C45C19421;
	Fri,  2 Jan 2026 14:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767364593;
	bh=BRJskyW4bSDrzfRFjFr9KkoMVvsZwgfeOOmGrr6KHTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=JU5jsHCkVp8FqZGwJmv7shCiN/sOMY0sdPxMVjEhCGwd8E6f9ov1bQD9sogGu90mU
	 VsFv+nHy/E7fopyrSrMzexyj9Uvbz25OPIjtB13bP04AoP566H2uLeYCBVSZsvdy0O
	 MN0HHWQJ/NVuE4Knq2/pSHU26ggY9Utlyf3vWh1oB9dFyAHvBfeJCrX822PR3ruRzu
	 4PvRbDylvkH2oeLAGXHBcBx/V5K4Givoy/Mg43oUQXWrlXCF3PtoT++t+JmhetmXXI
	 7eMUMZybDuV3lFigZbuNdfL6WtKnSsNlZuuHzYwpSy3kWu30QXJZLKcBs0rFpacbxq
	 4BDzP5MAMAiAw==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 02 Jan 2026 15:36:22 +0100
Subject: [PATCH 1/3] fs: ensure that internal tmpfs mount gets mount id
 zero
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260102-work-immutable-rootfs-v1-1-f2073b2d1602@kernel.org>
References: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
In-Reply-To: <20260102-work-immutable-rootfs-v1-0-f2073b2d1602@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Jeff Layton <jlayton@kernel.org>, Amir Goldstein <amir73il@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Josef Bacik <josef@toxicpanda.com>, Christian Brauner <brauner@kernel.org>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=919; i=brauner@kernel.org;
 h=from:subject:message-id; bh=BRJskyW4bSDrzfRFjFr9KkoMVvsZwgfeOOmGrr6KHTU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSGX3/zqkE9eZ2xzJc5Yh+WzM9KuVPzWfvBY5N15bxKw
 bb/ZB/O6yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIjC8Mf7jZa67dMTxs/JfF
 tC7/le9p3VO/oktZ1lwU/hJla+w28RDDfy8/33vNl2cd1tfN/qLC4N58wEyY/feEtay5THMEXuh
 EswMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

and the rootfs get mount id one as it always has. Before we actually
mount the rootfs we create an internal tmpfs mount which has mount id
zero but is never exposed anywhere. Continue that "tradition".

Fixes: 7f9bfafc5f49 ("fs: use xarray for old mount id")
Cc: <stable@vger.kernel.org>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index c58674a20cad..8b082b1de7f3 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -221,7 +221,7 @@ static int mnt_alloc_id(struct mount *mnt)
 	int res;
 
 	xa_lock(&mnt_id_xa);
-	res = __xa_alloc(&mnt_id_xa, &mnt->mnt_id, mnt, XA_LIMIT(1, INT_MAX), GFP_KERNEL);
+	res = __xa_alloc(&mnt_id_xa, &mnt->mnt_id, mnt, xa_limit_31b, GFP_KERNEL);
 	if (!res)
 		mnt->mnt_id_unique = ++mnt_id_ctr;
 	xa_unlock(&mnt_id_xa);

-- 
2.47.3



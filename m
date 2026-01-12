Return-Path: <linux-fsdevel+bounces-73269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DC85BD13CDD
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 16:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CEDA300A34E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jan 2026 15:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3C8363C42;
	Mon, 12 Jan 2026 15:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G+MCZLid"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF0C315776;
	Mon, 12 Jan 2026 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232842; cv=none; b=pAkEIrFySyrmywfhHvXiXrkkRARKE4VAURSK2yPTW2rk9V4ay/yevd8yw9vgq/VwBxoIob91IhLq9HmlXJjwDUE4H7YThSjpys8LggoMoETElaQAKGtETxI5BKSaVJ1RravYWjukq/haAu9sJ00RhkGM/xUBHosIJ0mGjzMqwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232842; c=relaxed/simple;
	bh=BRJskyW4bSDrzfRFjFr9KkoMVvsZwgfeOOmGrr6KHTU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Cjv90H1PJWQCcX9c+8GXQ9JQSTtfcmL+1oHk1Pj46ZzrHQwR37xNsq0jOYGNj+l5oWu97fbrnVpZS6CAUYAdFW9XP6TeRu0AElawSrlNhyBRlYZLiJQl3cPHrdQTd01e6iLP2USmm3uSpL/03yOC1Il919QNzvqGQbEBXTotPGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G+MCZLid; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45AC4C16AAE;
	Mon, 12 Jan 2026 15:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768232842;
	bh=BRJskyW4bSDrzfRFjFr9KkoMVvsZwgfeOOmGrr6KHTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G+MCZLidHa+OoXzBnq7DHsg4dhVAUyFFeULqtNhKRA89KIYEDfdtdOYUDR9ck06Le
	 W9pGESv1wNFJLHjJLWH/cVy6IaWLQp2wrWOY8+9UUWMHeX71LsAxZyJyKayj12w2ia
	 DLyUn9fp6zPZaN5mdthZtFrB7kcxTzbqimZudPwgIsbShybICI/z30Jb5BjEjDTzlq
	 so75zNZ5aYn4+H/X7qUV5xVaL228zeIH9hY50mBaBplp3Tnxe6U2mHkRgQtIS4WeU9
	 xH8rGmCi0KkiZ6ouXW1cijrCtT54QV2lNDQ9tfJ0aSM6R/cdlwj/4cdlkP2pYbqQoZ
	 hwr5bCqrDxQCA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 12 Jan 2026 16:47:08 +0100
Subject: [PATCH v2 1/4] fs: ensure that internal tmpfs mount gets mount id
 zero
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-work-immutable-rootfs-v2-1-88dd1c34a204@kernel.org>
References: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
In-Reply-To: <20260112-work-immutable-rootfs-v2-0-88dd1c34a204@kernel.org>
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
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSmireyGPUzuRVM+uppWW8km9+z6dvnwlCjTca7QvMmL
 NALXXSzo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJpPgz/k0rvZq95v1q7yVpe
 oYTP9b/xh7XCLoZnl0mkaO48d9dyDcM/paO8J++6McZf3CqyaRMju6G233nvXfN9pTjChTjun1d
 kBQA=
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



Return-Path: <linux-fsdevel+bounces-35811-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1789D8786
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:14:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91B128A623
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1551BE223;
	Mon, 25 Nov 2024 14:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pGtm1XrA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA551BD9EA;
	Mon, 25 Nov 2024 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543853; cv=none; b=rU0/fHFtAB3CD/GNL7vRVx4X0/ZL3QmTao86joBigTtZiM/ulmoLSmpg0EZF4M/d0e0x2/omT8/ye9PAaI2VTINNxQULEGtsUa6tEHGRu2lQMNJx5394iJu8GZ+Zzs6qD2x/VHVBIP9DsfhXxL8aNheRB5T+KkDTi4LmlFhUwrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543853; c=relaxed/simple;
	bh=4cgA6IsAxTTKPHviIv93Rrt2GwxVewQqHJ5F0vhgT3c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aBiWPaabBTJCoHVX/18KmUs354vGMlitZJ66HgJKt9TuWpv5XiRwL3uN16xs0o2soPIrUkFsTOcFCSdFdMKw5wSvMCVE7yn8du+NWVPEdmp+wIqqPY3p9CZix3jgokZXUguuTOrQ7Nxbxf1bS+EHuiPfFzXEFHpDcPceM8Whfos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pGtm1XrA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8140DC4CECF;
	Mon, 25 Nov 2024 14:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543853;
	bh=4cgA6IsAxTTKPHviIv93Rrt2GwxVewQqHJ5F0vhgT3c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pGtm1XrAqMA1s9l3u8B5Xx8tjIRF70GOg6KxdZFhEEd0cH/DzO+MEjSXuMUbnjo2I
	 NWKS+DVwPUM2gYq3Qyd4x9JoeWqJB53rV+4QSwK11OEKkr6nY++oaQuvcWQm3tlIkN
	 RtgrQlejyvEosfQaVYZGylpzoclrXpyNgejSn09zCyljC8TJHmQxqbXA3w+amkxB2g
	 VGCGrq6slIy109q3auMXnFb4KELwkUwSPMEDwdiV2ibkR/ZgsyWnKfCB7q0VOw/YzK
	 GPsthsJ1evnm/ODQfsuD0+gR0/TptbaEpFstkxkv45Gin/H2ZWT5dtt/sYjpzR8sB1
	 aZAdCNK6tpnTQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:10 +0100
Subject: [PATCH v2 14/29] nfs/nfs4idmap: avoid pointless reference count
 bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-14-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4cgA6IsAxTTKPHviIv93Rrt2GwxVewQqHJ5F0vhgT3c=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHpavfpWKsd7oFvi3MTIY8kPmj/ec0luOV76zoBtf
 brzGh79jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkw3GBkOHz1IJPDwylXWNde
 nXRurcU6Ph3jtYJftqi9vvbuz49jB98wMhydtS3D+9dnmfYNwauZUndNPZb8wtvt1bE996WkHtx
 7IMsMAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The override creds are allocated with a long-term refernce when the
id_resolver is initialized via prepare_kernel_creds() that is put when
the id_resolver is destroyed.

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



Return-Path: <linux-fsdevel+bounces-35818-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF079D8793
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:16:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2A2128937D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688D71CEE93;
	Mon, 25 Nov 2024 14:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="amJa9TfN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7AA71B219E;
	Mon, 25 Nov 2024 14:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543869; cv=none; b=aueCHPsesANFRpDXXR28ZkKzEExrBD/CxS892YKl1CZblPcPwR0RyrSmC6ZII+TeNFvi4V0uA2eFV/0c52HVpf6pja8stR+/wqXPaB0Xa3dgv9rdwXx63kV6ANM4PfdEp/BpQ1gvazBBSeC61pCFf2mjJbPFqqTG5+rSxPXoMWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543869; c=relaxed/simple;
	bh=tl3xTNTeCJlrMJ7X8WfjBZE5bw28ffpb8r5WQgJyUZA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f3F55ZXHGqLAdaE55BG7VguMiE/t7fHqtQv6KbE/1TmYN0r+T93fq3WJWxG236jp+Sae2XHLinyK1/V1yuJZqBMHUFpbLcuPmf+/3GVXw17NZubbKaCeVz4Vp8fUNSK0wAuMwDl6To9MPnSyn808OsO6XNFxDtA+yqYaCwM14Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=amJa9TfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1ECC4CED2;
	Mon, 25 Nov 2024 14:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543869;
	bh=tl3xTNTeCJlrMJ7X8WfjBZE5bw28ffpb8r5WQgJyUZA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=amJa9TfNA3ezGrW+bkaFm3U2lH95ENXj5cKB/bfew2xbOAZkpezXFDuB1BIeqEAGh
	 GPCCRqhKnqQ42O02M9Hxy6EGY98B5dnCE5ezzl/A0ihBW34p6VNy+uG+KWa5fWvHJx
	 Glo7UTtI+uTF/n9t+qNrthhL2TVgeNfgaxFBSqJH5PQvwuF5f9yVdZMcrHkeSp+J96
	 NYVawTU71RXBzUYdgJ63dQRYi0J6IpHTR3ijslb2lHQQFLuGMx9EMrGzJQ3kY/auSs
	 GKkKkjybYi4GM6w62nWr7Hd7AO+iGT8E3CZ1FcGvrpYrASOb6yhX9buYjeOfDMAWKQ
	 nJdKKsQwJc4Mg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:17 +0100
Subject: [PATCH v2 21/29] smb: avoid pointless cred reference count bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-21-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tl3xTNTeCJlrMJ7X8WfjBZE5bw28ffpb8r5WQgJyUZA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHoduejcVKl57M2xoHUbsgRjJ3pEmPy1+vW79vqkc
 unotMq3HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOxeMXIsKgxTWHW4kUzaqdM
 e/BjebDrpD+r+ZOfsmhwFQROanQ6v56R4doGk1gd3f0cy3Zvc3KV78mp9D4cm32b91bWWZnbnP0
 TGAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The creds are allocated via prepare_kernel_cred() which has already
taken a reference.

This also removes a pointless check that gives the impression that
override_creds() can ever be called on a task with current->cred NULL.
That's not possible afaict. Remove the check to not imply that there can
be a dangling pointer in current->cred.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/smb/server/smb_common.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index f1d770a214c8b2c7d7dd4083ef57c7130bbce52c..a92e3081cead250dac89a0dc00fcee8444465b8a 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -780,11 +780,7 @@ int __ksmbd_override_fsids(struct ksmbd_work *work,
 		cred->cap_effective = cap_drop_fs_set(cred->cap_effective);
 
 	WARN_ON(work->saved_cred);
-	work->saved_cred = override_creds(get_new_cred(cred));
-	if (!work->saved_cred) {
-		abort_creds(cred);
-		return -EINVAL;
-	}
+	work->saved_cred = override_creds(cred);
 	return 0;
 }
 
@@ -796,13 +792,11 @@ int ksmbd_override_fsids(struct ksmbd_work *work)
 void ksmbd_revert_fsids(struct ksmbd_work *work)
 {
 	const struct cred *cred;
-
 	WARN_ON(!work->saved_cred);
 
-	cred = current_cred();
-	put_cred(revert_creds(work->saved_cred));
-	put_cred(cred);
+	cred = revert_creds(work->saved_cred);
 	work->saved_cred = NULL;
+	put_cred(cred);
 }
 
 __le32 smb_map_generic_desired_access(__le32 daccess)

-- 
2.45.2



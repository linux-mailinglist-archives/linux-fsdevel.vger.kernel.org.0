Return-Path: <linux-fsdevel+bounces-35805-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6DE59D8779
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 15:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB992162490
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2024 14:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43031B6CE0;
	Mon, 25 Nov 2024 14:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9NF1VKG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CBB1B4F17;
	Mon, 25 Nov 2024 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732543840; cv=none; b=rtpiQ/f7zWzXTrIWxltP6D7qDsYlKdbrAkJzY1C7jdp9pc5hm+iVUpM1nUFm8TSHhO+aMLzKtHeftdBHrQ7Z4qrJuAAxIeywXrQGmHibMAsBGaH36Yu/AyRZ7HItOBboj9GJFsN4LN0hW3u5dccJUU1mDYhrUZPybPvMaZKGMxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732543840; c=relaxed/simple;
	bh=JyuYZyB4OGl5WxMFcCkQWT6w+5cVFX8MiGQmbuR3Uto=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QcXhbC7t8uUDxOE41M8owLfMJHgd0Dh6Cp43rGa2pz9MPnSh7ykzvn60rfrUfspiy8FPQhjwwpY4nZYox7FvE0gPUWUWwuXsQxprYrUmLULsxuotODv5JmnQvRTRHL3xr34gCNHyp5jA+X2JDru+Fjhf+Bavz4ZV676vnVFFleU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9NF1VKG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0806C4CED2;
	Mon, 25 Nov 2024 14:10:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732543839;
	bh=JyuYZyB4OGl5WxMFcCkQWT6w+5cVFX8MiGQmbuR3Uto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=p9NF1VKGQ7nIYyme8SpWwgcQ8pAtlobFiheI/USIYwQydfo6EgfB3eY4wNh9mwn1G
	 06hkUKBGCpjDZZyYPm8G6A79El2FUgY4DIqruIqc3M4lfRJL0zA/ri7Ti7bJv+BlmJ
	 te4PFcJzhpjVZWJS7GGzuaAuCWXnwyadZ6rMrylSw8rNlCZXVJvUAn64bwp43XMGnI
	 vIeb/Ow+joYhFO0cZwwcalllGxvMeIk2+MJPF9mUWYTkFOCE05s2rg1D26DmLLf5QT
	 8bUpEBdj2ucJU0GuUXEPksc1oGsbx5JcEWIOppBZ1sxFHSYZuJVMMSfgiA79Jcm6Fs
	 6ecXf/LSxnMQQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 25 Nov 2024 15:10:04 +0100
Subject: [PATCH v2 08/29] sev-dev: avoid pointless cred reference count
 bump
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-work-cred-v2-8-68b9d38bb5b2@kernel.org>
References: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
In-Reply-To: <20241125-work-cred-v2-0-68b9d38bb5b2@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Miklos Szeredi <miklos@szeredi.hu>, 
 Al Viro <viro@zeniv.linux.org.uk>, Jens Axboe <axboe@kernel.dk>, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-355e8
X-Developer-Signature: v=1; a=openpgp-sha256; l=980; i=brauner@kernel.org;
 h=from:subject:message-id; bh=JyuYZyB4OGl5WxMFcCkQWT6w+5cVFX8MiGQmbuR3Uto=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaS7tHoYedVklF49+HT3b1MnCf2YM0ui+2tvf5G+u/bA0
 klTd+Sc7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIBAZGhslny+6/F+a+HP7X
 N+3YlWStAwd+anp6p+zLuLbuwLr4diWG/+6xrLxLma1OVZw/uuDajKxmgQPaGqKzY8ov9/FwTv7
 xlh8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

and fix a memory leak while at it. The new creds are created via
prepare_creds() and then reverted via put_cred(revert_creds()). The
additional reference count bump from override_creds() wasn't even taken
into account before.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 drivers/crypto/ccp/sev-dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/ccp/sev-dev.c b/drivers/crypto/ccp/sev-dev.c
index 187c34b02442dd50640f88713bc5f6f88a1990f4..2e87ca0e292a1c1706a8e878285159b481b68a6f 100644
--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -244,7 +244,7 @@ static struct file *open_file_as_root(const char *filename, int flags, umode_t m
 	if (!cred)
 		return ERR_PTR(-ENOMEM);
 	cred->fsuid = GLOBAL_ROOT_UID;
-	old_cred = override_creds(get_new_cred(cred));
+	old_cred = override_creds(cred);
 
 	fp = file_open_root(&root, filename, flags, mode);
 	path_put(&root);

-- 
2.45.2



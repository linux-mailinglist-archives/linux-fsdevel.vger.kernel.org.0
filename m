Return-Path: <linux-fsdevel+bounces-68684-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E365CC63524
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:47:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44896381944
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AE9328B4D;
	Mon, 17 Nov 2025 09:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPUOKT1f"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADBAB328262;
	Mon, 17 Nov 2025 09:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372098; cv=none; b=Yl4roiB7AafmmmWLTftSHk5zh63X+pIpIcToD5ewMb17LvHIlNMdeNPNjl3x92TnJmp8h81mma/OvmdaUs5Xbumw/5ze/R5wGn8raZTGvHzzcXbsvnRojXrJ+4Cz28MdGPg9WdC3ugI8MzL7TyMvk8IDDZr3YpxVE5NI7VAt0mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372098; c=relaxed/simple;
	bh=4ViGONZA18LPah3ntvkWt+hXmAFdyvqaR0vIurrBrcc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JAmIhTXlyXyicv1qfCl6iMdz2Lmdjdf+NmaNcaEbYcYmIvtc0TJJTKh6BVXhu8DNysqjhDiRUjoKYBwI52yyLlMk9UxjktRqeLlNnqBJhkqjcONnIb4azFtn+BZ2eaWYjSPIf99ypeQzQcIcWX8yGgaU6ddI/1koZ3OAo7UDEcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPUOKT1f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE9B7C113D0;
	Mon, 17 Nov 2025 09:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372098;
	bh=4ViGONZA18LPah3ntvkWt+hXmAFdyvqaR0vIurrBrcc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hPUOKT1ftJHpwNrW3mSXL4v0SMFY9wjgine95i8Kx7Elj+RVBbckvo6RIiIzmHkqx
	 A6kmWfBmZ8oc9hjHD7cvunY8urB55CHfpSU5SPv6pq/8SB7hHi/JyZJeZAxqlR4YvI
	 evROD8j7sN5Bvc7U0KoQbDm7S5HslXU9NQ+E3sZvY8hIUqHfHEBJAiVI8ubaPwW+rb
	 kwA9GSuicZoJkyD7/iV7N0Q4NS0o6HlJOhcWgDK4ANfEHUVgNUk1XY1oZHW+vWwIkU
	 P4tD9ydbAHy1o4aovzPifxEO2Wyw0s7rdyNqk5DQEWxQsS+mFDNWebPMIQLIxlXnbS
	 p9O+e7mBNoIaA==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:12 +0100
Subject: [PATCH v4 41/42] ovl: port ovl_fill_super() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-41-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1272; i=brauner@kernel.org;
 h=from:subject:message-id; bh=4ViGONZA18LPah3ntvkWt+hXmAFdyvqaR0vIurrBrcc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf6+d9uGvbmZLtdnlysVh7QU9LSZxfKtyzq62GjNn
 oWSP7/M7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIHV6G//6uoQyhauLVBU/E
 Hn98/3Gt+cqOqmPfK6bz/+t7n16lzc7wV37CqbbmjT/SmW6vWqd88disy3tWCbpesp/CeIxr/rG
 VlawA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/super.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/fs/overlayfs/super.c b/fs/overlayfs/super.c
index e3781fccaef8..3b9b9b569e5c 100644
--- a/fs/overlayfs/super.c
+++ b/fs/overlayfs/super.c
@@ -1545,8 +1545,6 @@ static int do_ovl_fill_super(struct fs_context *fc, struct super_block *sb)
 int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 {
 	struct ovl_fs *ofs = sb->s_fs_info;
-	const struct cred *old_cred = NULL;
-	struct cred *cred;
 	int err;
 
 	err = -EIO;
@@ -1555,20 +1553,16 @@ int ovl_fill_super(struct super_block *sb, struct fs_context *fc)
 
 	ovl_set_d_op(sb);
 
+	if (!ofs->creator_cred) {
 		err = -ENOMEM;
+		ofs->creator_cred = prepare_creds();
 		if (!ofs->creator_cred)
-		ofs->creator_cred = cred = prepare_creds();
-	else
-		cred = (struct cred *)ofs->creator_cred;
-	if (!cred)
 			goto out_err;
+	}
 
-	old_cred = ovl_override_creds(sb);
-
+	with_ovl_creds(sb)
 		err = do_ovl_fill_super(fc, sb);
 
-	ovl_revert_creds(old_cred);
-
 out_err:
 	if (err) {
 		ovl_free_fs(ofs);

-- 
2.47.3



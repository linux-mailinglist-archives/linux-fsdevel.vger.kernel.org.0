Return-Path: <linux-fsdevel+bounces-68250-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B394C57911
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 13C6F353700
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B715D35503F;
	Thu, 13 Nov 2025 13:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ktF3SLbz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207EB35293B;
	Thu, 13 Nov 2025 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039011; cv=none; b=lo9TvXfm2o9z7lRCtElheAng0fgmVw9C3IZOECqAB1qFgmjF/x+SC+EfckdCfRXH2rVCD6KL7NDz80cxXHmVIzxj0FfKMCiVh1YmnNVEGgeMKShmE6oEaOu9XgmxppXRgSvwb0JRHN3/CF8k/kH9KhEjs4NaKuJzcRahF272CsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039011; c=relaxed/simple;
	bh=QCIjx7RLAaEAHWXg/eTxYNQswMmNNkRk7sB3QkTa88o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Aa+vqO1XFxPQUcqy9gNbsQoVl/k+D7QmFblnDGJLZaGHvP44z0sEP1fyCzuugugYMvqYmmwISMe+VdB2VC9q2MBhZDawKRnFrSUaCFSXUS2HeWquJRpiSu9mM7b/XaYDfMX6sBoRWUQgdcOOFRnHjpYkJs0kNl0LL59DPACPn74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ktF3SLbz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ADFFC19422;
	Thu, 13 Nov 2025 13:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039010;
	bh=QCIjx7RLAaEAHWXg/eTxYNQswMmNNkRk7sB3QkTa88o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ktF3SLbzqFT9K/Q9++i56c9oioiXtRk9ixB88HfhEBJxO76WvTKhbIkRSfNUn0MaJ
	 KbNMV7iUrotda8v/HqxCFotKp8lvHwnRx0JOqcmMdAo6mVysX9ksm7bDkFXPzbhENV
	 0oYxo6CKCZUuELxI0Fmt3G82Ed9nPFx5CWWB9fCcBR8+sZzIVPF3wn4qgnTCmNCYNH
	 4RcrldSpMN4Fn/DYCffhvlKuDOnDrL5ZFa1a/mHv4gHnFswdcwO+uK39ZQwcL2OnYz
	 C7MzfmdzfuygQFDpEHCRXx3N8TAksFAnrKkwWqVO2+QbXC0swGqKdGBbJKs8jnQeDV
	 FRWa08v1wRk3Q==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:53 +0100
Subject: [PATCH RFC 33/42] ovl: port ovl_listxattr() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-33-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=brauner@kernel.org;
 h=from:subject:message-id; bh=QCIjx7RLAaEAHWXg/eTxYNQswMmNNkRk7sB3QkTa88o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnuyjuXA/4W6P7n3KPxiKJqq2nCoZN/xOZek0vwPX
 ZJVnvest6OUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi330ZGdZw7z+RPvNtS/+R
 7gs6bgeNz26aJW9co6vqzDDHk114yUdGhuV80dHGGUdmWoqsEhI1nG7yTSF42+vElCtfL267fNd
 FnxsA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 788182fff3e0..aa95855c7023 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -109,12 +109,10 @@ ssize_t ovl_listxattr(struct dentry *dentry, char *list, size_t size)
 	ssize_t res;
 	size_t len;
 	char *s;
-	const struct cred *old_cred;
 	size_t prefix_len, name_len;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_listxattr(realdentry, list, size);
-	ovl_revert_creds(old_cred);
+	with_ovl_creds(dentry->d_sb)
+		res = vfs_listxattr(realdentry, list, size);
 	if (res <= 0 || size == 0)
 		return res;
 

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-68671-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AACC63490
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:45:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E62B83814D2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEBBA32E13B;
	Mon, 17 Nov 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LHAndEwX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3807832E121;
	Mon, 17 Nov 2025 09:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372075; cv=none; b=HigL/fmQorfDMFKR+e8U3/2S6ZV0MNINvjXOioLEwJRQKXye9p3Q5Ofz+9X9614Do3c8kPv8cbVBg5B7UAhKCZttLWbsFBYssf3TdwpBdL0ljKE/qR/BJntsOLsff7J7soYKO8B71iNvHCC/3AkkAKjg/D7do7A/jo/lXHRIKq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372075; c=relaxed/simple;
	bh=rPoSuECMAKBN9m8sbIu3E2PkfIRUFNoqozRYSn9OzDE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MFO6VxXjb3EJorrmkX2L52Tt7hZ6NnpAdEucRB/+cCodYfYZYHrLAxZIBoyks2yFT6krWCvGdBOy5x4On+x0l0jYrTdAsTSkgdCpU8WBiKYXJoQqExFvvHyKx1inEbaJ7WDt2yeRvSc37tPeZUUn6zfAKaHkgIPtsKlP9ylw8FI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LHAndEwX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13EDC4AF09;
	Mon, 17 Nov 2025 09:34:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372075;
	bh=rPoSuECMAKBN9m8sbIu3E2PkfIRUFNoqozRYSn9OzDE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LHAndEwXtNfAyIoxMl3zrQ+/8H3YzXhByRh+Tcw76XPX1ynNJHb2/v8GBn6oV8HLN
	 1RwcSwhdgfAj+kSPUcHe1jm5/SFJv7qjXZqT6Ee0MxyvNAA/egb9sfg9t8aKZpDgIK
	 ZBhrBys9wRVYQIvKHeuScxJF0ZQvayzVwoRbhyqBRcYEXfCUX0axLqKzAF5IR/D+pK
	 rOiWW//6RMxF/ApcuYXjhu8K6TSI8GqA0eSdH/dnap7+PdDGuCQd2LNspdo+G68fIH
	 waY4t7ox8jIpkFLlDsRsKkC1yCIuAkjT0oOgqzPoc6JOQo/DeJuI0YcyESQ1FBKois
	 YvrZTRdZVU9VQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:59 +0100
Subject: [PATCH v4 28/42] ovl: port ovl_nlink_start() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-28-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; i=brauner@kernel.org;
 h=from:subject:message-id; bh=rPoSuECMAKBN9m8sbIu3E2PkfIRUFNoqozRYSn9OzDE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf72hkv+uH+KzQ+j36XCq1v7/ttNfyL0SvPs0fjb+
 0Sea0040lHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRs2mMDF+Ncl4sMrgX7hXr
 KnExanLbCg8z0TWBN7uvBaknesUv+8/wh08qLMnr61mRRKaX6SyP0+Re2mw8Lvf46cVf7qv2aqe
 s5AMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/util.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f76672f2e686..2280980cb3c3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1147,7 +1147,6 @@ static void ovl_cleanup_index(struct dentry *dentry)
 int ovl_nlink_start(struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	const struct cred *old_cred;
 	int err;
 
 	if (WARN_ON(!inode))
@@ -1184,15 +1183,14 @@ int ovl_nlink_start(struct dentry *dentry)
 	if (d_is_dir(dentry) || !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
 	/*
 	 * The overlay inode nlink should be incremented/decremented IFF the
 	 * upper operation succeeds, along with nlink change of upper inode.
 	 * Therefore, before link/unlink/rename, we store the union nlink
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
+	with_ovl_creds(dentry->d_sb)
 		err = ovl_set_nlink_upper(dentry);
-	ovl_revert_creds(old_cred);
 	if (err)
 		goto out_drop_write;
 

-- 
2.47.3



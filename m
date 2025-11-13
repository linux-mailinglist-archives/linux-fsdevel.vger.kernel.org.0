Return-Path: <linux-fsdevel+bounces-68333-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B83C58E83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:56:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7DB5C36211D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC0836999B;
	Thu, 13 Nov 2025 16:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKD2F3hb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BFB3359F87;
	Thu, 13 Nov 2025 16:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051923; cv=none; b=ZHmNTVcyzDbekyWYRFoq+WwZQKbAX4IesYrJXFIThmRGvB/X9Wt47L0ZikgxeDuuqiRVvNF1XguV8H6U7RAAFixFEy8EUU5xUFE/ECk+CqGYmHr7M+GStvgBV0e+msFCcjciXpD8sSOdtsAE+Rb4jlWA/f1XY63A3sa11wCdDug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051923; c=relaxed/simple;
	bh=/z6w0Lru6782SK+PYUoGMYK9C/VHAIPVBeMHm5eoTTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SK9o8f7BNgFoMYk9/QW52rW6k+/IQzOohAhSx34Jc+3S51pmxbbXwCHDq9AUsHA0Qh9DbAHJFS4AwWSmaJdT01EsfJunag/UguTfLnfumbCanM4pWwymjdx5agBpNZO2kP3NChCQOrMPmG4G6xqFuZwIBZ/sGxM2zTAH/sanCGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKD2F3hb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 051C5C4CEF7;
	Thu, 13 Nov 2025 16:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051923;
	bh=/z6w0Lru6782SK+PYUoGMYK9C/VHAIPVBeMHm5eoTTI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=UKD2F3hbXb0759loQBQhl/04Eq3XSwIpKZ2hEBHd99/w0qz/GiOMCcLn4uExVnd0k
	 /umiPRVKfOjuIQqjhpthmlpEpqDZoaP0ttoxqm5ktFAIa9JzU5z8j9S2ZvxwR8ZCLv
	 VGzotJRIXF6ZDa4ePCS8NU8KsQwoqUPkb5KIJWxLckLD70mAMOJcx9IGjAxG6+ILgA
	 dpUJM1pcRBGuyGhkgAI5oVeNaV0yFnWX8Ae/Gv59UEUQ27jpkkcJOKNZsoJdfEGKyV
	 p31ir6jfC+E/qpECE926e+nQPJBlh7o/03lMLwdGe2dGnCT/eYopnIsOMbd9f+kOmu
	 6+FzRbkszVNAA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:45 +0100
Subject: [PATCH v2 40/42] ovl: port ovl_fill_super() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-40-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1222; i=brauner@kernel.org;
 h=from:subject:message-id; bh=/z6w0Lru6782SK+PYUoGMYK9C/VHAIPVBeMHm5eoTTI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcboLtJXVLGo1WVbEuMq8e47sHXeTI/xtyS/bhC62T
 0xKFP7XUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJGtixkZ5s9YWbz/afbDFlOB
 4KXe+5l2d6tpCz/t/91uldfFstX+HsNfWUnmyUx1d9nn3oqQFRGb7Fd88fHekiYzxrbZjHt+P7H
 kBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

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



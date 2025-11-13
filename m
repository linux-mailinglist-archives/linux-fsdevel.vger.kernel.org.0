Return-Path: <linux-fsdevel+bounces-68255-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2BAC57980
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C6223BF73E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4194C3557E4;
	Thu, 13 Nov 2025 13:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g69rE9cp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFBA34D91E;
	Thu, 13 Nov 2025 13:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039019; cv=none; b=BuyKZnrLZLDLXvHzlMoUQhNIQoWIRxAhw78uOD1RLy7YEkqJyfx87TeQbb+CJpyIQg1OUrA8iiAlUZsyFa15/8kL6SDIydIHsQ7CM0bhTulnGtIoevwGMLD4WlFnTK1fNIBz5+lhqz/yLw47QjhSq+rjBY8omej37brXVwfUgNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039019; c=relaxed/simple;
	bh=Sj3buniy8H3+Kl2hZeYAbcZSy7Wq6H+Gne1vAXkxIOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hFltjMi+XoiGVyRd/j8WenuoTknuTWbAEoptV855B0S5PY8KEEnEvwwhP1P4rdcOXZb87Y9js80kQDr+CPmYu6BeiYvL/pSaL+gPafrMNPJCRvT8UV4pf6wEqj8qv4cOdgfzyBnyM2MV9Gfly5Jo+0wIoezJYf4y1AQpO5LSyfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g69rE9cp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 337F3C19422;
	Thu, 13 Nov 2025 13:03:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039019;
	bh=Sj3buniy8H3+Kl2hZeYAbcZSy7Wq6H+Gne1vAXkxIOM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g69rE9cpxaqh1doAFn+bx2BmQwJ/tu0Z8ciaWs94m2mjtZMKwzTaX00WvsJJY/6Og
	 2eYw+57fPrtZZvnY28I0SdaJsOl7BZhge4m+Q2b8KigrUzm7aeHh1tumQ7FxL7EKcS
	 rbBFfM2obNy42eQUFzx6liXz0x273P1gffG4JiKf89ldYBw8/mJLHRVecEKs8qGlyW
	 cRaD1mz1uJfqqKa+SD4L3yKkX7OVq1j/WeVssFF2Hhu4rRwQenxsoKkYthxKTCRM1D
	 n16Q16Iv6ZjkNh0UD1NpIdGoDyiiSlBYeu6rWwYjVt8iqCSdI/0agG33ZA+HYJVTXr
	 6yZRJ2KUIc3aA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:58 +0100
Subject: [PATCH RFC 38/42] ovl: port ovl_lookup() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-38-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Sj3buniy8H3+Kl2hZeYAbcZSy7Wq6H+Gne1vAXkxIOM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvy/bqhkaqsalCRfLPxOp5qBe72G01eITXdG6NrF
 VT+T7rUUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJEVkQy/2dKezFtzo1c3+EdR
 5tnp92NTnsmftN7UvITtbon4odeMPYwM5zI+nS+/4vPn4qpP71qm9HT9lKkWf1utvU3nF99ykTd
 uzAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index fcdc807f41c3..03ef31afdd8d 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1377,7 +1377,6 @@ static int do_ovl_lookup(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data *d)
 struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags)
 {
-	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
@@ -1395,11 +1394,9 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-
-	err = do_ovl_lookup(&ctx, &d);
+	with_ovl_creds(dentry->d_sb)
+		err = do_ovl_lookup(&ctx, &d);
 
-	ovl_revert_creds(old_cred);
 	if (ctx.origin_path) {
 		dput(ctx.origin_path->dentry);
 		kfree(ctx.origin_path);

-- 
2.47.3



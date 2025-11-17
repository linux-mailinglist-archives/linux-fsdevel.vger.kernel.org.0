Return-Path: <linux-fsdevel+bounces-68681-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DD470C634F3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:46:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id AE8CA3680D9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1341329E61;
	Mon, 17 Nov 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o7G2ZQ3L"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170AA32E6AE;
	Mon, 17 Nov 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372093; cv=none; b=ejp3rFhTCLqfk8aWpHkbmo9JjY9ZcafcpP69tK0qiPMtM2Cl03fWvdL52LGOgkWIM7tU1echSMgpeOVl1TPH91L8uabDejzjfSumOcfUFzvDsHHv38T303SedI+l/5NoMV9tfFNCeQuFS0CedNrb2WUu6O5PR92+QgZpLxs9iGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372093; c=relaxed/simple;
	bh=tQdiCJOVAeQftK6LxowC47B1FIJEhrUOstx3PBXlZTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rA2hFqQocS11uI3Fmlrg+2v7APazljGV+jQ4HjqpbQX2kTP2gz7NB6oR6P/lw7Q9ACiQStrVCBRA/Ew6ViKuknRidrX7L2flxS8Kcmd/9x1URcnTSMMInAiAZUTOkm+9N2kO0w9Xo73wjbNNVFQ1rXEXjiW3tj5+WLuij1AbmAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o7G2ZQ3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2582C4CEF1;
	Mon, 17 Nov 2025 09:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372092;
	bh=tQdiCJOVAeQftK6LxowC47B1FIJEhrUOstx3PBXlZTA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=o7G2ZQ3LkhUqZ3lwUSgIdSM2Ro4fYkheiKoU8pHkztwjvdrilABAW3neFuNrk2rOH
	 UjgWtAbgBCVMXeVK2UiEv8iE4gOJ9W2MCw+s0oDUhlMLs6psmZbASAvXGloAcJkoje
	 ajo2WV0dMfqcGngqwXHAbtTLiV8aD/ub283scrxc/MjeCJL/eB35jpttm3hmiW5x12
	 kRo3H8Pu/bhUj7Il0N2SeOfbzmRYJd/Y8ZhuimW9T+T9BrQsPjgu8ckxAaxCzmprc+
	 Gol7zUr/F/KELBsc6+o7L7f8kdMRYV9Pep5BmIhAblDXHTbGiYRVgyAnfsILup3hk1
	 xU6+95UERs3Eg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:09 +0100
Subject: [PATCH v4 38/42] ovl: port ovl_lookup() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-38-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1219; i=brauner@kernel.org;
 h=from:subject:message-id; bh=tQdiCJOVAeQftK6LxowC47B1FIJEhrUOstx3PBXlZTA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf72ny9f7eESF7cnojcXK6veF7j7O6T97rEbSkFWd
 8p/XT3g01HKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCRNx8Z/jumVHGfzFjFlL30
 Z7L3/S+X71vKnakTeXVJ1ccn1NGx/RnDP3u5T+7+J/JvpHRw2r/6zLv41AzhO+pssycxvuZJfb6
 dkQ8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/namei.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/overlayfs/namei.c b/fs/overlayfs/namei.c
index 4368f9f6ff9c..9c0c539b3a37 100644
--- a/fs/overlayfs/namei.c
+++ b/fs/overlayfs/namei.c
@@ -1376,7 +1376,6 @@ static int do_ovl_lookup(struct ovl_lookup_ctx *ctx, struct ovl_lookup_data *d)
 struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 			  unsigned int flags)
 {
-	const struct cred *old_cred;
 	struct ovl_fs *ofs = OVL_FS(dentry->d_sb);
 	struct ovl_entry *poe = OVL_E(dentry->d_parent);
 	bool check_redirect = (ovl_redirect_follow(ofs) || ofs->numdatalayer);
@@ -1394,11 +1393,9 @@ struct dentry *ovl_lookup(struct inode *dir, struct dentry *dentry,
 	if (dentry->d_name.len > ofs->namelen)
 		return ERR_PTR(-ENAMETOOLONG);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-
+	with_ovl_creds(dentry->d_sb)
 		err = do_ovl_lookup(&ctx, &d);
 
-	ovl_revert_creds(old_cred);
 	if (ctx.origin_path) {
 		dput(ctx.origin_path->dentry);
 		kfree(ctx.origin_path);

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-68460-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C465C5C873
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 11:20:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F93422D99
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Nov 2025 10:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7702A30FC18;
	Fri, 14 Nov 2025 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxkkQGw7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECCF30FC35;
	Fri, 14 Nov 2025 10:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763115333; cv=none; b=pAby7yGleXX70DYeOC0sCbi7LjXgJmKBtff/g9l4bpGbunt31kGed5jCGCXzzdKeFVRCqgZriO5iSrLkRInDvWGWNrTD+OrLeOwoXTaL7dAmxm3xp5NyA1fShyPRjhUL8vj8t/P68teQNkmOlZ3BH1vKQrSMBSyHPuSfZ2NmWS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763115333; c=relaxed/simple;
	bh=1XcWR+N6J1mo9KpbgpVO2wXMMlTrvO22q9OiXB2fqRs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SCWuzZWS1EXTxlkzCZ75U1CLHWTwPDVc2Rus6Z5Ugmm+qzrbjPWiEynBA26LzScZ8T7gQ5T1xsOFcC4B3dkloz2PE4WsBMoohQIEd1DDqZU3XxtEQko/Ds2P7zf1eBe5PRzNc/MeiJS8W2+HLqrsHoAkds94esnl+zAM/4lqUbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxkkQGw7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE84C113D0;
	Fri, 14 Nov 2025 10:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763115333;
	bh=1XcWR+N6J1mo9KpbgpVO2wXMMlTrvO22q9OiXB2fqRs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sxkkQGw7enAUtI6PbmcwQw4bZ+w7pcREh1TPVCpJ0Z8ldiNzGWObTtDSLC1EfxqbR
	 9UrYNiJZR2VM6o2BZeN9HLcJRTa9YKbgxuZrblyXdZLmNqpnXcyq54wSm3roJrGm6f
	 1Jb6NGsdYW79Z0KAnPiVp3+REwuyNntHGvpTCWEoylJrbBN6rwaH3xjzYzwH8s0+Ed
	 zlLSRyWm8EqPMhLbD+hEpkkZ2RcZqUjP1lxffjv5jjbYdB/4VkEB9Cd1QtHX4QiOO6
	 ypYwb9ruIFqi2datHcTYUUI/hWKGRjJmm3x4JdUM0cy5GgDZ5pIYJQP2EpDUIAw6vr
	 y6Knqye28/2XQ==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 14 Nov 2025 11:15:16 +0100
Subject: [PATCH 1/6] ovl: add prepare_creds_ovl cleanup guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251114-work-ovl-cred-guard-prepare-v1-1-4fc1208afa3d@kernel.org>
References: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
In-Reply-To: <20251114-work-ovl-cred-guard-prepare-v1-0-4fc1208afa3d@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2403; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1XcWR+N6J1mo9KpbgpVO2wXMMlTrvO22q9OiXB2fqRs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKMzq6CV4RS31oERb1c8qNjYWFOk86J7tonbSwCX1S0
 aO/7Mv8jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgImYdDMyHJxzue5HA9vSvoA1
 y0VcPbTPF8queLRjrVz3guN3L1mFzWdkaHjydddMPwO/JaJh7RZ9u3kOeHR5r7hdtsW5QH9m3eW
 bHAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The current code to override credentials for creation operations is
pretty difficult to understand. We effectively override the credentials
twice:

(1) override with the mounter's credentials
(2) copy the mounts credentials and override the fs{g,u}id with the inode {u,g}id

And then we elide the revert because it would be an idempotent revert.
That elision doesn't buy us anything anymore though because I've made it
all work without any reference counting anyway. All it does is mix the
two credential overrides together.

We can use a cleanup guard to clarify the creation codepaths and make
them easier to understand.

This just introduces the cleanup guard keeping the patch reviewable.
We'll convert the caller in follow-up patches and then drop the
duplicated code.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0030f5a69d22..87f6c5ea6ce0 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -575,6 +575,42 @@ static int ovl_create_over_whiteout(struct dentry *dentry, struct inode *inode,
 	goto out_dput;
 }
 
+static const struct cred *ovl_prepare_creds(struct dentry *dentry, struct inode *inode, umode_t mode)
+{
+	int err;
+
+	if (WARN_ON_ONCE(current->cred != ovl_creds(dentry->d_sb)))
+		return ERR_PTR(-EINVAL);
+
+	CLASS(prepare_creds, override_cred)();
+	if (!override_cred)
+		return ERR_PTR(-ENOMEM);
+
+	override_cred->fsuid = inode->i_uid;
+	override_cred->fsgid = inode->i_gid;
+
+	err = security_dentry_create_files_as(dentry, mode, &dentry->d_name,
+					      current->cred, override_cred);
+	if (err)
+		return ERR_PTR(err);
+
+	return override_creds(no_free_ptr(override_cred));
+}
+
+static void ovl_revert_creds(const struct cred *old_cred)
+{
+	const struct cred *override_cred;
+
+	override_cred = revert_creds(old_cred);
+	put_cred(override_cred);
+}
+
+DEFINE_CLASS(prepare_creds_ovl,
+	     const struct cred *,
+	     if (!IS_ERR(_T)) ovl_revert_creds(_T),
+	     ovl_prepare_creds(dentry, inode, mode),
+	     struct dentry *dentry, struct inode *inode, umode_t mode)
+
 static const struct cred *ovl_setup_cred_for_create(struct dentry *dentry,
 						    struct inode *inode,
 						    umode_t mode,

-- 
2.47.3



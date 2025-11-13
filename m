Return-Path: <linux-fsdevel+bounces-68361-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 438DCC5A224
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45FB235437E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FBA325720;
	Thu, 13 Nov 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSo0+YQ0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6361C324B3C;
	Thu, 13 Nov 2025 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069539; cv=none; b=KTI4zAl0yKUY6EnG/SlAInIs/iqS/eK9T51q4317zB8ybILzvbqjrWgOfP9YX7dOAiHXkvcg3JMYdgbj5nDsd7g80bVHpCO5l7JC8k+QSeByHRKX2/BTlDoWSbZp03KG+3Gk7aZ9Ff3Fdu6QZurjGAKlQhR//30Ril+6W/qndfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069539; c=relaxed/simple;
	bh=B2+Y0YF3/vmrw7dYZj5bbU+H2FgZF44A5BgQtn2E3aM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KsRGe5VBeyxytzBV72jJP+9qOaKVJXoKOqodhcr9kAyQEn6dcgopdvwgbGenrxDMtpbh1MT7ypMnYDw9R6gWo5QA7xt6DVBCDA0iLY5ZrU16ma41OG3Pt0wCuNPl98o6JVF5SkA+UhjwUl4/cXpctC1iOVQGE/TD0/mRhhOUEZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSo0+YQ0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4D6AC2BC87;
	Thu, 13 Nov 2025 21:32:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069539;
	bh=B2+Y0YF3/vmrw7dYZj5bbU+H2FgZF44A5BgQtn2E3aM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DSo0+YQ0rfvsMQvkP7wLQ/KMTF63CkP+4hCCdJ8dc4ogKCXpYuPfx8OKubmmtVeNn
	 5OegXmtMDFtXdp6PMLMroCUrS6AqvwovWj6ehFyovRAwxrpMKR/u+c/BXwiTBUaPpj
	 8F6w+ehUpHSGtYzEeMQHAiST+pRFf4hVSkzUF/ccl1te5fgAM42YCOKkLM5239wPb/
	 JZLy/bmYW3SxTj/K9cFR51JmdTTK+IhRl66iaZ9hNycwD2qU6evWalBWiVL/XRkP97
	 896xhrRS4lMcqHrS2GHd/OmIahIVFi/e8RbPdJiKU4PUwZzckiuddgcxn8m3AoxZVt
	 2WMvFCmjZYiYQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:48 +0100
Subject: [PATCH v3 05/42] ovl: port ovl_do_remove() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-5-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1081; i=brauner@kernel.org;
 h=from:subject:message-id; bh=B2+Y0YF3/vmrw7dYZj5bbU+H2FgZF44A5BgQtn2E3aM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YVJ8S4/zfg1On114sk1a09GzwrQFLE42cbBzcTkb
 sh9/Or2jlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIl0P2dkOK7KcNHWT3v6+buT
 RW5OVGZb1TCFc/6qb10O30STbJ/qKjD84Zz9KGCdSMjOnMW9kqd/KjZ+Umx0EPs8UUgnIqVHWD6
 VFwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 63f2b3d07f54..1a801fa40dd1 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -903,7 +903,6 @@ static void ovl_drop_nlink(struct dentry *dentry)
 static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 {
 	int err;
-	const struct cred *old_cred;
 	bool lower_positive = ovl_lower_positive(dentry);
 	LIST_HEAD(list);
 
@@ -922,12 +921,12 @@ static int ovl_do_remove(struct dentry *dentry, bool is_dir)
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
+	with_ovl_creds(dentry->d_sb) {
 		if (!lower_positive)
 			err = ovl_remove_upper(dentry, is_dir, &list);
 		else
 			err = ovl_remove_and_whiteout(dentry, &list);
-	ovl_revert_creds(old_cred);
+	}
 	if (!err) {
 		if (is_dir)
 			clear_nlink(dentry->d_inode);

-- 
2.47.3



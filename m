Return-Path: <linux-fsdevel+bounces-68294-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F111C58FAE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:05:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C516435AC4C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F9E130AAC4;
	Thu, 13 Nov 2025 16:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rYjTyzQ5"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0558A2E427F;
	Thu, 13 Nov 2025 16:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051852; cv=none; b=JNjEu4w+AaQfH0qwKjOQ6tXnGU62+DBvtAVD6gp+8p5ELJRQgC2rmFz7gpdk4qUQQTxG92Fv4BLPoHyjF1myfc+X0WJ45Q1PKtCnzbZOHu4iU6q/IhHmVHi8Wz0WIEn/K/lESM/GKR6BAtyavSzQ92DtewS/XLoIPsDFQtjN860=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051852; c=relaxed/simple;
	bh=zSASKcddf9CQaFnn2hf/tv6j/LhojRKTPaPL/pRNonA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XQDZw0SLVPhzpB1O6duNISx5idmg2q5XUX3FAQFKPcnf7bIGAZ0hO4gbRySDYXSjGTrZ7lVkh7ficaAT/Rur3O+irgROMW1BW9PR/8sgYlzEhQ4tva+asLYVqoXM/AQMLsc8syncXV3PYJ7Or6DepP1VxeJ8m5cK0Lw5Pk9TBqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rYjTyzQ5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33115C116D0;
	Thu, 13 Nov 2025 16:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051851;
	bh=zSASKcddf9CQaFnn2hf/tv6j/LhojRKTPaPL/pRNonA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rYjTyzQ5PHwzSNcSs4sfb79K8QzmrJmgOn03QjWsR50gzVPbwfxeIuqGEkK/DmW8v
	 KRDcultkPSVOTEL6Wx6Fpy0DfFrDw62FONH1Rjd0bln4KCvhkJDHh1y2a6FkAnXeOr
	 3GdwDqKKImhmH8syW0qOzsz3WOm7/nJabX2reTs/v+eNYA2Sk+CTqB2SGZ+L5Fkr4y
	 TOFIQHOOYKep3xVqEqhOVxTGNUSgnhOEelhd/rO4ruhJ44nkNKyTg7N73Uz06a3bit
	 zGgNV3ylkK59vxk6mY5zBEPcopyN/RMvMfsNDWNAyECrQ7IcLs6wcg7QlkJ2qoXOke
	 wFEeHk36dFwcA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:06 +0100
Subject: [PATCH v2 01/42] ovl: add override_creds cleanup guard extension
 for overlayfs
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-1-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1055; i=brauner@kernel.org;
 h=from:subject:message-id; bh=zSASKcddf9CQaFnn2hf/tv6j/LhojRKTPaPL/pRNonA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbq2pq9kdDEx6c1b2Wh0+877oqjiWaq5mXJHOe7Oq
 LDderyio5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLn9zL8r4q/8Gt9a8qfzzVP
 T2VE5ez1u6az1jpHa8+cCT9tX3gwsTL8lalJCMyNruUQ/TbvxjWuE6GeLNa5z58sfqR8dsHfn19
 0uQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Overlayfs plucks the relevant creds from the superblock. Extend the
override_creds cleanup class I added to override_creds_ovl which uses
the ovl_override_creds() function as initialization helper. Add
with_ovl_creds() based on this new class.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/overlayfs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index c8fd5951fc5e..eeace590ba57 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -439,6 +439,11 @@ struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
 void ovl_revert_creds(const struct cred *old_cred);
 
+EXTEND_CLASS(override_creds, _ovl, ovl_override_creds(sb), struct super_block *sb)
+
+#define with_ovl_creds(sb) \
+	scoped_class(override_creds_ovl, __UNIQUE_ID(label), sb)
+
 static inline const struct cred *ovl_creds(struct super_block *sb)
 {
 	return OVL_FS(sb)->creator_cred;

-- 
2.47.3



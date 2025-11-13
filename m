Return-Path: <linux-fsdevel+bounces-68312-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AEA2C59422
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A3B63540658
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BCE0366563;
	Thu, 13 Nov 2025 16:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjK3rV6V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C323624A0;
	Thu, 13 Nov 2025 16:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051885; cv=none; b=WzIdbVUTyVKLVQv5YTtx+iPFcHRIaGR48BJraf9YL2rqTj/mW2MCLV4OO1VeQP0V17EZt3u7Z58ow1QHRl5MvDT6TaDqsU4MgsOQCnyX6BgzjN8WhZvw55T5u0Hnq4gwa+0oWn6Pzitnz0dF1s7HProKnb2FhrClBpIR+lsnt6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051885; c=relaxed/simple;
	bh=jLPCMUI1gH+yGj2d6PE+by1iikCIptRkcKk43mWvidU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pWQix67dYfCwKHucpXElvLkOE7lBigX7oB2ldWIh/HjJwLeagR2Qiu0F/GUUIxnKzrfie1vkAFgtnUk45UgZdlIT5LC1Yq3CsSyr0e0DwuqiwyKPj3qlorzRzLxTQ+IDnKBe6KRqdmS9XLj8/t4jOdmmhC79mPemdOQ6oC6Wy2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjK3rV6V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2BEC4CEF7;
	Thu, 13 Nov 2025 16:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051885;
	bh=jLPCMUI1gH+yGj2d6PE+by1iikCIptRkcKk43mWvidU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=DjK3rV6VqAWAAeEVCxPDbCMXAQWvM1du3+5/TkqpGEjk0Rx7+kI3toSkH+5ZKMe98
	 XwCqdffeEk1e3289dw1EAnbAMULRD02wZ3rFpxgJLU36upIpbiv86CnwkbzbG0ASMf
	 n7Gt07CHwG0ZWGbIKGd616Z/Fx8cROKxTZCyPHLjm7OQgzkAYctgPSooSErNjbgOx1
	 2Gas3bSCSI2e0g4P4bfA1kmr0Rr2WIzzPn3eMvFQSoA/vOit+tCs8qzxsI2FQtg6fH
	 iSmBY3QIXH6dDDbBiH3G17lX7K5Zo23jB3SrFFmmpyjdrMcmN6dfOIuDzvoj5/Yavi
	 ikCrukGXYDgEA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:24 +0100
Subject: [PATCH v2 19/42] ovl: port ovl_fiemap() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-19-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jLPCMUI1gH+yGj2d6PE+by1iikCIptRkcKk43mWvidU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbotYdi5PK/0Xrl/fvwsa32bfs9mV8bpa942+evkf
 /u5t296RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwETMRRkZrvNrnL9RqtG5tHHK
 t/i9l2bsvXNQzqt3bWBh+VqOld+WFzP8T3y6deLl65Eedd3lf0++VfrJ+/TLjBB/J6nSFXrTtoR
 M5QMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index e6d6cfd9335d..5574ce30e0b2 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -578,9 +578,7 @@ int ovl_update_time(struct inode *inode, int flags)
 static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		      u64 start, u64 len)
 {
-	int err;
 	struct inode *realinode = ovl_inode_realdata(inode);
-	const struct cred *old_cred;
 
 	if (!realinode)
 		return -EIO;
@@ -588,11 +586,8 @@ static int ovl_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!realinode->i_op->fiemap)
 		return -EOPNOTSUPP;
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	err = realinode->i_op->fiemap(realinode, fieinfo, start, len);
-	ovl_revert_creds(old_cred);
-
-	return err;
+	with_ovl_creds(inode->i_sb)
+		return realinode->i_op->fiemap(realinode, fieinfo, start, len);
 }
 
 /*

-- 
2.47.3



Return-Path: <linux-fsdevel+bounces-68322-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E7AC58E74
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:56:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA410427928
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52DD0368283;
	Thu, 13 Nov 2025 16:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKnM+IiT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A575D351FBA;
	Thu, 13 Nov 2025 16:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051903; cv=none; b=tdPEHAOUwrOvIzIwFcX+afFRLnTWPFA4zs1/z/po20/JmVS1aeUMzlo8mkkjj5zEOj6xvqmpht8X7MMCRkkhuQTC2yp+m9SbQuHj3QYasRre5c5TYXHfVUhWanGIOg/aaXpygbgt5h7qdZ5DlAco7L9z0DKZb0/RHQIGhPxrvSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051903; c=relaxed/simple;
	bh=OBrlzcQDy4ZIB5j1MKvbxhMIoTQGFIyGcvP0Nj09QT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vBFT7l1SceUJScTtKht0RiUgEuaK4wmXokrSKVQMzjLGIbDoMsn/cKkkHiQWZbbVwEMQ6qslWSUXTMovDypQmDKZG7vQUmY/Yz24jhaOKxX/TWH10VDTSPZgSWgJuxqUSAlhjOAp3oE4ASVqcFmT6OTZMovpAXdEJevMO+NeMG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKnM+IiT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CAF4C4CEF7;
	Thu, 13 Nov 2025 16:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051903;
	bh=OBrlzcQDy4ZIB5j1MKvbxhMIoTQGFIyGcvP0Nj09QT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SKnM+IiTmFrB+spat7zAGLCqDC1e9nKn+wN/NLW9d6lgdB3hX4SbzOR1tBdfXHODy
	 SBDcNB745GRDSqHG3XlRFB6u5L+kBQwn/bqKZQbTL+lEx3meo7IkEOl1ve8TgnAtHv
	 fAwmVgNT7qR1b4cr/m8X6ylNFDbGoPfOrk404w+ixe3apW87+AWizb9GjjKbwxsG16
	 qL7kN8VuT3KZcSaIA8OD8M3Fg6kuiKeL965UmIxFA37uiKO94OI8gq96najBRpvuC3
	 MAHEWOsTAtwKMA8VbID4Z2GMlYeLHFlb6zEcDFs5J0aBQBwgtKFYNG9SammTzrOell
	 09ErcECl6QJQQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:34 +0100
Subject: [PATCH v2 29/42] ovl: port ovl_nlink_end() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-29-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=722; i=brauner@kernel.org;
 h=from:subject:message-id; bh=OBrlzcQDy4ZIB5j1MKvbxhMIoTQGFIyGcvP0Nj09QT8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbqXWNTwxbtWC69ev0JCa+0kaxH7t4dljqnGePK5r
 jlj1LWgo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCL23xgZzp1caFt5KWl3fJ/8
 T5ZzEptZEncJvXn3Mk110lvBpCc1dQx/Je+eill7vGPutYT19x7arQ6JmizPtm1a9rUU312lYlp
 O7AA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/util.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index 2280980cb3c3..e2f2e0d17f0b 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1211,11 +1211,8 @@ void ovl_nlink_end(struct dentry *dentry)
 	ovl_drop_write(dentry);
 
 	if (ovl_test_flag(OVL_INDEX, inode) && inode->i_nlink == 0) {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(dentry->d_sb);
+		with_ovl_creds(dentry->d_sb)
 			ovl_cleanup_index(dentry);
-		ovl_revert_creds(old_cred);
 	}
 
 	ovl_inode_unlock(inode);

-- 
2.47.3



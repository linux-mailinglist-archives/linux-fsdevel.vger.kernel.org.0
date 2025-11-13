Return-Path: <linux-fsdevel+bounces-68237-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D0C578D7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:08:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 48943356E24
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07363546F2;
	Thu, 13 Nov 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqsK1xxt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0A435292A;
	Thu, 13 Nov 2025 13:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038987; cv=none; b=DGRh5ekI3fmD5D5vAonadPn+536rAqJqqHm5Je8ZjUE+XKe7o/uv4ft6nG6fWHaH12R6iUygcOyPeOocd130rdETRLdDCdhTv4Xv7YwLkCXhLstpgTimEc6ZOHz+Xw87D8KOgtsk5cqk5zM0/VbpiKBA3Rs+NZeAy1IOGwxGNI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038987; c=relaxed/simple;
	bh=jLPCMUI1gH+yGj2d6PE+by1iikCIptRkcKk43mWvidU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fo8a8H2AKaSs9+h1OW5775/ufh23FnvpZzN43Xz8vitHGGTyEG7CqiC5pPSOn9XCWBSxKO33m4eUzMrGpFPCQDngPRV5pF/oqiN5AxtcNChTg/XLujgIwYSA51BCyyEE//lg6C+KZWkXGLP6xumgq1UdI9eQ035V8XopCLVa3Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqsK1xxt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB12C4CEF5;
	Thu, 13 Nov 2025 13:03:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038987;
	bh=jLPCMUI1gH+yGj2d6PE+by1iikCIptRkcKk43mWvidU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dqsK1xxtNBKpv1MUvBSsAAhJVYCDZexEN4PsLccj6FPZ+OU3ri9BfZR1vkTG4S57b
	 4xtW2wZRooBcqH5tudghyHswO0sJf+t8PNtrNn3Ti8m0roqRsh7Ga3JHRxZjeCp2tV
	 nlyBTWHrgJcsxyYgAn5Hg+zd4EIoYS+c+kN7wQHcPorn3pKOlE6HLHmfCIP6K2Fh/4
	 L9t+/Gy/q653oIeiiFn4DpM2RMCFNXNMx2WpXK1QK5o/zKwDk8rEQKuTI48lxU0QJW
	 5v0lGVeS2oCQbo6rWg5KXCEPTdi/7zkJe3Hs0JUjqNl9kef6X+QmBKkcMW6PcPBUOY
	 mEkC8fojo7fXQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:40 +0100
Subject: [PATCH RFC 20/42] ovl: port ovl_fiemap() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-20-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1114; i=brauner@kernel.org;
 h=from:subject:message-id; bh=jLPCMUI1gH+yGj2d6PE+by1iikCIptRkcKk43mWvidU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvM/P6Dv1GgyrSfB+5uMON81Ps95iH/5TthYVPuC
 9zt2pRxsKOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAib2YyMmy5HW211dpGb9qm
 K88fF2yS5kuSfSMxbWqp5vEHX48mHjVj+J8VELNmi0+YYp3RCrki1k9rklUXVngv6+xXXhJx1rO
 1ghkA
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



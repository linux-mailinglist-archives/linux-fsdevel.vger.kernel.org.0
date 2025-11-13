Return-Path: <linux-fsdevel+bounces-68232-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 168B6C578C0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:07:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 23A8534D891
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DDDB352927;
	Thu, 13 Nov 2025 13:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfcYcUs2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7731E352924;
	Thu, 13 Nov 2025 13:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038979; cv=none; b=Y7EjNxoMSjavxYeaqEyfFCDwtKuzc7W8JZd/TKd8byrMgevBDICGs3hBKTHuDtwuetxJP21dFiHQNJJQy76TWE0ZJZTkKpc040SwO3c5GlvLbg9uSrUWY7h27YOr4D5vazvUdco/nBADZTZu/Jp1Q1VqO+uS5BQmn7bgYLGKHOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038979; c=relaxed/simple;
	bh=I/TPAHuCuUWPH+MYwzqWE8VY4Lm4p2TKjL13cwusq0g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eWefP+d2mBR6EmL/6JUSy3SAaIWj+d8yCNupOqZ4ad5ql8ZwDmnHLprS7B611GxyrXV1KFkMarjEn9q4b9SWzSGzrARDch3QNbc1O4XeY8KXDplE3pR48ViDJt6TZZXR50L5MTwj0EMNiMAQeeX8xEQsYYg79Tuts+jW9gmdmbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfcYcUs2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C66C116D0;
	Thu, 13 Nov 2025 13:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038978;
	bh=I/TPAHuCuUWPH+MYwzqWE8VY4Lm4p2TKjL13cwusq0g=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bfcYcUs27tsmXfKbzeKTapbmrxRSt+npfEUwq10jC6WAuuhJJal0zhUod3jxuiFlJ
	 DwloRbODz/WYM5RGqgbiOaNaUjXkiGRElpzeLqdR28komO9a0gITVUwb45nakqF1HW
	 SPpsWxoV2Io7RvbFeyh3taq9c0dUBRtyfboAm4HcvM+tb7CCoSnB2bnk13GXFn8U0x
	 STsvqtlIsGCP6SqzCH/9CNCRbGaB7ws1l0EiVcpULDfI2696S+sdoyTmL5G7HQgXxV
	 pJZGeDK1eVOtFYoomDdqjDt3qDMORsKMB7DrSeMPUwOE2uHWZMDChEd7gkvbGFP71F
	 CVtzOhkpK3yQw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:35 +0100
Subject: [PATCH RFC 15/42] ovl: return directly
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-15-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1554; i=brauner@kernel.org;
 h=from:subject:message-id; bh=I/TPAHuCuUWPH+MYwzqWE8VY4Lm4p2TKjL13cwusq0g=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXntskXdp/Svvl+L/Z3Y+Cl87O1K82GDFOYfQCK3Ot
 RM+pFZUdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEmJfhr0TGspcdj9jbtjGX
 zH7J9mX3QQtbnonC/lqazDM33l/MuIWR4f1LWQMf+wMmxacCTh8//fG05syKLy/7Vs6vMD5Vd93
 iJycA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

No need for the goto anymore after we ported to cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 5fa6376f916b..00e1a47116d4 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -178,7 +178,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	type = ovl_path_real(dentry, &realpath);
 	err = ovl_real_getattr_nosec(sb, &realpath, stat, request_mask, flags);
 	if (err)
-		goto out;
+		return err;
 
 	/* Report the effective immutable/append-only STATX flags */
 	generic_fill_statx_attr(inode, stat);
@@ -204,7 +204,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 			err = ovl_real_getattr_nosec(sb, &realpath, &lowerstat,
 						     lowermask, flags);
 			if (err)
-				goto out;
+				return err;
 
 			/*
 			 * Lower hardlinks may be broken on copy up to different
@@ -258,7 +258,7 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 							     &lowerdatastat,
 							     lowermask, flags);
 				if (err)
-					goto out;
+					return err;
 			} else {
 				lowerdatastat.blocks =
 					round_up(stat->size, stat->blksize) >> 9;
@@ -286,7 +286,6 @@ int ovl_getattr(struct mnt_idmap *idmap, const struct path *path,
 	if (!is_dir && ovl_test_flag(OVL_INDEX, d_inode(dentry)))
 		stat->nlink = dentry->d_inode->i_nlink;
 
-out:
 	return err;
 }
 

-- 
2.47.3



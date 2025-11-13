Return-Path: <linux-fsdevel+bounces-68387-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 30E91C5A2DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0BC904F4712
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A96C328B68;
	Thu, 13 Nov 2025 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NCHkvcRG"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8696328B57;
	Thu, 13 Nov 2025 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069586; cv=none; b=tKFAzHR2A8xXHjRg2BtXW1RZjshlENARQocoRQmtc9S3mGhieS4zHuGBXgsgu3p4QRiqrxtygxIrfePvoXp066rZCIIN+jVUWrjbsWUUJZkIPv84Plsl5VbDULDGmmGkK59uS31RAJZG3VSbUmUZC9mFNAipfjVXs1pZ93/Wqq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069586; c=relaxed/simple;
	bh=NZvpWdrgEQg6od6W+evXbcQuCw7gbUadQdivoyup+a4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kf8qgsNmlUtBWr3EliLmilcfxK+Vu2OYq5dyGEa3Yo34s/UpRSprhVN/JHtLqa8OzqkkVKKM/RVRpkebZ/wv2lieVkEVyP6iOnnuyPfVPbp/9SLCm3aZ/NhqtsdNEb3XQTJO6chcOkn+VLcPPzE8ucAnPKY9P2Lcb/hXmZLfgHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NCHkvcRG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 422AAC4CEF7;
	Thu, 13 Nov 2025 21:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069586;
	bh=NZvpWdrgEQg6od6W+evXbcQuCw7gbUadQdivoyup+a4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NCHkvcRGhGMw61Kd2vDRJN9sQVI8GJjBWoqeXLp+G5kFvEeF9VUIAg/GZ2+AfRa8S
	 oydV+eEN5UhxbwndiHeCKSWCHYTiUqvD3VDPobSP8M6FdIDvGgUGOVDUo1SHyiKjVA
	 Zv/szQYJykGC1dk4uXzFDCdPAedIiGrVXnq+Zb9dcLjbg7K4Il56VMb2iXvwyQCKgG
	 yV5USHbOa0pASRmRWuRr3HLjOZ5Uxz3KzrJcCfaMv0iannIANZW1cRXZSs3Q/0nw4f
	 +2bXJtxNHU96O/hOsAw5plu2Thdl7IsFVN2ioUNPh0EUn3rBFPfjOazwCaUc0h6B/R
	 3VKie7DIo4vQA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:14 +0100
Subject: [PATCH v3 31/42] ovl: port ovl_xattr_get() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-31-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1116; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NZvpWdrgEQg6od6W+evXbcQuCw7gbUadQdivoyup+a4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YVv3yRceEtIoWrSc3/L7lBXtduWhoFVkoqTtmwvq
 g46+ye7o5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCLTNjEy/O80Z5XxF5T+Er/6
 Tnr125jLqQXZu3V1NUWi7iS+fzVbn5Hh59GNZcIajPcrVhnVlx0N4rNI/vP+6Z2dBy4aHbm/7RI
 LAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/xattrs.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/xattrs.c b/fs/overlayfs/xattrs.c
index 787df86acb26..788182fff3e0 100644
--- a/fs/overlayfs/xattrs.c
+++ b/fs/overlayfs/xattrs.c
@@ -81,15 +81,11 @@ static int ovl_xattr_set(struct dentry *dentry, struct inode *inode, const char
 static int ovl_xattr_get(struct dentry *dentry, struct inode *inode, const char *name,
 			 void *value, size_t size)
 {
-	ssize_t res;
-	const struct cred *old_cred;
 	struct path realpath;
 
 	ovl_i_path_real(inode, &realpath);
-	old_cred = ovl_override_creds(dentry->d_sb);
-	res = vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
-	ovl_revert_creds(old_cred);
-	return res;
+	with_ovl_creds(dentry->d_sb)
+		return vfs_getxattr(mnt_idmap(realpath.mnt), realpath.dentry, name, value, size);
 }
 
 static bool ovl_can_list(struct super_block *sb, const char *s)

-- 
2.47.3



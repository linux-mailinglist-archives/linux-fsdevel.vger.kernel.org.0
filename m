Return-Path: <linux-fsdevel+bounces-68371-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDEB1C5A2FC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4BB4B4F1C6D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DEE326958;
	Thu, 13 Nov 2025 21:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jmg5Iieb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82562C3245;
	Thu, 13 Nov 2025 21:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069557; cv=none; b=oRNodVqeb5i1HutUvi4csT5HcfXb8sMq/wjKiGxE6VtPc3rcq8vvlxqR4KZRZvq0wV3ofQDDbrxRP6A9bUozXZCoQ9nZOCc5N78SUQyDJb1p+qIcgigXt+Y2B+36TZI20hxSFhq+CbK/pky6/6puhNgOhxnweYLhDdYUdhPd40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069557; c=relaxed/simple;
	bh=C4csfGdfNeHOg7jfqeEjQl6Bulh64hMoaHvrlk5FKAA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rJgVySdtUv3NfDVVXkXKQ2b8Y1OsscyWjuIRlz4ADJDEgOFXfYyHpq/iOhm/ncB/cdfE8SkdeUJlADb19S8khes8hK2sDfWoRipSD50J6CgYWihtsB9SHi84eEOe6u86GnJV5ON1d2JQj8ZdiYfcsfWogKNYHrdqAusxMTqgEIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jmg5Iieb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 084F9C4CEF5;
	Thu, 13 Nov 2025 21:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069557;
	bh=C4csfGdfNeHOg7jfqeEjQl6Bulh64hMoaHvrlk5FKAA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=jmg5IiebbdgBPY8z2RwxuPSafWicN/GLy9ZWnTLHGW3lj2ajr94KV8kpqNTnlgXGf
	 X0+VKM6ca3TrSNzmCnkSQGHSSK0q0slA3gcPpVvjtNHB4v0RWjPez95HsWIyIM+B7f
	 mTY6240FtHlxSAsUBivwORcT4Jr2ZedBgG+WedOmM5diEqBg5Gy2GcjMEemXW4Ch0v
	 Kw1WDXonx9c/jhsdJ4qlJiBtclAsDq23+NcmvkeEm6aaQpYezDrh9He2jo+vsdqYAo
	 tr73Gziwlz5Hhdsnh5rL+relChIaSNTdXQa2DFO/DiDllOBAddQKLmS8HFp1qqe7t+
	 K8QyOz5pMQOsQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:31:58 +0100
Subject: [PATCH v3 15/42] ovl: port ovl_permission() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-15-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1260; i=brauner@kernel.org;
 h=from:subject:message-id; bh=C4csfGdfNeHOg7jfqeEjQl6Bulh64hMoaHvrlk5FKAA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YXlr/TZee2V4sfImdUhu4/bqL5oFGGYXmi0iq3px
 BOhPxLBHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpXc7IcGu50sI7a4LUP9V0
 H2Eydt8ZVyuyLfOmu5DL3cjVlxcuPcrwP/fjpnTTikUHO792u1jyVBvOLrJxmH7t5sotS/i+xFx
 JYwAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 00e1a47116d4..dca96db19f81 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -295,7 +295,6 @@ int ovl_permission(struct mnt_idmap *idmap,
 	struct inode *upperinode = ovl_inode_upper(inode);
 	struct inode *realinode;
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	/* Careful in RCU walk mode */
@@ -313,17 +312,15 @@ int ovl_permission(struct mnt_idmap *idmap,
 	if (err)
 		return err;
 
-	old_cred = ovl_override_creds(inode->i_sb);
 	if (!upperinode &&
 	    !special_file(realinode->i_mode) && mask & MAY_WRITE) {
 		mask &= ~(MAY_WRITE | MAY_APPEND);
 		/* Make sure mounter can read file for copy up later */
 		mask |= MAY_READ;
 	}
-	err = inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
-	ovl_revert_creds(old_cred);
 
-	return err;
+	with_ovl_creds(inode->i_sb)
+		return inode_permission(mnt_idmap(realpath.mnt), realinode, mask);
 }
 
 static const char *ovl_get_link(struct dentry *dentry,

-- 
2.47.3



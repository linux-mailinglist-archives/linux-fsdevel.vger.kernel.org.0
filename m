Return-Path: <linux-fsdevel+bounces-68391-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D4FC5A33E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 636E14F509F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB832325721;
	Thu, 13 Nov 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OpgwtL3e"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA46325719;
	Thu, 13 Nov 2025 21:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069594; cv=none; b=t3OmvaajK9JnryVtnkikV+JMHRYsYOOwdtHuNqJWpa9mJnGJzPYua4xPKQGSUCq4SsvBIWSmawUPQRjGyLGP3WC3cIyE6FcvhLTwXk98R9g4FNqTR5ulLXouSa2ww9tmjXT4C2bN4sCj489HYUWHgcntCZfKQSGqVmNsXGzoRec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069594; c=relaxed/simple;
	bh=wROOG33U43JUlgpe6148WHoqeelDL3V/CsJrIyWaeG8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q3Hbg/9Wf73pcqw1I0Ci+AcrQw+3O+tXfoz8Vos8IY8puyN9tP5r6e7LGDw+h7MLPiOyIUtJuO9Ln6zi7qJoOpgkDy+1bbixP60y94sRYpL2Oo1W3wflOwezHoiniIfN66pkilX2GlW9OIJT5rZVQF+vZA7+oxpu+BhP0k6280Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OpgwtL3e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D615C4CEFB;
	Thu, 13 Nov 2025 21:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069593;
	bh=wROOG33U43JUlgpe6148WHoqeelDL3V/CsJrIyWaeG8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=OpgwtL3eEUNGlOZcwN/FrKb3alBkFfzYctNakj2tCNFI4jmcjfiWL3rkEeTkjarmd
	 dMsbxylTOLXmnJ8aVUAvRZ2INiqzbSauqF+S10gIPSJ7MfXuMeuvE4ZhfnTFTIB2g+
	 Kvpcxp7JqGFPv2DTP4SM5cblNtoOHS7GWw/OH8xlD6O4kLx70hi5SVCYFIcqNV4ovK
	 ESnFi7IN4yw1NFQQL1h6HAxrxMjA5pIrdjz9RzaQKAXoGvxkx2WXKI+407bYrMGM7J
	 StI3TwssT2NdYe5VV7JkHEaoSCLBLkI51UOLHWYMpkhR155A2QHX9VCnWkVXmbibEw
	 tzpWP9FkpYk8A==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:18 +0100
Subject: [PATCH v3 35/42] ovl: port ovl_rename() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-35-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1030; i=brauner@kernel.org;
 h=from:subject:message-id; bh=wROOG33U43JUlgpe6148WHoqeelDL3V/CsJrIyWaeG8=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+UU4FsyazaL4fGmw5/2uwICLba3ccvdv8c5qiFrsv
 m9b1gnJjlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIkc9GBk2PvfVu2ha1DK3xMz
 X2w97/no23XuL5k7IpkmzjjNdU+5J5jhr6zk9udGnB1f47ftcy5jfTbZyFzzpNL1pe3aBm8MFew
 28AAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 0812bb4ee4f6..0030f5a69d22 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1246,7 +1246,6 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	bool update_nlink = false;
 	bool is_dir = d_is_dir(old);
 	bool new_is_dir = d_is_dir(new);
-	const struct cred *old_cred = NULL;
 	struct ovl_renamedata ovlrd = {
 		.old_parent		= old->d_parent,
 		.old_dentry		= old,
@@ -1318,11 +1317,9 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 			goto out;
 	}
 
-	old_cred = ovl_override_creds(old->d_sb);
-
+	with_ovl_creds(old->d_sb)
 		err = do_ovl_rename(&ovlrd, &list);
 
-	ovl_revert_creds(old_cred);
 	if (update_nlink)
 		ovl_nlink_end(new);
 	else

-- 
2.47.3



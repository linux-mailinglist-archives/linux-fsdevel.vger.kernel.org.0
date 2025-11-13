Return-Path: <linux-fsdevel+bounces-68246-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B3DBC57899
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0948D4E2CDF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F52355022;
	Thu, 13 Nov 2025 13:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsMWsfHA"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7504350A1B;
	Thu, 13 Nov 2025 13:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039003; cv=none; b=oqZgzrmVdwpzXjJ/AtUWGO3aDPPXoHjhzfy4T/otkIMz+WUiD4dfVPwmxU5L4c0Dwfp0I+ilaPwqlXUDCMJAzGCAPykIZDiJwwli12PxR37MpsLBJN6OoidYZeypKIi5Jk8DLwDSm31h8+vgzVZKygBs7VAa8Q3NaM8+8Zfs29g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039003; c=relaxed/simple;
	bh=oOiVJIwPeXH6oy33VXMNMHkYOFgh2eu1mU4xj95xiCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tkkqUj/bce2Zbo5/yxDVkRYhEAxgEu9vmCniLyXX2gGFci7viD5Ieo6UiDHTRiWYqvuoFyCYIQLFemO7E2HGQqqdtLR66FxnSuqIcWIquwmWyA4BfWyKvXEyiTOGwaVzMBs/wb2A+vl+3xdl5WRpZHDry/fOelOnSL9CpT2Eh0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsMWsfHA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E765C19422;
	Thu, 13 Nov 2025 13:03:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039003;
	bh=oOiVJIwPeXH6oy33VXMNMHkYOFgh2eu1mU4xj95xiCQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BsMWsfHA17h+1+HTpweyIJwQkocPstmDxt9Ngy6+rZ5BnDVlOgFVz+ujVOAdU39BM
	 C63DJACcRcGCknW/XRwlZ7U7OexPqLy+7+z9IQHiQvQyQJEt3d3OVP01GTzc85cEyP
	 JcsXFH3splLblz7W6Q2vybQ235Mz5ZKVLGqqmFziDkqFmJkkqkDwRQWIu/fOrKRi5U
	 7ZzHT4IBFuPie8IV3V/KQv96+2aQh8kz4So5fXm/OK2mkfwDLHCQauPHjiSRe5hBwp
	 l0ZNzm8IhadB5akeHM7TM2h7fCZpKz0N+98sV9HdX6Fe4heeLJTck95QR6NoA5v5Jh
	 5MUDh9u8kKFPA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:49 +0100
Subject: [PATCH RFC 29/42] ovl: port ovl_nlink_start() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-29-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1254; i=brauner@kernel.org;
 h=from:subject:message-id; bh=oOiVJIwPeXH6oy33VXMNMHkYOFgh2eu1mU4xj95xiCQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnuSwiVTkH93xpEW4XXyIdH/b2gdOpHE80WtXeNMR
 93MIzFnO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbSeJyR4Sbnd/+5k02yQvy0
 O1TtbK9u6M9ut1prPTNg3lnjc8I8jowMd6ee0jLPmGTKMtfL6CGXfUF/2r2H3bZSB6QehznWdAp
 wAwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/util.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index f76672f2e686..2280980cb3c3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -1147,7 +1147,6 @@ static void ovl_cleanup_index(struct dentry *dentry)
 int ovl_nlink_start(struct dentry *dentry)
 {
 	struct inode *inode = d_inode(dentry);
-	const struct cred *old_cred;
 	int err;
 
 	if (WARN_ON(!inode))
@@ -1184,15 +1183,14 @@ int ovl_nlink_start(struct dentry *dentry)
 	if (d_is_dir(dentry) || !ovl_test_flag(OVL_INDEX, inode))
 		return 0;
 
-	old_cred = ovl_override_creds(dentry->d_sb);
 	/*
 	 * The overlay inode nlink should be incremented/decremented IFF the
 	 * upper operation succeeds, along with nlink change of upper inode.
 	 * Therefore, before link/unlink/rename, we store the union nlink
 	 * value relative to the upper inode nlink in an upper inode xattr.
 	 */
-	err = ovl_set_nlink_upper(dentry);
-	ovl_revert_creds(old_cred);
+	with_ovl_creds(dentry->d_sb)
+		err = ovl_set_nlink_upper(dentry);
 	if (err)
 		goto out_drop_write;
 

-- 
2.47.3



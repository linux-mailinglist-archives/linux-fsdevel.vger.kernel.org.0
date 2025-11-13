Return-Path: <linux-fsdevel+bounces-68373-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C3559C5A2AB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:41:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1679D4EBA8B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2966326D53;
	Thu, 13 Nov 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jh7K9lJE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD18324B32;
	Thu, 13 Nov 2025 21:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069561; cv=none; b=WTjb1RJ+hYNK7SitPL3zd3yiRqb/FIw/a2pDlHek7tcwbB5103kQEcfzjFpsWwJ0z/kJkKxaygbi5JCkUFy/BmhUpDmUOCwWk01TF1dxe8NkHnLCYMtR92KUDzJ4vPBkmj0RTNmZD8Fz5k1LTbe5JcdtBAefyjcxmkLf4o1plo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069561; c=relaxed/simple;
	bh=xR3sFH2D4S1Ty1W0iWziq6tLvi0ZWQFJXnHpfejcsVA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=avq2BLZpDv5IdMYKk4dIECQ+7m+3o/u1m8rc71OKb6YuWHcqgjYJp0f7dZj/OwFN49tiaIVW2JhYI2BHMSL2AKFT5SpPU10fPd4XbocLr06DCNX9IvbwWg+KIz6mmWb9SVQlA3Yg6VzHvPCR1KOJXy6dykNqDhBSg0QoZRmP67s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jh7K9lJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A791FC4CEF5;
	Thu, 13 Nov 2025 21:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069561;
	bh=xR3sFH2D4S1Ty1W0iWziq6tLvi0ZWQFJXnHpfejcsVA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Jh7K9lJE64mojUtlTS5v6eeAqmwcCgq9+eWcTWol2zlX2ufGhUSMmsHJX+fDEBIL0
	 HUhwNqNpd/ug5q/t/2L98K/oDYus6ERLC/MWzwI0u+1nB79Baj+9sfSx+Wlx5M+0et
	 p3ono1rJAePde7cax0uuKPWv9BcjsCH37CLGNesd1r2zLVxNV3ZCfRofMobefcslp+
	 vvm+SEjdGr3mQxpWrWne2ox6G9vabc80jJqnhxokBiI/IJJjzmnbO+V93lKhJwTzTp
	 agNTnP85m6Hb1z8AQGoG/m7NJLaXk16esmdqht9gNnsLpxp2vmggxBqtkLgLzSrIUo
	 txV16BHV0UzMA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:00 +0100
Subject: [PATCH v3 17/42] ovl: port do_ovl_get_acl() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-17-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=787; i=brauner@kernel.org;
 h=from:subject:message-id; bh=xR3sFH2D4S1Ty1W0iWziq6tLvi0ZWQFJXnHpfejcsVA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YXP1G2SX7s7dOMe4b8J2/1fTTwcIcq3QjxNMvncV
 r7CKTOud5SyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExkuwTDT0b+NlWxHdN+vPM8
 w68wvYdTbOa2YrbqWRMOnyrRuJKZxs/IcPjx6bOsy4oEtKYUGy94fjpYrdXy2vbMuA3T2lzuZ0z
 dxgkA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 3a35f9b125f4..1e74b3d9b7f3 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -461,11 +461,8 @@ struct posix_acl *do_ovl_get_acl(struct mnt_idmap *idmap,
 
 		acl = get_cached_acl_rcu(realinode, type);
 	} else {
-		const struct cred *old_cred;
-
-		old_cred = ovl_override_creds(inode->i_sb);
+		with_ovl_creds(inode->i_sb)
 			acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
-		ovl_revert_creds(old_cred);
 	}
 
 	return acl;

-- 
2.47.3



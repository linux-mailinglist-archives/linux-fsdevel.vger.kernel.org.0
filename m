Return-Path: <linux-fsdevel+bounces-68310-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2D2C59371
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B7B5506B52
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4635135A943;
	Thu, 13 Nov 2025 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pLJRv6NW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A294A35A153;
	Thu, 13 Nov 2025 16:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051881; cv=none; b=JNKOQjjHqEycdbtDhNmX4mJwdN3JPCwyM8VbxUKP6KwNobPJEvAEuphj9vtYfPsBf8/kseEwaUZq4CdBROJ6xBlRRYqHZUMIcivZDAk6Pea+s7E1sJzFj1mi5qqc3z9iK/jihp74cc0X0MBqzX9HyMDqwpzj3hEjbp2zSChu9jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051881; c=relaxed/simple;
	bh=GZOx6xsdBBcJPbjJE9TdIEiXaZgusc5fhE/lcLlr69E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QNywN9bo3l8+Xhj6B7UYY9uxmxwQBe3ZWE+hHHJTrvWdk3qOxA2v4eTb4jVrUbRgr1ZK3LcKv4C2jMaLyDVuP3B/7Xordq05HRhPerx7tGHJgKoIhkRiuMH5ph3uIrFJWBOBy/t6HQ7HT07VNrJO8WO2Pnbjf+ycR/x/VPVKsqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pLJRv6NW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F13FAC4CEF7;
	Thu, 13 Nov 2025 16:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051881;
	bh=GZOx6xsdBBcJPbjJE9TdIEiXaZgusc5fhE/lcLlr69E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=pLJRv6NW7CeR3SwPSkrNPWz/14FqlCKktRIS+SfuapkgcarI8kQE+rWL6ASsIGHMR
	 0BrmEBLqMSpA/C+gCPHwsTNxaPP42M+SJDN3knxtimzlT4ITA79sF3iLjT/ZSOKzg1
	 MJvpwNwOa28FQkP/M2H1iiBmszj4D0varWuaMueRBvPd16/xmX8S+8uCE5JkOLxkXf
	 5gxMFnmH6KJzSD9rt12NlcMSY70r4p4v983M83NIsqw0mUI/2CYusLljf4jlDiwMfQ
	 3Me46sKMAt3s+PUZVWsDd7pJt//t5Eq/cR76m96rzw3/AaQhGrnlEtOmlOOBRUdEcU
	 SPq0joc4f3Pqw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:22 +0100
Subject: [PATCH v2 17/42] ovl: port do_ovl_get_acl() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-17-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=737; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GZOx6xsdBBcJPbjJE9TdIEiXaZgusc5fhE/lcLlr69E=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbqtWXmkS5D3o5twzKrindl5RvdrNjxm5c98IhUkd
 UXLtOd1RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwER26DL805V+JqZSG5RYledx
 eGbJJMdSY9sJSS+i2+6+uWMTfJPrMcP/iqthigEuEyY9K7tvkej/4BITt8nbzD9KkwuETTZev5P
 GBgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

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



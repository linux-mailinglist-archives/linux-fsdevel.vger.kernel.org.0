Return-Path: <linux-fsdevel+bounces-68235-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DD821C578D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:07:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 65F4D356CA0
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160163546E5;
	Thu, 13 Nov 2025 13:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opDSfsNw"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7236E35292A;
	Thu, 13 Nov 2025 13:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038983; cv=none; b=SgpCVsN/0U8BH3KQi934HNmTHegDruM3p0DjyQ6ez0J0CmMQwzhCZ7X0+GHJ62JiaStvs4gLe6eI8o9oJLZG3caF7K7qtQzJlSsMh0g1PZfFkCxDHMW1c3annGXyCJC0Mmva9TpDuMA8koM+ig+zDW2Ocj1Q6acjirq52bhv49A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038983; c=relaxed/simple;
	bh=u+kRwotkhllnE2jX+ItQHodgpzGwaVB7S7Ar1CNLgPU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Tmk4YrBxDGfhh6rErHzfDmghq6GxB1odsWPeI0APRdyDltyAJT79vWOJO3bvpOBvG23fKmHyVN5Le1hJGXHyp5m/cjIhjjJ2yeyziw45wkq1m2EkjuwDRu3aPN5BUPcV1M6D7y0gQt7la/KtCGjKQI32yp81k+dzdZQ2rExrwkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opDSfsNw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13A3CC4CEF5;
	Thu, 13 Nov 2025 13:03:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038983;
	bh=u+kRwotkhllnE2jX+ItQHodgpzGwaVB7S7Ar1CNLgPU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=opDSfsNwTYci3XDYHmXJi5stqFHJLbD99VSFtof+r/eMESkzftNOrfnqH79W/5kw9
	 xNuyfMyGIx38zFiFK3C350VMmfuF2MhUs4jzZvC30vL8QV29mB31H3bRUBlu56AbKW
	 PSlXwG5eTfNAaL6RoUBbfXDa3x55Nu7uHRbRZzWhGGoVF7Ny2OO6AqzTUUeKLJlTWN
	 8OdHqIedrGM5wErzVl3kmowo5zM43GjutnfWf1mcpxNbPQ0lIDnKHl+b2lpJtlJZ1/
	 4ngf27NIzPFJ/Jt7AdpXOR5tutPVFJjC5Z1UjqJb6iCLSv1Qjd+veypk3q/oQu8+7q
	 c7MrrpJE/QyLw==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:38 +0100
Subject: [PATCH RFC 18/42] ovl: port do_ovl_get_acl() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-18-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=815; i=brauner@kernel.org;
 h=from:subject:message-id; bh=u+kRwotkhllnE2jX+ItQHodgpzGwaVB7S7Ar1CNLgPU=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnt8wH5zh8SSXt8rwlKcDqLpXeblW+U+PFSXW5/tW
 CWbIMnYUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMBHjOYwMs37kH900ueR0tNjr
 J8wWpvxVc7aUnH+uc27Tgzt/HnpPZGH47zft3eFrm3gmOq2UaDxyIob9bkPP/x71Okd9/lWeZ3/
 V8QEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

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
-		acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
-		ovl_revert_creds(old_cred);
+		with_ovl_creds(inode->i_sb)
+			acl = ovl_get_acl_path(&realpath, posix_acl_xattr_name(type), noperm);
 	}
 
 	return acl;

-- 
2.47.3



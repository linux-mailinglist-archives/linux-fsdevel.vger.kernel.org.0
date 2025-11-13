Return-Path: <linux-fsdevel+bounces-68385-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5C0C5A251
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:35:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CD03B9EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE11328628;
	Thu, 13 Nov 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ayaD/o7w"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D91328608;
	Thu, 13 Nov 2025 21:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069583; cv=none; b=WOO0Jh/v9ewh6pyMOYQvuN5eMc0TCvYyeW9YQFjIfWzEIEs0OsqLVsXEiZ2WpfHr2OAZHAwmTuNsYiqZFHi+uYYbARiQcArtq5c3aGPJ+nkmB0AHCJgiXldEZrKKwUwbn0QuV8LlUKaVCwZ6BGTpASlWWWKJ8ztSEldegTMgAY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069583; c=relaxed/simple;
	bh=v9EfvUjy/UZTOSxkY5Jk5IzQxKITiZRl2FR/498WhRA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aias5aV273GgQ+PWvsQp+hfBhXBVNdhVKVKYVLjPVJpWbetpbuC1WxLAE7MsngZP3uFpaBjy/qWqDVNlJtR4mXOA2UadoIYR1fekFf38sbtlcia8Lam5PNZyDB3E6784Yn9hjr/4W6LDLB/Atc8VUmIVnfKhq2UX7laCyTNCQl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayaD/o7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98809C4CEF7;
	Thu, 13 Nov 2025 21:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069582;
	bh=v9EfvUjy/UZTOSxkY5Jk5IzQxKITiZRl2FR/498WhRA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ayaD/o7wq7dbdeILBCKMx5HcDKreYDtVMF2z8O4PI6zswj98e/vEGPR0eZBPXFzkq
	 deFg6YUWOBjUpeRm53jg8ZDldnc4u6gTF37Rs82XT4wE+Qq2WeTzxMjg1uj1prxaFX
	 wzZHwqxjEJYibqd9lQOTeB/5X6IKvgAgCVP0gS9dXwKP72ihMAU1dQDPOQSM8roS1L
	 uU6B9qJPP32DM0m+7oaFQZ2u4K6PZ6HyBt7nsFnpkWYUo0NrOa0LW585RghvaCWLfM
	 fEIapiMi5Dp4USWfLyf9iKKZkqXWzRzbKMPZe7tIZtW72Ejw8fUBZoyRlmXuxlZ/t2
	 IZ9jSb9C+KlIA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:12 +0100
Subject: [PATCH v3 29/42] ovl: port ovl_nlink_end() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-29-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=772; i=brauner@kernel.org;
 h=from:subject:message-id; bh=v9EfvUjy/UZTOSxkY5Jk5IzQxKITiZRl2FR/498WhRA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YW/NxWduis0tfi/haXfkvYbmbuLN5XM74w0bCk2U
 tn60Fauo5SFQYyLQVZMkcWh3SRcbjlPxWajTA2YOaxMIEMYuDgFYCJ3kxkZXnsYdNvsWnZZ3LzO
 J9jHO7Fi/YZpju2nVm3pmqnRvOTuG0aGyftNFgn5GqYvLc3+vG6B9udL9b8tX687YGPW/+rtK4f
 TbAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
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



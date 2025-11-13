Return-Path: <linux-fsdevel+bounces-68239-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 5674EC578E7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D02AB357021
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76EC352943;
	Thu, 13 Nov 2025 13:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvUGEL+k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E99835293D;
	Thu, 13 Nov 2025 13:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038991; cv=none; b=nWQxgEAujalj71lmIqP5AGzC2xWgScVb/h8bv6azn9sH+atjAU+AhlUWXFZuVS9f5aNWvhzJxQxXzayIaXfIHXwwzEpoGGg/UoR0qXxXMGZoY6GKTS3Uqv6ELJ/N2xIz0gR0XWm73R8V9kNsevU3p1lOJf+m4xDPPyvFYOkxJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038991; c=relaxed/simple;
	bh=edFceTKkSHCrIUEukwgcy6v+n+B3UinxzCo8zKWCpJQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TjubZvc/+XbaDVVfUBHm4gHBh6BwMBXAKpRANfR5RuII5wufPaOZj4NKzMby576jOQU3J7jO6sE1jIWPxlGLMv4KfdDJ+K7F5j/GDNCQMKe9dUxqX/vJ0OaiqZEsl+H7/VE4j193YD2dbEV5y4Sm0BCpejhum222XBFRO1VoOQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvUGEL+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56346C4CEFB;
	Thu, 13 Nov 2025 13:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038990;
	bh=edFceTKkSHCrIUEukwgcy6v+n+B3UinxzCo8zKWCpJQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=TvUGEL+k0byhSpIkKIZv6ASWPfYjfPJyYHVatyPaUTc3cx44doEB0X1LCAFYkdA91
	 m6gnBDboJ/voYsZ0mm36RjszDoYaQeI6OoG39q7RBjLPb+TKcQdVQZVb7zpIxthZPb
	 tZINiYhTOEihp1M+xBXEqQKJ9HPfzzzaKP9CqR4j0Ev6E4hcm4hapTeANA65aiF25+
	 6v5hv0ZbSVI4/U5y3UvfcQKZIpLnYhNiObRUcjXVV7yfxfmi+i0Ghgrc4knwAMmHDv
	 vLbSzAVYx27x03X65qo0J8L4wiM6OZCpx34v+ES+pqK8SEmYQRnYQj9pQhZ2fKXuz9
	 1Q1O67VD6BJGg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:42 +0100
Subject: [PATCH RFC 22/42] ovl: port ovl_fileattr_get() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-22-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=brauner@kernel.org;
 h=from:subject:message-id; bh=edFceTKkSHCrIUEukwgcy6v+n+B3UinxzCo8zKWCpJQ=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvcbp0my/4pMcZk93Jzz/nqF4tXWZ1/fVqu7erMk
 Ou3vGu8O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACay5CAjw4q7l87WL8pYs3jV
 qqrPSzdqqn+M2x8c8qq4fr9Kkn2pfjMjw7knXYK1/PWpDpPmd+nuOn204fixi3/F5me0+sve162
 7yQoA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index 3a23eb038097..40671fcc6c4e 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -714,15 +714,13 @@ int ovl_fileattr_get(struct dentry *dentry, struct file_kattr *fa)
 {
 	struct inode *inode = d_inode(dentry);
 	struct path realpath;
-	const struct cred *old_cred;
 	int err;
 
 	ovl_path_real(dentry, &realpath);
 
-	old_cred = ovl_override_creds(inode->i_sb);
-	err = ovl_real_fileattr_get(&realpath, fa);
+	with_ovl_creds(inode->i_sb)
+		err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	ovl_revert_creds(old_cred);
 
 	return err;
 }

-- 
2.47.3



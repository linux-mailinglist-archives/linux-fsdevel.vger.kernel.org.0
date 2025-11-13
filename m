Return-Path: <linux-fsdevel+bounces-68249-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E1439C5790B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 317F235345C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FB19355035;
	Thu, 13 Nov 2025 13:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGAdIEU2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A36350A1C;
	Thu, 13 Nov 2025 13:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039009; cv=none; b=KQZq7AJ095chSXfapduhv59jTG8Ra5l5YeCAlaaHB79VU09L+gYiQjHtgnz96qWos45fGhB9f+Dtpro52MAVcUKUcR0wBcuc9Ff1xIlHOcJOufhkDE2FU2mlfYaZsARn72M/1Tn4q2099m2Rvz933JVDtFhnjS4WoLeniFcyc4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039009; c=relaxed/simple;
	bh=cqEH+zWyeNZgfbGwHI6sHc55SqFjreLR5rVR1+rHlxs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IWCAwAhbv+NAHkGIremXZP+OplfbD4BNP/0wf/iEb9W3Vk+JJQFN4NNP0s8WpGzBuTqrmM0oV+kbmDa7JFXPRWT/c7eryakOBok3ZD0Atx/OcfGGgagcY+X6V2cjek6NDBemDXHO/1VhffkTGnHFlbCORSj5vWU+85hosl5fQg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGAdIEU2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88398C116D0;
	Thu, 13 Nov 2025 13:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039008;
	bh=cqEH+zWyeNZgfbGwHI6sHc55SqFjreLR5rVR1+rHlxs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=YGAdIEU2A6O+0c8oXgo7ed0rqDYyb2uhVP6MLZ6TVV6ihbE1kzulsSel2rMuqtO4D
	 eBMeMR9O140W5LIfh+HqZH4RDp6d+HQcQ8Uhw6cpx2ZQAIGAzSeqhRHnR0xXmH0AFr
	 4s6oF1AmNAh5BQNxqf8zCfHYD/3n9wicJBH5V6CPjfJ7u681j81P4STTkxXuBoGu2u
	 UYmmdgQQoHO9UwMKaOwZifl/8Pl+YlfJ/lDLCVNadBGS9eNAzYqTTbY1ZwozHcSqHC
	 DIA/7qFpgcWHTXcoBFc6y0RwMn0DuC0/3gaIW9abf5K+2DHZ1nofMu2uP3A/dhWcqy
	 V7UAd7hn1+USg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:52 +0100
Subject: [PATCH RFC 32/42] ovl: port ovl_xattr_set() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-32-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1066; i=brauner@kernel.org;
 h=from:subject:message-id; bh=cqEH+zWyeNZgfbGwHI6sHc55SqFjreLR5rVR1+rHlxs=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnuyfY2bxEfNO9f/Kyd8Fl0QHrW4Y6bXpKUV7nVHD
 +1Yt3mbSEcpC4MYF4OsmCKLQ7tJuNxynorNRpkaMHNYmUCGMHBxCsBEjjgzMrybM2XXl4rEySsy
 BY3tmRwvbgvK9HRVO3rjyet7FWd+bdvH8FdEJnfl/p/OJbkxz1bM6nyl3M5uVKuWqJuc9DXk0XG
 WecwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

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



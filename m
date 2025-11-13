Return-Path: <linux-fsdevel+bounces-68259-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20221C5799B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:16:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DEDF421554
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311BA355810;
	Thu, 13 Nov 2025 13:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5pPUuhD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6B73557F9;
	Thu, 13 Nov 2025 13:03:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039026; cv=none; b=ti18krD5sWk7EQJvwzx6c5m6+gKFmA7muxNEgRdTKzRVzB1XT+SsnL5ZzNjQTAq4rs6OduKNivko1thqu7NWSQRs0U1FBoCB1Pvm+FzbVnJgv10VaYtqHoa1Xu3beVcrB1Sfxn/C2Pe1p6fMepmotMLtLUYzzwR2so1KwVZv3d4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039026; c=relaxed/simple;
	bh=IywD2BmQKvbf/BcUntmmS39gkpy8Qz7uVjWzUS+jG9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owkfmMDEZs539Xtd8yIcXuYQIZRGqjNvnUmyIpc32GATbVly61rLNHZUT/a3xBTSaSH9JnfRuobsSiK9Mendmril3n+Ax+oBsE4jEp5tVM6/+DP37MaERnlNzSP9WKY9AbIgCEEbgsPA9r9ok0WLnERvLZjkJCd9yVTtMHDdg50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5pPUuhD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FB2FC2BC86;
	Thu, 13 Nov 2025 13:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039026;
	bh=IywD2BmQKvbf/BcUntmmS39gkpy8Qz7uVjWzUS+jG9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Z5pPUuhDgWQldZU+ja3Ph+JpMtz/y+PqzV96Fl/05xrj6BCIkcLF9J5skb2cpZ3Ap
	 ZajIUxEWCSSeIKg/GS5usisFPW1HDfG9gC7hOLrVDkCst0MtyidWazPM+MSr+VX7WE
	 N1EqN6ndrnIAyl8pu+P1p4OcFDXpil1a2Nd9xxoP+ZES45/w9SL0LnXSF1N3xSo6y3
	 cFtnTzP/Flj9FKQLRnxwlUtuVQD6vHGnt/fzPcnLTWLsrSsQiQZm9f1XcMyBraWDOP
	 etKuLX77TCoQIbHvU/Ce41QiWFx6tdLYxNSUBsl1Vvl4iRImDelgHGpJydjuVUyD9W
	 4sAwE8IwZsexg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:02:02 +0100
Subject: [PATCH RFC 42/42] ovl: remove ovl_revert_creds()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-42-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IywD2BmQKvbf/BcUntmmS39gkpy8Qz7uVjWzUS+jG9o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnty80PvedE9D9YKBuz7J/ytfVdkyf8jalfOzK7rS
 3OuyxS/2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR5GqG/4UvX8knR17g6kjn
 XPYqc+qNN4mNDH982huPd5Ter9t1eR0jw5HPP1zO25et5pXZd+l0Qlir+5oLe5M3aE7iXeCuesr
 TjgUA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

The wrapper isn't needed anymore. Overlayfs completely relies on its
cleanup guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/overlayfs.h | 1 -
 fs/overlayfs/util.c      | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/fs/overlayfs/overlayfs.h b/fs/overlayfs/overlayfs.h
index eeace590ba57..41a3c0e9595b 100644
--- a/fs/overlayfs/overlayfs.h
+++ b/fs/overlayfs/overlayfs.h
@@ -437,7 +437,6 @@ int ovl_want_write(struct dentry *dentry);
 void ovl_drop_write(struct dentry *dentry);
 struct dentry *ovl_workdir(struct dentry *dentry);
 const struct cred *ovl_override_creds(struct super_block *sb);
-void ovl_revert_creds(const struct cred *old_cred);
 
 EXTEND_CLASS(override_creds, _ovl, ovl_override_creds(sb), struct super_block *sb)
 
diff --git a/fs/overlayfs/util.c b/fs/overlayfs/util.c
index e2f2e0d17f0b..dc521f53d7a3 100644
--- a/fs/overlayfs/util.c
+++ b/fs/overlayfs/util.c
@@ -69,11 +69,6 @@ const struct cred *ovl_override_creds(struct super_block *sb)
 	return override_creds(ofs->creator_cred);
 }
 
-void ovl_revert_creds(const struct cred *old_cred)
-{
-	revert_creds(old_cred);
-}
-
 /*
  * Check if underlying fs supports file handles and try to determine encoding
  * type, in order to deduce maximum inode number used by fs.

-- 
2.47.3



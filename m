Return-Path: <linux-fsdevel+bounces-68377-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A12CEC5A2B4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:41:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B3EC24F2838
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 21:34:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB043271E2;
	Thu, 13 Nov 2025 21:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g3lgHdg2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF07324B36;
	Thu, 13 Nov 2025 21:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763069568; cv=none; b=H2ADORxtljreq3/s9LAT3rjub7uD96UGwbkiDrnrZzSkkGFnb40i/MaWTB+ByFkC+TJPs6Xkt79SjNojrofK05GE7RE3/6LJFb9eSNPotU0x0fhtnitKOkp4MfeGAoY+07GLWqMXUOULZKH6tqrMOGj3M9mesq4Oy17A2d33Nwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763069568; c=relaxed/simple;
	bh=U7fo1b25mcxC7193uxI6I2izgbqi0wn9lOUyo/GnAtc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=F0rywVSSCXwooU8TRgxacEBk/b80i97U2bjg2QnMU6qfe/YFTBwC2Kyrp6nwSCcf+BuafPyorLsX82DxetVMvo6uBAE+D1IOOgbxeT4YIS2qlZwcFfQpGK0pjMHPKBsPITj6PSi8Zy7rUjcNDG2vFOlmcmHTXdZhEJ1k/TpKlOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g3lgHdg2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25303C4CEF7;
	Thu, 13 Nov 2025 21:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763069568;
	bh=U7fo1b25mcxC7193uxI6I2izgbqi0wn9lOUyo/GnAtc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g3lgHdg2W+DZN6M4r6hPv8EilsGSZS0TMwWdLCFDydzjH3VRH9Y0cJ+qcmsUQGTEk
	 AzWZWHnNLC2Gkbsb+3XjggtBe9hPYYnp9GuSeUkD5Q0zfcIMUzJ9RppPg58SY7pt5b
	 zJzczK8s1xe2HjnNCJhbTU1ulOWRxvszys6MdVw2cpAxbmERMf6essU+66mMQa4eqx
	 dslGxY57SFtrrlGLfx2ALiMZOlc7mNdJbYdEesmu+xeCRfB33iBkOXx7OP96/m1GbB
	 TGe5XW5fUccDddWkXX0acyBj1LAsyO9HK080bboWm4rpKN1hgbtTy/B2XJJF1Ufhhx
	 rpHZLUWTlV8kg==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 22:32:04 +0100
Subject: [PATCH v3 21/42] ovl: port ovl_fileattr_get() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v3-21-b35ec983efc1@kernel.org>
References: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v3-0-b35ec983efc1@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=863; i=brauner@kernel.org;
 h=from:subject:message-id; bh=U7fo1b25mcxC7193uxI6I2izgbqi0wn9lOUyo/GnAtc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSK+YVvXu6lX7lDfEPu5GPf3TZ1Hm+P2XzIu2LGHWtGa
 X8n73tNHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABPZuZ3hf/rzLfUT+fedfPDu
 0H+pkJ4ygdhPliec/zULPrcp3Zf3qZnhf8HdHzscd4apbJ2m9OJlwKUzO+6t+pCu+pXXuiDJs6d
 zHz8A
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

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
+	with_ovl_creds(inode->i_sb)
 		err = ovl_real_fileattr_get(&realpath, fa);
 	ovl_fileattr_prot_flags(inode, fa);
-	ovl_revert_creds(old_cred);
 
 	return err;
 }

-- 
2.47.3



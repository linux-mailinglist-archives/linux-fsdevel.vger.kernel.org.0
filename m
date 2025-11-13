Return-Path: <linux-fsdevel+bounces-68334-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 828D9C58E59
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 17:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 005CF506641
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:47:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B24636997D;
	Thu, 13 Nov 2025 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNcEkNpq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A70035A958;
	Thu, 13 Nov 2025 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051925; cv=none; b=WCgmiuICjd23TAZuQtrOhe+1b1pYvr8kjmAulmGZjeQTlxI2uVZnzml2UDMUb0PCEUKoRAtGc38u33FiokVwq+M5/UG1LmiqWAQi2xza0Jl+tHVH8ionYvOOXAZCu+OXYAPfybN/uhY+UHSAN7PHE4cHp4pXgfDWf3PzM6QjTPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051925; c=relaxed/simple;
	bh=IywD2BmQKvbf/BcUntmmS39gkpy8Qz7uVjWzUS+jG9o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RVE+fswAVmkoojCJy4o8rpQF9qJcBNtXOE0A4+7ZBTWRoGBL7QqDN7xX+MPjwtXygpzxqxuPLSTIC8PFrVqDscrMJiwKQOvapN4z4MiOEP4bapGksuYypfdr3A7/VFlYhasp5YkyILTNdh4mDxfC8783HKg4+4/iFEx8Yx2O5hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNcEkNpq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5AAAC4CEF7;
	Thu, 13 Nov 2025 16:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051925;
	bh=IywD2BmQKvbf/BcUntmmS39gkpy8Qz7uVjWzUS+jG9o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ZNcEkNpqUv5K1zmtwn219mm+IudUiZH0oZxkLlI/uIiprWLIe+smepfN9cTczI1RH
	 3CZbcrgJxZk2eio2b2smtT4PqKkGjfGoKp+YTKoNCQy/zFCfT8xEEI3qQQYm+A7trr
	 YOkTxaUoeAY4m1K+GUhCMorKbKj8RuUuvAqoL1SExiQj1h3enopzw8DLTt6r30+aDI
	 JYwOEVBFxOjACZ23cAcPQnUSRcgke+IDF5IOPbwtfsHE00+0FWtOa2LPbv11XJ+pb0
	 sBhF9sim82BYgf2ZiX+eim0f4yonxwyo1qhYqWWR46HnL7kGInfXHd213SeOBxi2oc
	 xU/vi3JWPMwrA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:46 +0100
Subject: [PATCH v2 41/42] ovl: remove ovl_revert_creds()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-41-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1337; i=brauner@kernel.org;
 h=from:subject:message-id; bh=IywD2BmQKvbf/BcUntmmS39gkpy8Qz7uVjWzUS+jG9o=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcXpYGxesnN7uu3T209lTvi2Z86ap+/KdxO08mR7LV
 2esjzC92FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCR/72MDBf//f7umS66REzo
 6NOGhHY1lcruDfxmcnxOhg0LmXaFGTMyHM04eMDqm9fnXvmH4hPWp2jsPpuz863x3OTFPVEpm/W
 2sgMA
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



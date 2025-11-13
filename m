Return-Path: <linux-fsdevel+bounces-68309-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E58F2C591A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 18:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 19546563532
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 16:46:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4997E364033;
	Thu, 13 Nov 2025 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SRZcepAo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D23135A933;
	Thu, 13 Nov 2025 16:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051879; cv=none; b=XCZMf8YpadmegGppIUGhN0rrFeOYxPfREIe3PQ3KpfeLnqg0nPV0SUDALjDMyOlawWOxVrw2eX/I8qpRRy9/UkifzNitQmuwFrRIIgAEVtDnrkK/4lBz47GaOQV/qJ/LLPtyjk4bKRf9rWe/lQL8M/pUdcsb8+o60puOdstSEP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051879; c=relaxed/simple;
	bh=qDyOOnsKgjDMJECVSKZHFCLTntFUXNRakxJ39KMrkIw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KApG5LABA1Y9Sj6AP5zxYAJB8XO3cnZeVA8o6vH787HdukN9ku8GFvuseQj3ibKZYomshVsmaEoOz+yGZmIbcHiOJy8S4wkrcGIFzNdyOLdySi0mxgR46DsRShdl/aAGJcLz4CMLyhzyppTym/3QDzFPyPc30ilZP5QNMUPC+qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SRZcepAo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AC6C4CEF1;
	Thu, 13 Nov 2025 16:37:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763051879;
	bh=qDyOOnsKgjDMJECVSKZHFCLTntFUXNRakxJ39KMrkIw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SRZcepAo8mCF7wjR35xhT3fyvut6J42TPMa2+0V7T0YYXpfZ4L0YnYOC1VnkxGaou
	 Mca29Y36mpj56G9KxfStdVZ8+o5RhH0wPm1uPTDdipHHtIHDcL0vKpbc74g5f8IU4k
	 AbYs9PW94q5F3tbz1O2FDCwVZb9bGbMMsklw0tLYfNlnTxnyWWLQ0ZLlqyHZShd3ah
	 ne3V+4Ujtu3jU3guBiARqJemTT1z/XXHTji0/576lJIecnjjl8siz4S4sa/vxw+FRT
	 B4BMkWZLBV6FG/gV28S7lqQzm8dT4bOSeIAlT0tmkN70aI0rnYtJlv+R3HdsIL2ZYt
	 p6eNKbGUCU/dQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 17:37:21 +0100
Subject: [PATCH v2 16/42] ovl: port ovl_get_link() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v2-16-c08940095e90@kernel.org>
References: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v2-0-c08940095e90@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=864; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qDyOOnsKgjDMJECVSKZHFCLTntFUXNRakxJ39KMrkIw=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKcbpl7E2xPOrP9MSOYycPu4+q8RPxl5OU9kxfc/yWs
 8WBB0ZnO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACby9Scjw/s15a5in7PKK1Sb
 1hyd1d1jOztOaI8DV94GnrNL4h+z3GFkuKAk5bF6Zao444LJ0/O3BbzW1u/8c++akfoTxUc6HxX
 38gMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/inode.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/inode.c b/fs/overlayfs/inode.c
index dca96db19f81..3a35f9b125f4 100644
--- a/fs/overlayfs/inode.c
+++ b/fs/overlayfs/inode.c
@@ -327,16 +327,11 @@ static const char *ovl_get_link(struct dentry *dentry,
 				struct inode *inode,
 				struct delayed_call *done)
 {
-	const struct cred *old_cred;
-	const char *p;
-
 	if (!dentry)
 		return ERR_PTR(-ECHILD);
 
-	old_cred = ovl_override_creds(dentry->d_sb);
-	p = vfs_get_link(ovl_dentry_real(dentry), done);
-	ovl_revert_creds(old_cred);
-	return p;
+	with_ovl_creds(dentry->d_sb)
+		return vfs_get_link(ovl_dentry_real(dentry), done);
 }
 
 #ifdef CONFIG_FS_POSIX_ACL

-- 
2.47.3



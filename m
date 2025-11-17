Return-Path: <linux-fsdevel+bounces-68691-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 50103C634FC
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9FA1E4F19BA
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:40:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD462328608;
	Mon, 17 Nov 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHnus+BP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26CF332ED46;
	Mon, 17 Nov 2025 09:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372113; cv=none; b=cVw5BWtnQhfQZyVo9SsAzLA2mQv5+0m0+UBPGsQBwAt5c6M7iYfKdEswTyqFeWhDcskeAgaU1uYx809yV+3B4P02l7ZoHLvR2/lVDPfpnUbukveR5mV9hQ3v9HynPECTT/cEvvrvcRgElJSpFqRyDVxCeyQzU6MH8aHyBTO/Frs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372113; c=relaxed/simple;
	bh=GukGVQEuunUOFjYxbzYAASC5HHKCZserK7xuVBJ6JGE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=q03h/iGhZawbZOCPgsVc8uUjdYvsfetsrUOJEy7kv/Rerx9/zhyhGlJK8Y5azODk9Z6Bu5HT/rc7W42ObAXxAR3t2kH6ouI2GY0TZM8gTw1aVdohqh3NwE3MQai2PxlJcoi06yzdZmcpQ+PMDHgBFskQsbZex82Mk+90zw5xm0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHnus+BP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37720C19422;
	Mon, 17 Nov 2025 09:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372112;
	bh=GukGVQEuunUOFjYxbzYAASC5HHKCZserK7xuVBJ6JGE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gHnus+BPppz5pbnot0yyl854GYAIrUgnGWvlOvd8lbwEAdVr9YNwrgpnCoIiCi9BB
	 DRXGRyxRkULBCJF7tEppvijt5RVfXmxhPi6Cao34EHCPLjUxQDlYFoTlDMdFR25mdF
	 r7MqepZM4sgUAK59vQmQNAVv9lukUr7Gdaz1iV7mjC/Y5A5A3f2yRingfDJizo0J1z
	 I0/mp8K0umKvp5El2Aj0LhfHCePAhfp6tl1Z52NRR/M5+s3OVMNpt8HmXyc21dAqsT
	 PyUOYtOWAJBdN4i+Rzgo4uhyiGhYt6U8MH6eg1CyRp/mfKXMx9s5A/ARyaLZewpeLe
	 Euz3/yzteP9Gw==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:42 +0100
Subject: [PATCH v2 5/6] ovl: port ovl_create_or_link() to new
 ovl_override_creator_creds cleanup guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-prepare-v2-5-bd1c97a36d7b@kernel.org>
References: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-prepare-v2-0-bd1c97a36d7b@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1441; i=brauner@kernel.org;
 h=from:subject:message-id; bh=GukGVQEuunUOFjYxbzYAASC5HHKCZserK7xuVBJ6JGE=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvXFlbmz71Gv++fZ0J+cHHXyM4j1txnoB3o2ap298T
 Lv4uuNmRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwERsfjP8r1yk6C+XZ9X3LI6X
 VyFg6YpZSWIybFY/fb+4202qt29ezPBPi//IfUv7G3VGx7dfzzu+Rjh9Xi3TgwNV8aZewR5rJ+U
 zAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

This clearly indicates the double-credential override and makes the code
a lot easier to grasp with one glance.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index 1bb311a25303..cb474b649ed2 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -657,10 +657,9 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 			      struct ovl_cattr *attr, bool origin)
 {
 	int err;
-	const struct cred *new_cred __free(put_cred) = NULL;
 	struct dentry *parent = dentry->d_parent;
 
-	scoped_class(override_creds_ovl, old_cred, dentry->d_sb) {
+	with_ovl_creds(dentry->d_sb) {
 		/*
 		 * When linking a file with copy up origin into a new parent, mark the
 		 * new parent dir "impure".
@@ -688,12 +687,12 @@ static int ovl_create_or_link(struct dentry *dentry, struct inode *inode,
 		if (attr->hardlink)
 			return do_ovl_create_or_link(dentry, inode, attr);
 
-		new_cred = ovl_setup_cred_for_create(dentry, inode, attr->mode, old_cred);
-		if (IS_ERR(new_cred))
-			return PTR_ERR(new_cred);
-
+		scoped_class(ovl_override_creator_creds, cred, dentry, inode, attr->mode) {
+			if (IS_ERR(cred))
+				return PTR_ERR(cred);
 			return do_ovl_create_or_link(dentry, inode, attr);
 		}
+	}
 	return err;
 }
 

-- 
2.47.3



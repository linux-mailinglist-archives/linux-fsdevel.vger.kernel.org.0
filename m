Return-Path: <linux-fsdevel+bounces-52120-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E55A7ADF819
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 22:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36E6A188D7ED
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 20:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30B0921CA13;
	Wed, 18 Jun 2025 20:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqkHUxGN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9190821ABB0
	for <linux-fsdevel@vger.kernel.org>; Wed, 18 Jun 2025 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750280036; cv=none; b=YVOibZu9BPozVqCRP7UOWqGKm4O3Aqamkre5sXT0lrkysMmq7iq6FNZ4tzALBa6CSbL5Xa6yLHkmF1ECtKC7XO2MyaxzCTHdD5/BEhF2nbAbSkf5F62Wat/JDRXDtS27N4rDj8rX97bbhfLNdlc66MSyOpbMuRiAn0eIDTvv5sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750280036; c=relaxed/simple;
	bh=NXQv5PDrsqWdi+F9oAXhe0/iW0IsEM4U6LZj4q/oN88=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CG7xQWBUEdRCLFVKKCpBL4gpkA4/S2VgHr7SEvF1mcwVyiPI96klpdRf7zwg/kM8Vlg7cSHnO4IkOgDv525Zfl+2UnaKBbT0XsMO0wqGpBdV+i9CI9mR2WbAN+soRRT5sOCrrQ3LYVqsDv8dzuEDXOJPbdLHJmwxddL42+8h2XE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqkHUxGN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1535FC4CEED;
	Wed, 18 Jun 2025 20:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750280036;
	bh=NXQv5PDrsqWdi+F9oAXhe0/iW0IsEM4U6LZj4q/oN88=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=mqkHUxGNzYrgl2Kk4xLwZFhEG/lFEjDRzH8nN+EWkNZYlcfaSEg9fTyZj1FtfJwJX
	 OFLSOJ2jrPEwN6qeaxA8WNr6HJ0XMnjjf5b/yyRSM9oCb3eaGm9rYT0FT4fM5Qvk1j
	 zNJiDC+XGzNeylrITJfnk2bJ/jABEb49DNPO3rbSn6veNJDvihITQuC1EBG5FIJT/K
	 nyQAP/tfHcPfnHm4u5OBOO6uVIcnq1pnO2dl6sLoWcQfGTk0KRneps4G/Zj+IHKEom
	 667AHuV+fBeh5iVQwUf0PWeKr2WsuvSvtLeDep2EFGYPdwOltcPKY5JW4cDlBI6rNg
	 Vbs7+qeS/KzRQ==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 18 Jun 2025 22:53:37 +0200
Subject: [PATCH v2 03/16] libfs: massage path_from_stashed()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250618-work-pidfs-persistent-v2-3-98f3456fd552@kernel.org>
References: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
In-Reply-To: <20250618-work-pidfs-persistent-v2-0-98f3456fd552@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Jann Horn <jannh@google.com>, Josef Bacik <josef@toxicpanda.com>, 
 Jeff Layton <jlayton@kernel.org>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
 Lennart Poettering <lennart@poettering.net>, Mike Yuan <me@yhndnzj.com>, 
 =?utf-8?q?Zbigniew_J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>, 
 Christian Brauner <brauner@kernel.org>, 
 Alexander Mikhalitsyn <alexander@mihalicyn.com>
X-Mailer: b4 0.15-dev-262a7
X-Developer-Signature: v=1; a=openpgp-sha256; l=1180; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NXQv5PDrsqWdi+F9oAXhe0/iW0IsEM4U6LZj4q/oN88=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQEq0eynIq5y1F5YWO91tPpGZVGs9WFfyivldkgJ3KBf
 fqNfcKhHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMxYmVkePbjw/+fJZe1v6Sn
 7Dm4vk/DcOaLHYsPvNlznuGl7LF7t7IY/keLB4uyr9XniozQ3env+MlJTe7NOs/87x8zXLMOLb2
 8kwMA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Make it a littler easier to follow.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/libfs.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/libfs.c b/fs/libfs.c
index 3541e22c87b5..997d3a363ce6 100644
--- a/fs/libfs.c
+++ b/fs/libfs.c
@@ -2227,9 +2227,8 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 	if (IS_ERR(res))
 		return PTR_ERR(res);
 	if (res) {
-		path->dentry = res;
 		sops->put_data(data);
-		goto out_path;
+		goto make_path;
 	}
 
 	/* Allocate a new dentry. */
@@ -2246,15 +2245,14 @@ int path_from_stashed(struct dentry **stashed, struct vfsmount *mnt, void *data,
 		dput(dentry);
 		return PTR_ERR(res);
 	}
-	path->dentry = res;
-	/* A dentry was reused. */
 	if (res != dentry)
 		dput(dentry);
 
-out_path:
-	WARN_ON_ONCE(path->dentry->d_fsdata != stashed);
-	WARN_ON_ONCE(d_inode(path->dentry)->i_private != data);
+make_path:
+	path->dentry = res;
 	path->mnt = mntget(mnt);
+	VFS_WARN_ON_ONCE(path->dentry->d_fsdata != stashed);
+	VFS_WARN_ON_ONCE(d_inode(path->dentry)->i_private != data);
 	return 0;
 }
 

-- 
2.47.2



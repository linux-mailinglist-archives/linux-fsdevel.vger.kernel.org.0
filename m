Return-Path: <linux-fsdevel+bounces-68679-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AEFCAC634CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6EB044F3C34
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F043329C75;
	Mon, 17 Nov 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m+Ep0hSt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A51A329E55;
	Mon, 17 Nov 2025 09:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372090; cv=none; b=Qt9spw8G872sXwvY061fsH4vYv+twy8XObAy44sV1mXzTAOMFnsWfnFlS9O0zqusTs4IyFq/Gjnh6DTq+GCdmtSe3H1NyohiUrVPoTxbq4wcYoyIhkyNCKx+uSpOiv9LujTEc4j0hEJ/K5Z3jBlF5hqtbXULQyv+HeRfPl9Q9Hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372090; c=relaxed/simple;
	bh=qEiuZFar8su1vEVGKLVaGY/c4g2PHTw+N1qsYxoX2mA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I+OZtBWYcMfCV7UyKLLhkLTlsU5Itn3ZOttBIcgT+MePUrQq+xSHOsZtVExnozB25Y5ppZLuv4UdaErbL7fuFRkdR2qZ1Amb9ng5RnHVcLqFjONFaxdEDr60ZqB39WALLMETnKrhpvfHTeEgmMyq9dQ9g2ILvT4dTZIhEs/5MNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m+Ep0hSt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48339C4CEF1;
	Mon, 17 Nov 2025 09:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372087;
	bh=qEiuZFar8su1vEVGKLVaGY/c4g2PHTw+N1qsYxoX2mA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=m+Ep0hStIZUFe/eZ8NdjQIIl4/tnNxXR4B7Vftsqr1ZAS0cH33YJh8/fjkBjIvhqw
	 EExLq6FVYB1bPIjEGCBbCL00NOJlA2+oxUTDj9u8oq3XNzkFaEICj3zrB5YOX/zvrN
	 eS91V2KooaOBiZNMEtu/By5n1Va4Qj7Zq/2R863gamJbuGxpwqNGAVWtawTqOjTH62
	 W8BptYjgzyb2tnBhrET+/d36gV+up5nh9CuAkHp67MsA+EwpvCyprc5jFjce4MkdtI
	 bVTh6jxEQrbcp357eqD5u2ibpvyXY9NGnTegYlxelmaKie2QOWdjCGWtH9J4iD7Jb0
	 MVjQwskDwBvmQ==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:34:06 +0100
Subject: [PATCH v4 35/42] ovl: port ovl_rename() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-35-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1054; i=brauner@kernel.org;
 h=from:subject:message-id; bh=qEiuZFar8su1vEVGKLVaGY/c4g2PHTw+N1qsYxoX2mA=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf52z/fIm/bT7Oz26YveO7erd01/b8l1+sGx6caq+
 rc+X+Yy7yhlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZjIox6G/45/54e+zru9YWnM
 /t11wQwHT75k88kJvvnD8KTY/QYz9+uMDFvmlSwI0PZ8xMLN+KqFcaHgU681R1ffPV3gnlc3YYm
 iEicA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/dir.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/overlayfs/dir.c b/fs/overlayfs/dir.c
index b0e619a9b004..4fd6ddd6f4ef 100644
--- a/fs/overlayfs/dir.c
+++ b/fs/overlayfs/dir.c
@@ -1321,7 +1321,6 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 		      struct dentry *old, struct inode *newdir,
 		      struct dentry *new, unsigned int flags)
 {
-	const struct cred *old_cred = NULL;
 	struct ovl_renamedata ovlrd = {
 		.old_parent		= old->d_parent,
 		.old_dentry		= old,
@@ -1337,11 +1336,9 @@ static int ovl_rename(struct mnt_idmap *idmap, struct inode *olddir,
 	if (err)
 		goto out;
 
-	old_cred = ovl_override_creds(old->d_sb);
-
+	with_ovl_creds(old->d_sb)
 		err = ovl_rename_upper(&ovlrd, &list);
 
-	ovl_revert_creds(old_cred);
 	ovl_rename_end(&ovlrd);
 out:
 	dput(ovlrd.new_upper);

-- 
2.47.3



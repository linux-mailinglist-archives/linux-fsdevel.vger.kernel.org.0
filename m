Return-Path: <linux-fsdevel+bounces-68226-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA5EC5793B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:13:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB1A3A6885
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:04:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39AAC352956;
	Thu, 13 Nov 2025 13:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2+uLne0"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941E5352FB2;
	Thu, 13 Nov 2025 13:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763038968; cv=none; b=mGXk+JE2jhbHmm1554qwW2U0ZresBbMAhklHkw2OeJt9WGjkUBrBGzOdJ/Va25P3NAvhq0OmHN7kYVGQa326ORb4IF0tXq9tY5C3oNeNDXbB3LrsgfIsXDuUprFspap+XrF3C1/ENkKDGnUrO3A949JEz0cx67LOhBX85Kkh0CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763038968; c=relaxed/simple;
	bh=gJMZ7FuJyEsQkEVnFZtKPZqq8C/tXf/mvq74fsIIrCo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pgcZ/sujrYT9VQucR4uVagw6GDj3unMWrnMqsdReB5D2EQizMrrEJmzHSo2KBaL9vn6ladvIA6t87KGXX5dhdV3PrF26Rv8I4Vxa28Lu4P2cFjxBZnJMz4/mipQS0HPjrTd6R8Okn0ASPwQ7L1ujPYEP4PNdIggINPN7+a+IpDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2+uLne0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 007C1C4CEF1;
	Thu, 13 Nov 2025 13:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763038967;
	bh=gJMZ7FuJyEsQkEVnFZtKPZqq8C/tXf/mvq74fsIIrCo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i2+uLne0s/mmu+cXl4SRzpIz/jJizf+8NLSzYl5wxmXTMp+A2nNxa6P2px6Pwz641
	 /FsB5Lr8jKqoYHdDZ5oZqwp8jE+4NHqXuEbQD0TMlY2rtMMhFwzpdiJVubt1NN2xGu
	 8XfMr2ZoWv1ksKu6R6Q+VDinSnhqKBgl1LP8yegx6+5QUojKVnFExTBSfyx0ISsVPV
	 9vRSWmyFkMdpOcUcDlECks16OfVNii7wPNnuDybk+42f1+m7rkp6BIHEFHEWV4hxcV
	 5cktRIXbaVzL8n8NuCW8m8rpcXQWtHlpidJo4OZSWSpxElh1/svEjNwOgps/TS5eGG
	 aYr/We8zTn1DQ==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:29 +0100
Subject: [PATCH RFC 09/42] ovl: port ovl_fsync() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-9-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1141; i=brauner@kernel.org;
 h=from:subject:message-id; bh=gJMZ7FuJyEsQkEVnFZtKPZqq8C/tXf/mvq74fsIIrCo=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnvkZXFt+0npisjO3OATUkuTW8wynrZ4beZdwbA6J
 tb7kbV0RykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQMvRgZpop9TV/ztNq1u/D2
 Y8a1pc3JZm517rKPwhWO1V3eU/qekZFhTeoki+XPZwuF1Bx5WjdJ8LXmnSV7Zn94ErPh3Y8YJ/a
 rPAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e713f27d70aa..6c5aa74f63ec 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -446,7 +446,6 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	enum ovl_path_type type;
 	struct path upperpath;
 	struct file *upperfile;
-	const struct cred *old_cred;
 	int ret;
 
 	ret = ovl_sync_status(OVL_FS(file_inode(file)->i_sb));
@@ -463,11 +462,8 @@ static int ovl_fsync(struct file *file, loff_t start, loff_t end, int datasync)
 	if (IS_ERR(upperfile))
 		return PTR_ERR(upperfile);
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fsync_range(upperfile, start, end, datasync);
-	ovl_revert_creds(old_cred);
-
-	return ret;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return vfs_fsync_range(upperfile, start, end, datasync);
 }
 
 static int ovl_mmap(struct file *file, struct vm_area_struct *vma)

-- 
2.47.3



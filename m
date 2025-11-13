Return-Path: <linux-fsdevel+bounces-68253-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E239FC57974
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 14:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F3B3A4C40
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 13:06:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC5C335293A;
	Thu, 13 Nov 2025 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hLIvHk1h"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2313B34D91E;
	Thu, 13 Nov 2025 13:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763039016; cv=none; b=lXfKXiOJjSdbmIppJb/nJlVg316BPyLN9aAJVOpA2AgSLkRT2GxwNdlul9M8ENgDCnc9OQpx27liaqHL3XiqHgfst8WZqfwg+UCx0gO9V+9d5FY1ALJdTwFvxtbo2YMlBNq5S3SVWrO8PYePs4EJUqpXWrXK0o+FEjMrRHGtUsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763039016; c=relaxed/simple;
	bh=470djjlZ2/Jz+9hZZClKQ3Ly8ft0Ex7xWfPNPpOI71A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FSTVd5SPQkiUpKXN3Nb6Aqr48P2834fasM3ZVJbv/AmflmlpF3yxdHxt4f6wK5bCUg/t9juAulLu3L2HUC04nVWw1DCLxg9uGKMda+y7DaFlbfMbFJc0KjvRz0vkmcHJ1ucgIm99rLnbZjbVBrMAD7dsM69LPoRIsUf203d123Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hLIvHk1h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC497C4CEF8;
	Thu, 13 Nov 2025 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763039016;
	bh=470djjlZ2/Jz+9hZZClKQ3Ly8ft0Ex7xWfPNPpOI71A=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hLIvHk1hgqhQ9NDnXLGS9mZULEaoqbOh1QQeNONSw+kEzkx/C3ZBubAuCbSYbda1E
	 ASGd9GM5tqFoFvY7SFDYmvS0/vrR32Bl+90Usw6yDC+izLLjQmJpvrwxHsy+VoznGH
	 wbNfmXS23kRYi4h8AUJ6/nuFHebCpXc6LdAkXQGvX9sqHNZU0DN1ynUvnxtnBpW3Q4
	 PtSUEIumpobDHN5l1ewpdO9RcuxlmYBN0138yEbD/tXzcm2B7F/2LLk1ikjSQXR/bs
	 FCAs9QEnYTNryyMADATcs5roGfaJAmD+pxv97SpomYrwrR1ftZwhgHRegLGQ1kFoaL
	 0hYuPHqiYHlDA==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 13 Nov 2025 14:01:56 +0100
Subject: [PATCH RFC 36/42] ovl: port ovl_copyfile() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251113-work-ovl-cred-guard-v1-36-fa9887f17061@kernel.org>
References: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
In-Reply-To: <20251113-work-ovl-cred-guard-v1-0-fa9887f17061@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1870; i=brauner@kernel.org;
 h=from:subject:message-id; bh=470djjlZ2/Jz+9hZZClKQ3Ly8ft0Ex7xWfPNPpOI71A=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSKXnuy4dKr2HkHjAQ7lBW/8atU/L7YFNhuHd+zSkLm9
 gcXiQ3rO0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbS08jIcCib2Tua99C9sJ3N
 p47qPBAuE75lKXivcKuqxqLzx9IanBkZHp5MtuVfst3zbJLU46nL18VtCtLznlqzVHHFn+aGlnQ
 LfgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index e375c7306051..42a77876a36d 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -531,7 +531,6 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 {
 	struct inode *inode_out = file_inode(file_out);
 	struct file *realfile_in, *realfile_out;
-	const struct cred *old_cred;
 	loff_t ret;
 
 	inode_lock(inode_out);
@@ -553,25 +552,27 @@ static loff_t ovl_copyfile(struct file *file_in, loff_t pos_in,
 	if (IS_ERR(realfile_in))
 		goto out_unlock;
 
-	old_cred = ovl_override_creds(file_inode(file_out)->i_sb);
-	switch (op) {
-	case OVL_COPY:
-		ret = vfs_copy_file_range(realfile_in, pos_in,
-					  realfile_out, pos_out, len, flags);
-		break;
-
-	case OVL_CLONE:
-		ret = vfs_clone_file_range(realfile_in, pos_in,
-					   realfile_out, pos_out, len, flags);
-		break;
-
-	case OVL_DEDUPE:
-		ret = vfs_dedupe_file_range_one(realfile_in, pos_in,
-						realfile_out, pos_out, len,
-						flags);
-		break;
+	with_ovl_creds(file_inode(file_out)->i_sb) {
+		switch (op) {
+			case OVL_COPY:
+				ret = vfs_copy_file_range(realfile_in, pos_in,
+							  realfile_out, pos_out,
+							  len, flags);
+				break;
+
+			case OVL_CLONE:
+				ret = vfs_clone_file_range(realfile_in, pos_in,
+							   realfile_out,
+							   pos_out, len, flags);
+				break;
+
+			case OVL_DEDUPE:
+				ret = vfs_dedupe_file_range_one(realfile_in, pos_in,
+								realfile_out, pos_out,
+								len, flags);
+				break;
+		}
 	}
-	ovl_revert_creds(old_cred);
 
 	/* Update size */
 	ovl_file_modified(file_out);

-- 
2.47.3



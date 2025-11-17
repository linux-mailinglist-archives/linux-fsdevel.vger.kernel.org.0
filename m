Return-Path: <linux-fsdevel+bounces-68654-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BB20C6343C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 10:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0735D363943
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 09:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D8AB328B7F;
	Mon, 17 Nov 2025 09:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bt2dnxsK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1A0329380;
	Mon, 17 Nov 2025 09:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763372044; cv=none; b=cVtue/IICfbiSbXzb3uBsRNArhGk9i7WTE9sitlQY5il3TOWIYeo6M1b9ObnfUgGUwyBIkK8dTPUL5SYrEO5Wg5BJa9oV6eucTMEWNW4WZceR9nltLqEM4XA3qhetQ8f7dJW6tABEQ8TCVrTjNnCp6nN2vDKHvWZMrJM8EvQLw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763372044; c=relaxed/simple;
	bh=8ekCz0i+nQCss2JlZWQ8Ri5tJPGzRNJjeyfMjnRa8gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J+yLdJhNZ2RyHydleAKwn/2Krl/dvqTeowCH1eu4w3xJIxmHcR+WXi0M6C16SXjjDzVbyB7PFm8zitSd7dxrYJfwtYt+Yg77ekeJp4VN4NVzzpA+XrHQrsj6vb8tPMAED9/+7ObGGsq7C6SY0bH5NVXVNGzhrnCTZO16y3AiIZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bt2dnxsK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F120C4CEF5;
	Mon, 17 Nov 2025 09:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763372044;
	bh=8ekCz0i+nQCss2JlZWQ8Ri5tJPGzRNJjeyfMjnRa8gY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bt2dnxsKHqGjem+fON7ORKyxISYo1ViRVXeWNnGe28+Cg634p0qSSTGOetPrOxwHF
	 6DLsSaEQsxI3i3CwFIih6APrj5iAx5YuRTGacuLKcHKiNLwxEZ5ZlBxlUlJYHzTfX6
	 PRUn7LV2K4yAcVr3AHyjPIVic3RW2ZGZZbX6QP/9vX1lsRXozdG6GYzNJ3yF5Lafqq
	 555mNrDC2aYQujPFDTOap+MUQ4g0lu8Wv8mctnSRJLSVrxpybCi4psr7zUjqi5LdFq
	 Kw5xHD2iMot7febR8SakZyerHt/rqxHzihBJ78QfTQwRkcO08S8gAGfG/iQR99NhrG
	 BGzp3jbX7wLXg==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 17 Nov 2025 10:33:42 +0100
Subject: [PATCH v4 11/42] ovl: port ovl_fadvise() to cred guard
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-work-ovl-cred-guard-v4-11-b31603935724@kernel.org>
References: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
In-Reply-To: <20251117-work-ovl-cred-guard-v4-0-b31603935724@kernel.org>
To: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=brauner@kernel.org;
 h=from:subject:message-id; bh=8ekCz0i+nQCss2JlZWQ8Ri5tJPGzRNJjeyfMjnRa8gY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRKvf4qGZ0s497+cFbnhYaqo+97dZaUfK6pLmXhlNfr/
 vxg+4n7HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABOpzmf4Z2Gys8N659vq4vB2
 SdMJe/zKf8jq5U6frb5UYJq35dNJwowMMxXCDy69v8Z6U7wqb0nubrld5vN27ImePZNFcZ+eXMk
 HLgA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Use the scoped ovl cred guard.

Reviewed-by: Amir Goldstein <amir73il@gmail.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/overlayfs/file.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/fs/overlayfs/file.c b/fs/overlayfs/file.c
index 28263ad00dee..f562f908f48a 100644
--- a/fs/overlayfs/file.c
+++ b/fs/overlayfs/file.c
@@ -510,18 +510,13 @@ static long ovl_fallocate(struct file *file, int mode, loff_t offset, loff_t len
 static int ovl_fadvise(struct file *file, loff_t offset, loff_t len, int advice)
 {
 	struct file *realfile;
-	const struct cred *old_cred;
-	int ret;
 
 	realfile = ovl_real_file(file);
 	if (IS_ERR(realfile))
 		return PTR_ERR(realfile);
 
-	old_cred = ovl_override_creds(file_inode(file)->i_sb);
-	ret = vfs_fadvise(realfile, offset, len, advice);
-	ovl_revert_creds(old_cred);
-
-	return ret;
+	with_ovl_creds(file_inode(file)->i_sb)
+		return vfs_fadvise(realfile, offset, len, advice);
 }
 
 enum ovl_copyop {

-- 
2.47.3



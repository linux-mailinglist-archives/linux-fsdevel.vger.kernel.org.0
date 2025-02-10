Return-Path: <linux-fsdevel+bounces-41393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3838A2ECAB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 13:39:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 442D53A47B1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Feb 2025 12:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB24B1BE23E;
	Mon, 10 Feb 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hnKKrWah"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215DE222575;
	Mon, 10 Feb 2025 12:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739191152; cv=none; b=Tm1mL07qrHUQGvW4p+XcwKrT6waVeWDvnBYofF/KxTIUju9mEjR05n0ko430ly29/EtFhWcGkBfT4MB9B9MbKyUfU/VaFntzsloPPmli9y7sxjmRBo3pbIZmRqItlx6xnExrWMz/orLJwccbpa19YsRpu8AU7mvTNtkwxUJGN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739191152; c=relaxed/simple;
	bh=WBQB0hQsS8wj6sXR0LdPoQXO+BSkN20LwUKgMV/+DiY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TgcoRbSP7DUakUlm5XZ9LCN2QpHvMrsxvc/V/SN2UCWNs0YlummTIennAVDVwty/7/KNXDxMBJ7kC4AP8Dj5ay1MHsc5A7v1WVZsOsGApsTPWURPMLJByFg8F4ru6YwhZWGtZDI9B+Vd5QI+RvQwS4DjDCUAmOt1l8XWz7SB/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hnKKrWah; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C660C4CEE5;
	Mon, 10 Feb 2025 12:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739191151;
	bh=WBQB0hQsS8wj6sXR0LdPoQXO+BSkN20LwUKgMV/+DiY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hnKKrWah+jp5rQmyRNET7EBrrGDFtp2IC+HwRIDCxTOgnyTsjcD6aOaNWylgXIAzz
	 B8zxjcnvWm3ARn5sJXeyaxJfiV5yrUJEimSGHZswEwhCSGjWMNUXCYdkpzGdSN9iXy
	 4022e1LiRjffbBKrIiY8Of6a6DunPgWNbGR8qwQZecYPXCsMV5n65uihXNhVkFvOfN
	 F+ChdcwAr6RGfDm5BYMnkzPbFWog+2p7lo6ub5kRA1rFyMXeuTun0UNvotp6LDsIEF
	 terWaWex7Ti7WUA5nmdzocClXx8YPGaet11Hi0qLhwdD3pUQ5fzCVcc4QjZvPeFM5D
	 mVk23RZsCYt5Q==
From: Christian Brauner <brauner@kernel.org>
Date: Mon, 10 Feb 2025 13:38:59 +0100
Subject: [PATCH v2 1/2] fs: support O_PATH fds with FSCONFIG_SET_FD
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-work-overlayfs-v2-1-ed2a949b674b@kernel.org>
References: <20250210-work-overlayfs-v2-0-ed2a949b674b@kernel.org>
In-Reply-To: <20250210-work-overlayfs-v2-0-ed2a949b674b@kernel.org>
To: linux-unionfs@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>, Amir Goldstein <amir73il@gmail.com>, 
 Mike Baynton <mike@mbaynton.com>, linux-fsdevel@vger.kernel.org, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-d23a9
X-Developer-Signature: v=1; a=openpgp-sha256; l=1420; i=brauner@kernel.org;
 h=from:subject:message-id; bh=WBQB0hQsS8wj6sXR0LdPoQXO+BSkN20LwUKgMV/+DiY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMaSv/JwzLd5D8t26L1cDD7R9cF32qez/749X0201HrHJ8
 Fnf+i+o2FHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjARf1aGfyqB6clrolyvrz7W
 8GHdX+8zJ+xTPjbmVHmVNbsWBvklhjD84Tzgnb5OSv1/Wsi2FWtlOd/t7J8mWCr1j6Hm1ganhdI
 mrAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Let FSCONFIG_SET_FD handle O_PATH file descriptors. This is particularly
useful in the context of overlayfs where layers can be specified via
file descriptors instead of paths. But userspace must currently use
non-O_PATH file desriptors which is often pointless especially if
the file descriptors have been created via open_tree(OPEN_TREE_CLONE).

Fixes: a08557d19ef41 ("ovl: specify layers via file descriptors")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/autofs/autofs_i.h | 2 ++
 fs/fsopen.c          | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/autofs/autofs_i.h b/fs/autofs/autofs_i.h
index 77c7991d89aa..23cea74f9933 100644
--- a/fs/autofs/autofs_i.h
+++ b/fs/autofs/autofs_i.h
@@ -218,6 +218,8 @@ void autofs_clean_ino(struct autofs_info *);
 
 static inline int autofs_check_pipe(struct file *pipe)
 {
+	if (pipe->f_mode & FMODE_PATH)
+		return -EINVAL;
 	if (!(pipe->f_mode & FMODE_CAN_WRITE))
 		return -EINVAL;
 	if (!S_ISFIFO(file_inode(pipe)->i_mode))
diff --git a/fs/fsopen.c b/fs/fsopen.c
index 094a7f510edf..1aaf4cb2afb2 100644
--- a/fs/fsopen.c
+++ b/fs/fsopen.c
@@ -453,7 +453,7 @@ SYSCALL_DEFINE5(fsconfig,
 	case FSCONFIG_SET_FD:
 		param.type = fs_value_is_file;
 		ret = -EBADF;
-		param.file = fget(aux);
+		param.file = fget_raw(aux);
 		if (!param.file)
 			goto out_key;
 		param.dirfd = aux;

-- 
2.47.2



Return-Path: <linux-fsdevel+bounces-71243-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BBFF4CBA6D1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 08:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5BF4B30BC1C6
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Dec 2025 07:46:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97FE521D59B;
	Sat, 13 Dec 2025 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BnUZAwOP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00B13FCC
	for <linux-fsdevel@vger.kernel.org>; Sat, 13 Dec 2025 07:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765611995; cv=none; b=fcshs3okjEzcKW2a8f6M/uTkkzOn5m78QuzHC6cC+qzX/smdbVF5giyZGWJdVz92oCiTpGdHALJU9wvUBSMl75vP1cN6BMlfM4yadWf2hdjR3TbJ8dWvDavqZgfKOVzMEE5Qjyy9XwoGUGad4XNa7FX6s8gY7dzKpOzibKck8RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765611995; c=relaxed/simple;
	bh=OkNCr+W9+iXcJEIfRVmsFa2dfGw99v9lWLhyDEYaaks=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tj/bEi3tvttD3FEIp4pDJKuXpzSg97QdrUTlXfAczeP1bGFSnh979MEHJ0CbN0Vy5WAh2hsM/ZG4NVBvIJD9jZXEN7C3jFXU/8J+CWVZ0V10jmnN1yGzk/WzTkPaGxBaOJ93+VWXKRoQwonXAGU/N5Pr/HrKXhhh5lZFPpJfyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BnUZAwOP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 714D4C4CEF7;
	Sat, 13 Dec 2025 07:46:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765611994;
	bh=OkNCr+W9+iXcJEIfRVmsFa2dfGw99v9lWLhyDEYaaks=;
	h=From:To:Cc:Subject:Date:From;
	b=BnUZAwOPEA4q90izP48X4REr9/BmkRb4W9UbvUeqHmD/KjIGgk4lQcSoCGIqDQAzH
	 QrULfbW/I4RNGdJhzxmP//GFy+Zewj0kPx7rnphXLFm+c+0PSF/EYqRjwDOp1H81ZA
	 Uw45Zee0/eak5oMCVEEEFF6rY66sJwklBXq/HHfPYKtkXw5EQ7EZT6hMS0S/5SWamp
	 C3QfG4CmwqrFWENKfdvXGST99lZ4yV/ztSGcEl3OOp0ZYebB91zpdnJWrOL9Z1tV9D
	 EEvkIji5GnMfXBWhuhDJHPzfi/dJuYTDg8WgCq9Q44WjTO8JzkbUquW0RziQhpAx/l
	 aZqk2KyBHdCoA==
From: Christian Brauner <brauner@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Christian Brauner <brauner@kernel.org>,
	linux-fsdevel@vger.kernel.org,
	Chris Mason <clm@fb.com>,
	Jeff Layton <jlayton@kernel.org>
Subject: [PATCH] file: ensure cleanup
Date: Sat, 13 Dec 2025 08:45:23 +0100
Message-ID: <20251213-distanz-umgewandelt-c6179aac18d7@brauner>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1898; i=brauner@kernel.org; h=from:subject:message-id; bh=OkNCr+W9+iXcJEIfRVmsFa2dfGw99v9lWLhyDEYaaks=; b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTaSs5JDThjwLnUQLjly/e2OCfDb+cNljrzJ4iySy77P Du61+hURykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwESy4xkZ1t418Lik0KpwtoQ3 yaInXX0a24NniV7HXh/xk1fd7vdkKcP/3McKpX72IayWGuVKCpGhzU91509XiNAyWTzdo3vX23v cAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp; fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
Content-Transfer-Encoding: 8bit

Brown paper bag time. This is a silly oversight where I missed to drop
the error condition checking to ensure we clean up on early error
returns. I have an internal unit testset coming up for this which will
catch all such issues going forward.

Reported-by: Chris Mason <clm@fb.com>
Reported-by: Jeff Layton <jlayton@kernel.org>
Fixes: 011703a9acd7 ("file: add FD_{ADD,PREPARE}()")
Signed-off-by: Christian Brauner <brauner@kernel.org>
---
Linus,

I didn't take my second hardware key to Tokyo so I have no access to any
mail or relevant servers right now. I get back to work on Monday. Can
you please apply this directly?

Thanks!
Christian
---
 include/linux/file.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/include/linux/file.h b/include/linux/file.h
index cf389fde9bc2..27484b444d31 100644
--- a/include/linux/file.h
+++ b/include/linux/file.h
@@ -161,12 +161,10 @@ typedef struct fd_prepare class_fd_prepare_t;
 /* Do not use directly. */
 static inline void class_fd_prepare_destructor(const struct fd_prepare *fdf)
 {
-	if (unlikely(fdf->err)) {
-		if (likely(fdf->__fd >= 0))
-			put_unused_fd(fdf->__fd);
-		if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
-			fput(fdf->__file);
-	}
+	if (unlikely(fdf->__fd >= 0))
+		put_unused_fd(fdf->__fd);
+	if (unlikely(!IS_ERR_OR_NULL(fdf->__file)))
+		fput(fdf->__file);
 }
 
 /* Do not use directly. */
@@ -230,7 +228,8 @@ static inline int class_fd_prepare_lock_err(const struct fd_prepare *fdf)
 		VFS_WARN_ON_ONCE(fdp->__fd < 0);               \
 		VFS_WARN_ON_ONCE(IS_ERR_OR_NULL(fdp->__file)); \
 		fd_install(fdp->__fd, fdp->__file);            \
-		fdp->__fd;                                     \
+		retain_and_null_ptr(fdp->__file);              \
+		take_fd(fdp->__fd);                            \
 	})
 
 /* Do not use directly. */
-- 
2.47.3



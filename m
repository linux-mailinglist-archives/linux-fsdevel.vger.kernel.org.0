Return-Path: <linux-fsdevel+bounces-69527-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 19BA4C7E3AB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 17:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2C53C349C46
	for <lists+linux-fsdevel@lfdr.de>; Sun, 23 Nov 2025 16:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311B92D7DC7;
	Sun, 23 Nov 2025 16:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SB+2cd42"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 009172264A7
	for <linux-fsdevel@vger.kernel.org>; Sun, 23 Nov 2025 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763915626; cv=none; b=PEbfjcNTzb8hIrCyIBCd0L3+0HNYT7Oo3/FxlH9L3tVLTa1E0DcUHrQfGq6QjNs92TZLK34Aas32fGTKkKCEjbByVmbrvF9xiMRV+2Ic+ewe0XjkEur2ey6HdfWXFLnWHusuwukFprO6O0f8mDC1HR/ueoBl7DIKkX42CwC/kks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763915626; c=relaxed/simple;
	bh=99CmVar0V/qUQYuJA6lrBqhY2dOsw4rmdb8vp8k3V90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L5GLxJGQUtHfouKYhugha2sO31ROIah6iHhHx2AU0KwPuwgTwLsG+1cq9FIIkGCEFh/o4mmTvMyZkugSUp7f7SkPO4PnthZR4gTksolNi6cem1pLwyhFwetYLNvjrAGXQM42YTQ7kqkcGLZAxZg27FDpEPhh+nXPu3rtNNDwXkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SB+2cd42; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C1A0C113D0;
	Sun, 23 Nov 2025 16:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763915625;
	bh=99CmVar0V/qUQYuJA6lrBqhY2dOsw4rmdb8vp8k3V90=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=SB+2cd429qImhpyw2UzqLgt5HHaY3W9QpAAs4skOJWdtN1XtVaX1TuP69u+dpRqkj
	 8a8IgPcb3m/1ZSrHizfi4m4Ku8zzB3A+lhQE4Oopr9Gv9kEotzQixDBbc+fdYSPVov
	 jOav8AH6n+2vleh/bruKy8cAuk/9UmH6aVQWsBiNKhpLakA54Km/KOjSdZN0igBANJ
	 0WbLwuQ01Ygvy5hcJTId578wa/piHpVjbTZLHgzEiqUjhbksG163iGZqvQRNe/5yQb
	 XexV2MdhBviso5oNm1F1neYNhA23rCYAPmH7+Osk/PBh4cw6Iu/ZAKk8jV0iAKu0h0
	 5Q9oaSj3bAL8Q==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 23 Nov 2025 17:33:23 +0100
Subject: [PATCH v4 05/47] namespace: convert open_tree() to FD_PREPARE()
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251123-work-fd-prepare-v4-5-b6efa1706cfd@kernel.org>
References: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
In-Reply-To: <20251123-work-fd-prepare-v4-0-b6efa1706cfd@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-fsdevel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Amir Goldstein <amir73il@gmail.com>, Jens Axboe <axboe@kernel.dk>, 
 Christian Brauner <brauner@kernel.org>
X-Mailer: b4 0.15-dev-a6db3
X-Developer-Signature: v=1; a=openpgp-sha256; l=854; i=brauner@kernel.org;
 h=from:subject:message-id; bh=99CmVar0V/qUQYuJA6lrBqhY2dOsw4rmdb8vp8k3V90=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQqm0c6N34t6lgrUnzgZ7Tyv6D+hO0lehKqXzTj2m+tF
 N1jnODUUcrCIMbFICumyOLQbhIut5ynYrNRpgbMHFYmkCEMXJwCMJFlPxkZJjq+ede0ba0jK5Ol
 aeDGjKcSL1dt57sxPaNw67bVovZ5sxj+KWt9XF60S2xtnPk5/4dzFlyY9jR2pkLmjGNXvUvvCia
 FsQAA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Signed-off-by: Christian Brauner <brauner@kernel.org>
---
 fs/namespace.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d82910f33dc4..3cf3fa27117d 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -3103,19 +3103,7 @@ static struct file *vfs_open_tree(int dfd, const char __user *filename, unsigned
 
 SYSCALL_DEFINE3(open_tree, int, dfd, const char __user *, filename, unsigned, flags)
 {
-	int fd;
-	struct file *file __free(fput) = NULL;
-
-	file = vfs_open_tree(dfd, filename, flags);
-	if (IS_ERR(file))
-		return PTR_ERR(file);
-
-	fd = get_unused_fd_flags(flags & O_CLOEXEC);
-	if (fd < 0)
-		return fd;
-
-	fd_install(fd, no_free_ptr(file));
-	return fd;
+	return FD_ADD(flags, vfs_open_tree(dfd, filename, flags));
 }
 
 /*

-- 
2.47.3



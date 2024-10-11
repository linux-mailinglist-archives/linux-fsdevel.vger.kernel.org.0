Return-Path: <linux-fsdevel+bounces-31778-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E4F99AD97
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 22:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 946FC1F23C3C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Oct 2024 20:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54C31D14E8;
	Fri, 11 Oct 2024 20:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uYAbcrXK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F841C3F0A;
	Fri, 11 Oct 2024 20:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679048; cv=none; b=KbpdVama0ONF5wVqel0SJSnH0htrIYgzsSEgef2eqyRTsUZ+r7FBAPyozhy8BQLOLe/qh5rRdnTLpCFu2bRW9TJZeEBx0aaHFD6nN3+VPtwz0TtiZfSbQhqKbweoq/MXkR/3oFZzSOL04siUBbTauEzg24nLGEIB+sOGIwn6ITo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679048; c=relaxed/simple;
	bh=CWZGBnEJ80UiaDTPSuDUZ70kqMw3cxxu6gG4Z0pcQVE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M5iLnQr7yGD6fnSGRXwEpejfQdLXQk+O4UJHXZnOz1DdfdT7j+WRYQJNWdxgDHy/VCnc4P8mXN+rDx6/fZKMTR3F4JJtWORhLkFY3RX3c6Yl71Rdns+194czOOQXIZSKKW5E/lGJyrxJZE9rXv2JMcU8NfeDQYO7T6+ioi5xVSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uYAbcrXK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831CEC4CEC3;
	Fri, 11 Oct 2024 20:37:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728679047;
	bh=CWZGBnEJ80UiaDTPSuDUZ70kqMw3cxxu6gG4Z0pcQVE=;
	h=From:To:Cc:Subject:Date:From;
	b=uYAbcrXK8FLRoEkmirqKqE2T2BWanywm0TM90kzfEKK0nYuDxOhrIhDbmui+SrNt+
	 1mjjpUvymCswoPAWZddBRZSI7fZe1o/evRZNqBo4Dx0xEuYkhxpBEJfDTd3GNxZ7x6
	 EfQdm7CxvjmXuQiP/TXiDi+s7rhBX8ol2CN0MOjYzQ641N3+0xB/AMBZfdDW9fuMFx
	 P22KWy+9B9G/KGvAJ+MhJiAwddKNcyTSZWStAhfBiaqRPqSU4L7Qo+fr2ai89iLO7+
	 Hpf0G4myWZ4l50hTbL1Ymw49gXx1n5eI2ZVFY1+67nxeDf2gyZfuLV8Q+x3Tkzavr1
	 H7vOx5CHPuwdg==
From: Song Liu <song@kernel.org>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
Cc: viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	paul@paul-moore.com,
	jmorris@namei.org,
	serge@hallyn.com,
	kernel-team@fb.com,
	song@kernel.org
Subject: [PATCH] fsnotify, lsm: Separate fsnotify_open_perm() and security_file_open()
Date: Fri, 11 Oct 2024 13:37:22 -0700
Message-ID: <20241011203722.3749850-1-song@kernel.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, fsnotify_open_perm() is called from security_file_open(). This
is not right for CONFIG_SECURITY=n and CONFIG_FSNOTIFY=y case, as
security_file_open() in this combination will be a no-op and not call
fsnotify_open_perm(). Fix this by calling fsnotify_open_perm() directly.

Signed-off-by: Song Liu <song@kernel.org>

---

PS: I didn't included a Fixes tag. This issue was probably introduced 15
years ago in [1]. If we want to back port this to stable, we will need
another version for older kernel because of [2].

[1] c4ec54b40d33 ("fsnotify: new fsnotify hooks and events types for access decisions")
[2] 36e28c42187c ("fsnotify: split fsnotify_perm() into two hooks")
---
 fs/open.c           | 4 ++++
 security/security.c | 9 +--------
 2 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/fs/open.c b/fs/open.c
index acaeb3e25c88..6c4950f19cfb 100644
--- a/fs/open.c
+++ b/fs/open.c
@@ -946,6 +946,10 @@ static int do_dentry_open(struct file *f,
 	if (error)
 		goto cleanup_all;
 
+	error = fsnotify_open_perm(f);
+	if (error)
+		goto cleanup_all;
+
 	error = break_lease(file_inode(f), f->f_flags);
 	if (error)
 		goto cleanup_all;
diff --git a/security/security.c b/security/security.c
index 6875eb4a59fc..a72cc62c0a07 100644
--- a/security/security.c
+++ b/security/security.c
@@ -19,7 +19,6 @@
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
 #include <linux/lsm_hooks.h>
-#include <linux/fsnotify.h>
 #include <linux/mman.h>
 #include <linux/mount.h>
 #include <linux/personality.h>
@@ -3102,13 +3101,7 @@ int security_file_receive(struct file *file)
  */
 int security_file_open(struct file *file)
 {
-	int ret;
-
-	ret = call_int_hook(file_open, file);
-	if (ret)
-		return ret;
-
-	return fsnotify_open_perm(file);
+	return call_int_hook(file_open, file);
 }
 
 /**
-- 
2.43.5



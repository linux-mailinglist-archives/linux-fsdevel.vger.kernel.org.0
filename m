Return-Path: <linux-fsdevel+bounces-31809-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE01399B7CB
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 02:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1C391C21681
	for <lists+linux-fsdevel@lfdr.de>; Sun, 13 Oct 2024 00:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C322128FD;
	Sun, 13 Oct 2024 00:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeWrSY0g"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4C0819;
	Sun, 13 Oct 2024 00:23:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728778981; cv=none; b=IpRqFJr3uU3SbJM/PXKn7Amf3LVdbpHdttpMl7Tj2b/QP9Av1TtSNyF7Q6d1NUqqIsBfbW8eQn7PW2p6kwK67VqRz7fd4asyk28xzzIQcD6uSAgD4Zj3ZkBhh+vsSb5AGEqY4HHf6bNKIrMPR1rTPIkzmphJI6/exeT4xnw/lhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728778981; c=relaxed/simple;
	bh=rEzJzobjxqPB3qyg2IMyvh87zgno3Ga2EHEkOAM7yd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d/a4/HMlqatk9lgObG+foy0/Lhe+LaPgoEo+8GwIaPZLTZBvBJJdObah/eul7hyN1BTkwMmPNcXWj+T3xBTo8M/m3IVHYvyyf5cgrYYWLgoSEMWG7z4j1kEr9QpMH2bQ6lJW7HxO5cM1jpr2TJEcxuu7ER+/6KKRB130BbrQ9pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeWrSY0g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F350EC4CEC6;
	Sun, 13 Oct 2024 00:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728778980;
	bh=rEzJzobjxqPB3qyg2IMyvh87zgno3Ga2EHEkOAM7yd4=;
	h=From:To:Cc:Subject:Date:From;
	b=oeWrSY0gxznVTGjDFVkfdFHWB3YjzUD3AQarRSa9Mw6V6GdW067x3V4EBytbc81J2
	 am2DeBgwCPhd2vl2fvX5LuL4c7cW2ndvRDUOQKPF7R49O1tiMAbVusuKPK2xogqmUF
	 nAeIgHQr2LjZX6fEPSVpLa+815A3a8SNB5P5PWrbikkIWmcreYixhix0CFb0vy7MEP
	 TmbVXV+GZpP8Cedu3LsrAfi871moIunrsTLB/5mdF9/HIrugfdPYAGOCXyfkA4qXXN
	 kkuuGOeM9cwFQQxwiNuCWDK0skE9jQQnAwwi9/yxiwT1FZQk03+4JonG2D7CqBzVk7
	 lXIvMH84UH9Sw==
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
Subject: [PATCH v2] fsnotify, lsm: Decouple fsnotify from lsm
Date: Sat, 12 Oct 2024 17:22:48 -0700
Message-ID: <20241013002248.3984442-1-song@kernel.org>
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

After this, CONFIG_FANOTIFY_ACCESS_PERMISSIONS does not require
CONFIG_SECURITY any more. Remove the dependency in the config.

Signed-off-by: Song Liu <song@kernel.org>
Acked-by: Paul Moore <paul@paul-moore.com>

---

v1: https://lore.kernel.org/linux-fsdevel/20241011203722.3749850-1-song@kernel.org/

As far as I can tell, it is necessary to back port this to stable. Because
CONFIG_FANOTIFY_ACCESS_PERMISSIONS is the only user of fsnotify_open_perm,
and CONFIG_FANOTIFY_ACCESS_PERMISSIONS depends on CONFIG_SECURITY.
Therefore, the following tags are not necessary. But I include here as
these are discussed in v1.

Fixes: c4ec54b40d33 ("fsnotify: new fsnotify hooks and events types for access decisions")
Depends-on: 36e28c42187c ("fsnotify: split fsnotify_perm() into two hooks")
Depends-on: d9e5d31084b0 ("fsnotify: optionally pass access range in file permission hooks")
---
 fs/notify/fanotify/Kconfig | 1 -
 fs/open.c                  | 4 ++++
 security/security.c        | 9 +--------
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/fs/notify/fanotify/Kconfig b/fs/notify/fanotify/Kconfig
index a511f9d8677b..0e36aaf379b7 100644
--- a/fs/notify/fanotify/Kconfig
+++ b/fs/notify/fanotify/Kconfig
@@ -15,7 +15,6 @@ config FANOTIFY
 config FANOTIFY_ACCESS_PERMISSIONS
 	bool "fanotify permissions checking"
 	depends on FANOTIFY
-	depends on SECURITY
 	default n
 	help
 	   Say Y here is you want fanotify listeners to be able to make permissions
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



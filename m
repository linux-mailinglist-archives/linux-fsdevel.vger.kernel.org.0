Return-Path: <linux-fsdevel+bounces-61561-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A030B589E8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C25947AD944
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E2B1A2545;
	Tue, 16 Sep 2025 00:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK4FBpGt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7AB3E571
	for <linux-fsdevel@vger.kernel.org>; Tue, 16 Sep 2025 00:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983323; cv=none; b=Q/5TLVpW84VTjRZpAqwVQ7qMFfBi4oGuELPd9EFFSzV7ZqtPyyg9jv8NnqbiHFW+U9coRSzJZk6cdSF4Gtd0o7zrp/W3YcBVwX7gYRu2AaqP69If2VsS4de2LPw9wFKkSjYcbzp6VYsClvPEK9QEwIHrB3M7HYlDIwdH9lSEmUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983323; c=relaxed/simple;
	bh=yzz7Y4oAj9FOo35aQdjmYQpeM8zK3n5dyX2RtZLo3hU=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A3oWw2i/863F8m2ZM4XdweB0DvTsri3VxzSXCFWO37PL7d/SruWZwyAO6mXpjj6qA9csT5bAXlbzh8nsZhFfytpaceNqMP3cPGy4/zPKeo3G4SQuVFoZkc0r1looynsNjtNL9fCa0FOlx/lgU4QSNLzKqBEf+1VEHcdpo/7s0PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK4FBpGt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 822A9C4CEF1;
	Tue, 16 Sep 2025 00:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983323;
	bh=yzz7Y4oAj9FOo35aQdjmYQpeM8zK3n5dyX2RtZLo3hU=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=VK4FBpGt6ViLYxng4nnFcmT0ZMpnHdrbcvLllCQt+N1tW0jnZlU7ag+54VaI44BWb
	 ACELxPfMK/J73w7HdSAAxLfIQo/KGjwfE0Y4X2S3m1v5iOlTEmocsC1LJYu7pj16Kg
	 Velgufp0/X4AslfuXLZ5iJdUhO06j0aHYF6BOBH46pxjgh2oPbERvU+X2Rbjl5+pya
	 gcoKQHHJ9JV33ViBZW0WwGYVMOHtqlaWUCKioRZdPIp3Jvmg/zsqt8FN3soGR++p6a
	 aPDLhJJrGyY0Er2+35QHzirBJH3LUUV5UZtHW6TtcrhkHIxecqto/zq+Mc/sEuuvr7
	 u5lHpfojNXTmg==
Date: Mon, 15 Sep 2025 17:42:03 -0700
Subject: [PATCH 01/18] libfuse: bump kernel and library ABI versions
From: "Darrick J. Wong" <djwong@kernel.org>
To: bschubert@ddn.com, djwong@kernel.org
Cc: John@groves.net, neal@gompa.dev, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, joannelkoong@gmail.com
Message-ID: <175798154532.386924.12118983114394408880.stgit@frogsfrogsfrogs>
In-Reply-To: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
References: <175798154438.386924.8786074960979860206.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Bump the kernel ABI version to 7.99 and the libfuse ABI version to 3.99
to start our development.  This patch exists to avoid confusion during
the prototyping stage.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse_kernel.h  |    4 +++-
 ChangeLog.rst          |   12 +++++++++++-
 lib/fuse_versionscript |    3 +++
 lib/meson.build        |    2 +-
 meson.build            |    2 +-
 5 files changed, 19 insertions(+), 4 deletions(-)


diff --git a/include/fuse_kernel.h b/include/fuse_kernel.h
index 122d6586e8d4da..4d68c4e8a71d5f 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -235,6 +235,8 @@
  *
  *  7.44
  *  - add FUSE_NOTIFY_INC_EPOCH
+ *
+ *  7.99
  */
 
 #ifndef _LINUX_FUSE_H
@@ -270,7 +272,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 44
+#define FUSE_KERNEL_MINOR_VERSION 99
 
 /** The node ID of the root inode */
 #define FUSE_ROOT_ID 1
diff --git a/ChangeLog.rst b/ChangeLog.rst
index 505d9dba84100f..bdb133a5f7db74 100644
--- a/ChangeLog.rst
+++ b/ChangeLog.rst
@@ -1,4 +1,14 @@
-libfuse 3.18
+libfuse 3.99
+
+libfuse 3.99-rc0 (2025-07-18)
+===============================
+
+* Add prototypes of iomap and syncfs (djwong)
+
+libfuse 3.18-rc0 (2025-07-18)
+===============================
+
+* Add statx, among other things (djwong)
 
 libfuse 3.17.1-rc0 (2024-02.10)
 ===============================
diff --git a/lib/fuse_versionscript b/lib/fuse_versionscript
index 2feafcf83860c5..96a94e43f73909 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -218,6 +218,9 @@ FUSE_3.18 {
 		fuse_fs_statx;
 } FUSE_3.17;
 
+FUSE_3.99 {
+} FUSE_3.18;
+
 # Local Variables:
 # indent-tabs-mode: t
 # End:
diff --git a/lib/meson.build b/lib/meson.build
index fcd95741c9d374..8efe71abfabc9e 100644
--- a/lib/meson.build
+++ b/lib/meson.build
@@ -49,7 +49,7 @@ libfuse = library('fuse3',
                   dependencies: deps,
                   install: true,
                   link_depends: 'fuse_versionscript',
-                  c_args: [ '-DFUSE_USE_VERSION=317',
+                  c_args: [ '-DFUSE_USE_VERSION=399',
                             '-DFUSERMOUNT_DIR="@0@"'.format(fusermount_path) ],
                   link_args: ['-Wl,--version-script,' + meson.current_source_dir()
                               + '/fuse_versionscript' ])
diff --git a/meson.build b/meson.build
index 07c729581789e1..7214d24705c7fb 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('libfuse3', ['c'],
-        version: '3.18.0-rc0',  # Version with RC suffix
+        version: '3.99.0-rc0',  # Version with RC suffix
         meson_version: '>= 0.60.0',
         default_options: [
             'buildtype=debugoptimized',



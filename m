Return-Path: <linux-fsdevel+bounces-58476-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B45FB2E9EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:03:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9709F1891DE6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA0EB1F4C8E;
	Thu, 21 Aug 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NN8bss08"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370EC4315A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738098; cv=none; b=cfnHwrg1bKLn8hrkPG9WaZU4z+Kdsx7ZoKThq2tOmVt8UNSm3jnW/4gwgcGr36i3qp7dRpc3yT1iS0Vf8PwjTFd/Gj99bI+5+ttveULdmx9incvyQOmy9V3VekZqPLC6+lBzejBkhLUhdVamOPUNKnCOVv8+hPDgcAN2fZpCOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738098; c=relaxed/simple;
	bh=frbatKPgTcBjzWGiUsbLxYK1CHehDZAgt8FsIx8Srs4=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dobBgM2FnvNHUHPqL9Vz5gidRbn1pHqn976YrobN7xoKt8eflLuiA6kJCcXc3ffZq5pjGsu9EAd5ZyAnWc3DLVF4JWoVZvAaijO7X1lFBRi2YSteNeRiUF4kYbSuRyAy9dSRvqSsf3l3o8CiJBdhfebZAwXnkbVu3mkzZUt0xXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NN8bss08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3D9C4CEE7;
	Thu, 21 Aug 2025 01:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738098;
	bh=frbatKPgTcBjzWGiUsbLxYK1CHehDZAgt8FsIx8Srs4=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=NN8bss08HVFphht/fVlJEbk5TdzHpon3YHRA8YUvxyZ2PfYZz6PZkWilKBsuT4zfV
	 hm9XDCGFPKwRMSsd/Eh0dBjynuUD4naenKVsaYECbyZ8Ua3N50e9fUl/QiKu0rtpIo
	 v3Ryyhwv3CZIPYxHKwlnV6HlVVSEEzBA2DPnIn1L7qz3LPv+tfoOzN26p54+b2Yxdp
	 c8IKr2EdWcSQDjftOSh7dv5PrPVeTvmjxGyX0B+E9CeLP8YTn0+LRq+kUD7XG87qT6
	 psj638xsBPArKDz2F0gemg36EarhhaZ4WIdg70mmy2bjr6bJPynDwRfsCuFbgV/tfJ
	 Jmvf6YVlgFpjA==
Date: Wed, 20 Aug 2025 18:01:37 -0700
Subject: [PATCH 01/21] libfuse: bump kernel and library ABI versions
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573711300.19163.11309102343582077082.stgit@frogsfrogsfrogs>
In-Reply-To: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
References: <175573711192.19163.9486664721161324503.stgit@frogsfrogsfrogs>
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
index 0e581f1711412c..ba8f3b00478b30 100644
--- a/lib/fuse_versionscript
+++ b/lib/fuse_versionscript
@@ -217,6 +217,9 @@ FUSE_3.18 {
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
index f98ef8a6d60f33..0abb2cf0be5563 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('libfuse3', ['c'],
-        version: '3.18.0-rc0',  # Version with RC suffix
+        version: '3.99.0-rc0',  # Version with RC suffix
         meson_version: '>= 0.60.0',
         default_options: [
             'buildtype=debugoptimized',



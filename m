Return-Path: <linux-fsdevel+bounces-66058-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20451C17B47
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 491801889E6E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CFB02D7DCE;
	Wed, 29 Oct 2025 00:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="udNK0s8y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015002D3EF6;
	Wed, 29 Oct 2025 00:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699575; cv=none; b=ibXBxJE33VS3BIdO5vwivQx/Xr44Ha43OuNsQNeaCBespUxhPLiEqniG2LVM8BhzxaTRLghRx7UwTMRUK0f425qQ4RLwzl38hBwOPtIr4bcs8tIzLfaWF1bl5RrJP4AwSKr4lvM/ITy+En4HgUYbu7wB5wdLFH0WgGNIqi78mMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699575; c=relaxed/simple;
	bh=c9JuMoqz4nKf4IT1K/OyWoXTk12T+gJb4Aam2lV0Uvk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rZBpzRBFlfYI/2Uauys6a1Q9b9Ed9UvesTgOUzD848nAJ5JpeK+kdTtQu/PQbqOzE/l/qTcqo1F3ESj8NIQnDaxRr3svALLOunu/ufuYH937ZO3eDiVAWLohxoAoMyl3hh1BvtrvxGELDHL68dd+ZeY0ELiP1Uz2h+KKOAQm1Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=udNK0s8y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91E86C4CEE7;
	Wed, 29 Oct 2025 00:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761699574;
	bh=c9JuMoqz4nKf4IT1K/OyWoXTk12T+gJb4Aam2lV0Uvk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=udNK0s8yDRdCRisPbdBWd/4B1F2RZ8UtzfgoVWs7XBJ8JKp5jvaVceBZNCAXlFTf+
	 U9exWHw9tD2ek+qaapJUuF2mOsj7UYQMx51HozT9WJn7ZtFy6jLvPF3Hk2FRqAvWyZ
	 3Me0GWw8bVve4oJvMH96wWIpiUydOFGdbwwCuD6Cq9qFkpucOeqptxDXunk2aik7MD
	 zx4AHZvJRVuspdjCvfOZ1mldjTtq17WY8lamGe6uMnc7JudjwaE7sivWxCB54k5xTb
	 wuToPTnhoq3Oeg/Bys2j6Uj+jSh9dJWYtXKNRP8urHsydKBzd6piyO2cbctcPKl0cx
	 lGROOiBUOQHGw==
Date: Tue, 28 Oct 2025 17:59:34 -0700
Subject: [PATCH 01/22] libfuse: bump kernel and library ABI versions
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 bernd@bsbernd.com, miklos@szeredi.hu, joannelkoong@gmail.com, neal@gompa.dev
Message-ID: <176169813551.1427432.14472849364340575034.stgit@frogsfrogsfrogs>
In-Reply-To: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
References: <176169813437.1427432.15345189583850708968.stgit@frogsfrogsfrogs>
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
index 94621f68a5cc8d..cf4a5f1a35c98b 100644
--- a/include/fuse_kernel.h
+++ b/include/fuse_kernel.h
@@ -239,6 +239,8 @@
  *  7.45
  *  - add FUSE_COPY_FILE_RANGE_64
  *  - add struct fuse_copy_file_range_out
+ *
+ *  7.99
  */
 
 #ifndef _LINUX_FUSE_H
@@ -274,7 +276,7 @@
 #define FUSE_KERNEL_VERSION 7
 
 /** Minor version number of this interface */
-#define FUSE_KERNEL_MINOR_VERSION 45
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
index e3c7eeba64fd64..8359a489c351b9 100644
--- a/meson.build
+++ b/meson.build
@@ -1,5 +1,5 @@
 project('libfuse3', ['c'],
-        version: '3.18.0-rc0',  # Version with RC suffix
+        version: '3.99.0-rc0',  # Version with RC suffix
         meson_version: '>= 0.60.0',
         default_options: [
             'buildtype=debugoptimized',



Return-Path: <linux-fsdevel+bounces-61594-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A02CCB58A1E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 02:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33BA85216F2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Sep 2025 00:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503581AC43A;
	Tue, 16 Sep 2025 00:51:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghtk1x+U"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A481B7483;
	Tue, 16 Sep 2025 00:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757983886; cv=none; b=gt80nl8gO5V//BMn9w4oFOEQrW2jkSipKE6ggJcDxj+bDZGFyS0P+/g70Xqi24DNOrRu7gWrqdewycJR9veRsmvZJUeo+nUTVsQn3K5RYPmTMLfNNnkL9Lru5tBR4/EBJfVrN3+KkJv1uOOJy+BBKaIy9MDuQR7gOec8prBjUV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757983886; c=relaxed/simple;
	bh=+p2q9N5WVDONgyAVHXODfIZugnSy8XZmRtYre5vHxrI=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BAEJKiWv+RZWF9xvNWeF11l1qxmz2sSKR68LASw75aFhlaR+kcMfSE1/rJC5rMKso27OMZS/z91OucDrpG0l7m4OpW0qSct+1NKDfBfhlNa+lkEtnlaB6pa5YlQ6YVUR2Tv8SwGQRR8a9UNIzi4lO9nHODfwDa8hBaXgBasNX8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghtk1x+U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 772E3C4CEF1;
	Tue, 16 Sep 2025 00:51:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757983886;
	bh=+p2q9N5WVDONgyAVHXODfIZugnSy8XZmRtYre5vHxrI=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ghtk1x+UWhRKQRcpxO8GbkJcjHZhPI3z4kW6WF3qRKlVkQ8Uz1iPi+x6gILu7qosC
	 axUItYhiVH+lbDXtQ4+i8Z75tlekhLgO3s99yJl6fUJgLPz5Qy2tSSx8CCVHB137JW
	 gysgGP3Mmbg/SNfWdr/s/ih9KkBWLEHairWs5mZVzSzdUZ7LtZIap0VENRNOYRAWgd
	 akNzf0IipeICpc66RqpJTkBAy73LSuRSZlkgu1OCgXnqxhAYgyUP4aBG2dX27iI/2g
	 cZJcOkPhbAcQWrDXzurrrTtP9rfFeUDITwXGiVypQdk0DDnwyrNKAc97XF0W0n1Ljh
	 h0oNhCR6zOTEA==
Date: Mon, 15 Sep 2025 17:51:26 -0700
Subject: [PATCH 03/21] debian: create new package for fuse4fs
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: miklos@szeredi.hu, neal@gompa.dev, amir73il@gmail.com,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, John@groves.net,
 bernd@bsbernd.com, joannelkoong@gmail.com
Message-ID: <175798160829.389252.9702141690311640195.stgit@frogsfrogsfrogs>
In-Reply-To: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
References: <175798160681.389252.3813376553626224026.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Create a new package for fuse4fs.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 debian/control         |   12 +++++++++++-
 debian/fuse4fs.install |    2 ++
 debian/rules           |   11 +++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)
 create mode 100644 debian/fuse4fs.install


diff --git a/debian/control b/debian/control
index fb3487cd32b99a..94c6b82e25a97e 100644
--- a/debian/control
+++ b/debian/control
@@ -2,7 +2,7 @@ Source: e2fsprogs
 Section: admin
 Priority: important
 Maintainer: Theodore Y. Ts'o <tytso@mit.edu>
-Build-Depends: dpkg-dev (>= 1.22.5), gettext, texinfo, pkgconf, libarchive-dev <!nocheck>, libfuse3-dev [linux-any kfreebsd-any] <!pkg.e2fsprogs.no-fuse2fs>, debhelper-compat (= 12), dh-exec, libblkid-dev, uuid-dev, m4, udev [linux-any], systemd [linux-any], systemd-dev [linux-any], cron [linux-any], dh-sequence-movetousr
+Build-Depends: dpkg-dev (>= 1.22.5), gettext, texinfo, pkgconf, libarchive-dev <!nocheck>, libfuse3-dev [linux-any kfreebsd-any] <!pkg.e2fsprogs.no-fuse2fs> <!pkg.e2fsprogs.no-fuse4fs>, debhelper-compat (= 12), dh-exec, libblkid-dev, uuid-dev, m4, udev [linux-any], systemd [linux-any], systemd-dev [linux-any], cron [linux-any], dh-sequence-movetousr
 Rules-Requires-Root: no
 Standards-Version: 4.7.2
 Homepage: http://e2fsprogs.sourceforge.net
@@ -21,6 +21,16 @@ Description: ext2 / ext3 / ext4 file system driver for FUSE
  writing from devices or image files containing ext2, ext3, and ext4
  file systems.
 
+Package: fuse4fs
+Build-Profiles: <!pkg.e2fsprogs.no-fuse4fs>
+Priority: optional
+Depends: ${shlibs:Depends}, ${misc:Depends}
+Architecture: linux-any kfreebsd-any
+Description: ext2 / ext3 / ext4 file system driver for FUSE
+ fuse4fs is a faster FUSE file system client that supports reading and
+ writing from devices or image files containing ext2, ext3, and ext4
+ file systems.
+
 Package: fuseext2
 Build-Profiles: <!pkg.e2fsprogs.no-fuse2fs>
 Depends: fuse2fs (>= 1.47.1-2), ${misc:Depends}
diff --git a/debian/fuse4fs.install b/debian/fuse4fs.install
new file mode 100644
index 00000000000000..fb8c8ab671c73c
--- /dev/null
+++ b/debian/fuse4fs.install
@@ -0,0 +1,2 @@
+/usr/bin/fuse4fs
+/usr/share/man/man1/fuse4fs.1
diff --git a/debian/rules b/debian/rules
index 4cb80652115317..3240d6bc2640c9 100755
--- a/debian/rules
+++ b/debian/rules
@@ -12,6 +12,7 @@ export LC_ALL ?= C
 
 ifeq ($(DEB_HOST_ARCH_OS), hurd)
 SKIP_FUSE2FS=yes
+SKIP_FUSE4FS=yes
 endif
 
 ifeq ($(DEB_HOST_ARCH_OS), linux)
@@ -22,6 +23,9 @@ endif
 ifneq ($(filter pkg.e2fsprogs.no-fuse2fs,$(DEB_BUILD_PROFILES)),)
 SKIP_FUSE2FS=yes
 endif
+ifneq ($(filter pkg.e2fsprogs.no-fuse4fs,$(DEB_BUILD_PROFILES)),)
+SKIP_FUSE4FS=yes
+endif
 
 ifneq (,$(filter-out parallel=1,$(filter parallel=%,$(DEB_BUILD_OPTIONS))))
     NUMJOBS = $(patsubst parallel=%,%,$(filter parallel=%,$(DEB_BUILD_OPTIONS)))
@@ -60,6 +64,9 @@ COMMON_CONF_FLAGS = --enable-elf-shlibs --disable-ubsan \
 ifneq ($(SKIP_FUSE2FS),)
 COMMON_CONF_FLAGS +=  --disable-fuse2fs
 endif
+ifneq ($(SKIP_FUSE4FS),)
+COMMON_CONF_FLAGS +=  --disable-fuse4fs
+endif
 
 ifneq ($(DEB_BUILD_GNU_TYPE),$(DEB_HOST_GNU_TYPE))
 CC ?= $(DEB_HOST_GNU_TYPE)-gcc
@@ -189,6 +196,10 @@ endif
 ifeq ($(SKIP_FUSE2FS),)
 	dh_shlibdeps -pfuse2fs -l${stdbuilddir}/lib \
 		-- -Ldebian/e2fsprogs.shlibs.local
+endif
+ifeq ($(SKIP_FUSE4FS),)
+	dh_shlibdeps -pfuse4fs -l${stdbuilddir}/lib \
+		-- -Ldebian/e2fsprogs.shlibs.local
 endif
 	dh_shlibdeps --remaining-packages -l${stdbuilddir}/lib
 



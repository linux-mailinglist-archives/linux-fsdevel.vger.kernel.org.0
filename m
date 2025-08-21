Return-Path: <linux-fsdevel+bounces-58475-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D25B2E9EF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 03:04:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACBD117159C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 01:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B4A21B4233;
	Thu, 21 Aug 2025 01:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l2C+ldnl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD314315A
	for <linux-fsdevel@vger.kernel.org>; Thu, 21 Aug 2025 01:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755738082; cv=none; b=Fti5gchGSzcO7iGqNa4+RCjE074i7hSBEIT0HMbsfXSzgvpQ+UZz9fkkF8Br60SHpDTGRciCJO6OEobchh3Yjc3weHlUMrdRnwLYDAwKgpkhNayO6kbDS3A52PndzpbkamLFZ/r4Q0lC80fOWpMJuknl8x+H+z68yIk6S4i2+MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755738082; c=relaxed/simple;
	bh=Xm0x81DDVZi1PMMRPRKy44uIu4rBOgd+/KkjYsiCCbk=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9HBb0PxghKPSzAnlMudsNDJqZb5PgkOvOPOwVFNJr9uKt/rETsxjVCw2LHA+Tw09ihN+qgqVmKOfmID8YI492I497HP1CC3DqF+xyJxkJXtoSDy0vB2KFSS1tyLoqozd6ylC9AVLYsX3Evy1ks7CrGkpMGm/o4Nv5U8aJ7HbSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l2C+ldnl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F4AC4CEE7;
	Thu, 21 Aug 2025 01:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755738082;
	bh=Xm0x81DDVZi1PMMRPRKy44uIu4rBOgd+/KkjYsiCCbk=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=l2C+ldnltq+DD6uFNnpiWrw15Jha5gzptlg192KeZLgYDXrjo7nPM5xoVaKh+fR2c
	 hwxeCu+n0i/0wXl1AFf2fRywp75zmHD9rex6OGEgPQibv3wllfBYNhpmp2tzN3wY9P
	 5yr8Yp792NWzJwnUZ22bK7CGdAVoHJWyw40ra5l090DRYu9P9CsEQqLvNZ6rN3o4bJ
	 gzpulOMQxGXGsbn7p0y0nqEXwCSd2YI7vKowScjkkLJ/UiglfL3WLaRggDsMzEWXOc
	 A/OgUcX+d7nnLV+aAO7OO+jJaXLWCffvlkSZd+OFbRtFlwQB6iMnGIZpOoeSb5DCza
	 yzEkVk1cjBB3g==
Date: Wed, 20 Aug 2025 18:01:21 -0700
Subject: [PATCH 1/1] libfuse: don't put HAVE_STATX in a public header
From: "Darrick J. Wong" <djwong@kernel.org>
To: djwong@kernel.org, bschubert@ddn.com
Cc: John@groves.net, joannelkoong@gmail.com, bernd@bsbernd.com,
 linux-fsdevel@vger.kernel.org, miklos@szeredi.hu, neal@gompa.dev
Message-ID: <175573710994.19062.1523403126247996321.stgit@frogsfrogsfrogs>
In-Reply-To: <175573710975.19062.7329425679466983566.stgit@frogsfrogsfrogs>
References: <175573710975.19062.7329425679466983566.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

fuse.h and fuse_lowlevel.h are public headers, don't expose internal
build system config variables to downstream clients.  This can also lead
to function pointer ordering issues if (say) libfuse gets built with
HAVE_STATX but the client program doesn't define a HAVE_STATX.

Get rid of the conditionals in the public header files to fix this.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 include/fuse.h           |    2 --
 include/fuse_lowlevel.h  |    2 --
 example/memfs_ll.cc      |    2 +-
 example/passthrough.c    |    2 +-
 example/passthrough_fh.c |    2 +-
 example/passthrough_ll.c |    2 +-
 6 files changed, 4 insertions(+), 8 deletions(-)


diff --git a/include/fuse.h b/include/fuse.h
index 06feacb070fbfb..209102651e9454 100644
--- a/include/fuse.h
+++ b/include/fuse.h
@@ -854,7 +854,6 @@ struct fuse_operations {
 	 */
 	off_t (*lseek) (const char *, off_t off, int whence, struct fuse_file_info *);
 
-#ifdef HAVE_STATX
 	/**
 	 * Get extended file attributes.
 	 *
@@ -865,7 +864,6 @@ struct fuse_operations {
 	 */
 	int (*statx)(const char *path, int flags, int mask, struct statx *stxbuf,
 		     struct fuse_file_info *fi);
-#endif
 };
 
 /** Extra context that may be needed by some filesystems
diff --git a/include/fuse_lowlevel.h b/include/fuse_lowlevel.h
index 844ee710295973..8d87be413bfe37 100644
--- a/include/fuse_lowlevel.h
+++ b/include/fuse_lowlevel.h
@@ -1327,7 +1327,6 @@ struct fuse_lowlevel_ops {
 	void (*tmpfile) (fuse_req_t req, fuse_ino_t parent,
 			mode_t mode, struct fuse_file_info *fi);
 
-#ifdef HAVE_STATX
 	/**
 	 * Get extended file attributes.
 	 *
@@ -1343,7 +1342,6 @@ struct fuse_lowlevel_ops {
 	 */
 	void (*statx)(fuse_req_t req, fuse_ino_t ino, int flags, int mask,
 		      struct fuse_file_info *fi);
-#endif
 };
 
 /**
diff --git a/example/memfs_ll.cc b/example/memfs_ll.cc
index edda34b4e43d39..7055a434a439cd 100644
--- a/example/memfs_ll.cc
+++ b/example/memfs_ll.cc
@@ -6,7 +6,7 @@
   See the file GPL2.txt.
 */
 
-#define FUSE_USE_VERSION 317
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
 
 #include <algorithm>
 #include <stdio.h>
diff --git a/example/passthrough.c b/example/passthrough.c
index fdaa19e331a17d..1f09c2dc05df1e 100644
--- a/example/passthrough.c
+++ b/example/passthrough.c
@@ -23,7 +23,7 @@
  */
 
 
-#define FUSE_USE_VERSION 31
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
 
 #define _GNU_SOURCE
 
diff --git a/example/passthrough_fh.c b/example/passthrough_fh.c
index 0d4fb5bd4df0d6..6403fbb74c7759 100644
--- a/example/passthrough_fh.c
+++ b/example/passthrough_fh.c
@@ -23,7 +23,7 @@
  * \include passthrough_fh.c
  */
 
-#define FUSE_USE_VERSION 31
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
 
 #define _GNU_SOURCE
 
diff --git a/example/passthrough_ll.c b/example/passthrough_ll.c
index 5ca6efa2300abe..8a5ac2e9226b59 100644
--- a/example/passthrough_ll.c
+++ b/example/passthrough_ll.c
@@ -35,7 +35,7 @@
  */
 
 #define _GNU_SOURCE
-#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 12)
+#define FUSE_USE_VERSION FUSE_MAKE_VERSION(3, 18)
 
 #include <fuse_lowlevel.h>
 #include <unistd.h>



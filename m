Return-Path: <linux-fsdevel+bounces-66129-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E313C17D92
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 02:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C2171A22152
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Oct 2025 01:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5D552D4807;
	Wed, 29 Oct 2025 01:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AM+1ISLq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E50248176;
	Wed, 29 Oct 2025 01:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761700686; cv=none; b=PPU+L05hsGKVA0AV2QjYvTQqOrfPhoH1UBrR3Pbv75eKlD5zdliPMcuktfrsgHFBgOPuF34SZ9dwNH/p3Hsd+Ck143p5HeSpMXSeulp4VuIx4BEa+iFhbBrXhErbxglDNgdFfzFBJ4saixCL7WRVuQYYbAk/3KiUy+RPcAf9V/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761700686; c=relaxed/simple;
	bh=nRQvE9MwZ+/+BZUZjFs4M4OvqcL50QnEczGl9CIufbY=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rq1ROmI1gPpzuShNCD+X+jMxDHAvEbFwkGshRECIqVB2omX/jnnn7melBI3RpOS3TAxzT3o2t9LMPulW77FYxc1XwzbsMpsKgRULUZkiH5olFR24hPGgqOiG4F+BeGOS7MquevrY0pyKov6jROQEYPXoBAMayFmT8ubXxkiBbFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AM+1ISLq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D049C4CEE7;
	Wed, 29 Oct 2025 01:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761700685;
	bh=nRQvE9MwZ+/+BZUZjFs4M4OvqcL50QnEczGl9CIufbY=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=AM+1ISLqGJsDWGr+NRAWZsjkMSCWkD5TZZWH1RCpQcTAcZ6VPN8ujVqMt/IvQFeR+
	 poVOI97UO96atPRoA/ZQfPrabg14BK6yTjeCB2n5km4tHvXTwm8WknwlrX7VjEMxEx
	 cvOaT+Lw/EtS59w5FPA5vNSIp2gCupAHT7212Lt3FoirMD2fmzwa52Blf7j2hnirlE
	 xBkjmjcNchm0+CyHRM384ULV3YMirMZspAQ9OJHPxW8ObqpATz03dQTSpPn3dGQRQc
	 0vQsdFT5ynBJVtkE8AJ+MRclxid68HZVgqJW0JkzBV/uNG6j9mX9GcuGdwuQc6ISXC
	 WtA2V5YOXttCw==
Date: Tue, 28 Oct 2025 18:18:05 -0700
Subject: [PATCH 4/6] fuse2fs: enable caching IO manager
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-fsdevel@vger.kernel.org, joannelkoong@gmail.com, bernd@bsbernd.com,
 neal@gompa.dev, miklos@szeredi.hu, linux-ext4@vger.kernel.org
Message-ID: <176169818834.1431012.15366269956408461432.stgit@frogsfrogsfrogs>
In-Reply-To: <176169818736.1431012.5858175697736904225.stgit@frogsfrogsfrogs>
References: <176169818736.1431012.5858175697736904225.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Enable the new dynamic iocache I/O manager in the fuse server, and turn
off all the other cache control.

Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 fuse4fs/Makefile.in |    3 ++-
 fuse4fs/fuse4fs.c   |    4 +++-
 misc/Makefile.in    |    4 +++-
 misc/fuse2fs.c      |    6 +++++-
 4 files changed, 13 insertions(+), 4 deletions(-)


diff --git a/fuse4fs/Makefile.in b/fuse4fs/Makefile.in
index 9f3547c271638f..0a558da23ced81 100644
--- a/fuse4fs/Makefile.in
+++ b/fuse4fs/Makefile.in
@@ -147,7 +147,8 @@ fuse4fs.o: $(srcdir)/fuse4fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
  $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
- $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
+ $(top_srcdir)/lib/support/iocache.h
 journal.o: $(srcdir)/../debugfs/journal.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(srcdir)/../debugfs/journal.h \
  $(top_srcdir)/e2fsck/jfs_user.h $(top_srcdir)/e2fsck/e2fsck.h \
diff --git a/fuse4fs/fuse4fs.c b/fuse4fs/fuse4fs.c
index ef73013aa8fcb1..e000fc4195ab59 100644
--- a/fuse4fs/fuse4fs.c
+++ b/fuse4fs/fuse4fs.c
@@ -56,6 +56,7 @@
 #include "support/bthread.h"
 #include "support/list.h"
 #include "support/cache.h"
+#include "support/iocache.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -1575,6 +1576,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
 	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+	iocache_set_backing_manager(unix_io_manager);
 
 	err = fuse4fs_try_losetup(ff, flags);
 	if (err)
@@ -1612,7 +1614,7 @@ static errcode_t fuse4fs_open(struct fuse4fs *ff)
 	deadline = init_deadline(FUSE4FS_OPEN_TIMEOUT);
 	do {
 		err = ext2fs_open2(fuse4fs_device(ff), options, flags, 0, 0,
-				   unix_io_manager, &ff->fs);
+				   iocache_io_manager, &ff->fs);
 		if ((err == EPERM || err == EACCES) &&
 		    (!ff->ro || (flags & EXT2_FLAG_RW))) {
 			/*
diff --git a/misc/Makefile.in b/misc/Makefile.in
index ec964688acd623..8a3adc70fb736e 100644
--- a/misc/Makefile.in
+++ b/misc/Makefile.in
@@ -880,7 +880,9 @@ fuse2fs.o: $(srcdir)/fuse2fs.c $(top_builddir)/lib/config.h \
  $(top_srcdir)/lib/ext2fs/ext2_ext_attr.h $(top_srcdir)/lib/ext2fs/hashmap.h \
  $(top_srcdir)/lib/ext2fs/bitops.h $(top_srcdir)/lib/ext2fs/ext2fsP.h \
  $(top_srcdir)/lib/ext2fs/ext2fs.h $(top_srcdir)/version.h \
- $(top_srcdir)/lib/e2p/e2p.h
+ $(top_srcdir)/lib/e2p/e2p.h $(top_srcdir)/lib/support/cache.h \
+ $(top_srcdir)/lib/support/list.h $(top_srcdir)/lib/support/xbitops.h \
+ $(top_srcdir)/lib/support/iocache.h
 e2fuzz.o: $(srcdir)/e2fuzz.c $(top_builddir)/lib/config.h \
  $(top_builddir)/lib/dirpaths.h $(top_srcdir)/lib/ext2fs/ext2_fs.h \
  $(top_builddir)/lib/ext2fs/ext2_types.h $(top_srcdir)/lib/ext2fs/ext2fs.h \
diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index b359e91f7b9e9b..fb31183d4cd895 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -53,6 +53,9 @@
 #include "ext2fs/ext2_fs.h"
 #include "ext2fs/ext2fsP.h"
 #include "support/bthread.h"
+#include "support/list.h"
+#include "support/cache.h"
+#include "support/iocache.h"
 
 #include "../version.h"
 #include "uuid/uuid.h"
@@ -1405,6 +1408,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 		flags |= EXT2_FLAG_DIRECT_IO;
 
 	dbg_printf(ff, "opening with flags=0x%x\n", flags);
+	iocache_set_backing_manager(unix_io_manager);
 
 	err = fuse2fs_try_losetup(ff, flags);
 	if (err)
@@ -1442,7 +1446,7 @@ static errcode_t fuse2fs_open(struct fuse2fs *ff)
 	deadline = init_deadline(FUSE2FS_OPEN_TIMEOUT);
 	do {
 		err = ext2fs_open2(fuse2fs_device(ff), options, flags, 0, 0,
-				   unix_io_manager, &ff->fs);
+				   iocache_io_manager, &ff->fs);
 		if ((err == EPERM || err == EACCES) &&
 		    (!ff->ro || (flags & EXT2_FLAG_RW))) {
 			/*



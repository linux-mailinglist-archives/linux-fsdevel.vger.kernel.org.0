Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44964B1BD4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 12:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387889AbfIMK6J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 06:58:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:48100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387424AbfIMK6J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:58:09 -0400
Received: from tleilax.poochiereds.net.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E22252089F;
        Fri, 13 Sep 2019 10:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568372288;
        bh=xTthybmuTE2hi+1VU+wPKx1CKEtzS271P9b305s10vA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ghUqX0xEYCBLWrQhoNP5vpo0WhWPup+L8OBy5zBJJ5GFwpO1uEXjaGbyHQ4rtuY1u
         DlLmKCNmMKKYx+E9fW6nG7avG74Y9Ry6Kevq2zbpkqAc040nhB9iEWlJIbcNdi44om
         vbynN2Oz7254PVRlpvrl4LmUI2znBZanLDXxptgU=
From:   Jeff Layton <jlayton@kernel.org>
To:     coreutils@gnu.org
Cc:     adilger@dilger.ca, dhowells@redhat.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [coreutils PATCH v2 1/2] stat: move struct statx to struct stat conversion routines to new header
Date:   Fri, 13 Sep 2019 06:58:04 -0400
Message-Id: <20190913105805.24669-2-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190913105805.24669-1-jlayton@kernel.org>
References: <20190913105805.24669-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* move statx_timestamp_to_timespec and statx_to_stat to a new header
---
 src/stat.c  | 32 +------------------------------
 src/statx.h | 54 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+), 31 deletions(-)
 create mode 100644 src/statx.h

diff --git a/src/stat.c b/src/stat.c
index ee68f1682bc8..f2bf0dcb7901 100644
--- a/src/stat.c
+++ b/src/stat.c
@@ -73,6 +73,7 @@
 #include "strftime.h"
 #include "find-mount-point.h"
 #include "xvasprintf.h"
+#include "statx.h"
 
 #if HAVE_STATX && defined STATX_INO
 # define USE_STATX 1
@@ -1245,37 +1246,6 @@ static bool dont_sync;
 static bool force_sync;
 
 #if USE_STATX
-/* Much of the format printing requires a struct stat or timespec */
-static struct timespec
-statx_timestamp_to_timespec (struct statx_timestamp tsx)
-{
-  struct timespec ts;
-
-  ts.tv_sec = tsx.tv_sec;
-  ts.tv_nsec = tsx.tv_nsec;
-  return ts;
-}
-
-static void
-statx_to_stat (struct statx *stx, struct stat *stat)
-{
-  stat->st_dev = makedev (stx->stx_dev_major, stx->stx_dev_minor);
-  stat->st_ino = stx->stx_ino;
-  stat->st_mode = stx->stx_mode;
-  stat->st_nlink = stx->stx_nlink;
-  stat->st_uid = stx->stx_uid;
-  stat->st_gid = stx->stx_gid;
-  stat->st_rdev = makedev (stx->stx_rdev_major, stx->stx_rdev_minor);
-  stat->st_size = stx->stx_size;
-  stat->st_blksize = stx->stx_blksize;
-/* define to avoid sc_prohibit_stat_st_blocks.  */
-# define SC_ST_BLOCKS st_blocks
-  stat->SC_ST_BLOCKS = stx->stx_blocks;
-  stat->st_atim = statx_timestamp_to_timespec (stx->stx_atime);
-  stat->st_mtim = statx_timestamp_to_timespec (stx->stx_mtime);
-  stat->st_ctim = statx_timestamp_to_timespec (stx->stx_ctime);
-}
-
 static unsigned int
 fmt_to_mask (char fmt)
 {
diff --git a/src/statx.h b/src/statx.h
new file mode 100644
index 000000000000..a98ec10de380
--- /dev/null
+++ b/src/statx.h
@@ -0,0 +1,54 @@
+/* statx -> stat conversion functions for coreutils
+   Copyright (C) 2019 Free Software Foundation, Inc.
+
+   This program is free software: you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation, either version 3 of the License, or
+   (at your option) any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License
+   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */
+
+#ifndef COREUTILS_STATX_H
+# define COREUTILS_STATX_H
+
+#include <sys/stat.h>
+
+#if HAVE_STATX && defined STATX_INO
+/* Much of the format printing requires a struct stat or timespec */
+static inline struct timespec
+statx_timestamp_to_timespec (struct statx_timestamp tsx)
+{
+  struct timespec ts;
+
+  ts.tv_sec = tsx.tv_sec;
+  ts.tv_nsec = tsx.tv_nsec;
+  return ts;
+}
+
+static inline void
+statx_to_stat (struct statx *stx, struct stat *stat)
+{
+  stat->st_dev = makedev (stx->stx_dev_major, stx->stx_dev_minor);
+  stat->st_ino = stx->stx_ino;
+  stat->st_mode = stx->stx_mode;
+  stat->st_nlink = stx->stx_nlink;
+  stat->st_uid = stx->stx_uid;
+  stat->st_gid = stx->stx_gid;
+  stat->st_rdev = makedev (stx->stx_rdev_major, stx->stx_rdev_minor);
+  stat->st_size = stx->stx_size;
+  stat->st_blksize = stx->stx_blksize;
+/* define to avoid sc_prohibit_stat_st_blocks.  */
+# define SC_ST_BLOCKS st_blocks
+  stat->SC_ST_BLOCKS = stx->stx_blocks;
+  stat->st_atim = statx_timestamp_to_timespec (stx->stx_atime);
+  stat->st_mtim = statx_timestamp_to_timespec (stx->stx_mtime);
+  stat->st_ctim = statx_timestamp_to_timespec (stx->stx_ctime);
+}
+#endif /* HAVE_STATX && defined STATX_INO */
+#endif /* COREUTILS_STATX_H */
-- 
2.21.0


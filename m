Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BBCD3B1BD8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Sep 2019 12:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387896AbfIMK6L (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Sep 2019 06:58:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387865AbfIMK6K (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Sep 2019 06:58:10 -0400
Received: from tleilax.poochiereds.net.com (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AEE8208C2;
        Fri, 13 Sep 2019 10:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1568372289;
        bh=MDxzN3viBo9XfwZp9lDIicUT4RQBxPKTfc7l/HQje/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRLsjvBqQisTcqzNX6bpHNh9Yvu1286Qljt8hHXFw9UD3Gc3lX6UJC9xB8acW2IzK
         q/6LTGZEkjxu/gVkP+y85AXwd3vzH+5mzd2XfpUiNCqC8orSfJLkIDociYkhnF6Xqp
         GTar3nG9cwM/x7Vr8bt5JImBKATU6jnAYmVJDMc8=
From:   Jeff Layton <jlayton@kernel.org>
To:     coreutils@gnu.org
Cc:     adilger@dilger.ca, dhowells@redhat.com, ceph-devel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [coreutils PATCH v2 2/2] ls: use statx instead of stat when available
Date:   Fri, 13 Sep 2019 06:58:05 -0400
Message-Id: <20190913105805.24669-3-jlayton@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190913105805.24669-1-jlayton@kernel.org>
References: <20190913105805.24669-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

* add wrapper functions for stat/lstat/fstat calls, and add variants for
  when we are only interested in specific info
* add statx-enabled functions and set the request mask based on the
  output format and what values are needed
* for loop detection, use AT_STATX_DONT_SYNC since we're only interested
  in the dev/ino and that should never change
---
 src/ls.c | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 7 deletions(-)

diff --git a/src/ls.c b/src/ls.c
index 120ce153e340..003a69aaa280 100644
--- a/src/ls.c
+++ b/src/ls.c
@@ -114,6 +114,7 @@
 #include "xgethostname.h"
 #include "c-ctype.h"
 #include "canonicalize.h"
+#include "statx.h"
 
 /* Include <sys/capability.h> last to avoid a clash of <sys/types.h>
    include guards with some premature versions of libcap.
@@ -1063,6 +1064,97 @@ dired_dump_obstack (const char *prefix, struct obstack *os)
     }
 }
 
+#if HAVE_STATX && defined STATX_INO
+static unsigned int
+calc_req_mask (void)
+{
+  unsigned int mask = STATX_MODE;
+
+  if (print_inode)
+    mask |= STATX_INO;
+  if (format == long_format) {
+    mask |= STATX_NLINK | STATX_SIZE;
+    if (print_owner || print_author)
+      mask |= STATX_UID;
+    if (print_group)
+      mask |= STATX_GID;
+  }
+  return mask;
+}
+
+static int
+do_statx (int fd, const char *name, struct stat *st, int flags,
+	  unsigned int mask)
+{
+  struct statx stx;
+  int ret = statx (fd, name, flags, mask, &stx);
+  if (ret >= 0)
+    statx_to_stat (&stx, st);
+  return ret;
+}
+
+static inline int
+do_stat (const char *name, struct stat *st)
+{
+  return do_statx (AT_FDCWD, name, st, 0, calc_req_mask());
+}
+
+static inline int
+do_lstat (const char *name, struct stat *st)
+{
+  return do_statx (AT_FDCWD, name, st, AT_SYMLINK_NOFOLLOW, calc_req_mask());
+}
+
+static inline int
+stat_for_mode (const char *name, struct stat *st)
+{
+  return do_statx (AT_FDCWD, name, st, 0, STATX_MODE);
+}
+
+/* dev+ino should be static, so no need to sync with backing store */
+static inline int
+stat_for_ino (const char *name, struct stat *st)
+{
+  return do_statx (AT_FDCWD, name, st, AT_STATX_DONT_SYNC, STATX_INO);
+}
+
+static inline int
+fstat_for_ino (int fd, struct stat *st)
+{
+  return do_statx (fd, "", st, AT_EMPTY_PATH|AT_STATX_DONT_SYNC, STATX_INO);
+}
+#else
+static inline int
+do_stat (const char *name, struct stat *st)
+{
+  return stat (name, st);
+}
+
+static inline int
+do_lstat (const char *name, struct stat *st)
+{
+  return lstat (name, st);
+}
+
+static inline int
+stat_for_mode (const char *name, struct stat *st)
+{
+  return stat (name, st);
+}
+
+static inline int
+stat_for_ino (const char *name, struct stat *st)
+{
+  return stat (name, st);
+}
+
+static inline int
+fstat_for_ino (int fd, struct stat *st)
+{
+  return fstat (fd, st);
+}
+#endif
+
 /* Return the address of the first plain %b spec in FMT, or NULL if
    there is no such spec.  %5b etc. do not match, so that user
    widths/flags are honored.  */
@@ -2737,10 +2829,10 @@ print_dir (char const *name, char const *realname, bool command_line_arg)
       struct stat dir_stat;
       int fd = dirfd (dirp);
 
-      /* If dirfd failed, endure the overhead of using stat.  */
+      /* If dirfd failed, endure the overhead of stat'ing by path  */
       if ((0 <= fd
-           ? fstat (fd, &dir_stat)
-           : stat (name, &dir_stat)) < 0)
+           ? fstat_for_ino (fd, &dir_stat)
+           : stat_for_ino (name, &dir_stat)) < 0)
         {
           file_failure (command_line_arg,
                         _("cannot determine device and inode of %s"), name);
@@ -3202,7 +3294,7 @@ gobble_file (char const *name, enum filetype type, ino_t inode,
       switch (dereference)
         {
         case DEREF_ALWAYS:
-          err = stat (full_name, &f->stat);
+          err = do_stat (full_name, &f->stat);
           do_deref = true;
           break;
 
@@ -3211,7 +3303,7 @@ gobble_file (char const *name, enum filetype type, ino_t inode,
           if (command_line_arg)
             {
               bool need_lstat;
-              err = stat (full_name, &f->stat);
+              err = do_stat (full_name, &f->stat);
               do_deref = true;
 
               if (dereference == DEREF_COMMAND_LINE_ARGUMENTS)
@@ -3231,7 +3323,7 @@ gobble_file (char const *name, enum filetype type, ino_t inode,
           FALLTHROUGH;
 
         default: /* DEREF_NEVER */
-          err = lstat (full_name, &f->stat);
+          err = do_lstat (full_name, &f->stat);
           do_deref = false;
           break;
         }
@@ -3320,7 +3412,7 @@ gobble_file (char const *name, enum filetype type, ino_t inode,
              they won't be traced and when no indicator is needed.  */
           if (linkname
               && (file_type <= indicator_style || check_symlink_mode)
-              && stat (linkname, &linkstats) == 0)
+              && stat_for_mode(linkname, &linkstats) == 0)
             {
               f->linkok = true;
               f->linkmode = linkstats.st_mode;
-- 
2.21.0


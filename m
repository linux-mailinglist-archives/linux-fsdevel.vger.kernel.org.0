Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B471B21D80
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbfEQShX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:23 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57598 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729361AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj2-0000oZ-Ui; Fri, 17 May 2019 14:37:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 11/22] coda: change Coda's user api to use 64-bit time_t in timespec
Date:   Fri, 17 May 2019 14:36:49 -0400
Message-Id: <8d089068823bfb292a4020f773922fbd82ffad39.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Move the 32-bit time_t problems to userspace.

Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 Documentation/filesystems/coda.txt | 10 ++++-----
 fs/coda/coda_linux.c               | 21 +++++++------------
 include/uapi/linux/coda.h          | 33 +++++++-----------------------
 3 files changed, 19 insertions(+), 45 deletions(-)

diff --git a/Documentation/filesystems/coda.txt b/Documentation/filesystems/coda.txt
index ea5969068895..545262c167c3 100644
--- a/Documentation/filesystems/coda.txt
+++ b/Documentation/filesystems/coda.txt
@@ -481,8 +481,8 @@ kernel support.
 
 
 
-  struct vtimespec {
-          long            tv_sec;         /* seconds */
+  struct coda_timespec {
+          int64_t         tv_sec;         /* seconds */
           long            tv_nsec;        /* nanoseconds */
   };
 
@@ -496,9 +496,9 @@ kernel support.
           long            va_fileid;      /* file id */
           u_quad_t        va_size;        /* file size in bytes */
           long            va_blocksize;   /* blocksize preferred for i/o */
-          struct vtimespec va_atime;      /* time of last access */
-          struct vtimespec va_mtime;      /* time of last modification */
-          struct vtimespec va_ctime;      /* time file changed */
+          struct coda_timespec va_atime;  /* time of last access */
+          struct coda_timespec va_mtime;  /* time of last modification */
+          struct coda_timespec va_ctime;  /* time file changed */
           u_long          va_gen;         /* generation number of file */
           u_long          va_flags;       /* flags defined for file */
           dev_t           va_rdev;        /* device special file represents */
diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index 8addcd166908..e4b5f02f0dd4 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -66,13 +66,8 @@ unsigned short coda_flags_to_cflags(unsigned short flags)
 	return coda_flags;
 }
 
-static struct timespec64 coda_to_timespec64(struct vtimespec ts)
+static struct timespec64 coda_to_timespec64(struct coda_timespec ts)
 {
-	/*
-	 * We interpret incoming timestamps as 'signed' to match traditional
-	 * usage and support pre-1970 timestamps, but this breaks in y2038
-	 * on 32-bit machines.
-	 */
 	struct timespec64 ts64 = {
 		.tv_sec = ts.tv_sec,
 		.tv_nsec = ts.tv_nsec,
@@ -81,12 +76,10 @@ static struct timespec64 coda_to_timespec64(struct vtimespec ts)
 	return ts64;
 }
 
-static struct vtimespec timespec64_to_coda(struct timespec64 ts64)
+static struct coda_timespec timespec64_to_coda(struct timespec64 ts64)
 {
-	/* clamp the timestamps to the maximum range rather than wrapping */
-	struct vtimespec ts = {
-		.tv_sec = lower_32_bits(clamp_t(time64_t, ts64.tv_sec,
-						LONG_MIN, LONG_MAX)),
+	struct coda_timespec ts = {
+		.tv_sec = ts64.tv_sec,
 		.tv_nsec = ts64.tv_nsec,
 	};
 
@@ -156,11 +149,11 @@ void coda_iattr_to_vattr(struct iattr *iattr, struct coda_vattr *vattr)
         vattr->va_uid = (vuid_t) -1; 
         vattr->va_gid = (vgid_t) -1;
         vattr->va_size = (off_t) -1;
-	vattr->va_atime.tv_sec = (long) -1;
+	vattr->va_atime.tv_sec = (int64_t) -1;
 	vattr->va_atime.tv_nsec = (long) -1;
-	vattr->va_mtime.tv_sec = (long) -1;
+	vattr->va_mtime.tv_sec = (int64_t) -1;
 	vattr->va_mtime.tv_nsec = (long) -1;
-	vattr->va_ctime.tv_sec = (long) -1;
+	vattr->va_ctime.tv_sec = (int64_t) -1;
 	vattr->va_ctime.tv_nsec = (long) -1;
         vattr->va_type = C_VNON;
 	vattr->va_fileid = -1;
diff --git a/include/uapi/linux/coda.h b/include/uapi/linux/coda.h
index fc5f7874208a..5dba636b6e11 100644
--- a/include/uapi/linux/coda.h
+++ b/include/uapi/linux/coda.h
@@ -86,10 +86,6 @@ typedef unsigned long long u_quad_t;
 
 #define inline
 
-struct timespec {
-        long       ts_sec;
-        long       ts_nsec;
-};
 #else  /* DJGPP but not KERNEL */
 #include <sys/time.h>
 typedef unsigned long long u_quad_t;
@@ -110,13 +106,6 @@ typedef unsigned long long u_quad_t;
 #define cdev_t dev_t
 #endif
 
-#ifdef __CYGWIN32__
-struct timespec {
-        time_t  tv_sec;         /* seconds */
-        long    tv_nsec;        /* nanoseconds */
-};
-#endif
-
 #ifndef __BIT_TYPES_DEFINED__
 #define __BIT_TYPES_DEFINED__
 typedef signed char	      int8_t;
@@ -211,19 +200,10 @@ struct CodaFid {
  */
 enum coda_vtype	{ C_VNON, C_VREG, C_VDIR, C_VBLK, C_VCHR, C_VLNK, C_VSOCK, C_VFIFO, C_VBAD };
 
-#ifdef __linux__
-/*
- * This matches the traditional Linux 'timespec' structure binary layout,
- * before using 64-bit time_t everywhere. Overflows in y2038 on 32-bit
- * architectures.
- */
-struct vtimespec {
-	long		tv_sec;		/* seconds */
+struct coda_timespec {
+	int64_t		tv_sec;		/* seconds */
 	long		tv_nsec;	/* nanoseconds */
 };
-#else
-#define vtimespec timespec
-#endif
 
 struct coda_vattr {
 	long     	va_type;	/* vnode type (for create) */
@@ -234,9 +214,9 @@ struct coda_vattr {
 	long		va_fileid;	/* file id */
 	u_quad_t	va_size;	/* file size in bytes */
 	long		va_blocksize;	/* blocksize preferred for i/o */
-	struct vtimespec va_atime;	/* time of last access */
-	struct vtimespec va_mtime;	/* time of last modification */
-	struct vtimespec va_ctime;	/* time file changed */
+	struct coda_timespec va_atime;	/* time of last access */
+	struct coda_timespec va_mtime;	/* time of last modification */
+	struct coda_timespec va_ctime;	/* time file changed */
 	u_long		va_gen;		/* generation number of file */
 	u_long		va_flags;	/* flags defined for file */
 	cdev_t	        va_rdev;	/* device special file represents */
@@ -301,7 +281,8 @@ struct coda_statfs {
 
 #define CIOC_KERNEL_VERSION _IOWR('c', 10, size_t)
 
-#define CODA_KERNEL_VERSION 3 /* 128-bit file identifiers */
+//      CODA_KERNEL_VERSION 3 /* 128-bit file identifiers */
+#define CODA_KERNEL_VERSION 4 /* 64-bit timespec */
 
 /*
  *        Venus <-> Coda  RPC arguments
-- 
2.20.1


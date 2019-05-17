Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474BF21D78
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 May 2019 20:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728865AbfEQShQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 May 2019 14:37:16 -0400
Received: from hurricane.elijah.cs.cmu.edu ([128.2.209.191]:57606 "EHLO
        hurricane.elijah.cs.cmu.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729367AbfEQShC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 May 2019 14:37:02 -0400
Received: from jaharkes by hurricane.elijah.cs.cmu.edu with local (Exim 4.92)
        (envelope-from <jaharkes@hurricane.elijah.cs.cmu.edu>)
        id 1hRhj2-0000oU-Tg; Fri, 17 May 2019 14:37:00 -0400
From:   Jan Harkes <jaharkes@cs.cmu.edu>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Jan Harkes <jaharkes@cs.cmu.edu>, linux-fsdevel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 10/22] coda: stop using 'struct timespec' in user API
Date:   Fri, 17 May 2019 14:36:48 -0400
Message-Id: <562b7324149461743e4fbe2fedbf7c242f7e274a.1558117389.git.jaharkes@cs.cmu.edu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1558117389.git.jaharkes@cs.cmu.edu>
References: <cover.1558117389.git.jaharkes@cs.cmu.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

We exchange file timestamps with user space using psdev device
read/write operations with a fixed but architecture specific binary
layout.

On 32-bit systems, this uses a 'timespec' structure that is defined by
the C library to contain two 32-bit values for seconds and nanoseconds.
As we get ready for the year 2038 overflow of the 32-bit signed seconds,
the kernel now uses 64-bit timestamps internally, and user space will
do the same change by changing the 'timespec' definition in the future.

Unfortunately, this breaks the layout of the coda_vattr structure, so
we need to redefine that in terms of something that does not change.
I'm introducing a new 'struct vtimespec' structure here that keeps
the existing layout, and the same change has to be done in the coda
user space copy of linux/coda.h before anyone can use that on a 32-bit
architecture with 64-bit time_t.

An open question is what should happen to actual times past y2038,
as they are now truncated to the last valid date when sent to user
space, and interpreted as pre-1970 times when a timestamp with the
MSB set is read back into the kernel. Alternatively, we could
change the new timespec64_to_coda()/coda_to_timespec64() functions
to use a different interpretation and extend the available range
further to the future by disallowing past timestamps. This would
require more changes in the user space side though.

Acked-by: Jan Harkes <jaharkes@cs.cmu.edu>
Link: https://patchwork.kernel.org/patch/10474735/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Jan Harkes <jaharkes@cs.cmu.edu>
---
 Documentation/filesystems/coda.txt | 11 ++++---
 fs/coda/coda_linux.c               | 50 +++++++++++++++++++++++-------
 include/uapi/linux/coda.h          | 20 ++++++++++--
 3 files changed, 62 insertions(+), 19 deletions(-)

diff --git a/Documentation/filesystems/coda.txt b/Documentation/filesystems/coda.txt
index 61311356025d..ea5969068895 100644
--- a/Documentation/filesystems/coda.txt
+++ b/Documentation/filesystems/coda.txt
@@ -481,7 +481,10 @@ kernel support.
 
 
 
-
+  struct vtimespec {
+          long            tv_sec;         /* seconds */
+          long            tv_nsec;        /* nanoseconds */
+  };
 
   struct coda_vattr {
           enum coda_vtype va_type;        /* vnode type (for create) */
@@ -493,9 +496,9 @@ kernel support.
           long            va_fileid;      /* file id */
           u_quad_t        va_size;        /* file size in bytes */
           long            va_blocksize;   /* blocksize preferred for i/o */
-          struct timespec va_atime;       /* time of last access */
-          struct timespec va_mtime;       /* time of last modification */
-          struct timespec va_ctime;       /* time file changed */
+          struct vtimespec va_atime;      /* time of last access */
+          struct vtimespec va_mtime;      /* time of last modification */
+          struct vtimespec va_ctime;      /* time file changed */
           u_long          va_gen;         /* generation number of file */
           u_long          va_flags;       /* flags defined for file */
           dev_t           va_rdev;        /* device special file represents */
diff --git a/fs/coda/coda_linux.c b/fs/coda/coda_linux.c
index f3d543dd9a98..8addcd166908 100644
--- a/fs/coda/coda_linux.c
+++ b/fs/coda/coda_linux.c
@@ -66,6 +66,32 @@ unsigned short coda_flags_to_cflags(unsigned short flags)
 	return coda_flags;
 }
 
+static struct timespec64 coda_to_timespec64(struct vtimespec ts)
+{
+	/*
+	 * We interpret incoming timestamps as 'signed' to match traditional
+	 * usage and support pre-1970 timestamps, but this breaks in y2038
+	 * on 32-bit machines.
+	 */
+	struct timespec64 ts64 = {
+		.tv_sec = ts.tv_sec,
+		.tv_nsec = ts.tv_nsec,
+	};
+
+	return ts64;
+}
+
+static struct vtimespec timespec64_to_coda(struct timespec64 ts64)
+{
+	/* clamp the timestamps to the maximum range rather than wrapping */
+	struct vtimespec ts = {
+		.tv_sec = lower_32_bits(clamp_t(time64_t, ts64.tv_sec,
+						LONG_MIN, LONG_MAX)),
+		.tv_nsec = ts64.tv_nsec,
+	};
+
+	return ts;
+}
 
 /* utility functions below */
 void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
@@ -105,11 +131,11 @@ void coda_vattr_to_iattr(struct inode *inode, struct coda_vattr *attr)
 	if (attr->va_size != -1)
 		inode->i_blocks = (attr->va_size + 511) >> 9;
 	if (attr->va_atime.tv_sec != -1) 
-		inode->i_atime = timespec_to_timespec64(attr->va_atime);
+		inode->i_atime = coda_to_timespec64(attr->va_atime);
 	if (attr->va_mtime.tv_sec != -1)
-		inode->i_mtime = timespec_to_timespec64(attr->va_mtime);
+		inode->i_mtime = coda_to_timespec64(attr->va_mtime);
         if (attr->va_ctime.tv_sec != -1)
-		inode->i_ctime = timespec_to_timespec64(attr->va_ctime);
+		inode->i_ctime = coda_to_timespec64(attr->va_ctime);
 }
 
 
@@ -130,12 +156,12 @@ void coda_iattr_to_vattr(struct iattr *iattr, struct coda_vattr *vattr)
         vattr->va_uid = (vuid_t) -1; 
         vattr->va_gid = (vgid_t) -1;
         vattr->va_size = (off_t) -1;
-	vattr->va_atime.tv_sec = (time_t) -1;
-	vattr->va_atime.tv_nsec =  (time_t) -1;
-        vattr->va_mtime.tv_sec = (time_t) -1;
-        vattr->va_mtime.tv_nsec = (time_t) -1;
-	vattr->va_ctime.tv_sec = (time_t) -1;
-	vattr->va_ctime.tv_nsec = (time_t) -1;
+	vattr->va_atime.tv_sec = (long) -1;
+	vattr->va_atime.tv_nsec = (long) -1;
+	vattr->va_mtime.tv_sec = (long) -1;
+	vattr->va_mtime.tv_nsec = (long) -1;
+	vattr->va_ctime.tv_sec = (long) -1;
+	vattr->va_ctime.tv_nsec = (long) -1;
         vattr->va_type = C_VNON;
 	vattr->va_fileid = -1;
 	vattr->va_gen = -1;
@@ -175,13 +201,13 @@ void coda_iattr_to_vattr(struct iattr *iattr, struct coda_vattr *vattr)
                 vattr->va_size = iattr->ia_size;
 	}
         if ( valid & ATTR_ATIME ) {
-		vattr->va_atime = timespec64_to_timespec(iattr->ia_atime);
+		vattr->va_atime = timespec64_to_coda(iattr->ia_atime);
 	}
         if ( valid & ATTR_MTIME ) {
-		vattr->va_mtime = timespec64_to_timespec(iattr->ia_mtime);
+		vattr->va_mtime = timespec64_to_coda(iattr->ia_mtime);
 	}
         if ( valid & ATTR_CTIME ) {
-		vattr->va_ctime = timespec64_to_timespec(iattr->ia_ctime);
+		vattr->va_ctime = timespec64_to_coda(iattr->ia_ctime);
 	}
 }
 
diff --git a/include/uapi/linux/coda.h b/include/uapi/linux/coda.h
index ed8cb263e482..fc5f7874208a 100644
--- a/include/uapi/linux/coda.h
+++ b/include/uapi/linux/coda.h
@@ -211,6 +211,20 @@ struct CodaFid {
  */
 enum coda_vtype	{ C_VNON, C_VREG, C_VDIR, C_VBLK, C_VCHR, C_VLNK, C_VSOCK, C_VFIFO, C_VBAD };
 
+#ifdef __linux__
+/*
+ * This matches the traditional Linux 'timespec' structure binary layout,
+ * before using 64-bit time_t everywhere. Overflows in y2038 on 32-bit
+ * architectures.
+ */
+struct vtimespec {
+	long		tv_sec;		/* seconds */
+	long		tv_nsec;	/* nanoseconds */
+};
+#else
+#define vtimespec timespec
+#endif
+
 struct coda_vattr {
 	long     	va_type;	/* vnode type (for create) */
 	u_short		va_mode;	/* files access mode and type */
@@ -220,9 +234,9 @@ struct coda_vattr {
 	long		va_fileid;	/* file id */
 	u_quad_t	va_size;	/* file size in bytes */
 	long		va_blocksize;	/* blocksize preferred for i/o */
-	struct timespec	va_atime;	/* time of last access */
-	struct timespec	va_mtime;	/* time of last modification */
-	struct timespec	va_ctime;	/* time file changed */
+	struct vtimespec va_atime;	/* time of last access */
+	struct vtimespec va_mtime;	/* time of last modification */
+	struct vtimespec va_ctime;	/* time file changed */
 	u_long		va_gen;		/* generation number of file */
 	u_long		va_flags;	/* flags defined for file */
 	cdev_t	        va_rdev;	/* device special file represents */
-- 
2.20.1


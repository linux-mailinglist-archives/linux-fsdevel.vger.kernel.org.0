Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E10DAF8F50
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 13:09:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfKLMJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 07:09:25 -0500
Received: from mout.kundenserver.de ([212.227.126.131]:38291 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfKLMJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:09:25 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M5wc7-1iWS7m0Jz9-007Wwo; Tue, 12 Nov 2019 13:09:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 2/5] xfs: [variant B] add time64 version of xfs_bstat
Date:   Tue, 12 Nov 2019 13:09:07 +0100
Message-Id: <20191112120910.1977003-3-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191112120910.1977003-1-arnd@arndb.de>
References: <20191112120910.1977003-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:jiVvlZRTcjUi6N1yWhBCvkvO/6X1upQQxrwA10MpiBYzb8YRwsd
 4w13ivj29TxJf6F0LldXSFparEDGUJqpRiyJ7d8okkMYjK/kN+3AAvF+7wIKodSDLf4+AIg
 Q2w2iYgcavEI57zYWfwN+cOlDbNqNXtSyPpFzlpqg5XUPlgI0upvNKY42fiF7rWJ4cpDMi2
 zRDKaNazYgYg00YF8+sUg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:EpWAn4ma5/Q=:1fXXGECpSEn4+JNBZ1kReZ
 Huylw6F676dON2BmteIJF03Rsx0hTg74d77wQ049fTkq13Vwd2jLoShv5T4YfO8n2245LpjDg
 u0E86o7ehoY2+r1xLg/lQ3n2JzAtmI9Xh/X9mvfYjiRIdCTgLesJZ4vDjfXZ8GUmAmtdE2nLb
 9CZvZBvIhHcFG0Epj1KgX2Iuc0Sys1WqoTepMZte9t1YXfPh+6Ce0AdiM42t4nhMRV5hL3RNB
 ONng4JclV9dOWqU+kNKXtT/dRsqevPPoPM8OTb/YYnljkk+hEnjBITmMDi7t3EQ0TciBGEf13
 nz7bjg3d0L0bToL2dc2JYhOBqqvyUjR3lqTscTJlA5tX7vH+o6d/Gp9ZB81n9XOSJe+GV7Cf6
 LF54a7CiCQkIKR3MmDOjYkJPTVoPdkIoVvnfKwebN7vq/DPIiZQ+Gdhn4VN3blGX7KOayqTxq
 fX4gxEg2MwWdqKDz3ofMHDONljPKLKtl8BisAmCDYKkuhS0ct2fCFcc0+/JoZUNQExcAKyDje
 edQgJ6+IxspjXzCOMrqvpshKgqKpoAL90Iv5luY38JuCI04C/WnJdLrQ0POe3uP1E5OZrRsLH
 Qi5aAWlRqnowBbFvzN9kCdk97IUyqcMcmhaihzQy44hyYIw37C+cB7kQkhHQtC2HGw5PjsvIu
 hc69OC0Hg0HvU8MdW0jQCrqUM1X4SfWWV3lAGPgD1inQmFEuoQwrBtvXMaHkHQ/AvJ5EOe/HB
 qLjOqT+SmTur1lvC4nIlRC1wZ23igYE8aW+dGAuA4Yxm7z9Od9mSA9S/pSIpAxyK+uaivNzEY
 4tWLGG+iqiQGUiIFq9bxNJuC6xvfdq9V8rgiwdkRm2htWyLK8IT1ig2gkEOv+yjkDFPF561bJ
 x9Hmf9Lr8NJL4d5ExSAg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The ioctl definitions for XFS_IOC_SWAPEXT, XFS_IOC_FSBULKSTAT and
XFS_IOC_FSBULKSTAT_SINGLE are part of libxfs and based on time_t.

The definition for time_t differs between current kernels and coming
32-bit libc variants that define it as 64-bit. For most ioctls, that
means the kernel has to be able to handle two different command codes
based on the different structure sizes.

The same solution is be applied for XFS_IOC_SWAPEXT, but it would does
work for XFS_IOC_FSBULKSTAT and XFS_IOC_FSBULKSTAT_SINGLE because the
structure with the time_t is passed through an indirect pointer, and
the command number itself is based on struct xfs_fsop_bulkreq, which
does not differ based on time_t.

The best workaround I could come up with is to change the header file to
define new command numbers with the same structure and have users pick
one or the other at compile-time based on the time_t definition in the
C library, like:

 #define XFS_IOC_FSBULKSTAT_OLD _IOWR('X', 101, struct xfs_fsop_bulkreq)
 #define XFS_IOC_FSBULKSTAT_NEW _IOWR('X', 129, struct xfs_fsop_bulkreq)
 #define XFS_IOC_FSBULKSTAT ((sizeof(time_t) == sizeof(__kernel_long_t)) ? \
                             XFS_IOC_FSBULKSTAT_OLD : XFS_IOC_FSBULKSTAT_NEW)

The native xfs_ioctl now handles both the time32 and the time64 version
of the xfs_bstat data structure, and this gets called indirectly by the
compat code implementing the xfs_fsop_bulkreq commands. For x86, we
still need another implementation to deal with the broken alignment,
so the existing code is left in ioctl32 but changed to now handle
the misaligned time64 structure.

Based on the requirement to change the header file, a much simpler fix
would be to change the time_t reference to 'long' and always keep
passing the shorter timestamp as on 32-bit applications using the old
ioctl, forcing code changes to use the v5 API to access post-y2038
timestamps, and still requiring the updated header when building with
a new C library.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Note: I have not tested this patch beyond compiling it, for now this
is for discussion, to decide which approach makes more sense.
---
 fs/xfs/libxfs/xfs_fs.h |  19 +++-
 fs/xfs/xfs_ioctl.c     | 195 +++++++++++++++++++++++++++++++++++++++--
 fs/xfs/xfs_ioctl.h     |  12 +++
 fs/xfs/xfs_ioctl32.c   |  82 ++++++++++-------
 fs/xfs/xfs_ioctl32.h   |  26 +++---
 5 files changed, 278 insertions(+), 56 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 4c4330f6e653..9310576a45e5 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -324,8 +324,13 @@ typedef struct xfs_growfs_rt {
  * Structures returned from ioctl XFS_IOC_FSBULKSTAT & XFS_IOC_FSBULKSTAT_SINGLE
  */
 typedef struct xfs_bstime {
-	__kernel_long_t tv_sec;		/* seconds		*/
+#ifdef __KERNEL__
+	__s64		tv_sec;		/* seconds		*/
 	__s32		tv_nsec;	/* and nanoseconds	*/
+#else
+	time_t		tv_sec;		/* seconds		*/
+	__s32		tv_nsec;	/* and nanoseconds	*/
+#endif
 } xfs_bstime_t;
 
 struct xfs_bstat {
@@ -775,8 +780,8 @@ struct xfs_scrub_metadata {
  * ioctl commands that replace IRIX syssgi()'s
  */
 #define XFS_IOC_FSGEOMETRY_V1	     _IOR ('X', 100, struct xfs_fsop_geom_v1)
-#define XFS_IOC_FSBULKSTAT	     _IOWR('X', 101, struct xfs_fsop_bulkreq)
-#define XFS_IOC_FSBULKSTAT_SINGLE    _IOWR('X', 102, struct xfs_fsop_bulkreq)
+#define XFS_IOC_FSBULKSTAT_OLD	     _IOWR('X', 101, struct xfs_fsop_bulkreq)
+#define XFS_IOC_FSBULKSTAT_SINGLE_OLD _IOWR('X', 102, struct xfs_fsop_bulkreq)
 #define XFS_IOC_FSINUMBERS	     _IOWR('X', 103, struct xfs_fsop_bulkreq)
 #define XFS_IOC_PATH_TO_FSHANDLE     _IOWR('X', 104, struct xfs_fsop_handlereq)
 #define XFS_IOC_PATH_TO_HANDLE	     _IOWR('X', 105, struct xfs_fsop_handlereq)
@@ -805,6 +810,14 @@ struct xfs_scrub_metadata {
 #define XFS_IOC_FSGEOMETRY	     _IOR ('X', 126, struct xfs_fsop_geom)
 #define XFS_IOC_BULKSTAT	     _IOR ('X', 127, struct xfs_bulkstat_req)
 #define XFS_IOC_INUMBERS	     _IOR ('X', 128, struct xfs_inumbers_req)
+#define XFS_IOC_FSBULKSTAT_NEW	     _IOWR('X', 129, struct xfs_fsop_bulkreq)
+#define XFS_IOC_FSBULKSTAT_SINGLE_NEW _IOWR('X', 130, struct xfs_fsop_bulkreq)
+
+#define XFS_IOC_FSBULKSTAT	  ((sizeof(time_t) == sizeof(__kernel_long_t)) ? \
+				   XFS_IOC_FSBULKSTAT_OLD : XFS_IOC_FSBULKSTAT_NEW)
+#define XFS_IOC_FSBULKSTAT_SINGLE ((sizeof(time_t) == sizeof(__kernel_long_t)) ? \
+				   XFS_IOC_FSBULKSTAT_OLD : XFS_IOC_FSBULKSTAT_NEW)
+
 /*	XFS_IOC_GETFSUUID ---------- deprecated 140	 */
 
 
diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index d58f0d6a699e..d50135760622 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -24,6 +24,7 @@
 #include "xfs_export.h"
 #include "xfs_trace.h"
 #include "xfs_icache.h"
+#include "xfs_ioctl.h"
 #include "xfs_trans.h"
 #include "xfs_acl.h"
 #include "xfs_btree.h"
@@ -713,7 +714,96 @@ xfs_ioc_space(
 	return error;
 }
 
+/*
+ * Structures returned from ioctl XFS_IOC_FSBULKSTAT_TIME32 & XFS_IOC_FSBULKSTAT_SINGLE_TIME32
+ */
+struct xfs_bstime32 {
+	__s32		tv_sec;		/* seconds		*/
+	__s32		tv_nsec;	/* and nanoseconds	*/
+};
+
+struct xfs_bstat_time32 {
+	__u64		bs_ino;		/* inode number			*/
+	__u16		bs_mode;	/* type and mode		*/
+	__u16		bs_nlink;	/* number of links		*/
+	__u32		bs_uid;		/* user id			*/
+	__u32		bs_gid;		/* group id			*/
+	__u32		bs_rdev;	/* device value			*/
+	__s32		bs_blksize;	/* block size			*/
+	__s64		bs_size;	/* file size			*/
+	struct xfs_bstime32 bs_atime;	/* access time			*/
+	struct xfs_bstime32 bs_mtime;	/* modify time			*/
+	struct xfs_bstime32 bs_ctime;	/* inode change time		*/
+	int64_t		bs_blocks;	/* number of blocks		*/
+	__u32		bs_xflags;	/* extended flags		*/
+	__s32		bs_extsize;	/* extent size			*/
+	__s32		bs_extents;	/* number of extents		*/
+	__u32		bs_gen;		/* generation count		*/
+	__u16		bs_projid_lo;	/* lower part of project id	*/
+	__u16		bs_forkoff;	/* inode fork offset in bytes	*/
+	__u16		bs_projid_hi;	/* higher part of project id	*/
+	uint16_t	bs_sick;	/* sick inode metadata		*/
+	uint16_t	bs_checked;	/* checked inode metadata	*/
+	unsigned char	bs_pad[2];	/* pad space, unused		*/
+	__u32		bs_cowextsize;	/* cow extent size		*/
+	__u32		bs_dmevmask;	/* DMIG event mask		*/
+	__u16		bs_dmstate;	/* DMIG state info		*/
+	__u16		bs_aextents;	/* attribute number of extents	*/
+} __compat_packed; /* packing for x86-64 compat mode */
+
+/* Convert bulkstat (v5) to bstat (v1) with 32-bit time_t. */
+void
+xfs_bulkstat_to_bstat_time32(
+	struct xfs_mount		*mp,
+	struct xfs_bstat_time32		*bs1,
+	const struct xfs_bulkstat	*bstat)
+{
+	/* memset is needed here because of padding holes in the structure. */
+	memset(bs1, 0, sizeof(struct xfs_bstat));
+	bs1->bs_ino = bstat->bs_ino;
+	bs1->bs_mode = bstat->bs_mode;
+	bs1->bs_nlink = bstat->bs_nlink;
+	bs1->bs_uid = bstat->bs_uid;
+	bs1->bs_gid = bstat->bs_gid;
+	bs1->bs_rdev = bstat->bs_rdev;
+	bs1->bs_blksize = bstat->bs_blksize;
+	bs1->bs_size = bstat->bs_size;
+	bs1->bs_atime.tv_sec = bstat->bs_atime;
+	bs1->bs_mtime.tv_sec = bstat->bs_mtime;
+	bs1->bs_ctime.tv_sec = bstat->bs_ctime;
+	bs1->bs_atime.tv_nsec = bstat->bs_atime_nsec;
+	bs1->bs_mtime.tv_nsec = bstat->bs_mtime_nsec;
+	bs1->bs_ctime.tv_nsec = bstat->bs_ctime_nsec;
+	bs1->bs_blocks = bstat->bs_blocks;
+	bs1->bs_xflags = bstat->bs_xflags;
+	bs1->bs_extsize = XFS_FSB_TO_B(mp, bstat->bs_extsize_blks);
+	bs1->bs_extents = bstat->bs_extents;
+	bs1->bs_gen = bstat->bs_gen;
+	bs1->bs_projid_lo = bstat->bs_projectid & 0xFFFF;
+	bs1->bs_forkoff = bstat->bs_forkoff;
+	bs1->bs_projid_hi = bstat->bs_projectid >> 16;
+	bs1->bs_sick = bstat->bs_sick;
+	bs1->bs_checked = bstat->bs_checked;
+	bs1->bs_cowextsize = XFS_FSB_TO_B(mp, bstat->bs_cowextsize_blks);
+	bs1->bs_dmevmask = 0;
+	bs1->bs_dmstate = 0;
+	bs1->bs_aextents = bstat->bs_aextents;
+}
+
 /* Return 0 on success or positive error */
+int
+xfs_fsbulkstat_time32_one_fmt(
+	struct xfs_ibulk		*breq,
+	const struct xfs_bulkstat	*bstat)
+{
+	struct xfs_bstat_time32		bs1;
+
+	xfs_bulkstat_to_bstat_time32(breq->mp, &bs1, bstat);
+	if (copy_to_user(breq->ubuffer, &bs1, sizeof(bs1)))
+		return -EFAULT;
+	return xfs_ibulk_advance(breq, sizeof(struct xfs_bstat_time32));
+}
+
 int
 xfs_fsbulkstat_one_fmt(
 	struct xfs_ibulk		*breq,
@@ -789,18 +879,40 @@ xfs_ioc_fsbulkstat(
 	 * is a special case because it has traditionally meant "first inode
 	 * in filesystem".
 	 */
-	if (cmd == XFS_IOC_FSINUMBERS) {
+	switch (cmd) {
+	case XFS_IOC_FSINUMBERS:
 		breq.startino = lastino ? lastino + 1 : 0;
 		error = xfs_inumbers(&breq, xfs_fsinumbers_fmt);
 		lastino = breq.startino - 1;
-	} else if (cmd == XFS_IOC_FSBULKSTAT_SINGLE) {
+		break;
+	case XFS_IOC_FSBULKSTAT_SINGLE_OLD:
+		if (!IS_ENABLED(CONFIG_64BIT)) {
+			breq.startino = lastino;
+			breq.icount = 1;
+			error = xfs_bulkstat_one(&breq, xfs_fsbulkstat_time32_one_fmt);
+			break;
+		}
+		/* Fallthrough */
+	case XFS_IOC_FSBULKSTAT_SINGLE_NEW:
 		breq.startino = lastino;
 		breq.icount = 1;
 		error = xfs_bulkstat_one(&breq, xfs_fsbulkstat_one_fmt);
-	} else {	/* XFS_IOC_FSBULKSTAT */
+		break;
+	case XFS_IOC_FSBULKSTAT_OLD:
+		if (!IS_ENABLED(CONFIG_64BIT)) {
+			breq.startino = lastino ? lastino + 1 : 0;
+			error = xfs_bulkstat(&breq, xfs_fsbulkstat_time32_one_fmt);
+			lastino = breq.startino - 1;
+			break;
+		}
+		/* Fallthrough */
+	case XFS_IOC_FSBULKSTAT_NEW:
 		breq.startino = lastino ? lastino + 1 : 0;
 		error = xfs_bulkstat(&breq, xfs_fsbulkstat_one_fmt);
 		lastino = breq.startino - 1;
+		break;
+	default:
+		error = -EINVAL;
 	}
 
 	if (error)
@@ -2093,6 +2205,74 @@ xfs_ioc_setlabel(
 	return error;
 }
 
+static int get_xfs_bstime32(struct xfs_bstime *bstime,
+				struct xfs_bstime32 __user *bstime32)
+{
+	struct xfs_bstime32 t;
+
+	if (copy_from_user(&t, bstime32, sizeof(t)))
+		return -EFAULT;
+
+	*bstime = (struct xfs_bstime){
+		.tv_sec = t.tv_sec,
+		.tv_nsec = t.tv_nsec,
+	};
+
+	return 0;
+}
+
+static int get_xfs_bstat_time32(struct xfs_bstat *bstat,
+				struct xfs_bstat_time32 __user *bstat32)
+{
+	if (copy_from_user(bstat, bstat32,
+			   offsetof(struct xfs_bstat, bs_atime)))
+		return -EFAULT;
+
+	if (get_xfs_bstime32(&bstat->bs_atime, &bstat32->bs_atime) ||
+	    get_xfs_bstime32(&bstat->bs_mtime, &bstat32->bs_mtime) ||
+	    get_xfs_bstime32(&bstat->bs_ctime, &bstat32->bs_ctime))
+		return -EFAULT;
+
+	if (copy_from_user(&bstat->bs_blocks, &bstat32->bs_blocks,
+			   sizeof(struct xfs_bstat) -
+			   offsetof(struct xfs_bstat, bs_blocks)))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * Structure passed to XFS_IOC_SWAPEXT_TIME32
+ */
+struct xfs_swapext_time32
+{
+	int64_t		sx_version;	/* version */
+	int64_t		sx_fdtarget;	/* fd of target file */
+	int64_t		sx_fdtmp;	/* fd of tmp file */
+	xfs_off_t	sx_offset;	/* offset into file */
+	xfs_off_t	sx_length;	/* leng from offset */
+	char		sx_pad[16];	/* pad space, unused */
+	struct xfs_bstat_time32 sx_stat;/* stat of target b4 copy */
+};
+#define XFS_IOC_SWAPEXT_TIME32    _IOWR('X', 109, struct xfs_swapext_time32)
+
+static int get_xfs_swapext(struct xfs_swapext *sxp, unsigned int cmd, void __user *arg)
+{
+	struct xfs_swapext_time32 *sxp32 = arg;
+	int ret;
+
+	if (cmd == XFS_IOC_SWAPEXT) {
+		ret = copy_from_user(sxp, arg, sizeof(struct xfs_swapext));
+		return ret ? -EFAULT : 0;
+	}
+
+	ret = copy_from_user(sxp, arg, offsetof(struct xfs_swapext, sx_stat));
+	if (ret)
+		return -EFAULT;
+
+	return get_xfs_bstat_time32(&sxp->sx_stat, &sxp32->sx_stat);
+}
+
 /*
  * Note: some of the ioctl's return positive numbers as a
  * byte count indicating success, such as readlink_by_handle.
@@ -2149,8 +2329,10 @@ xfs_file_ioctl(
 		return 0;
 	}
 
-	case XFS_IOC_FSBULKSTAT_SINGLE:
-	case XFS_IOC_FSBULKSTAT:
+	case XFS_IOC_FSBULKSTAT_SINGLE_OLD:
+	case XFS_IOC_FSBULKSTAT_OLD:
+	case XFS_IOC_FSBULKSTAT_SINGLE_NEW:
+	case XFS_IOC_FSBULKSTAT_NEW:
 	case XFS_IOC_FSINUMBERS:
 		return xfs_ioc_fsbulkstat(mp, cmd, arg);
 
@@ -2242,10 +2424,11 @@ xfs_file_ioctl(
 	case XFS_IOC_ATTRMULTI_BY_HANDLE:
 		return xfs_attrmulti_by_handle(filp, arg);
 
+	case XFS_IOC_SWAPEXT_TIME32:
 	case XFS_IOC_SWAPEXT: {
 		struct xfs_swapext	sxp;
 
-		if (copy_from_user(&sxp, arg, sizeof(xfs_swapext_t)))
+		if (get_xfs_swapext(&sxp, cmd, arg))
 			return -EFAULT;
 		error = mnt_want_write_file(filp);
 		if (error)
diff --git a/fs/xfs/xfs_ioctl.h b/fs/xfs/xfs_ioctl.h
index 654c0bb1bcf8..318ff243258f 100644
--- a/fs/xfs/xfs_ioctl.h
+++ b/fs/xfs/xfs_ioctl.h
@@ -83,6 +83,18 @@ struct xfs_inogrp;
 
 int xfs_fsbulkstat_one_fmt(struct xfs_ibulk *breq,
 			   const struct xfs_bulkstat *bstat);
+int xfs_fsbulkstat_time32_one_fmt(struct xfs_ibulk *breq,
+			   const struct xfs_bulkstat *bstat);
 int xfs_fsinumbers_fmt(struct xfs_ibulk *breq, const struct xfs_inumbers *igrp);
 
+/*
+ * On intel, even if sizes match, alignment and/or padding may differ.
+ */
+#if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
+#define BROKEN_X86_ALIGNMENT
+#define __compat_packed __attribute__((packed))
+#else
+#define __compat_packed
+#endif
+
 #endif
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index 1e08bf79b478..2ea7d3e12b4b 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -98,28 +98,18 @@ xfs_fsinumbers_fmt_compat(
 	return xfs_ibulk_advance(breq, sizeof(struct compat_xfs_inogrp));
 }
 
-#else
-#define xfs_fsinumbers_fmt_compat xfs_fsinumbers_fmt
-#endif	/* BROKEN_X86_ALIGNMENT */
-
+/* struct xfs_bstat has differing alignment on intel */
 STATIC int
 xfs_ioctl32_bstime_copyin(
 	xfs_bstime_t		*bstime,
 	compat_xfs_bstime_t	__user *bstime32)
 {
-	compat_time_t		sec32;	/* tv_sec differs on 64 vs. 32 */
-
-	if (get_user(sec32,		&bstime32->tv_sec)	||
+	if (get_user(bstime->tv_sec,	&bstime32->tv_sec)	||
 	    get_user(bstime->tv_nsec,	&bstime32->tv_nsec))
 		return -EFAULT;
-	bstime->tv_sec = sec32;
 	return 0;
 }
 
-/*
- * struct xfs_bstat has differing alignment on intel, & bstime_t sizes
- * everywhere
- */
 STATIC int
 xfs_ioctl32_bstat_copyin(
 	struct xfs_bstat		*bstat,
@@ -158,10 +148,7 @@ xfs_bstime_store_compat(
 	compat_xfs_bstime_t	__user *p32,
 	const xfs_bstime_t	*p)
 {
-	__s32			sec32;
-
-	sec32 = p->tv_sec;
-	if (put_user(sec32, &p32->tv_sec) ||
+	if (put_user(p->tv_sec, &p32->tv_sec) ||
 	    put_user(p->tv_nsec, &p32->tv_nsec))
 		return -EFAULT;
 	return 0;
@@ -206,6 +193,10 @@ xfs_fsbulkstat_one_fmt_compat(
 	return xfs_ibulk_advance(breq, sizeof(struct compat_xfs_bstat));
 }
 
+#else
+#define xfs_fsinumbers_fmt_compat xfs_fsinumbers_fmt
+#endif	/* BROKEN_X86_ALIGNMENT */
+
 /* copied from xfs_ioctl.c */
 STATIC int
 xfs_compat_ioc_fsbulkstat(
@@ -229,7 +220,12 @@ xfs_compat_ioc_fsbulkstat(
 	 * functions and structure size are the correct ones to use ...
 	 */
 	inumbers_fmt_pf		inumbers_func = xfs_fsinumbers_fmt_compat;
-	bulkstat_one_fmt_pf	bs_one_func = xfs_fsbulkstat_one_fmt_compat;
+	bulkstat_one_fmt_pf	bs_one_func_old = xfs_fsbulkstat_time32_one_fmt;
+	bulkstat_one_fmt_pf	bs_one_func_new = xfs_fsbulkstat_one_fmt;
+
+#ifdef BROKEN_X86_ALIGNMENT
+	bs_one_func_new = xfs_fsbulkstat_one_fmt_compat;
+#endif
 
 #ifdef CONFIG_X86_X32
 	if (in_x32_syscall()) {
@@ -242,7 +238,7 @@ xfs_compat_ioc_fsbulkstat(
 		 * x32 userspace expects.
 		 */
 		inumbers_func = xfs_fsinumbers_fmt;
-		bs_one_func = xfs_fsbulkstat_one_fmt;
+		bs_one_func_old = xfs_fsbulkstat_one_fmt;
 	}
 #endif
 
@@ -289,21 +285,37 @@ xfs_compat_ioc_fsbulkstat(
 	 * is a special case because it has traditionally meant "first inode
 	 * in filesystem".
 	 */
-	if (cmd == XFS_IOC_FSINUMBERS_32) {
+	switch (cmd) {
+	case XFS_IOC_FSINUMBERS_32:
 		breq.startino = lastino ? lastino + 1 : 0;
 		error = xfs_inumbers(&breq, inumbers_func);
 		lastino = breq.startino - 1;
-	} else if (cmd == XFS_IOC_FSBULKSTAT_SINGLE_32) {
+		break;
+	case XFS_IOC_FSBULKSTAT_SINGLE_OLD32:
 		breq.startino = lastino;
 		breq.icount = 1;
-		error = xfs_bulkstat_one(&breq, bs_one_func);
+		error = xfs_bulkstat_one(&breq, bs_one_func_old);
 		lastino = breq.startino;
-	} else if (cmd == XFS_IOC_FSBULKSTAT_32) {
+		break;
+	case XFS_IOC_FSBULKSTAT_OLD32:
 		breq.startino = lastino ? lastino + 1 : 0;
-		error = xfs_bulkstat(&breq, bs_one_func);
+		error = xfs_bulkstat(&breq, bs_one_func_old);
 		lastino = breq.startino - 1;
-	} else {
+		break;
+	case XFS_IOC_FSBULKSTAT_SINGLE_NEW32:
+		breq.startino = lastino;
+		breq.icount = 1;
+		error = xfs_bulkstat_one(&breq, bs_one_func_new);
+		lastino = breq.startino;
+		break;
+	case XFS_IOC_FSBULKSTAT_NEW32:
+		breq.startino = lastino ? lastino + 1 : 0;
+		error = xfs_bulkstat(&breq, bs_one_func_new);
+		lastino = breq.startino - 1;
+		break;
+	default:
 		error = -EINVAL;
+		break;
 	}
 	if (error)
 		return error;
@@ -548,7 +560,9 @@ xfs_file_compat_ioctl(
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
 	void			__user *arg = compat_ptr(p);
+#if defined(BROKEN_X86_ALIGNMENT)
 	int			error;
+#endif
 
 	trace_xfs_file_compat_ioctl(ip);
 
@@ -596,13 +610,6 @@ xfs_file_compat_ioctl(
 		mnt_drop_write_file(filp);
 		return error;
 	}
-#endif
-	/* long changes size, but xfs only copiese out 32 bits */
-	case XFS_IOC_GETXFLAGS_32:
-	case XFS_IOC_SETXFLAGS_32:
-	case XFS_IOC_GETVERSION_32:
-		cmd = _NATIVE_IOC(cmd, long);
-		return xfs_file_ioctl(filp, cmd, p);
 	case XFS_IOC_SWAPEXT_32: {
 		struct xfs_swapext	  sxp;
 		struct compat_xfs_swapext __user *sxu = arg;
@@ -619,8 +626,17 @@ xfs_file_compat_ioctl(
 		mnt_drop_write_file(filp);
 		return error;
 	}
-	case XFS_IOC_FSBULKSTAT_32:
-	case XFS_IOC_FSBULKSTAT_SINGLE_32:
+#endif
+	/* long changes size, but xfs only copiese out 32 bits */
+	case XFS_IOC_GETXFLAGS_32:
+	case XFS_IOC_SETXFLAGS_32:
+	case XFS_IOC_GETVERSION_32:
+		cmd = _NATIVE_IOC(cmd, long);
+		return xfs_file_ioctl(filp, cmd, p);
+	case XFS_IOC_FSBULKSTAT_OLD32:
+	case XFS_IOC_FSBULKSTAT_SINGLE_OLD32:
+	case XFS_IOC_FSBULKSTAT_NEW32:
+	case XFS_IOC_FSBULKSTAT_SINGLE_NEW32:
 	case XFS_IOC_FSINUMBERS_32:
 		return xfs_compat_ioc_fsbulkstat(mp, cmd, arg);
 	case XFS_IOC_FD_TO_HANDLE_32:
diff --git a/fs/xfs/xfs_ioctl32.h b/fs/xfs/xfs_ioctl32.h
index 7985344d3aa6..d7050f4360e9 100644
--- a/fs/xfs/xfs_ioctl32.h
+++ b/fs/xfs/xfs_ioctl32.h
@@ -21,20 +21,11 @@
 #define XFS_IOC_SETXFLAGS_32	FS_IOC32_SETFLAGS
 #define XFS_IOC_GETVERSION_32	FS_IOC32_GETVERSION
 
-/*
- * On intel, even if sizes match, alignment and/or padding may differ.
- */
-#if defined(CONFIG_IA64) || defined(CONFIG_X86_64)
-#define BROKEN_X86_ALIGNMENT
-#define __compat_packed __attribute__((packed))
-#else
-#define __compat_packed
-#endif
-
+#ifdef BROKEN_X86_ALIGNMENT
 typedef struct compat_xfs_bstime {
-	compat_time_t	tv_sec;		/* seconds		*/
+	__s64		tv_sec;		/* seconds		*/
 	__s32		tv_nsec;	/* and nanoseconds	*/
-} compat_xfs_bstime_t;
+} __compat_packed compat_xfs_bstime_t;
 
 struct compat_xfs_bstat {
 	__u64		bs_ino;		/* inode number			*/
@@ -62,6 +53,7 @@ struct compat_xfs_bstat {
 	__u16		bs_dmstate;	/* DMIG state info		*/
 	__u16		bs_aextents;	/* attribute number of extents	*/
 } __compat_packed;
+#endif
 
 struct compat_xfs_fsop_bulkreq {
 	compat_uptr_t	lastip;		/* last inode # pointer		*/
@@ -70,10 +62,14 @@ struct compat_xfs_fsop_bulkreq {
 	compat_uptr_t	ocount;		/* output count pointer		*/
 };
 
-#define XFS_IOC_FSBULKSTAT_32 \
+#define XFS_IOC_FSBULKSTAT_OLD32 \
 	_IOWR('X', 101, struct compat_xfs_fsop_bulkreq)
-#define XFS_IOC_FSBULKSTAT_SINGLE_32 \
+#define XFS_IOC_FSBULKSTAT_SINGLE_OLD32 \
 	_IOWR('X', 102, struct compat_xfs_fsop_bulkreq)
+#define XFS_IOC_FSBULKSTAT_NEW32 \
+	_IOWR('X', 129, struct compat_xfs_fsop_bulkreq)
+#define XFS_IOC_FSBULKSTAT_SINGLE_NEW32 \
+	_IOWR('X', 130, struct compat_xfs_fsop_bulkreq)
 #define XFS_IOC_FSINUMBERS_32 \
 	_IOWR('X', 103, struct compat_xfs_fsop_bulkreq)
 
@@ -98,6 +94,7 @@ typedef struct compat_xfs_fsop_handlereq {
 #define XFS_IOC_READLINK_BY_HANDLE_32 \
 	_IOWR('X', 108, struct compat_xfs_fsop_handlereq)
 
+#ifdef BROKEN_X86_ALIGNMENT
 /* The bstat field in the swapext struct needs translation */
 typedef struct compat_xfs_swapext {
 	int64_t			sx_version;	/* version */
@@ -110,6 +107,7 @@ typedef struct compat_xfs_swapext {
 } __compat_packed compat_xfs_swapext_t;
 
 #define XFS_IOC_SWAPEXT_32	_IOWR('X', 109, struct compat_xfs_swapext)
+#endif
 
 typedef struct compat_xfs_fsop_attrlist_handlereq {
 	struct compat_xfs_fsop_handlereq hreq; /* handle interface structure */
-- 
2.20.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A269F8F58
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 13:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbfKLMJp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 07:09:45 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:59147 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727229AbfKLMJo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:09:44 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1M1q8m-1iSJ7Z1b68-002Jt7; Tue, 12 Nov 2019 13:09:13 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 3/5] xfs: [variant C] avoid i386-misaligned xfs_bstat
Date:   Tue, 12 Nov 2019 13:09:08 +0100
Message-Id: <20191112120910.1977003-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191112120910.1977003-1-arnd@arndb.de>
References: <20191112120910.1977003-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:M+DgUTQXXx55xjkTyjjlvP9lY+UVcKlCUHKoHtQanp2/9dL6H0p
 XeQ7k781eMoZzf+XqiChKJwG+Vplb3OcxIILAU5pFGBj9NOLKtyeg8ayyp6/3YKzr/jjufZ
 /qoMUYwuQeqpTeXq+9EprMh5mMzR1AlrX/t7wUdLL8C5oWX+ALLbmwz6C8g1pb/aoHNdwgq
 gKKGRaLX0fOyQZdlb7n4Q==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:iu+uetCjnLs=:YSMg1vD//WT15pOicFSLp8
 zZDvEpBPwGxVkQaI6UF6tFJFzQdpXTUFBb3Ef+LDouRoQs3rwqgYY76ltjdVVyblu4LvSzkK4
 v/WwXrBPr/zRFAH9XEta//UfH2nm3nspH4W6Xw58vv/fSDbKjttwZu/QXJReHBnq+GnPm5RbH
 3f8K0U3Jw/1U91ZrdSLgfdt/bw1WKOl4K+s8kTo7DgiQlOjwKzwAgd0lan+ZAfHqurB9aAdwU
 jjExKNx23P9e5u+CLDnTEXz/D/dXga2XyZ2wnKF7GZBNKgCVa/IqCdIVQKHmTvz94tjRShH/Q
 B/ghS65ktkNyaE8vsTUP7lkuD43d8Wu7Oywga8vAH/iGMP5K7y14CWdiQmRArbWd1Gg56e0vc
 VS/aWX2Aywde0r6CWPAu1sFrbMNxKcJFZhQr1vbJzCYmScedJglZ5jtJGYOlawwStlZNrY5g7
 nXTsm7fLRqHjCtlV49cagVEZ5EXISkhGJDdFidpAJ6Hs/z5c/2N9IQHhrI/Qi2WLnXjJxE9Bm
 Ey2GdbDD5quT5lNLQbb2ldN8AjJt7aQXXlNX3r0CKoRHrJ0mjyHtgRzvXk5R1pzNhg0bqn+4R
 bmV5D19dvBBf/hd4d2jtC5IYBrLpiRMjXJyZ+DADRNx9v0D4bCxt1yuC+wFeW5vsIxzirK02T
 bhPT0WKpodqHR/7FjOEr+5SoXyU0c/f0hj/msHGYxmubQBw1u7xvvcH2ZLqtEhrsy3pNVByml
 ucGlQCuVecI4zNC2NEw/aMjQZEy96qi2nOx3GIzUkUAwpmMXr70HDkC97sbmlw3tI8w3hN24+
 kAbGWXefpLkdAqvuIXtfDT7t/3u7LoJcwBejEeYiibH2bJUw5VEkD4xbDfnTnogxKvxQ29Nhw
 o4aerJSDZXJQUaP0AxqQ==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

The change to the ioctl commands requires updating the header file. If
we do that, the alignment problem on i386 could be solved for the new
format by explictly aligning all 64-bit members to time_t. This complicates
the header file definition, but saves the code to deal with a third format.

The native ioctl simply deals with both the time32 and the time64 version,
and the latter is the same across all 64-bit architectures and all 32-bit
user space with 32-bit time_t including i386 and x32.

If we decide to do this, this change should be folded into "xfs: [variant B]
add time64 version of xfs_bstat".

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/xfs/libxfs/xfs_fs.h |  20 +++++--
 fs/xfs/xfs_ioctl32.c   | 120 +----------------------------------------
 2 files changed, 18 insertions(+), 122 deletions(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index 9310576a45e5..e95807d223ad 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -319,6 +319,17 @@ typedef struct xfs_growfs_rt {
 	__u32		extsize;	/* new realtime extent size, fsblocks */
 } xfs_growfs_rt_t;
 
+/*
+ * on i386, u64 has 32-bit alignment, which makes the traditional xfs_bstat
+ * different from other architectures. Aligning all 64-bit members to
+ * sizeof(time_t) means that the new version with 64-bit time_t is padded
+ * the same as on all other architectures.
+ */
+#ifdef __i386__
+#define __TIME_ALIGN __attribute__((aligned(sizeof(time_t))))
+#else
+#define __TIME_ALIGN
+#endif
 
 /*
  * Structures returned from ioctl XFS_IOC_FSBULKSTAT & XFS_IOC_FSBULKSTAT_SINGLE
@@ -328,24 +339,24 @@ typedef struct xfs_bstime {
 	__s64		tv_sec;		/* seconds		*/
 	__s32		tv_nsec;	/* and nanoseconds	*/
 #else
-	time_t		tv_sec;		/* seconds		*/
+	time_t		tv_sec __TIME_ALIGN; /* seconds		*/
 	__s32		tv_nsec;	/* and nanoseconds	*/
 #endif
 } xfs_bstime_t;
 
 struct xfs_bstat {
-	__u64		bs_ino;		/* inode number			*/
+	__u64		bs_ino __TIME_ALIGN; /* inode number		*/
 	__u16		bs_mode;	/* type and mode		*/
 	__u16		bs_nlink;	/* number of links		*/
 	__u32		bs_uid;		/* user id			*/
 	__u32		bs_gid;		/* group id			*/
 	__u32		bs_rdev;	/* device value			*/
 	__s32		bs_blksize;	/* block size			*/
-	__s64		bs_size;	/* file size			*/
+	__s64		bs_size __TIME_ALIGN;	/* file size		*/
 	xfs_bstime_t	bs_atime;	/* access time			*/
 	xfs_bstime_t	bs_mtime;	/* modify time			*/
 	xfs_bstime_t	bs_ctime;	/* inode change time		*/
-	int64_t		bs_blocks;	/* number of blocks		*/
+	int64_t		bs_blocks __TIME_ALIGN;	/* number of blocks	*/
 	__u32		bs_xflags;	/* extended flags		*/
 	__s32		bs_extsize;	/* extent size			*/
 	__s32		bs_extents;	/* number of extents		*/
@@ -362,6 +373,7 @@ struct xfs_bstat {
 	__u16		bs_dmstate;	/* DMIG state info		*/
 	__u16		bs_aextents;	/* attribute number of extents	*/
 };
+#undef __TIME_ALIGN
 
 /* New bulkstat structure that reports v5 features and fixes padding issues */
 struct xfs_bulkstat {
diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index 2ea7d3e12b4b..8059cdc2d5ca 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -98,101 +98,6 @@ xfs_fsinumbers_fmt_compat(
 	return xfs_ibulk_advance(breq, sizeof(struct compat_xfs_inogrp));
 }
 
-/* struct xfs_bstat has differing alignment on intel */
-STATIC int
-xfs_ioctl32_bstime_copyin(
-	xfs_bstime_t		*bstime,
-	compat_xfs_bstime_t	__user *bstime32)
-{
-	if (get_user(bstime->tv_sec,	&bstime32->tv_sec)	||
-	    get_user(bstime->tv_nsec,	&bstime32->tv_nsec))
-		return -EFAULT;
-	return 0;
-}
-
-STATIC int
-xfs_ioctl32_bstat_copyin(
-	struct xfs_bstat		*bstat,
-	struct compat_xfs_bstat	__user	*bstat32)
-{
-	if (get_user(bstat->bs_ino,	&bstat32->bs_ino)	||
-	    get_user(bstat->bs_mode,	&bstat32->bs_mode)	||
-	    get_user(bstat->bs_nlink,	&bstat32->bs_nlink)	||
-	    get_user(bstat->bs_uid,	&bstat32->bs_uid)	||
-	    get_user(bstat->bs_gid,	&bstat32->bs_gid)	||
-	    get_user(bstat->bs_rdev,	&bstat32->bs_rdev)	||
-	    get_user(bstat->bs_blksize,	&bstat32->bs_blksize)	||
-	    get_user(bstat->bs_size,	&bstat32->bs_size)	||
-	    xfs_ioctl32_bstime_copyin(&bstat->bs_atime, &bstat32->bs_atime) ||
-	    xfs_ioctl32_bstime_copyin(&bstat->bs_mtime, &bstat32->bs_mtime) ||
-	    xfs_ioctl32_bstime_copyin(&bstat->bs_ctime, &bstat32->bs_ctime) ||
-	    get_user(bstat->bs_blocks,	&bstat32->bs_size)	||
-	    get_user(bstat->bs_xflags,	&bstat32->bs_size)	||
-	    get_user(bstat->bs_extsize,	&bstat32->bs_extsize)	||
-	    get_user(bstat->bs_extents,	&bstat32->bs_extents)	||
-	    get_user(bstat->bs_gen,	&bstat32->bs_gen)	||
-	    get_user(bstat->bs_projid_lo, &bstat32->bs_projid_lo) ||
-	    get_user(bstat->bs_projid_hi, &bstat32->bs_projid_hi) ||
-	    get_user(bstat->bs_forkoff,	&bstat32->bs_forkoff)	||
-	    get_user(bstat->bs_dmevmask, &bstat32->bs_dmevmask)	||
-	    get_user(bstat->bs_dmstate,	&bstat32->bs_dmstate)	||
-	    get_user(bstat->bs_aextents, &bstat32->bs_aextents))
-		return -EFAULT;
-	return 0;
-}
-
-/* XFS_IOC_FSBULKSTAT and friends */
-
-STATIC int
-xfs_bstime_store_compat(
-	compat_xfs_bstime_t	__user *p32,
-	const xfs_bstime_t	*p)
-{
-	if (put_user(p->tv_sec, &p32->tv_sec) ||
-	    put_user(p->tv_nsec, &p32->tv_nsec))
-		return -EFAULT;
-	return 0;
-}
-
-/* Return 0 on success or positive error (to xfs_bulkstat()) */
-STATIC int
-xfs_fsbulkstat_one_fmt_compat(
-	struct xfs_ibulk		*breq,
-	const struct xfs_bulkstat	*bstat)
-{
-	struct compat_xfs_bstat	__user	*p32 = breq->ubuffer;
-	struct xfs_bstat		bs1;
-	struct xfs_bstat		*buffer = &bs1;
-
-	xfs_bulkstat_to_bstat(breq->mp, &bs1, bstat);
-
-	if (put_user(buffer->bs_ino,	  &p32->bs_ino)		||
-	    put_user(buffer->bs_mode,	  &p32->bs_mode)	||
-	    put_user(buffer->bs_nlink,	  &p32->bs_nlink)	||
-	    put_user(buffer->bs_uid,	  &p32->bs_uid)		||
-	    put_user(buffer->bs_gid,	  &p32->bs_gid)		||
-	    put_user(buffer->bs_rdev,	  &p32->bs_rdev)	||
-	    put_user(buffer->bs_blksize,  &p32->bs_blksize)	||
-	    put_user(buffer->bs_size,	  &p32->bs_size)	||
-	    xfs_bstime_store_compat(&p32->bs_atime, &buffer->bs_atime) ||
-	    xfs_bstime_store_compat(&p32->bs_mtime, &buffer->bs_mtime) ||
-	    xfs_bstime_store_compat(&p32->bs_ctime, &buffer->bs_ctime) ||
-	    put_user(buffer->bs_blocks,	  &p32->bs_blocks)	||
-	    put_user(buffer->bs_xflags,	  &p32->bs_xflags)	||
-	    put_user(buffer->bs_extsize,  &p32->bs_extsize)	||
-	    put_user(buffer->bs_extents,  &p32->bs_extents)	||
-	    put_user(buffer->bs_gen,	  &p32->bs_gen)		||
-	    put_user(buffer->bs_projid,	  &p32->bs_projid)	||
-	    put_user(buffer->bs_projid_hi,	&p32->bs_projid_hi)	||
-	    put_user(buffer->bs_forkoff,  &p32->bs_forkoff)	||
-	    put_user(buffer->bs_dmevmask, &p32->bs_dmevmask)	||
-	    put_user(buffer->bs_dmstate,  &p32->bs_dmstate)	||
-	    put_user(buffer->bs_aextents, &p32->bs_aextents))
-		return -EFAULT;
-
-	return xfs_ibulk_advance(breq, sizeof(struct compat_xfs_bstat));
-}
-
 #else
 #define xfs_fsinumbers_fmt_compat xfs_fsinumbers_fmt
 #endif	/* BROKEN_X86_ALIGNMENT */
@@ -221,11 +126,6 @@ xfs_compat_ioc_fsbulkstat(
 	 */
 	inumbers_fmt_pf		inumbers_func = xfs_fsinumbers_fmt_compat;
 	bulkstat_one_fmt_pf	bs_one_func_old = xfs_fsbulkstat_time32_one_fmt;
-	bulkstat_one_fmt_pf	bs_one_func_new = xfs_fsbulkstat_one_fmt;
-
-#ifdef BROKEN_X86_ALIGNMENT
-	bs_one_func_new = xfs_fsbulkstat_one_fmt_compat;
-#endif
 
 #ifdef CONFIG_X86_X32
 	if (in_x32_syscall()) {
@@ -305,12 +205,12 @@ xfs_compat_ioc_fsbulkstat(
 	case XFS_IOC_FSBULKSTAT_SINGLE_NEW32:
 		breq.startino = lastino;
 		breq.icount = 1;
-		error = xfs_bulkstat_one(&breq, bs_one_func_new);
+		error = xfs_bulkstat_one(&breq, xfs_fsbulkstat_one_fmt);
 		lastino = breq.startino;
 		break;
 	case XFS_IOC_FSBULKSTAT_NEW32:
 		breq.startino = lastino ? lastino + 1 : 0;
-		error = xfs_bulkstat(&breq, bs_one_func_new);
+		error = xfs_bulkstat(&breq, xfs_fsbulkstat_one_fmt);
 		lastino = breq.startino - 1;
 		break;
 	default:
@@ -610,22 +510,6 @@ xfs_file_compat_ioctl(
 		mnt_drop_write_file(filp);
 		return error;
 	}
-	case XFS_IOC_SWAPEXT_32: {
-		struct xfs_swapext	  sxp;
-		struct compat_xfs_swapext __user *sxu = arg;
-
-		/* Bulk copy in up to the sx_stat field, then copy bstat */
-		if (copy_from_user(&sxp, sxu,
-				   offsetof(struct xfs_swapext, sx_stat)) ||
-		    xfs_ioctl32_bstat_copyin(&sxp.sx_stat, &sxu->sx_stat))
-			return -EFAULT;
-		error = mnt_want_write_file(filp);
-		if (error)
-			return error;
-		error = xfs_ioc_swapext(&sxp);
-		mnt_drop_write_file(filp);
-		return error;
-	}
 #endif
 	/* long changes size, but xfs only copiese out 32 bits */
 	case XFS_IOC_GETXFLAGS_32:
-- 
2.20.0


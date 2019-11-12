Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4596EF8F56
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Nov 2019 13:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbfKLMJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Nov 2019 07:09:43 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:41717 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727109AbfKLMJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Nov 2019 07:09:43 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MPGBR-1iGZfR3EkP-00Pc3s; Tue, 12 Nov 2019 13:09:12 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     "Darrick J . Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <david@fromorbit.com>,
        Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        linux-fsdevel@vger.kernel.org
Subject: [RFC 1/5] xfs: [variant A] avoid time_t in user api
Date:   Tue, 12 Nov 2019 13:09:06 +0100
Message-Id: <20191112120910.1977003-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191112120910.1977003-1-arnd@arndb.de>
References: <20191112120910.1977003-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yoWqlCGd5hANpKL2cJs5nTBCZnQpBg6+YbJwERE06XjTio3694h
 uATgw0SZFZwox/ws5O0zLOOHT+Te1wler12Q02ESAvsmIXInzh0m/mqohRtgzvkpJv0Phuc
 SVsISjm1MnvKXQpKHti6TOynFdhMd8ICdYLtu3M6kabdOcxpzZmvbuXA4qKbr/cYv1t20ZF
 IGZWLSMTPpdjrWoMw9NHQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:VtIwy/yEKfU=:BEZ2Sp4BbtjQMSHsEQdbwU
 Owe0kfW9VqrGYzFieA8SZ0mrU8cdeOQxAJ/6Z+y+bp0Rj3DCwMbcbsJdSWUXrk11jZXumcKS3
 Vc9kLkOSm4xyFgBRf3kJuwmXzzeliNmjsBRhZUcozep2podV+UQeZEF3inRZINjGMPmNmoSf7
 isWfsuPNJmr9kWFSNm9XakALnrbx/7WbKRC65HY7r8df5E2c17JAHEuF6hzL4GrzKyyvGFLwM
 7FSceAQ15TkzGdZq5QgZ8zj2OxOwLaASzw8FCVrg3j0QvmV/bfpIdXy56dQ1Gz52DAfQPI/i0
 x/LPPhS2EGqqw9+dkFCzyaKH7VDBDyGu3p7p2J1vWszYn/IC/t6Gp1KBVJzjGAU6ww0rs2vNl
 uDiA1FZmMLnByR1SugpDcMlyh+4QXIYV0u7Z5bZCKHaiEyZk0aqdHEKYr224Q9GSEufWL1y8g
 1Xu9Zo1QiWpjDGpEYaMYyAo9Lsb7aiytyeiY1+G7QpT9EytVFR5T3dzQAjA4WPQbQpkWwdmVJ
 jrb8enQ6hhd+a0VmuyTulbBRByPYO9wGRZS2ziNh/yD1BUraA+wx2x2PBvW0i9spzweJrekKw
 15+5NiXeBIVn1A7u7NTT6dyOdIVj//inlAHomkhxacXb4ZY9fAl/h0OMLqTzSLeIC1nF4kM7V
 HV3KR7wKGj5kL8i1UXLAt8PQLL7KNEI0tTsmcC75dihL+iR/tJ440WwerGRCgena7YqHRD4Yn
 NGYUp3HFAeXHoGs2QMCeMKU6dA6Pvwo2tPOmldoJuhd9FfGCdp7N+JPwqVTggjyu7EvGho8UE
 GvBaSG4cA5eab7wjc26Vsn4dH/N8j/TIW3me7YivRybPfo+U1iTwbbjbMusp+Wc+n6ErCqsBC
 bOPkSHagoM2RiFLVegXA==
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

The same solution could be applied for XFS_IOC_SWAPEXT, but it would
not work for XFS_IOC_FSBULKSTAT and XFS_IOC_FSBULKSTAT_SINGLE because
the structure with the time_t is passed through an indirect pointer,
and the command number itself is based on struct xfs_fsop_bulkreq,
which does not differ based on time_t.

This means any solution that can be applied requires a change of the
ABI definition in the xfs_fs.h header file, as well as doing the same
change in any user application that contains a copy of this header.

The usual solution would be to define a replacement structure and
use conditional compilation for the ioctl command codes to use
one or the other, such as

 #define XFS_IOC_FSBULKSTAT_OLD _IOWR('X', 101, struct xfs_fsop_bulkreq)
 #define XFS_IOC_FSBULKSTAT_NEW _IOWR('X', 129, struct xfs_fsop_bulkreq)
 #define XFS_IOC_FSBULKSTAT ((sizeof(time_t) == sizeof(__kernel_long_t)) ? \
			     XFS_IOC_FSBULKSTAT_OLD : XFS_IOC_FSBULKSTAT_NEW)

After this, the kernel would be able to implement both
XFS_IOC_FSBULKSTAT_OLD and XFS_IOC_FSBULKSTAT_NEW handlers on
32-bit architectures with the correct ABI for either definition
of time_t.

However, as long as two observations are true, a much simpler solution
can be used:

1. xfsprogs is the only user space project that has a copy of this header
2. xfsprogs already has a replacement for all three affected ioctl commands,
   based on the xfs_bulkstat structure to pass 64-bit timestamps
   regardless of the architecture

Based on those assumptions, changing xfs_bstime to use __kernel_long_t
instead of time_t in both the kernel and in xfsprogs preserves the current
ABI for any libc definition of time_t and solves the problem of passing
64-bit timestamps to 32-bit user space.

If either of the two assumptions is invalid, more discussion is needed
for coming up with a way to fix as much of the affected user space
code as possible.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/xfs/libxfs/xfs_fs.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/libxfs/xfs_fs.h b/fs/xfs/libxfs/xfs_fs.h
index e9371a8e0e26..4c4330f6e653 100644
--- a/fs/xfs/libxfs/xfs_fs.h
+++ b/fs/xfs/libxfs/xfs_fs.h
@@ -324,7 +324,7 @@ typedef struct xfs_growfs_rt {
  * Structures returned from ioctl XFS_IOC_FSBULKSTAT & XFS_IOC_FSBULKSTAT_SINGLE
  */
 typedef struct xfs_bstime {
-	time_t		tv_sec;		/* seconds		*/
+	__kernel_long_t tv_sec;		/* seconds		*/
 	__s32		tv_nsec;	/* and nanoseconds	*/
 } xfs_bstime_t;
 
-- 
2.20.0


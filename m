Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27CD08DF1B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 22:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbfHNUn7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 16:43:59 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:50389 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfHNUn7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 16:43:59 -0400
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MiaLn-1iSeBA1QPf-00fn6k; Wed, 14 Aug 2019 22:43:47 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        linux-fsdevel@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-xfs@vger.kernel.org
Cc:     Arnd Bergmann <arnd@arndb.de>, Brian Foster <bfoster@redhat.com>,
        Allison Collins <allison.henderson@oracle.com>,
        Nick Bowler <nbowler@draconx.ca>,
        Eric Sandeen <sandeen@sandeen.net>,
        Dave Chinner <dchinner@redhat.com>
Subject: [PATCH v5 01/18] xfs: compat_ioctl: use compat_ptr()
Date:   Wed, 14 Aug 2019 22:42:28 +0200
Message-Id: <20190814204259.120942-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20190814204259.120942-1-arnd@arndb.de>
References: <20190814204259.120942-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sNo6mKYpnmSZN5AlXqVADdaOJq7MPq3SaOmLM1H/CuxqgrcCVf8
 2YSUJHmWE9awUdZ1xWV2chJQhpNMTxERfy48/uOA4nMXImoW5puUJJdd47twsIaPl4BFmD1
 wKmpCznhwYW60h8bbwBNrmaQxSUyotCMx6YiJNzqmhdaFwuJp9p4OMt5lO4jkNNkjEhlwNm
 PbA/cpynZI66g/mEvvdRQ==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:q3aew6AlwJ4=:ixRs8Mf5aY/UJ9Vn/Hkcj/
 +4ya2F/k0c5RLxn7JzJ+q/nFSoIdHix7z0JIdEDTZY2fL1TDA5xGRCEyR9q3VuIGN6S5hHYv8
 7B+L6v3E+3dlde75Ftb4UcDd1rz1NS0AZ/F3RwleJHV8GkrSykJW5MbEEujWbRrOVWte7gkZ/
 gt3qjaH7dF3L95ZIfHfD8IbOjwGDV7EazbEEOAIBgdXQSPLkrMiGkhboWt2mJbuLf+Vu3vaxN
 l0zyau97oPkkCh4ifXlArBOu5qXiZAXpj8q2wify14jO2rQb5m5CYM4W1Myb9I8FoOEtdJ/91
 Pgq/O2pMaA0Wks+a5PYV7NJLeq+N/FiqwT5kXYinZ+K0X1iTmMs4gtcTKDALUy1cE4GzQYNbP
 85xHtVqKP80iGykVntL/Q7oTAXNCbrmtQUQoRyuiU+j9hQ2j3nnVtzoXhyhska2S0GW2cNHlV
 PoSYBoV3mMn3bxomoc2SxDl2qWcWtwlR6rhUJNZBCiFXd7U8vLeiGxC0hBZsEQPpTTDmNSWBS
 l0MDM4Ng0Ywvapx2OZBgWjoW6NC4KAzDZKypalCHYvIeWqh96BAPqQtxqQCM3u2S7SbGjmosl
 OhzEk+FCpJD5yW9p70jZi17kA7tOnaPGqZMbIyfWCVg4T/Yhu9yhfs2xXTXk3bB5MhVOSkmgT
 p9sZgPKd6Lu5qfhhxprD/d85Q007A8rmJbJOo85jFix5C2VMbImBoYghcHa5rmaiJCytIN5eS
 sUsQiYYI3whKvtZQTO+lFbiMu3fN3QKH+pElHg==
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

For 31-bit s390 user space, we have to pass pointer arguments through
compat_ptr() in the compat_ioctl handler.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/xfs/xfs_ioctl32.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_ioctl32.c b/fs/xfs/xfs_ioctl32.c
index 7fcf7569743f..ad91e81a2fcf 100644
--- a/fs/xfs/xfs_ioctl32.c
+++ b/fs/xfs/xfs_ioctl32.c
@@ -547,7 +547,7 @@ xfs_file_compat_ioctl(
 	struct inode		*inode = file_inode(filp);
 	struct xfs_inode	*ip = XFS_I(inode);
 	struct xfs_mount	*mp = ip->i_mount;
-	void			__user *arg = (void __user *)p;
+	void			__user *arg = compat_ptr(p);
 	int			error;
 
 	trace_xfs_file_compat_ioctl(ip);
@@ -576,7 +576,7 @@ xfs_file_compat_ioctl(
 	case XFS_IOC_SCRUB_METADATA:
 	case XFS_IOC_BULKSTAT:
 	case XFS_IOC_INUMBERS:
-		return xfs_file_ioctl(filp, cmd, p);
+		return xfs_file_ioctl(filp, cmd, (unsigned long)arg);
 #if !defined(BROKEN_X86_ALIGNMENT) || defined(CONFIG_X86_X32)
 	/*
 	 * These are handled fine if no alignment issues.  To support x32
@@ -602,7 +602,7 @@ xfs_file_compat_ioctl(
 	 */
 	case XFS_IOC_SWAPEXT:
 #endif
-		return xfs_file_ioctl(filp, cmd, p);
+		return xfs_file_ioctl(filp, cmd, (unsigned long)arg);
 #endif
 #if defined(BROKEN_X86_ALIGNMENT)
 	case XFS_IOC_ALLOCSP_32:
@@ -653,7 +653,7 @@ xfs_file_compat_ioctl(
 	case XFS_IOC_SETXFLAGS_32:
 	case XFS_IOC_GETVERSION_32:
 		cmd = _NATIVE_IOC(cmd, long);
-		return xfs_file_ioctl(filp, cmd, p);
+		return xfs_file_ioctl(filp, cmd, (unsigned long)arg);
 	case XFS_IOC_SWAPEXT_32: {
 		struct xfs_swapext	  sxp;
 		struct compat_xfs_swapext __user *sxu = arg;
-- 
2.20.0


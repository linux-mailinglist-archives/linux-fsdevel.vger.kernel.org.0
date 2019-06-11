Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C87783C317
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2019 06:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391158AbfFKEuO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Jun 2019 00:50:14 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46456 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389620AbfFKEuO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Jun 2019 00:50:14 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4hbtt159138;
        Tue, 11 Jun 2019 04:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=w6B62XWgEySnIWZsve79cF+lTRasJpmyyQueK4g93UE=;
 b=xr/OkVp95W9CZa1qjVKbtngLN9J+a0uZavn2r3ArsGbLa3Idt+XiHAevESEnFd2Muawd
 IDeKByu9gQWLom5QvFu9SB6aGdiFJoCp0tz7vKlzNewkahhwnjXvO0YFc7SwTBUu/TXr
 1JAzKRa/DZxlP4ZZpnIqV/L0X1JujwSoecEOGG343C3b9FaK4zuy1R0cRIGXh59pnwVC
 rgO1+qT0i60g5fCtoX0xlqOK/qTFrDgQsRkvoiZce/aNAuX3Lrp5ll2wDFoSsEQSMY+0
 xO05b6rP2HVkV4MLCu2gbQsaloZCyjVElf52i0un57IO4AUWcCHG2FJLiCzCFi61Ne0u iQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2t04etjm38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 04:49:06 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5B4jGrX167613;
        Tue, 11 Jun 2019 04:47:06 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 2t024u6kpg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Jun 2019 04:47:06 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5B4l5Gj171026;
        Tue, 11 Jun 2019 04:47:06 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t024u6kpc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 Jun 2019 04:47:05 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5B4l4Q5023284;
        Tue, 11 Jun 2019 04:47:04 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 10 Jun 2019 21:47:04 -0700
Subject: [PATCH 6/6] xfs: clean up xfs_merge_ioc_xflags
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        darrick.wong@oracle.com, ard.biesheuvel@linaro.org,
        josef@toxicpanda.com, clm@fb.com, adilger.kernel@dilger.ca,
        viro@zeniv.linux.org.uk, jack@suse.com, dsterba@suse.com,
        jaegeuk@kernel.org, jk@ozlabs.org
Cc:     reiserfs-devel@vger.kernel.org, linux-efi@vger.kernel.org,
        devel@lists.orangefs.org, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        linux-mtd@lists.infradead.org, ocfs2-devel@oss.oracle.com,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Date:   Mon, 10 Jun 2019 21:47:01 -0700
Message-ID: <156022842153.3227213.3285668171167534801.stgit@magnolia>
In-Reply-To: <156022836912.3227213.13598042497272336695.stgit@magnolia>
References: <156022836912.3227213.13598042497272336695.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9284 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=605 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906110033
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

Clean up the calling convention since we're editing the fsxattr struct
anyway.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/xfs/xfs_ioctl.c |   32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)


diff --git a/fs/xfs/xfs_ioctl.c b/fs/xfs/xfs_ioctl.c
index 7b19ba2956ad..a67bc9afdd0b 100644
--- a/fs/xfs/xfs_ioctl.c
+++ b/fs/xfs/xfs_ioctl.c
@@ -829,35 +829,31 @@ xfs_ioc_ag_geometry(
  * Linux extended inode flags interface.
  */
 
-STATIC unsigned int
+static inline void
 xfs_merge_ioc_xflags(
-	unsigned int	flags,
-	unsigned int	start)
+	struct fsxattr	*fa,
+	unsigned int	flags)
 {
-	unsigned int	xflags = start;
-
 	if (flags & FS_IMMUTABLE_FL)
-		xflags |= FS_XFLAG_IMMUTABLE;
+		fa->fsx_xflags |= FS_XFLAG_IMMUTABLE;
 	else
-		xflags &= ~FS_XFLAG_IMMUTABLE;
+		fa->fsx_xflags &= ~FS_XFLAG_IMMUTABLE;
 	if (flags & FS_APPEND_FL)
-		xflags |= FS_XFLAG_APPEND;
+		fa->fsx_xflags |= FS_XFLAG_APPEND;
 	else
-		xflags &= ~FS_XFLAG_APPEND;
+		fa->fsx_xflags &= ~FS_XFLAG_APPEND;
 	if (flags & FS_SYNC_FL)
-		xflags |= FS_XFLAG_SYNC;
+		fa->fsx_xflags |= FS_XFLAG_SYNC;
 	else
-		xflags &= ~FS_XFLAG_SYNC;
+		fa->fsx_xflags &= ~FS_XFLAG_SYNC;
 	if (flags & FS_NOATIME_FL)
-		xflags |= FS_XFLAG_NOATIME;
+		fa->fsx_xflags |= FS_XFLAG_NOATIME;
 	else
-		xflags &= ~FS_XFLAG_NOATIME;
+		fa->fsx_xflags &= ~FS_XFLAG_NOATIME;
 	if (flags & FS_NODUMP_FL)
-		xflags |= FS_XFLAG_NODUMP;
+		fa->fsx_xflags |= FS_XFLAG_NODUMP;
 	else
-		xflags &= ~FS_XFLAG_NODUMP;
-
-	return xflags;
+		fa->fsx_xflags &= ~FS_XFLAG_NODUMP;
 }
 
 STATIC unsigned int
@@ -1504,7 +1500,7 @@ xfs_ioc_setxflags(
 		return -EOPNOTSUPP;
 
 	__xfs_ioc_fsgetxattr(ip, false, &fa);
-	fa.fsx_xflags = xfs_merge_ioc_xflags(flags, fa.fsx_xflags);
+	xfs_merge_ioc_xflags(&fa, flags);
 
 	error = mnt_want_write_file(filp);
 	if (error)


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 515834F1D5
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Jun 2019 01:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbfFUX6g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 21 Jun 2019 19:58:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49948 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726054AbfFUX6e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 21 Jun 2019 19:58:34 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LNsvRV052754;
        Fri, 21 Jun 2019 23:57:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=H3uevlbLebMWG9Gcus8tT+xdX29l/sejQz3Gcj6GgOM=;
 b=OcnqzjPSKPtrxCRWYar6ofhsldYVF9c+tkfBHXonTVfuZMYUnfzwd+pZBE075w5zCRmi
 ZvsUfy3kAcVu/YedEjN9R/6USufYjacFfPaKsIdUv80jaVBQnD/OAu6lBasg+yQiEqjP
 eKuWczOltqaQsSQOKOYn/WyUhF9mG4q9hlyIS5IHkJIYG9MP/Y+1AJ1FU73ge2OLZkP1
 hZaOIE2TRbrQFAunY0/VNR5vRAiBxDfmhK6deScIzINNLh1gycqSUk/W9IUPYABlnujp
 Ix4fU3tFgbn/QJ+lm60ma+H/Asm2thRj0sXAL9MfISyk+U6RhkB3o0SFsco43PF8crSz hg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t7809rsx8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 23:57:29 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5LNvQ7S171581;
        Fri, 21 Jun 2019 23:57:28 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3030.oracle.com with ESMTP id 2t7rdy064m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 21 Jun 2019 23:57:28 +0000
Received: from aserp3030.oracle.com (aserp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5LNvS47171635;
        Fri, 21 Jun 2019 23:57:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t7rdy064f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jun 2019 23:57:28 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5LNvPo2020773;
        Fri, 21 Jun 2019 23:57:26 GMT
Received: from localhost (/10.159.131.214)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 21 Jun 2019 16:57:25 -0700
Subject: [PATCH 4/7] vfs: don't allow most setxattr to immutable files
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
Date:   Fri, 21 Jun 2019 16:57:23 -0700
Message-ID: <156116144305.1664939.3544724373475771930.stgit@magnolia>
In-Reply-To: <156116141046.1664939.11424021489724835645.stgit@magnolia>
References: <156116141046.1664939.11424021489724835645.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9295 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=885 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906210182
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

The chattr manpage has this to say about immutable files:

"A file with the 'i' attribute cannot be modified: it cannot be deleted
or renamed, no link can be created to this file, most of the file's
metadata can not be modified, and the file can not be opened in write
mode."

However, we don't actually check the immutable flag in the setattr code,
which means that we can update inode flags and project ids and extent
size hints on supposedly immutable files.  Therefore, reject setflags
and fssetxattr calls on an immutable file if the file is immutable and
will remain that way.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/inode.c |   27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)


diff --git a/fs/inode.c b/fs/inode.c
index 6374ad2ef25b..220caefc31f7 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2204,6 +2204,14 @@ int vfs_ioc_setflags_check(struct inode *inode, int oldflags, int flags)
 	    !capable(CAP_LINUX_IMMUTABLE))
 		return -EPERM;
 
+	/*
+	 * We aren't allowed to change any other flags if the immutable flag is
+	 * already set and is not being unset.
+	 */
+	if ((oldflags & FS_IMMUTABLE_FL) && (flags & FS_IMMUTABLE_FL) &&
+	    oldflags != flags)
+		return -EPERM;
+
 	return 0;
 }
 EXPORT_SYMBOL(vfs_ioc_setflags_check);
@@ -2246,6 +2254,25 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
 	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
+	/*
+	 * We aren't allowed to change any fields if the immutable flag is
+	 * already set and is not being unset.
+	 */
+	if ((old_fa->fsx_xflags & FS_XFLAG_IMMUTABLE) &&
+	    (fa->fsx_xflags & FS_XFLAG_IMMUTABLE)) {
+		if (old_fa->fsx_xflags != fa->fsx_xflags)
+			return -EPERM;
+		if (old_fa->fsx_projid != fa->fsx_projid)
+			return -EPERM;
+		if ((fa->fsx_xflags & (FS_XFLAG_EXTSIZE |
+				       FS_XFLAG_EXTSZINHERIT)) &&
+		    old_fa->fsx_extsize != fa->fsx_extsize)
+			return -EPERM;
+		if ((old_fa->fsx_xflags & FS_XFLAG_COWEXTSIZE) &&
+		    old_fa->fsx_cowextsize != fa->fsx_cowextsize)
+			return -EPERM;
+	}
+
 	/* Extent size hints of zero turn off the flags. */
 	if (fa->fsx_extsize == 0)
 		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);


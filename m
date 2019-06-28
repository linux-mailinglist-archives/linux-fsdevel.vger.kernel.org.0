Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92A6D5A3CD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jun 2019 20:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726956AbfF1Sf2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jun 2019 14:35:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39078 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbfF1Sf2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jun 2019 14:35:28 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIYbxU114935;
        Fri, 28 Jun 2019 18:34:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : from : to :
 cc : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2018-07-02;
 bh=h0lWCLVuyu0P/36h1LaiA53s/qIbwAY/ZQm2+JFVybY=;
 b=13CJOqK6DbCKgAFDEdGfXZEvVfIS00B34kg4IH2cPp93lXn2rhMJKQVcwMqYiZ9PEp2q
 drixofMcAlyipPy+d/Jo+Il4ybSrgLHbAvgw4tK50RD45sM6EK0M99Ng0lKMs9md8KqU
 5tWdoa087WIWXwrn2s04wAsed02vkTR17Ptv29tbMr+oiYCUt2st5FEwhJD+kbBFNC1C
 d6Cbdu48A/VnHcS1l1Uyg1hNGBWFXjSndaRyJNjjEv58y9c32fT1M9Wdzfgtx8/joI9R
 m5/NhIOc7kzQsT4bnybWNh+KY3MzGG2YNT1bb9zN/F0Q8J/dIXekyku7LABnmpwudcIb EA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2t9cyqxyhm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:34:37 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5SIY3ak141544;
        Fri, 28 Jun 2019 18:34:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by userp3030.oracle.com with ESMTP id 2t99f5qutn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jun 2019 18:34:36 +0000
Received: from userp3030.oracle.com (userp3030.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x5SIYaxV142280;
        Fri, 28 Jun 2019 18:34:36 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2t99f5qutg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jun 2019 18:34:36 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5SIYYg3021719;
        Fri, 28 Jun 2019 18:34:34 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 28 Jun 2019 11:34:34 -0700
Subject: [PATCH 5/5] vfs: only allow FSSETXATTR to set DAX flag on files and
 dirs
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     matthew.garrett@nebula.com, yuchao0@huawei.com, tytso@mit.edu,
        darrick.wong@oracle.com, shaggy@kernel.org,
        ard.biesheuvel@linaro.org, josef@toxicpanda.com, hch@infradead.org,
        clm@fb.com, adilger.kernel@dilger.ca, jk@ozlabs.org, jack@suse.com,
        dsterba@suse.com, jaegeuk@kernel.org, viro@zeniv.linux.org.uk
Cc:     cluster-devel@redhat.com, jfs-discussion@lists.sourceforge.net,
        linux-efi@vger.kernel.org, reiserfs-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-nilfs@vger.kernel.org, linux-mtd@lists.infradead.org,
        ocfs2-devel@oss.oracle.com, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Date:   Fri, 28 Jun 2019 11:34:31 -0700
Message-ID: <156174687185.1557318.13703922197244050336.stgit@magnolia>
In-Reply-To: <156174682897.1557318.14418894077683701275.stgit@magnolia>
References: <156174682897.1557318.14418894077683701275.stgit@magnolia>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9302 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=965 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906280210
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Darrick J. Wong <darrick.wong@oracle.com>

The DAX flag only applies to files and directories, so don't let it get
set for other types of files.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
---
 fs/inode.c |    8 ++++++++
 1 file changed, 8 insertions(+)


diff --git a/fs/inode.c b/fs/inode.c
index 670d5408d022..f08711b34341 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -2259,6 +2259,14 @@ int vfs_ioc_fssetxattr_check(struct inode *inode, const struct fsxattr *old_fa,
 	    !S_ISREG(inode->i_mode) && !S_ISDIR(inode->i_mode))
 		return -EINVAL;
 
+	/*
+	 * It is only valid to set the DAX flag on regular files and
+	 * directories on filesystems.
+	 */
+	if ((fa->fsx_xflags & FS_XFLAG_DAX) &&
+	    !(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode)))
+		return -EINVAL;
+
 	/* Extent size hints of zero turn off the flags. */
 	if (fa->fsx_extsize == 0)
 		fa->fsx_xflags &= ~(FS_XFLAG_EXTSIZE | FS_XFLAG_EXTSZINHERIT);


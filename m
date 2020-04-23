Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACFD1B59A1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Apr 2020 12:49:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgDWKtE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Apr 2020 06:49:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:43170 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727111AbgDWKtE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Apr 2020 06:49:04 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03NAXUft143755
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:49:03 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30k09wf99h-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 23 Apr 2020 06:49:03 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 23 Apr 2020 11:48:36 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com (9.149.109.197)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 23 Apr 2020 11:48:31 +0100
Received: from d06av25.portsmouth.uk.ibm.com (d06av25.portsmouth.uk.ibm.com [9.149.105.61])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03NAms6t59900112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 23 Apr 2020 10:48:54 GMT
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A711611C052;
        Thu, 23 Apr 2020 10:48:54 +0000 (GMT)
Received: from d06av25.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9370311C050;
        Thu, 23 Apr 2020 10:48:51 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.60.18])
        by d06av25.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 23 Apr 2020 10:48:51 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     jack@suse.cz, tytso@mit.edu, adilger@dilger.ca,
        darrick.wong@oracle.com, hch@infradead.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Murphy Zhou <jencce.kernel@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: [PATCH 5/5] ext4: Get rid of ext4_fiemap_check_ranges
Date:   Thu, 23 Apr 2020 16:17:57 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1587555962.git.riteshh@linux.ibm.com>
References: <cover.1587555962.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20042310-0012-0000-0000-000003A9CB98
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20042310-0013-0000-0000-000021E71F88
Message-Id: <b2edd7710f07d94101a6055e398a5e4ed01f09bf.1587555962.git.riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-23_07:2020-04-22,2020-04-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=1 phishscore=0 clxscore=1015 adultscore=0 mlxlogscore=999
 bulkscore=0 impostorscore=0 spamscore=0 mlxscore=0 priorityscore=1501
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004230082
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Now that fiemap_check_ranges() is available for other filesystems
to use, so get rid of ext4's private version.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/ioctl.c | 25 +------------------------
 1 file changed, 1 insertion(+), 24 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index 76a2b5200ba3..6a7d7e9027cd 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -733,29 +733,6 @@ static void ext4_fill_fsxattr(struct inode *inode, struct fsxattr *fa)
 		fa->fsx_projid = from_kprojid(&init_user_ns, ei->i_projid);
 }
 
-/* copied from fs/ioctl.c */
-static int ext4_fiemap_check_ranges(struct super_block *sb,
-			       u64 start, u64 len, u64 *new_len)
-{
-	u64 maxbytes = (u64) sb->s_maxbytes;
-
-	*new_len = len;
-
-	if (len == 0)
-		return -EINVAL;
-
-	if (start > maxbytes)
-		return -EFBIG;
-
-	/*
-	 * Shrink request scope to what the fs can actually handle.
-	 */
-	if (len > maxbytes || (maxbytes - len) < start)
-		*new_len = maxbytes - start;
-
-	return 0;
-}
-
 /* So that the fiemap access checks can't overflow on 32 bit machines. */
 #define FIEMAP_MAX_EXTENTS	(UINT_MAX / sizeof(struct fiemap_extent))
 
@@ -775,7 +752,7 @@ static int ext4_ioctl_get_es_cache(struct file *filp, unsigned long arg)
 	if (fiemap.fm_extent_count > FIEMAP_MAX_EXTENTS)
 		return -EINVAL;
 
-	error = ext4_fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
+	error = fiemap_check_ranges(sb, fiemap.fm_start, fiemap.fm_length,
 				    &len);
 	if (error)
 		return error;
-- 
2.21.0


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26FD01BEF78
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 06:56:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726411AbgD3E4I (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 00:56:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29260 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726337AbgD3E4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 00:56:08 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U4WXsR061953;
        Thu, 30 Apr 2020 00:55:32 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhqada3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 00:55:32 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03U4pPve010649;
        Thu, 30 Apr 2020 04:55:29 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma01fra.de.ibm.com with ESMTP id 30mcu8ebtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 04:55:29 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03U4tRhI49086520
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 04:55:27 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id F376F42041;
        Thu, 30 Apr 2020 04:55:26 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 795ED42042;
        Thu, 30 Apr 2020 04:55:24 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.35.53])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 04:55:24 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv3 1/1] fibmap: Warn and return an error in case of block > INT_MAX
Date:   Thu, 30 Apr 2020 10:25:18 +0530
Message-Id: <b95aca069607600ffd1efc95803cf39c13768b4d.1588222212.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_01:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0
 priorityscore=1501 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300030
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

We better warn the fibmap user and not return a truncated and therefore
an incorrect block map address if the bmap() returned block address
is greater than INT_MAX (since user supplied integer pointer).

It's better to pr_warn() all user of ioctl_fibmap() and return a proper
error code rather than silently letting a FS corruption happen if the
user tries to fiddle around with the returned block map address.

We fix this by returning an error code of -ERANGE and returning 0 as the
block mapping address in case if it is > INT_MAX.

Now iomap_bmap() could be called from either of these two paths.
Either when a user is calling an ioctl_fibmap() interface to get
the block mapping address or by some filesystem via use of bmap()
internal kernel API.
bmap() kernel API is well equipped with handling of u64 addresses.

WARN condition in iomap_bmap_actor() was mainly added to warn all
the fibmap users. But now that we have directly added this warning
for all fibmap users and also made sure to return 0 as block map address
in case if addr > INT_MAX.
So we can now remove this logic from iomap_bmap_actor().

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
v2 -> v3:
1. Added file path info using (%pD4)
2. Dropped Reviewed-by tags for reviewing this final version.

 fs/ioctl.c        | 8 ++++++++
 fs/iomap/fiemap.c | 5 +----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index f1d93263186c..6b8629fbe0fd 100644
--- a/fs/ioctl.c
+++ b/fs/ioctl.c
@@ -55,6 +55,7 @@ EXPORT_SYMBOL(vfs_ioctl);
 static int ioctl_fibmap(struct file *filp, int __user *p)
 {
 	struct inode *inode = file_inode(filp);
+	struct super_block *sb = inode->i_sb;
 	int error, ur_block;
 	sector_t block;
 
@@ -71,6 +72,13 @@ static int ioctl_fibmap(struct file *filp, int __user *p)
 	block = ur_block;
 	error = bmap(inode, &block);
 
+	if (block > INT_MAX) {
+		error = -ERANGE;
+		pr_warn_ratelimited("[%s/%d] FS: %s File: %pD4 would truncate fibmap result\n",
+				    current->comm, task_pid_nr(current),
+				    sb->s_id, filp);
+	}
+
 	if (error)
 		ur_block = 0;
 	else
diff --git a/fs/iomap/fiemap.c b/fs/iomap/fiemap.c
index bccf305ea9ce..d55e8f491a5e 100644
--- a/fs/iomap/fiemap.c
+++ b/fs/iomap/fiemap.c
@@ -117,10 +117,7 @@ iomap_bmap_actor(struct inode *inode, loff_t pos, loff_t length,
 
 	if (iomap->type == IOMAP_MAPPED) {
 		addr = (pos - iomap->offset + iomap->addr) >> inode->i_blkbits;
-		if (addr > INT_MAX)
-			WARN(1, "would truncate bmap result\n");
-		else
-			*bno = addr;
+		*bno = addr;
 	}
 	return 0;
 }
-- 
2.21.0


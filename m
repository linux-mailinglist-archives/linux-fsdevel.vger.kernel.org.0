Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE6B01BB7D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Apr 2020 09:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgD1HjC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Apr 2020 03:39:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33102 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726565AbgD1HjB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Apr 2020 03:39:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03S7VbEu123945;
        Tue, 28 Apr 2020 03:38:46 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30mhr6hm4d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 03:38:46 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03S7Vbup007529;
        Tue, 28 Apr 2020 07:38:44 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma03fra.de.ibm.com with ESMTP id 30mcu58n7e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Apr 2020 07:38:44 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03S7cfvh3277088
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Apr 2020 07:38:41 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 45AB55204E;
        Tue, 28 Apr 2020 07:38:41 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.43.36])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id BFDE652051;
        Tue, 28 Apr 2020 07:38:38 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jan Kara <jack@suse.com>, tytso@mit.edu,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>,
        Jan Kara <jack@suse.cz>, Christoph Hellwig <hch@lst.de>
Subject: [PATCHv2] fibmap: Warn and return an error in case of block > INT_MAX
Date:   Tue, 28 Apr 2020 13:08:31 +0530
Message-Id: <58f0c64a3f2dbd363fb93371435f6bcaeeb7abe4.1588058868.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-28_03:2020-04-27,2020-04-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxscore=0 suspectscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2004280060
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

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
v1 -> v2: 
1. Improved error log msg.
2. Clubbed both iomap change and fibmap change into 1 patch.
3. Added Reviewed-by tags.

 fs/ioctl.c        | 8 ++++++++
 fs/iomap/fiemap.c | 5 +----
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/ioctl.c b/fs/ioctl.c
index f1d93263186c..adc1e8178c43 100644
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
+		pr_warn_ratelimited("[%s/%d] FS (%s): would truncate fibmap result\n",
+				    current->comm, task_pid_nr(current),
+				    sb->s_id);
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


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9198011C5A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Dec 2019 06:56:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbfLLF4M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 12 Dec 2019 00:56:12 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:28074 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727704AbfLLF4M (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 12 Dec 2019 00:56:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC5k7Kg021260
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 00:56:11 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf8jsd0g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Dec 2019 00:56:11 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Thu, 12 Dec 2019 05:56:08 -0000
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp07.uk.ibm.com (192.168.101.137) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Thu, 12 Dec 2019 05:56:06 -0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xBC5u5fm61014170
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 12 Dec 2019 05:56:05 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 11A4CAE056;
        Thu, 12 Dec 2019 05:56:05 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BDD86AE04D;
        Thu, 12 Dec 2019 05:56:02 +0000 (GMT)
Received: from dhcp-9-199-158-163.in.ibm.com (unknown [9.199.158.163])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 12 Dec 2019 05:56:02 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     jack@suse.cz, tytso@mit.edu, linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, mbobrowski@mbobrowski.org,
        joseph.qi@linux.alibaba.com, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv5 1/3] ext4: fix ext4_dax_read/write inode locking sequence for IOCB_NOWAIT
Date:   Thu, 12 Dec 2019 11:25:55 +0530
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191212055557.11151-1-riteshh@linux.ibm.com>
References: <20191212055557.11151-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19121205-0028-0000-0000-000003C7BB42
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19121205-0029-0000-0000-0000248AF293
Message-Id: <20191212055557.11151-2-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.95,18.0.572
 definitions=2019-12-12_01:2019-12-12,2019-12-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=3 bulkscore=0
 clxscore=1015 priorityscore=1501 malwarescore=0 phishscore=0
 mlxlogscore=958 impostorscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-1910280000 definitions=main-1912120036
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Apparently our current rwsem code doesn't like doing the trylock, then
lock for real scheme.  So change our dax read/write methods to just do the
trylock for the RWF_NOWAIT case.
This seems to fix AIM7 regression in some scalable filesystems upto ~25%
in some cases. Claimed in commit 942491c9e6d6 ("xfs: fix AIM7 regression")

Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
Tested-by: Joseph Qi <joseph.qi@linux.alibaba.com>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/file.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 6a7293a5cda2..977ac58dc718 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -88,9 +88,10 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
-	if (!inode_trylock_shared(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock_shared(inode))
 			return -EAGAIN;
+	} else {
 		inode_lock_shared(inode);
 	}
 	/*
@@ -487,9 +488,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	bool extend = false;
 	struct inode *inode = file_inode(iocb->ki_filp);
 
-	if (!inode_trylock(inode)) {
-		if (iocb->ki_flags & IOCB_NOWAIT)
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!inode_trylock(inode))
 			return -EAGAIN;
+	} else {
 		inode_lock(inode);
 	}
 
-- 
2.21.0


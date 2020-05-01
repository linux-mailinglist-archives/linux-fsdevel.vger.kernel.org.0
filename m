Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C63E21C0E1F
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728339AbgEAGaq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:46 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30254 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728126AbgEAGaq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:46 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162AUh108194;
        Fri, 1 May 2020 02:30:40 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30r5cmnj1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:39 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416Aqrb009348;
        Fri, 1 May 2020 06:30:38 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 30mcu746rs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:38 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416UZMA62849094
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:35 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 75323A4054;
        Fri,  1 May 2020 06:30:35 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AAB37A405C;
        Fri,  1 May 2020 06:30:33 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:33 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 13/20] ext4: mballoc: Don't BUG if kmalloc or read blk bitmap fail for DOUBLE_CHECK
Date:   Fri,  1 May 2020 11:59:55 +0530
Message-Id: <e0ec6f93833863d35577028abacb7f0ca8b46e96.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 impostorscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=3 bulkscore=0
 priorityscore=1501 mlxlogscore=999 malwarescore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005010040
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Remove the BUG_ON() logic if kmalloc() or ext4_read_block_bitmap() fails.
We should simply mark grp->bb_bitmap as NULL if above happens.
In fact ext4_read_block_bitmap() may even return an error in case of resize
ioctl. Hence remove this BUG_ON logic (fstests ext4/032 may trigger
this).

---
Should we add a ext4_msg() if any of above fails?

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index e32f3675f962..aa22ecf3f827 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -548,13 +548,20 @@ static void mb_group_bb_bitmap_alloc(struct super_block *sb,
 	struct buffer_head *bh;
 
 	grp->bb_bitmap = kmalloc(sb->s_blocksize, GFP_NOFS);
-	BUG_ON(grp->bb_bitmap == NULL);
+	if (!grp->bb_bitmap)
+		goto out;
 
 	bh = ext4_read_block_bitmap(sb, group);
-	BUG_ON(IS_ERR_OR_NULL(bh));
+	if (IS_ERR_OR_NULL(bh)) {
+		kfree(grp->bb_bitmap);
+		grp->bb_bitmap = NULL;
+		goto out;
+	}
 
 	memcpy(grp->bb_bitmap, bh->b_data, sb->s_blocksize);
 	put_bh(bh);
+out:
+	return;
 }
 
 static void mb_group_bb_bitmap_free(struct ext4_group_info *grp)
-- 
2.21.0


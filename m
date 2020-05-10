Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C9161CC73C
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgEJGZq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:46 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36662 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727122AbgEJGZp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:45 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A63bsY124590;
        Sun, 10 May 2020 02:25:41 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wrvxc5ac-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:41 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6KULw022915;
        Sun, 10 May 2020 06:25:39 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma01fra.de.ibm.com with ESMTP id 30wm558teq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:38 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PaGM57933866
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:36 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 1C4FD42042;
        Sun, 10 May 2020 06:25:36 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8EEE142049;
        Sun, 10 May 2020 06:25:34 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:34 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 09/16] ext4: mballoc: Fix possible NULL ptr & remove BUG_ONs from DOUBLE_CHECK
Date:   Sun, 10 May 2020 11:54:49 +0530
Message-Id: <9a54f8a696ff17c057cd571be3d15ac3ec1407f1.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 impostorscore=0
 lowpriorityscore=0 phishscore=0 priorityscore=1501 suspectscore=1
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Make sure to check for e4b->bd_info->bb_bitmap == NULL, in
mb_cmp_bitmaps() and return if NULL, to avoid possible NULL ptr
dereference. Similar to how we do this in other ifdef DOUBLE_CHECK
functions.

Also remove the BUG_ON() logic if kmalloc() or ext4_read_block_bitmap()
fails. We should simply mark grp->bb_bitmap as NULL if above happens.
In fact ext4_read_block_bitmap() may even return an error in case of resize
ioctl. Hence remove this BUG_ON logic (fstests ext4/032 may trigger
this).

---
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 3555e72f149c..c713d06e70b7 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -493,6 +493,8 @@ static void mb_mark_used_double(struct ext4_buddy *e4b, int first, int count)
 
 static void mb_cmp_bitmaps(struct ext4_buddy *e4b, void *bitmap)
 {
+	if (unlikely(e4b->bd_info->bb_bitmap == NULL))
+		return;
 	if (memcmp(e4b->bd_info->bb_bitmap, bitmap, e4b->bd_sb->s_blocksize)) {
 		unsigned char *b1, *b2;
 		int i;
@@ -517,10 +519,15 @@ static void mb_group_bb_bitmap_alloc(struct super_block *sb,
 	struct buffer_head *bh;
 
 	grp->bb_bitmap = kmalloc(sb->s_blocksize, GFP_NOFS);
-	BUG_ON(grp->bb_bitmap == NULL);
+	if (!grp->bb_bitmap)
+		return;
 
 	bh = ext4_read_block_bitmap(sb, group);
-	BUG_ON(IS_ERR_OR_NULL(bh));
+	if (IS_ERR_OR_NULL(bh)) {
+		kfree(grp->bb_bitmap);
+		grp->bb_bitmap = NULL;
+		return;
+	}
 
 	memcpy(grp->bb_bitmap, bh->b_data, sb->s_blocksize);
 	put_bh(bh);
-- 
2.21.0


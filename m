Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2ABAE1CC777
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 09:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728564AbgEJHI5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 03:08:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18520 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728332AbgEJHI5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 03:08:57 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A6cg9i023089;
        Sun, 10 May 2020 03:08:48 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30wsc248s5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 03:08:48 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A75G9x027632;
        Sun, 10 May 2020 07:08:46 GMT
Received: from b06avi18878370.portsmouth.uk.ibm.com (b06avi18878370.portsmouth.uk.ibm.com [9.149.26.194])
        by ppma04fra.de.ibm.com with ESMTP id 30wm55gtvd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 07:08:46 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06avi18878370.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A78h8D61604298
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 07:08:43 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 747BF42045;
        Sun, 10 May 2020 07:08:43 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 73DBF42041;
        Sun, 10 May 2020 07:08:41 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 07:08:41 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFCv4 2/6] ext4: mballoc: Use ext4_lock_group() around calculations involving bb_free
Date:   Sun, 10 May 2020 12:38:22 +0530
Message-Id: <015bd57d5ff409cef6d452dffd4c140848ea5021.1589086820.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086820.git.riteshh@linux.ibm.com>
References: <cover.1589086820.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_02:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 impostorscore=0 adultscore=0 mlxscore=0 malwarescore=0 priorityscore=1501
 spamscore=0 bulkscore=0 suspectscore=3 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100060
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently while doing block allocation grp->bb_free may be getting
modified if discard is happening in parallel.
For e.g. consider a case where there are lot of threads who have
preallocated lot of blocks and there is a thread which is trying
to discard all of this group's PA. Now it could happen that
we see all of those group's bb_free is zero and fail the allocation
while there is sufficient space if we free up all the PA.

So this patch takes the ext4_lock_group() around calculations involving
grp->bb_free in ext4_mb_good_group() & ext4_mb_good_group_nolock()

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index da11a4a738bd..dcd05ff7c012 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2138,9 +2138,11 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 				     ext4_group_t group, int cr)
 {
 	struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
+	struct super_block *sb = ac->ac_sb;
 	ext4_grpblk_t free;
 	int ret = 0;
 
+	ext4_lock_group(sb, group);
 	free = grp->bb_free;
 	if (free == 0)
 		goto out;
@@ -2148,6 +2150,7 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 		goto out;
 	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(grp)))
 		goto out;
+	ext4_unlock_group(sb, group);
 
 	/* We only do this if the grp has never been initialized */
 	if (unlikely(EXT4_MB_GRP_NEED_INIT(grp))) {
@@ -2156,8 +2159,10 @@ static int ext4_mb_good_group_nolock(struct ext4_allocation_context *ac,
 			return ret;
 	}
 
+	ext4_lock_group(sb, group);
 	ret = ext4_mb_good_group(ac, group, cr);
 out:
+	ext4_unlock_group(sb, group);
 	return ret;
 }
 
-- 
2.21.0


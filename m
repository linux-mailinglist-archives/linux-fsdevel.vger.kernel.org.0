Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0FD4AA959
	for <lists+linux-fsdevel@lfdr.de>; Sat,  5 Feb 2022 15:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380108AbiBEOK5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 5 Feb 2022 09:10:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42728 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380109AbiBEOKy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 5 Feb 2022 09:10:54 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 215Bdet2025892;
        Sat, 5 Feb 2022 14:10:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=S7qUl7KWN8noVApXnosvHpsF/XDi0OkOaCsxrI+B+OM=;
 b=PRWwYHVCGFvdLtVozxqq/GGnwS9r7QtemWEr7Pm/MFURoKU/FTsFLirdd6R2FqHzwv7g
 bKLLWrNrkTO8U8ChxZJu+CTbA0WiKxUucCnbxS31f+tTWHy2jWixszHITnBpgnp2c+Hg
 esZQ1xXt4biWUDhAmB1Z/hHjb5+aYbmnBY5g6ywakg4oWU9wOEcyfJh++WWfliOsTk8B
 WdHBmgCY2zN1RamHtp4DA8kdq00SKYJqeFO8juZ3T7F213SltLImBXATlm2lFWIxGODC
 U8pDUy5ZpsrVK9/AXddjRuQbAywmIW4dKs+xniYXeYbatTZ4Szjtc0x5RYwFpz7PhPls wQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1j7merje-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:50 +0000
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 215E9Iue010491;
        Sat, 5 Feb 2022 14:10:50 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3e1j7merhy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:50 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 215E3noZ003646;
        Sat, 5 Feb 2022 14:10:47 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma06fra.de.ibm.com with ESMTP id 3e1gghj3e6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 05 Feb 2022 14:10:47 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 215EAjIx44106198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 5 Feb 2022 14:10:45 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5B1F55204F;
        Sat,  5 Feb 2022 14:10:45 +0000 (GMT)
Received: from localhost (unknown [9.43.12.205])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 8333452050;
        Sat,  5 Feb 2022 14:10:43 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Jan Kara <jack@suse.cz>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCHv1 9/9] ext4: Add extra check in ext4_mb_mark_bb() to prevent against possible corruption
Date:   Sat,  5 Feb 2022 19:39:58 +0530
Message-Id: <50eb09dbf5d8d67c7edb0a4c0146e184cf4e2ed0.1644062450.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1644062450.git.riteshh@linux.ibm.com>
References: <cover.1644062450.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Gq5FmipUeXrBPXibuGWyk6sWCcdlzzwL
X-Proofpoint-GUID: JPIrZMejHnjyrsdq_r0KOPjoclQcTTOD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-05_10,2022-02-03_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 bulkscore=0
 phishscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 spamscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxlogscore=597 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2201110000 definitions=main-2202050095
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This patch adds an extra checks in ext4_mb_mark_bb() function
to make sure we mark & report error if we were to mark/clear any
of the critical FS metadata specific bitmaps (&bail out) to prevent
from any accidental corruption.

Suggested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 9f2b3a057918..75c20a10529a 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -3918,6 +3918,14 @@ void ext4_mb_mark_bb(struct super_block *sb, ext4_fsblk_t block,
 			EXT4_BLOCKS_PER_GROUP(sb) - EXT4_C2B(sbi, blkoff));
 		clen = EXT4_NUM_B2C(sbi, thisgrp_len);
 
+		if (!ext4_sb_block_valid(sb, NULL, block, thisgrp_len)) {
+			ext4_error(sb, "Marking blocks in system zone - "
+				   "Block = %llu, len = %u",
+				   block, thisgrp_len);
+			bitmap_bh = NULL;
+			break;
+		}
+
 		bitmap_bh = ext4_read_block_bitmap(sb, group);
 		if (IS_ERR(bitmap_bh)) {
 			err = PTR_ERR(bitmap_bh);
-- 
2.31.1


Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D73716007
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:38:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjE3MiU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231937AbjE3MiD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:38:03 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A375E1B8;
        Tue, 30 May 2023 05:37:18 -0700 (PDT)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UBqlMG020740;
        Tue, 30 May 2023 12:35:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=2H9MOv1sHuP/C1tOjBsd9RLxHiXVX7EVkskRbQWhwpk=;
 b=jeHKPjxQ3afgx0s7XpkK6ez7NTFOqegpglrP5SKs2UIBh9Z6MngGMPT+wtm8MKujz+r7
 N0+ksR1mEvK0tufdX51tp5Nhl/2mIg1wUajp8IL2wIWjHb3xZ9lkVccy7epXggPlgKkJ
 F2bitSEXVG2UASN+1PjJJF5u2wU7QimkBk+2qIlJv7pr7YLSF8EOQ7iF9Dq07zQS8yc1
 g4uiTcV59SQz1ASFAenLgMyxAqZ6uGNbX3F620se2JXWvJ13S8yPKmvFwwlh9+xtmHRX
 dx7P6cIfuTXE/rnUqgg+gPbjINwCruA1Lv2yrmVVhnJlgB6YpQwcOKGO9jBnOfAqKSNI HA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwgnjs6ev-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:35:45 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UCIF7V029084;
        Tue, 30 May 2023 12:35:44 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwgnjs571-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:35:44 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U4nThV029752;
        Tue, 30 May 2023 12:34:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qu94e1fjn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:02 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCY0Ri30999202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:34:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 366E22004E;
        Tue, 30 May 2023 12:34:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4340E20040;
        Tue, 30 May 2023 12:33:58 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:33:58 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 03/12] ext4: Remove unused extern variables declaration
Date:   Tue, 30 May 2023 18:03:41 +0530
Message-Id: <928b3142062172533b6d1b5a94de94700590fef3.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 5wvMfDoqodiRioiBomsYd0XILeViIIqQ
X-Proofpoint-ORIG-GUID: 2YTTg_13dglJ3PbURNwBP2XO1N-gtaxY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 priorityscore=1501 mlxlogscore=999 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305300103
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

ext4_mb_stats & ext4_mb_max_to_scan are never used. We use
sbi->s_mb_stats and sbi->s_mb_max_to_scan instead.
Hence kill these extern declarations.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/ext4.h    | 2 --
 fs/ext4/mballoc.h | 2 +-
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index b39a52b93a26..c075da665ec1 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2835,8 +2835,6 @@ int ext4_fc_record_regions(struct super_block *sb, int ino,
 /* mballoc.c */
 extern const struct seq_operations ext4_mb_seq_groups_ops;
 extern const struct seq_operations ext4_mb_seq_structs_summary_ops;
-extern long ext4_mb_stats;
-extern long ext4_mb_max_to_scan;
 extern int ext4_seq_mb_stats_show(struct seq_file *seq, void *offset);
 extern int ext4_mb_init(struct super_block *);
 extern int ext4_mb_release(struct super_block *);
diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
index 6d85ee8674a6..24b666e558f1 100644
--- a/fs/ext4/mballoc.h
+++ b/fs/ext4/mballoc.h
@@ -49,7 +49,7 @@
 #define MB_DEFAULT_MIN_TO_SCAN		10
 
 /*
- * with 'ext4_mb_stats' allocator will collect stats that will be
+ * with 's_mb_stats' allocator will collect stats that will be
  * shown at umount. The collecting costs though!
  */
 #define MB_DEFAULT_STATS		0
-- 
2.31.1


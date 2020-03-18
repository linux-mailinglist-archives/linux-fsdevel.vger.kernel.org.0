Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03864189597
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Mar 2020 07:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbgCRGNN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Mar 2020 02:13:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:6470 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726871AbgCRGNN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Mar 2020 02:13:13 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02I645rm039802
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2020 02:13:12 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yu8hv20j3-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 18 Mar 2020 02:13:12 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <riteshh@linux.ibm.com>;
        Wed, 18 Mar 2020 06:13:10 -0000
Received: from b06cxnps4076.portsmouth.uk.ibm.com (9.149.109.198)
        by e06smtp02.uk.ibm.com (192.168.101.132) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 18 Mar 2020 06:13:08 -0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 02I6D7Ld52232262
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Mar 2020 06:13:07 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C042E4C05E;
        Wed, 18 Mar 2020 06:13:07 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF6B64C058;
        Wed, 18 Mar 2020 06:13:05 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.46.3])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Wed, 18 Mar 2020 06:13:05 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [PATCH] ext4: Unregister sysfs path before destroying jbd2 journal
Date:   Wed, 18 Mar 2020 11:43:01 +0530
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 20031806-0008-0000-0000-0000035F24B0
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 20031806-0009-0000-0000-00004A807DF5
Message-Id: <20200318061301.4320-1-riteshh@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.645
 definitions=2020-03-18_02:2020-03-17,2020-03-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_spam_definite policy=outbound score=100 mlxscore=0
 spamscore=0 suspectscore=0 mlxlogscore=320 priorityscore=1501
 impostorscore=0 phishscore=0 clxscore=1015 adultscore=0 malwarescore=0
 bulkscore=0 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2003020000 definitions=main-2003180029
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Call ext4_unregister_sysfs(), before destroying jbd2 journal,
since below might cause, NULL pointer dereference issue.
This got reported with LTP tests.

ext4_put_super() 		cat /sys/fs/ext4/loop2/journal_task
	| 				ext4_attr_show();
ext4_jbd2_journal_destroy();  			|
    	|				 journal_task_show()
	| 					|
	| 				task_pid_vnr(NULL);
sbi->s_journal = NULL;

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/super.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 5dc65b7583cb..27ab130a40d1 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -1024,6 +1024,13 @@ static void ext4_put_super(struct super_block *sb)
 
 	destroy_workqueue(sbi->rsv_conversion_wq);
 
+	/*
+	 * Unregister sysfs before destroying jbd2 journal.
+	 * Since we could still access attr_journal_task attribute via sysfs
+	 * path which could have sbi->s_journal->j_task as NULL
+	 */
+	ext4_unregister_sysfs(sb);
+
 	if (sbi->s_journal) {
 		aborted = is_journal_aborted(sbi->s_journal);
 		err = jbd2_journal_destroy(sbi->s_journal);
@@ -1034,7 +1041,6 @@ static void ext4_put_super(struct super_block *sb)
 		}
 	}
 
-	ext4_unregister_sysfs(sb);
 	ext4_es_unregister_shrinker(sbi);
 	del_timer_sync(&sbi->s_err_report);
 	ext4_release_system_zone(sb);
-- 
2.21.0


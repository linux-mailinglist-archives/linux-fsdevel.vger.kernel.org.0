Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A64C1CC74A
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:26:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgEJG0E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:26:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:61308 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728424AbgEJG0E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:26:04 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A62i7e117721;
        Sun, 10 May 2020 02:25:54 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30ws5cv010-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:54 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6KB8h004527;
        Sun, 10 May 2020 06:25:52 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 30wm568t86-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:52 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PnbG25034912
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:49 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A0ED842045;
        Sun, 10 May 2020 06:25:49 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E98E142041;
        Sun, 10 May 2020 06:25:47 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:47 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 16/16] ext4: Add process name and pid in ext4_msg()
Date:   Sun, 10 May 2020 11:54:56 +0530
Message-Id: <3d99e1291b3bc8f2a78467d11b1a7a31393180fc.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=1
 phishscore=0 spamscore=0 impostorscore=0 malwarescore=0 mlxlogscore=998
 lowpriorityscore=0 bulkscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This adds process name and pid for ext4_msg().
I found this to be useful. For e.g. below print gives more
info about process name and pid.

[ 7671.131912]  [mount/12543] EXT4-fs (dm-0): mounted filesystem with ordered data mode. Opts: acl,user_xattr

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index bf5fcb477f66..5067a47f4f46 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -756,7 +756,8 @@ void __ext4_msg(struct super_block *sb,
 	va_start(args, fmt);
 	vaf.fmt = fmt;
 	vaf.va = &args;
-	printk("%sEXT4-fs (%s): %pV\n", prefix, sb->s_id, &vaf);
+	printk("%s [%s/%d] EXT4-fs (%s): %pV\n", prefix, current->comm,
+		task_pid_nr(current), sb->s_id, &vaf);
 	va_end(args);
 }
 
-- 
2.21.0


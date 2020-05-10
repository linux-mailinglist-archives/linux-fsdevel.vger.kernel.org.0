Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFB41CC727
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 May 2020 08:25:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgEJGZe (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 10 May 2020 02:25:34 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65120 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725779AbgEJGZd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 10 May 2020 02:25:33 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04A639Uk043303;
        Sun, 10 May 2020 02:25:27 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30ws59bwwf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 02:25:27 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 04A6KB8f004527;
        Sun, 10 May 2020 06:25:25 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 30wm568t7x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 May 2020 06:25:25 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 04A6PMKa58458198
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 06:25:22 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CD04042041;
        Sun, 10 May 2020 06:25:22 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4528F4203F;
        Sun, 10 May 2020 06:25:21 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.199.61.127])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Sun, 10 May 2020 06:25:21 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 02/16] ext4: mballoc: Refactor ext4_mb_show_ac()
Date:   Sun, 10 May 2020 11:54:42 +0530
Message-Id: <8f07d890b0038dcc935e9c10e6043ec9f3792721.1589086800.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1589086800.git.riteshh@linux.ibm.com>
References: <cover.1589086800.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.676
 definitions=2020-05-10_01:2020-05-08,2020-05-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 priorityscore=1501 suspectscore=1 adultscore=0 impostorscore=0
 malwarescore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005100055
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

This factors out ext4_mb_show_pa() function to show all the group's
preallocation info. This could be useful info to be added in later
patches.

There should be no functionality change in this patch.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
 fs/ext4/mballoc.c | 65 +++++++++++++++++++++++++++++------------------
 1 file changed, 40 insertions(+), 25 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index bcfaaad62167..d1464d9110ef 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4120,38 +4120,16 @@ void ext4_discard_preallocations(struct inode *inode)
 }
 
 #ifdef CONFIG_EXT4_DEBUG
-static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
+static inline void ext4_mb_show_pa(struct super_block *sb)
 {
-	struct super_block *sb = ac->ac_sb;
-	ext4_group_t ngroups, i;
+	ext4_group_t i, ngroups;
 
 	if (!ext4_mballoc_debug ||
 	    (EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED))
 		return;
 
-	ext4_msg(ac->ac_sb, KERN_ERR, "Can't allocate:"
-			" Allocation context details:");
-	ext4_msg(ac->ac_sb, KERN_ERR, "status %d flags %d",
-			ac->ac_status, ac->ac_flags);
-	ext4_msg(ac->ac_sb, KERN_ERR, "orig %lu/%lu/%lu@%lu, "
-		 	"goal %lu/%lu/%lu@%lu, "
-			"best %lu/%lu/%lu@%lu cr %d",
-			(unsigned long)ac->ac_o_ex.fe_group,
-			(unsigned long)ac->ac_o_ex.fe_start,
-			(unsigned long)ac->ac_o_ex.fe_len,
-			(unsigned long)ac->ac_o_ex.fe_logical,
-			(unsigned long)ac->ac_g_ex.fe_group,
-			(unsigned long)ac->ac_g_ex.fe_start,
-			(unsigned long)ac->ac_g_ex.fe_len,
-			(unsigned long)ac->ac_g_ex.fe_logical,
-			(unsigned long)ac->ac_b_ex.fe_group,
-			(unsigned long)ac->ac_b_ex.fe_start,
-			(unsigned long)ac->ac_b_ex.fe_len,
-			(unsigned long)ac->ac_b_ex.fe_logical,
-			(int)ac->ac_criteria);
-	ext4_msg(ac->ac_sb, KERN_ERR, "%d found", ac->ac_found);
-	ext4_msg(ac->ac_sb, KERN_ERR, "groups: ");
 	ngroups = ext4_get_groups_count(sb);
+	ext4_msg(sb, KERN_ERR, "groups: ");
 	for (i = 0; i < ngroups; i++) {
 		struct ext4_group_info *grp = ext4_get_group_info(sb, i);
 		struct ext4_prealloc_space *pa;
@@ -4175,9 +4153,46 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 	}
 	printk(KERN_ERR "\n");
 }
+
+static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
+{
+	struct super_block *sb = ac->ac_sb;
+
+	if (!ext4_mballoc_debug ||
+	    (EXT4_SB(sb)->s_mount_flags & EXT4_MF_FS_ABORTED))
+		return;
+
+	ext4_msg(sb, KERN_ERR, "Can't allocate:"
+			" Allocation context details:");
+	ext4_msg(sb, KERN_ERR, "status %d flags %d",
+			ac->ac_status, ac->ac_flags);
+	ext4_msg(sb, KERN_ERR, "orig %lu/%lu/%lu@%lu, "
+			"goal %lu/%lu/%lu@%lu, "
+			"best %lu/%lu/%lu@%lu cr %d",
+			(unsigned long)ac->ac_o_ex.fe_group,
+			(unsigned long)ac->ac_o_ex.fe_start,
+			(unsigned long)ac->ac_o_ex.fe_len,
+			(unsigned long)ac->ac_o_ex.fe_logical,
+			(unsigned long)ac->ac_g_ex.fe_group,
+			(unsigned long)ac->ac_g_ex.fe_start,
+			(unsigned long)ac->ac_g_ex.fe_len,
+			(unsigned long)ac->ac_g_ex.fe_logical,
+			(unsigned long)ac->ac_b_ex.fe_group,
+			(unsigned long)ac->ac_b_ex.fe_start,
+			(unsigned long)ac->ac_b_ex.fe_len,
+			(unsigned long)ac->ac_b_ex.fe_logical,
+			(int)ac->ac_criteria);
+	ext4_msg(sb, KERN_ERR, "%d found", ac->ac_found);
+	ext4_mb_show_pa(sb);
+}
 #else
+static inline void ext4_mb_show_pa(struct super_block *sb)
+{
+	return;
+}
 static inline void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 {
+	ext4_mb_show_pa(ac->ac_sb);
 	return;
 }
 #endif
-- 
2.21.0


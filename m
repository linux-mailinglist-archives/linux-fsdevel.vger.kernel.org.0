Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBA11C0E0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 08:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbgEAGa1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 02:30:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53036 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728126AbgEAGa0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 02:30:26 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04162YT9078157;
        Fri, 1 May 2020 02:30:22 -0400
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30r7mc9gf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 02:30:22 -0400
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 0416BNE8029438;
        Fri, 1 May 2020 06:30:19 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma05fra.de.ibm.com with ESMTP id 30mcu53a8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 May 2020 06:30:19 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0416UHQ055705746
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 1 May 2020 06:30:17 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 02333A4062;
        Fri,  1 May 2020 06:30:17 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4D6F1A4064;
        Fri,  1 May 2020 06:30:15 +0000 (GMT)
Received: from localhost.localdomain.com (unknown [9.85.81.13])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri,  1 May 2020 06:30:15 +0000 (GMT)
From:   Ritesh Harjani <riteshh@linux.ibm.com>
To:     linux-ext4@vger.kernel.org
Cc:     "Paul E . McKenney" <paulmck@kernel.org>,
        linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.com>,
        tytso@mit.edu, "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Ritesh Harjani <riteshh@linux.ibm.com>
Subject: [RFC 04/20] ext4: mballoc: Refactor ext4_mb_show_ac()
Date:   Fri,  1 May 2020 11:59:46 +0530
Message-Id: <7cb8b137a930dd8794535e58ceff1873d4c98fa2.1588313626.git.riteshh@linux.ibm.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1588313626.git.riteshh@linux.ibm.com>
References: <cover.1588313626.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-01_01:2020-04-30,2020-05-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 mlxscore=0 phishscore=0 priorityscore=1501 clxscore=1015 mlxlogscore=999
 impostorscore=0 suspectscore=1 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005010040
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
index 478b33fb1183..d7ae5a092796 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4152,38 +4152,16 @@ void ext4_discard_preallocations(struct inode *inode)
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
@@ -4207,9 +4185,46 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
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


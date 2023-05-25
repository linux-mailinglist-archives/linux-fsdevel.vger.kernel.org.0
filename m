Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C85D0710B06
	for <lists+linux-fsdevel@lfdr.de>; Thu, 25 May 2023 13:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240966AbjEYLdl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 May 2023 07:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240755AbjEYLdc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 May 2023 07:33:32 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA2EE7;
        Thu, 25 May 2023 04:33:31 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34PBIHRa015124;
        Thu, 25 May 2023 11:33:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=OemCn1E4YGTfPcU/Xjj6Y9mi4ltTHwa0DIvygIQ2Nk4=;
 b=HpRXh+AdlDIQ/O5J/uYxEyAGVLUINtN3aGi+JBFcByvB/bfLq1EwE0MfCLFqrjdmfWef
 CC/XeJVkaL9A/PZOqzPsO0tHwASHSEa13WJu6ae8wQOkhSXcSapARuLuSw2UQR/6IfuB
 hlynS0GXg1+XJRCZ0MOS3XPUx3soMapQxQeyqu1dRqW79pGq8cz6/cdEt65CdKvW9FGq
 3HaJVMU7kAYLNzGW/b2GUpzwNlCf1vz/4+ouF+vfQzoaDO9dDvcXnDj9eNBkYhjrPBPe
 1JGVMksILmK31Hn11sgP6WzjcUyIeiBPv0IPXCFZHQfkgcIeqs8OQMLp5WCVgwsAu12y Sw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6p60bp0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:21 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34PBIePo016937;
        Thu, 25 May 2023 11:33:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qt6p60bks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34P0lCxF007529;
        Thu, 25 May 2023 11:33:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06ams.nl.ibm.com (PPS) with ESMTPS id 3qppc3jduu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 25 May 2023 11:33:17 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34PBXFvD17433178
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 May 2023 11:33:15 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5F9972004E;
        Thu, 25 May 2023 11:33:15 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 52F702004D;
        Thu, 25 May 2023 11:33:13 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Thu, 25 May 2023 11:33:13 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 02/13] ext4: mballoc: Remove useless setting of ac_criteria
Date:   Thu, 25 May 2023 17:02:56 +0530
Message-Id: <9190a546a98e053364583b499804472ec04d747b.1685009579.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685009579.git.ojaswin@linux.ibm.com>
References: <cover.1685009579.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DNLIjiq17q6H5-Gr97_jYi_OTLVFX2nb
X-Proofpoint-GUID: bwrCziY6CJnaqqmmkh1VlVvlIv_Au4Ji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-25_06,2023-05-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 spamscore=0 bulkscore=0 phishscore=0 impostorscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305250096
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>

There will be changes coming in future patches which will introduce a new
criteria for block allocation. This removes the useless setting of ac_criteria.
AFAIU, this might be only used to differentiate between whether a preallocated
blocks was allocated or was regular allocator called for allocating blocks.
Hence this also adds the debug prints to identify what type of block allocation
was done in ext4_mb_show_ac().

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 2e1a5f001883..288d504ee744 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4582,7 +4582,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 			atomic_inc(&tmp_pa->pa_count);
 			ext4_mb_use_inode_pa(ac, tmp_pa);
 			spin_unlock(&tmp_pa->pa_lock);
-			ac->ac_criteria = 10;
 			read_unlock(&ei->i_prealloc_lock);
 			return true;
 		}
@@ -4625,7 +4624,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	}
 	if (cpa) {
 		ext4_mb_use_group_pa(ac, cpa);
-		ac->ac_criteria = 20;
 		return true;
 	}
 	return false;
@@ -5407,6 +5405,10 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
 			(unsigned long)ac->ac_b_ex.fe_logical,
 			(int)ac->ac_criteria);
 	mb_debug(sb, "%u found", ac->ac_found);
+	mb_debug(sb, "used pa: %s, ", ac->ac_pa ? "yes" : "no");
+	if (ac->ac_pa)
+		mb_debug(sb, "pa_type %s\n", ac->ac_pa->pa_type == MB_GROUP_PA ?
+			 "group pa" : "inode pa");
 	ext4_mb_show_pa(sb);
 }
 #else
-- 
2.31.1


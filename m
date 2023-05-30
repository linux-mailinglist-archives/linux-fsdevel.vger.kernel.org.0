Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F169E715FE1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 May 2023 14:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjE3Mfw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 May 2023 08:35:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230051AbjE3Mft (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 May 2023 08:35:49 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DF7D1B3;
        Tue, 30 May 2023 05:35:21 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UCGrIh024240;
        Tue, 30 May 2023 12:34:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=KeZdso/T3NqzSn/aX/sedRkY9LS8b35yxKJ1/aKaO7c=;
 b=d8LNgo0jJlemTsq0bKy8sttBHRadqJNLMoYPknJDZqZ32H4enyhISi/5eDyfWlOCPgfE
 ehY5F8vUX762fDuoHl/cMPsG4XSJtP+KlAMETekO08+iMJ+LxYaWYY40SaQeY6or4L4P
 Nc1LdSqUzWkIkkm0/VUDeNjsjGkowQZr3Fk3x58BAcvzfP/y1LbamsTYYMpJlF5uT9N/
 qZf/yflmMBxCfu72k8MdRYFIUrcTCDXJmGYJtDpzJVn/1uoPbsf8EVoSWmboFXrh4w+J
 X+KmPW+wWSi56BrUNynx02IkMLPeGxdr3XZ3d0bC+zuhvj0mMa4W1mwlwi0q84AjIQB2 sQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwf7dkpqd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:03 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 34UBToAb022627;
        Tue, 30 May 2023 12:34:02 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3qwf7dkpp3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:02 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 34U2HD5v021187;
        Tue, 30 May 2023 12:34:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3qu9g59fdw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 12:34:00 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 34UCXvOM27394676
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 May 2023 12:33:58 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3EAE2004B;
        Tue, 30 May 2023 12:33:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C7D3920040;
        Tue, 30 May 2023 12:33:55 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.in.ibm.com (unknown [9.109.253.169])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Tue, 30 May 2023 12:33:55 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Kemeng Shi <shikemeng@huaweicloud.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v2 02/12] ext4: mballoc: Remove useless setting of ac_criteria
Date:   Tue, 30 May 2023 18:03:40 +0530
Message-Id: <1dbae05617519cb6202f1b299c9d1be3e7cda763.1685449706.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1685449706.git.ojaswin@linux.ibm.com>
References: <cover.1685449706.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: MTa8dPRfBiLZh3gKOz2Iv3owznizGACa
X-Proofpoint-ORIG-GUID: jMRzHQeAiZ1NGx3YvI3ZN6dHC3TRaCPD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_08,2023-05-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 mlxscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 bulkscore=0
 priorityscore=1501 spamscore=0 adultscore=0 mlxlogscore=999 phishscore=0
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
index 7ac6d3524f29..9d73f61458d4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4627,7 +4627,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 			atomic_inc(&tmp_pa->pa_count);
 			ext4_mb_use_inode_pa(ac, tmp_pa);
 			spin_unlock(&tmp_pa->pa_lock);
-			ac->ac_criteria = 10;
 			read_unlock(&ei->i_prealloc_lock);
 			return true;
 		}
@@ -4670,7 +4669,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	}
 	if (cpa) {
 		ext4_mb_use_group_pa(ac, cpa);
-		ac->ac_criteria = 20;
 		return true;
 	}
 	return false;
@@ -5444,6 +5442,10 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
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


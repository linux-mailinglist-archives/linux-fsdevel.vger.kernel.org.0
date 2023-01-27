Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1741667E56D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:38:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbjA0Mh6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233969AbjA0Mhz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:37:55 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB18F1115C;
        Fri, 27 Jan 2023 04:37:54 -0800 (PST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RBhKU6014035;
        Fri, 27 Jan 2023 12:37:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=XC6TK7Q+z3yL+r45529vOHcJKP/n9hfcP75Tz2gRgpk=;
 b=ewXOBydThx0lvrCuW4uVJIa9jiWL9qdWsvNAK19EiA6hJLUa/c7eQ4AL1rRkfs2fBM7I
 7asSrwuamJhs7JF78eeU59Cd88X4zWU8R5TNNp7+qmwn3GWefPuMtmBsakygVFWOwLVX
 +MNGF9tncQ87xQBBwBAqQ6couOGYQmG2P6KIPVzE7KR4YjTGOqxL6TdChVW3CtBNTYez
 5CUQVvx65VZFs68JhLs2JwapHPuqVsVheggjYlBP3rUqqBkxPGpP+i7Rg8uz0UC29Pb5
 JNGV+VPX46JX9FMZ1xwlQWuw5YZd5JXikSrBGrAkI3PCJNTZ0vxQvqX3MzXrBaupXssx 6w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncdyy19pa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:50 +0000
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RCSdag008886;
        Fri, 27 Jan 2023 12:37:50 GMT
Received: from ppma06fra.de.ibm.com (48.49.7a9f.ip4.static.sl-reverse.com [159.122.73.72])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncdyy19np-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:50 +0000
Received: from pps.filterd (ppma06fra.de.ibm.com [127.0.0.1])
        by ppma06fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30QJmSYv010363;
        Fri, 27 Jan 2023 12:37:48 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma06fra.de.ibm.com (PPS) with ESMTPS id 3n87afdemc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:37:48 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCbkR446465484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:37:46 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BC9C20040;
        Fri, 27 Jan 2023 12:37:46 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D6B8E2004B;
        Fri, 27 Jan 2023 12:37:43 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:37:43 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 01/11] ext4: mballoc: Remove useless setting of ac_criteria
Date:   Fri, 27 Jan 2023 18:07:28 +0530
Message-Id: <08aadf4fd475d87020c60792d81276a28d7176c1.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ClKmbQhYV6P6p80kykiv7mFx_RD2whrU
X-Proofpoint-GUID: RW1rbZrZaRzHGeAA51HRy_ns-UxN0rf2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 mlxlogscore=999 adultscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2212070000
 definitions=main-2301270113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

There will be changes coming in future patches which will introduce a new
criteria for block allocation. This removes the useless setting of ac_criteria.
AFAIU, this might be only used to differentiate between whether a preallocated
blocks was allocated or was regular allocator called for allocating blocks.
Hence this also adds the debug prints to identify what type of block allocation
was done in ext4_mb_show_ac().

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5b2ae37a8b80..572e79a698d4 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4391,7 +4391,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 			atomic_inc(&pa->pa_count);
 			ext4_mb_use_inode_pa(ac, pa);
 			spin_unlock(&pa->pa_lock);
-			ac->ac_criteria = 10;
 			rcu_read_unlock();
 			return true;
 		}
@@ -4434,7 +4433,6 @@ ext4_mb_use_preallocated(struct ext4_allocation_context *ac)
 	}
 	if (cpa) {
 		ext4_mb_use_group_pa(ac, cpa);
-		ac->ac_criteria = 20;
 		return true;
 	}
 	return false;
@@ -5131,6 +5129,10 @@ static void ext4_mb_show_ac(struct ext4_allocation_context *ac)
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


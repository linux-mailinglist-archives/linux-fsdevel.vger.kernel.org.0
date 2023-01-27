Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E4567E582
	for <lists+linux-fsdevel@lfdr.de>; Fri, 27 Jan 2023 13:39:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjA0MjB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 27 Jan 2023 07:39:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233929AbjA0Miw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 27 Jan 2023 07:38:52 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B278D4671C;
        Fri, 27 Jan 2023 04:38:08 -0800 (PST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30RBEO7T013729;
        Fri, 27 Jan 2023 12:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=bscJQYjzXho0Z4VD3EruBiAZYpwF3KYqE3WK1sXQOEw=;
 b=kS8OBGZEJzpPiqgYz5pkZCL5EHS+TIQZkCOZKrWMcnyM8S3Rak/eRRiRcDFvMiJZQdrx
 1XEs78OCkGPNunTKvc/P3GyfuvpjGw4NhLFZYyZTYVAqPJs8XtbdXiLRQqPF2dKUqRK4
 XU+299p4vOClIsHWRgvOc9omwQquynJ6YtfYfrf7OaKtFIXELYP4TUajJztxnYa26Q4o
 Ys6SlA27+w477qLhTcOyAXh0w37xMN5iipk9IUG3SersTVO+S9itRSOpQf+cp5dW9/Rz
 uXkoZbx5JKhvWd98pQ23FU8yARJq6mUKLawPqOAl7qKNSfZ6zOgLIWLpfhc8w1nY66A0 LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncdj7hx0t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:05 +0000
Received: from m0098416.ppops.net (m0098416.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 30RBOjIK021632;
        Fri, 27 Jan 2023 12:38:04 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com (PPS) with ESMTPS id 3ncdj7hx06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:04 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 30R7xVts019104;
        Fri, 27 Jan 2023 12:38:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma03ams.nl.ibm.com (PPS) with ESMTPS id 3n87p6qgt5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 Jan 2023 12:38:02 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 30RCc0Kv44040452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 27 Jan 2023 12:38:00 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E87B20043;
        Fri, 27 Jan 2023 12:38:00 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 837FA20040;
        Fri, 27 Jan 2023 12:37:58 +0000 (GMT)
Received: from li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com (unknown [9.43.40.88])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Fri, 27 Jan 2023 12:37:58 +0000 (GMT)
From:   Ojaswin Mujoo <ojaswin@linux.ibm.com>
To:     linux-ext4@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>, Ritesh Harjani <ritesh.list@gmail.com>
Subject: [RFC 07/11] ext4: Avoid scanning smaller extents in BG during CR1
Date:   Fri, 27 Jan 2023 18:07:34 +0530
Message-Id: <6fefb97af05081d344185334a36e90f093ccf310.1674822311.git.ojaswin@linux.ibm.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1674822311.git.ojaswin@linux.ibm.com>
References: <cover.1674822311.git.ojaswin@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oDJjUhbojVGgpx2vkGJFz0rNxZQRerh8
X-Proofpoint-ORIG-GUID: pcP1HcbRSyTPyMpjNCo62SJkP5I_C3n2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-27_06,2023-01-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 malwarescore=0 clxscore=1015 mlxlogscore=813
 priorityscore=1501 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301270113
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

When we are inside ext4_mb_complex_scan_group() in CR1, we can be sure
that this group has atleast 1 big enough continuous free extent to satisfy
our request because (free / fragments) > goal length.

Hence, instead of wasting time looping over smaller free extents, only
try to consider the free extent if we are sure that it has enough
continuous free space to satisfy goal length. This is particularly
useful when scanning highly fragmented BGs in CR1 as, without this
patch, the allocator might stop scanning early before reaching the big
enough free extent (due to ac_found > mb_max_to_scan) which causes us to
uncessarily trim the request.

Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/mballoc.c | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index c4ab8f412d32..14529d2fe65f 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -2279,7 +2279,7 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 	struct super_block *sb = ac->ac_sb;
 	void *bitmap = e4b->bd_bitmap;
 	struct ext4_free_extent ex;
-	int i;
+	int i, j, freelen;
 	int free;
 
 	free = e4b->bd_info->bb_free;
@@ -2306,6 +2306,23 @@ void ext4_mb_complex_scan_group(struct ext4_allocation_context *ac,
 			break;
 		}
 
+		if (ac->ac_criteria < CR2) {
+			/*
+			 * In CR1, we are sure that this group will
+			 * have a large enough continuous free extent, so skip
+			 * over the smaller free extents
+			 */
+			j = mb_find_next_bit(bitmap,
+						EXT4_CLUSTERS_PER_GROUP(sb), i);
+			freelen = j - i;
+
+			if (freelen < ac->ac_g_ex.fe_len) {
+				i = j;
+				free -= freelen;
+				continue;
+			}
+		}
+
 		mb_find_extent(e4b, i, ac->ac_g_ex.fe_len, &ex);
 		if (WARN_ON(ex.fe_len <= 0))
 			break;
-- 
2.31.1

